Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F5C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD7B26121
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="r8BVh9WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD7B26121
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934692AbeF0OIN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:08:13 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:53185 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932166AbeF0OIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:08:11 -0400
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com [209.85.217.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5RE82Yf005101;
        Wed, 27 Jun 2018 23:08:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5RE82Yf005101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530108484;
        bh=4tTQ/UAlhdq7BJOGvQ7ghf1e9mWu67LxJ92mf+RgWJM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=r8BVh9WEDX5bEYEPy+0py0XdtRLhyZRlFPR1087AQutTRj/uPqlU5hAgHNu7/SwDb
         ye8oroysgk7n5TeS/gghmKeeiO/SGHtwBLZFoEBpnOc/ClPgLcL5mmwuVEXLEEfSYq
         NmMYw3AtF+9Glbner/6rYiG7tkhdy9C19ubzanLqMCQI+mwVH7zSq8RYWrGHp7V7ap
         V6NA+/xLEWaNhRCIkiDJs4m8SMUH+5xvK2SuYakkAyt2Oov4M0kIfjOCIrO19uz7Py
         g3v9um6sgsZq3jPLX0pTyC/tQww7WcnMLwrMi2CpJg0h5UKi88zWXecsKc1SJPt4uT
         L7KF6PIwD7dNA==
X-Nifty-SrcIP: [209.85.217.174]
Received: by mail-ua0-f174.google.com with SMTP id r10-v6so1349287uao.1;
        Wed, 27 Jun 2018 07:08:03 -0700 (PDT)
X-Gm-Message-State: APt69E1GxRIR0ISY5+RCkkJcV3e5s8429tSJnqr5zsoEzahdtAgJ5ZF3
        tdrYldVhBOoLdirpCEuACV3jkETmPmopV9CZPX0=
X-Google-Smtp-Source: AAOMgpfxSXVMEQ60gH9rXOhQJqt/g8JnjbKnNNWVv6XNWxRnqTD8NiGxFJ0vSaFqxjXrqn9Ela2o8/0YIDSMshv525w=
X-Received: by 2002:ab0:5061:: with SMTP id z30-v6mr3831599uaz.82.1530108482484;
 Wed, 27 Jun 2018 07:08:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 07:07:21
 -0700 (PDT)
In-Reply-To: <20180627143705.5a1fed1c@kitsune.suse.cz>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Jun 2018 23:07:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
Message-ID: <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
Subject: Re: due to kconfig changes kernel config file is no longer sufficient
 for configuring the kernel
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>,
        Michal Kubecek <mkubecek@suse.cz>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Jeff Mahoney <jeffm@suse.com>,
        "Peter Zijlstra," <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-06-27 21:37 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
> Hello,
>
> in the x86 Kconfig we have this:
>
> # Select 32 or 64 bit
> config 64BIT
>         bool "64-bit kernel" if "$(ARCH)" =3D "x86"
>         default "$(ARCH)" !=3D "i386"
>         ---help---
>           Say yes to build a 64-bit kernel - formerly known as x86_64
>           Say no to build a 32-bit kernel - formerly known as i386
>
> Since commit 104daea149c4 ("kconfig: reference environment variables
> directly and remove 'option env=3D'") the value of ARCH is not saved in
> the kernel config.

I think this commit is unrelated.  It was just a syntax change.

Unless I am missing something,
we have never saved ARCH in the .config in the past.


> Since commit f467c5640c29 ("kconfig: only write '#
> CONFIG_FOO is not set' for visible symbols") the value of 64BIT is not
> saved if the ARCH is set i386 or x86_64 because the symbol is not
> visible.

This is correct.

It was discussed a few weeks ago.

https://lkml.org/lkml/2018/6/5/847


> There is a number of ways to hack this particular case to work.
>
> However, there is a more general problem with this. Some config options
> may depend on the environment, may not be saved, and the environment is
> not saved either.

Which environment variables in particular are in your mind?

As for ARCH, you need to pass the same ARCH as you used for building the ke=
rnel.
(For native building, you do not have to pass ARCH explicitly, though.)

As for CC, HOSTCC, etc.
yes, these are new 'unsaved' environments.

CONFIG options now depend on the compiler.
This is the concept suggested by Linus Torvalds.


> So in the end all the infrastructure with symlinks
> from module directory pointing to the kernel source and object
> directory is useless. To interpret the config stored there you need the
> environment and that is not saved anywhere. So if you try to build
> out-of-tree module it might end up reconfiguring your kernel and
> producing useless modules.

No. out-of-tree module building never ever re-configures the kernel.

out-of-tree modules are built with exactly the same configuration
as used for the kernel.


There is one more assumption here.

Greg-KH said:
  We don't ever support the system of loading a module built with anything
  other than the _exact_ same compiler than the kernel was.

(https://lkml.org/lkml/2017/10/4/496)



Based on that statement,
CONFIG options depending on 'CC' are valid for out-of-tree modules as well.




> Is there any plan to fix this?
>
> Thanks
>
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards
Masahiro Yamada
