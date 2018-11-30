Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D77C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C952146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVBoaMXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C952146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeK3PyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:54:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33401 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeK3PyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:54:02 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so1040553itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 20:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIAI16RWvHVDoEJapc7NJY6TWPbkzlrPdpU8HIv23OQ=;
        b=PVBoaMXeooyrt/QXhiKwRFgimq0aYvgyk25mjWBUmTWtrB8pIJbJRt1F56iDQKqCIe
         gCSOYC+1gPStIrQfA/HU+crBH/esa/aHFCRerLbkA9RTaeUE8v339AhZPVEMjfNaDpUh
         2FXviQXfDKkkNPPkSObTBy07Vlc3qSWBpvfA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIAI16RWvHVDoEJapc7NJY6TWPbkzlrPdpU8HIv23OQ=;
        b=X1Q7iu9Su1dB0iw9H46oadBi8KUTJpJgdS52xRjZutsMZu0c3kAjSziloV/6W6fCW3
         Fq/VzDoMoaCN9WenZNkGCCuFIb8e8BWNVZ0dNS5VvGt9Mf3FTsy5Y1y3rA6jdiO7Eqcs
         wro/xUzi95aSjMaJUqlg5zqQuTx1cR4htvBKTYuL3nwjKe6fWFdSxoqxPOCL+Q5rB9xh
         K/5bZbMgayZnnC80Iy9TeiMi1aYMpYk3OwP/4zZHebCwiE7aeeF0Tbnj0K7CXyOvZAof
         08XOrXp6wYf+Lc66eHxjAegynWVdljdSDe9LHqJWNcN5utgBXNQl/ieeZbndL1CcJ2Rd
         mPmQ==
X-Gm-Message-State: AA+aEWZkBvR+rOetlziiCBDJydYRPgJUFpj8bgG9VwuuYxQg2m4CExOh
        mt9imDx1rZT7lGICPHhNUMIS1CGbrMarhAIXRRsjLw==
X-Google-Smtp-Source: AFSGD/Vz57qCVZYwJC/LBMmIhh5dfqpZAJ63RO9enhbURgbxnkH5QDt7JL0BQu9Z26eYRyJv0Nhyb2Qttoljd1gO6zE=
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr3941657ita.65.1543553160332;
 Thu, 29 Nov 2018 20:46:00 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <1543481016-18500-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a1Pq=Y83p-cN9bf+m-2ZAmJdEYRaAY9FfEkVHvfSwNWNg@mail.gmail.com>
In-Reply-To: <CAK8P3a1Pq=Y83p-cN9bf+m-2ZAmJdEYRaAY9FfEkVHvfSwNWNg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 30 Nov 2018 10:15:48 +0530
Message-ID: <CALxhOniC95bKe5vLvNFdjwrzLa+mWw6hMvzESXG3MkUfVsrOzA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mips: add __NR_syscalls along with __NR_Linux_syscalls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your email.

On Thu, 29 Nov 2018 at 19:41, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> >  arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
> > index f25dd1d..6914be5 100644
> > --- a/arch/mips/include/uapi/asm/unistd.h
> > +++ b/arch/mips/include/uapi/asm/unistd.h
> > @@ -391,11 +391,14 @@
> >  #define __NR_rseq                      (__NR_Linux + 367)
> >  #define __NR_io_pgetevents             (__NR_Linux + 368)
> >
> > +#ifdef __KERNEL__
> > +#define __NR_syscalls                  368
> > +#endif
> >
> >  /*
> >   * Offset of the last Linux o32 flavoured syscall
> >   */
> > -#define __NR_Linux_syscalls            368
> > +#define __NR_Linux_syscalls            __NR_syscalls
>
> This seems odd: you define __NR_Linux_syscalls outside of
> #ifdef __KERNEL__, but the definition only works
> with __NR_syscalls being defined first, which it isn't in
> user space.
>
> Since the macros are completely unused as well as unusable
> now, how about removing them together with the other
> ones removed in patch 2?

Yes, good point, will update asap.

Firoz

>
>       Arnd
