Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41AEC282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925792146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bcvQhbtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBKBka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:40:30 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:26813 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfBKBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:40:30 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1B1eKt0008981;
        Mon, 11 Feb 2019 10:40:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1B1eKt0008981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549849221;
        bh=7N2llrOAXqRxqjJ2eRJhQGxWXeHXNdWCUdAsKp2/YZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bcvQhbtbP4wN1OunoGGpR3uDa/0mvx+hqVzMcvqWL2htBUZUqsjRSObkgQBUZWVNU
         7yiMLq959T4QG+AymdvFqBBmPQ2LbTk+I2GC1qwKi6+kf5Q2+JqxnflC0fvgPva9HV
         itrv936GV2kMvgyLzUf00ctqBh31nbRe8+mFUerTRZWuYk2h0ZPSBuZ0tlLYoCyCvu
         cSJRrv5T3UEgBz2Bf9yYcIrT9vcNcIfXQrgH6krwKBimA8NSm3kIqQASroxm+2YeHM
         vKv5J4VkOHCr2J2G5dNEEb+7eMDkSxMk98bGxXp/4o2KmBT+tWWu2f5xgo7tvxstJ0
         jNNI4A4+8cS0A==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id o130so2089140vke.10;
        Sun, 10 Feb 2019 17:40:20 -0800 (PST)
X-Gm-Message-State: AHQUAuYNbJdU2TKT/Drt1pqD+Z9evBd6qO8yUKgIt7vJrpLfg0oPGdn5
        WkypPjtmTIcCfb8YpTI75jlrgrlDgck5bcHklbo=
X-Google-Smtp-Source: AHgI3IZkhXJgUGFUQAbj1p8+nTN6mb/+jNQcPo1YtcfbUaFsVo6/8j5m/UEmOU4DXDz8ZkFo3IW8uLkDqiph/uwmvO0=
X-Received: by 2002:a1f:a343:: with SMTP id m64mr2660677vke.84.1549849219726;
 Sun, 10 Feb 2019 17:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20190207211102.154634-1-joel@joelfernandes.org>
In-Reply-To: <20190207211102.154634-1-joel@joelfernandes.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 11 Feb 2019 10:39:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREaZdc6=SgR215j25+By3upKe11EpRFZFC-fYAFa5roQ@mail.gmail.com>
Message-ID: <CAK7LNAREaZdc6=SgR215j25+By3upKe11EpRFZFC-fYAFa5roQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>, atishp04@gmail.com,
        dancol@google.com, Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 6:13 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Introduce in-kernel headers and other artifacts which are made available
> as an archive through proc (/proc/kheaders.txz file). This archive makes
> it possible to build kernel modules, run eBPF programs, and other
> tracing programs that need to extend the kernel for tracing purposes
> without any dependency on the file system having headers and build
> artifacts.
>
> On Android and embedded systems, it is common to switch kernels but not
> have kernel headers available on the file system. Raw kernel headers
> also cannot be copied into the filesystem like they can be on other
> distros, due to licensing and other issues. There's no linux-headers
> package on Android. Further once a different kernel is booted, any
> headers stored on the file system will no longer be useful. By storing
> the headers as a compressed archive within the kernel, we can avoid these
> issues that have been a hindrance for a long time.
>
> The feature is also buildable as a module just in case the user desires
> it not being part of the kernel image. This makes it possible to load
> and unload the headers on demand. A tracing program, or a kernel module
> builder can load the module, do its operations, and then unload the
> module to save kernel memory. The total memory needed is 3.8MB.
>
> The code to read the headers is based on /proc/config.gz code and uses
> the same technique to embed the headers.
>
> To build a module, the below steps have been tested on an x86 machine:
> modprobe kheaders
> rm -rf $HOME/headers
> mkdir -p $HOME/headers
> tar -xvf /proc/kheaders.txz -C $HOME/headers >/dev/null
> cd my-kernel-module
> make -C $HOME/headers M=$(pwd) modules
> rmmod kheaders
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Changes since RFC:
> Both changes bring size down to 3.8MB:
> - use xz for compression
> - strip comments except SPDX lines
> - Call out the module name in Kconfig
> - Also added selftests in second patch to ensure headers are always
> working.
>
>  Documentation/dontdiff    |  1 +
>  arch/x86/Makefile         |  2 ++
>  init/Kconfig              | 11 ++++++
>  kernel/.gitignore         |  2 ++
>  kernel/Makefile           | 29 +++++++++++++++
>  kernel/kheaders.c         | 74 +++++++++++++++++++++++++++++++++++++++
>  scripts/gen_ikh_data.sh   | 19 ++++++++++
>  scripts/strip-comments.pl |  8 +++++
>  8 files changed, 146 insertions(+)
>  create mode 100644 kernel/kheaders.c
>  create mode 100755 scripts/gen_ikh_data.sh
>  create mode 100755 scripts/strip-comments.pl
>
> diff --git a/Documentation/dontdiff b/Documentation/dontdiff
> index 2228fcc8e29f..05a2319ee2a2 100644
> --- a/Documentation/dontdiff
> +++ b/Documentation/dontdiff
> @@ -151,6 +151,7 @@ int8.c
>  kallsyms
>  kconfig
>  keywords.c
> +kheaders_data.h*
>  ksym.c*
>  ksym.h*
>  kxgettext
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 88398fdf8129..ad176d669da4 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -240,6 +240,8 @@ archmacros:
>  ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
>  export ASM_MACRO_FLAGS
>  KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
> +IKH_EXTRA += arch/x86/kernel/macros.s
> +export IKH_EXTRA


This does not exist in any of released kernels.

See commit 6ac389346e6



>
>  ###
>  # Kernel objects
> diff --git a/init/Kconfig b/init/Kconfig
> index a4112e95724a..b95d769b6098 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -549,6 +549,17 @@ config IKCONFIG_PROC
>           This option enables access to the kernel configuration file
>           through /proc/config.gz.
>
> +config IKHEADERS_PROC
> +       tristate "Enable kernel header artifacts through /proc/kheaders.txz"
> +       select BUILD_BIN2C
> +       depends on PROC_FS
> +       help
> +         This option enables access to the kernel header and other artifacts that
> +          are generated during the build process. These can be used to build kernel
> +          modules, and other in-kernel programs such as those generated by eBPF
> +          and systemtap tools. If you build the headers as a module, a module
> +          called kheaders.ko is built which can be loaded to get access to them.
> +
>  config LOG_BUF_SHIFT
>         int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
>         range 12 25
> diff --git a/kernel/.gitignore b/kernel/.gitignore
> index b3097bde4e9c..6acf71acbdcb 100644
> --- a/kernel/.gitignore
> +++ b/kernel/.gitignore
> @@ -3,5 +3,7 @@
>  #
>  config_data.h
>  config_data.gz
> +kheaders_data.h
> +kheaders_data.txz
>  timeconst.h
>  hz.bc
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 7343b3a9bff0..aa2d3f9b9f49 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_UTS_NS) += utsname.o
>  obj-$(CONFIG_USER_NS) += user_namespace.o
>  obj-$(CONFIG_PID_NS) += pid_namespace.o
>  obj-$(CONFIG_IKCONFIG) += configs.o
> +obj-$(CONFIG_IKHEADERS_PROC) += kheaders.o
>  obj-$(CONFIG_SMP) += stop_machine.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
> @@ -131,3 +132,31 @@ $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
>  targets += config_data.h
>  $(obj)/config_data.h: $(obj)/config_data.gz FORCE
>         $(call filechk,ikconfiggz)
> +
> +# Build a list of in-kernel headers for building kernel modules
> +# Any other files will be stored in IKH_EXTRA variable.
> +ikh_file_list := include/
> +ikh_file_list += arch/$(ARCH)/Makefile
> +ikh_file_list += arch/$(ARCH)/include/
> +ikh_file_list += $(IKH_EXTRA)

IKH_EXTRA is unneeded.


> +ikh_file_list += scripts/
> +ikh_file_list += Makefile
> +ikh_file_list += Module.symvers
> +ifeq ($(CONFIG_STACK_VALIDATION), y)
> +ikh_file_list += $(objtree)/tools/objtool/objtool
> +endif
> +
> +$(obj)/kheaders.o: $(obj)/kheaders_data.h
> +
> +targets += kheaders_data.txz
> +
> +quiet_cmd_genikh = GEN     $(obj)/kheaders_data.txz
> +cmd_genikh = $(srctree)/scripts/gen_ikh_data.sh $@ $^ >/dev/null 2>&1
> +$(obj)/kheaders_data.txz: $(ikh_file_list) FORCE
> +       $(call cmd,genikh)
> +
> +filechk_ikheadersxz = (echo "static const char kernel_headers_data[] __used = KH_MAGIC_START"; cat $< | scripts/bin2c; echo "KH_MAGIC_END;")
> +
> +targets += kheaders_data.h
> +$(obj)/kheaders_data.h: $(obj)/kheaders_data.txz FORCE
> +       $(call filechk,ikheadersxz)
> diff --git a/kernel/kheaders.c b/kernel/kheaders.c
> new file mode 100644
> index 000000000000..c39930f51202
> --- /dev/null
> +++ b/kernel/kheaders.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * kernel/kheaders.c
> + * Provide headers and artifacts needed to build kernel modules.
> + * (Borrowed code from kernel/configs.c)
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
> +#include <linux/init.h>
> +#include <linux/uaccess.h>
> +
> +/*
> + * Define kernel_headers_data and kernel_headers_data_size, which contains the
> + * compressed kernel headers.  The file is first compressed with xz and then
> + * bounded by two eight byte magic numbers to allow extraction from a binary
> + * kernel image:
> + *
> + *   IKHD_ST
> + *   <image>
> + *   IKHD_ED
> + */
> +#define KH_MAGIC_START "IKHD_ST"
> +#define KH_MAGIC_END   "IKHD_ED"
> +#include "kheaders_data.h"
> +
> +
> +#define KH_MAGIC_SIZE (sizeof(KH_MAGIC_START) - 1)
> +#define kernel_headers_data_size \
> +       (sizeof(kernel_headers_data) - 1 - KH_MAGIC_SIZE * 2)
> +
> +static ssize_t
> +ikheaders_read_current(struct file *file, char __user *buf,
> +                     size_t len, loff_t *offset)
> +{
> +       return simple_read_from_buffer(buf, len, offset,
> +                                      kernel_headers_data + KH_MAGIC_SIZE,
> +                                      kernel_headers_data_size);
> +}
> +
> +static const struct file_operations ikheaders_file_ops = {
> +       .owner = THIS_MODULE,
> +       .read = ikheaders_read_current,
> +       .llseek = default_llseek,
> +};
> +
> +static int __init ikheaders_init(void)
> +{
> +       struct proc_dir_entry *entry;
> +
> +       /* create the current headers file */
> +       entry = proc_create("kheaders.txz", S_IFREG | S_IRUGO, NULL,
> +                           &ikheaders_file_ops);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       proc_set_size(entry, kernel_headers_data_size);
> +
> +       return 0;
> +}
> +
> +static void __exit ikheaders_cleanup(void)
> +{
> +       remove_proc_entry("kheaders.txz", NULL);
> +}
> +
> +module_init(ikheaders_init);
> +module_exit(ikheaders_cleanup);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Joel Fernandes");
> +MODULE_DESCRIPTION("Echo the kernel header artifacts used to build the kernel");
> diff --git a/scripts/gen_ikh_data.sh b/scripts/gen_ikh_data.sh
> new file mode 100755
> index 000000000000..609196b5cea2
> --- /dev/null
> +++ b/scripts/gen_ikh_data.sh
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +spath="$(dirname "$(readlink -f "$0")")"
> +
> +rm -rf $1.tmp
> +mkdir $1.tmp
> +
> +for f in "${@:2}";
> +       do find "$f" ! -name "*.c" ! -name "*.o" ! -name "*.cmd" ! -name ".*";
> +done | cpio -pd $1.tmp
> +
> +for f in $(find $1.tmp); do
> +       $spath/strip-comments.pl $f
> +done
> +
> +tar -Jcf $1 -C $1.tmp/ . > /dev/null
> +
> +rm -rf $1.tmp
> diff --git a/scripts/strip-comments.pl b/scripts/strip-comments.pl
> new file mode 100755
> index 000000000000..f8ada87c5802
> --- /dev/null
> +++ b/scripts/strip-comments.pl
> @@ -0,0 +1,8 @@
> +#!/usr/bin/perl -pi
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This script removes /**/ comments from a file, unless such comments
> +# contain "SPDX". It is used when building compressed in-kernel headers.
> +
> +BEGIN {undef $/;}
> +s/\/\*((?!SPDX).)*?\*\///smg;
> --
> 2.20.1.611.gfbb209baf1-goog



-- 
Best Regards
Masahiro Yamada
