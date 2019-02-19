Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63749C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A670217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xQavpI6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfBSEnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:43:12 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:56277 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSEnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:43:12 -0500
X-Greylist: delayed 1696 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2019 23:43:10 EST
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1J4gom1002993;
        Tue, 19 Feb 2019 13:42:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1J4gom1002993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550551371;
        bh=Ouc8G4KLNZaE6lveGhLr5rpPmdwDIB4HyR9ERDNDPIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xQavpI6Vzfdk7kv0oqLKCznvBpaMj9/ZR/FqLArqmriudYyOSAI7btDhXj/0gGIAj
         Yu4TKaae76BGnPGfFQ6TIaFc67vB9TEHMuMejJeD7EW1dNNNXFYJGMdz6+pP/tLx3t
         /3j2kvIdl1+hDDvSj1qLi/V5z2MZvMIKuRcqb20czXkLOOXTw3e3ZALkhYBz7YkWfZ
         JB3MhxBgqmwiU7mMA+Z3AvlGUru6SZ06WLPo7sKsIEGXCynrf4Lbf77dOWkBZfA+aY
         q28hQekDK6jNLVKnKJTwKZE5ICx7y5FkgPl9LgOKusq4OUSY0aTprDemaUEV1ZXess
         YG3kzkVklocKg==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id w14so3997885vso.6;
        Mon, 18 Feb 2019 20:42:50 -0800 (PST)
X-Gm-Message-State: AHQUAuaZ7a/rxYeBfeTXXTz5O5QWlaiBLLD5RomGagxzHtp84/WptqdM
        W9FPijBOCKs9kWA5f65Px7GBuZi6cHsd+A8fCKk=
X-Google-Smtp-Source: AHgI3IYnm0B/yD23GE1FOk2xDlSaKzk45t+t4haO0qql7ZKhC1nkKgfoSRCwu5lfwmlBRHfY9auboKM1NXZBq/OdDQg=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr7742118vsq.215.1550551369552;
 Mon, 18 Feb 2019 20:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp> <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
In-Reply-To: <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Feb 2019 13:42:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATf4adEEqWko2YO46wHHi-Vvc+_LBjQGNnM7rt8GSOgZQ@mail.gmail.com>
Message-ID: <CAK7LNATf4adEEqWko2YO46wHHi-Vvc+_LBjQGNnM7rt8GSOgZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 1:14 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Feb 15, 2019 at 11:48 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > > Introduce in-kernel headers and other artifacts which are made available
> > > as an archive through proc (/proc/kheaders.txz file).
>
>
> The extension '.txz' is not used in kernel code.
>
>
> '.tar.xz' is used for 'tarxz-pkg', 'perf-tarxz-src-pkg' etc.
>
>
> $ git grep  '\.txz'
> $ git grep  '\.tar\.xz'
> Documentation/admin-guide/README.rst:     xz -cd linux-4.X.tar.xz | tar xvf -
> arch/x86/crypto/camellia-aesni-avx-asm_64.S: *
> http://koti.mbnet.fi/axh/crypto/camellia-BSD-1.2.0-aesni1.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> scripts/package/Makefile:       @echo '  perf-tarxz-src-pkg  - Build
> $(perf-tar).tar.xz source tarball'
> tools/testing/selftests/gen_kselftest_tar.sh:
>  ext=".tar.xz"
>
>
>
> I prefer '.tar.xz' for consistency.
>
>
>
>
>
>
> BTW, have you ever looked at scripts/extract-ikconfig?
>
> You added IKHD_ST and IKHD_ED
> just to mimic kernel/configs.c
>
> It is currently pointless without the extracting tool,
> but you might think it is useful to extract headers
> from vmlinux or the module without mounting procfs.
>
>
>
>
> > > This archive makes
> > > it possible to build kernel modules, run eBPF programs, and other
> > > tracing programs that need to extend the kernel for tracing purposes
> > > without any dependency on the file system having headers and build
> > > artifacts.
> > >
> > > On Android and embedded systems, it is common to switch kernels but not
> > > have kernel headers available on the file system. Raw kernel headers
> > > also cannot be copied into the filesystem like they can be on other
> > > distros, due to licensing and other issues. There's no linux-headers
> > > package on Android. Further once a different kernel is booted, any
> > > headers stored on the file system will no longer be useful. By storing
> > > the headers as a compressed archive within the kernel, we can avoid these
> > > issues that have been a hindrance for a long time.
> >
> > The set looks good to me and since the main use case is building bpf progs
> > I can route it via bpf-next tree if there are no objections.
> > Masahiro, could you please ack it?
>
>
> Honestly, I was not tracking this thread
> since I did not know I was responsible for this.
>
>
> I just started to take a closer look, then immediately got scared.
>
> This version is not mature enough for the merge.
>
>
>
> First of all, this patch cannot be compiled out-of-tree (O= option).
>
>
> I do not know why 0-day bot did not catch this apparent breakage.
>
>
> $ make -j8 O=hoge
> make[1]: Entering directory '/home/masahiro/workspace/bsp/linux/hoge'
>   GEN     Makefile
>   Using .. as source for kernel
>   DESCEND  objtool
>   CALL    ../scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
> make[2]: *** No rule to make target 'Module.symvers', needed by
> 'kernel/kheaders_data.txz'.  Stop.
> make[2]: *** Waiting for unfinished jobs....
> /home/masahiro/workspace/bsp/linux/Makefile:1043: recipe for target
> 'kernel' failed
> make[1]: *** [kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make[1]: Leaving directory '/home/masahiro/workspace/bsp/linux/hoge'
> Makefile:152: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2




I saw this build error for in-tree building as well.

We cannot build this from a pristine source tree.

For example, I observed the build error in the following procedure.

$ make mrproper
$ make defconfig
 Set CONFIG_IKHEADERS_PROC=y
$ make




Module.symvers is generated in the modpost stage
(the very last stage of build).

But, vmlinux depends on kernel/kheaders_data.txz,
which includes Module.symvers.

So, this is not so simple since it is a circular dependency...




-- 
Best Regards
Masahiro Yamada
