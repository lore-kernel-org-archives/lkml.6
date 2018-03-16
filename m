Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeCPJ7p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:59:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:55432 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeCPJ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:59:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="25205960"
Subject: Re: [PATCH] perf: Fix sibling iteration
To: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Dmitry.Prohorov@intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@redhat.com, torvalds@linux-foundation.org,
        mingo@kernel.org, vincent.weaver@maine.edu, kan.liang@intel.com,
        eranian@google.com, davidcc@google.com, valery.cherepennikov@intel.com
Cc: linux-tip-commits@vger.kernel.org
References: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
 <20180315170129.GX4043@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0be54adb-a7be-cd2f-dfcb-4166dfe432ea@linux.intel.com>
Date: Fri, 16 Mar 2018 12:59:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315170129.GX4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 15.03.2018 20:01, Peter Zijlstra wrote:
> Subject: perf: Fix sibling iteration
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Mar 15 17:36:56 CET 2018
> 
> Mark noticed that the change to sibling_list changed some iteration
> semantics; because previously we used group_list as list entry,
> sibling events would always have an empty sibling_list.
> 
> But because we now use sibling_list for both list head and list entry,
> siblings will report as having siblings.
> 
> Fix this with a custom for_each_sibling_event() iterator.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 8343aae66167 ("perf/core: Remove perf_event::group_entry")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Applied to tip repo and run testing on Fedora 27/x86_64 (client skylake 8 cores):

make -C tools/perf/ build-test
make: Entering directory '/root/abudanko/tip/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
- /root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
cd . && make FEATURE_DUMP_COPY=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
      make_with_babeltrace_O: cd . && make LIBBABELTRACE=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.icWjm9G83i DESTDIR=/tmp/tmp.k3gS9nZWn1
           make_no_libperl_O: cd . && make NO_LIBPERL=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.cFFDwS0GI0 DESTDIR=/tmp/tmp.ZSHnATR3nx
              make_no_gtk2_O: cd . && make NO_GTK2=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.RnSxaWFXYe DESTDIR=/tmp/tmp.fQ1csVAL81
              make_no_newt_O: cd . && make NO_NEWT=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.IVFn6QEq17 DESTDIR=/tmp/tmp.6eBvM9A4kX
         make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.EM0Q3e692P DESTDIR=/tmp/tmp.ZwfkJkPCHP
make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.3Vo6EX89gQ DESTDIR=/tmp/tmp.AYf0P4xIMu
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.wKJnsI2J6Y DESTDIR=/tmp/tmp.dbkavZubVA
          make_no_auxtrace_O: cd . && make NO_AUXTRACE=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.JC2HxLAtWy DESTDIR=/tmp/tmp.m3kuS2SjoJ
                 make_tags_O: cd . && make tags FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.yNJ1JYIHRe DESTDIR=/tmp/tmp.DfpYbrOHyN
                  make_doc_O: cd . && make doc FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.4oRV5wwXRG DESTDIR=/tmp/tmp.hoHvRcWGMz
            make_clean_all_O: cd . && make clean all FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.VVZwGQwAsl DESTDIR=/tmp/tmp.otyKC854jC
          make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.Pqn88IDBJe DESTDIR=/tmp/tmp.26CemSq8rl
          make_install_bin_O: cd . && make install-bin FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.CJ5gfJRJ88 DESTDIR=/tmp/tmp.hS0o8yXeK7
              make_install_O: cd . && make install FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.RPRcY6uDq8 DESTDIR=/tmp/tmp.IW01wtATTd
 make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/ FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.gvOLjRABv2 DESTDIR=/tmp/tmp.6OMgy187rT
             make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.5IfNr3OiDn DESTDIR=/tmp/tmp.28yzBF5bDE
               make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.CTmyGT5ZNU DESTDIR=/tmp/tmp.ohiadqvLzw
       make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.bDoP5XgtvV DESTDIR=/tmp/tmp.Zfn944JFmO
            make_no_libelf_O: cd . && make NO_LIBELF=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.mzs7boZhfA DESTDIR=/tmp/tmp.P9AgDYEA3j
                 make_pure_O: cd . && make FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.pJGEhkbl9n DESTDIR=/tmp/tmp.msv5mDxu4F
       make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.QoERhLwZDr DESTDIR=/tmp/tmp.ZEmUFt1UnF
         make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.YKoeoBNF82 DESTDIR=/tmp/tmp.iClT1aOD26
         make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.bc9qEJlJD5 DESTDIR=/tmp/tmp.a4qXcSNfmD
                 make_help_O: cd . && make help FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.tFu00ESbDc DESTDIR=/tmp/tmp.p0P0FFCbTS
         make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.E7gtOpuChq DESTDIR=/tmp/tmp.AzdP8T1nhv
           make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.OceO9gPHwz DESTDIR=/tmp/tmp.CRisi5nnWs
          make_no_libaudit_O: cd . && make NO_LIBAUDIT=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.EpEWtVMRoE DESTDIR=/tmp/tmp.QgQTHcB26V
- /root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC: cd . && make FEATURE_DUMP_COPY=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC  LDFLAGS='-static' feature-dump
cd . && make FEATURE_DUMP_COPY=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC LDFLAGS='-static' feature-dump
               make_static_O: cd . && make LDFLAGS=-static FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC  O=/tmp/tmp.wRr6FijvF7 DESTDIR=/tmp/tmp.An2D2JBPYD
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.pXJDRBfMso DESTDIR=/tmp/tmp.Nhx7cYQ3qk
            make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.ldWtmgclEH DESTDIR=/tmp/tmp.Xs4273yDUM
              make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.xLZ9fBxwjy DESTDIR=/tmp/tmp.DuqT8srbXJ
     make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.vFgqAGKa4i DESTDIR=/tmp/tmp.gwbtrK8JK7
           make_no_libnuma_O: cd . && make NO_LIBNUMA=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.D9OZ9CynZ7 DESTDIR=/tmp/tmp.lt01zXW0iy
                make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 FEATURES_DUMP=/root/abudanko/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  O=/tmp/tmp.yJnU4c9jaG DESTDIR=/tmp/tmp.C7HAoPao2W
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
21: Breakpoint accounting                                 : Ok
22: Number of exit events of a simple workload            : Ok
23: Software clock events period values                   : Ok
24: Object code reading                                   : Ok
25: Sample parsing                                        : Ok
26: Use a dummy software event to keep tracking           : Ok
27: Parse with no sample_id_all bit set                   : Ok
28: Filter hist entries                                   : Ok
29: Lookup mmap thread                                    : Ok
30: Share thread mg                                       : Ok
31: Sort output of hist entries                           : Ok
32: Cumulate child hist entries                           : Ok
33: Track with sched_switch                               : Ok
34: Filter fds with revents mask in a fdarray             : Ok
35: Add fd to a fdarray, making it autogrow               : Ok
36: kmod_path__parse                                      : Ok
37: Thread map                                            : Ok
38: LLVM search and compile                               :
38.1: Basic BPF llvm compile                              : Skip
38.2: kbuild searching                                    : Skip
38.3: Compile source for BPF prologue generation          : Skip
38.4: Compile source for BPF relocation                   : Skip
39: Session topology                                      : Ok
40: BPF filter                                            :
40.1: Basic BPF filtering                                 : Skip
40.2: BPF pinning                                         : Skip
40.3: BPF prologue generation                             : Skip
40.4: BPF relocation checker                              : Skip
41: Synthesize thread map                                 : Ok
42: Remove thread map                                     : Ok
43: Synthesize cpu map                                    : Ok
44: Synthesize stat config                                : Ok
45: Synthesize stat                                       : Ok
46: Synthesize stat round                                 : Ok
47: Synthesize attr update                                : Ok
48: Event times                                           : Ok
49: Read backward ring buffer                             : Ok
50: Print cpu map                                         : Ok
51: Probe SDT events                                      : Ok
52: is_printable_array                                    : Ok
53: Print bitmap                                          : Ok
54: perf hooks                                            : Ok
55: builtin clang support                                 : Skip (not compiled in)
56: unit_number__scnprintf                                : Ok
57: x86 rdpmc                                             : Ok
58: Convert perf time to TSC                              : Ok
59: DWARF unwind                                          : Ok
60: x86 instruction decoder - new instructions            : Ok
61: Use vfs_getname probe to get syscall args filenames   : Ok
62: Add vfs_getname probe to get syscall args filenames   : Ok
63: Check open filename arg using perf trace + vfs_getname: Ok
64: probe libc's inet_pton & backtrace it with ping       : Ok

Vincent Weaver's tests (https://github.com/deater/perf_event_tests) 
using run_test.sh script:

**** RUNNING perf_event_tests ****
Linux nntvtune39 4.16.0-rc4+ #1 SMP Mon Mar 12 21:17:37 MSK 2018 x86_64 x86_64 x86_64 GNU/Linux

* Testing /proc/sys/kernel/perf_event_paranoid setting
  + tests/utils/check_paranoid
    Checking /proc/sys/kernel/perf_event_paranoid setting...   PASSED

* Checking infrastructure
  + tests/utils/get_cache_info
    Seeing if cache info is provided by the kernel...          PASSED
 + tests/sysfs/events
    Testing format of event files under /sys/...               PASSED

* Checking generalized events
  + tests/generalized_events/branches
    Testing "branches" generalized event...                    PASSED
  + tests/generalized_events/branch-misses
    Testing "branch-misses" generalized event...               PASSED
  + tests/generalized_events/cycles
    Testing "cycles" generalized event...                      PASSED
  + tests/generalized_events/instructions
    Testing "instructions" generalized event...                PASSED
  + tests/generalized_events/l1-dcache-stores
    Testing "L1-dcache-stores" generalized event...            PASSED
  + tests/generalized_events/l1-dcache-loads
    Testing "L1-dcache-loads" generalized event...             PASSED

* Checking Intel x86 specific features
  + tests/x86_intel/fixed_ctr0
    Testing fixed counter 0 event...                           PASSED
  + tests/x86_intel/fixed_ctr1
    Testing fixed counter 1 event...                           PASSED
  + tests/x86_intel/fixed_ctr2
    Testing fixed counter 2 event...                           PASSED
  + tests/x86_intel/offcore_response
    Testing RAW access to offcore response counters...         PASSED
  + tests/x86_intel/offcore_response_mask
    Testing if setting invalid offcore bits is blocked...      PASSED
  + tests/x86_intel/uncore_events
    Testing uncore events...                                   PASSED

* Checking breakpoint support
  + tests/breakpoints/breakpoint_support
    Testing hardware breakpoints...                            PASSED

* Checking basic perf_event functionality
  + tests/attr_fields/disabled
    Testing disabled bit...                                    PASSED
  + tests/attr_fields/exclusive
    Testing exclusive eventsets...                             PASSED
  + tests/attr_fields/format_id_support
    Testing for FORMAT_ID support...                           PASSED
  + tests/attr_fields/inherit
    Testing inherit...                                         PASSED
  + tests/attr_fields/inherit_stat
    Testing inherit_stat...                                    UNEXPLAINED
  + tests/attr_fields/pinned
    Testing pinned...                                          PASSED
  + tests/attr_fields/read_format_range_check
    Testing attr->read_format invalid bits...                  PASSED
  + tests/attr_fields/sample_type_range_check
    Testing attr->sample_type invalid bits...                  PASSED
  + tests/attr_fields/exclude_user
    Testing exclude_user...                                    PASSED
  + tests/attr_fields/exclude_kernel
    Testing exclude_kernel...                                  PASSED
  + tests/attr_fields/exclude_hv
    Testing exclude_hv...                                      PASSED
  + tests/attr_fields/exclude_guest
    Testing exclude_guest...                                   PASSED
  + tests/attr_fields/exclude_host
    Testing exclude_host...                                    PASSED
  + tests/flags/flags_range_check
    Testing flags invalid bits...                              PASSED
  + tests/flags/flags_cgroup
    Testing PERF_FLAG_PID_CGROUP flag...                       PASSED
  + tests/flags/flags_fd_no_group
    Testing PERF_FLAG_FD_NO_GROUP flag...                      PASSED
  + tests/flags/flags_fd_output
    Testing PERF_FLAG_FD_OUTPUT flag...                        KNOWN KERNEL BUG
  + tests/socket/socket_pass
    Testing passing fd over a socket...                        PASSED

* Checking attr.size behavior
  + tests/size/too_big
    Testing attr > kernel supported size...                    PASSED
  + tests/size/too_little
    Testing attr < kernel supported size...                    PASSED
  + tests/size/just_right
    Testing attr is kernel supported size...                   PASSED
  + tests/size/header_mismatch
    Testing header vs kernel attr size...                      PASSED

* Checking perf_event ioctl calls
  + tests/ioctl/ioctl_flag_group
    Testing PERF_IOC_FLAG_GROUP...                             PASSED
  + tests/ioctl/ioctl_id
    Testing ioctl(PERF_EVENT_IOC_ID)...                        PASSED
  + tests/ioctl/ioctl_period
    Testing ioctl(PERF_EVENT_IOC_PERIOD)...                    PASSED
  + tests/ioctl/ioctl_set_filter
    Testing PERF_EVENT_IOC_SET_FILTER ioctl...                 PASSED
  + tests/ioctl/ioctl_set_output
    Testing PERF_EVENT_IOC_SET_OUTPUT ioctl...                 PASSED

* Checking error returns
  + tests/error_returns/e2big
    Testing E2BIG errors...                                    PASSED
  + tests/error_returns/eacces
    Testing EACCES generation...                               FAILED
  + tests/error_returns/ebadf
    Testing EBADF generation...                                PASSED
  + tests/error_returns/efault
    Testing EFAULT generation...                               PASSED
  + tests/error_returns/einval
    Testing EINVAL generation...                               PASSED
  + tests/error_returns/emfile
    Testing if EMFILE can be triggered...                      PASSED
  + tests/error_returns/enoent
    Testing ENOENT generation...                               PASSED
  + tests/error_returns/enospc
    Testing ENOSPC generation...                               PASSED
  + tests/error_returns/eopnotsupp
    Testing EOPNOTSUPP generation...                           PASSED
  + tests/error_returns/eoverflow
    Testing EOVERFLOW generation...                            PASSED
  + tests/error_returns/eperm
    Testing EPERM generation...                                PASSED
  + tests/error_returns/esrch
    Testing ESRCH generation...                                PASSED
  + tests/error_returns/non-existent
    Testing if non-existent events fail...                     PASSED

* Checking multithread functionality
  + tests/multithread/fork_then_read
    Testing reads in forked children...                        PASSED

* Checking overflow functionality
  + tests/overflow/breakpoint_overflow
    Testing hardware breakpoint overflow...                    UNEXPLAINED
  + tests/overflow/simple_overflow_leader
    Testing overflow on leaders...                             PASSED
  + tests/overflow/simple_overflow_sibling
    Testing overflows on sibling...                            PASSED
  + tests/overflow/simultaneous_overflow
    Testing multiple event overflow...                         PASSED
  + tests/overflow/simultaneous_group_overflow
    Testing multiple event overflow within group...            PASSED
  + tests/overflow/simul_oneshot_group_overflow
    Testing simultaneous one-shot group overflow...            PASSED
  + tests/overflow/single_shot_overflow
    Testing single shot overflow...                            PASSED
  + tests/overflow/single_shot_w_enable
    Testing enable vs refresh signal types...                  PASSED
  + tests/overflow/wakeup_events_overflow
    Testing wakeup events overflow...                          PASSED
  + tests/overflow/overflow_requires_wakeup
    Testing if we overflow w/o setting wakeup...               PASSED
  + tests/overflow/overflow_poll
    Testing catching overflow with poll()...                   PASSED
  + tests/overflow/overflow_large
    Testing large sample_period...                             PASSED
  + tests/overflow/overflow_skid
    Testing if we can skid into kernel...                      KNOWN KERNEL BUG

* Checking tracepoint functionality
  + tests/tracepoints/tracepoint_alias
    Testing if tracepoint event ids alias...                   PASSED

* Checking mmap record sample functionality
  + tests/record_sample/print_record_sample
    Testing record sampling...                                 PASSED
  + tests/record_sample/validate_record_sample
    Validating sample record overflow...                       PASSED
  + tests/record_sample/lost_record_sample
    Checking behavior on mmap overflow...                      PASSED
  + tests/record_sample/multiple_mmap_sizes
    Checking behavior of various mmap sizes...                 PASSED
  + tests/record_sample/sample_branch_stack
    Testing PERF_SAMPLE_BRANCH_STACK...                        PASSED
  + tests/record_sample/record_comm
    Testing PERF_RECORD_COMM...                                PASSED
  + tests/record_sample/record_comm_exec
    Testing PERF_RECORD_COMM_EXEC...                           PASSED
  + tests/record_sample/record_fork
    Testing PERF_RECORD_FORK...                                PASSED
  + tests/record_sample/record_mmap
    Testing PERF_RECORD_MMAP...                                PASSED
  + tests/record_sample/record_mmap2
    Testing PERF_RECORD_MMAP2...                               PASSED
  + tests/record_sample/record_mmap_data
    Testing PERF_RECORD_MMAP with mmap_data...                 PASSED
  + tests/record_sample/sample_data_src
    Testing PERF_SAMPLE_DATA_SRC...                            PASSED
  + tests/record_sample/sample_regs_intr
    Testing PERF_SAMPLE_REGS_INTR...                           PASSED
  + tests/record_sample/sample_regs_user
    Testing PERF_SAMPLE_REGS_USER...                           PASSED
  + tests/record_sample/sample_stack_user
    Testing PERF_SAMPLE_STACK_USER...                          PASSED
  + tests/record_sample/sample_weight
    Testing PERF_SAMPLE_WEIGHT...                              PASSED
  + tests/record_sample/overwrite_mmap
    Checking trashing of mmap buffer...                        PASSED
  + tests/record_sample/mmap_multiple
    Trying to mmap same perf_event fd multiple times...        PASSED

* Checking bugs that PAPI has to work around
  + tests/bugs/sync_read_required
    Testing if time running is correct without DISABLE...      PASSED
  + tests/bugs/read_group_attached
    Testing if FORMAT_GROUP works on attached processes...     PASSED
  + tests/bugs/check_schedulability
    Testing if events checked for schedulability at read...    PASSED
  + tests/multiplexing/check_papi_multiplexing
    Testing if schedulability checked with pinned=0...         PASSED
  + tests/multiplexing/check_multiplexing
    Testing if multiplexing works...                           PASSED

* Checking other bugs
  + tests/corner_cases/sw_start_leader
    Testing start with sw event group leader...                PASSED
  + tests/corner_cases/hw_sw_mix
    Testing mixes of HW and SW events...                       KNOWN KERNEL BUG

* Checking bugs that can silently produce wrong results
  + tests/constraints/check_constraints
    Testing if event constraints are enforced...               SKIPPED
  + tests/corner_cases/context_switch_user_kernel
    Testing if context-switches are kernel only...             PASSED

* Checking interfaces that have changed over the years
  + tests/corner_cases/overflow_requires_mmap
    Testing if overflow signals require ring buffer...         PASSED
  + tests/corner_cases/signal_after_exec
    Testing if overflow signals survive exec...                PASSED
  + tests/corner_cases/sampled_notleader_refresh
    Testing if refresh of group leader enables siblings...     PASSED

* Checking for corner-cases in the ABI (not necessarily bugs)
  + tests/corner_cases/multiple_active
    Testing multiple simultaneous measurements...              PASSED
  + tests/corner_cases/max_num_events
    Testing max events that can be created...                  PASSED
  + tests/corner_cases/max_multiplex
    Testing limit of multiplexing...                           PASSED
  + tests/corner_cases/reset_leader
    Testing reset on group leader...                           PASSED
  + tests/corner_cases/check_reset_mpx
    Testing if reset clears multiplex fields...                PASSED
  + tests/corner_cases/huge_events_start
    Testing start of max events...                             PASSED
  + tests/corner_cases/huge_group_start
    Testing start of max event group...                        PASSED

* Checking for fast RDPMC support
  + tests/rdpmc/rdpmc_support
    Testing if userspace rdpmc reads are supported...          PASSED
  + tests/rdpmc/rdpmc_validation
    Testing if userspace rdpmc reads give expected results...  PASSED
  + tests/rdpmc/rdpmc_multiplexing
    Testing if userspace rdpmc multiplexing works...           PASSED
  + tests/rdpmc/rdpmc_reset
    Testing if resetting while using rdpmc works...            PASSED
  + tests/rdpmc/rdpmc_group
    Testing if rdpmc works with event groups...                PASSED
  + tests/rdpmc/rdpmc_attach
    Testing if rdpmc attach works...                           PASSED
  + tests/rdpmc/rdpmc_multiattach
    Testing if rdpmc multi-attach works...                     PASSED
  + tests/rdpmc/rdpmc_multiattach_papi
    Testing if rdpmc papi-multi-attach works...                PASSED
  + tests/rdpmc/rdpmc_pthreads
    Testing if rdpmc with pthreads works...                    PASSED
  + tests/rdpmc/rdpmc_pthreads_group
    Testing if rdpmc with pthreads works...                    PASSED
  + tests/rdpmc/rdpmc_attach_multi_enable
    Testing if minimized rdpmc papi-multi-attach works...      PASSED
  + tests/rdpmc/rdpmc_exec
    Testing if we can rdpmc in execed process...               PASSED
  + tests/rdpmc/rdpmc_exec_papi
    Testing if we can rdpmc in execed process (PAPI) ...       PASSED

* Checking OpenMP support
  + tests/openmp/openmp_test
    Testing OpenMP results...                                  PASSED
  + tests/openmp/openmp_overflow
    Testing OpenMP overflow results...                         PASSED
  + tests/openmp/openmp_sample
    Testing OpenMP sampling results...                         UNEXPLAINED

* Checking proposed interface updates (not in any released kernel)
  + tests/corner_cases/ioctl_refresh_0
    Testing if PERF_IOC_REFRESH with 0 works...                USE CAUTION
  + tests/corner_cases/wrong_size_enospc
    Testing if ENOSPC returned for wrong-sized buffer...       OLD BEHAVIOR

* Checking for major bugs that are unlikely to ever be fixed
  + tests/bugs/nmi_watchdog_group_leader
    Testing if NMI watchdog interferes w/ event scheduling...  KNOWN KERNEL BUG

Fuzzer testing is in progress.

Thanks,
Alexey
