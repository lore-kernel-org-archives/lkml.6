Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C268C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1B82146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RseZA7eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1B82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeKTRJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:09:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56264 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbeKTRJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:09:50 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so1818140itg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 22:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLe0vHfmoqtCyZ5txdsfsOS6gzKRYIMzVK3kdH4JNM0=;
        b=RseZA7eGWURaXAjaCT4AaNorCFWlXXzdhDxROWqiMEiWFevE+dzqQr4Vji0hORKE0l
         eK8C65QsQ9HUAgZAh/7T1J/4RBBUPqTmRRe22wfuG77i8TCWicVSOP5vSeg+5RdL+oQk
         Bt2dgclJQVVcHwr67ThCNSQZGjo3xxwCQvhTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLe0vHfmoqtCyZ5txdsfsOS6gzKRYIMzVK3kdH4JNM0=;
        b=MSecCyL1tJ/WS5HG/G4s+GqXQJXtGsnyVOTdgCcVTrUsskKfKvxrLjMX01f7QJTM5d
         35I9qz8O5qjeE2W7ThC7mAy6X1Ns8HSdk/SfjrT0BRLucGrv6UjE97h3G06JpMjNeXsz
         HiqrVhlz1atnvON8bnXkU3SQkEbKF+aeGymyry2z5Jl4hVHBvK7Uj/GnNjobSqpY4kW9
         zEWf6J7XetzzCq7eFmDhvB8noV9u1bCgq+yHZ1NciZtGhjm7S6Pt2dWW4U/+N81yKInH
         fP6HEpJJvSDMH1OH/bn7ElkOR6bkxUkb/aZlUhLL1L7Q5qUAgLXyp67nLmIHW6QkbCKt
         eUMQ==
X-Gm-Message-State: AGRZ1gKdVilScwbTqffS+45AE2i10UyqysxzrJYzR6d+SrjM8jgAlwv1
        Nvd6xAOVDfYbWj9wpFYKPxHuYKgsxJhCQmyRm+ASFA==
X-Google-Smtp-Source: AFSGD/WF5K019AquhpgFZx0uzEObS93WLZOx/sCvBYzy50dYyzknznRHhld9i4tNdmj9ddDmKvXRfStXtpXuNBUi0Oo=
X-Received: by 2002:a05:660c:a1a:: with SMTP id e26mr1097947itk.83.1542696140027;
 Mon, 19 Nov 2018 22:42:20 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a2CuryCoZKaOXz=nH_WTAZ7VneNoUYHkKFDLQNQvrkWUg@mail.gmail.com>
In-Reply-To: <CAK8P3a2CuryCoZKaOXz=nH_WTAZ7VneNoUYHkKFDLQNQvrkWUg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 20 Nov 2018 12:12:08 +0530
Message-ID: <CALxhOnjrXLjWNqrAtChw+k5vv5iu39wqAJNqJ9xDdzdv=xihhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mips: add __NR_syscalls along with __NR_Linux_syscalls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
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

On Mon, 19 Nov 2018 at 21:22, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 15, 2018 at 7:14 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd.h along
> > with __NR_Linux_syscalls. The macro __NR_syscalls also
> > added for making the name convention same across all
> > architecture. While __NR_syscalls isn't strictly part of
> > the uapi, having it as part of the generated header to
> > simplifies the implementation. We also need to enclose
> > this macro with #ifdef __KERNEL__ to avoid side effects.
>
> I fear this doesn't work the way you hoped:
>
> > --- a/arch/mips/include/uapi/asm/unistd.h
> > +++ b/arch/mips/include/uapi/asm/unistd.h
> > @@ -391,16 +391,19 @@
> >  #define __NR_rseq                      (__NR_Linux + 367)
> >  #define __NR_io_pgetevents             (__NR_Linux + 368)
> >
> > +#ifdef __KERNEL__
> > +#define __NR_syscalls                  368
> > +#endif
>
> We now have three different definitions of __NR_syscalls,
> one for each ABI. User space previously saw the correct
> one (now it doesn't see any, but that's ok).
>
> >  /*
> >   * Offset of the last Linux o32 flavoured syscall
> >   */
> > -#define __NR_Linux_syscalls            368
> > +#define __NR_Linux_syscalls            __NR_syscalls
>
> so this part part again is ok.
>
> >  #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
> >
> >  #define __NR_O32_Linux                 4000
> > -#define __NR_O32_Linux_syscalls                368
> > +#define __NR_O32_Linux_syscalls                __NR_syscalls
>
> but this part is not: Now __NR_O32_Linux_syscalls is defined
> to __NR_syscalls, which may be one of the three values.
> Any usage of __NR_O32_Linux_syscalls in a 64-bit kernel
> is then clearly wrong.
>
> >  #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
> >
> >  #define __NR_N32_Linux                 6000
> > -#define __NR_N32_Linux_syscalls                332
> > +#define __NR_N32_Linux_syscalls                __NR_syscalls
>
> Same for this one.

Thanks for the feedback. Will address all the comments.

Firoz

>
>        Arnd
