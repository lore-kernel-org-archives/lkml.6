Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD77C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A3B2159F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YjxbHsao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A3B2159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbeHBXpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:45:39 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:45879 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732585AbeHBXpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:45:39 -0400
Received: by mail-io0-f178.google.com with SMTP id k16-v6so3324964iom.12;
        Thu, 02 Aug 2018 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0zflNNvagRZKAv4tuyRdjDuCX6qMLrwNkukKt1XHrQ=;
        b=YjxbHsaohnUgvtDAy2IwtSL52QGLsI8HWdBKZdZxuLQk24viw1Zok1TDH7KMlZyOp4
         /WDlSBigShCh6xiHQCvSmEFuTJRajYNyYBS5uiW3lBXZH0/zLoaVyO/cZ1KAYEQNl2W0
         BDOosiqhDnSjpjX4n1V458/rjkUP02pXySm6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0zflNNvagRZKAv4tuyRdjDuCX6qMLrwNkukKt1XHrQ=;
        b=KziwDdfYvgIp8XaxaxHwb2u0v8zD+zP/FSMwjAqSiGNv78PSXW+2yzJz/8ZHz6nflU
         YIBOEoRwSsdbu5HbFBQTAIU3pw/PQ7hCLJP3Fc3g2ysUBbA6CnbBplEhsnCNT9pqETKj
         qwVMNZCjKdlv6Kpw36JX6Dv9qTqVjDNv88Um+rNYpTrJ64MVA1TWb1dGLWZR/Q7JvdDq
         CkEJW7NMFT079iyvvywZcBk1WRQP8lXdNSw3hfvf7rogbxL/kel2Xnf8YmFlXXrCmGiZ
         s6EODwiXYzdDR5lHCeeRRLNdTu60iRo0LZkUatGh4bwDFyMOBngNn1YEWlknvaWqrJTP
         IARg==
X-Gm-Message-State: AOUpUlH8l04cQ29PZlNzkKgLa8ICP1HAhGOr896tRfJko+EqBWhLu4T8
        XAgU09Khng5Hb92kg46WR1U1MDYwOE9slmw5/fy7aQ==
X-Google-Smtp-Source: AA+uWPyxbo4etvVF7iSSf/RHYdN2jK6tNiqIVKYkJSKB8Pz3j6waHDIJ3FiKj3Hqjl4x3UcGYG1+oV2CLKzr16nYYyg=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr4200167iom.238.1533246755453;
 Thu, 02 Aug 2018 14:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru> <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
In-Reply-To: <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Aug 2018 14:52:24 -0700
Message-ID: <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     wgh@torlan.ru
Cc:     Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 2:39 PM WGH <wgh@torlan.ru> wrote:
>
> I've just found one public report of this bug, though:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900442

Yeah, it does sound like we should fix this issue.

Ilya?

             Linus
