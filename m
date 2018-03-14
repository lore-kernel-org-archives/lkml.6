Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCNOSD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:18:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:7986 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeCNOSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:18:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="25641454"
Subject: Re: [PATCH RESEND v1 0/3] perf/core: expose thread context switch out
 event type to user space
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <fda5bacc-8e84-6cbb-6c4f-9f9318186421@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d41fc56f-a5c0-787a-4e70-2290bf77d425@linux.intel.com>
Date: Wed, 14 Mar 2018 17:17:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <fda5bacc-8e84-6cbb-6c4f-9f9318186421@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2018 11:38, Alexey Budankov wrote:
> 
> Here is a series of small patches that implement exposing type of 
> context-switch-out event as a part of PERF_RECORD_SWITCH[_CPU_WIDE] record.

Testing results from my Fedora 27/x86_64:

uname -a
Linux nntvtune39 4.16.0-rc4+ #1 SMP Mon Mar 12 21:17:37 MSK 2018 x86_64 x86_64 x86_64 GNU/Linux

make -C tools/perf build-test
make: Entering directory '/root/abudanko/tip/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_help_O: cd . && make help FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.xrLs5ksrJ9 DESTDIR=/tmp/tmp.5ZpjIqvBVY
                  make_doc_O: cd . && make doc FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.MJmfrgLhNK DESTDIR=/tmp/tmp.yJo94jyacg
         make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.ZuEWWlVFeU DESTDIR=/tmp/tmp.aNyH2VKah3
              make_install_O: cd . && make install FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.XXcWzGEFUk DESTDIR=/tmp/tmp.NMO2Xtx42H
       make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.5RerzNEW09 DESTDIR=/tmp/tmp.ehBBqNFP98
           make_no_libnuma_O: cd . && make NO_LIBNUMA=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.aMXBc8UM1x DESTDIR=/tmp/tmp.ttdyrsd18s
               make_static_O: cd . && make LDFLAGS=-static FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC  O=/tmp/tmp.obO7qjlSS9 DESTDIR=/tmp/tmp.dnvYuui9Jj
          make_no_libaudit_O: cd . && make NO_LIBAUDIT=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.7cWjMWSYZD DESTDIR=/tmp/tmp.tIi87QH0yU
                 make_tags_O: cd . && make tags FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.RhiMLTTU6h DESTDIR=/tmp/tmp.JAAbJwzneB
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.WeiF5jlgUO DESTDIR=/tmp/tmp.LuEBtkX92v
 make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/ FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.Wdsxe0jQ8j DESTDIR=/tmp/tmp.iraPIy4UAS
            make_no_libelf_O: cd . && make NO_LIBELF=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.6MBYepMyHa DESTDIR=/tmp/tmp.p3PrkVry8g
       make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.PoPZzgpUV1 DESTDIR=/tmp/tmp.ipXWNpqDRs
              make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.hq7E29QItv DESTDIR=/tmp/tmp.5RgyPl1F0Q
           make_no_libperl_O: cd . && make NO_LIBPERL=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.1yx2LBUHLy DESTDIR=/tmp/tmp.258moNRwf3
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.sohUVBmifi DESTDIR=/tmp/tmp.DFP99FuMWs
                make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.uoGvFnx0sR DESTDIR=/tmp/tmp.0RNi8PX9wa
                 make_pure_O: cd . && make FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.HqqCNIxJmM DESTDIR=/tmp/tmp.CvFxUqhh4X
            make_clean_all_O: cd . && make clean all FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.hffsHJY0jp DESTDIR=/tmp/tmp.3kq9oSNTJD
              make_no_newt_O: cd . && make NO_NEWT=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.4DDe0e7oiV DESTDIR=/tmp/tmp.lH28Fbdq2A
          make_install_bin_O: cd . && make install-bin FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.r8pqeg8Bji DESTDIR=/tmp/tmp.fDlZujS8lV
     make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.f3V6Jiisxg DESTDIR=/tmp/tmp.PUDAXV2mch
         make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.VKfBelKuio DESTDIR=/tmp/tmp.3y5FCbUf6P
              make_no_gtk2_O: cd . && make NO_GTK2=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.zaVqsGpU2H DESTDIR=/tmp/tmp.i9UKKwNPED
      make_with_babeltrace_O: cd . && make LIBBABELTRACE=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.3PDo5rHKA1 DESTDIR=/tmp/tmp.CjHtdhGFDa
          make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.cafL24IcpK DESTDIR=/tmp/tmp.Df2ehA6Coc
           make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.rqy6KUq5u3 DESTDIR=/tmp/tmp.0gcFovJ7dU
               make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.Hgn6SV60iB DESTDIR=/tmp/tmp.zPz5HSuCdc
             make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.yNpnVEo3cY DESTDIR=/tmp/tmp.WlGcI4JYLr
         make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.eUIGux6t1l DESTDIR=/tmp/tmp.9fbBddEstQ
make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.9mj1JAfAU0 DESTDIR=/tmp/tmp.YrMfF3PgTE
         make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.2r9LfRZpLU DESTDIR=/tmp/tmp.QfnjPHDYYl
            make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.3VYlKWYvYr DESTDIR=/tmp/tmp.C2S4CFHUJS
          make_no_auxtrace_O: cd . && make NO_AUXTRACE=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.zQcyEThr5D DESTDIR=/tmp/tmp.3NDAUKtHXm
OK
make: Leaving directory '/root/abudanko/tip/tools/perf'

perf test
 1: vmlinux symtab matches kallsyms                       : Ok
 2: Detect openat syscall event                           : Ok
 3: Detect openat syscall event on all cpus               : Ok
 4: Read samples using the mmap interface                 : Ok
 5: Test data source output                               : Ok
 6: Parse event definition strings                        : Ok
 7: Simple expression parser                              : Ok
 8: PERF_RECORD_* events & perf_sample fields             : Ok
 9: Parse perf pmu format                                 : Ok
10: DSO data read                                         : Ok
11: DSO data cache                                        : Ok
12: DSO data reopen                                       : Ok
13: Roundtrip evsel->name                                 : Ok
14: Parse sched tracepoints fields                        : Ok
15: syscalls:sys_enter_openat event fields                : Ok
16: Setup struct perf_event_attr                          : Ok
17: Match and link multiple hists                         : Ok
18: 'import perf' in python                               : Ok
19: Breakpoint overflow signal handler                    : Ok
20: Breakpoint overflow sampling                          : Ok
21: Number of exit events of a simple workload            : Ok
22: Software clock events period values                   : Ok
23: Object code reading                                   :
--- start ---
test child forked, pid 16844
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/4.16.0-rc4+/build/vmlinux for symbols
Parsing event 'cycles'
mmap size 528384B
Reading object code for memory address: 0xffffffffab060c16
File is: /lib/modules/4.16.0-rc4+/build/vmlinux
On file address is: 0x260c16
Objdump command is: objdump -z -d --start-address=0xffffffff81060c16 --stop-address=0xffffffff81060c96 /lib/modules/4.16.0-rc4+/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xfffffe000013a01e
thread__find_addr_map failed
test child finished with -1
---- end ----
Object code reading: FAILED!
24: Sample parsing                                        : Ok
25: Use a dummy software event to keep tracking           : Ok
26: Parse with no sample_id_all bit set                   : Ok
27: Filter hist entries                                   : Ok
28: Lookup mmap thread                                    : Ok
29: Share thread mg                                       : Ok
30: Sort output of hist entries                           : Ok
31: Cumulate child hist entries                           : Ok
32: Track with sched_switch                               : Ok
33: Filter fds with revents mask in a fdarray             : Ok
34: Add fd to a fdarray, making it autogrow               : Ok
35: kmod_path__parse                                      : Ok
36: Thread map                                            : Ok
37: LLVM search and compile                               :
37.1: Basic BPF llvm compile                              : Skip
37.2: kbuild searching                                    : Skip
37.3: Compile source for BPF prologue generation          : Skip
37.4: Compile source for BPF relocation                   : Skip
38: Session topology                                      : Ok
39: BPF filter                                            :
39.1: Basic BPF filtering                                 : Skip
39.2: BPF pinning                                         : Skip
39.3: BPF prologue generation                             : Skip
39.4: BPF relocation checker                              : Skip
40: Synthesize thread map                                 : Ok
41: Remove thread map                                     : Ok
42: Synthesize cpu map                                    : Ok
43: Synthesize stat config                                : Ok
44: Synthesize stat                                       : Ok
45: Synthesize stat round                                 : Ok
46: Synthesize attr update                                : Ok
47: Event times                                           : Ok
48: Read backward ring buffer                             : Ok
49: Print cpu map                                         : Ok
50: Probe SDT events                                      : Ok
51: is_printable_array                                    : Ok
52: Print bitmap                                          : Ok
53: perf hooks                                            : Ok
54: builtin clang support                                 : Skip (not compiled in)
55: unit_number__scnprintf                                : Ok
56: x86 rdpmc                                             : Ok
57: Convert perf time to TSC                              : Ok
58: DWARF unwind                                          : Ok
59: x86 instruction decoder - new instructions            : Ok
60: Use vfs_getname probe to get syscall args filenames   : Ok
61: Add vfs_getname probe to get syscall args filenames   : Ok
62: Check open filename arg using perf trace + vfs_getname: Ok
63: probe libc's inet_pton & backtrace it with ping       : Ok

Thanks,
Alexey
