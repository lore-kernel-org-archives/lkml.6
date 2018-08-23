Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC1DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9592E2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPt/lg+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9592E2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHWWB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:01:59 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34708 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHWWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:01:59 -0400
Received: by mail-yw1-f65.google.com with SMTP id y134-v6so2336095ywg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7oRLMpHWCmGcE25vUXt/LkN9qeQ+aQ7Zx4/hNEPeHPM=;
        b=WPt/lg+G84ak973HnATX/5k4Q3lQwRWb3YtnXZa+2VihD8mXOt5Tx5Q3hGI0nkzeJZ
         lWwLCsmHFflB4W/LYOn5itJLQFOoL/8y5F7u2WzSJt+k4WAZpMp3dvIhkOqLRXh7P3QU
         LGWcrBcMAEg1OyyfNudHAi6nZ5gM/Of4vC5ppQwk1G39G3Q4WdY/mr2/Yf6R5HIJFAkf
         uruUCuqGxal/BBGlRIH8h9E9lZwzCcyUTCKsWbjcl0cMhCxoHs/AhAlXVRI/R8d4Zfe7
         dR+23IbwzgHVbpaN3nXMIQs6XsxcPA7vc2DcO3594NBGfnVXnZ1VtLi4q6ZREVmb29cA
         jAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7oRLMpHWCmGcE25vUXt/LkN9qeQ+aQ7Zx4/hNEPeHPM=;
        b=f90XoOsICZX8VTxCXzYjQcQBJwnRMJvrGCcsOQZ5HJRqfBH+SFO41HyuioUvXGlSaB
         6XUyYqyhtGqcvL55nVcpyaSMTMqwcbHYUmNp2YYBKCEcBxheZDe2HAld8pVnBreFm4ES
         9uF/89VKXdlmbKvbqCPQchGAgnOYMGH99DqvK7v9taroGHPPss6DLS4Lvk/R+f4r8aa3
         wUXoYtDET5cKxjss/cJxLJB5wsMZRd6BZVefXqohrk/BNmdkJGxtRDqozKVc10rt+zMQ
         Wve8+GZv14VRujJJVCOcKv93b7mcrtRjDM8SLveK2FdY6EM7DJhs0OEYlsslnxsLJsVb
         ptHw==
X-Gm-Message-State: APzg51ClmtN8IyiWM2A0KL4VuU4b5diJm6iTZmR/ew13EYl9kgAahq7N
        mNtTRVoYiVWGBB211NQSvh/MOTMuMiiqZUcIKUg=
X-Google-Smtp-Source: ANB0VdadEXgCiZeBAEgcEKdi12VmbFqK2vaCQmlI2Efs2p6T9NOcnp/IWSumhrB+pF+pCy2NAC0gij9oFiTp4rpKPbM=
X-Received: by 2002:a81:b1c6:: with SMTP id p189-v6mr3619331ywh.496.1535049062438;
 Thu, 23 Aug 2018 11:31:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5457:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 11:31:02
 -0700 (PDT)
In-Reply-To: <20180823152143.GA3049@infradead.org>
References: <20180822185034.30167-1-jcmvbkbc@gmail.com> <20180823152143.GA3049@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 23 Aug 2018 11:31:02 -0700
Message-ID: <CAMo8BfL7WpM-o=Hp-sNRiG4ANFA9cSoTrKTRZYjeecNa+b3dFQ@mail.gmail.com>
Subject: Re: [PULL 00/14] Xtensa updates for 4.19
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 8:21 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>       xtensa: platform-specific handling of coherent memory
>
> How is this supposed to be used?  For the nommu version there only
> are __weak stubs, but no actual implementation.

The idea is that nommu xtensa platforms that have two views of the
physical memory may map one of them as cached and the other as
uncached. They will provide implementations for these four functions.

A platform with single view of the physical memory but with CPU that
has region translation still may create two views of the memory.

Both situations are platform-specific as we don't have fixed address
space layout for nommu systems.

I had an example here, but the addresses in this example are incorrect
as I misread the spec, so I didn't add it to the PR:
https://github.com/jcmvbkbc/linux-xtensa/commit/21ec04090f59647e69fb775ae9d447fcc778701e

-- 
Thanks.
-- Max
