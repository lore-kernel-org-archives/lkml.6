Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLACK,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338FEC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343AF20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343AF20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeGVIuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 04:50:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:40091 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbeGVIuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 04:50:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2018 00:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,388,1526367600"; 
   d="xz'?scan'208";a="56904988"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2018 00:52:44 -0700
Date:   Sun, 22 Jul 2018 15:53:24 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>, lkp@01.org
Subject: [lkp-robot] [perf tools]  600b7378cf:
 perf-sanity-tests.Share_thread_mg.fail
Message-ID: <20180722075323.GB23613@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20180712142023.16915-3-jolsa@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


FYI, we noticed the following commit (built with gcc-7):

commit: 600b7378cf43f522e88027874f11f63b6fbf53d8 ("[PATCH 2/4] perf tools: =
Add threads__get_last_match function")
url: https://github.com/0day-ci/linux/commits/Jiri-Olsa/perf-tools-Fix-top-=
crashes/20180714-075809


in testcase: perf-sanity-tests
with following parameters:

	perf_compiler: gcc



on test machine: qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3 -smp 2 -m=
 8G

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




2018-07-16 20:49:07 make ARCH=3D -C /usr/src/linux-perf-x86_64-randconfig-s=
5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf
make: Entering directory '/usr/src/linux-perf-x86_64-randconfig-s5-07160434=
-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf'
  BUILD:   Doing 'make =1B[33m-j1=1B[m' parallel build
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
  CC       util/annotate.o
  CC       util/block-range.o
  CC       util/build-id.o
  CC       util/config.o
  CC       util/ctype.o
  CC       util/db-export.o
  CC       util/env.o
  CC       util/event.o
  CC       util/evlist.o
  CC       util/evsel.o
  CC       util/evsel_fprintf.o
  CC       util/find_bit.o
  CC       util/kallsyms.o
  CC       util/levenshtein.o
  CC       util/llvm-utils.o
  CC       util/mmap.o
  CC       util/memswap.o
  BISON    util/parse-events-bison.c
  FLEX     util/parse-events-flex.c
  CC       util/parse-events.o
  CC       util/perf_regs.o
  CC       util/path.o
  CC       util/print_binary.o
  CC       util/rbtree.o
  CC       util/libstring.o
  CC       util/bitmap.o
  CC       util/hweight.o
  CC       util/smt.o
  CC       util/strbuf.o
  CC       util/string.o
  CC       util/strlist.o
  CC       util/strfilter.o
  CC       util/top.o
  CC       util/usage.o
  CC       util/dso.o
  CC       util/symbol.o
  CC       util/symbol_fprintf.o
  CC       util/color.o
  CC       util/metricgroup.o
  CC       util/header.o
  CC       util/callchain.o
  CC       util/values.o
  CC       util/debug.o
  CC       util/machine.o
  CC       util/map.o
  CC       util/pstack.o
  CC       util/session.o
  CC       util/syscalltbl.o
  CC       util/ordered-events.o
  CC       util/namespaces.o
  CC       util/comm.o
  CC       util/thread.o
  CC       util/thread_map.o
  CC       util/trace-event-parse.o
  CC       util/parse-events-flex.o
  CC       util/parse-events-bison.o
  BISON    util/pmu-bison.c
  FLEX     util/pmu-flex.c
  CC       util/pmu.o
  CC       util/pmu-flex.o
  CC       util/pmu-bison.o
  CC       util/trace-event-read.o
  CC       util/trace-event-info.o
  CC       util/trace-event-scripting.o
  CC       util/trace-event.o
  CC       util/svghelper.o
  CC       util/sort.o
  CC       util/hist.o
  CC       util/util.o
  CC       util/xyarray.o
  CC       util/cpumap.o
  CC       util/cgroup.o
  CC       util/target.o
  CC       util/rblist.o
  CC       util/intlist.o
  CC       util/vdso.o
  CC       util/counts.o
  CC       util/stat.o
  CC       util/stat-shadow.o
  CC       util/record.o
  CC       util/srcline.o
  CC       util/data.o
  CC       util/tsc.o
  CC       util/cloexec.o
  CC       util/call-path.o
  CC       util/rwsem.o
  CC       util/thread-stack.o
  CC       util/auxtrace.o
  CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN      util/intel-pt-decoder/inat-tables.c
  CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/intel-pt-decoder/intel-pt-decoder.o
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
  CC       util/expr-bison.o
  CC       util/branch.o
  CC       util/mem2node.o
  CC       util/bpf-loader.o
  CC       util/bpf-prologue.o
  CC       util/symbol-elf.o
  CC       util/probe-file.o
  CC       util/probe-event.o
  CC       util/probe-finder.o
  CC       util/dwarf-aux.o
  CC       util/dwarf-regs.o
  CC       util/unwind-libunwind-local.o
  CC       util/unwind-libunwind.o
  CC       util/zlib.o
  CC       util/lzma.o
  CC       util/demangle-java.o
  CC       util/demangle-rust.o
  CC       util/jitdump.o
  CC       util/genelf.o
  CC       util/genelf_debug.o
  CC       util/perf-hooks.o
  LD       util/libperf-in.o
  CC       arch/common.o
  CC       arch/x86/util/header.o
  CC       arch/x86/util/tsc.o
  CC       arch/x86/util/pmu.o
  CC       arch/x86/util/kvm-stat.o
  CC       arch/x86/util/perf_regs.o
  CC       arch/x86/util/group.o
  CC       arch/x86/util/machine.o
  CC       arch/x86/util/event.o
  CC       arch/x86/util/dwarf-regs.o
  CC       arch/x86/util/unwind-libunwind.o
  CC       arch/x86/util/auxtrace.o
  CC       arch/x86/util/intel-pt.o
  CC       arch/x86/util/intel-bts.o
  LD       arch/x86/util/libperf-in.o
  CC       arch/x86/tests/regs_load.o
  CC       arch/x86/tests/dwarf-unwind.o
  CC       arch/x86/tests/arch-tests.o
  CC       arch/x86/tests/rdpmc.o
  CC       arch/x86/tests/perf-time-to-tsc.o
  CC       arch/x86/tests/insn-x86.o
  LD       arch/x86/tests/libperf-in.o
  LD       arch/x86/libperf-in.o
  LD       arch/libperf-in.o
  CC       ui/setup.o
  CC       ui/helpline.o
  CC       ui/progress.o
  CC       ui/util.o
  CC       ui/hist.o
  CC       ui/stdio/hist.o
  LD       ui/libperf-in.o
  CC       scripts/python/Perf-Trace-Util/Context.o
  LD       scripts/python/Perf-Trace-Util/libperf-in.o
  LD       scripts/libperf-in.o
  CC       trace/beauty/clone.o
  CC       trace/beauty/fcntl.o
  CC       trace/beauty/flock.o
  CC       trace/beauty/ioctl.o
  CC       trace/beauty/kcmp.o
  CC       trace/beauty/pkey_alloc.o
  CC       trace/beauty/prctl.o
  CC       trace/beauty/statx.o
  LD       trace/beauty/libperf-in.o
  LD       libperf-in.o
  AR       libperf.a
  CC       fd/array.o
  LD       fd/libapi-in.o
  CC       fs/fs.o
  CC       fs/tracing_path.o
  LD       fs/libapi-in.o
  CC       cpu.o
  CC       debug.o
  CC       str_error_r.o
  LD       libapi-in.o
  AR       libapi.a
  CC       event-parse.o
  CC       event-plugin.o
  CC       trace-seq.o
  CC       parse-filter.o
  CC       parse-utils.o
  CC       kbuffer-parse.o
  LD       libtraceevent-in.o
  LINK     libtraceevent.a
  CC       exec-cmd.o
  CC       help.o
  CC       pager.o
  CC       parse-options.o
  CC       run-command.o
  CC       sigchain.o
  CC       subcmd-config.o
  LD       libsubcmd-in.o
  AR       libsubcmd.a
  CC       libbpf.o
  CC       bpf.o
  CC       nlattr.o
  CC       btf.o
  LD       libbpf-in.o
  LINK     libbpf.a
  CC       builtin-bench.o
  CC       builtin-annotate.o
  CC       builtin-config.o
  CC       builtin-diff.o
  CC       builtin-evlist.o
  CC       builtin-ftrace.o
  CC       builtin-help.o
  CC       builtin-sched.o
  CC       builtin-buildid-list.o
  CC       builtin-buildid-cache.o
  CC       builtin-kallsyms.o
  CC       builtin-list.o
  CC       builtin-record.o
  CC       builtin-report.o
  CC       builtin-stat.o
  CC       builtin-timechart.o
  CC       builtin-top.o
  CC       builtin-script.o
  CC       builtin-kmem.o
  CC       builtin-lock.o
  CC       builtin-kvm.o
  CC       builtin-inject.o
  CC       builtin-mem.o
  CC       builtin-data.o
  CC       builtin-version.o
  CC       builtin-c2c.o
  CC       builtin-trace.o
  CC       builtin-probe.o
  CC       bench/sched-messaging.o
  CC       bench/sched-pipe.o
  CC       bench/mem-functions.o
  CC       bench/futex-hash.o
  CC       bench/futex-wake.o
  CC       bench/futex-wake-parallel.o
  CC       bench/futex-requeue.o
  CC       bench/futex-lock-pi.o
  CC       bench/mem-memcpy-x86-64-asm.o
  CC       bench/mem-memset-x86-64-asm.o
  CC       bench/numa.o
  LD       bench/perf-in.o
  CC       tests/builtin-test.o
  CC       tests/parse-events.o
  CC       tests/dso-data.o
  CC       tests/attr.o
  CC       tests/vmlinux-kallsyms.o
  CC       tests/openat-syscall.o
  CC       tests/openat-syscall-all-cpus.o
  CC       tests/openat-syscall-tp-fields.o
  CC       tests/mmap-basic.o
  CC       tests/perf-record.o
  CC       tests/evsel-roundtrip-name.o
  CC       tests/evsel-tp-sched.o
  CC       tests/fdarray.o
  CC       tests/pmu.o
  CC       tests/hists_common.o
  CC       tests/hists_link.o
  CC       tests/hists_filter.o
  CC       tests/hists_output.o
  CC       tests/hists_cumulate.o
  CC       tests/python-use.o
  CC       tests/bp_signal.o
  CC       tests/bp_signal_overflow.o
  CC       tests/bp_account.o
  CC       tests/task-exit.o
  CC       tests/sw-clock.o
  CC       tests/mmap-thread-lookup.o
  CC       tests/thread-mg-share.o
  CC       tests/switch-tracking.o
  CC       tests/keep-tracking.o
  CC       tests/code-reading.o
  CC       tests/sample-parsing.o
  CC       tests/parse-no-sample-id-all.o
  CC       tests/kmod-path.o
  CC       tests/thread-map.o
  CC       tests/llvm.o
  CC       tests/llvm-src-base.o
  CC       tests/llvm-src-kbuild.o
  CC       tests/llvm-src-prologue.o
  CC       tests/llvm-src-relocation.o
  CC       tests/bpf.o
  CC       tests/topology.o
  CC       tests/mem.o
  CC       tests/cpumap.o
  CC       tests/stat.o
  CC       tests/event_update.o
  CC       tests/event-times.o
  CC       tests/expr.o
  CC       tests/backward-ring-buffer.o
  CC       tests/sdt.o
  CC       tests/is_printable_array.o
  CC       tests/bitmap.o
  CC       tests/perf-hooks.o
  CC       tests/clang.o
  CC       tests/unit_number__scnprintf.o
  CC       tests/mem2node.o
  CC       tests/dwarf-unwind.o
  LD       tests/perf-in.o
  CC       perf.o
  LD       perf-in.o
  HOSTCC   pmu-events/json.o
  HOSTCC   pmu-events/jsmn.o
  HOSTCC   pmu-events/jevents.o
  HOSTLD   pmu-events/jevents-in.o
  LINK     pmu-events/jevents
  GEN      pmu-events/pmu-events.c
  CC       pmu-events/pmu-events.o
  LD       pmu-events/pmu-events-in.o
  CC       plugin_jbd2.o
  LD       plugin_jbd2-in.o
  LINK     plugin_jbd2.so
  CC       plugin_hrtimer.o
  LD       plugin_hrtimer-in.o
  LINK     plugin_hrtimer.so
  CC       plugin_kmem.o
  LD       plugin_kmem-in.o
  LINK     plugin_kmem.so
  CC       plugin_kvm.o
  LD       plugin_kvm-in.o
  LINK     plugin_kvm.so
  CC       plugin_mac80211.o
  LD       plugin_mac80211-in.o
  LINK     plugin_mac80211.so
  CC       plugin_sched_switch.o
  LD       plugin_sched_switch-in.o
  LINK     plugin_sched_switch.so
  CC       plugin_function.o
  LD       plugin_function-in.o
  LINK     plugin_function.so
  CC       plugin_xen.o
  LD       plugin_xen-in.o
  LINK     plugin_xen.so
  CC       plugin_scsi.o
  LD       plugin_scsi-in.o
  LINK     plugin_scsi.so
  CC       plugin_cfg80211.o
  LD       plugin_cfg80211-in.o
  LINK     plugin_cfg80211.so
  GEN      libtraceevent-dynamic-list
  LINK     perf
  GEN      perf-archive
  GEN      perf-with-kcore
  GEN      python/perf.so
make: Leaving directory '/usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf'
2018-07-16 20:55:35 cd /usr/src/linux-perf-x86_64-randconfig-s5-07160434-60=
0b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf
2018-07-16 20:55:35 mkdir -p /pkg
2018-07-16 20:55:36 mkdir -p /kbuild/obj/consumer/x86_64-randconfig-s5-0716=
0434
2018-07-16 20:55:36 cp /pkg/linux/x86_64-randconfig-s5-07160434/gcc-7/600b7=
378cf43f522e88027874f11f63b6fbf53d8/vmlinux.xz /tmp
2018-07-16 20:55:37 unxz -k /tmp/vmlinux.xz
2018-07-16 20:55:40 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-randconfig-=
s5-07160434
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
ignored_by_lkp: builtin clang support
2018-07-16 20:55:41 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 1
 1: vmlinux symtab matches kallsyms                       : Ok
2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 2
 2: Detect openat syscall event                           : FAILED!
2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 3
 3: Detect openat syscall event on all cpus               : FAILED!
2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 4
 4: Read samples using the mmap interface                 : FAILED!
2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 5
 5: Test data source output                               : Ok
2018-07-16 20:55:44 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 6
 6: Parse event definition strings                        : FAILED!
2018-07-16 20:55:44 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 7
 7: Simple expression parser                              : Ok
2018-07-16 20:55:44 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 8
 8: PERF_RECORD_* events & perf_sample fields             : Ok
2018-07-16 20:55:46 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 9
 9: Parse perf pmu format                                 : Ok
2018-07-16 20:55:46 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 10
10: DSO data read                                         : Ok
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 11
11: DSO data cache                                        : Ok
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 12
12: DSO data reopen                                       : Ok
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 13
13: Roundtrip evsel->name                                 : Ok
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 14
14: Parse sched tracepoints fields                        : FAILED!
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 15
15: syscalls:sys_enter_openat event fields                : FAILED!
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 16
16: Setup struct perf_event_attr                          : Ok
2018-07-16 20:56:01 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 17
17: Match and link multiple hists                         : Ok
2018-07-16 20:56:02 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 18
18: 'import perf' in python                               : Ok
2018-07-16 20:56:02 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 19
19: Breakpoint overflow signal handler                    : Ok
2018-07-16 20:56:02 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 20
20: Breakpoint overflow sampling                          : Ok
2018-07-16 20:56:03 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 21
21: Breakpoint accounting                                 : Skip
2018-07-16 20:56:03 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 22
22: Number of exit events of a simple workload            : Skip
2018-07-16 20:56:03 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 23
23: Software clock events period values                   : Ok
2018-07-16 20:56:03 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 24
24: Object code reading                                   : FAILED!
2018-07-16 20:56:04 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 25
25: Sample parsing                                        : Ok
2018-07-16 20:56:05 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 26
26: Use a dummy software event to keep tracking           : Skip
2018-07-16 20:56:05 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 27
27: Parse with no sample_id_all bit set                   : Ok
2018-07-16 20:56:05 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 28
28: Filter hist entries                                   : Ok
2018-07-16 20:56:05 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 29
29: Lookup mmap thread                                    : Ok
2018-07-16 20:56:06 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 30
30: Share thread mg                                       : FAILED!
2018-07-16 20:56:06 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 31
31: Sort output of hist entries                           : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 32
32: Cumulate child hist entries                           : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 33
33: Track with sched_switch                               : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 34
34: Filter fds with revents mask in a fdarray             : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 35
35: Add fd to a fdarray, making it autogrow               : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 36
36: kmod_path__parse                                      : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 37
37: Thread map                                            : Ok
2018-07-16 20:56:08 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 39
39: Session topology                                      : Ok
2018-07-16 20:56:08 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 41
41: Synthesize thread map                                 : Ok
2018-07-16 20:56:08 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 42
42: Remove thread map                                     : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 43
43: Synthesize cpu map                                    : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 44
44: Synthesize stat config                                : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 45
45: Synthesize stat                                       : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 46
46: Synthesize stat round                                 : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 47
47: Synthesize attr update                                : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 48
48: Event times                                           : FAILED!
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 49
49: Read backward ring buffer                             : Skip
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 50
50: Print cpu map                                         : Ok
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 51
51: Probe SDT events                                      : Ok
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 52
52: is_printable_array                                    : Ok
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 53
53: Print bitmap                                          : Ok
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 54
54: perf hooks                                            : Ok
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 56
56: unit_number__scnprintf                                : Ok
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 57
57: mem2node                                              : Ok
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 58
58: x86 rdpmc                                             : FAILED!
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 59
59: Convert perf time to TSC                              : FAILED!
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 60
60: DWARF unwind                                          : Ok
2018-07-16 20:56:12 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 61
61: x86 instruction decoder - new instructions            : Ok
2018-07-16 20:56:12 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 62
62: probe libc's inet_pton & backtrace it with ping       : FAILED!
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 66
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 67
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 68
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 69
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 70
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 71
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 72
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 73



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in th=
is email



Thanks,
Rong, Chen

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.18.0-rc2-00091-g600b737"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.18.0-rc2 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
# CONFIG_ACORN_PARTITION_ICS is not set
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MQ_IOSCHED_DEADLINE=m
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=m
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=m
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_DEVICE_PUBLIC=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_INTEL_UMIP is not set
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_VERIFY_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=m
CONFIG_X86_X32=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=m
CONFIG_MTD_TESTS=m
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=m
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
CONFIG_SSFDC=m
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=m
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC=m
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=m
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_NAND_DOCG4=m
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_PLATFORM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_VIRTIO_BLK_SCSI=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=y
# CONFIG_NVME_TARGET_FCLOOP is not set

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=m
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=y
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
CONFIG_ECHO=m
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_ENCLOSURE is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
CONFIG_SATA_DWC=m
CONFIG_SATA_DWC_OLD_DMA=y
CONFIG_SATA_DWC_DEBUG=y
CONFIG_SATA_DWC_VDEBUG=y
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PLATFORM=y
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
CONFIG_KEYBOARD_ADP5520=y
CONFIG_KEYBOARD_ADP5588=y
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=m
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=m
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_TWL4030 is not set
CONFIG_KEYBOARD_XTKBD=m
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=m
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=m
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=m
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=m
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
# CONFIG_IPMI_SI is not set
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_NVRAM is not set
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_MUX_MLXCPLD is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=m
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_MAX8925_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=m
CONFIG_BATTERY_TWL4030_MADC=m
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_BATTERY_RX51=m
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_CHARGER_RT9455=y
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=m
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
CONFIG_MFD_CROS_EC_CHARDEV=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=m
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
# CONFIG_IR_RC6_DECODER is not set
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_RC_DEVICES is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SOC=m
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=m
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_SSI=m
# CONFIG_SND_SOC_FSL_SPDIF is not set
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_IMX_AUDMUX=m
# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
# CONFIG_SND_SOC_INTEL_HASWELL is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XTFPGA_I2S=m
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU1701=m
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=m
CONFIG_SND_SOC_AK5558=m
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_BD28623=m
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
# CONFIG_SND_SOC_CS35L35 is not set
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=m
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4265=m
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4349 is not set
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DIO2125=m
# CONFIG_SND_SOC_ES7134 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
# CONFIG_SND_SOC_MAX9867 is not set
# CONFIG_SND_SOC_MAX98927 is not set
CONFIG_SND_SOC_MAX98373=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
# CONFIG_SND_SOC_PCM3168A_I2C is not set
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2305=m
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS6424=m
# CONFIG_SND_SOC_TDA7419 is not set
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
# CONFIG_SND_SOC_WM8804_I2C is not set
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_ZX_AUD96P22=m
# CONFIG_SND_SOC_MAX9759 is not set
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_NAU8540=m
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=m
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=m
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
CONFIG_I2C_HID=y

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_PWM=m
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_LP8788 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8925=m
CONFIG_RTC_DRV_MAX8998=y
# CONFIG_RTC_DRV_MAX8997 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_TPS80031 is not set
# CONFIG_RTC_DRV_RC5T583 is not set
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=m
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_AB3100=y
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_MT6397=y

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD=m
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#
CONFIG_AD7606=m
# CONFIG_AD7606_IFACE_PARALLEL is not set

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_I2C=y

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7152=m
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#

#
# Digital gyroscope sensors
#

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Active energy metering IC
#
CONFIG_ADE7854=m
CONFIG_ADE7854_I2C=m

#
# Resolver to digital converters
#

#
# Speakup console speech
#
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
CONFIG_ASHMEM=y
# CONFIG_ION is not set
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
CONFIG_CRYPTO_SKEIN=y
CONFIG_UNISYSSPAR=y
CONFIG_MOST=y
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
# CONFIG_MOST_SOUND is not set
# CONFIG_MOST_I2C is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_MTK_MMC=m
# CONFIG_MTK_AEE_KDUMP is not set
# CONFIG_MTK_MMC_CD_POLL is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_CTL=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_ARIZONA is not set
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADXL345_I2C is not set
CONFIG_BMA180=y
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_DA280=y
CONFIG_DA311=m
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_STK8312=m
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7291=m
# CONFIG_AD799X is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
# CONFIG_LP8788_ADC is not set
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=m
CONFIG_NAU7802=m
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADS1015 is not set
CONFIG_TWL4030_MADC=y
CONFIG_TWL6030_GPADC=y

#
# Analog Front Ends
#

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_CCS811=m
# CONFIG_IAQCORE is not set
CONFIG_VZ89X=y
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
# CONFIG_IIO_CROS_EC_SENSORS is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#
# CONFIG_104_QUAD_8 is not set

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5380=y
CONFIG_AD5446=m
# CONFIG_AD5593R is not set
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_CIO_DAC=y
CONFIG_DS4424=y
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=y

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=y
CONFIG_IIO_SIMPLE_DUMMY=y
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_IIO_ST_LSM6DSX is not set

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=m
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM36651=m
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
CONFIG_GP2AP020A00F=m
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=y
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_SI1145=m
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=m
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Multiplexers
#

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MCP4018=m
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=m
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=y
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=m
CONFIG_SRF04=m
# CONFIG_SX9500 is not set
CONFIG_SRF08=y

#
# Resolver to digital converters
#

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=m
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=m
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
CONFIG_PWM_TWL=m
# CONFIG_PWM_TWL_LED is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
# CONFIG_ND_BLK is not set
CONFIG_ND_CLAIM=y
# CONFIG_BTT is not set
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
# CONFIG_NVMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=m
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FS_ENCRYPTION is not set
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=m
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_GDB_SCRIPTS=y
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
CONFIG_CRYPTO_MORUS640=y
CONFIG_CRYPTO_MORUS640_GLUE=m
CONFIG_CRYPTO_MORUS640_SSE2=m
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_MORUS1280_GLUE=m
CONFIG_CRYPTO_MORUS1280_SSE2=m
CONFIG_CRYPTO_MORUS1280_AVX2=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=m
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA1_MB=m
# CONFIG_CRYPTO_SHA256_MB is not set
# CONFIG_CRYPTO_SHA512_MB is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=m
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='perf-sanity-tests'
	export testcase='perf-sanity-tests'
	export category='functional'
	export job_origin='/lkp/lkp/src/allot/rand/vm-lkp-nex04-8G/perf-sanity-tests.yaml'
	export testbox='vm-lkp-nex04-8G-10'
	export tbox_group='vm-lkp-nex04-8G'
	export kconfig='x86_64-randconfig-s5-07160434'
	export compiler='gcc-7'
	export queue='bisect'
	export branch='linux-devel/devel-hourly-2018071523'
	export commit='600b7378cf43f522e88027874f11f63b6fbf53d8'
	export submit_id='5b4c90700b9a93da51399a7c'
	export job_file='/lkp/scheduled/vm-lkp-nex04-8G-10/perf-sanity-tests-gcc-debian-x86_64-2018-04-03.cgz-600b7378cf43f522e88027874f11f63b6fbf53d8-20180716-55889-6bi015-0.yaml'
	export id='6b4b545b02e840528bb3f02212ce8353e0117871'
	export model='qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3'
	export nr_vm=10
	export nr_cpu=2
	export memory='8G'
	export hdd_partitions='/dev/vda'
	export need_linux_perf=true
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export ssh_base_port=23250
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2018-07-16 20:32:48 +0800'
	export _id='5b4c90700b9a93da51399a7c'
	export _rt='/result/perf-sanity-tests/gcc/vm-lkp-nex04-8G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-s5-07160434/gcc-7/600b7378cf43f522e88027874f11f63b6fbf53d8'
	export user='lkp'
	export result_root='/result/perf-sanity-tests/gcc/vm-lkp-nex04-8G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-s5-07160434/gcc-7/600b7378cf43f522e88027874f11f63b6fbf53d8/0'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/scheduled/vm-lkp-nex04-8G-10/perf-sanity-tests-gcc-debian-x86_64-2018-04-03.cgz-600b7378cf43f522e88027874f11f63b6fbf53d8-20180716-55889-6bi015-0.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-s5-07160434
branch=linux-devel/devel-hourly-2018071523
commit=600b7378cf43f522e88027874f11f63b6fbf53d8
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-07160434/gcc-7/600b7378cf43f522e88027874f11f63b6fbf53d8/vmlinuz-4.18.0-rc2-00091-g600b737
max_uptime=3600
RESULT_ROOT=/result/perf-sanity-tests/gcc/vm-lkp-nex04-8G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-s5-07160434/gcc-7/600b7378cf43f522e88027874f11f63b6fbf53d8/0
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-s5-07160434/gcc-7/600b7378cf43f522e88027874f11f63b6fbf53d8/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf-sanity-tests_2018-05-18.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-6f0d349d922b_2018-06-26.cgz'
	export linux_perf_initrd='/pkg/linux/x86_64-randconfig-s5-07160434/gcc-7/600b7378cf43f522e88027874f11f63b6fbf53d8/linux-perf.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export kernel='/pkg/linux/x86_64-randconfig-s5-07160434/gcc-7/600b7378cf43f522e88027874f11f63b6fbf53d8/vmlinuz-4.18.0-rc2-00091-g600b737'
	export dequeue_time='2018-07-16 20:47:14 +0800'
	export job_initrd='/lkp/scheduled/vm-lkp-nex04-8G-10/perf-sanity-tests-gcc-debian-x86_64-2018-04-03.cgz-600b7378cf43f522e88027874f11f63b6fbf53d8-20180716-55889-6bi015-0.cgz'

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

--A6N2fC+uXW/VQSAv
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=perf-sanity-tests
Content-Transfer-Encoding: quoted-printable

2018-07-16 20:49:07 make ARCH=3D -C /usr/src/linux-perf-x86_64-randconfig-s=
5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf
make: Entering directory '/usr/src/linux-perf-x86_64-randconfig-s5-07160434=
-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf'
  BUILD:   Doing 'make =1B[33m-j1=1B[m' parallel build
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
  CC       util/annotate.o
  CC       util/block-range.o
  CC       util/build-id.o
  CC       util/config.o
  CC       util/ctype.o
  CC       util/db-export.o
  CC       util/env.o
  CC       util/event.o
  CC       util/evlist.o
  CC       util/evsel.o
  CC       util/evsel_fprintf.o
  CC       util/find_bit.o
  CC       util/kallsyms.o
  CC       util/levenshtein.o
  CC       util/llvm-utils.o
  CC       util/mmap.o
  CC       util/memswap.o
  BISON    util/parse-events-bison.c
  FLEX     util/parse-events-flex.c
  CC       util/parse-events.o
  CC       util/perf_regs.o
  CC       util/path.o
  CC       util/print_binary.o
  CC       util/rbtree.o
  CC       util/libstring.o
  CC       util/bitmap.o
  CC       util/hweight.o
  CC       util/smt.o
  CC       util/strbuf.o
  CC       util/string.o
  CC       util/strlist.o
  CC       util/strfilter.o
  CC       util/top.o
  CC       util/usage.o
  CC       util/dso.o
  CC       util/symbol.o
  CC       util/symbol_fprintf.o
  CC       util/color.o
  CC       util/metricgroup.o
  CC       util/header.o
  CC       util/callchain.o
  CC       util/values.o
  CC       util/debug.o
  CC       util/machine.o
  CC       util/map.o
  CC       util/pstack.o
  CC       util/session.o
  CC       util/syscalltbl.o
  CC       util/ordered-events.o
  CC       util/namespaces.o
  CC       util/comm.o
  CC       util/thread.o
  CC       util/thread_map.o
  CC       util/trace-event-parse.o
  CC       util/parse-events-flex.o
  CC       util/parse-events-bison.o
  BISON    util/pmu-bison.c
  FLEX     util/pmu-flex.c
  CC       util/pmu.o
  CC       util/pmu-flex.o
  CC       util/pmu-bison.o
  CC       util/trace-event-read.o
  CC       util/trace-event-info.o
  CC       util/trace-event-scripting.o
  CC       util/trace-event.o
  CC       util/svghelper.o
  CC       util/sort.o
  CC       util/hist.o
  CC       util/util.o
  CC       util/xyarray.o
  CC       util/cpumap.o
  CC       util/cgroup.o
  CC       util/target.o
  CC       util/rblist.o
  CC       util/intlist.o
  CC       util/vdso.o
  CC       util/counts.o
  CC       util/stat.o
  CC       util/stat-shadow.o
  CC       util/record.o
  CC       util/srcline.o
  CC       util/data.o
  CC       util/tsc.o
  CC       util/cloexec.o
  CC       util/call-path.o
  CC       util/rwsem.o
  CC       util/thread-stack.o
  CC       util/auxtrace.o
  CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN      util/intel-pt-decoder/inat-tables.c
  CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/intel-pt-decoder/intel-pt-decoder.o
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
  CC       util/expr-bison.o
  CC       util/branch.o
  CC       util/mem2node.o
  CC       util/bpf-loader.o
  CC       util/bpf-prologue.o
  CC       util/symbol-elf.o
  CC       util/probe-file.o
  CC       util/probe-event.o
  CC       util/probe-finder.o
  CC       util/dwarf-aux.o
  CC       util/dwarf-regs.o
  CC       util/unwind-libunwind-local.o
  CC       util/unwind-libunwind.o
  CC       util/zlib.o
  CC       util/lzma.o
  CC       util/demangle-java.o
  CC       util/demangle-rust.o
  CC       util/jitdump.o
  CC       util/genelf.o
  CC       util/genelf_debug.o
  CC       util/perf-hooks.o
  LD       util/libperf-in.o
  CC       arch/common.o
  CC       arch/x86/util/header.o
  CC       arch/x86/util/tsc.o
  CC       arch/x86/util/pmu.o
  CC       arch/x86/util/kvm-stat.o
  CC       arch/x86/util/perf_regs.o
  CC       arch/x86/util/group.o
  CC       arch/x86/util/machine.o
  CC       arch/x86/util/event.o
  CC       arch/x86/util/dwarf-regs.o
  CC       arch/x86/util/unwind-libunwind.o
  CC       arch/x86/util/auxtrace.o
  CC       arch/x86/util/intel-pt.o
  CC       arch/x86/util/intel-bts.o
  LD       arch/x86/util/libperf-in.o
  CC       arch/x86/tests/regs_load.o
  CC       arch/x86/tests/dwarf-unwind.o
  CC       arch/x86/tests/arch-tests.o
  CC       arch/x86/tests/rdpmc.o
  CC       arch/x86/tests/perf-time-to-tsc.o
  CC       arch/x86/tests/insn-x86.o
  LD       arch/x86/tests/libperf-in.o
  LD       arch/x86/libperf-in.o
  LD       arch/libperf-in.o
  CC       ui/setup.o
  CC       ui/helpline.o
  CC       ui/progress.o
  CC       ui/util.o
  CC       ui/hist.o
  CC       ui/stdio/hist.o
  LD       ui/libperf-in.o
  CC       scripts/python/Perf-Trace-Util/Context.o
  LD       scripts/python/Perf-Trace-Util/libperf-in.o
  LD       scripts/libperf-in.o
  CC       trace/beauty/clone.o
  CC       trace/beauty/fcntl.o
  CC       trace/beauty/flock.o
  CC       trace/beauty/ioctl.o
  CC       trace/beauty/kcmp.o
  CC       trace/beauty/pkey_alloc.o
  CC       trace/beauty/prctl.o
  CC       trace/beauty/statx.o
  LD       trace/beauty/libperf-in.o
  LD       libperf-in.o
  AR       libperf.a
  CC       fd/array.o
  LD       fd/libapi-in.o
  CC       fs/fs.o
  CC       fs/tracing_path.o
  LD       fs/libapi-in.o
  CC       cpu.o
  CC       debug.o
  CC       str_error_r.o
  LD       libapi-in.o
  AR       libapi.a
  CC       event-parse.o
  CC       event-plugin.o
  CC       trace-seq.o
  CC       parse-filter.o
  CC       parse-utils.o
  CC       kbuffer-parse.o
  LD       libtraceevent-in.o
  LINK     libtraceevent.a
  CC       exec-cmd.o
  CC       help.o
  CC       pager.o
  CC       parse-options.o
  CC       run-command.o
  CC       sigchain.o
  CC       subcmd-config.o
  LD       libsubcmd-in.o
  AR       libsubcmd.a
  CC       libbpf.o
  CC       bpf.o
  CC       nlattr.o
  CC       btf.o
  LD       libbpf-in.o
  LINK     libbpf.a
  CC       builtin-bench.o
  CC       builtin-annotate.o
  CC       builtin-config.o
  CC       builtin-diff.o
  CC       builtin-evlist.o
  CC       builtin-ftrace.o
  CC       builtin-help.o
  CC       builtin-sched.o
  CC       builtin-buildid-list.o
  CC       builtin-buildid-cache.o
  CC       builtin-kallsyms.o
  CC       builtin-list.o
  CC       builtin-record.o
  CC       builtin-report.o
  CC       builtin-stat.o
  CC       builtin-timechart.o
  CC       builtin-top.o
  CC       builtin-script.o
  CC       builtin-kmem.o
  CC       builtin-lock.o
  CC       builtin-kvm.o
  CC       builtin-inject.o
  CC       builtin-mem.o
  CC       builtin-data.o
  CC       builtin-version.o
  CC       builtin-c2c.o
  CC       builtin-trace.o
  CC       builtin-probe.o
  CC       bench/sched-messaging.o
  CC       bench/sched-pipe.o
  CC       bench/mem-functions.o
  CC       bench/futex-hash.o
  CC       bench/futex-wake.o
  CC       bench/futex-wake-parallel.o
  CC       bench/futex-requeue.o
  CC       bench/futex-lock-pi.o
  CC       bench/mem-memcpy-x86-64-asm.o
  CC       bench/mem-memset-x86-64-asm.o
  CC       bench/numa.o
  LD       bench/perf-in.o
  CC       tests/builtin-test.o
  CC       tests/parse-events.o
  CC       tests/dso-data.o
  CC       tests/attr.o
  CC       tests/vmlinux-kallsyms.o
  CC       tests/openat-syscall.o
  CC       tests/openat-syscall-all-cpus.o
  CC       tests/openat-syscall-tp-fields.o
  CC       tests/mmap-basic.o
  CC       tests/perf-record.o
  CC       tests/evsel-roundtrip-name.o
  CC       tests/evsel-tp-sched.o
  CC       tests/fdarray.o
  CC       tests/pmu.o
  CC       tests/hists_common.o
  CC       tests/hists_link.o
  CC       tests/hists_filter.o
  CC       tests/hists_output.o
  CC       tests/hists_cumulate.o
  CC       tests/python-use.o
  CC       tests/bp_signal.o
  CC       tests/bp_signal_overflow.o
  CC       tests/bp_account.o
  CC       tests/task-exit.o
  CC       tests/sw-clock.o
  CC       tests/mmap-thread-lookup.o
  CC       tests/thread-mg-share.o
  CC       tests/switch-tracking.o
  CC       tests/keep-tracking.o
  CC       tests/code-reading.o
  CC       tests/sample-parsing.o
  CC       tests/parse-no-sample-id-all.o
  CC       tests/kmod-path.o
  CC       tests/thread-map.o
  CC       tests/llvm.o
  CC       tests/llvm-src-base.o
  CC       tests/llvm-src-kbuild.o
  CC       tests/llvm-src-prologue.o
  CC       tests/llvm-src-relocation.o
  CC       tests/bpf.o
  CC       tests/topology.o
  CC       tests/mem.o
  CC       tests/cpumap.o
  CC       tests/stat.o
  CC       tests/event_update.o
  CC       tests/event-times.o
  CC       tests/expr.o
  CC       tests/backward-ring-buffer.o
  CC       tests/sdt.o
  CC       tests/is_printable_array.o
  CC       tests/bitmap.o
  CC       tests/perf-hooks.o
  CC       tests/clang.o
  CC       tests/unit_number__scnprintf.o
  CC       tests/mem2node.o
  CC       tests/dwarf-unwind.o
  LD       tests/perf-in.o
  CC       perf.o
  LD       perf-in.o
  HOSTCC   pmu-events/json.o
  HOSTCC   pmu-events/jsmn.o
  HOSTCC   pmu-events/jevents.o
  HOSTLD   pmu-events/jevents-in.o
  LINK     pmu-events/jevents
  GEN      pmu-events/pmu-events.c
  CC       pmu-events/pmu-events.o
  LD       pmu-events/pmu-events-in.o
  CC       plugin_jbd2.o
  LD       plugin_jbd2-in.o
  LINK     plugin_jbd2.so
  CC       plugin_hrtimer.o
  LD       plugin_hrtimer-in.o
  LINK     plugin_hrtimer.so
  CC       plugin_kmem.o
  LD       plugin_kmem-in.o
  LINK     plugin_kmem.so
  CC       plugin_kvm.o
  LD       plugin_kvm-in.o
  LINK     plugin_kvm.so
  CC       plugin_mac80211.o
  LD       plugin_mac80211-in.o
  LINK     plugin_mac80211.so
  CC       plugin_sched_switch.o
  LD       plugin_sched_switch-in.o
  LINK     plugin_sched_switch.so
  CC       plugin_function.o
  LD       plugin_function-in.o
  LINK     plugin_function.so
  CC       plugin_xen.o
  LD       plugin_xen-in.o
  LINK     plugin_xen.so
  CC       plugin_scsi.o
  LD       plugin_scsi-in.o
  LINK     plugin_scsi.so
  CC       plugin_cfg80211.o
  LD       plugin_cfg80211-in.o
  LINK     plugin_cfg80211.so
  GEN      libtraceevent-dynamic-list
  LINK     perf
  GEN      perf-archive
  GEN      perf-with-kcore
  GEN      python/perf.so
make: Leaving directory '/usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf'
2018-07-16 20:55:35 cd /usr/src/linux-perf-x86_64-randconfig-s5-07160434-60=
0b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf
2018-07-16 20:55:35 mkdir -p /pkg
2018-07-16 20:55:36 mkdir -p /kbuild/obj/consumer/x86_64-randconfig-s5-0716=
0434
2018-07-16 20:55:36 cp /pkg/linux/x86_64-randconfig-s5-07160434/gcc-7/600b7=
378cf43f522e88027874f11f63b6fbf53d8/vmlinux.xz /tmp
2018-07-16 20:55:37 unxz -k /tmp/vmlinux.xz
2018-07-16 20:55:40 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-randconfig-=
s5-07160434
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
ignored_by_lkp: builtin clang support
2018-07-16 20:55:41 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 1
 1: vmlinux symtab matches kallsyms                       : Ok
2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 2
 2: Detect openat syscall event                           : FAILED!
2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 3
 3: Detect openat syscall event on all cpus               : FAILED!
2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 4
 4: Read samples using the mmap interface                 : FAILED!
2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 5
 5: Test data source output                               : Ok
2018-07-16 20:55:44 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 6
 6: Parse event definition strings                        : FAILED!
2018-07-16 20:55:44 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 7
 7: Simple expression parser                              : Ok
2018-07-16 20:55:44 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 8
 8: PERF_RECORD_* events & perf_sample fields             : Ok
2018-07-16 20:55:46 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 9
 9: Parse perf pmu format                                 : Ok
2018-07-16 20:55:46 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 10
10: DSO data read                                         : Ok
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 11
11: DSO data cache                                        : Ok
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 12
12: DSO data reopen                                       : Ok
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 13
13: Roundtrip evsel->name                                 : Ok
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 14
14: Parse sched tracepoints fields                        : FAILED!
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 15
15: syscalls:sys_enter_openat event fields                : FAILED!
2018-07-16 20:55:47 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 16
16: Setup struct perf_event_attr                          : Ok
2018-07-16 20:56:01 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 17
17: Match and link multiple hists                         : Ok
2018-07-16 20:56:02 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 18
18: 'import perf' in python                               : Ok
2018-07-16 20:56:02 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 19
19: Breakpoint overflow signal handler                    : Ok
2018-07-16 20:56:02 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 20
20: Breakpoint overflow sampling                          : Ok
2018-07-16 20:56:03 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 21
21: Breakpoint accounting                                 : Skip
2018-07-16 20:56:03 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 22
22: Number of exit events of a simple workload            : Skip
2018-07-16 20:56:03 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 23
23: Software clock events period values                   : Ok
2018-07-16 20:56:03 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 24
24: Object code reading                                   : FAILED!
2018-07-16 20:56:04 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 25
25: Sample parsing                                        : Ok
2018-07-16 20:56:05 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 26
26: Use a dummy software event to keep tracking           : Skip
2018-07-16 20:56:05 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 27
27: Parse with no sample_id_all bit set                   : Ok
2018-07-16 20:56:05 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 28
28: Filter hist entries                                   : Ok
2018-07-16 20:56:05 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 29
29: Lookup mmap thread                                    : Ok
2018-07-16 20:56:06 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 30
30: Share thread mg                                       : FAILED!
2018-07-16 20:56:06 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 31
31: Sort output of hist entries                           : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 32
32: Cumulate child hist entries                           : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 33
33: Track with sched_switch                               : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 34
34: Filter fds with revents mask in a fdarray             : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 35
35: Add fd to a fdarray, making it autogrow               : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 36
36: kmod_path__parse                                      : Ok
2018-07-16 20:56:07 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 37
37: Thread map                                            : Ok
2018-07-16 20:56:08 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 39
39: Session topology                                      : Ok
2018-07-16 20:56:08 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 41
41: Synthesize thread map                                 : Ok
2018-07-16 20:56:08 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 42
42: Remove thread map                                     : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 43
43: Synthesize cpu map                                    : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 44
44: Synthesize stat config                                : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 45
45: Synthesize stat                                       : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 46
46: Synthesize stat round                                 : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 47
47: Synthesize attr update                                : Ok
2018-07-16 20:56:09 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 48
48: Event times                                           : FAILED!
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 49
49: Read backward ring buffer                             : Skip
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 50
50: Print cpu map                                         : Ok
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 51
51: Probe SDT events                                      : Ok
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 52
52: is_printable_array                                    : Ok
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 53
53: Print bitmap                                          : Ok
2018-07-16 20:56:10 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 54
54: perf hooks                                            : Ok
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 56
56: unit_number__scnprintf                                : Ok
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 57
57: mem2node                                              : Ok
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 58
58: x86 rdpmc                                             : FAILED!
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 59
59: Convert perf time to TSC                              : FAILED!
2018-07-16 20:56:11 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 60
60: DWARF unwind                                          : Ok
2018-07-16 20:56:12 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 61
61: x86 instruction decoder - new instructions            : Ok
2018-07-16 20:56:12 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 62
62: probe libc's inet_pton & backtrace it with ping       : FAILED!
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 66
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 67
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 68
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 69
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 70
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 71
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 72
2018-07-16 20:56:13 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-=
600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 73

--A6N2fC+uXW/VQSAv--
