Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D131FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A982720893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GQMb/JVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A982720893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeG3Jha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:37:30 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25003 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeG3Jha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:37:30 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w6U83N65023551;
        Mon, 30 Jul 2018 17:03:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w6U83N65023551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532937804;
        bh=dbAUsu1aH6+Dmz7kJv02NWlAQ/5kio6ISMBkrnxQafc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GQMb/JVPIeyf/NpS3svqoqfmLhPyqShRKy0+LtTg3e07KaRbNs0anDH2mUjxhodjC
         jPscf+c22gSRXWvMgkjtgaMcHYe4NrRVb6PxVP5KRpyprJkIWO124llyWzN/Fj5Pwa
         PWt4Ho3jPdUHzKs5PQl94QLfHoL67V+wUhYSJVKR0sO2XNW0ldws0pKGmdDqHEtM0a
         HJEL6KqtfIPhb1HmtRV9WqfgTpl5HoveHy6BCjYvuIk3myIHcTHxr3ZhgfiyguofG5
         tpquYSo7ZH41KKMLLxnv5Y3Aj2LUtZx+Kyo2+eNfSNUobPCx4TLR4mh0h9Zscti7+I
         UJXlq5Um63mMw==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id q12-v6so7244200ual.2;
        Mon, 30 Jul 2018 01:03:24 -0700 (PDT)
X-Gm-Message-State: AOUpUlHlSJYFrRJrRyPABPffhXQNIax8depKTnP6MT6hJGekMBe6jHY0
        95JrI9TEH6bXnTk3OYFkGzKbaXckb6JHo3CJyoo=
X-Google-Smtp-Source: AAOMgpfHeyYO/NebRSoMytAGk9GDcZaBgVm2ojvmmO2CRk8ouvi0qVBUEy5sdr/ifVRlkMx1rHqihnSzlLkFV5mGZns=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr11258021uaf.199.1532937802871;
 Mon, 30 Jul 2018 01:03:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 01:02:42
 -0700 (PDT)
In-Reply-To: <20180628111623.3807fe9b@naga.suse.cz>
References: <20180627143705.5a1fed1c@kitsune.suse.cz> <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
 <20180628111623.3807fe9b@naga.suse.cz>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 30 Jul 2018 17:02:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
Message-ID: <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
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

2018-06-28 18:16 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
> On Wed, 27 Jun 2018 23:07:21 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> Hi.
>>
>>
>> 2018-06-27 21:37 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
>> > Hello,
>> >
>> > in the x86 Kconfig we have this:
>> >
>> > # Select 32 or 64 bit
>> > config 64BIT
>> >         bool "64-bit kernel" if "$(ARCH)" =3D "x86"
>> >         default "$(ARCH)" !=3D "i386"
>> >         ---help---
>> >           Say yes to build a 64-bit kernel - formerly known as
>> > x86_64 Say no to build a 32-bit kernel - formerly known as i386
>> >
>> > Since commit 104daea149c4 ("kconfig: reference environment variables
>> > directly and remove 'option env=3D'") the value of ARCH is not saved
>> > in the kernel config.
>>
>> I think this commit is unrelated.  It was just a syntax change.
>
> This does not look like syntax only change to me:
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 15aae32e0719..1217fc62ca61 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1,20 +1,12 @@
> -config ARCH
> -       string
> -       option env=3D"ARCH"
> -
> -config KERNELVERSION
> -       string
> -       option env=3D"KERNELVERSION"
> -

This is just syntax change.

'option env=3D' was used to reference an environment variable.

Now, $(ARCH), $(KERNELVERSION) are simpler forms.


>>
>> Unless I am missing something,
>> we have never saved ARCH in the .config in the past.
>
> There was a config symbol defined for it before the commit removed it.

No.

CONFIG symbols with'option env=3D'
are not written out to the .config file.

We have never had CONFIG_ARCH or CONFIG_KERNELVERSION.




>>
>>
>> > Since commit f467c5640c29 ("kconfig: only write '#
>> > CONFIG_FOO is not set' for visible symbols") the value of 64BIT is
>> > not saved if the ARCH is set i386 or x86_64 because the symbol is
>> > not visible.
>>
>> This is correct.
>>
>> It was discussed a few weeks ago.
>>
>> https://lkml.org/lkml/2018/6/5/847
>>
>>
>> > There is a number of ways to hack this particular case to work.
>> >
>> > However, there is a more general problem with this. Some config
>> > options may depend on the environment, may not be saved, and the
>> > environment is not saved either.
>>
>> Which environment variables in particular are in your mind?
>
> Any that is used in Kconfig.

They are provided from outside of Kconfig.
This is the behavior we keep since a long time ago.

ARCH is given by the environment variable or the command line.
KERNELVERSION is supplied by the top Makefile.




>>
>> As for ARCH, you need to pass the same ARCH as you used for building
>> the kernel. (For native building, you do not have to pass ARCH
>> explicitly, though.)
>
> Except if you do pass it to make config you may need to pass it to to
> make later as well.

Right.

For exmaple 'make ARCH=3Darm config' will create the config suitable
only for ARM architecture.
Then, you need to do 'make ARCH=3Darm' to build the kernel.

If it is tedious to give 'ARCH=3Darm' to every make command,
you can do 'export ARCH=3Darm' in your shell.

Again, this is the behavior we have for a long time.



>>
>> As for CC, HOSTCC, etc.
>> yes, these are new 'unsaved' environments.
>>
>> CONFIG options now depend on the compiler.
>> This is the concept suggested by Linus Torvalds.
>>
>>
>> > So in the end all the infrastructure with symlinks
>> > from module directory pointing to the kernel source and object
>> > directory is useless. To interpret the config stored there you need
>> > the environment and that is not saved anywhere. So if you try to
>> > build out-of-tree module it might end up reconfiguring your kernel
>> > and producing useless modules.
>>
>> No. out-of-tree module building never ever re-configures the kernel.
>
> It does implicitly because the config values depend on environment that
> is not saved and the values themselves are not saved either. If that
> happens to expose a new variable it is even explicitly reconfigured.


You should have a built kernel tree
before building external modules.

The .config is already there.

The .config works for external modules, given that

  - ARCH is the same
  - the compiler is the same



>>
>> out-of-tree modules are built with exactly the same configuration
>> as used for the kernel.
>
> It is not true. And that is the problem. You need the config file and
> dump of the environment passed to the make command at configuration
> time to get the exact same configuration. The environment is not saved
> anywhere, though.


Why dump of the environment?


If you are building external modules natively
your distribution provides /lib/modules/$(uname -r)/build,
which contains files enough for building external modules.

You can pass the directory path to M=3D... parameter.  That's it.



If you are cross-building external modules,
you also need to

 - pass ARCH=3D
 - use the same compiler with CROSS_COMPILE=3D

You should know both
because you have built the kernel by your self.

You do not need any other information, do you?




> And it went nowhere.
>
> Anyway, the observed issue with CONFIG_64BIT on x86 is the tip of a
> larger problem which was unnoticed for ages. The .config simply does
> not contain the whole kernel configuration. ie. make oldconfig (and
> make syncconfig) is *not* expected to just work. It used to work just by
> luck until f467c5640c29 ("kconfig: only write '# CONFIG_FOO is not set'
> for visible symbols") finally exposed the problem.

If you want to build the kernel for an architecture
other than the host machine architecture, you need to pass ARCH=3D.

Building the i386 kernel on a x86_64 machine, it is a _kind_ of cross-compi=
ling.
So, passing ARCH=3Di386 is not so weird.


> So is .config supposed to contain the kernel configuration or is it
> just some byproduct of the kernel build which is meaningless outside of
> your build environment (the object tree, shell environment, etc).

The .config is supposed to contain the kernel configuration,
'ARCH' and the compiler are exceptions.

'ARCH' must be passed separately.

The .config now depends on the compiler.  So, if you pass your .config
to somebody else, some symbols that depend on the compiler support
might be configured differently.

'make syncconfig' will notice the compiler difference,
and show prompts for user input as needed.





--=20
Best Regards
Masahiro Yamada
