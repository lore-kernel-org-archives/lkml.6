Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F7EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886502152D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="WLx97pIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886502152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeHOW1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:27:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40796 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeHOW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:27:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so2481792qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FSpWdA0SKcMo1cy0kfowwoX1MB79YE608KfhbUDI2HI=;
        b=WLx97pIqif3CIjPoeidpUCrRwQpjs+8fDhlXAXnW6T9j2mEa5NFWhxV8aA9w+ZsceZ
         QC3mUojgys2sPe/kODW2feWnAthAIatMBVdk9v200f7tmm5jIi4f6ZkUgA1euzBfW6pO
         DOCQbaBWolI1m2s8pKA6ZjMhqk67xGS5WWstaYOyiI1x2+QscE4Q52QXJhiLSZ9NibsP
         2MGxrhixO/n6j16jH9dv/vVwq9tOclTlNHhHO9fjkwS9WY5lrNF9PV1iV5VezItJY+Ii
         JBIQOmnonS3ptCmvlda2k40fkkyU1dsI1MKEn9qvgZo98czw6xgHOtX2X0CcFqo2P5QN
         f7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FSpWdA0SKcMo1cy0kfowwoX1MB79YE608KfhbUDI2HI=;
        b=F2b90lvqiNH+6ej40xezDfg8YnD8AMBQwdAvMbSl8lIOBCqcLvLnbZhvRKTbvjBTqs
         Frss1EbvAnc+k5h3AozzmsvW2lAHt7FoA6VzZvmWzFr/jYrn7GLDT6u+UYGT4aw+3a4y
         qMswz2ioM5yzbOVSAUOfOXOZDi+VxK0XD+2EIcERy0/JYSbe8M7DoCg0kBKYyzutg9vU
         LB3HAcuQMlAJNx/fiT0D+QueevZd70VNVJ6SL8KX3gziC170Vn0grg2db4YRxXpeezLt
         02Kuj3xBf3YJPRS5lf/HKjsba7ts6KmktiCJEXmYMGsqwdhq4jqWCPAon9NFigE/vHyE
         WPiQ==
X-Gm-Message-State: AOUpUlGB9xKXVCXidKz58FKxnmrYKA8tBEQwdxlrRIOeFNqwlzowkHwE
        nfCxmJ7LcfFWaR6aj/Mid4qesw==
X-Google-Smtp-Source: AA+uWPzK78AKLzP9KzFDD5lzpw4NZsor2UaoGpaGcoptu9Got4o3HXmHKthQmglwENqur6VZwIN7Hg==
X-Received: by 2002:a0c:96eb:: with SMTP id b40-v6mr24452961qvd.235.1534361662593;
        Wed, 15 Aug 2018 12:34:22 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i128-v6sm14195128qke.36.2018.08.15.12.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 12:34:22 -0700 (PDT)
Date:   Wed, 15 Aug 2018 12:34:18 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, wangnan0@huawei.com,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        acme@kernel.org, Chenbo Feng <fengc@google.com>
Subject: Re: samples don't build on v4.18
Message-ID: <20180815123418.2765f5b6@cakuba.netronome.com>
In-Reply-To: <20180815030132.GA204101@joelaf.mtv.corp.google.com>
References: <20180815012054.GA70201@joelaf.mtv.corp.google.com>
        <CAJWu+orb35w6O5B9KyHdYtwc2RbaR9d72HW-i5Bsup72QP8Oag@mail.gmail.com>
        <20180815030132.GA204101@joelaf.mtv.corp.google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 20:01:32 -0700, Joel Fernandes wrote:
> On Tue, Aug 14, 2018 at 06:22:21PM -0700, Joel Fernandes wrote:
> > Forgot to add the patch author, doing so now. thanks
> > 
> > On Tue, Aug 14, 2018 at 6:20 PM, Joel Fernandes <joelaf@google.com> wrote:  
> > >
> > > Hi,
> > > When building BPF samples on v4.18, I get the following errors:
> > >
> > > $ cd samples/bpf/
> > > $ make
> > >
> > > Auto-detecting system features:
> > > ...                        libelf: [ OFF ]
> > > ...                           bpf: [ OFF ]
> > >
> > > No libelf found
> > > Makefile:213: recipe for target 'elfdep' failed
> > > -----------
> > >
> > > I bissected it down to commit 5f9380572b4bb24f60cd492b1
> > >
> > > Author: Jakub Kicinski <jakub.kicinski@netronome.com>
> > > Date:   Thu May 10 10:24:39 2018 -0700
> > >
> > >     samples: bpf: compile and link against full libbpf
> > > ---------
> > >
> > > Checking out a kernel before this commit makes the samples build. Also I do
> > > have libelf on my system.
> > >
> > > Any thoughts on this issue?  
> 
> There is some weirdness going on with my kernel tree. If I do a fresh clone
> of v4.18 and build samples, everything works.
> 
> However if I take my existing checkout, do a:
> git clean -f -d
> make mrproper
> 
> Then I try to build the samples, I get the "No libelf found".
> 
> Obviously the existing checked out kernel tree is in some weird state that I
> am not yet able to fix. But atleast if I blow the whole tree and clone again,
> I'm able to build...
> 
> Is this related to the intermittent "No libelf found" issues that were
> recently discussed?

Can't reproduce, could you provide all exact commands you run to see
this, including the initial clone?

12:32 linux$ git clean -f -d
12:32 linux$ make mrproper
  CLEAN   .
  CLEAN   arch/x86/tools
  CLEAN   .tmp_versions
  CLEAN   scripts/basic
  CLEAN   scripts/kconfig
  CLEAN   scripts/mod
  CLEAN   scripts
  CLEAN   include/config usr/include include/generated arch/x86/include/generated
  CLEAN   .config .config.old
12:32 linux$ make defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
12:32 linux$ make headers_install
  UPD     include/generated/uapi/linux/version.h
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (497 files)
  INSTALL usr/include/linux/android/ (1 file)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (12 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (4 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
12:32 linux$ cd samples/bpf/
12:32 bpf$ make  LLC=llc-6.0 LLVM_OBJCOPY=llvm-objcopy-6.0 CLANG=clang-6.0 
make -C ../../ /tmp/linux/samples/bpf/ BPF_SAMPLES_PATH=/tmp/linux/samples/bpf
make[1]: Entering directory '/tmp/linux'
scripts/kconfig/conf  --syncconfig Kconfig
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  UPD     include/config/kernel.release
  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
  UPD     include/generated/utsrelease.h
  CC      kernel/bounds.s
  UPD     include/generated/bounds.h
  UPD     include/generated/timeconst.h
  CC      arch/x86/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  HOSTCC   /tmp/linux/tools/objtool/fixdep.o
  HOSTLD   /tmp/linux/tools/objtool/fixdep-in.o
  LINK     /tmp/linux/tools/objtool/fixdep
  CC       /tmp/linux/tools/objtool/exec-cmd.o
  CC       /tmp/linux/tools/objtool/help.o
  CC       /tmp/linux/tools/objtool/pager.o
  CC       /tmp/linux/tools/objtool/parse-options.o
  CC       /tmp/linux/tools/objtool/run-command.o
  CC       /tmp/linux/tools/objtool/sigchain.o
  CC       /tmp/linux/tools/objtool/subcmd-config.o
  LD       /tmp/linux/tools/objtool/libsubcmd-in.o
  AR       /tmp/linux/tools/objtool/libsubcmd.a
  CC       /tmp/linux/tools/objtool/arch/x86/decode.o
  LD       /tmp/linux/tools/objtool/arch/x86/objtool-in.o
  CC       /tmp/linux/tools/objtool/builtin-check.o
  CC       /tmp/linux/tools/objtool/builtin-orc.o
  CC       /tmp/linux/tools/objtool/check.o
  CC       /tmp/linux/tools/objtool/orc_gen.o
  CC       /tmp/linux/tools/objtool/orc_dump.o
  CC       /tmp/linux/tools/objtool/elf.o
  CC       /tmp/linux/tools/objtool/special.o
  CC       /tmp/linux/tools/objtool/objtool.o
  CC       /tmp/linux/tools/objtool/libstring.o
  CC       /tmp/linux/tools/objtool/str_error_r.o
  LD       /tmp/linux/tools/objtool/objtool-in.o
  LINK     /tmp/linux/tools/objtool/objtool
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/selinux/genheaders/genheaders
  HOSTCC  scripts/selinux/mdp/mdp
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/sortextable
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
make -C /tmp/linux/samples/bpf/../../tools/lib/bpf/ RM='rm -rf' LDFLAGS= srctree=/tmp/linux/samples/bpf/../../ O=
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
  CC       libbpf.o
  CC       bpf.o
  CC       nlattr.o
  CC       btf.o
  LD       libbpf-in.o
  LINK     libbpf.a
  LINK     libbpf.so
  HOSTCC  /tmp/linux/samples/bpf/test_lru_dist
  HOSTCC  /tmp/linux/samples/bpf/sock_example
  HOSTCC  /tmp/linux/samples/bpf/bpf_load.o
  HOSTCC  /tmp/linux/samples/bpf/fds_example.o
  HOSTLD  /tmp/linux/samples/bpf/fds_example
  HOSTCC  /tmp/linux/samples/bpf/sockex1_user.o
  HOSTLD  /tmp/linux/samples/bpf/sockex1
  HOSTCC  /tmp/linux/samples/bpf/sockex2_user.o
  HOSTLD  /tmp/linux/samples/bpf/sockex2
  HOSTCC  /tmp/linux/samples/bpf/sockex3_user.o
  HOSTLD  /tmp/linux/samples/bpf/sockex3
  HOSTCC  /tmp/linux/samples/bpf/tracex1_user.o
  HOSTLD  /tmp/linux/samples/bpf/tracex1
  HOSTCC  /tmp/linux/samples/bpf/tracex2_user.o
  HOSTLD  /tmp/linux/samples/bpf/tracex2
  HOSTCC  /tmp/linux/samples/bpf/tracex3_user.o
  HOSTLD  /tmp/linux/samples/bpf/tracex3
  HOSTCC  /tmp/linux/samples/bpf/tracex4_user.o
  HOSTLD  /tmp/linux/samples/bpf/tracex4
  HOSTCC  /tmp/linux/samples/bpf/tracex5_user.o
  HOSTLD  /tmp/linux/samples/bpf/tracex5
  HOSTCC  /tmp/linux/samples/bpf/tracex6_user.o
  HOSTLD  /tmp/linux/samples/bpf/tracex6
  HOSTCC  /tmp/linux/samples/bpf/tracex7_user.o
  HOSTLD  /tmp/linux/samples/bpf/tracex7
  HOSTCC  /tmp/linux/samples/bpf/test_probe_write_user_user.o
  HOSTLD  /tmp/linux/samples/bpf/test_probe_write_user
  HOSTCC  /tmp/linux/samples/bpf/trace_output_user.o
  HOSTCC  /tmp/linux/samples/bpf/../../tools/testing/selftests/bpf/trace_helpers.o
  HOSTLD  /tmp/linux/samples/bpf/trace_output
  HOSTCC  /tmp/linux/samples/bpf/lathist_user.o
  HOSTLD  /tmp/linux/samples/bpf/lathist
  HOSTCC  /tmp/linux/samples/bpf/offwaketime_user.o
  HOSTLD  /tmp/linux/samples/bpf/offwaketime
  HOSTCC  /tmp/linux/samples/bpf/spintest_user.o
  HOSTLD  /tmp/linux/samples/bpf/spintest
  HOSTCC  /tmp/linux/samples/bpf/map_perf_test_user.o
  HOSTLD  /tmp/linux/samples/bpf/map_perf_test
  HOSTCC  /tmp/linux/samples/bpf/test_overhead_user.o
  HOSTLD  /tmp/linux/samples/bpf/test_overhead
  HOSTCC  /tmp/linux/samples/bpf/test_cgrp2_array_pin.o
  HOSTLD  /tmp/linux/samples/bpf/test_cgrp2_array_pin
  HOSTCC  /tmp/linux/samples/bpf/test_cgrp2_attach.o
  HOSTLD  /tmp/linux/samples/bpf/test_cgrp2_attach
  HOSTCC  /tmp/linux/samples/bpf/test_cgrp2_attach2.o
  HOSTCC  /tmp/linux/samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.o
  HOSTLD  /tmp/linux/samples/bpf/test_cgrp2_attach2
  HOSTCC  /tmp/linux/samples/bpf/test_cgrp2_sock.o
  HOSTLD  /tmp/linux/samples/bpf/test_cgrp2_sock
  HOSTCC  /tmp/linux/samples/bpf/test_cgrp2_sock2.o
  HOSTLD  /tmp/linux/samples/bpf/test_cgrp2_sock2
  HOSTCC  /tmp/linux/samples/bpf/xdp1_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp1
  HOSTLD  /tmp/linux/samples/bpf/xdp2
  HOSTCC  /tmp/linux/samples/bpf/xdp_router_ipv4_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_router_ipv4
  HOSTCC  /tmp/linux/samples/bpf/test_current_task_under_cgroup_user.o
  HOSTLD  /tmp/linux/samples/bpf/test_current_task_under_cgroup
  HOSTCC  /tmp/linux/samples/bpf/trace_event_user.o
  HOSTLD  /tmp/linux/samples/bpf/trace_event
  HOSTCC  /tmp/linux/samples/bpf/sampleip_user.o
  HOSTLD  /tmp/linux/samples/bpf/sampleip
  HOSTCC  /tmp/linux/samples/bpf/tc_l2_redirect_user.o
  HOSTLD  /tmp/linux/samples/bpf/tc_l2_redirect
  HOSTCC  /tmp/linux/samples/bpf/lwt_len_hist_user.o
  HOSTLD  /tmp/linux/samples/bpf/lwt_len_hist
  HOSTCC  /tmp/linux/samples/bpf/xdp_tx_iptunnel_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_tx_iptunnel
  HOSTCC  /tmp/linux/samples/bpf/test_map_in_map_user.o
  HOSTLD  /tmp/linux/samples/bpf/test_map_in_map
  HOSTCC  /tmp/linux/samples/bpf/cookie_uid_helper_example.o
  HOSTLD  /tmp/linux/samples/bpf/per_socket_stats_example
  HOSTCC  /tmp/linux/samples/bpf/load_sock_ops.o
  HOSTLD  /tmp/linux/samples/bpf/load_sock_ops
  HOSTCC  /tmp/linux/samples/bpf/xdp_redirect_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_redirect
  HOSTCC  /tmp/linux/samples/bpf/xdp_redirect_map_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_redirect_map
  HOSTCC  /tmp/linux/samples/bpf/xdp_redirect_cpu_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_redirect_cpu
  HOSTCC  /tmp/linux/samples/bpf/xdp_monitor_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_monitor
  HOSTCC  /tmp/linux/samples/bpf/xdp_rxq_info_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_rxq_info
  HOSTCC  /tmp/linux/samples/bpf/syscall_tp_user.o
  HOSTLD  /tmp/linux/samples/bpf/syscall_tp
  HOSTCC  /tmp/linux/samples/bpf/cpustat_user.o
  HOSTLD  /tmp/linux/samples/bpf/cpustat
  HOSTCC  /tmp/linux/samples/bpf/xdp_adjust_tail_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_adjust_tail
  HOSTCC  /tmp/linux/samples/bpf/xdpsock_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdpsock
  HOSTCC  /tmp/linux/samples/bpf/xdp_fwd_user.o
  HOSTLD  /tmp/linux/samples/bpf/xdp_fwd
  HOSTCC  /tmp/linux/samples/bpf/task_fd_query_user.o
  HOSTLD  /tmp/linux/samples/bpf/task_fd_query
  CC      /tmp/linux/samples/bpf/syscall_nrs.s
  CLANG-bpf  /tmp/linux/samples/bpf/sockex1_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/sockex2_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/sockex3_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tracex1_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tracex2_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tracex3_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tracex4_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tracex5_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tracex6_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tracex7_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/sock_flags_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/test_probe_write_user_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/trace_output_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tcbpf1_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tc_l2_redirect_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/lathist_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/offwaketime_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/spintest_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/map_perf_test_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/test_overhead_tp_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/test_overhead_raw_tp_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/test_overhead_kprobe_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/parse_varlen.o
  CLANG-bpf  /tmp/linux/samples/bpf/parse_simple.o
  CLANG-bpf  /tmp/linux/samples/bpf/parse_ldabs.o
  CLANG-bpf  /tmp/linux/samples/bpf/test_cgrp2_tc_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp1_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp2_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_router_ipv4_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/test_current_task_under_cgroup_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/trace_event_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/sampleip_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/lwt_len_hist_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_tx_iptunnel_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/test_map_in_map_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tcp_synrto_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tcp_rwnd_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tcp_bufs_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tcp_cong_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tcp_iw_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tcp_clamp_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/tcp_basertt_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_redirect_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_redirect_map_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_redirect_cpu_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_monitor_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_rxq_info_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp2skb_meta_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/syscall_tp_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/cpustat_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_adjust_tail_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdpsock_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/xdp_fwd_kern.o
  CLANG-bpf  /tmp/linux/samples/bpf/task_fd_query_kern.o
make[1]: Leaving directory '/tmp/linux'
