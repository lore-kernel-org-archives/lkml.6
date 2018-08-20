Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24120C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86EE21531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86EE21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeHUAuy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:50:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:52008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbeHUAuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:50:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9907AED3;
        Mon, 20 Aug 2018 21:33:34 +0000 (UTC)
Date:   Mon, 20 Aug 2018 23:33:31 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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
Subject: Re: due to kconfig changes kernel config file is no longer
 sufficient for configuring the kernel
Message-ID: <20180820233331.08dd2bfb@naga.suse.cz>
In-Reply-To: <CAK7LNATCktToMui4NYxoUXV8ZbuDK8F0JCp_CysEWaSBPUP7NQ@mail.gmail.com>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
        <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
        <20180628111623.3807fe9b@naga.suse.cz>
        <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
        <20180806200725.4efa5d35@kitsune.suse.cz>
        <CAK7LNATCktToMui4NYxoUXV8ZbuDK8F0JCp_CysEWaSBPUP7NQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 21 Aug 2018 03:15:12 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 2018-08-07 3:07 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:
> > On Mon, 30 Jul 2018 17:02:42 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >  
> >> 2018-06-28 18:16 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:  
> >> > On Wed, 27 Jun 2018 23:07:21 +0900
> >> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >> >  

> >>
> >>
> >>  
> >> >>
> >> >> out-of-tree modules are built with exactly the same
> >> >> configuration as used for the kernel.  
> >> >
> >> > It is not true. And that is the problem. You need the config file
> >> > and dump of the environment passed to the make command at
> >> > configuration time to get the exact same configuration. The
> >> > environment is not saved anywhere, though.  
> >>
> >>
> >> Why dump of the environment?
> >>
> >>
> >> If you are building external modules natively
> >> your distribution provides /lib/modules/$(uname -r)/build,
> >> which contains files enough for building external modules.
> >>
> >> You can pass the directory path to M=... parameter.  That's it.  
> >
> > No, that's not it. Since passing ARCH=i386 is the de-facto standard
> > to configure a 32bit kernel and the result of passing that was not
> > saved you need to pass it to make as well.  
> 
> 
> If you pass ARCH= for the configuration phase,
> you need to pass the same ARCH= in the build phase.
> 
> 
> 
> 
> What I can suggest for you is:
> 
> 
> $ make ARCH=i386 defconfig
> $ make ARCH=i386
> 
>    OR
> 
> $ make i386_defconfig
> $ make

Maybe you missed that but I do not want to build the defconfig. I want
to build a *particular* config which has been saved in a file
beforehand.
> 
> > And you need to patch a number of
> > 3rd party build scripts that build a kernel module as part of a
> > bigger project.  
> 
> 
> You do not need to patch a number of scripts.
> 
> Just one liner fix.
> Add 'export ARCH=i386' in the top level script.

And that does not work because there is no toplevel script. rpm has
three toplevel scripts - prep, build and install.

Building out-of-tree module is another toplevel script.

And it does not suffice to 'export ARCH=i386'. What if it was a 64bit
config? How do I tell?

With more and more options left out of the config that depend on
compiler features, environment variables, phase of the moon or whatnot
you can't even tell what kind of kernel the user is running by looking
at the config.

Thanks

Michal
