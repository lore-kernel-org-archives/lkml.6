Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A56C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97D021773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="P3L6jNDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfBSEO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:14:57 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31526 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfBSEO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:14:57 -0500
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x1J4ElIV008320;
        Tue, 19 Feb 2019 13:14:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1J4ElIV008320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550549688;
        bh=s2rmefywG5qxRfRX9Ispy/WfF/VrvGNX/NJKAR+FOgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P3L6jNDwzr1EB2636z7AQnlpfMbyj+LnMf900heL9+Ndk32TtOinAaxEoM3eg+Rx2
         9UD1YGia+VwuHWVHrP5DpQrvjb24LS7gHlBFwiABApsAfYA2q/6jhCyn/n8gsmI2R6
         YJ1iTbdLAhIQkXKUnVN+swpGv6BrGoyJXF2pH+4HJJ9dc3iOknEdQJKqhTRnjPdl+3
         IWtdazLHP57x2qtdxlz0hNMBQD1BTbDxlRJL5qIAD2LuEsKf8RxI/aClvzL5kPMALD
         zmSKYsfFuM5w9pPqk8kG5b6bjJJ3ZBX9AJHkxIJEO5JtP1ks/3AS2cvjIxa0URQMba
         lwjkl1ykuQvfw==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id h128so4351596vkg.11;
        Mon, 18 Feb 2019 20:14:48 -0800 (PST)
X-Gm-Message-State: AHQUAubfAMYUu67mKnQIpRCqchKHKFB9RGW2qWI8VRveEh3YZP2BIpkd
        jlveAJCpEanCqP8+NXrT0wvn1yVNq/ph7aw2wFw=
X-Google-Smtp-Source: AHgI3IZo5AE7PNvPF825jn5n7M6ABkfNkD3bMbBFDTxwEOkbOxLdQFDki0790yv0sV2JLjhr45qp9yNq9QHzV7LaeY4=
X-Received: by 2002:a1f:5e96:: with SMTP id s144mr13298575vkb.74.1550549687283;
 Mon, 18 Feb 2019 20:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20190211143600.15021-1-joel@joelfernandes.org> <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
In-Reply-To: <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Feb 2019 13:14:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
Message-ID: <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
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

On Fri, Feb 15, 2019 at 11:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > Introduce in-kernel headers and other artifacts which are made available
> > as an archive through proc (/proc/kheaders.txz file).


The extension '.txz' is not used in kernel code.


'.tar.xz' is used for 'tarxz-pkg', 'perf-tarxz-src-pkg' etc.


$ git grep  '\.txz'
$ git grep  '\.tar\.xz'
Documentation/admin-guide/README.rst:     xz -cd linux-4.X.tar.xz | tar xvf -
arch/x86/crypto/camellia-aesni-avx-asm_64.S: *
http://koti.mbnet.fi/axh/crypto/camellia-BSD-1.2.0-aesni1.tar.xz
crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
scripts/package/Makefile:       @echo '  perf-tarxz-src-pkg  - Build
$(perf-tar).tar.xz source tarball'
tools/testing/selftests/gen_kselftest_tar.sh:
 ext=".tar.xz"



I prefer '.tar.xz' for consistency.






BTW, have you ever looked at scripts/extract-ikconfig?

You added IKHD_ST and IKHD_ED
just to mimic kernel/configs.c

It is currently pointless without the extracting tool,
but you might think it is useful to extract headers
from vmlinux or the module without mounting procfs.




> > This archive makes
> > it possible to build kernel modules, run eBPF programs, and other
> > tracing programs that need to extend the kernel for tracing purposes
> > without any dependency on the file system having headers and build
> > artifacts.
> >
> > On Android and embedded systems, it is common to switch kernels but not
> > have kernel headers available on the file system. Raw kernel headers
> > also cannot be copied into the filesystem like they can be on other
> > distros, due to licensing and other issues. There's no linux-headers
> > package on Android. Further once a different kernel is booted, any
> > headers stored on the file system will no longer be useful. By storing
> > the headers as a compressed archive within the kernel, we can avoid these
> > issues that have been a hindrance for a long time.
>
> The set looks good to me and since the main use case is building bpf progs
> I can route it via bpf-next tree if there are no objections.
> Masahiro, could you please ack it?


Honestly, I was not tracking this thread
since I did not know I was responsible for this.


I just started to take a closer look, then immediately got scared.

This version is not mature enough for the merge.



First of all, this patch cannot be compiled out-of-tree (O= option).


I do not know why 0-day bot did not catch this apparent breakage.


$ make -j8 O=hoge
make[1]: Entering directory '/home/masahiro/workspace/bsp/linux/hoge'
  GEN     Makefile
  Using .. as source for kernel
  DESCEND  objtool
  CALL    ../scripts/checksyscalls.sh
  CHK     include/generated/compile.h
make[2]: *** No rule to make target 'Module.symvers', needed by
'kernel/kheaders_data.txz'.  Stop.
make[2]: *** Waiting for unfinished jobs....
/home/masahiro/workspace/bsp/linux/Makefile:1043: recipe for target
'kernel' failed
make[1]: *** [kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory '/home/masahiro/workspace/bsp/linux/hoge'
Makefile:152: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2





I was able to compile it in-tree
but it makes the incremental build extremely slow.

(Here, the incremental build means
"make" without changing any code after the full build.)




Before this patch, "make -j8" took 11 sec on my machine.

real 0m11.777s
user 0m16.608s
sys 0m5.164s



After this patch, x86_64_defconfig + CONFIG_IKHEADERS_PROC=y
takes 53 sec for me since kernel/kheaders_data.txz is regenerated
every time even when you did not touch any source file.


$ time make -j8
  DESCEND  objtool
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  GEN     kernel/kheaders_data.txz
  UPD     kernel/kheaders_data.h
  CC      kernel/kheaders.o
  AR      kernel/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  AR      built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  Building modules, stage 2.
  CC      arch/x86/boot/version.o
  MODPOST 17 modules
  VOFFSET arch/x86/boot/compressed/../voffset.h
  OBJCOPY arch/x86/boot/compressed/vmlinux.bin
  RELOCS  arch/x86/boot/compressed/vmlinux.relocs
  CC      arch/x86/boot/compressed/kaslr.o
  GZIP    arch/x86/boot/compressed/vmlinux.bin.gz
  CC      arch/x86/boot/compressed/misc.o
  MKPIGGY arch/x86/boot/compressed/piggy.S
  AS      arch/x86/boot/compressed/piggy.o
  LD      arch/x86/boot/compressed/vmlinux
  ZOFFSET arch/x86/boot/zoffset.h
  OBJCOPY arch/x86/boot/vmlinux.bin
  AS      arch/x86/boot/header.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  BUILD   arch/x86/boot/bzImage
Setup is 15612 bytes (padded to 15872 bytes).
System is 12673 kB
CRC 697aaf88
Kernel: arch/x86/boot/bzImage is ready  (#6)

real 0m53.024s
user 0m32.076s
sys 0m9.296s




Also, I notice $(ARCH) must be fixed to $(SRCARCH),
but that is one of minor issues.



We should take time for careful review and test.


Please give me more time for thorough review.



--
Best Regards
Masahiro Yamada
