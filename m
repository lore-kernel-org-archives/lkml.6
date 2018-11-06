Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89666C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5730C20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5730C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbeKFXAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:00:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38355 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeKFXAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:00:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so2545464qtl.5;
        Tue, 06 Nov 2018 05:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kASLEA4PMU0uaNmLTB6/W+v596gOmzQzaGwu/NafnKc=;
        b=Am2yShR6TnqptDLaj+kvSbBrE4KQFAx6skMQPfxcyoUitzO7xRWUcOCI8FmxWcQZBL
         3ElJSgY0CWWrQu6v2PPL32yvDcmArvFsvM2NmCCfPI1ZHTaNHXm61XrfNvhpWrZEWMI3
         /Pli9f7+Cac2kGJaAsasfD81J6wNxG6mroVEb84YAkzoDpFdyCWtZxZS/Tt9n3Jxlxv9
         Z9B824BKpDSJTizDEd2E7ADsdZCltO63yIaJoJdmgpfdhAYt4gD8Nj/xWDdwj+olVpzJ
         pTdgp9GbcOJwGkeMLjneWGXBVWP1Z2KB0L3R2Xkx5LPjdlv/FPpz4Vc5tGTCtn5PGlLd
         R2zw==
X-Gm-Message-State: AGRZ1gKpJvJLdO3ng1bMV67AunpFD/oA7OqzUZSSnP6RXRlBC7UiQzA9
        F+PmQFppXSNdGqQpaY1UQ662GMLj2nMFSEybEnEKsDOQ
X-Google-Smtp-Source: AJdET5czWfXBRQUcdhZFDI0paQmVegCxr2qL3754fMhWSJYIPSrhBlsEfz9PC0e/AwiVR+ei61Zfb1sx3jBfl1yHfM8=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr24908868qtl.343.1541511287677;
 Tue, 06 Nov 2018 05:34:47 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
In-Reply-To: <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Nov 2018 14:34:31 +0100
Message-ID: <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 10:44 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Thu, Nov 1, 2018 at 6:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > index 82c75643..b35d2e6 100644
> > --- a/arch/xtensa/include/asm/Kbuild
> > +++ b/arch/xtensa/include/asm/Kbuild
> > @@ -28,3 +28,4 @@ generic-y += topology.h
> >  generic-y += trace_clock.h
> >  generic-y += word-at-a-time.h
> >  generic-y += xor.h
> > +generic-y += syscall_table.h
>
> This doesn't look right: syscall_table.h is not asm-generic header.
>
> > diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> > index 837d4dd..f826d52 100644
> > --- a/arch/xtensa/include/uapi/asm/Kbuild
> > +++ b/arch/xtensa/include/uapi/asm/Kbuild
> > @@ -11,3 +11,4 @@ generic-y += resource.h
> >  generic-y += siginfo.h
> >  generic-y += statfs.h
> >  generic-y += termios.h
> > +generic-y += unistd_32.h
>
> Ditto: unistd32_.h is not asm-generic header.

I think the correct syntax here would be

generated-y += unistd_32.h

Firoz, if I remember correctly, this came up before, maybe you just did
not update all architectures together?

        Arnd
