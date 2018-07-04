Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230D3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65262473D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65262473D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbeGDHBL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:01:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:65126 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753086AbeGDHBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:01:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 00:01:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="xz'?scan'208";a="62139391"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2018 00:01:06 -0700
Date:   Wed, 4 Jul 2018 14:57:21 +0800
From:   kernel test robot <xiaolong.ye@intel.com>
To:     Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, lkp@01.org
Subject: [lkp-robot] [perf tests]  32a4debc7c:
 perf-sanity-tests.probe_libc's_inet_pton_&_backtrace_it_with_ping.fail
Message-ID: <20180704065721.GF23907@yexl-desktop>
Reply-To: kernel test robot <xiaolong.ye@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <20180518072417.1498-1-sandipan@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


FYI, we noticed the following commit (built with gcc-7):

commit: 32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f ("[PATCH] perf tests: Fix regex for record+probe_libc_inet_pton.sh")
url: https://github.com/0day-ci/linux/commits/Sandipan-Das/perf-tests-Fix-regex-for-record-probe_libc_inet_pton-sh/20180521-130408


in testcase: perf-sanity-tests
with following parameters:

	perf_compiler: gcc



on test machine: qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3 -smp 2 -m 8G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 62
62: probe libc's inet_pton & backtrace it with ping       : FAILED!



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
Xiaolong

--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='perf-sanity-tests'
	export testcase='perf-sanity-tests'
	export category='functional'
	export job_origin='/lkp/lkp/src/allot/rand/vm-lkp-nex04-8G/perf-sanity-tests.yaml'
	export testbox='vm-lkp-nex04-8G-2'
	export tbox_group='vm-lkp-nex04-8G'
	export kconfig='x86_64-fedora-25'
	export compiler='gcc-7'
	export queue='bisect'
	export branch='linux-devel/devel-spot-201805211347'
	export commit='32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f'
	export submit_id='5b03dff30b9a932b3a767d71'
	export job_file='/lkp/scheduled/vm-lkp-nex04-8G-2/perf-sanity-tests-gcc-debian-x86_64-2016-08-31.cgz-32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f-20180522-11066-yve2a-1.yaml'
	export id='1bdd8b616b538b8db798a8cdad4603b67ca4566f'
	export model='qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3'
	export nr_vm=10
	export nr_cpu=2
	export memory='8G'
	export hdd_partitions='/dev/vda'
	export need_linux_perf=true
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export ssh_base_port=23250
	export rootfs='debian-x86_64-2016-08-31.cgz'
	export enqueue_time='2018-05-22 17:16:35 +0800'
	export _id='5b03e2ff0b9a932b3a767d72'
	export _rt='/result/perf-sanity-tests/gcc/vm-lkp-nex04-8G/debian-x86_64-2016-08-31.cgz/x86_64-fedora-25/gcc-7/32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f'
	export user='lkp'
	export result_root='/result/perf-sanity-tests/gcc/vm-lkp-nex04-8G/debian-x86_64-2016-08-31.cgz/x86_64-fedora-25/gcc-7/32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/0'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2016-08-31.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/scheduled/vm-lkp-nex04-8G-2/perf-sanity-tests-gcc-debian-x86_64-2016-08-31.cgz-32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f-20180522-11066-yve2a-1.yaml
ARCH=x86_64
kconfig=x86_64-fedora-25
branch=linux-devel/devel-spot-201805211347
commit=32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f
BOOT_IMAGE=/pkg/linux/x86_64-fedora-25/gcc-7/32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/vmlinuz-4.17.0-rc5-00073-g32a4deb
max_uptime=3600
RESULT_ROOT=/result/perf-sanity-tests/gcc/vm-lkp-nex04-8G/debian-x86_64-2016-08-31.cgz/x86_64-fedora-25/gcc-7/32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/0
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-fedora-25/gcc-7/32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/lkp_2018-05-14.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/perf-sanity-tests_2017-12-29.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/perf-x86_64-771c577c23ba_2018-05-21.cgz'
	export linux_perf_initrd='/pkg/linux/x86_64-fedora-25/gcc-7/32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/linux-perf.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export kernel='/pkg/linux/x86_64-fedora-25/gcc-7/32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/vmlinuz-4.17.0-rc5-00073-g32a4deb'
	export dequeue_time='2018-05-22 17:33:08 +0800'
	export job_initrd='/lkp/scheduled/vm-lkp-nex04-8G-2/perf-sanity-tests-gcc-debian-x86_64-2016-08-31.cgz-32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f-20180522-11066-yve2a-1.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test perf_compiler='gcc' $LKP_SRC/tests/wrapper perf-sanity-tests
}

extract_stats()
{
	$LKP_SRC/stats/wrapper perf-sanity-tests
	$LKP_SRC/stats/wrapper kmsg

	$LKP_SRC/stats/wrapper time perf-sanity-tests.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--Wb5NtZlyOqqy58h0
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=perf-sanity-tests
Content-Transfer-Encoding: quoted-printable

2018-05-22 17:39:10 make ARCH=3D -C /usr/src/linux-perf-x86_64-fedora-25-32=
a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/tools/perf
make: Entering directory '/usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89=
ee5e29c0bbdfdd3ae0ce0e01057f/tools/perf'
  BUILD:   Doing 'make =1B[33m-j2=1B[m' parallel build
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep

Auto-detecting system features:
=2E..                         dwarf: [ =1B[32mon=1B[m  ]
=2E..            dwarf_getlocations: [ =1B[32mon=1B[m  ]
=2E..                         glibc: [ =1B[32mon=1B[m  ]
=2E..                          gtk2: [ =1B[31mOFF=1B[m ]
=2E..                      libaudit: [ =1B[32mon=1B[m  ]
=2E..                        libbfd: [ =1B[32mon=1B[m  ]
=2E..                        libelf: [ =1B[32mon=1B[m  ]
=2E..                       libnuma: [ =1B[32mon=1B[m  ]
=2E..        numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
=2E..                       libperl: [ =1B[31mOFF=1B[m ]
=2E..                     libpython: [ =1B[32mon=1B[m  ]
=2E..                      libslang: [ =1B[31mOFF=1B[m ]
=2E..                     libcrypto: [ =1B[31mOFF=1B[m ]
=2E..                     libunwind: [ =1B[32mon=1B[m  ]
=2E..            libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
=2E..                          zlib: [ =1B[32mon=1B[m  ]
=2E..                          lzma: [ =1B[32mon=1B[m  ]
=2E..                     get_cpuid: [ =1B[32mon=1B[m  ]
=2E..                           bpf: [ =1B[32mon=1B[m  ]

  GEN      common-cmds.h
  CC       fd/array.o
  LD       fd/libapi-in.o
  CC       fs/fs.o
  CC       fs/tracing_path.o
  CC       event-parse.o
  LD       fs/libapi-in.o
  CC       cpu.o
  CC       debug.o
  CC       str_error_r.o
  LD       libapi-in.o
  AR       libapi.a
  CC       exec-cmd.o
  CC       help.o
  CC       event-plugin.o
  CC       pager.o
  CC       trace-seq.o
  CC       parse-options.o
  CC       parse-filter.o
  CC       parse-utils.o
  CC       kbuffer-parse.o
  LD       libtraceevent-in.o
  LINK     libtraceevent.a
  CC       libbpf.o
  CC       run-command.o
  CC       bpf.o
  CC       sigchain.o
  CC       nlattr.o
  CC       subcmd-config.o
  LD       libbpf-in.o
  LINK     libbpf.a
  HOSTCC   pmu-events/json.o
  LD       libsubcmd-in.o
  AR       libsubcmd.a
  CC       plugin_jbd2.o
  HOSTCC   pmu-events/jsmn.o
  LD       plugin_jbd2-in.o
  CC       plugin_hrtimer.o
  HOSTCC   pmu-events/jevents.o
  LD       plugin_hrtimer-in.o
  CC       plugin_kmem.o
  LD       plugin_kmem-in.o
  CC       plugin_kvm.o
  HOSTLD   pmu-events/jevents-in.o
  GEN      perf-archive
  GEN      perf-with-kcore
  CC       util/annotate.o
  LD       plugin_kvm-in.o
  CC       plugin_mac80211.o
  LD       plugin_mac80211-in.o
  CC       plugin_sched_switch.o
  LD       plugin_sched_switch-in.o
  CC       plugin_function.o
  LD       plugin_function-in.o
  CC       plugin_xen.o
  LD       plugin_xen-in.o
  CC       plugin_scsi.o
  LD       plugin_scsi-in.o
  CC       plugin_cfg80211.o
  LD       plugin_cfg80211-in.o
  LINK     plugin_jbd2.so
  LINK     plugin_hrtimer.so
  LINK     plugin_kmem.so
  LINK     plugin_kvm.so
  LINK     plugin_mac80211.so
  LINK     plugin_sched_switch.so
  LINK     plugin_function.so
  LINK     plugin_xen.so
  LINK     plugin_scsi.so
  LINK     plugin_cfg80211.so
  CC       builtin-bench.o
  CC       builtin-annotate.o
  CC       builtin-config.o
  CC       builtin-diff.o
  CC       util/block-range.o
  CC       util/build-id.o
  CC       builtin-evlist.o
  CC       builtin-ftrace.o
  CC       util/config.o
  CC       builtin-help.o
  CC       builtin-sched.o
  CC       util/ctype.o
  CC       util/db-export.o
  CC       util/env.o
  CC       util/event.o
  CC       util/evlist.o
  CC       builtin-buildid-list.o
  CC       builtin-buildid-cache.o
  CC       builtin-kallsyms.o
  CC       builtin-list.o
  CC       util/evsel.o
  CC       builtin-record.o
  CC       builtin-report.o
  CC       builtin-stat.o
  CC       util/evsel_fprintf.o
  CC       util/find_bit.o
  CC       util/kallsyms.o
  CC       util/levenshtein.o
  CC       util/llvm-utils.o
  CC       util/mmap.o
  CC       util/memswap.o
  BISON    util/parse-events-bison.c
  CC       builtin-timechart.o
  CC       util/perf_regs.o
  CC       util/path.o
  CC       util/print_binary.o
  CC       util/rbtree.o
  CC       util/libstring.o
  CC       util/bitmap.o
  CC       util/hweight.o
  CC       util/smt.o
  CC       builtin-top.o
  CC       util/quote.o
  CC       util/strbuf.o
  CC       util/string.o
  CC       util/strlist.o
  CC       util/strfilter.o
  CC       builtin-script.o
  CC       util/top.o
  CC       util/usage.o
  CC       util/dso.o
  CC       util/symbol.o
  CC       builtin-kmem.o
  CC       util/symbol_fprintf.o
  CC       util/color.o
  CC       builtin-lock.o
  CC       util/metricgroup.o
  CC       builtin-kvm.o
  CC       util/header.o
  CC       builtin-inject.o
  CC       builtin-mem.o
  CC       builtin-data.o
  CC       builtin-version.o
  CC       builtin-c2c.o
  CC       util/callchain.o
  CC       builtin-trace.o
  CC       util/values.o
  CC       util/debug.o
  CC       util/machine.o
  CC       builtin-probe.o
  CC       bench/sched-messaging.o
  CC       bench/sched-pipe.o
  CC       util/map.o
  CC       bench/mem-functions.o
  CC       bench/futex-hash.o
  CC       bench/futex-wake.o
  CC       util/pstack.o
  CC       bench/futex-wake-parallel.o
  CC       util/session.o
  CC       bench/futex-requeue.o
  CC       bench/futex-lock-pi.o
  CC       bench/mem-memcpy-x86-64-asm.o
  CC       bench/mem-memset-x86-64-asm.o
  CC       bench/numa.o
  CC       util/syscalltbl.o
  CC       util/ordered-events.o
  CC       util/namespaces.o
  LD       bench/perf-in.o
  CC       tests/builtin-test.o
  CC       util/comm.o
  CC       util/thread.o
  CC       tests/parse-events.o
  CC       util/thread_map.o
  CC       util/trace-event-parse.o
  CC       util/parse-events-bison.o
  CC       tests/dso-data.o
  BISON    util/pmu-bison.c
  CC       util/trace-event-read.o
  CC       tests/attr.o
  CC       util/trace-event-info.o
  CC       tests/vmlinux-kallsyms.o
  CC       tests/openat-syscall.o
  CC       util/trace-event-scripting.o
  CC       tests/openat-syscall-all-cpus.o
  CC       util/trace-event.o
  CC       tests/openat-syscall-tp-fields.o
  CC       util/svghelper.o
  CC       tests/mmap-basic.o
  CC       tests/perf-record.o
  CC       util/sort.o
  CC       tests/evsel-roundtrip-name.o
  CC       tests/evsel-tp-sched.o
  CC       tests/fdarray.o
  CC       tests/pmu.o
  CC       tests/hists_common.o
  CC       tests/hists_link.o
  CC       util/hist.o
  CC       tests/hists_filter.o
  CC       tests/hists_output.o
  CC       tests/hists_cumulate.o
  CC       tests/python-use.o
  CC       tests/bp_signal.o
  CC       util/util.o
  CC       tests/bp_signal_overflow.o
  CC       tests/bp_account.o
  CC       util/xyarray.o
  CC       util/cpumap.o
  CC       tests/task-exit.o
  CC       tests/sw-clock.o
  CC       tests/mmap-thread-lookup.o
  CC       util/cgroup.o
  CC       tests/thread-mg-share.o
  CC       tests/switch-tracking.o
  CC       util/target.o
  CC       util/rblist.o
  CC       util/intlist.o
  CC       tests/keep-tracking.o
  CC       util/vdso.o
  CC       tests/code-reading.o
  CC       util/counts.o
  CC       util/stat.o
  CC       tests/sample-parsing.o
  CC       util/stat-shadow.o
  CC       tests/parse-no-sample-id-all.o
  CC       tests/kmod-path.o
  CC       tests/thread-map.o
  CC       tests/llvm.o
  CC       util/record.o
  CC       tests/bpf.o
  CC       util/srcline.o
  CC       tests/topology.o
  CC       tests/mem.o
  CC       util/data.o
  CC       tests/cpumap.o
  CC       util/tsc.o
  CC       util/cloexec.o
  CC       tests/stat.o
  CC       util/call-path.o
  CC       tests/event_update.o
  CC       util/rwsem.o
  CC       util/thread-stack.o
  CC       tests/event-times.o
  CC       tests/expr.o
  CC       util/auxtrace.o
  CC       tests/backward-ring-buffer.o
  CC       tests/sdt.o
  CC       tests/is_printable_array.o
  CC       tests/bitmap.o
  CC       tests/perf-hooks.o
  CC       tests/clang.o
  CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
  CC       tests/unit_number__scnprintf.o
  CC       tests/mem2node.o
  GEN      util/intel-pt-decoder/inat-tables.c
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       tests/dwarf-unwind.o
  CC       util/intel-pt-decoder/intel-pt-decoder.o
  CC       tests/llvm-src-base.o
  CC       tests/llvm-src-kbuild.o
  CC       tests/llvm-src-prologue.o
  CC       tests/llvm-src-relocation.o
  LD       tests/perf-in.o
  CC       perf.o
  LD       perf-in.o
  CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
  LINK     pmu-events/jevents
  GEN      libtraceevent-dynamic-list
  GEN      pmu-events/pmu-events.c
  CC       pmu-events/pmu-events.o
  LD       pmu-events/pmu-events-in.o
  GEN      python/perf.so
  LD       util/intel-pt-decoder/libperf-in.o
  CC       util/scripting-engines/trace-event-python.o
  LD       util/scripting-engines/libperf-in.o
  CC       util/intel-pt.o
  CC       util/intel-bts.o
  CC       util/arm-spe.o
  CC       util/arm-spe-pkt-decoder.o
  CC       util/parse-branch-options.o
  CC       util/dump-insn.o
  CC       util/parse-regs-options.o
  CC       util/term.o
  CC       util/help-unknown-cmd.o
  CC       util/mem-events.o
  CC       util/vsprintf.o
  CC       util/drv_configs.o
  CC       util/units.o
  CC       util/time-utils.o
  BISON    util/expr-bison.c
  CC       util/branch.o
  CC       util/mem2node.o
  CC       util/bpf-loader.o
  CC       util/bpf-prologue.o
  CC       util/symbol-elf.o
  CC       util/probe-file.o
  CC       arch/common.o
  CC       arch/x86/util/header.o
  CC       arch/x86/util/tsc.o
  CC       util/probe-event.o
  CC       arch/x86/util/pmu.o
  CC       arch/x86/util/kvm-stat.o
  CC       arch/x86/util/perf_regs.o
  CC       arch/x86/util/group.o
  CC       arch/x86/util/dwarf-regs.o
  CC       arch/x86/util/unwind-libunwind.o
  CC       arch/x86/util/auxtrace.o
  CC       arch/x86/util/intel-pt.o
  CC       arch/x86/util/intel-bts.o
  CC       util/probe-finder.o
  LD       arch/x86/util/libperf-in.o
  CC       arch/x86/tests/regs_load.o
  CC       arch/x86/tests/dwarf-unwind.o
  CC       arch/x86/tests/arch-tests.o
  CC       arch/x86/tests/rdpmc.o
  CC       arch/x86/tests/perf-time-to-tsc.o
  CC       arch/x86/tests/insn-x86.o
  CC       util/dwarf-aux.o
  LD       arch/x86/tests/libperf-in.o
  LD       arch/x86/libperf-in.o
  LD       arch/libperf-in.o
  CC       ui/setup.o
  CC       ui/helpline.o
  CC       ui/progress.o
  CC       ui/util.o
  CC       util/dwarf-regs.o
  CC       ui/hist.o
  CC       util/unwind-libunwind-local.o
  CC       util/unwind-libunwind.o
  CC       util/zlib.o
  CC       util/lzma.o
  CC       util/demangle-java.o
  CC       util/demangle-rust.o
  CC       util/jitdump.o
  CC       ui/stdio/hist.o
  CC       util/genelf.o
  CC       util/genelf_debug.o
  LD       ui/libperf-in.o
  CC       scripts/python/Perf-Trace-Util/Context.o
  LD       scripts/python/Perf-Trace-Util/libperf-in.o
  LD       scripts/libperf-in.o
  CC       trace/beauty/clone.o
  CC       trace/beauty/fcntl.o
  CC       util/perf-hooks.o
  CC       trace/beauty/flock.o
  CC       trace/beauty/ioctl.o
  FLEX     util/parse-events-flex.c
  FLEX     util/pmu-flex.c
  CC       util/pmu-bison.o
  CC       trace/beauty/kcmp.o
  CC       trace/beauty/pkey_alloc.o
  CC       trace/beauty/prctl.o
  CC       util/expr-bison.o
  CC       trace/beauty/statx.o
  LD       trace/beauty/libperf-in.o
  CC       util/parse-events.o
  CC       util/parse-events-flex.o
  CC       util/pmu.o
  CC       util/pmu-flex.o
  LD       util/libperf-in.o
  LD       libperf-in.o
  AR       libperf.a
  LINK     perf
make: Leaving directory '/usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf'
2018-05-22 17:40:51 cd /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89ee5=
e29c0bbdfdd3ae0ce0e01057f/tools/perf
2018-05-22 17:40:51 mkdir -p /pkg
2018-05-22 17:40:51 mkdir -p /kbuild/obj/lkp/x86_64-fedora-25
2018-05-22 17:40:51 cp /pkg/linux/x86_64-fedora-25/gcc-7/32a4debc7c89ee5e29=
c0bbdfdd3ae0ce0e01057f/vmlinux.xz /tmp
2018-05-22 17:40:53 unxz -k /tmp/vmlinux.xz
2018-05-22 17:41:00 cp /tmp/vmlinux /kbuild/obj/lkp/x86_64-fedora-25
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
ignored_by_lkp: builtin clang support
2018-05-22 17:41:01 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 1
 1: vmlinux symtab matches kallsyms                       : Ok
2018-05-22 17:41:02 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 2
 2: Detect openat syscall event                           : Ok
2018-05-22 17:41:02 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 3
 3: Detect openat syscall event on all cpus               : Ok
2018-05-22 17:41:02 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 4
 4: Read samples using the mmap interface                 : Ok
2018-05-22 17:41:02 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 5
 5: Test data source output                               : Ok
2018-05-22 17:41:02 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 6
 6: Parse event definition strings                        : FAILED!
2018-05-22 17:41:03 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 7
 7: Simple expression parser                              : Ok
2018-05-22 17:41:03 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 8
 8: PERF_RECORD_* events & perf_sample fields             : Ok
2018-05-22 17:41:05 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 9
 9: Parse perf pmu format                                 : Ok
2018-05-22 17:41:05 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 10
10: DSO data read                                         : Ok
2018-05-22 17:41:05 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 11
11: DSO data cache                                        : Ok
2018-05-22 17:41:05 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 12
12: DSO data reopen                                       : Ok
2018-05-22 17:41:05 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 13
13: Roundtrip evsel->name                                 : Ok
2018-05-22 17:41:05 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 14
14: Parse sched tracepoints fields                        : Ok
2018-05-22 17:41:05 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 15
15: syscalls:sys_enter_openat event fields                : Ok
2018-05-22 17:41:05 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 16
16: Setup struct perf_event_attr                          : Ok
2018-05-22 17:41:11 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 17
17: Match and link multiple hists                         : Ok
2018-05-22 17:41:11 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 18
18: 'import perf' in python                               : Ok
2018-05-22 17:41:11 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 19
19: Breakpoint overflow signal handler                    : Ok
2018-05-22 17:41:11 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 20
20: Breakpoint overflow sampling                          : Ok
2018-05-22 17:41:11 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 21
21: Breakpoint accounting                                 : Ok
2018-05-22 17:41:11 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 22
22: Number of exit events of a simple workload            : Skip
2018-05-22 17:41:11 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 23
23: Software clock events period values                   : Ok
2018-05-22 17:41:11 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 24
24: Object code reading                                   : FAILED!
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 25
25: Sample parsing                                        : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 26
26: Use a dummy software event to keep tracking           : Skip
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 27
27: Parse with no sample_id_all bit set                   : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 28
28: Filter hist entries                                   : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 29
29: Lookup mmap thread                                    : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 30
30: Share thread mg                                       : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 31
31: Sort output of hist entries                           : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 32
32: Cumulate child hist entries                           : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 33
33: Track with sched_switch                               : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 34
34: Filter fds with revents mask in a fdarray             : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 35
35: Add fd to a fdarray, making it autogrow               : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 36
36: kmod_path__parse                                      : Ok
2018-05-22 17:41:12 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 37
37: Thread map                                            : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 39
39: Session topology                                      : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 41
41: Synthesize thread map                                 : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 42
42: Remove thread map                                     : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 43
43: Synthesize cpu map                                    : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 44
44: Synthesize stat config                                : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 45
45: Synthesize stat                                       : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 46
46: Synthesize stat round                                 : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 47
47: Synthesize attr update                                : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 48
48: Event times                                           : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 49
49: Read backward ring buffer                             : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 50
50: Print cpu map                                         : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 51
51: Probe SDT events                                      : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 52
52: is_printable_array                                    : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 53
53: Print bitmap                                          : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 54
54: perf hooks                                            : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 56
56: unit_number__scnprintf                                : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 57
57: mem2node                                              : Ok
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 58
58: x86 rdpmc                                             : FAILED!
2018-05-22 17:41:13 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 59
59: Convert perf time to TSC                              : FAILED!
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 60
60: DWARF unwind                                          : Ok
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 61
61: x86 instruction decoder - new instructions            : Ok
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 62
62: probe libc's inet_pton & backtrace it with ping       : FAILED!
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 66
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 67
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 68
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 69
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 70
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 71
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 72
2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89e=
e5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 73

--Wb5NtZlyOqqy58h0--
