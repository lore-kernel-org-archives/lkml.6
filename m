Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E710C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E4D208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSTfmTrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E4D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeHIWwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:52:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35657 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHIWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:52:20 -0400
Received: by mail-yw1-f65.google.com with SMTP id s68-v6so6421325ywg.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cw+dhAfJJfgfs9i1nvHZEtgRosdRSztWhtve09NFE9U=;
        b=lSTfmTrhoMButeCCWT5kPXrVjyDpWnaiUTQcaf/T8FlzkVBALu1Be20w/qApXRYOt/
         6HyPqLiDcFys3h6fZH57WoDZSfs8yz6Tt+x1CuG96w4Na9cZjlY7VxRfj+hP78j2E6NN
         KBAWD1SmjFFNVhR/bMkzckxzaPc2h80ZHyWOkR8dy20ddfEx7Ys952xg3+AUCUMlZEFK
         40F18OBDynrpJY/Hf9CY5Jb/o/z+9HQzt9ax1OHHsB96BV3QxfHRndQ97tJgAKsQ6BOB
         hSBaPVD3ISKH/AfXRo2w0OAm+x8qUjoV9gBy4x0hzFE5o5i/nxUpCi+zPDqRKd1U8BUf
         DiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cw+dhAfJJfgfs9i1nvHZEtgRosdRSztWhtve09NFE9U=;
        b=qXshJJcrnabDexv2N89g1CLrFF8wVWlgh8bATl5bsdwshjt/gVYuhK/ZxtKpKCjizn
         7bqZr/UbUeX5ISZqfLmSzsgRKY1m5Nhn9lTw6CtDeYxp3zTYMtV2+/abADviBQPzZZUC
         iDyh/YpkPF2W403hSgBib+hTlmqlKEqAdLjgL8VD/1BWpA+UxH68QxaAaw0ybHPaqaWm
         AjPH9JYdFrIrW0et4Z6rUO7ShzcYjByfHFSEM2DOgO1bCNQ89bDG3/cqIEW6oPCELJ4x
         tcV00St/zNI1KHLs9sM9NBWnlqdxhBehSdJZ2IKNKJtMakDk8pshwnPYG06vB/hb1CSb
         8gpA==
X-Gm-Message-State: AOUpUlFueaxKQS+WHjUxClwzQkc/81x/d5J/7jSrl/Fc9BspMKWWo1Uv
        26GgIV/gcIWZ/2hPOZEU3hfX8C0aPHKZC+jh+IU=
X-Google-Smtp-Source: AA+uWPyVM8hVhQt0fPY0X4EhslDJcQEepVhqVgeyW8Pd79u4yv0JMUI4uL+utKBLjtHJtvr3/G0mflN3ZkO6jkUWYxU=
X-Received: by 2002:a81:8742:: with SMTP id x63-v6mr2002638ywf.129.1533846352218;
 Thu, 09 Aug 2018 13:25:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d44:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 13:25:51 -0700 (PDT)
In-Reply-To: <20180809201554.168804-2-namit@vmware.com>
References: <20180809201554.168804-1-namit@vmware.com> <20180809201554.168804-2-namit@vmware.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 9 Aug 2018 13:25:51 -0700
Message-ID: <CAMo8BfJzh20K_1RZCDX+ygFVdZx2T_VeB8AQAB87EFKbq9sr+w@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] xtensa: defining LINKER_SCRIPT for the linker script
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 1:15 PM, Nadav Amit <namit@vmware.com> wrote:
> Defining the LINKER_SCRIPT when building the linker script as being done
> in other architectures. This is required for the next Makefile changes
> would otherwise break things.
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/xtensa/kernel/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
