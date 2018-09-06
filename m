Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD9CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855232083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hBEPL1lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855232083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeIFUjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:39:39 -0400
Received: from mail.efficios.com ([167.114.142.138]:41844 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIFUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:39:39 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CE7A11C53E4;
        Thu,  6 Sep 2018 12:03:27 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id oJCjrFUn27Dd; Thu,  6 Sep 2018 12:03:27 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1673A1C53D5;
        Thu,  6 Sep 2018 12:03:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1673A1C53D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1536249807;
        bh=nzwpMN4o+QUp/evynGRvdmbCVTbOhqxTNP57CNax7e0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hBEPL1lxExSIfJWn8RvjLgXm17O1Jkpregkg1pycQVVsyIWeGZlVIK4QXEDI9w3DG
         zpM1muW9WpsbMc0poci8JripsPDYGRbFCg9VxWdizgXBERvHgoTxIaUdfVL4cXg2qv
         Xq0sQxUo8nZz7rlTLshXzA7vHOhqhCPr/ey/opUR3TfWF4e+X5fBfp0pdcrAlPsX8v
         4xz3CP2W1bS5OtmCjohp++nxmXeoc0iq+j0AGPU8ft/wpztJ/NcVMBW6DhVgYJwxF1
         NGCa+cobLPQZ330I05YS3W5oELnFQtTVP87yrRdUra7Pl38soja1kzzhHYdf2Kk6u0
         wdCF7jnIexXHQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id DLxwTWMY7oGq; Thu,  6 Sep 2018 12:03:27 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 008021C53C4;
        Thu,  6 Sep 2018 12:03:26 -0400 (EDT)
Date:   Thu, 6 Sep 2018 12:03:26 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1838118639.9187.1536249806722.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.11.0-rc1 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3006 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3006)
Thread-Index: Pl9J3kb3QKr5Ib8TP0EjBqCXjjZjyw==
Thread-Topic: LTTng-modules 2.11.0-rc1 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the first release candidate of LTTng modules 2.11 Linux kernel
tracer.

This release is named after a modern Saison beer from Montr=C3=A9al's Oshla=
g
microbrewery. It is a refreshing, zesty, rice beer with hints of fruit and
spices. Some even say it makes for a great Somaek when mixed with Chamisul
Soju, not that we've tried!

Lafontaine is also a tongue-in-cheek reference to a water leak that
affected EfficiOS's offices during the development of this release.

The most notable features of this new release that apply to lttng-modules
are:

    Session rotation
    Dynamic user-space tracing with uprobes
    User and kernel space call stack capture from the kernel tracer
    Support for arrays and bitwise binary operators in filters

See the lttng-tools release tag for more information about this
features: https://github.com/lttng/lttng-tools/releases/tag/v2.11.0-rc1

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2018-09-05 (Be Late for Something Day) LTTng modules 2.11.0-rc1
        * Fix: uprobes: missing break in lttng_event_ioctl()
        * Fix: ACCESS_ONCE was removed in 4.15, use READ_ONCE instead
        * Fix: instruction pointer has different names across arch
        * Fix: build failures when CONFIG_UPROBES is absent
        * uprobe: Support multiple call sites for the same uprobe event
        * uprobe: Receive file descriptor from session instead of path to f=
ile
        * uprobe: Mark uprobe event as registered
        * Add uprobes support
        * Fix: adjust SLE version ranges to build with SP2 and SP3
        * Fix: Allow alphanumeric characters in SLE version
        * Fix: Adjust range for SuSE 4.4.103-92 kernels
        * Cleanup: move to kernel style SPDX license identifiers
        * Cleanup: move scripts to subdirectory
        * Cleanup: modinfo keys
        * Add extra version information framework
        * Revert "Add btrfs file item tracepoints"
        * Fix: btrfs: Remove unnecessary fs_info parameter
        * Fix: btrfs: use fs_info for btrfs_handle_em_exist tracepoint
        * Fix: asoc: Remove snd_soc_cache_sync() implementation
        * Fix: asoc: fix printing jack name
        * Fix: asoc: Consolidate path trace events
        * Fix: ASoC level IO tracing removed upstream
        * Enable userspace callstack contexts only on x86
        * Prevent re-entrancy in callstack-user context
        * Callstack context: bump number of entries to 128
        * Fix: callstack context alignment calculation
        * Cleanup callstack context
        * Fix callstack context: write empty sequence if no stack trace
        * Fix: callstack context: false-sharing, bad memory size allocation
        * callstack context: use delimiter when stack is incomplete
        * Cleanup callstack context
        * Add kernel and user callstack contexts
        * Assign CPU id before saving the context size
        * Define max nesting count constant
        * Compute variable sized context length
        * Pass arguments for context size computation
        * Add 9p probe
        * Update delayed ref tracepoints for v3.12
        * Add btrfs file item tracepoints
        * Add btrfs tracepoint for em's EEXIST case
        * Fix: dyntick field added to trace_rcu_dyntick in v4.16
        * Fix: BUILD_BUG_ON with compile time constant on < v2.6.38
        * Fix: lttng filter validator ERANGE error handling
        * Fix: filter interpreter: use LTTNG_SIZE_MAX
        * Filter: add FILTER_OP_RETURN_S64 instruction
        * Perform bitwise ops on unsigned types
        * Filter: catch shift undefined behavior
        * Filter: add lshift, rshift, bit not ops
        * Filter: index array, sequences, implement bitwise binary operator=
s
        * Fix: pid tracker should track "pgid" for noargs probes
        * lttng-tp-mempool: perform node-local allocation
        * Fix: update RCU instrumentation for 4.17
        * Fix: sunrpc instrumentation for 4.17
        * Fix: use struct reclaim_stat in mm_vmscan_lru_shrink_inactive for=
 4.17
        * Fix: Add gfp_flags arg to mm_vmscan_kswapd_wake for 4.17
        * Update: kvm instrumentation for ubuntu 4.13.0-38
        * Fix: update kvm instrumentation for Ubuntu 3.13.0-144
        * Fix: btrfs instrumentation namespacing
        * Cleanup: comment about CONFIG_HOTPLUG_CPU ifdef
        * Fix: do not use CONFIG_HOTPLUG_CPU for the new hotplug API
        * Fix: update kvm instrumentation for 4.1.50+
        * Use the memory pool instead of kmalloc
        * Create a memory pool for temporary tracepoint probes storage
        * Fix: use proper pid_ns in the process statedump
        * Fix: add variable quoting to shell scripts
        * Update: kvm instrumentation for fedora 4.14.13-300
        * Fix: Add Fedora version macros
        * Add preemptirq instrumentation
        * Clean-up: fix stale #endif comments
        * Command to dump the metadata cache again
        * Add a new /dev/lttng-logger interface
        * Fix: update btrfs instrumentation for SuSE 4.4.114-92
        * Fix: update block instrumentation for SuSE 4.4.114-92
        * Fix: update rcu instrumentation for v4.16
        * Fix: update vmscan instrumentation for v4.16
        * Fix: update timer instrumentation on 4.16 and 4.14-rt
        * Update kvm instrumentation for debian kernel 4.14.0-3
        * Fix: network instrumentation protocol enum
        * Fix: update btrfs instrumentation for SuSE 4.4.103-6
        * Fix: update block instrumentation for SuSE 4.4.73-5
        * Fix: global_dirty_limit for kernel v4.2 and up
        * Fix: network instrumentation handling of corrupted TCP headers
        * Fix: add missing uaccess.h include from kstrtox.h wrapper
        * Update: kvm instrumentation for 4.14.14+, 4.9.77+, 4.4.112+
        * Fix: btrfs_delayed_ref_head was unwired since v3.12
        * Update kvm instrumentation for debian kernel 4.9.65-3
        * Fix: debian kernel version parsing
        * Fix: block instrumentation 4.14+ NULL pointer dereference
        * Update: kvm instrumentation for 3.16.52 and 3.2.97
        * Fix: kvm instrumentation for 4.15
        * Update sock instrumentation for 4.15
        * Update kvm instrumentation for 4.15
        * Fix: ACCESS_ONCE() removed in kernel 4.15
        * Fix: sched instrumentation on stable RT kernels
        * timer API transition for kernel 4.15
        * Fix: Don't nest get online cpus
        * Fix: lttng_channel_syscall_mask() bool use in bitfield
        * Fix: update kmem instrumentation for kernel 4.15
        * Fix: lttng_kvmalloc helper NULL pointer OOPS
        * Update version to 2.11.0-pre
        * Fix: lttng-logger get_user_pages_fast error handling
        * Fix: update block instrumentation for 4.14 kernel
        * Revert "Fix: update block instrumentation for kernel 4.14"
        * Fix: version check error in btrfs instrumentation
        * Fix: update btrfs instrumentation for kernel 4.14
        * Fix: update writeback instrumentation for kernel 4.14
        * Fix: update block instrumentation for kernel 4.14
        * Fix: vmalloc wrapper on kernel < 2.6.38
        * Fix: vmalloc wrapper on kernel >=3D 4.12
        * Add kmalloc failover to vmalloc
        * Fix: mmap: caches aliased on virtual addresses
        * Fix: update ext4 instrumentation for kernel 4.13
        * Fix: Sleeping function called from invalid context
        * Fix: sched for v4.11.5-rt1
        * Make vim users life easier
        * Rename Makefile.ABI.workarounds to Kbuild.common
        * Fix: handle missing ftrace header on v4.12
        * Fix: pid tracker should track "pgid"
        * Cleanup: typo in lttng pid tracker
        * Fix: Build ftrace probe on kernels prior to 4.12
        * Fix: update ftrace probe for kernel 4.12
        * Fix: update block instrumentation for kernel 4.12
        * Calculate context length outside of retry loop
        * Fix: Add support for 4.9.27-rt18 kernel
        * Fix: update btrfs instrumentation for kernel 4.12
        * Fix: update ringbuffer for kernel 4.12
        * Fix: update sched instrumentation for kernel 4.12
        * Fix: ext3 was completely removed from the kernel in v4.3
        * Fix: NULL pointer dereference of THIS_MODULE with built-in module=
s
        * Fix: add "flush empty" ioctl for stream intersection
        * Revert "Fix: flush empty packets on snapshot channel"
        * Revert "Fix: don't perform extra flush on metadata channel"

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
