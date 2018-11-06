Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14082C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C3A20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeIzkEbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C3A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbeKGAiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:38:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52039 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbeKGAiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:38:16 -0500
Received: by mail-it1-f194.google.com with SMTP id h13so18293257itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s94cYqaaFFfBnXRtY031JH5D4ASSC/WcmOvmo6Jeb5o=;
        b=aeIzkEbVb/pvPfegE44bxzQn2a0R0dQVzY+vmokgwijDURhvHFIVPfNYrSDKnISOad
         IeE8zE0fErnsi60MjDWy9k5HDwQDp0Yy7+ZsoK134l1T/aiTRHzWK7Uow+baRbpU4ezZ
         dQwUxKDvt5YRv9vaPSYWZMtJ4QqVc31N30LbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s94cYqaaFFfBnXRtY031JH5D4ASSC/WcmOvmo6Jeb5o=;
        b=laFwuoGXslOU683YOb0o2FXG3b/GGwy5kP+9f8mvr5Vcw57SFnOcXsw1d/T+ni6zJI
         eLVbn+TGR5qBIhOlsrqN80ji9TRW/kFD8yycjFn2GkMZ9VnAKJyT2RunuHiy2/VcDOV0
         8Hl2YusYlLGHP4i8PBoAQVaI9cdYkj/x96FhTFS+fEtMFHDGwnU+AtPJTW2eSBk8nv5I
         2w9C3C924J65RGBt92tdY38WTPwJKSEsJUQV3OnYSrU6aoMuuo56+3ZgsOHr+OQU49XL
         vab9jNrWvHbxXlMWBDXXuByyqVou+0lS51Y8lzcit2G+y9eKi0VGNqXO9CzCzP/szhAd
         xJFQ==
X-Gm-Message-State: AGRZ1gIyRj0mqOrFFtn32GzGpzsx3p3eq1+xmPFXPlHpShfkCaRZBzkL
        FlSrSa/vvDeosfj/QqJCrxnfdC1R1cLumppCWO3SDA==
X-Google-Smtp-Source: AJdET5c6rycmWGu4Q3jfSeRjxX3BLEY9NM0jxYqZXJvPSrP+7sZ9OTZfv8P+Bhx2S40TuPXR/MiVBIqWsrSkou4Go+Y=
X-Received: by 2002:a24:430e:: with SMTP id s14-v6mr2239742itb.83.1541517155139;
 Tue, 06 Nov 2018 07:12:35 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
 <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com>
In-Reply-To: <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 6 Nov 2018 20:42:24 +0530
Message-ID: <CALxhOnhN=erC=KpE55PHPx9u45QiAU+yxhGHZXGJ_7pV0a_=NQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>,
        linux-xtensa@linux-xtensa.org,
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

On Tue, 6 Nov 2018 at 19:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 5, 2018 at 10:44 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> > On Thu, Nov 1, 2018 at 6:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > index 82c75643..b35d2e6 100644
> > > --- a/arch/xtensa/include/asm/Kbuild
> > > +++ b/arch/xtensa/include/asm/Kbuild
> > > @@ -28,3 +28,4 @@ generic-y += topology.h
> > >  generic-y += trace_clock.h
> > >  generic-y += word-at-a-time.h
> > >  generic-y += xor.h
> > > +generic-y += syscall_table.h
> >
> > This doesn't look right: syscall_table.h is not asm-generic header.
> >
> > > diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> > > index 837d4dd..f826d52 100644
> > > --- a/arch/xtensa/include/uapi/asm/Kbuild
> > > +++ b/arch/xtensa/include/uapi/asm/Kbuild
> > > @@ -11,3 +11,4 @@ generic-y += resource.h
> > >  generic-y += siginfo.h
> > >  generic-y += statfs.h
> > >  generic-y += termios.h
> > > +generic-y += unistd_32.h
> >
> > Ditto: unistd32_.h is not asm-generic header.
>
> I think the correct syntax here would be
>
> generated-y += unistd_32.h
>
> Firoz, if I remember correctly, this came up before, maybe you just did
> not update all architectures together?

My initial patches does have generated-y += unistd_32.h instead of
generic-y += unistd_32.h.
If I remember someone pointed out that this implementation doesn't
look good. So I
replaced to generic-y += unistd_32.h.

Sure, I'll change to generated-y += unistd_32.h instead of generic-y
+= unistd_32.h.

Max, this looks ok. right?

Thanks
Firoz


>
>         Arnd
