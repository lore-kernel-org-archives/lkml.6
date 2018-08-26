Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3A52098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3A52098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeHZNWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 09:22:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41662 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHZNWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 09:22:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftrVx-0000Gf-3W; Sun, 26 Aug 2018 11:39:24 +0200
Subject: [GIT pull] perf updates for 4.19
Message-ID: <153527451523.1785.3925483581634278456.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de>
Date:   Sun, 26 Aug 2018 11:39:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

perf/core improvements and fixes:

  Kernel:

    - Improve kallsyms coverage
    - Add x86 entry trampolines to kcore
    - Fix ARM SPE handling
    - Correct PPC event post processing

  Tools:

   - Make the build system more robust
   - Small fixes and enhancements all over the place
   - Update kernel ABI header copies
   - Preparatory work for converting libtraceevnt to a shared library
   - License cleanups

Thanks,

	tglx

------------------>
Adrian Hunter (3):
      perf auxtrace: Fix queue resize
      kallsyms: Simplify update_iter_mod()
      x86: Add entry trampolines to kcore

Alexander Kapshuk (1):
      perf tools: Fix check-headers.sh AND list path of execution

Alexander Shishkin (1):
      kallsyms, x86: Export addresses of PTI entry trampolines

Arnaldo Carvalho de Melo (21):
      perf trace: Associate vfs_getname()'ed pathname with fd returned from 'openat'
      perf trace: Use beautifiers on syscalls:sys_enter_ handlers
      perf trace: Rename some syscall_tp methods to raw_syscall
      perf trace: Allow setting up a syscall_tp struct without a format_field
      perf trace: Setup struct syscall_tp for syscalls:sys_{enter,exit}_NAME events
      perf trace: Use perf_evsel__sc_tp_{uint,ptr} for "id"/"args" handling syscalls:* events
      perf bpf: Add 'syscall_enter' probe helper for syscall enter tracepoints
      perf bpf: Add struct bpf_map struct
      perf bpf: Add bpf/stdio.h wrapper to bpf_perf_event_output function
      perf bpf: Make bpf__for_each_stdout_map() generic
      perf bpf: Generalize bpf__setup_stdout()
      perf bpf: Add bpf__setup_output_event() strerror() counterpart
      perf bpf: Add wrappers to BPF_FUNC_probe_read(_str) functions
      perf trace: Handle "bpf-output" events associated with "__augmented_syscalls__" BPF map
      perf bpf: Make bpf__setup_output_event() return the bpf-output event
      perf trace: Setup the augmented syscalls bpf-output event fields
      perf trace: Wire up the augmented syscalls with the syscalls:sys_enter_FOO beautifier
      perf python: Remove -mcet and -fcf-protection when building with clang
      perf llvm: Allow passing options to llc in addition to clang
      tools arch x86: Update tools's copy of cpufeatures.h
      tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'

Benno Evers (1):
      perf tools: Check for null when copying nsinfo.

Jack Henschel (1):
      perf parser: Improve error message for PMU address filters

Jiri Olsa (37):
      perf annotate: Make symbol__annotate_fprintf2() local
      perf annotate: Make annotation_line__max_percent static
      perf annotate: Get rid of annotation__scnprintf_samples_period()
      perf annotate: Rename struct annotation_line::samples* to data*
      perf annotate: Rename local sample variables to data
      perf annotate: Rename hist to sym_hist in annotation__calc_percent
      perf annotate: Loop group events directly in annotation__calc_percent()
      perf annotate: Switch struct annotation_data::percent to array
      perf annotate: Add PERCENT_HITS_GLOBAL percent value
      perf annotate: Add PERCENT_PERIOD_LOCAL percent value
      perf annotate: Add PERCENT_PERIOD_GLOBAL percent value
      perf annotate: Add percent_type to struct annotation_options
      perf annotate: Pass struct annotation_options to symbol__calc_lines()
      perf annotate: Pass 'struct annotation_options' to map_symbol__annotation_dump()
      perf annotate: Pass browser percent_type in annotate_browser__calc_percent()
      perf annotate: Add support to toggle percent type
      perf annotate: Make local period the default percent type
      perf annotate: Display percent type in stdio output
      perf annotate: Add --percent-type option
      perf report: Add --percent-type option
      perf tools: Make check-headers.sh check based on kernel dir
      perf tools: Move syscall_64.tbl check into check-headers.sh
      perf tools: Get rid of dso__needs_decompress() call in read_object_code()
      perf tools: Get rid of dso__needs_decompress() call in symbol__disassemble()
      perf tools: Get rid of dso__needs_decompress() call in __open_dso()
      perf tools: Make decompress_to_file() function static
      perf tools: Make is_supported_compression() static
      perf tools: Add compression id into 'struct kmod_path'
      perf tools: Store compression id into struct dso
      perf tools: Use compression id in decompress_kmodule()
      perf tools: Move the temp file processing into decompress_kmodule
      perf tools: Add is_compressed callback to compressions array
      perf tools: Add lzma_is_compressed function
      perf tools: Add gzip_is_compressed function
      perf tools: Remove ext from struct kmod_path
      perf mmap: Store real cpu number in 'struct perf_mmap'
      perf python: Fix pyrf_evlist__read_on_cpu() interface

Kim Phillips (1):
      perf arm spe: Fix uninitialized record error variable

Konstantin Khlebnikov (2):
      perf map: Synthesize maps only for thread group leader
      perf map: Optimize maps__fixup_overlappings()

Rasmus Villemoes (1):
      perf tools: Disable parallelism for 'make clean'

Sandipan Das (1):
      perf probe powerpc: Fix trace event post-processing

Sean V Kelley (1):
      perf vendor events arm64: Enable JSON events for eMAG

Steven Rostedt (VMware) (1):
      tools lib traceevent: Change to SPDX License format

Thomas Richter (3):
      perf auxtrace: Support for perf report -D for s390
      perf report: Add raw report support for s390 auxiliary trace
      perf report: Add GUI report support for s390 auxiliary trace

Tzvetomir Stoyanov (VMware) (24):
      tools lib traceevent, perf tools: Rename struct pevent to struct tep_handle
      tools lib traceevent, perf tools: Rename 'struct pevent_record' to 'struct tep_record'
      tools lib traceevent, perf tools: Rename pevent plugin related APIs
      tools lib traceevent, perf tools: Rename pevent alloc / free APIs
      tools lib traceevent, perf tools: Rename pevent find APIs
      tools lib traceevent, perf tools: Rename pevent parse APIs
      tools lib traceevent, perf tools: Rename pevent print APIs
      tools lib traceevent, perf tools: Rename pevent_read_number_* APIs
      tools lib traceevent, perf tools: Rename pevent_register_* APIs
      tools lib traceevent, perf tools: Rename pevent_set_* APIs
      tools lib traceevent, perf tools: Rename traceevent_* APIs
      tools lib traceevent, perf tools: Rename 'enum pevent_flag' to 'enum tep_flag'
      tools lib traceevent, tools lib lockdep: Rename 'enum pevent_errno' to 'enum tep_errno'
      tools lib traceevent: Rename pevent_function* APIs
      tools lib traceevent,  perf tools: Rename traceevent_plugin_* APIs
      tools lib traceevent: Rename pevent_filter* APIs
      tools lib traceevent: Rename pevent_register / unregister APIs
      tools lib traceevent: Rename pevent_data_ APIs
      tools lib traceevent: Rename pevent field APIs
      tools lib traceevent: Rename pevent_find_* APIs
      tools lib traceevent: Rename various pevent get/set/is APIs
      tools lib traceevent: Rename internal parser related APIs
      tools lib traceevent: Rename various pevent APIs
      tools lib traceevent: Rename static variables and functions in event-parse.c

Yury Norov (1):
      perf tools: Drop unneeded bitmap_zero() calls


 arch/x86/mm/cpu_entry_area.c                       |  33 +
 fs/proc/kcore.c                                    |   7 +-
 include/linux/kcore.h                              |  13 +
 kernel/kallsyms.c                                  |  51 +-
 tools/arch/x86/include/asm/cpufeatures.h           |   3 +-
 tools/arch/x86/lib/memcpy_64.S                     |   2 +-
 tools/lib/lockdep/Makefile                         |   4 +-
 tools/lib/traceevent/Makefile                      |   4 +-
 tools/lib/traceevent/event-parse.c                 | 712 ++++++++--------
 tools/lib/traceevent/event-parse.h                 | 458 +++++-----
 tools/lib/traceevent/event-plugin.c                |  86 +-
 tools/lib/traceevent/event-utils.h                 |  16 +-
 tools/lib/traceevent/kbuffer-parse.c               |  17 +-
 tools/lib/traceevent/parse-filter.c                | 304 ++++---
 tools/lib/traceevent/parse-utils.c                 |  16 +-
 tools/lib/traceevent/plugin_cfg80211.c             |  20 +-
 tools/lib/traceevent/plugin_function.c             |  34 +-
 tools/lib/traceevent/plugin_hrtimer.c              |  56 +-
 tools/lib/traceevent/plugin_jbd2.c                 |  36 +-
 tools/lib/traceevent/plugin_kmem.c                 |  66 +-
 tools/lib/traceevent/plugin_kvm.c                  | 154 ++--
 tools/lib/traceevent/plugin_mac80211.c             |  28 +-
 tools/lib/traceevent/plugin_sched_switch.c         |  60 +-
 tools/lib/traceevent/plugin_scsi.c                 |  24 +-
 tools/lib/traceevent/plugin_xen.c                  |  20 +-
 tools/lib/traceevent/trace-seq.c                   |  16 +-
 tools/perf/Documentation/perf-annotate.txt         |   9 +
 tools/perf/Documentation/perf-report.txt           |   9 +
 tools/perf/Makefile                                |   4 +-
 tools/perf/arch/arm64/util/arm-spe.c               |   1 +
 tools/perf/arch/powerpc/util/sym-handling.c        |   4 +-
 tools/perf/arch/s390/util/auxtrace.c               |   1 +
 tools/perf/arch/x86/Makefile                       |   3 -
 tools/perf/builtin-annotate.c                      |   4 +
 tools/perf/builtin-kmem.c                          |   6 +-
 tools/perf/builtin-report.c                        |   9 +-
 tools/perf/builtin-script.c                        |   6 +-
 tools/perf/builtin-trace.c                         | 191 ++++-
 tools/perf/check-headers.sh                        |  17 +-
 tools/perf/examples/bpf/augmented_syscalls.c       |  55 ++
 tools/perf/examples/bpf/hello.c                    |   9 +
 tools/perf/examples/bpf/sys_enter_openat.c         |  33 +
 tools/perf/include/bpf/bpf.h                       |  20 +
 tools/perf/include/bpf/stdio.h                     |  19 +
 .../arch/arm64/ampere/emag/core-imp-def.json       |  32 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 tools/perf/tests/bitmap.c                          |   2 -
 tools/perf/tests/code-reading.c                    |   4 +-
 tools/perf/tests/kmod-path.c                       | 136 ++-
 tools/perf/tests/mem2node.c                        |   2 -
 tools/perf/ui/browsers/annotate.c                  |  76 +-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/annotate.c                         | 305 ++++---
 tools/perf/util/annotate.h                         |  54 +-
 tools/perf/util/auxtrace.c                         |   6 +
 tools/perf/util/auxtrace.h                         |   1 +
 tools/perf/util/bpf-loader.c                       |  48 +-
 tools/perf/util/bpf-loader.h                       |  23 +-
 tools/perf/util/compress.h                         |   2 +
 tools/perf/util/data-convert-bt.c                  |   6 +-
 tools/perf/util/dso.c                              | 111 ++-
 tools/perf/util/dso.h                              |  13 +-
 tools/perf/util/event.c                            |  13 +-
 tools/perf/util/evlist.c                           |   2 +-
 tools/perf/util/evsel.c                            |   2 +-
 tools/perf/util/evsel.h                            |   7 +
 tools/perf/util/header.c                           |   9 +-
 tools/perf/util/llvm-utils.c                       |  31 +-
 tools/perf/util/llvm-utils.h                       |   9 +
 tools/perf/util/lzma.c                             |  20 +
 tools/perf/util/machine.c                          |   4 +-
 tools/perf/util/machine.h                          |   2 +-
 tools/perf/util/map.c                              |  44 +-
 tools/perf/util/map.h                              |   1 -
 tools/perf/util/mmap.c                             |   3 +-
 tools/perf/util/mmap.h                             |   3 +-
 tools/perf/util/namespaces.c                       |   3 +
 tools/perf/util/parse-events.c                     |  20 +-
 tools/perf/util/python.c                           |  30 +-
 tools/perf/util/s390-cpumsf-kernel.h               |  71 ++
 tools/perf/util/s390-cpumsf.c                      | 945 +++++++++++++++++++++
 tools/perf/util/s390-cpumsf.h                      |  21 +
 .../perf/util/scripting-engines/trace-event-perl.c |   2 +-
 .../util/scripting-engines/trace-event-python.c    |   6 +-
 tools/perf/util/setup.py                           |  10 +-
 tools/perf/util/sort.c                             |  16 +-
 tools/perf/util/sort.h                             |   2 +-
 tools/perf/util/trace-event-parse.c                |  34 +-
 tools/perf/util/trace-event-read.c                 |  44 +-
 tools/perf/util/trace-event-scripting.c            |   4 +-
 tools/perf/util/trace-event.c                      |  28 +-
 tools/perf/util/trace-event.h                      |  20 +-
 tools/perf/util/zlib.c                             |  18 +
 93 files changed, 3259 insertions(+), 1628 deletions(-)
 create mode 100644 tools/perf/examples/bpf/augmented_syscalls.c
 create mode 100644 tools/perf/examples/bpf/hello.c
 create mode 100644 tools/perf/examples/bpf/sys_enter_openat.c
 create mode 100644 tools/perf/include/bpf/stdio.h
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
 create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
 create mode 100644 tools/perf/util/s390-cpumsf.c
 create mode 100644 tools/perf/util/s390-cpumsf.h

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index b45f5aaefd74..076ebdce9bd4 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -2,6 +2,8 @@
 
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
+#include <linux/kallsyms.h>
+#include <linux/kcore.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/pgtable.h>
@@ -13,6 +15,7 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage)
 #ifdef CONFIG_X86_64
 static DEFINE_PER_CPU_PAGE_ALIGNED(char, exception_stacks
 	[(N_EXCEPTION_STACKS - 1) * EXCEPTION_STKSZ + DEBUG_STKSZ]);
+static DEFINE_PER_CPU(struct kcore_list, kcore_entry_trampoline);
 #endif
 
 struct cpu_entry_area *get_cpu_entry_area(int cpu)
@@ -146,10 +149,40 @@ static void __init setup_cpu_entry_area(int cpu)
 
 	cea_set_pte(&get_cpu_entry_area(cpu)->entry_trampoline,
 		     __pa_symbol(_entry_trampoline), PAGE_KERNEL_RX);
+	/*
+	 * The cpu_entry_area alias addresses are not in the kernel binary
+	 * so they do not show up in /proc/kcore normally.  This adds entries
+	 * for them manually.
+	 */
+	kclist_add_remap(&per_cpu(kcore_entry_trampoline, cpu),
+			 _entry_trampoline,
+			 &get_cpu_entry_area(cpu)->entry_trampoline, PAGE_SIZE);
 #endif
 	percpu_setup_debug_store(cpu);
 }
 
+#ifdef CONFIG_X86_64
+int arch_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		     char *name)
+{
+	unsigned int cpu, ncpu = 0;
+
+	if (symnum >= num_possible_cpus())
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		if (ncpu++ >= symnum)
+			break;
+	}
+
+	*value = (unsigned long)&get_cpu_entry_area(cpu)->entry_trampoline;
+	*type = 't';
+	strlcpy(name, "__entry_SYSCALL_64_trampoline", KSYM_NAME_LEN);
+
+	return 0;
+}
+#endif
+
 static __init void setup_cpu_entry_area_ptes(void)
 {
 #ifdef CONFIG_X86_32
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e64ecb9f2720..00282f134336 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -383,8 +383,11 @@ static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
 		phdr->p_type	= PT_LOAD;
 		phdr->p_flags	= PF_R|PF_W|PF_X;
 		phdr->p_offset	= kc_vaddr_to_offset(m->addr) + dataoff;
-		phdr->p_vaddr	= (size_t)m->addr;
-		if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
+		if (m->type == KCORE_REMAP)
+			phdr->p_vaddr	= (size_t)m->vaddr;
+		else
+			phdr->p_vaddr	= (size_t)m->addr;
+		if (m->type == KCORE_RAM || m->type == KCORE_TEXT || m->type == KCORE_REMAP)
 			phdr->p_paddr	= __pa(m->addr);
 		else
 			phdr->p_paddr	= (elf_addr_t)-1;
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 8de55e4b5ee9..bc088ef96358 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -12,11 +12,13 @@ enum kcore_type {
 	KCORE_VMEMMAP,
 	KCORE_USER,
 	KCORE_OTHER,
+	KCORE_REMAP,
 };
 
 struct kcore_list {
 	struct list_head list;
 	unsigned long addr;
+	unsigned long vaddr;
 	size_t size;
 	int type;
 };
@@ -36,11 +38,22 @@ struct vmcoredd_node {
 
 #ifdef CONFIG_PROC_KCORE
 extern void kclist_add(struct kcore_list *, void *, size_t, int type);
+static inline
+void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
+{
+	m->vaddr = (unsigned long)vaddr;
+	kclist_add(m, addr, sz, KCORE_REMAP);
+}
 #else
 static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
 }
+
+static inline
+void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
+{
+}
 #endif
 
 #endif /* _LINUX_KCORE_H */
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a23e21ada81b..02a0b01380d8 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -432,6 +432,7 @@ int sprint_backtrace(char *buffer, unsigned long address)
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter {
 	loff_t pos;
+	loff_t pos_arch_end;
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
 	unsigned long value;
@@ -443,9 +444,29 @@ struct kallsym_iter {
 	int show_value;
 };
 
+int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
+			    char *type, char *name)
+{
+	return -EINVAL;
+}
+
+static int get_ksymbol_arch(struct kallsym_iter *iter)
+{
+	int ret = arch_get_kallsym(iter->pos - kallsyms_num_syms,
+				   &iter->value, &iter->type,
+				   iter->name);
+
+	if (ret < 0) {
+		iter->pos_arch_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int get_ksymbol_mod(struct kallsym_iter *iter)
 {
-	int ret = module_get_kallsym(iter->pos - kallsyms_num_syms,
+	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
@@ -501,32 +522,34 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	iter->nameoff = get_symbol_offset(new_pos);
 	iter->pos = new_pos;
 	if (new_pos == 0) {
+		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
 	}
 }
 
+/*
+ * The end position (last + 1) of each additional kallsyms section is recorded
+ * in iter->pos_..._end as each section is added, and so can be used to
+ * determine which get_ksymbol_...() function to call next.
+ */
 static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 {
 	iter->pos = pos;
 
-	if (iter->pos_ftrace_mod_end > 0 &&
-	    iter->pos_ftrace_mod_end < iter->pos)
-		return get_ksymbol_bpf(iter);
+	if ((!iter->pos_arch_end || iter->pos_arch_end > pos) &&
+	    get_ksymbol_arch(iter))
+		return 1;
 
-	if (iter->pos_mod_end > 0 &&
-	    iter->pos_mod_end < iter->pos) {
-		if (!get_ksymbol_ftrace_mod(iter))
-			return get_ksymbol_bpf(iter);
+	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
+	    get_ksymbol_mod(iter))
 		return 1;
-	}
 
-	if (!get_ksymbol_mod(iter)) {
-		if (!get_ksymbol_ftrace_mod(iter))
-			return get_ksymbol_bpf(iter);
-	}
+	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > pos) &&
+	    get_ksymbol_ftrace_mod(iter))
+		return 1;
 
-	return 1;
+	return get_ksymbol_bpf(iter);
 }
 
 /* Returns false if pos at or past end of file. */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 5701f5cecd31..b5c60faf8429 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -219,6 +219,7 @@
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
+#define X86_FEATURE_IBRS_ENHANCED	( 7*32+29) /* Enhanced IBRS */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -229,7 +230,7 @@
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
-
+#define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 298ef1479240..3b24dc05251c 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -256,7 +256,7 @@ ENTRY(__memcpy_mcsafe)
 
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
-	xorq %rax, %rax
+	xorl %eax, %eax
 	ret
 ENDPROC(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
diff --git a/tools/lib/lockdep/Makefile b/tools/lib/lockdep/Makefile
index 9b0ca3ad1ef3..9dafb8cb752f 100644
--- a/tools/lib/lockdep/Makefile
+++ b/tools/lib/lockdep/Makefile
@@ -129,12 +129,12 @@ $(OUTPUT)liblockdep.a: $(LIB_IN)
 tags:	force
 	$(RM) tags
 	find . -name '*.[ch]' | xargs ctags --extra=+f --c-kinds=+px \
-	--regex-c++='/_PE\(([^,)]*).*/PEVENT_ERRNO__\1/'
+	--regex-c++='/_PE\(([^,)]*).*/TEP_ERRNO__\1/'
 
 TAGS:	force
 	$(RM) TAGS
 	find . -name '*.[ch]' | xargs etags \
-	--regex='/_PE(\([^,)]*\).*/PEVENT_ERRNO__\1/'
+	--regex='/_PE(\([^,)]*\).*/TEP_ERRNO__\1/'
 
 define do_install
 	$(print_install)				\
diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 46cd5f871ad7..0b4e833088a4 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -233,12 +233,12 @@ endef
 tags:	force
 	$(RM) tags
 	find . -name '*.[ch]' | xargs ctags --extra=+f --c-kinds=+px \
-	--regex-c++='/_PE\(([^,)]*).*/PEVENT_ERRNO__\1/'
+	--regex-c++='/_PE\(([^,)]*).*/TEP_ERRNO__\1/'
 
 TAGS:	force
 	$(RM) TAGS
 	find . -name '*.[ch]' | xargs etags \
-	--regex='/_PE(\([^,)]*\).*/PEVENT_ERRNO__\1/'
+	--regex='/_PE(\([^,)]*\).*/TEP_ERRNO__\1/'
 
 define do_install_mkdir
 	if [ ! -d '$(DESTDIR_SQ)$1' ]; then		\
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index e5f2acbb70cc..ce1e20227c64 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  *  The parts for function graph printing was taken and modified from the
  *  Linux Kernel that were written by
@@ -73,12 +59,12 @@ static void init_input_buf(const char *buf, unsigned long long size)
 	input_buf_ptr = 0;
 }
 
-const char *pevent_get_input_buf(void)
+const char *tep_get_input_buf(void)
 {
 	return input_buf;
 }
 
-unsigned long long pevent_get_input_buf_ptr(void)
+unsigned long long tep_get_input_buf_ptr(void)
 {
 	return input_buf_ptr;
 }
@@ -88,21 +74,21 @@ struct event_handler {
 	int				id;
 	const char			*sys_name;
 	const char			*event_name;
-	pevent_event_handler_func	func;
+	tep_event_handler_func		func;
 	void				*context;
 };
 
-struct pevent_func_params {
-	struct pevent_func_params	*next;
-	enum pevent_func_arg_type	type;
+struct func_params {
+	struct func_params	*next;
+	enum tep_func_arg_type	type;
 };
 
-struct pevent_function_handler {
-	struct pevent_function_handler	*next;
-	enum pevent_func_arg_type	ret_type;
+struct tep_function_handler {
+	struct tep_function_handler	*next;
+	enum tep_func_arg_type		ret_type;
 	char				*name;
-	pevent_func_handler		func;
-	struct pevent_func_params	*params;
+	tep_func_handler		func;
+	struct func_params		*params;
 	int				nr_args;
 };
 
@@ -110,17 +96,17 @@ static unsigned long long
 process_defined_func(struct trace_seq *s, void *data, int size,
 		     struct event_format *event, struct print_arg *arg);
 
-static void free_func_handle(struct pevent_function_handler *func);
+static void free_func_handle(struct tep_function_handler *func);
 
 /**
- * pevent_buffer_init - init buffer for parsing
+ * tep_buffer_init - init buffer for parsing
  * @buf: buffer to parse
  * @size: the size of the buffer
  *
- * For use with pevent_read_token(), this initializes the internal
- * buffer that pevent_read_token() will parse.
+ * For use with tep_read_token(), this initializes the internal
+ * buffer that tep_read_token() will parse.
  */
-void pevent_buffer_init(const char *buf, unsigned long long size)
+void tep_buffer_init(const char *buf, unsigned long long size)
 {
 	init_input_buf(buf, size);
 }
@@ -160,7 +146,7 @@ struct cmdline_list {
 	int			pid;
 };
 
-static int cmdline_init(struct pevent *pevent)
+static int cmdline_init(struct tep_handle *pevent)
 {
 	struct cmdline_list *cmdlist = pevent->cmdlist;
 	struct cmdline_list *item;
@@ -189,7 +175,7 @@ static int cmdline_init(struct pevent *pevent)
 	return 0;
 }
 
-static const char *find_cmdline(struct pevent *pevent, int pid)
+static const char *find_cmdline(struct tep_handle *pevent, int pid)
 {
 	const struct cmdline *comm;
 	struct cmdline key;
@@ -211,14 +197,14 @@ static const char *find_cmdline(struct pevent *pevent, int pid)
 }
 
 /**
- * pevent_pid_is_registered - return if a pid has a cmdline registered
+ * tep_pid_is_registered - return if a pid has a cmdline registered
  * @pevent: handle for the pevent
  * @pid: The pid to check if it has a cmdline registered with.
  *
  * Returns 1 if the pid has a cmdline mapped to it
  * 0 otherwise.
  */
-int pevent_pid_is_registered(struct pevent *pevent, int pid)
+int tep_pid_is_registered(struct tep_handle *pevent, int pid)
 {
 	const struct cmdline *comm;
 	struct cmdline key;
@@ -244,7 +230,7 @@ int pevent_pid_is_registered(struct pevent *pevent, int pid)
  * we must add this pid. This is much slower than when cmdlines
  * are added before the array is initialized.
  */
-static int add_new_comm(struct pevent *pevent, const char *comm, int pid)
+static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
 {
 	struct cmdline *cmdlines = pevent->cmdlines;
 	const struct cmdline *cmdline;
@@ -288,7 +274,7 @@ static int add_new_comm(struct pevent *pevent, const char *comm, int pid)
 }
 
 /**
- * pevent_register_comm - register a pid / comm mapping
+ * tep_register_comm - register a pid / comm mapping
  * @pevent: handle for the pevent
  * @comm: the command line to register
  * @pid: the pid to map the command line to
@@ -296,7 +282,7 @@ static int add_new_comm(struct pevent *pevent, const char *comm, int pid)
  * This adds a mapping to search for command line names with
  * a given pid. The comm is duplicated.
  */
-int pevent_register_comm(struct pevent *pevent, const char *comm, int pid)
+int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
 {
 	struct cmdline_list *item;
 
@@ -324,7 +310,7 @@ int pevent_register_comm(struct pevent *pevent, const char *comm, int pid)
 	return 0;
 }
 
-int pevent_register_trace_clock(struct pevent *pevent, const char *trace_clock)
+int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock)
 {
 	pevent->trace_clock = strdup(trace_clock);
 	if (!pevent->trace_clock) {
@@ -381,7 +367,7 @@ static int func_bcmp(const void *a, const void *b)
 	return 1;
 }
 
-static int func_map_init(struct pevent *pevent)
+static int func_map_init(struct tep_handle *pevent)
 {
 	struct func_list *funclist;
 	struct func_list *item;
@@ -421,7 +407,7 @@ static int func_map_init(struct pevent *pevent)
 }
 
 static struct func_map *
-__find_func(struct pevent *pevent, unsigned long long addr)
+__find_func(struct tep_handle *pevent, unsigned long long addr)
 {
 	struct func_map *func;
 	struct func_map key;
@@ -438,13 +424,13 @@ __find_func(struct pevent *pevent, unsigned long long addr)
 }
 
 struct func_resolver {
-	pevent_func_resolver_t *func;
-	void		       *priv;
-	struct func_map	       map;
+	tep_func_resolver_t	*func;
+	void			*priv;
+	struct func_map		map;
 };
 
 /**
- * pevent_set_function_resolver - set an alternative function resolver
+ * tep_set_function_resolver - set an alternative function resolver
  * @pevent: handle for the pevent
  * @resolver: function to be used
  * @priv: resolver function private state.
@@ -453,8 +439,8 @@ struct func_resolver {
  * keep using it instead of duplicating all the entries inside
  * pevent->funclist.
  */
-int pevent_set_function_resolver(struct pevent *pevent,
-				 pevent_func_resolver_t *func, void *priv)
+int tep_set_function_resolver(struct tep_handle *pevent,
+			      tep_func_resolver_t *func, void *priv)
 {
 	struct func_resolver *resolver = malloc(sizeof(*resolver));
 
@@ -471,20 +457,20 @@ int pevent_set_function_resolver(struct pevent *pevent,
 }
 
 /**
- * pevent_reset_function_resolver - reset alternative function resolver
+ * tep_reset_function_resolver - reset alternative function resolver
  * @pevent: handle for the pevent
  *
  * Stop using whatever alternative resolver was set, use the default
  * one instead.
  */
-void pevent_reset_function_resolver(struct pevent *pevent)
+void tep_reset_function_resolver(struct tep_handle *pevent)
 {
 	free(pevent->func_resolver);
 	pevent->func_resolver = NULL;
 }
 
 static struct func_map *
-find_func(struct pevent *pevent, unsigned long long addr)
+find_func(struct tep_handle *pevent, unsigned long long addr)
 {
 	struct func_map *map;
 
@@ -503,7 +489,7 @@ find_func(struct pevent *pevent, unsigned long long addr)
 }
 
 /**
- * pevent_find_function - find a function by a given address
+ * tep_find_function - find a function by a given address
  * @pevent: handle for the pevent
  * @addr: the address to find the function with
  *
@@ -511,7 +497,7 @@ find_func(struct pevent *pevent, unsigned long long addr)
  * address. Note, the address does not have to be exact, it
  * will select the function that would contain the address.
  */
-const char *pevent_find_function(struct pevent *pevent, unsigned long long addr)
+const char *tep_find_function(struct tep_handle *pevent, unsigned long long addr)
 {
 	struct func_map *map;
 
@@ -523,16 +509,16 @@ const char *pevent_find_function(struct pevent *pevent, unsigned long long addr)
 }
 
 /**
- * pevent_find_function_address - find a function address by a given address
+ * tep_find_function_address - find a function address by a given address
  * @pevent: handle for the pevent
  * @addr: the address to find the function with
  *
  * Returns the address the function starts at. This can be used in
- * conjunction with pevent_find_function to print both the function
+ * conjunction with tep_find_function to print both the function
  * name and the function offset.
  */
 unsigned long long
-pevent_find_function_address(struct pevent *pevent, unsigned long long addr)
+tep_find_function_address(struct tep_handle *pevent, unsigned long long addr)
 {
 	struct func_map *map;
 
@@ -544,7 +530,7 @@ pevent_find_function_address(struct pevent *pevent, unsigned long long addr)
 }
 
 /**
- * pevent_register_function - register a function with a given address
+ * tep_register_function - register a function with a given address
  * @pevent: handle for the pevent
  * @function: the function name to register
  * @addr: the address the function starts at
@@ -553,8 +539,8 @@ pevent_find_function_address(struct pevent *pevent, unsigned long long addr)
  * This registers a function name with an address and module.
  * The @func passed in is duplicated.
  */
-int pevent_register_function(struct pevent *pevent, char *func,
-			     unsigned long long addr, char *mod)
+int tep_register_function(struct tep_handle *pevent, char *func,
+			  unsigned long long addr, char *mod)
 {
 	struct func_list *item = malloc(sizeof(*item));
 
@@ -589,12 +575,12 @@ int pevent_register_function(struct pevent *pevent, char *func,
 }
 
 /**
- * pevent_print_funcs - print out the stored functions
+ * tep_print_funcs - print out the stored functions
  * @pevent: handle for the pevent
  *
  * This prints out the stored functions.
  */
-void pevent_print_funcs(struct pevent *pevent)
+void tep_print_funcs(struct tep_handle *pevent)
 {
 	int i;
 
@@ -636,7 +622,7 @@ static int printk_cmp(const void *a, const void *b)
 	return 0;
 }
 
-static int printk_map_init(struct pevent *pevent)
+static int printk_map_init(struct tep_handle *pevent)
 {
 	struct printk_list *printklist;
 	struct printk_list *item;
@@ -668,7 +654,7 @@ static int printk_map_init(struct pevent *pevent)
 }
 
 static struct printk_map *
-find_printk(struct pevent *pevent, unsigned long long addr)
+find_printk(struct tep_handle *pevent, unsigned long long addr)
 {
 	struct printk_map *printk;
 	struct printk_map key;
@@ -685,7 +671,7 @@ find_printk(struct pevent *pevent, unsigned long long addr)
 }
 
 /**
- * pevent_register_print_string - register a string by its address
+ * tep_register_print_string - register a string by its address
  * @pevent: handle for the pevent
  * @fmt: the string format to register
  * @addr: the address the string was located at
@@ -693,8 +679,8 @@ find_printk(struct pevent *pevent, unsigned long long addr)
  * This registers a string by the address it was stored in the kernel.
  * The @fmt passed in is duplicated.
  */
-int pevent_register_print_string(struct pevent *pevent, const char *fmt,
-				 unsigned long long addr)
+int tep_register_print_string(struct tep_handle *pevent, const char *fmt,
+			      unsigned long long addr)
 {
 	struct printk_list *item = malloc(sizeof(*item));
 	char *p;
@@ -732,12 +718,12 @@ int pevent_register_print_string(struct pevent *pevent, const char *fmt,
 }
 
 /**
- * pevent_print_printk - print out the stored strings
+ * tep_print_printk - print out the stored strings
  * @pevent: handle for the pevent
  *
  * This prints the string formats that were stored.
  */
-void pevent_print_printk(struct pevent *pevent)
+void tep_print_printk(struct tep_handle *pevent)
 {
 	int i;
 
@@ -756,7 +742,7 @@ static struct event_format *alloc_event(void)
 	return calloc(1, sizeof(struct event_format));
 }
 
-static int add_event(struct pevent *pevent, struct event_format *event)
+static int add_event(struct tep_handle *pevent, struct event_format *event)
 {
 	int i;
 	struct event_format **events = realloc(pevent->events, sizeof(event) *
@@ -913,11 +899,11 @@ static int __peek_char(void)
 }
 
 /**
- * pevent_peek_char - peek at the next character that will be read
+ * tep_peek_char - peek at the next character that will be read
  *
  * Returns the next character read, or -1 if end of buffer.
  */
-int pevent_peek_char(void)
+int tep_peek_char(void)
 {
 	return __peek_char();
 }
@@ -1157,24 +1143,24 @@ static enum event_type read_token(char **tok)
 }
 
 /**
- * pevent_read_token - access to utilites to use the pevent parser
+ * tep_read_token - access to utilites to use the pevent parser
  * @tok: The token to return
  *
  * This will parse tokens from the string given by
- * pevent_init_data().
+ * tep_init_data().
  *
  * Returns the token type.
  */
-enum event_type pevent_read_token(char **tok)
+enum event_type tep_read_token(char **tok)
 {
 	return read_token(tok);
 }
 
 /**
- * pevent_free_token - free a token returned by pevent_read_token
+ * tep_free_token - free a token returned by tep_read_token
  * @token: the token to free
  */
-void pevent_free_token(char *token)
+void tep_free_token(char *token)
 {
 	free_token(token);
 }
@@ -2101,11 +2087,11 @@ process_entry(struct event_format *event __maybe_unused, struct print_arg *arg,
 	arg->field.name = field;
 
 	if (is_flag_field) {
-		arg->field.field = pevent_find_any_field(event, arg->field.name);
+		arg->field.field = tep_find_any_field(event, arg->field.name);
 		arg->field.field->flags |= FIELD_IS_FLAG;
 		is_flag_field = 0;
 	} else if (is_symbolic_field) {
-		arg->field.field = pevent_find_any_field(event, arg->field.name);
+		arg->field.field = tep_find_any_field(event, arg->field.name);
 		arg->field.field->flags |= FIELD_IS_SYMBOLIC;
 		is_symbolic_field = 0;
 	}
@@ -2714,7 +2700,7 @@ process_dynamic_array(struct event_format *event, struct print_arg *arg, char **
 
 	/* Find the field */
 
-	field = pevent_find_field(event, token);
+	field = tep_find_field(event, token);
 	if (!field)
 		goto out_free;
 
@@ -2771,7 +2757,7 @@ process_dynamic_array_len(struct event_format *event, struct print_arg *arg,
 	arg->type = PRINT_DYNAMIC_ARRAY_LEN;
 
 	/* Find the field */
-	field = pevent_find_field(event, token);
+	field = tep_find_field(event, token);
 	if (!field)
 		goto out_free;
 
@@ -2914,10 +2900,10 @@ process_bitmask(struct event_format *event __maybe_unused, struct print_arg *arg
 	return EVENT_ERROR;
 }
 
-static struct pevent_function_handler *
-find_func_handler(struct pevent *pevent, char *func_name)
+static struct tep_function_handler *
+find_func_handler(struct tep_handle *pevent, char *func_name)
 {
-	struct pevent_function_handler *func;
+	struct tep_function_handler *func;
 
 	if (!pevent)
 		return NULL;
@@ -2930,10 +2916,10 @@ find_func_handler(struct pevent *pevent, char *func_name)
 	return func;
 }
 
-static void remove_func_handler(struct pevent *pevent, char *func_name)
+static void remove_func_handler(struct tep_handle *pevent, char *func_name)
 {
-	struct pevent_function_handler *func;
-	struct pevent_function_handler **next;
+	struct tep_function_handler *func;
+	struct tep_function_handler **next;
 
 	next = &pevent->func_handlers;
 	while ((func = *next)) {
@@ -2947,7 +2933,7 @@ static void remove_func_handler(struct pevent *pevent, char *func_name)
 }
 
 static enum event_type
-process_func_handler(struct event_format *event, struct pevent_function_handler *func,
+process_func_handler(struct event_format *event, struct tep_function_handler *func,
 		     struct print_arg *arg, char **tok)
 {
 	struct print_arg **next_arg;
@@ -3008,7 +2994,7 @@ static enum event_type
 process_function(struct event_format *event, struct print_arg *arg,
 		 char *token, char **tok)
 {
-	struct pevent_function_handler *func;
+	struct tep_function_handler *func;
 
 	if (strcmp(token, "__print_flags") == 0) {
 		free_token(token);
@@ -3265,7 +3251,7 @@ static int event_read_print(struct event_format *event)
 }
 
 /**
- * pevent_find_common_field - return a common field by event
+ * tep_find_common_field - return a common field by event
  * @event: handle for the event
  * @name: the name of the common field to return
  *
@@ -3273,7 +3259,7 @@ static int event_read_print(struct event_format *event)
  * This only searchs the common fields and not all field.
  */
 struct format_field *
-pevent_find_common_field(struct event_format *event, const char *name)
+tep_find_common_field(struct event_format *event, const char *name)
 {
 	struct format_field *format;
 
@@ -3287,7 +3273,7 @@ pevent_find_common_field(struct event_format *event, const char *name)
 }
 
 /**
- * pevent_find_field - find a non-common field
+ * tep_find_field - find a non-common field
  * @event: handle for the event
  * @name: the name of the non-common field
  *
@@ -3295,7 +3281,7 @@ pevent_find_common_field(struct event_format *event, const char *name)
  * This does not search common fields.
  */
 struct format_field *
-pevent_find_field(struct event_format *event, const char *name)
+tep_find_field(struct event_format *event, const char *name)
 {
 	struct format_field *format;
 
@@ -3309,7 +3295,7 @@ pevent_find_field(struct event_format *event, const char *name)
 }
 
 /**
- * pevent_find_any_field - find any field by name
+ * tep_find_any_field - find any field by name
  * @event: handle for the event
  * @name: the name of the field
  *
@@ -3318,18 +3304,18 @@ pevent_find_field(struct event_format *event, const char *name)
  * the non-common ones if a common one was not found.
  */
 struct format_field *
-pevent_find_any_field(struct event_format *event, const char *name)
+tep_find_any_field(struct event_format *event, const char *name)
 {
 	struct format_field *format;
 
-	format = pevent_find_common_field(event, name);
+	format = tep_find_common_field(event, name);
 	if (format)
 		return format;
-	return pevent_find_field(event, name);
+	return tep_find_field(event, name);
 }
 
 /**
- * pevent_read_number - read a number from data
+ * tep_read_number - read a number from data
  * @pevent: handle for the pevent
  * @ptr: the raw data
  * @size: the size of the data that holds the number
@@ -3337,8 +3323,8 @@ pevent_find_any_field(struct event_format *event, const char *name)
  * Returns the number (converted to host) from the
  * raw data.
  */
-unsigned long long pevent_read_number(struct pevent *pevent,
-				      const void *ptr, int size)
+unsigned long long tep_read_number(struct tep_handle *pevent,
+				   const void *ptr, int size)
 {
 	switch (size) {
 	case 1:
@@ -3356,7 +3342,7 @@ unsigned long long pevent_read_number(struct pevent *pevent,
 }
 
 /**
- * pevent_read_number_field - read a number from data
+ * tep_read_number_field - read a number from data
  * @field: a handle to the field
  * @data: the raw data to read
  * @value: the value to place the number in
@@ -3366,8 +3352,8 @@ unsigned long long pevent_read_number(struct pevent *pevent,
  *
  * Returns 0 on success, -1 otherwise.
  */
-int pevent_read_number_field(struct format_field *field, const void *data,
-			     unsigned long long *value)
+int tep_read_number_field(struct format_field *field, const void *data,
+			  unsigned long long *value)
 {
 	if (!field)
 		return -1;
@@ -3376,15 +3362,15 @@ int pevent_read_number_field(struct format_field *field, const void *data,
 	case 2:
 	case 4:
 	case 8:
-		*value = pevent_read_number(field->event->pevent,
-					    data + field->offset, field->size);
+		*value = tep_read_number(field->event->pevent,
+					 data + field->offset, field->size);
 		return 0;
 	default:
 		return -1;
 	}
 }
 
-static int get_common_info(struct pevent *pevent,
+static int get_common_info(struct tep_handle *pevent,
 			   const char *type, int *offset, int *size)
 {
 	struct event_format *event;
@@ -3400,7 +3386,7 @@ static int get_common_info(struct pevent *pevent,
 	}
 
 	event = pevent->events[0];
-	field = pevent_find_common_field(event, type);
+	field = tep_find_common_field(event, type);
 	if (!field)
 		return -1;
 
@@ -3410,7 +3396,7 @@ static int get_common_info(struct pevent *pevent,
 	return 0;
 }
 
-static int __parse_common(struct pevent *pevent, void *data,
+static int __parse_common(struct tep_handle *pevent, void *data,
 			  int *size, int *offset, const char *name)
 {
 	int ret;
@@ -3420,45 +3406,45 @@ static int __parse_common(struct pevent *pevent, void *data,
 		if (ret < 0)
 			return ret;
 	}
-	return pevent_read_number(pevent, data + *offset, *size);
+	return tep_read_number(pevent, data + *offset, *size);
 }
 
-static int trace_parse_common_type(struct pevent *pevent, void *data)
+static int trace_parse_common_type(struct tep_handle *pevent, void *data)
 {
 	return __parse_common(pevent, data,
 			      &pevent->type_size, &pevent->type_offset,
 			      "common_type");
 }
 
-static int parse_common_pid(struct pevent *pevent, void *data)
+static int parse_common_pid(struct tep_handle *pevent, void *data)
 {
 	return __parse_common(pevent, data,
 			      &pevent->pid_size, &pevent->pid_offset,
 			      "common_pid");
 }
 
-static int parse_common_pc(struct pevent *pevent, void *data)
+static int parse_common_pc(struct tep_handle *pevent, void *data)
 {
 	return __parse_common(pevent, data,
 			      &pevent->pc_size, &pevent->pc_offset,
 			      "common_preempt_count");
 }
 
-static int parse_common_flags(struct pevent *pevent, void *data)
+static int parse_common_flags(struct tep_handle *pevent, void *data)
 {
 	return __parse_common(pevent, data,
 			      &pevent->flags_size, &pevent->flags_offset,
 			      "common_flags");
 }
 
-static int parse_common_lock_depth(struct pevent *pevent, void *data)
+static int parse_common_lock_depth(struct tep_handle *pevent, void *data)
 {
 	return __parse_common(pevent, data,
 			      &pevent->ld_size, &pevent->ld_offset,
 			      "common_lock_depth");
 }
 
-static int parse_common_migrate_disable(struct pevent *pevent, void *data)
+static int parse_common_migrate_disable(struct tep_handle *pevent, void *data)
 {
 	return __parse_common(pevent, data,
 			      &pevent->ld_size, &pevent->ld_offset,
@@ -3468,13 +3454,13 @@ static int parse_common_migrate_disable(struct pevent *pevent, void *data)
 static int events_id_cmp(const void *a, const void *b);
 
 /**
- * pevent_find_event - find an event by given id
+ * tep_find_event - find an event by given id
  * @pevent: a handle to the pevent
  * @id: the id of the event
  *
  * Returns an event that has a given @id.
  */
-struct event_format *pevent_find_event(struct pevent *pevent, int id)
+struct event_format *tep_find_event(struct tep_handle *pevent, int id)
 {
 	struct event_format **eventptr;
 	struct event_format key;
@@ -3498,7 +3484,7 @@ struct event_format *pevent_find_event(struct pevent *pevent, int id)
 }
 
 /**
- * pevent_find_event_by_name - find an event by given name
+ * tep_find_event_by_name - find an event by given name
  * @pevent: a handle to the pevent
  * @sys: the system name to search for
  * @name: the name of the event to search for
@@ -3507,8 +3493,8 @@ struct event_format *pevent_find_event(struct pevent *pevent, int id)
  * @sys. If @sys is NULL the first event with @name is returned.
  */
 struct event_format *
-pevent_find_event_by_name(struct pevent *pevent,
-			  const char *sys, const char *name)
+tep_find_event_by_name(struct tep_handle *pevent,
+		       const char *sys, const char *name)
 {
 	struct event_format *event;
 	int i;
@@ -3537,7 +3523,7 @@ pevent_find_event_by_name(struct pevent *pevent,
 static unsigned long long
 eval_num_arg(void *data, int size, struct event_format *event, struct print_arg *arg)
 {
-	struct pevent *pevent = event->pevent;
+	struct tep_handle *pevent = event->pevent;
 	unsigned long long val = 0;
 	unsigned long long left, right;
 	struct print_arg *typearg = NULL;
@@ -3553,14 +3539,14 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
 		return strtoull(arg->atom.atom, NULL, 0);
 	case PRINT_FIELD:
 		if (!arg->field.field) {
-			arg->field.field = pevent_find_any_field(event, arg->field.name);
+			arg->field.field = tep_find_any_field(event, arg->field.name);
 			if (!arg->field.field)
 				goto out_warning_field;
 			
 		}
 		/* must be a number */
-		val = pevent_read_number(pevent, data + arg->field.field->offset,
-				arg->field.field->size);
+		val = tep_read_number(pevent, data + arg->field.field->offset,
+				      arg->field.field->size);
 		break;
 	case PRINT_FLAGS:
 	case PRINT_SYMBOL:
@@ -3603,7 +3589,7 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
 
 			switch (larg->type) {
 			case PRINT_DYNAMIC_ARRAY:
-				offset = pevent_read_number(pevent,
+				offset = tep_read_number(pevent,
 						   data + larg->dynarray.field->offset,
 						   larg->dynarray.field->size);
 				if (larg->dynarray.field->elementsize)
@@ -3619,7 +3605,7 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
 			case PRINT_FIELD:
 				if (!larg->field.field) {
 					larg->field.field =
-						pevent_find_any_field(event, larg->field.name);
+						tep_find_any_field(event, larg->field.name);
 					if (!larg->field.field) {
 						arg = larg;
 						goto out_warning_field;
@@ -3632,8 +3618,8 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
 			default:
 				goto default_op; /* oops, all bets off */
 			}
-			val = pevent_read_number(pevent,
-						 data + offset, field_size);
+			val = tep_read_number(pevent,
+					      data + offset, field_size);
 			if (typearg)
 				val = eval_type(val, typearg, 1);
 			break;
@@ -3733,9 +3719,9 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
 		}
 		break;
 	case PRINT_DYNAMIC_ARRAY_LEN:
-		offset = pevent_read_number(pevent,
-					    data + arg->dynarray.field->offset,
-					    arg->dynarray.field->size);
+		offset = tep_read_number(pevent,
+					 data + arg->dynarray.field->offset,
+					 arg->dynarray.field->size);
 		/*
 		 * The total allocated length of the dynamic array is
 		 * stored in the top half of the field, and the offset
@@ -3745,9 +3731,9 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
 		break;
 	case PRINT_DYNAMIC_ARRAY:
 		/* Without [], we pass the address to the dynamic data */
-		offset = pevent_read_number(pevent,
-					    data + arg->dynarray.field->offset,
-					    arg->dynarray.field->size);
+		offset = tep_read_number(pevent,
+					 data + arg->dynarray.field->offset,
+					 arg->dynarray.field->size);
 		/*
 		 * The total allocated length of the dynamic array is
 		 * stored in the top half of the field, and the offset
@@ -3820,7 +3806,7 @@ static void print_str_to_seq(struct trace_seq *s, const char *format,
 		trace_seq_printf(s, format, str);
 }
 
-static void print_bitmask_to_seq(struct pevent *pevent,
+static void print_bitmask_to_seq(struct tep_handle *pevent,
 				 struct trace_seq *s, const char *format,
 				 int len_arg, const void *data, int size)
 {
@@ -3878,7 +3864,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 			  struct event_format *event, const char *format,
 			  int len_arg, struct print_arg *arg)
 {
-	struct pevent *pevent = event->pevent;
+	struct tep_handle *pevent = event->pevent;
 	struct print_flag_sym *flag;
 	struct format_field *field;
 	struct printk_map *printk;
@@ -3899,7 +3885,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 	case PRINT_FIELD:
 		field = arg->field.field;
 		if (!field) {
-			field = pevent_find_any_field(event, arg->field.name);
+			field = tep_find_any_field(event, arg->field.name);
 			if (!field) {
 				str = arg->field.name;
 				goto out_warning_field;
@@ -3992,7 +3978,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 	case PRINT_HEX_STR:
 		if (arg->hex.field->type == PRINT_DYNAMIC_ARRAY) {
 			unsigned long offset;
-			offset = pevent_read_number(pevent,
+			offset = tep_read_number(pevent,
 				data + arg->hex.field->dynarray.field->offset,
 				arg->hex.field->dynarray.field->size);
 			hex = data + (offset & 0xffff);
@@ -4000,7 +3986,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 			field = arg->hex.field->field.field;
 			if (!field) {
 				str = arg->hex.field->field.name;
-				field = pevent_find_any_field(event, str);
+				field = tep_find_any_field(event, str);
 				if (!field)
 					goto out_warning_field;
 				arg->hex.field->field.field = field;
@@ -4023,15 +4009,15 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 			unsigned long offset;
 			struct format_field *field =
 				arg->int_array.field->dynarray.field;
-			offset = pevent_read_number(pevent,
-						    data + field->offset,
-						    field->size);
+			offset = tep_read_number(pevent,
+						 data + field->offset,
+						 field->size);
 			num = data + (offset & 0xffff);
 		} else {
 			field = arg->int_array.field->field.field;
 			if (!field) {
 				str = arg->int_array.field->field.name;
-				field = pevent_find_any_field(event, str);
+				field = tep_find_any_field(event, str);
 				if (!field)
 					goto out_warning_field;
 				arg->int_array.field->field.field = field;
@@ -4071,7 +4057,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 		if (arg->string.offset == -1) {
 			struct format_field *f;
 
-			f = pevent_find_any_field(event, arg->string.string);
+			f = tep_find_any_field(event, arg->string.string);
 			arg->string.offset = f->offset;
 		}
 		str_offset = data2host4(pevent, data + arg->string.offset);
@@ -4089,7 +4075,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 		if (arg->bitmask.offset == -1) {
 			struct format_field *f;
 
-			f = pevent_find_any_field(event, arg->bitmask.bitmask);
+			f = tep_find_any_field(event, arg->bitmask.bitmask);
 			arg->bitmask.offset = f->offset;
 		}
 		bitmask_offset = data2host4(pevent, data + arg->bitmask.offset);
@@ -4132,8 +4118,8 @@ static unsigned long long
 process_defined_func(struct trace_seq *s, void *data, int size,
 		     struct event_format *event, struct print_arg *arg)
 {
-	struct pevent_function_handler *func_handle = arg->func.func;
-	struct pevent_func_params *param;
+	struct tep_function_handler *func_handle = arg->func.func;
+	struct func_params *param;
 	unsigned long long *args;
 	unsigned long long ret;
 	struct print_arg *farg;
@@ -4159,12 +4145,12 @@ process_defined_func(struct trace_seq *s, void *data, int size,
 
 	for (i = 0; i < func_handle->nr_args; i++) {
 		switch (param->type) {
-		case PEVENT_FUNC_ARG_INT:
-		case PEVENT_FUNC_ARG_LONG:
-		case PEVENT_FUNC_ARG_PTR:
+		case TEP_FUNC_ARG_INT:
+		case TEP_FUNC_ARG_LONG:
+		case TEP_FUNC_ARG_PTR:
 			args[i] = eval_num_arg(data, size, event, farg);
 			break;
-		case PEVENT_FUNC_ARG_STRING:
+		case TEP_FUNC_ARG_STRING:
 			trace_seq_init(&str);
 			print_str_arg(&str, data, size, event, "%s", -1, farg);
 			trace_seq_terminate(&str);
@@ -4227,7 +4213,7 @@ static void free_args(struct print_arg *args)
 
 static struct print_arg *make_bprint_args(char *fmt, void *data, int size, struct event_format *event)
 {
-	struct pevent *pevent = event->pevent;
+	struct tep_handle *pevent = event->pevent;
 	struct format_field *field, *ip_field;
 	struct print_arg *args, *arg, **next;
 	unsigned long long ip, val;
@@ -4239,12 +4225,12 @@ static struct print_arg *make_bprint_args(char *fmt, void *data, int size, struc
 	ip_field = pevent->bprint_ip_field;
 
 	if (!field) {
-		field = pevent_find_field(event, "buf");
+		field = tep_find_field(event, "buf");
 		if (!field) {
 			do_warning_event(event, "can't find buffer field for binary printk");
 			return NULL;
 		}
-		ip_field = pevent_find_field(event, "ip");
+		ip_field = tep_find_field(event, "ip");
 		if (!ip_field) {
 			do_warning_event(event, "can't find ip field for binary printk");
 			return NULL;
@@ -4253,7 +4239,7 @@ static struct print_arg *make_bprint_args(char *fmt, void *data, int size, struc
 		pevent->bprint_ip_field = ip_field;
 	}
 
-	ip = pevent_read_number(pevent, data + ip_field->offset, ip_field->size);
+	ip = tep_read_number(pevent, data + ip_field->offset, ip_field->size);
 
 	/*
 	 * The first arg is the IP pointer.
@@ -4347,7 +4333,7 @@ static struct print_arg *make_bprint_args(char *fmt, void *data, int size, struc
 				/* the pointers are always 4 bytes aligned */
 				bptr = (void *)(((unsigned long)bptr + 3) &
 						~3);
-				val = pevent_read_number(pevent, bptr, vsize);
+				val = tep_read_number(pevent, bptr, vsize);
 				bptr += vsize;
 				arg = alloc_arg();
 				if (!arg) {
@@ -4404,7 +4390,7 @@ static char *
 get_bprint_format(void *data, int size __maybe_unused,
 		  struct event_format *event)
 {
-	struct pevent *pevent = event->pevent;
+	struct tep_handle *pevent = event->pevent;
 	unsigned long long addr;
 	struct format_field *field;
 	struct printk_map *printk;
@@ -4413,7 +4399,7 @@ get_bprint_format(void *data, int size __maybe_unused,
 	field = pevent->bprint_fmt_field;
 
 	if (!field) {
-		field = pevent_find_field(event, "fmt");
+		field = tep_find_field(event, "fmt");
 		if (!field) {
 			do_warning_event(event, "can't find format field for binary printk");
 			return NULL;
@@ -4421,7 +4407,7 @@ get_bprint_format(void *data, int size __maybe_unused,
 		pevent->bprint_fmt_field = field;
 	}
 
-	addr = pevent_read_number(pevent, data + field->offset, field->size);
+	addr = tep_read_number(pevent, data + field->offset, field->size);
 
 	printk = find_printk(pevent, addr);
 	if (!printk) {
@@ -4457,7 +4443,7 @@ static void print_mac_arg(struct trace_seq *s, int mac, void *data, int size,
 		fmt = "%.2x%.2x%.2x%.2x%.2x%.2x";
 	if (!arg->field.field) {
 		arg->field.field =
-			pevent_find_any_field(event, arg->field.name);
+			tep_find_any_field(event, arg->field.name);
 		if (!arg->field.field) {
 			do_warning_event(event, "%s: field %s not found",
 					 __func__, arg->field.name);
@@ -4607,7 +4593,7 @@ static int print_ipv4_arg(struct trace_seq *s, const char *ptr, char i,
 
 	if (!arg->field.field) {
 		arg->field.field =
-			pevent_find_any_field(event, arg->field.name);
+			tep_find_any_field(event, arg->field.name);
 		if (!arg->field.field) {
 			do_warning("%s: field %s not found",
 				   __func__, arg->field.name);
@@ -4653,7 +4639,7 @@ static int print_ipv6_arg(struct trace_seq *s, const char *ptr, char i,
 
 	if (!arg->field.field) {
 		arg->field.field =
-			pevent_find_any_field(event, arg->field.name);
+			tep_find_any_field(event, arg->field.name);
 		if (!arg->field.field) {
 			do_warning("%s: field %s not found",
 				   __func__, arg->field.name);
@@ -4711,7 +4697,7 @@ static int print_ipsa_arg(struct trace_seq *s, const char *ptr, char i,
 
 	if (!arg->field.field) {
 		arg->field.field =
-			pevent_find_any_field(event, arg->field.name);
+			tep_find_any_field(event, arg->field.name);
 		if (!arg->field.field) {
 			do_warning("%s: field %s not found",
 				   __func__, arg->field.name);
@@ -4800,18 +4786,18 @@ static int is_printable_array(char *p, unsigned int len)
 	return 1;
 }
 
-void pevent_print_field(struct trace_seq *s, void *data,
-			struct format_field *field)
+void tep_print_field(struct trace_seq *s, void *data,
+		     struct format_field *field)
 {
 	unsigned long long val;
 	unsigned int offset, len, i;
-	struct pevent *pevent = field->event->pevent;
+	struct tep_handle *pevent = field->event->pevent;
 
 	if (field->flags & FIELD_IS_ARRAY) {
 		offset = field->offset;
 		len = field->size;
 		if (field->flags & FIELD_IS_DYNAMIC) {
-			val = pevent_read_number(pevent, data + offset, len);
+			val = tep_read_number(pevent, data + offset, len);
 			offset = val;
 			len = offset >> 16;
 			offset &= 0xffff;
@@ -4831,8 +4817,8 @@ void pevent_print_field(struct trace_seq *s, void *data,
 			field->flags &= ~FIELD_IS_STRING;
 		}
 	} else {
-		val = pevent_read_number(pevent, data + field->offset,
-					 field->size);
+		val = tep_read_number(pevent, data + field->offset,
+				      field->size);
 		if (field->flags & FIELD_IS_POINTER) {
 			trace_seq_printf(s, "0x%llx", val);
 		} else if (field->flags & FIELD_IS_SIGNED) {
@@ -4865,22 +4851,22 @@ void pevent_print_field(struct trace_seq *s, void *data,
 	}
 }
 
-void pevent_print_fields(struct trace_seq *s, void *data,
-			 int size __maybe_unused, struct event_format *event)
+void tep_print_fields(struct trace_seq *s, void *data,
+		      int size __maybe_unused, struct event_format *event)
 {
 	struct format_field *field;
 
 	field = event->format.fields;
 	while (field) {
 		trace_seq_printf(s, " %s=", field->name);
-		pevent_print_field(s, data, field);
+		tep_print_field(s, data, field);
 		field = field->next;
 	}
 }
 
 static void pretty_print(struct trace_seq *s, void *data, int size, struct event_format *event)
 {
-	struct pevent *pevent = event->pevent;
+	struct tep_handle *pevent = event->pevent;
 	struct print_fmt *print_fmt = &event->print_fmt;
 	struct print_arg *arg = print_fmt->args;
 	struct print_arg *args = NULL;
@@ -4899,7 +4885,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct event
 
 	if (event->flags & EVENT_FL_FAILED) {
 		trace_seq_printf(s, "[FAILED TO PARSE]");
-		pevent_print_fields(s, data, size, event);
+		tep_print_fields(s, data, size, event);
 		return;
 	}
 
@@ -5140,7 +5126,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct event
 }
 
 /**
- * pevent_data_lat_fmt - parse the data for the latency format
+ * tep_data_lat_fmt - parse the data for the latency format
  * @pevent: a handle to the pevent
  * @s: the trace_seq to write to
  * @record: the record to read from
@@ -5149,8 +5135,8 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct event
  * need rescheduling, in hard/soft interrupt, preempt count
  * and lock depth) and places it into the trace_seq.
  */
-void pevent_data_lat_fmt(struct pevent *pevent,
-			 struct trace_seq *s, struct pevent_record *record)
+void tep_data_lat_fmt(struct tep_handle *pevent,
+		      struct trace_seq *s, struct tep_record *record)
 {
 	static int check_lock_depth = 1;
 	static int check_migrate_disable = 1;
@@ -5223,55 +5209,55 @@ void pevent_data_lat_fmt(struct pevent *pevent,
 }
 
 /**
- * pevent_data_type - parse out the given event type
+ * tep_data_type - parse out the given event type
  * @pevent: a handle to the pevent
  * @rec: the record to read from
  *
  * This returns the event id from the @rec.
  */
-int pevent_data_type(struct pevent *pevent, struct pevent_record *rec)
+int tep_data_type(struct tep_handle *pevent, struct tep_record *rec)
 {
 	return trace_parse_common_type(pevent, rec->data);
 }
 
 /**
- * pevent_data_event_from_type - find the event by a given type
+ * tep_data_event_from_type - find the event by a given type
  * @pevent: a handle to the pevent
  * @type: the type of the event.
  *
  * This returns the event form a given @type;
  */
-struct event_format *pevent_data_event_from_type(struct pevent *pevent, int type)
+struct event_format *tep_data_event_from_type(struct tep_handle *pevent, int type)
 {
-	return pevent_find_event(pevent, type);
+	return tep_find_event(pevent, type);
 }
 
 /**
- * pevent_data_pid - parse the PID from record
+ * tep_data_pid - parse the PID from record
  * @pevent: a handle to the pevent
  * @rec: the record to parse
  *
  * This returns the PID from a record.
  */
-int pevent_data_pid(struct pevent *pevent, struct pevent_record *rec)
+int tep_data_pid(struct tep_handle *pevent, struct tep_record *rec)
 {
 	return parse_common_pid(pevent, rec->data);
 }
 
 /**
- * pevent_data_preempt_count - parse the preempt count from the record
+ * tep_data_preempt_count - parse the preempt count from the record
  * @pevent: a handle to the pevent
  * @rec: the record to parse
  *
  * This returns the preempt count from a record.
  */
-int pevent_data_preempt_count(struct pevent *pevent, struct pevent_record *rec)
+int tep_data_preempt_count(struct tep_handle *pevent, struct tep_record *rec)
 {
 	return parse_common_pc(pevent, rec->data);
 }
 
 /**
- * pevent_data_flags - parse the latency flags from the record
+ * tep_data_flags - parse the latency flags from the record
  * @pevent: a handle to the pevent
  * @rec: the record to parse
  *
@@ -5279,20 +5265,20 @@ int pevent_data_preempt_count(struct pevent *pevent, struct pevent_record *rec)
  *
  *  Use trace_flag_type enum for the flags (see event-parse.h).
  */
-int pevent_data_flags(struct pevent *pevent, struct pevent_record *rec)
+int tep_data_flags(struct tep_handle *pevent, struct tep_record *rec)
 {
 	return parse_common_flags(pevent, rec->data);
 }
 
 /**
- * pevent_data_comm_from_pid - return the command line from PID
+ * tep_data_comm_from_pid - return the command line from PID
  * @pevent: a handle to the pevent
  * @pid: the PID of the task to search for
  *
  * This returns a pointer to the command line that has the given
  * @pid.
  */
-const char *pevent_data_comm_from_pid(struct pevent *pevent, int pid)
+const char *tep_data_comm_from_pid(struct tep_handle *pevent, int pid)
 {
 	const char *comm;
 
@@ -5301,7 +5287,7 @@ const char *pevent_data_comm_from_pid(struct pevent *pevent, int pid)
 }
 
 static struct cmdline *
-pid_from_cmdlist(struct pevent *pevent, const char *comm, struct cmdline *next)
+pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *next)
 {
 	struct cmdline_list *cmdlist = (struct cmdline_list *)next;
 
@@ -5317,7 +5303,7 @@ pid_from_cmdlist(struct pevent *pevent, const char *comm, struct cmdline *next)
 }
 
 /**
- * pevent_data_pid_from_comm - return the pid from a given comm
+ * tep_data_pid_from_comm - return the pid from a given comm
  * @pevent: a handle to the pevent
  * @comm: the cmdline to find the pid from
  * @next: the cmdline structure to find the next comm
@@ -5329,8 +5315,8 @@ pid_from_cmdlist(struct pevent *pevent, const char *comm, struct cmdline *next)
  * next pid.
  * Also, it does a linear seach, so it may be slow.
  */
-struct cmdline *pevent_data_pid_from_comm(struct pevent *pevent, const char *comm,
-					  struct cmdline *next)
+struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
+				       struct cmdline *next)
 {
 	struct cmdline *cmdline;
 
@@ -5365,13 +5351,13 @@ struct cmdline *pevent_data_pid_from_comm(struct pevent *pevent, const char *com
 }
 
 /**
- * pevent_cmdline_pid - return the pid associated to a given cmdline
+ * tep_cmdline_pid - return the pid associated to a given cmdline
  * @cmdline: The cmdline structure to get the pid from
  *
  * Returns the pid for a give cmdline. If @cmdline is NULL, then
  * -1 is returned.
  */
-int pevent_cmdline_pid(struct pevent *pevent, struct cmdline *cmdline)
+int tep_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline)
 {
 	struct cmdline_list *cmdlist = (struct cmdline_list *)cmdline;
 
@@ -5391,7 +5377,7 @@ int pevent_cmdline_pid(struct pevent *pevent, struct cmdline *cmdline)
 }
 
 /**
- * pevent_data_comm_from_pid - parse the data into the print format
+ * tep_event_info - parse the data into the print format
  * @s: the trace_seq to write to
  * @event: the handle to the event
  * @record: the record to read from
@@ -5399,13 +5385,13 @@ int pevent_cmdline_pid(struct pevent *pevent, struct cmdline *cmdline)
  * This parses the raw @data using the given @event information and
  * writes the print format into the trace_seq.
  */
-void pevent_event_info(struct trace_seq *s, struct event_format *event,
-		       struct pevent_record *record)
+void tep_event_info(struct trace_seq *s, struct event_format *event,
+		    struct tep_record *record)
 {
 	int print_pretty = 1;
 
 	if (event->pevent->print_raw || (event->flags & EVENT_FL_PRINTRAW))
-		pevent_print_fields(s, record->data, record->size, event);
+		tep_print_fields(s, record->data, record->size, event);
 	else {
 
 		if (event->handler && !(event->flags & EVENT_FL_NOHANDLE))
@@ -5433,7 +5419,7 @@ static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
 }
 
 /**
- * pevent_find_event_by_record - return the event from a given record
+ * tep_find_event_by_record - return the event from a given record
  * @pevent: a handle to the pevent
  * @record: The record to get the event from
  *
@@ -5441,7 +5427,7 @@ static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
  * is found.
  */
 struct event_format *
-pevent_find_event_by_record(struct pevent *pevent, struct pevent_record *record)
+tep_find_event_by_record(struct tep_handle *pevent, struct tep_record *record)
 {
 	int type;
 
@@ -5452,11 +5438,11 @@ pevent_find_event_by_record(struct pevent *pevent, struct pevent_record *record)
 
 	type = trace_parse_common_type(pevent, record->data);
 
-	return pevent_find_event(pevent, type);
+	return tep_find_event(pevent, type);
 }
 
 /**
- * pevent_print_event_task - Write the event task comm, pid and CPU
+ * tep_print_event_task - Write the event task comm, pid and CPU
  * @pevent: a handle to the pevent
  * @s: the trace_seq to write to
  * @event: the handle to the record's event
@@ -5464,9 +5450,9 @@ pevent_find_event_by_record(struct pevent *pevent, struct pevent_record *record)
  *
  * Writes the tasks comm, pid and CPU to @s.
  */
-void pevent_print_event_task(struct pevent *pevent, struct trace_seq *s,
-			     struct event_format *event,
-			     struct pevent_record *record)
+void tep_print_event_task(struct tep_handle *pevent, struct trace_seq *s,
+			  struct event_format *event,
+			  struct tep_record *record)
 {
 	void *data = record->data;
 	const char *comm;
@@ -5483,7 +5469,7 @@ void pevent_print_event_task(struct pevent *pevent, struct trace_seq *s,
 }
 
 /**
- * pevent_print_event_time - Write the event timestamp
+ * tep_print_event_time - Write the event timestamp
  * @pevent: a handle to the pevent
  * @s: the trace_seq to write to
  * @event: the handle to the record's event
@@ -5492,10 +5478,10 @@ void pevent_print_event_task(struct pevent *pevent, struct trace_seq *s,
  *
  * Writes the timestamp of the record into @s.
  */
-void pevent_print_event_time(struct pevent *pevent, struct trace_seq *s,
-			     struct event_format *event,
-			     struct pevent_record *record,
-			     bool use_trace_clock)
+void tep_print_event_time(struct tep_handle *pevent, struct trace_seq *s,
+			  struct event_format *event,
+			  struct tep_record *record,
+			  bool use_trace_clock)
 {
 	unsigned long secs;
 	unsigned long usecs;
@@ -5511,11 +5497,11 @@ void pevent_print_event_time(struct pevent *pevent, struct trace_seq *s,
 	}
 
 	if (pevent->latency_format) {
-		pevent_data_lat_fmt(pevent, s, record);
+		tep_data_lat_fmt(pevent, s, record);
 	}
 
 	if (use_usec_format) {
-		if (pevent->flags & PEVENT_NSEC_OUTPUT) {
+		if (pevent->flags & TEP_NSEC_OUTPUT) {
 			usecs = nsecs;
 			p = 9;
 		} else {
@@ -5534,7 +5520,7 @@ void pevent_print_event_time(struct pevent *pevent, struct trace_seq *s,
 }
 
 /**
- * pevent_print_event_data - Write the event data section
+ * tep_print_event_data - Write the event data section
  * @pevent: a handle to the pevent
  * @s: the trace_seq to write to
  * @event: the handle to the record's event
@@ -5542,9 +5528,9 @@ void pevent_print_event_time(struct pevent *pevent, struct trace_seq *s,
  *
  * Writes the parsing of the record's data to @s.
  */
-void pevent_print_event_data(struct pevent *pevent, struct trace_seq *s,
-			     struct event_format *event,
-			     struct pevent_record *record)
+void tep_print_event_data(struct tep_handle *pevent, struct trace_seq *s,
+			  struct event_format *event,
+			  struct tep_record *record)
 {
 	static const char *spaces = "                    "; /* 20 spaces */
 	int len;
@@ -5556,15 +5542,15 @@ void pevent_print_event_data(struct pevent *pevent, struct trace_seq *s,
 	if (len < 20)
 		trace_seq_printf(s, "%.*s", 20 - len, spaces);
 
-	pevent_event_info(s, event, record);
+	tep_event_info(s, event, record);
 }
 
-void pevent_print_event(struct pevent *pevent, struct trace_seq *s,
-			struct pevent_record *record, bool use_trace_clock)
+void tep_print_event(struct tep_handle *pevent, struct trace_seq *s,
+		     struct tep_record *record, bool use_trace_clock)
 {
 	struct event_format *event;
 
-	event = pevent_find_event_by_record(pevent, record);
+	event = tep_find_event_by_record(pevent, record);
 	if (!event) {
 		int i;
 		int type = trace_parse_common_type(pevent, record->data);
@@ -5577,9 +5563,9 @@ void pevent_print_event(struct pevent *pevent, struct trace_seq *s,
 		return;
 	}
 
-	pevent_print_event_task(pevent, s, event, record);
-	pevent_print_event_time(pevent, s, event, record, use_trace_clock);
-	pevent_print_event_data(pevent, s, event, record);
+	tep_print_event_task(pevent, s, event, record);
+	tep_print_event_time(pevent, s, event, record, use_trace_clock);
+	tep_print_event_data(pevent, s, event, record);
 }
 
 static int events_id_cmp(const void *a, const void *b)
@@ -5630,7 +5616,7 @@ static int events_system_cmp(const void *a, const void *b)
 	return events_id_cmp(a, b);
 }
 
-struct event_format **pevent_list_events(struct pevent *pevent, enum event_sort_type sort_type)
+struct event_format **tep_list_events(struct tep_handle *pevent, enum event_sort_type sort_type)
 {
 	struct event_format **events;
 	int (*sort)(const void *a, const void *b);
@@ -5709,13 +5695,13 @@ get_event_fields(const char *type, const char *name,
 }
 
 /**
- * pevent_event_common_fields - return a list of common fields for an event
+ * tep_event_common_fields - return a list of common fields for an event
  * @event: the event to return the common fields of.
  *
  * Returns an allocated array of fields. The last item in the array is NULL.
  * The array must be freed with free().
  */
-struct format_field **pevent_event_common_fields(struct event_format *event)
+struct format_field **tep_event_common_fields(struct event_format *event)
 {
 	return get_event_fields("common", event->name,
 				event->format.nr_common,
@@ -5723,13 +5709,13 @@ struct format_field **pevent_event_common_fields(struct event_format *event)
 }
 
 /**
- * pevent_event_fields - return a list of event specific fields for an event
+ * tep_event_fields - return a list of event specific fields for an event
  * @event: the event to return the fields of.
  *
  * Returns an allocated array of fields. The last item in the array is NULL.
  * The array must be freed with free().
  */
-struct format_field **pevent_event_fields(struct event_format *event)
+struct format_field **tep_event_fields(struct event_format *event)
 {
 	return get_event_fields("event", event->name,
 				event->format.nr_fields,
@@ -5930,7 +5916,7 @@ static void parse_header_field(const char *field,
 }
 
 /**
- * pevent_parse_header_page - parse the data stored in the header page
+ * tep_parse_header_page - parse the data stored in the header page
  * @pevent: the handle to the pevent
  * @buf: the buffer storing the header page format string
  * @size: the size of @buf
@@ -5941,8 +5927,8 @@ static void parse_header_field(const char *field,
  *
  * /sys/kernel/debug/tracing/events/header_page
  */
-int pevent_parse_header_page(struct pevent *pevent, char *buf, unsigned long size,
-			     int long_size)
+int tep_parse_header_page(struct tep_handle *pevent, char *buf, unsigned long size,
+			  int long_size)
 {
 	int ignore;
 
@@ -5994,7 +5980,7 @@ static void free_handler(struct event_handler *handle)
 	free(handle);
 }
 
-static int find_event_handle(struct pevent *pevent, struct event_format *event)
+static int find_event_handle(struct tep_handle *pevent, struct event_format *event)
 {
 	struct event_handler *handle, **next;
 
@@ -6023,7 +6009,7 @@ static int find_event_handle(struct pevent *pevent, struct event_format *event)
 }
 
 /**
- * __pevent_parse_format - parse the event format
+ * __tep_parse_format - parse the event format
  * @buf: the buffer storing the event format string
  * @size: the size of @buf
  * @sys: the system the event belongs to
@@ -6035,9 +6021,9 @@ static int find_event_handle(struct pevent *pevent, struct event_format *event)
  *
  * /sys/kernel/debug/tracing/events/.../.../format
  */
-enum pevent_errno __pevent_parse_format(struct event_format **eventp,
-					struct pevent *pevent, const char *buf,
-					unsigned long size, const char *sys)
+enum tep_errno __tep_parse_format(struct event_format **eventp,
+				  struct tep_handle *pevent, const char *buf,
+				  unsigned long size, const char *sys)
 {
 	struct event_format *event;
 	int ret;
@@ -6046,12 +6032,12 @@ enum pevent_errno __pevent_parse_format(struct event_format **eventp,
 
 	*eventp = event = alloc_event();
 	if (!event)
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 
 	event->name = event_read_name();
 	if (!event->name) {
 		/* Bad event? */
-		ret = PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		ret = TEP_ERRNO__MEM_ALLOC_FAILED;
 		goto event_alloc_failed;
 	}
 
@@ -6064,7 +6050,7 @@ enum pevent_errno __pevent_parse_format(struct event_format **eventp,
 		
 	event->id = event_read_id();
 	if (event->id < 0) {
-		ret = PEVENT_ERRNO__READ_ID_FAILED;
+		ret = TEP_ERRNO__READ_ID_FAILED;
 		/*
 		 * This isn't an allocation error actually.
 		 * But as the ID is critical, just bail out.
@@ -6074,7 +6060,7 @@ enum pevent_errno __pevent_parse_format(struct event_format **eventp,
 
 	event->system = strdup(sys);
 	if (!event->system) {
-		ret = PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		ret = TEP_ERRNO__MEM_ALLOC_FAILED;
 		goto event_alloc_failed;
 	}
 
@@ -6083,7 +6069,7 @@ enum pevent_errno __pevent_parse_format(struct event_format **eventp,
 
 	ret = event_read_format(event);
 	if (ret < 0) {
-		ret = PEVENT_ERRNO__READ_FORMAT_FAILED;
+		ret = TEP_ERRNO__READ_FORMAT_FAILED;
 		goto event_parse_failed;
 	}
 
@@ -6098,7 +6084,7 @@ enum pevent_errno __pevent_parse_format(struct event_format **eventp,
 	show_warning = 1;
 
 	if (ret < 0) {
-		ret = PEVENT_ERRNO__READ_PRINT_FAILED;
+		ret = TEP_ERRNO__READ_PRINT_FAILED;
 		goto event_parse_failed;
 	}
 
@@ -6112,14 +6098,14 @@ enum pevent_errno __pevent_parse_format(struct event_format **eventp,
 			arg = alloc_arg();
 			if (!arg) {
 				event->flags |= EVENT_FL_FAILED;
-				return PEVENT_ERRNO__OLD_FTRACE_ARG_FAILED;
+				return TEP_ERRNO__OLD_FTRACE_ARG_FAILED;
 			}
 			arg->type = PRINT_FIELD;
 			arg->field.name = strdup(field->name);
 			if (!arg->field.name) {
 				event->flags |= EVENT_FL_FAILED;
 				free_arg(arg);
-				return PEVENT_ERRNO__OLD_FTRACE_ARG_FAILED;
+				return TEP_ERRNO__OLD_FTRACE_ARG_FAILED;
 			}
 			arg->field.field = field;
 			*list = arg;
@@ -6142,20 +6128,20 @@ enum pevent_errno __pevent_parse_format(struct event_format **eventp,
 	return ret;
 }
 
-static enum pevent_errno
-__pevent_parse_event(struct pevent *pevent,
-		     struct event_format **eventp,
-		     const char *buf, unsigned long size,
-		     const char *sys)
+static enum tep_errno
+__parse_event(struct tep_handle *pevent,
+	      struct event_format **eventp,
+	      const char *buf, unsigned long size,
+	      const char *sys)
 {
-	int ret = __pevent_parse_format(eventp, pevent, buf, size, sys);
+	int ret = __tep_parse_format(eventp, pevent, buf, size, sys);
 	struct event_format *event = *eventp;
 
 	if (event == NULL)
 		return ret;
 
 	if (pevent && add_event(pevent, event)) {
-		ret = PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		ret = TEP_ERRNO__MEM_ALLOC_FAILED;
 		goto event_add_failed;
 	}
 
@@ -6166,12 +6152,12 @@ __pevent_parse_event(struct pevent *pevent,
 	return 0;
 
 event_add_failed:
-	pevent_free_format(event);
+	tep_free_format(event);
 	return ret;
 }
 
 /**
- * pevent_parse_format - parse the event format
+ * tep_parse_format - parse the event format
  * @pevent: the handle to the pevent
  * @eventp: returned format
  * @buf: the buffer storing the event format string
@@ -6185,16 +6171,16 @@ __pevent_parse_event(struct pevent *pevent,
  *
  * /sys/kernel/debug/tracing/events/.../.../format
  */
-enum pevent_errno pevent_parse_format(struct pevent *pevent,
-				      struct event_format **eventp,
-				      const char *buf,
-				      unsigned long size, const char *sys)
+enum tep_errno tep_parse_format(struct tep_handle *pevent,
+				struct event_format **eventp,
+				const char *buf,
+				unsigned long size, const char *sys)
 {
-	return __pevent_parse_event(pevent, eventp, buf, size, sys);
+	return __parse_event(pevent, eventp, buf, size, sys);
 }
 
 /**
- * pevent_parse_event - parse the event format
+ * tep_parse_event - parse the event format
  * @pevent: the handle to the pevent
  * @buf: the buffer storing the event format string
  * @size: the size of @buf
@@ -6207,22 +6193,22 @@ enum pevent_errno pevent_parse_format(struct pevent *pevent,
  *
  * /sys/kernel/debug/tracing/events/.../.../format
  */
-enum pevent_errno pevent_parse_event(struct pevent *pevent, const char *buf,
-				     unsigned long size, const char *sys)
+enum tep_errno tep_parse_event(struct tep_handle *pevent, const char *buf,
+			       unsigned long size, const char *sys)
 {
 	struct event_format *event = NULL;
-	return __pevent_parse_event(pevent, &event, buf, size, sys);
+	return __parse_event(pevent, &event, buf, size, sys);
 }
 
 #undef _PE
 #define _PE(code, str) str
-static const char * const pevent_error_str[] = {
-	PEVENT_ERRORS
+static const char * const tep_error_str[] = {
+	TEP_ERRORS
 };
 #undef _PE
 
-int pevent_strerror(struct pevent *pevent __maybe_unused,
-		    enum pevent_errno errnum, char *buf, size_t buflen)
+int tep_strerror(struct tep_handle *pevent __maybe_unused,
+		 enum tep_errno errnum, char *buf, size_t buflen)
 {
 	int idx;
 	const char *msg;
@@ -6232,19 +6218,19 @@ int pevent_strerror(struct pevent *pevent __maybe_unused,
 		return 0;
 	}
 
-	if (errnum <= __PEVENT_ERRNO__START ||
-	    errnum >= __PEVENT_ERRNO__END)
+	if (errnum <= __TEP_ERRNO__START ||
+	    errnum >= __TEP_ERRNO__END)
 		return -1;
 
-	idx = errnum - __PEVENT_ERRNO__START - 1;
-	msg = pevent_error_str[idx];
+	idx = errnum - __TEP_ERRNO__START - 1;
+	msg = tep_error_str[idx];
 	snprintf(buf, buflen, "%s", msg);
 
 	return 0;
 }
 
 int get_field_val(struct trace_seq *s, struct format_field *field,
-		  const char *name, struct pevent_record *record,
+		  const char *name, struct tep_record *record,
 		  unsigned long long *val, int err)
 {
 	if (!field) {
@@ -6253,7 +6239,7 @@ int get_field_val(struct trace_seq *s, struct format_field *field,
 		return -1;
 	}
 
-	if (pevent_read_number_field(field, record->data, val)) {
+	if (tep_read_number_field(field, record->data, val)) {
 		if (err)
 			trace_seq_printf(s, " %s=INVALID", name);
 		return -1;
@@ -6263,7 +6249,7 @@ int get_field_val(struct trace_seq *s, struct format_field *field,
 }
 
 /**
- * pevent_get_field_raw - return the raw pointer into the data field
+ * tep_get_field_raw - return the raw pointer into the data field
  * @s: The seq to print to on error
  * @event: the event that the field is for
  * @name: The name of the field
@@ -6276,9 +6262,9 @@ int get_field_val(struct trace_seq *s, struct format_field *field,
  *
  * On failure, it returns NULL.
  */
-void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
-			   const char *name, struct pevent_record *record,
-			   int *len, int err)
+void *tep_get_field_raw(struct trace_seq *s, struct event_format *event,
+			const char *name, struct tep_record *record,
+			int *len, int err)
 {
 	struct format_field *field;
 	void *data = record->data;
@@ -6288,7 +6274,7 @@ void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
 	if (!event)
 		return NULL;
 
-	field = pevent_find_field(event, name);
+	field = tep_find_field(event, name);
 
 	if (!field) {
 		if (err)
@@ -6302,7 +6288,7 @@ void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
 
 	offset = field->offset;
 	if (field->flags & FIELD_IS_DYNAMIC) {
-		offset = pevent_read_number(event->pevent,
+		offset = tep_read_number(event->pevent,
 					    data + offset, field->size);
 		*len = offset >> 16;
 		offset &= 0xffff;
@@ -6313,7 +6299,7 @@ void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
 }
 
 /**
- * pevent_get_field_val - find a field and return its value
+ * tep_get_field_val - find a field and return its value
  * @s: The seq to print to on error
  * @event: the event that the field is for
  * @name: The name of the field
@@ -6323,22 +6309,22 @@ void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
  *
  * Returns 0 on success -1 on field not found.
  */
-int pevent_get_field_val(struct trace_seq *s, struct event_format *event,
-			 const char *name, struct pevent_record *record,
-			 unsigned long long *val, int err)
+int tep_get_field_val(struct trace_seq *s, struct event_format *event,
+		      const char *name, struct tep_record *record,
+		      unsigned long long *val, int err)
 {
 	struct format_field *field;
 
 	if (!event)
 		return -1;
 
-	field = pevent_find_field(event, name);
+	field = tep_find_field(event, name);
 
 	return get_field_val(s, field, name, record, val, err);
 }
 
 /**
- * pevent_get_common_field_val - find a common field and return its value
+ * tep_get_common_field_val - find a common field and return its value
  * @s: The seq to print to on error
  * @event: the event that the field is for
  * @name: The name of the field
@@ -6348,22 +6334,22 @@ int pevent_get_field_val(struct trace_seq *s, struct event_format *event,
  *
  * Returns 0 on success -1 on field not found.
  */
-int pevent_get_common_field_val(struct trace_seq *s, struct event_format *event,
-				const char *name, struct pevent_record *record,
-				unsigned long long *val, int err)
+int tep_get_common_field_val(struct trace_seq *s, struct event_format *event,
+			     const char *name, struct tep_record *record,
+			     unsigned long long *val, int err)
 {
 	struct format_field *field;
 
 	if (!event)
 		return -1;
 
-	field = pevent_find_common_field(event, name);
+	field = tep_find_common_field(event, name);
 
 	return get_field_val(s, field, name, record, val, err);
 }
 
 /**
- * pevent_get_any_field_val - find a any field and return its value
+ * tep_get_any_field_val - find a any field and return its value
  * @s: The seq to print to on error
  * @event: the event that the field is for
  * @name: The name of the field
@@ -6373,22 +6359,22 @@ int pevent_get_common_field_val(struct trace_seq *s, struct event_format *event,
  *
  * Returns 0 on success -1 on field not found.
  */
-int pevent_get_any_field_val(struct trace_seq *s, struct event_format *event,
-			     const char *name, struct pevent_record *record,
-			     unsigned long long *val, int err)
+int tep_get_any_field_val(struct trace_seq *s, struct event_format *event,
+			  const char *name, struct tep_record *record,
+			  unsigned long long *val, int err)
 {
 	struct format_field *field;
 
 	if (!event)
 		return -1;
 
-	field = pevent_find_any_field(event, name);
+	field = tep_find_any_field(event, name);
 
 	return get_field_val(s, field, name, record, val, err);
 }
 
 /**
- * pevent_print_num_field - print a field and a format
+ * tep_print_num_field - print a field and a format
  * @s: The seq to print to
  * @fmt: The printf format to print the field with.
  * @event: the event that the field is for
@@ -6398,17 +6384,17 @@ int pevent_get_any_field_val(struct trace_seq *s, struct event_format *event,
  *
  * Returns: 0 on success, -1 field not found, or 1 if buffer is full.
  */
-int pevent_print_num_field(struct trace_seq *s, const char *fmt,
-			   struct event_format *event, const char *name,
-			   struct pevent_record *record, int err)
+int tep_print_num_field(struct trace_seq *s, const char *fmt,
+			struct event_format *event, const char *name,
+			struct tep_record *record, int err)
 {
-	struct format_field *field = pevent_find_field(event, name);
+	struct format_field *field = tep_find_field(event, name);
 	unsigned long long val;
 
 	if (!field)
 		goto failed;
 
-	if (pevent_read_number_field(field, record->data, &val))
+	if (tep_read_number_field(field, record->data, &val))
 		goto failed;
 
 	return trace_seq_printf(s, fmt, val);
@@ -6420,7 +6406,7 @@ int pevent_print_num_field(struct trace_seq *s, const char *fmt,
 }
 
 /**
- * pevent_print_func_field - print a field and a format for function pointers
+ * tep_print_func_field - print a field and a format for function pointers
  * @s: The seq to print to
  * @fmt: The printf format to print the field with.
  * @event: the event that the field is for
@@ -6430,12 +6416,12 @@ int pevent_print_num_field(struct trace_seq *s, const char *fmt,
  *
  * Returns: 0 on success, -1 field not found, or 1 if buffer is full.
  */
-int pevent_print_func_field(struct trace_seq *s, const char *fmt,
-			    struct event_format *event, const char *name,
-			    struct pevent_record *record, int err)
+int tep_print_func_field(struct trace_seq *s, const char *fmt,
+			 struct event_format *event, const char *name,
+			 struct tep_record *record, int err)
 {
-	struct format_field *field = pevent_find_field(event, name);
-	struct pevent *pevent = event->pevent;
+	struct format_field *field = tep_find_field(event, name);
+	struct tep_handle *pevent = event->pevent;
 	unsigned long long val;
 	struct func_map *func;
 	char tmp[128];
@@ -6443,7 +6429,7 @@ int pevent_print_func_field(struct trace_seq *s, const char *fmt,
 	if (!field)
 		goto failed;
 
-	if (pevent_read_number_field(field, record->data, &val))
+	if (tep_read_number_field(field, record->data, &val))
 		goto failed;
 
 	func = find_func(pevent, val);
@@ -6461,9 +6447,9 @@ int pevent_print_func_field(struct trace_seq *s, const char *fmt,
 	return -1;
 }
 
-static void free_func_handle(struct pevent_function_handler *func)
+static void free_func_handle(struct tep_function_handler *func)
 {
-	struct pevent_func_params *params;
+	struct func_params *params;
 
 	free(func->name);
 
@@ -6477,29 +6463,29 @@ static void free_func_handle(struct pevent_function_handler *func)
 }
 
 /**
- * pevent_register_print_function - register a helper function
+ * tep_register_print_function - register a helper function
  * @pevent: the handle to the pevent
  * @func: the function to process the helper function
  * @ret_type: the return type of the helper function
  * @name: the name of the helper function
- * @parameters: A list of enum pevent_func_arg_type
+ * @parameters: A list of enum tep_func_arg_type
  *
  * Some events may have helper functions in the print format arguments.
  * This allows a plugin to dynamically create a way to process one
  * of these functions.
  *
- * The @parameters is a variable list of pevent_func_arg_type enums that
- * must end with PEVENT_FUNC_ARG_VOID.
+ * The @parameters is a variable list of tep_func_arg_type enums that
+ * must end with TEP_FUNC_ARG_VOID.
  */
-int pevent_register_print_function(struct pevent *pevent,
-				   pevent_func_handler func,
-				   enum pevent_func_arg_type ret_type,
-				   char *name, ...)
-{
-	struct pevent_function_handler *func_handle;
-	struct pevent_func_params **next_param;
-	struct pevent_func_params *param;
-	enum pevent_func_arg_type type;
+int tep_register_print_function(struct tep_handle *pevent,
+				tep_func_handler func,
+				enum tep_func_arg_type ret_type,
+				char *name, ...)
+{
+	struct tep_function_handler *func_handle;
+	struct func_params **next_param;
+	struct func_params *param;
+	enum tep_func_arg_type type;
 	va_list ap;
 	int ret;
 
@@ -6517,7 +6503,7 @@ int pevent_register_print_function(struct pevent *pevent,
 	func_handle = calloc(1, sizeof(*func_handle));
 	if (!func_handle) {
 		do_warning("Failed to allocate function handler");
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 	}
 
 	func_handle->ret_type = ret_type;
@@ -6526,26 +6512,26 @@ int pevent_register_print_function(struct pevent *pevent,
 	if (!func_handle->name) {
 		do_warning("Failed to allocate function name");
 		free(func_handle);
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 	}
 
 	next_param = &(func_handle->params);
 	va_start(ap, name);
 	for (;;) {
-		type = va_arg(ap, enum pevent_func_arg_type);
-		if (type == PEVENT_FUNC_ARG_VOID)
+		type = va_arg(ap, enum tep_func_arg_type);
+		if (type == TEP_FUNC_ARG_VOID)
 			break;
 
-		if (type >= PEVENT_FUNC_ARG_MAX_TYPES) {
+		if (type >= TEP_FUNC_ARG_MAX_TYPES) {
 			do_warning("Invalid argument type %d", type);
-			ret = PEVENT_ERRNO__INVALID_ARG_TYPE;
+			ret = TEP_ERRNO__INVALID_ARG_TYPE;
 			goto out_free;
 		}
 
 		param = malloc(sizeof(*param));
 		if (!param) {
 			do_warning("Failed to allocate function param");
-			ret = PEVENT_ERRNO__MEM_ALLOC_FAILED;
+			ret = TEP_ERRNO__MEM_ALLOC_FAILED;
 			goto out_free;
 		}
 		param->type = type;
@@ -6569,7 +6555,7 @@ int pevent_register_print_function(struct pevent *pevent,
 }
 
 /**
- * pevent_unregister_print_function - unregister a helper function
+ * tep_unregister_print_function - unregister a helper function
  * @pevent: the handle to the pevent
  * @func: the function to process the helper function
  * @name: the name of the helper function
@@ -6578,10 +6564,10 @@ int pevent_register_print_function(struct pevent *pevent,
  *
  * Returns 0 if the handler was removed successully, -1 otherwise.
  */
-int pevent_unregister_print_function(struct pevent *pevent,
-				     pevent_func_handler func, char *name)
+int tep_unregister_print_function(struct tep_handle *pevent,
+				  tep_func_handler func, char *name)
 {
-	struct pevent_function_handler *func_handle;
+	struct tep_function_handler *func_handle;
 
 	func_handle = find_func_handler(pevent, name);
 	if (func_handle && func_handle->func == func) {
@@ -6591,15 +6577,15 @@ int pevent_unregister_print_function(struct pevent *pevent,
 	return -1;
 }
 
-static struct event_format *pevent_search_event(struct pevent *pevent, int id,
-						const char *sys_name,
-						const char *event_name)
+static struct event_format *search_event(struct tep_handle *pevent, int id,
+					 const char *sys_name,
+					 const char *event_name)
 {
 	struct event_format *event;
 
 	if (id >= 0) {
 		/* search by id */
-		event = pevent_find_event(pevent, id);
+		event = tep_find_event(pevent, id);
 		if (!event)
 			return NULL;
 		if (event_name && (strcmp(event_name, event->name) != 0))
@@ -6607,7 +6593,7 @@ static struct event_format *pevent_search_event(struct pevent *pevent, int id,
 		if (sys_name && (strcmp(sys_name, event->system) != 0))
 			return NULL;
 	} else {
-		event = pevent_find_event_by_name(pevent, sys_name, event_name);
+		event = tep_find_event_by_name(pevent, sys_name, event_name);
 		if (!event)
 			return NULL;
 	}
@@ -6615,7 +6601,7 @@ static struct event_format *pevent_search_event(struct pevent *pevent, int id,
 }
 
 /**
- * pevent_register_event_handler - register a way to parse an event
+ * tep_register_event_handler - register a way to parse an event
  * @pevent: the handle to the pevent
  * @id: the id of the event to register
  * @sys_name: the system name the event belongs to
@@ -6631,14 +6617,14 @@ static struct event_format *pevent_search_event(struct pevent *pevent, int id,
  * If @id is >= 0, then it is used to find the event.
  * else @sys_name and @event_name are used.
  */
-int pevent_register_event_handler(struct pevent *pevent, int id,
-				  const char *sys_name, const char *event_name,
-				  pevent_event_handler_func func, void *context)
+int tep_register_event_handler(struct tep_handle *pevent, int id,
+			       const char *sys_name, const char *event_name,
+			       tep_event_handler_func func, void *context)
 {
 	struct event_format *event;
 	struct event_handler *handle;
 
-	event = pevent_search_event(pevent, id, sys_name, event_name);
+	event = search_event(pevent, id, sys_name, event_name);
 	if (event == NULL)
 		goto not_found;
 
@@ -6654,7 +6640,7 @@ int pevent_register_event_handler(struct pevent *pevent, int id,
 	handle = calloc(1, sizeof(*handle));
 	if (!handle) {
 		do_warning("Failed to allocate event handler");
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 	}
 
 	handle->id = id;
@@ -6669,7 +6655,7 @@ int pevent_register_event_handler(struct pevent *pevent, int id,
 		free((void *)handle->event_name);
 		free((void *)handle->sys_name);
 		free(handle);
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 	}
 
 	handle->func = func;
@@ -6682,7 +6668,7 @@ int pevent_register_event_handler(struct pevent *pevent, int id,
 
 static int handle_matches(struct event_handler *handler, int id,
 			  const char *sys_name, const char *event_name,
-			  pevent_event_handler_func func, void *context)
+			  tep_event_handler_func func, void *context)
 {
 	if (id >= 0 && id != handler->id)
 		return 0;
@@ -6700,7 +6686,7 @@ static int handle_matches(struct event_handler *handler, int id,
 }
 
 /**
- * pevent_unregister_event_handler - unregister an existing event handler
+ * tep_unregister_event_handler - unregister an existing event handler
  * @pevent: the handle to the pevent
  * @id: the id of the event to unregister
  * @sys_name: the system name the handler belongs to
@@ -6715,15 +6701,15 @@ static int handle_matches(struct event_handler *handler, int id,
  *
  * Returns 0 if handler was removed successfully, -1 if event was not found.
  */
-int pevent_unregister_event_handler(struct pevent *pevent, int id,
-				    const char *sys_name, const char *event_name,
-				    pevent_event_handler_func func, void *context)
+int tep_unregister_event_handler(struct tep_handle *pevent, int id,
+				 const char *sys_name, const char *event_name,
+				 tep_event_handler_func func, void *context)
 {
 	struct event_format *event;
 	struct event_handler *handle;
 	struct event_handler **next;
 
-	event = pevent_search_event(pevent, id, sys_name, event_name);
+	event = search_event(pevent, id, sys_name, event_name);
 	if (event == NULL)
 		goto not_found;
 
@@ -6754,11 +6740,11 @@ int pevent_unregister_event_handler(struct pevent *pevent, int id,
 }
 
 /**
- * pevent_alloc - create a pevent handle
+ * tep_alloc - create a pevent handle
  */
-struct pevent *pevent_alloc(void)
+struct tep_handle *tep_alloc(void)
 {
-	struct pevent *pevent = calloc(1, sizeof(*pevent));
+	struct tep_handle *pevent = calloc(1, sizeof(*pevent));
 
 	if (pevent)
 		pevent->ref_count = 1;
@@ -6766,12 +6752,12 @@ struct pevent *pevent_alloc(void)
 	return pevent;
 }
 
-void pevent_ref(struct pevent *pevent)
+void tep_ref(struct tep_handle *pevent)
 {
 	pevent->ref_count++;
 }
 
-void pevent_free_format_field(struct format_field *field)
+void tep_free_format_field(struct format_field *field)
 {
 	free(field->type);
 	if (field->alias != field->name)
@@ -6786,7 +6772,7 @@ static void free_format_fields(struct format_field *field)
 
 	while (field) {
 		next = field->next;
-		pevent_free_format_field(field);
+		tep_free_format_field(field);
 		field = next;
 	}
 }
@@ -6797,7 +6783,7 @@ static void free_formats(struct format *format)
 	free_format_fields(format->fields);
 }
 
-void pevent_free_format(struct event_format *event)
+void tep_free_format(struct event_format *event)
 {
 	free(event->name);
 	free(event->system);
@@ -6811,15 +6797,15 @@ void pevent_free_format(struct event_format *event)
 }
 
 /**
- * pevent_free - free a pevent handle
+ * tep_free - free a pevent handle
  * @pevent: the pevent handle to free
  */
-void pevent_free(struct pevent *pevent)
+void tep_free(struct tep_handle *pevent)
 {
 	struct cmdline_list *cmdlist, *cmdnext;
 	struct func_list *funclist, *funcnext;
 	struct printk_list *printklist, *printknext;
-	struct pevent_function_handler *func_handler;
+	struct tep_function_handler *func_handler;
 	struct event_handler *handle;
 	int i;
 
@@ -6883,7 +6869,7 @@ void pevent_free(struct pevent *pevent)
 	}
 
 	for (i = 0; i < pevent->nr_events; i++)
-		pevent_free_format(pevent->events[i]);
+		tep_free_format(pevent->events[i]);
 
 	while (pevent->handlers) {
 		handle = pevent->handlers;
@@ -6899,7 +6885,7 @@ void pevent_free(struct pevent *pevent)
 	free(pevent);
 }
 
-void pevent_unref(struct pevent *pevent)
+void tep_unref(struct tep_handle *pevent)
 {
-	pevent_free(pevent);
+	tep_free(pevent);
 }
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 0c03538df74c..44b7c2d41f9f 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -41,7 +41,7 @@
 #define DEBUG_RECORD 0
 #endif
 
-struct pevent_record {
+struct tep_record {
 	unsigned long long	ts;
 	unsigned long long	offset;
 	long long		missed_events;	/* buffer dropped events before */
@@ -53,8 +53,8 @@ struct pevent_record {
 	int			locked;		/* Do not free, even if ref_count is zero */
 	void			*priv;
 #if DEBUG_RECORD
-	struct pevent_record	*prev;
-	struct pevent_record	*next;
+	struct tep_record	*prev;
+	struct tep_record	*next;
 	long			alloc_addr;
 #endif
 };
@@ -98,19 +98,19 @@ extern int trace_seq_do_printf(struct trace_seq *s);
 
 /* ----------------------- pevent ----------------------- */
 
-struct pevent;
+struct tep_handle;
 struct event_format;
 
-typedef int (*pevent_event_handler_func)(struct trace_seq *s,
-					 struct pevent_record *record,
-					 struct event_format *event,
-					 void *context);
+typedef int (*tep_event_handler_func)(struct trace_seq *s,
+				      struct tep_record *record,
+				      struct event_format *event,
+				      void *context);
 
-typedef int (*pevent_plugin_load_func)(struct pevent *pevent);
-typedef int (*pevent_plugin_unload_func)(struct pevent *pevent);
+typedef int (*tep_plugin_load_func)(struct tep_handle *pevent);
+typedef int (*tep_plugin_unload_func)(struct tep_handle *pevent);
 
-struct pevent_plugin_option {
-	struct pevent_plugin_option	*next;
+struct tep_plugin_option {
+	struct tep_plugin_option	*next;
 	void				*handle;
 	char				*file;
 	char				*name;
@@ -124,20 +124,20 @@ struct pevent_plugin_option {
 /*
  * Plugin hooks that can be called:
  *
- * PEVENT_PLUGIN_LOADER:  (required)
+ * TEP_PLUGIN_LOADER:  (required)
  *   The function name to initialized the plugin.
  *
- *   int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+ *   int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
  *
- * PEVENT_PLUGIN_UNLOADER:  (optional)
+ * TEP_PLUGIN_UNLOADER:  (optional)
  *   The function called just before unloading
  *
- *   int PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+ *   int TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
  *
- * PEVENT_PLUGIN_OPTIONS:  (optional)
+ * TEP_PLUGIN_OPTIONS:  (optional)
  *   Plugin options that can be set before loading
  *
- *   struct pevent_plugin_option PEVENT_PLUGIN_OPTIONS[] = {
+ *   struct tep_plugin_option TEP_PLUGIN_OPTIONS[] = {
  *	{
  *		.name = "option-name",
  *		.plugin_alias = "override-file-name", (optional)
@@ -158,19 +158,19 @@ struct pevent_plugin_option {
  *   .set will be processed. If .value is defined, then it is considered
  *   a string option and .set will be ignored.
  *
- * PEVENT_PLUGIN_ALIAS: (optional)
+ * TEP_PLUGIN_ALIAS: (optional)
  *   The name to use for finding options (uses filename if not defined)
  */
-#define PEVENT_PLUGIN_LOADER pevent_plugin_loader
-#define PEVENT_PLUGIN_UNLOADER pevent_plugin_unloader
-#define PEVENT_PLUGIN_OPTIONS pevent_plugin_options
-#define PEVENT_PLUGIN_ALIAS pevent_plugin_alias
+#define TEP_PLUGIN_LOADER tep_plugin_loader
+#define TEP_PLUGIN_UNLOADER tep_plugin_unloader
+#define TEP_PLUGIN_OPTIONS tep_plugin_options
+#define TEP_PLUGIN_ALIAS tep_plugin_alias
 #define _MAKE_STR(x)	#x
 #define MAKE_STR(x)	_MAKE_STR(x)
-#define PEVENT_PLUGIN_LOADER_NAME MAKE_STR(PEVENT_PLUGIN_LOADER)
-#define PEVENT_PLUGIN_UNLOADER_NAME MAKE_STR(PEVENT_PLUGIN_UNLOADER)
-#define PEVENT_PLUGIN_OPTIONS_NAME MAKE_STR(PEVENT_PLUGIN_OPTIONS)
-#define PEVENT_PLUGIN_ALIAS_NAME MAKE_STR(PEVENT_PLUGIN_ALIAS)
+#define TEP_PLUGIN_LOADER_NAME MAKE_STR(TEP_PLUGIN_LOADER)
+#define TEP_PLUGIN_UNLOADER_NAME MAKE_STR(TEP_PLUGIN_UNLOADER)
+#define TEP_PLUGIN_OPTIONS_NAME MAKE_STR(TEP_PLUGIN_OPTIONS)
+#define TEP_PLUGIN_ALIAS_NAME MAKE_STR(TEP_PLUGIN_ALIAS)
 
 enum format_flags {
 	FIELD_IS_ARRAY		= 1,
@@ -269,10 +269,10 @@ struct print_arg_op {
 	struct print_arg	*right;
 };
 
-struct pevent_function_handler;
+struct tep_function_handler;
 
 struct print_arg_func {
-	struct pevent_function_handler	*func;
+	struct tep_function_handler	*func;
 	struct print_arg		*args;
 };
 
@@ -320,14 +320,14 @@ struct print_fmt {
 };
 
 struct event_format {
-	struct pevent		*pevent;
+	struct tep_handle	*pevent;
 	char			*name;
 	int			id;
 	int			flags;
 	struct format		format;
 	struct print_fmt	print_fmt;
 	char			*system;
-	pevent_event_handler_func handler;
+	tep_event_handler_func	handler;
 	void			*context;
 };
 
@@ -361,25 +361,25 @@ enum event_type {
 	EVENT_SQUOTE,
 };
 
-typedef unsigned long long (*pevent_func_handler)(struct trace_seq *s,
-					     unsigned long long *args);
+typedef unsigned long long (*tep_func_handler)(struct trace_seq *s,
+					       unsigned long long *args);
 
-enum pevent_func_arg_type {
-	PEVENT_FUNC_ARG_VOID,
-	PEVENT_FUNC_ARG_INT,
-	PEVENT_FUNC_ARG_LONG,
-	PEVENT_FUNC_ARG_STRING,
-	PEVENT_FUNC_ARG_PTR,
-	PEVENT_FUNC_ARG_MAX_TYPES
+enum tep_func_arg_type {
+	TEP_FUNC_ARG_VOID,
+	TEP_FUNC_ARG_INT,
+	TEP_FUNC_ARG_LONG,
+	TEP_FUNC_ARG_STRING,
+	TEP_FUNC_ARG_PTR,
+	TEP_FUNC_ARG_MAX_TYPES
 };
 
-enum pevent_flag {
-	PEVENT_NSEC_OUTPUT		= 1,	/* output in NSECS */
-	PEVENT_DISABLE_SYS_PLUGINS	= 1 << 1,
-	PEVENT_DISABLE_PLUGINS		= 1 << 2,
+enum tep_flag {
+	TEP_NSEC_OUTPUT		= 1,	/* output in NSECS */
+	TEP_DISABLE_SYS_PLUGINS	= 1 << 1,
+	TEP_DISABLE_PLUGINS	= 1 << 2,
 };
 
-#define PEVENT_ERRORS 							      \
+#define TEP_ERRORS 							      \
 	_PE(MEM_ALLOC_FAILED,	"failed to allocate memory"),		      \
 	_PE(PARSE_EVENT_FAILED,	"failed to parse event"),		      \
 	_PE(READ_ID_FAILED,	"failed to read event id"),		      \
@@ -411,10 +411,10 @@ enum pevent_flag {
 	_PE(FILTER_MISS,	"record does not match to filter")
 
 #undef _PE
-#define _PE(__code, __str) PEVENT_ERRNO__ ## __code
-enum pevent_errno {
-	PEVENT_ERRNO__SUCCESS			= 0,
-	PEVENT_ERRNO__FILTER_MATCH		= PEVENT_ERRNO__SUCCESS,
+#define _PE(__code, __str) TEP_ERRNO__ ## __code
+enum tep_errno {
+	TEP_ERRNO__SUCCESS			= 0,
+	TEP_ERRNO__FILTER_MATCH			= TEP_ERRNO__SUCCESS,
 
 	/*
 	 * Choose an arbitrary negative big number not to clash with standard
@@ -423,11 +423,11 @@ enum pevent_errno {
 	 *
 	 * http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
 	 */
-	__PEVENT_ERRNO__START			= -100000,
+	__TEP_ERRNO__START			= -100000,
 
-	PEVENT_ERRORS,
+	TEP_ERRORS,
 
-	__PEVENT_ERRNO__END,
+	__TEP_ERRNO__END,
 };
 #undef _PE
 
@@ -435,17 +435,17 @@ struct plugin_list;
 
 #define INVALID_PLUGIN_LIST_OPTION	((char **)((unsigned long)-1))
 
-struct plugin_list *traceevent_load_plugins(struct pevent *pevent);
-void traceevent_unload_plugins(struct plugin_list *plugin_list,
-			       struct pevent *pevent);
-char **traceevent_plugin_list_options(void);
-void traceevent_plugin_free_options_list(char **list);
-int traceevent_plugin_add_options(const char *name,
-				  struct pevent_plugin_option *options);
-void traceevent_plugin_remove_options(struct pevent_plugin_option *options);
-void traceevent_print_plugins(struct trace_seq *s,
-			      const char *prefix, const char *suffix,
-			      const struct plugin_list *list);
+struct plugin_list *tep_load_plugins(struct tep_handle *pevent);
+void tep_unload_plugins(struct plugin_list *plugin_list,
+			struct tep_handle *pevent);
+char **tep_plugin_list_options(void);
+void tep_plugin_free_options_list(char **list);
+int tep_plugin_add_options(const char *name,
+			   struct tep_plugin_option *options);
+void tep_plugin_remove_options(struct tep_plugin_option *options);
+void tep_print_plugins(struct trace_seq *s,
+			const char *prefix, const char *suffix,
+			const struct plugin_list *list);
 
 struct cmdline;
 struct cmdline_list;
@@ -454,10 +454,10 @@ struct func_list;
 struct event_handler;
 struct func_resolver;
 
-typedef char *(pevent_func_resolver_t)(void *priv,
-				       unsigned long long *addrp, char **modp);
+typedef char *(tep_func_resolver_t)(void *priv,
+				    unsigned long long *addrp, char **modp);
 
-struct pevent {
+struct tep_handle {
 	int ref_count;
 
 	int header_page_ts_offset;
@@ -524,7 +524,7 @@ struct pevent {
 	struct format_field *bprint_buf_field;
 
 	struct event_handler *handlers;
-	struct pevent_function_handler *func_handlers;
+	struct tep_function_handler *func_handlers;
 
 	/* cache */
 	struct event_format *last_event;
@@ -532,13 +532,13 @@ struct pevent {
 	char *trace_clock;
 };
 
-static inline void pevent_set_flag(struct pevent *pevent, int flag)
+static inline void tep_set_flag(struct tep_handle *pevent, int flag)
 {
 	pevent->flags |= flag;
 }
 
 static inline unsigned short
-__data2host2(struct pevent *pevent, unsigned short data)
+__data2host2(struct tep_handle *pevent, unsigned short data)
 {
 	unsigned short swap;
 
@@ -552,7 +552,7 @@ __data2host2(struct pevent *pevent, unsigned short data)
 }
 
 static inline unsigned int
-__data2host4(struct pevent *pevent, unsigned int data)
+__data2host4(struct tep_handle *pevent, unsigned int data)
 {
 	unsigned int swap;
 
@@ -568,7 +568,7 @@ __data2host4(struct pevent *pevent, unsigned int data)
 }
 
 static inline unsigned long long
-__data2host8(struct pevent *pevent, unsigned long long data)
+__data2host8(struct tep_handle *pevent, unsigned long long data)
 {
 	unsigned long long swap;
 
@@ -597,7 +597,7 @@ __data2host8(struct pevent *pevent, unsigned long long data)
 	__data2host8(pevent, __val);				\
 })
 
-static inline int traceevent_host_bigendian(void)
+static inline int tep_host_bigendian(void)
 {
 	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4 };
 	unsigned int val;
@@ -615,198 +615,198 @@ enum trace_flag_type {
 	TRACE_FLAG_SOFTIRQ		= 0x10,
 };
 
-int pevent_set_function_resolver(struct pevent *pevent,
-				 pevent_func_resolver_t *func, void *priv);
-void pevent_reset_function_resolver(struct pevent *pevent);
-int pevent_register_comm(struct pevent *pevent, const char *comm, int pid);
-int pevent_register_trace_clock(struct pevent *pevent, const char *trace_clock);
-int pevent_register_function(struct pevent *pevent, char *name,
-			     unsigned long long addr, char *mod);
-int pevent_register_print_string(struct pevent *pevent, const char *fmt,
-				 unsigned long long addr);
-int pevent_pid_is_registered(struct pevent *pevent, int pid);
-
-void pevent_print_event_task(struct pevent *pevent, struct trace_seq *s,
-			     struct event_format *event,
-			     struct pevent_record *record);
-void pevent_print_event_time(struct pevent *pevent, struct trace_seq *s,
-			     struct event_format *event,
-			     struct pevent_record *record,
-			     bool use_trace_clock);
-void pevent_print_event_data(struct pevent *pevent, struct trace_seq *s,
-			     struct event_format *event,
-			     struct pevent_record *record);
-void pevent_print_event(struct pevent *pevent, struct trace_seq *s,
-			struct pevent_record *record, bool use_trace_clock);
-
-int pevent_parse_header_page(struct pevent *pevent, char *buf, unsigned long size,
-			     int long_size);
-
-enum pevent_errno pevent_parse_event(struct pevent *pevent, const char *buf,
-				     unsigned long size, const char *sys);
-enum pevent_errno pevent_parse_format(struct pevent *pevent,
-				      struct event_format **eventp,
-				      const char *buf,
-				      unsigned long size, const char *sys);
-void pevent_free_format(struct event_format *event);
-void pevent_free_format_field(struct format_field *field);
-
-void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
-			   const char *name, struct pevent_record *record,
-			   int *len, int err);
-
-int pevent_get_field_val(struct trace_seq *s, struct event_format *event,
-			 const char *name, struct pevent_record *record,
-			 unsigned long long *val, int err);
-int pevent_get_common_field_val(struct trace_seq *s, struct event_format *event,
-				const char *name, struct pevent_record *record,
-				unsigned long long *val, int err);
-int pevent_get_any_field_val(struct trace_seq *s, struct event_format *event,
-			     const char *name, struct pevent_record *record,
+int tep_set_function_resolver(struct tep_handle *pevent,
+			      tep_func_resolver_t *func, void *priv);
+void tep_reset_function_resolver(struct tep_handle *pevent);
+int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid);
+int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
+int tep_register_function(struct tep_handle *pevent, char *name,
+			  unsigned long long addr, char *mod);
+int tep_register_print_string(struct tep_handle *pevent, const char *fmt,
+			      unsigned long long addr);
+int tep_pid_is_registered(struct tep_handle *pevent, int pid);
+
+void tep_print_event_task(struct tep_handle *pevent, struct trace_seq *s,
+			  struct event_format *event,
+			  struct tep_record *record);
+void tep_print_event_time(struct tep_handle *pevent, struct trace_seq *s,
+			  struct event_format *event,
+			  struct tep_record *record,
+			  bool use_trace_clock);
+void tep_print_event_data(struct tep_handle *pevent, struct trace_seq *s,
+			  struct event_format *event,
+			  struct tep_record *record);
+void tep_print_event(struct tep_handle *pevent, struct trace_seq *s,
+		     struct tep_record *record, bool use_trace_clock);
+
+int tep_parse_header_page(struct tep_handle *pevent, char *buf, unsigned long size,
+			  int long_size);
+
+enum tep_errno tep_parse_event(struct tep_handle *pevent, const char *buf,
+			       unsigned long size, const char *sys);
+enum tep_errno tep_parse_format(struct tep_handle *pevent,
+				struct event_format **eventp,
+				const char *buf,
+				unsigned long size, const char *sys);
+void tep_free_format(struct event_format *event);
+void tep_free_format_field(struct format_field *field);
+
+void *tep_get_field_raw(struct trace_seq *s, struct event_format *event,
+			const char *name, struct tep_record *record,
+			int *len, int err);
+
+int tep_get_field_val(struct trace_seq *s, struct event_format *event,
+		      const char *name, struct tep_record *record,
+		      unsigned long long *val, int err);
+int tep_get_common_field_val(struct trace_seq *s, struct event_format *event,
+			     const char *name, struct tep_record *record,
 			     unsigned long long *val, int err);
+int tep_get_any_field_val(struct trace_seq *s, struct event_format *event,
+			  const char *name, struct tep_record *record,
+			  unsigned long long *val, int err);
 
-int pevent_print_num_field(struct trace_seq *s, const char *fmt,
+int tep_print_num_field(struct trace_seq *s, const char *fmt,
 			   struct event_format *event, const char *name,
-			   struct pevent_record *record, int err);
-
-int pevent_print_func_field(struct trace_seq *s, const char *fmt,
-			   struct event_format *event, const char *name,
-			   struct pevent_record *record, int err);
-
-int pevent_register_event_handler(struct pevent *pevent, int id,
-				  const char *sys_name, const char *event_name,
-				  pevent_event_handler_func func, void *context);
-int pevent_unregister_event_handler(struct pevent *pevent, int id,
-				    const char *sys_name, const char *event_name,
-				    pevent_event_handler_func func, void *context);
-int pevent_register_print_function(struct pevent *pevent,
-				   pevent_func_handler func,
-				   enum pevent_func_arg_type ret_type,
-				   char *name, ...);
-int pevent_unregister_print_function(struct pevent *pevent,
-				     pevent_func_handler func, char *name);
-
-struct format_field *pevent_find_common_field(struct event_format *event, const char *name);
-struct format_field *pevent_find_field(struct event_format *event, const char *name);
-struct format_field *pevent_find_any_field(struct event_format *event, const char *name);
-
-const char *pevent_find_function(struct pevent *pevent, unsigned long long addr);
+			   struct tep_record *record, int err);
+
+int tep_print_func_field(struct trace_seq *s, const char *fmt,
+			 struct event_format *event, const char *name,
+			 struct tep_record *record, int err);
+
+int tep_register_event_handler(struct tep_handle *pevent, int id,
+			       const char *sys_name, const char *event_name,
+			       tep_event_handler_func func, void *context);
+int tep_unregister_event_handler(struct tep_handle *pevent, int id,
+				 const char *sys_name, const char *event_name,
+				 tep_event_handler_func func, void *context);
+int tep_register_print_function(struct tep_handle *pevent,
+				tep_func_handler func,
+				enum tep_func_arg_type ret_type,
+				char *name, ...);
+int tep_unregister_print_function(struct tep_handle *pevent,
+				  tep_func_handler func, char *name);
+
+struct format_field *tep_find_common_field(struct event_format *event, const char *name);
+struct format_field *tep_find_field(struct event_format *event, const char *name);
+struct format_field *tep_find_any_field(struct event_format *event, const char *name);
+
+const char *tep_find_function(struct tep_handle *pevent, unsigned long long addr);
 unsigned long long
-pevent_find_function_address(struct pevent *pevent, unsigned long long addr);
-unsigned long long pevent_read_number(struct pevent *pevent, const void *ptr, int size);
-int pevent_read_number_field(struct format_field *field, const void *data,
-			     unsigned long long *value);
+tep_find_function_address(struct tep_handle *pevent, unsigned long long addr);
+unsigned long long tep_read_number(struct tep_handle *pevent, const void *ptr, int size);
+int tep_read_number_field(struct format_field *field, const void *data,
+			  unsigned long long *value);
 
-struct event_format *pevent_find_event(struct pevent *pevent, int id);
+struct event_format *tep_find_event(struct tep_handle *pevent, int id);
 
 struct event_format *
-pevent_find_event_by_name(struct pevent *pevent, const char *sys, const char *name);
+tep_find_event_by_name(struct tep_handle *pevent, const char *sys, const char *name);
 
 struct event_format *
-pevent_find_event_by_record(struct pevent *pevent, struct pevent_record *record);
-
-void pevent_data_lat_fmt(struct pevent *pevent,
-			 struct trace_seq *s, struct pevent_record *record);
-int pevent_data_type(struct pevent *pevent, struct pevent_record *rec);
-struct event_format *pevent_data_event_from_type(struct pevent *pevent, int type);
-int pevent_data_pid(struct pevent *pevent, struct pevent_record *rec);
-int pevent_data_preempt_count(struct pevent *pevent, struct pevent_record *rec);
-int pevent_data_flags(struct pevent *pevent, struct pevent_record *rec);
-const char *pevent_data_comm_from_pid(struct pevent *pevent, int pid);
+tep_find_event_by_record(struct tep_handle *pevent, struct tep_record *record);
+
+void tep_data_lat_fmt(struct tep_handle *pevent,
+		      struct trace_seq *s, struct tep_record *record);
+int tep_data_type(struct tep_handle *pevent, struct tep_record *rec);
+struct event_format *tep_data_event_from_type(struct tep_handle *pevent, int type);
+int tep_data_pid(struct tep_handle *pevent, struct tep_record *rec);
+int tep_data_preempt_count(struct tep_handle *pevent, struct tep_record *rec);
+int tep_data_flags(struct tep_handle *pevent, struct tep_record *rec);
+const char *tep_data_comm_from_pid(struct tep_handle *pevent, int pid);
 struct cmdline;
-struct cmdline *pevent_data_pid_from_comm(struct pevent *pevent, const char *comm,
-					  struct cmdline *next);
-int pevent_cmdline_pid(struct pevent *pevent, struct cmdline *cmdline);
-
-void pevent_print_field(struct trace_seq *s, void *data,
-			struct format_field *field);
-void pevent_print_fields(struct trace_seq *s, void *data,
-			 int size __maybe_unused, struct event_format *event);
-void pevent_event_info(struct trace_seq *s, struct event_format *event,
-		       struct pevent_record *record);
-int pevent_strerror(struct pevent *pevent, enum pevent_errno errnum,
+struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
+				       struct cmdline *next);
+int tep_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline);
+
+void tep_print_field(struct trace_seq *s, void *data,
+		     struct format_field *field);
+void tep_print_fields(struct trace_seq *s, void *data,
+		      int size __maybe_unused, struct event_format *event);
+void tep_event_info(struct trace_seq *s, struct event_format *event,
+		       struct tep_record *record);
+int tep_strerror(struct tep_handle *pevent, enum tep_errno errnum,
 		    char *buf, size_t buflen);
 
-struct event_format **pevent_list_events(struct pevent *pevent, enum event_sort_type);
-struct format_field **pevent_event_common_fields(struct event_format *event);
-struct format_field **pevent_event_fields(struct event_format *event);
+struct event_format **tep_list_events(struct tep_handle *pevent, enum event_sort_type);
+struct format_field **tep_event_common_fields(struct event_format *event);
+struct format_field **tep_event_fields(struct event_format *event);
 
-static inline int pevent_get_cpus(struct pevent *pevent)
+static inline int tep_get_cpus(struct tep_handle *pevent)
 {
 	return pevent->cpus;
 }
 
-static inline void pevent_set_cpus(struct pevent *pevent, int cpus)
+static inline void tep_set_cpus(struct tep_handle *pevent, int cpus)
 {
 	pevent->cpus = cpus;
 }
 
-static inline int pevent_get_long_size(struct pevent *pevent)
+static inline int tep_get_long_size(struct tep_handle *pevent)
 {
 	return pevent->long_size;
 }
 
-static inline void pevent_set_long_size(struct pevent *pevent, int long_size)
+static inline void tep_set_long_size(struct tep_handle *pevent, int long_size)
 {
 	pevent->long_size = long_size;
 }
 
-static inline int pevent_get_page_size(struct pevent *pevent)
+static inline int tep_get_page_size(struct tep_handle *pevent)
 {
 	return pevent->page_size;
 }
 
-static inline void pevent_set_page_size(struct pevent *pevent, int _page_size)
+static inline void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 {
 	pevent->page_size = _page_size;
 }
 
-static inline int pevent_is_file_bigendian(struct pevent *pevent)
+static inline int tep_is_file_bigendian(struct tep_handle *pevent)
 {
 	return pevent->file_bigendian;
 }
 
-static inline void pevent_set_file_bigendian(struct pevent *pevent, int endian)
+static inline void tep_set_file_bigendian(struct tep_handle *pevent, int endian)
 {
 	pevent->file_bigendian = endian;
 }
 
-static inline int pevent_is_host_bigendian(struct pevent *pevent)
+static inline int tep_is_host_bigendian(struct tep_handle *pevent)
 {
 	return pevent->host_bigendian;
 }
 
-static inline void pevent_set_host_bigendian(struct pevent *pevent, int endian)
+static inline void tep_set_host_bigendian(struct tep_handle *pevent, int endian)
 {
 	pevent->host_bigendian = endian;
 }
 
-static inline int pevent_is_latency_format(struct pevent *pevent)
+static inline int tep_is_latency_format(struct tep_handle *pevent)
 {
 	return pevent->latency_format;
 }
 
-static inline void pevent_set_latency_format(struct pevent *pevent, int lat)
+static inline void tep_set_latency_format(struct tep_handle *pevent, int lat)
 {
 	pevent->latency_format = lat;
 }
 
-struct pevent *pevent_alloc(void);
-void pevent_free(struct pevent *pevent);
-void pevent_ref(struct pevent *pevent);
-void pevent_unref(struct pevent *pevent);
+struct tep_handle *tep_alloc(void);
+void tep_free(struct tep_handle *pevent);
+void tep_ref(struct tep_handle *pevent);
+void tep_unref(struct tep_handle *pevent);
 
 /* access to the internal parser */
-void pevent_buffer_init(const char *buf, unsigned long long size);
-enum event_type pevent_read_token(char **tok);
-void pevent_free_token(char *token);
-int pevent_peek_char(void);
-const char *pevent_get_input_buf(void);
-unsigned long long pevent_get_input_buf_ptr(void);
+void tep_buffer_init(const char *buf, unsigned long long size);
+enum event_type tep_read_token(char **tok);
+void tep_free_token(char *token);
+int tep_peek_char(void);
+const char *tep_get_input_buf(void);
+unsigned long long tep_get_input_buf_ptr(void);
 
 /* for debugging */
-void pevent_print_funcs(struct pevent *pevent);
-void pevent_print_printk(struct pevent *pevent);
+void tep_print_funcs(struct tep_handle *pevent);
+void tep_print_printk(struct tep_handle *pevent);
 
 /* ----------------------- filtering ----------------------- */
 
@@ -930,22 +930,22 @@ struct filter_type {
 	struct filter_arg	*filter;
 };
 
-#define PEVENT_FILTER_ERROR_BUFSZ  1024
+#define TEP_FILTER_ERROR_BUFSZ  1024
 
 struct event_filter {
-	struct pevent		*pevent;
+	struct tep_handle	*pevent;
 	int			filters;
 	struct filter_type	*event_filters;
-	char			error_buffer[PEVENT_FILTER_ERROR_BUFSZ];
+	char			error_buffer[TEP_FILTER_ERROR_BUFSZ];
 };
 
-struct event_filter *pevent_filter_alloc(struct pevent *pevent);
+struct event_filter *tep_filter_alloc(struct tep_handle *pevent);
 
 /* for backward compatibility */
-#define FILTER_NONE		PEVENT_ERRNO__NO_FILTER
-#define FILTER_NOEXIST		PEVENT_ERRNO__FILTER_NOT_FOUND
-#define FILTER_MISS		PEVENT_ERRNO__FILTER_MISS
-#define FILTER_MATCH		PEVENT_ERRNO__FILTER_MATCH
+#define FILTER_NONE		TEP_ERRNO__NO_FILTER
+#define FILTER_NOEXIST		TEP_ERRNO__FILTER_NOT_FOUND
+#define FILTER_MISS		TEP_ERRNO__FILTER_MISS
+#define FILTER_MATCH		TEP_ERRNO__FILTER_MATCH
 
 enum filter_trivial_type {
 	FILTER_TRIVIAL_FALSE,
@@ -953,39 +953,39 @@ enum filter_trivial_type {
 	FILTER_TRIVIAL_BOTH,
 };
 
-enum pevent_errno pevent_filter_add_filter_str(struct event_filter *filter,
-					       const char *filter_str);
+enum tep_errno tep_filter_add_filter_str(struct event_filter *filter,
+					 const char *filter_str);
 
-enum pevent_errno pevent_filter_match(struct event_filter *filter,
-				      struct pevent_record *record);
+enum tep_errno tep_filter_match(struct event_filter *filter,
+				struct tep_record *record);
 
-int pevent_filter_strerror(struct event_filter *filter, enum pevent_errno err,
-			   char *buf, size_t buflen);
+int tep_filter_strerror(struct event_filter *filter, enum tep_errno err,
+			char *buf, size_t buflen);
 
-int pevent_event_filtered(struct event_filter *filter,
-			  int event_id);
+int tep_event_filtered(struct event_filter *filter,
+		       int event_id);
 
-void pevent_filter_reset(struct event_filter *filter);
+void tep_filter_reset(struct event_filter *filter);
 
-int pevent_filter_clear_trivial(struct event_filter *filter,
-				 enum filter_trivial_type type);
+int tep_filter_clear_trivial(struct event_filter *filter,
+			     enum filter_trivial_type type);
 
-void pevent_filter_free(struct event_filter *filter);
+void tep_filter_free(struct event_filter *filter);
 
-char *pevent_filter_make_string(struct event_filter *filter, int event_id);
+char *tep_filter_make_string(struct event_filter *filter, int event_id);
 
-int pevent_filter_remove_event(struct event_filter *filter,
-			       int event_id);
+int tep_filter_remove_event(struct event_filter *filter,
+			    int event_id);
 
-int pevent_filter_event_has_trivial(struct event_filter *filter,
-				    int event_id,
-				    enum filter_trivial_type type);
+int tep_filter_event_has_trivial(struct event_filter *filter,
+				 int event_id,
+				 enum filter_trivial_type type);
 
-int pevent_filter_copy(struct event_filter *dest, struct event_filter *source);
+int tep_filter_copy(struct event_filter *dest, struct event_filter *source);
 
-int pevent_update_trivial(struct event_filter *dest, struct event_filter *source,
-			  enum filter_trivial_type type);
+int tep_update_trivial(struct event_filter *dest, struct event_filter *source,
+			enum filter_trivial_type type);
 
-int pevent_filter_compare(struct event_filter *filter1, struct event_filter *filter2);
+int tep_filter_compare(struct event_filter *filter1, struct event_filter *filter2);
 
 #endif /* _PARSE_EVENTS_H */
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index d542cb60ca1a..f17e25097e1e 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
 #include <ctype.h>
@@ -34,7 +20,7 @@
 
 static struct registered_plugin_options {
 	struct registered_plugin_options	*next;
-	struct pevent_plugin_option		*options;
+	struct tep_plugin_option		*options;
 } *registered_options;
 
 static struct trace_plugin_options {
@@ -58,7 +44,7 @@ static void lower_case(char *str)
 		*str = tolower(*str);
 }
 
-static int update_option_value(struct pevent_plugin_option *op, const char *val)
+static int update_option_value(struct tep_plugin_option *op, const char *val)
 {
 	char *op_val;
 
@@ -97,7 +83,7 @@ static int update_option_value(struct pevent_plugin_option *op, const char *val)
 }
 
 /**
- * traceevent_plugin_list_options - get list of plugin options
+ * tep_plugin_list_options - get list of plugin options
  *
  * Returns an array of char strings that list the currently registered
  * plugin options in the format of <plugin>:<option>. This list can be
@@ -106,12 +92,12 @@ static int update_option_value(struct pevent_plugin_option *op, const char *val)
  * Returns NULL if there's no options registered. On error it returns
  * INVALID_PLUGIN_LIST_OPTION
  *
- * Must be freed with traceevent_plugin_free_options_list().
+ * Must be freed with tep_plugin_free_options_list().
  */
-char **traceevent_plugin_list_options(void)
+char **tep_plugin_list_options(void)
 {
 	struct registered_plugin_options *reg;
-	struct pevent_plugin_option *op;
+	struct tep_plugin_option *op;
 	char **list = NULL;
 	char *name;
 	int count = 0;
@@ -146,7 +132,7 @@ char **traceevent_plugin_list_options(void)
 	return INVALID_PLUGIN_LIST_OPTION;
 }
 
-void traceevent_plugin_free_options_list(char **list)
+void tep_plugin_free_options_list(char **list)
 {
 	int i;
 
@@ -163,7 +149,7 @@ void traceevent_plugin_free_options_list(char **list)
 }
 
 static int
-update_option(const char *file, struct pevent_plugin_option *option)
+update_option(const char *file, struct tep_plugin_option *option)
 {
 	struct trace_plugin_options *op;
 	char *plugin;
@@ -215,14 +201,14 @@ update_option(const char *file, struct pevent_plugin_option *option)
 }
 
 /**
- * traceevent_plugin_add_options - Add a set of options by a plugin
+ * tep_plugin_add_options - Add a set of options by a plugin
  * @name: The name of the plugin adding the options
  * @options: The set of options being loaded
  *
  * Sets the options with the values that have been added by user.
  */
-int traceevent_plugin_add_options(const char *name,
-				  struct pevent_plugin_option *options)
+int tep_plugin_add_options(const char *name,
+			   struct tep_plugin_option *options)
 {
 	struct registered_plugin_options *reg;
 
@@ -241,10 +227,10 @@ int traceevent_plugin_add_options(const char *name,
 }
 
 /**
- * traceevent_plugin_remove_options - remove plugin options that were registered
- * @options: Options to removed that were registered with traceevent_plugin_add_options
+ * tep_plugin_remove_options - remove plugin options that were registered
+ * @options: Options to removed that were registered with tep_plugin_add_options
  */
-void traceevent_plugin_remove_options(struct pevent_plugin_option *options)
+void tep_plugin_remove_options(struct tep_plugin_option *options)
 {
 	struct registered_plugin_options **last;
 	struct registered_plugin_options *reg;
@@ -260,19 +246,19 @@ void traceevent_plugin_remove_options(struct pevent_plugin_option *options)
 }
 
 /**
- * traceevent_print_plugins - print out the list of plugins loaded
+ * tep_print_plugins - print out the list of plugins loaded
  * @s: the trace_seq descripter to write to
  * @prefix: The prefix string to add before listing the option name
  * @suffix: The suffix string ot append after the option name
- * @list: The list of plugins (usually returned by traceevent_load_plugins()
+ * @list: The list of plugins (usually returned by tep_load_plugins()
  *
  * Writes to the trace_seq @s the list of plugins (files) that is
- * returned by traceevent_load_plugins(). Use @prefix and @suffix for formating:
+ * returned by tep_load_plugins(). Use @prefix and @suffix for formating:
  * @prefix = "  ", @suffix = "\n".
  */
-void traceevent_print_plugins(struct trace_seq *s,
-			      const char *prefix, const char *suffix,
-			      const struct plugin_list *list)
+void tep_print_plugins(struct trace_seq *s,
+		       const char *prefix, const char *suffix,
+		       const struct plugin_list *list)
 {
 	while (list) {
 		trace_seq_printf(s, "%s%s%s", prefix, list->name, suffix);
@@ -281,11 +267,11 @@ void traceevent_print_plugins(struct trace_seq *s,
 }
 
 static void
-load_plugin(struct pevent *pevent, const char *path,
+load_plugin(struct tep_handle *pevent, const char *path,
 	    const char *file, void *data)
 {
 	struct plugin_list **plugin_list = data;
-	pevent_plugin_load_func func;
+	tep_plugin_load_func func;
 	struct plugin_list *list;
 	const char *alias;
 	char *plugin;
@@ -305,14 +291,14 @@ load_plugin(struct pevent *pevent, const char *path,
 		goto out_free;
 	}
 
-	alias = dlsym(handle, PEVENT_PLUGIN_ALIAS_NAME);
+	alias = dlsym(handle, TEP_PLUGIN_ALIAS_NAME);
 	if (!alias)
 		alias = file;
 
-	func = dlsym(handle, PEVENT_PLUGIN_LOADER_NAME);
+	func = dlsym(handle, TEP_PLUGIN_LOADER_NAME);
 	if (!func) {
 		warning("could not find func '%s' in plugin '%s'\n%s\n",
-			PEVENT_PLUGIN_LOADER_NAME, plugin, dlerror());
+			TEP_PLUGIN_LOADER_NAME, plugin, dlerror());
 		goto out_free;
 	}
 
@@ -336,9 +322,9 @@ load_plugin(struct pevent *pevent, const char *path,
 }
 
 static void
-load_plugins_dir(struct pevent *pevent, const char *suffix,
+load_plugins_dir(struct tep_handle *pevent, const char *suffix,
 		 const char *path,
-		 void (*load_plugin)(struct pevent *pevent,
+		 void (*load_plugin)(struct tep_handle *pevent,
 				     const char *path,
 				     const char *name,
 				     void *data),
@@ -378,8 +364,8 @@ load_plugins_dir(struct pevent *pevent, const char *suffix,
 }
 
 static void
-load_plugins(struct pevent *pevent, const char *suffix,
-	     void (*load_plugin)(struct pevent *pevent,
+load_plugins(struct tep_handle *pevent, const char *suffix,
+	     void (*load_plugin)(struct tep_handle *pevent,
 				 const char *path,
 				 const char *name,
 				 void *data),
@@ -390,7 +376,7 @@ load_plugins(struct pevent *pevent, const char *suffix,
 	char *envdir;
 	int ret;
 
-	if (pevent->flags & PEVENT_DISABLE_PLUGINS)
+	if (pevent->flags & TEP_DISABLE_PLUGINS)
 		return;
 
 	/*
@@ -398,7 +384,7 @@ load_plugins(struct pevent *pevent, const char *suffix,
 	 * check that first.
 	 */
 #ifdef PLUGIN_DIR
-	if (!(pevent->flags & PEVENT_DISABLE_SYS_PLUGINS))
+	if (!(pevent->flags & TEP_DISABLE_SYS_PLUGINS))
 		load_plugins_dir(pevent, suffix, PLUGIN_DIR,
 				 load_plugin, data);
 #endif
@@ -431,7 +417,7 @@ load_plugins(struct pevent *pevent, const char *suffix,
 }
 
 struct plugin_list*
-traceevent_load_plugins(struct pevent *pevent)
+tep_load_plugins(struct tep_handle *pevent)
 {
 	struct plugin_list *list = NULL;
 
@@ -440,15 +426,15 @@ traceevent_load_plugins(struct pevent *pevent)
 }
 
 void
-traceevent_unload_plugins(struct plugin_list *plugin_list, struct pevent *pevent)
+tep_unload_plugins(struct plugin_list *plugin_list, struct tep_handle *pevent)
 {
-	pevent_plugin_unload_func func;
+	tep_plugin_unload_func func;
 	struct plugin_list *list;
 
 	while (plugin_list) {
 		list = plugin_list;
 		plugin_list = list->next;
-		func = dlsym(list->handle, PEVENT_PLUGIN_UNLOADER_NAME);
+		func = dlsym(list->handle, TEP_PLUGIN_UNLOADER_NAME);
 		if (func)
 			func(pevent);
 		dlclose(list->handle);
diff --git a/tools/lib/traceevent/event-utils.h b/tools/lib/traceevent/event-utils.h
index d1dc2170e402..0560b96a31d1 100644
--- a/tools/lib/traceevent/event-utils.h
+++ b/tools/lib/traceevent/event-utils.h
@@ -1,21 +1,7 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
 /*
  * Copyright (C) 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #ifndef __UTIL_H
 #define __UTIL_H
diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
index ca424b157e46..af2a1f3b7424 100644
--- a/tools/lib/traceevent/kbuffer-parse.c
+++ b/tools/lib/traceevent/kbuffer-parse.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 431e8b309f6e..e76154c02ee7 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * Copyright (C) 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <stdio.h>
 #include <stdlib.h>
@@ -51,8 +37,8 @@ static void show_error(char *error_buf, const char *fmt, ...)
 	int len;
 	int i;
 
-	input = pevent_get_input_buf();
-	index = pevent_get_input_buf_ptr();
+	input = tep_get_input_buf();
+	index = tep_get_input_buf_ptr();
 	len = input ? strlen(input) : 0;
 
 	if (len) {
@@ -66,13 +52,13 @@ static void show_error(char *error_buf, const char *fmt, ...)
 	}
 
 	va_start(ap, fmt);
-	vsnprintf(error_buf + len, PEVENT_FILTER_ERROR_BUFSZ - len, fmt, ap);
+	vsnprintf(error_buf + len, TEP_FILTER_ERROR_BUFSZ - len, fmt, ap);
 	va_end(ap);
 }
 
 static void free_token(char *token)
 {
-	pevent_free_token(token);
+	tep_free_token(token);
 }
 
 static enum event_type read_token(char **tok)
@@ -82,13 +68,13 @@ static enum event_type read_token(char **tok)
 
 	do {
 		free_token(token);
-		type = pevent_read_token(&token);
+		type = tep_read_token(&token);
 	} while (type == EVENT_NEWLINE || type == EVENT_SPACE);
 
 	/* If token is = or ! check to see if the next char is ~ */
 	if (token &&
 	    (strcmp(token, "=") == 0 || strcmp(token, "!") == 0) &&
-	    pevent_peek_char() == '~') {
+	    tep_peek_char() == '~') {
 		/* append it */
 		*tok = malloc(3);
 		if (*tok == NULL) {
@@ -98,7 +84,7 @@ static enum event_type read_token(char **tok)
 		sprintf(*tok, "%c%c", *token, '~');
 		free_token(token);
 		/* Now remove the '~' from the buffer */
-		pevent_read_token(&token);
+		tep_read_token(&token);
 		free_token(token);
 	} else
 		*tok = token;
@@ -167,7 +153,7 @@ add_filter_type(struct event_filter *filter, int id)
 
 	filter_type = &filter->event_filters[i];
 	filter_type->event_id = id;
-	filter_type->event = pevent_find_event(filter->pevent, id);
+	filter_type->event = tep_find_event(filter->pevent, id);
 	filter_type->filter = NULL;
 
 	filter->filters++;
@@ -176,10 +162,10 @@ add_filter_type(struct event_filter *filter, int id)
 }
 
 /**
- * pevent_filter_alloc - create a new event filter
+ * tep_filter_alloc - create a new event filter
  * @pevent: The pevent that this filter is associated with
  */
-struct event_filter *pevent_filter_alloc(struct pevent *pevent)
+struct event_filter *tep_filter_alloc(struct tep_handle *pevent)
 {
 	struct event_filter *filter;
 
@@ -189,7 +175,7 @@ struct event_filter *pevent_filter_alloc(struct pevent *pevent)
 
 	memset(filter, 0, sizeof(*filter));
 	filter->pevent = pevent;
-	pevent_ref(pevent);
+	tep_ref(pevent);
 
 	return filter;
 }
@@ -268,8 +254,8 @@ static int event_match(struct event_format *event,
 		!regexec(ereg, event->name, 0, NULL, 0);
 }
 
-static enum pevent_errno
-find_event(struct pevent *pevent, struct event_list **events,
+static enum tep_errno
+find_event(struct tep_handle *pevent, struct event_list **events,
 	   char *sys_name, char *event_name)
 {
 	struct event_format *event;
@@ -289,26 +275,26 @@ find_event(struct pevent *pevent, struct event_list **events,
 
 	ret = asprintf(&reg, "^%s$", event_name);
 	if (ret < 0)
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 
 	ret = regcomp(&ereg, reg, REG_ICASE|REG_NOSUB);
 	free(reg);
 
 	if (ret)
-		return PEVENT_ERRNO__INVALID_EVENT_NAME;
+		return TEP_ERRNO__INVALID_EVENT_NAME;
 
 	if (sys_name) {
 		ret = asprintf(&reg, "^%s$", sys_name);
 		if (ret < 0) {
 			regfree(&ereg);
-			return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+			return TEP_ERRNO__MEM_ALLOC_FAILED;
 		}
 
 		ret = regcomp(&sreg, reg, REG_ICASE|REG_NOSUB);
 		free(reg);
 		if (ret) {
 			regfree(&ereg);
-			return PEVENT_ERRNO__INVALID_EVENT_NAME;
+			return TEP_ERRNO__INVALID_EVENT_NAME;
 		}
 	}
 
@@ -328,9 +314,9 @@ find_event(struct pevent *pevent, struct event_list **events,
 		regfree(&sreg);
 
 	if (!match)
-		return PEVENT_ERRNO__EVENT_NOT_FOUND;
+		return TEP_ERRNO__EVENT_NOT_FOUND;
 	if (fail)
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 
 	return 0;
 }
@@ -346,7 +332,7 @@ static void free_events(struct event_list *events)
 	}
 }
 
-static enum pevent_errno
+static enum tep_errno
 create_arg_item(struct event_format *event, const char *token,
 		enum event_type type, struct filter_arg **parg, char *error_str)
 {
@@ -356,7 +342,7 @@ create_arg_item(struct event_format *event, const char *token,
 	arg = allocate_arg();
 	if (arg == NULL) {
 		show_error(error_str, "failed to allocate filter arg");
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 	}
 
 	switch (type) {
@@ -370,7 +356,7 @@ create_arg_item(struct event_format *event, const char *token,
 		if (!arg->value.str) {
 			free_arg(arg);
 			show_error(error_str, "failed to allocate string filter arg");
-			return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+			return TEP_ERRNO__MEM_ALLOC_FAILED;
 		}
 		break;
 	case EVENT_ITEM:
@@ -382,7 +368,7 @@ create_arg_item(struct event_format *event, const char *token,
 			break;
 		}
 		/* Consider this a field */
-		field = pevent_find_any_field(event, token);
+		field = tep_find_any_field(event, token);
 		if (!field) {
 			/* If token is 'COMM' or 'CPU' then it is special */
 			if (strcmp(token, COMM) == 0) {
@@ -402,7 +388,7 @@ create_arg_item(struct event_format *event, const char *token,
 	default:
 		free_arg(arg);
 		show_error(error_str, "expected a value but found %s", token);
-		return PEVENT_ERRNO__UNEXPECTED_TYPE;
+		return TEP_ERRNO__UNEXPECTED_TYPE;
 	}
 	*parg = arg;
 	return 0;
@@ -454,7 +440,7 @@ create_arg_cmp(enum filter_cmp_type ctype)
 	return arg;
 }
 
-static enum pevent_errno
+static enum tep_errno
 add_right(struct filter_arg *op, struct filter_arg *arg, char *error_str)
 {
 	struct filter_arg *left;
@@ -487,7 +473,7 @@ add_right(struct filter_arg *op, struct filter_arg *arg, char *error_str)
 			break;
 		default:
 			show_error(error_str, "Illegal rvalue");
-			return PEVENT_ERRNO__ILLEGAL_RVALUE;
+			return TEP_ERRNO__ILLEGAL_RVALUE;
 		}
 
 		/*
@@ -534,7 +520,7 @@ add_right(struct filter_arg *op, struct filter_arg *arg, char *error_str)
 			if (left->type != FILTER_ARG_FIELD) {
 				show_error(error_str,
 					   "Illegal lvalue for string comparison");
-				return PEVENT_ERRNO__ILLEGAL_LVALUE;
+				return TEP_ERRNO__ILLEGAL_LVALUE;
 			}
 
 			/* Make sure this is a valid string compare */
@@ -553,13 +539,13 @@ add_right(struct filter_arg *op, struct filter_arg *arg, char *error_str)
 					show_error(error_str,
 						   "RegEx '%s' did not compute",
 						   str);
-					return PEVENT_ERRNO__INVALID_REGEX;
+					return TEP_ERRNO__INVALID_REGEX;
 				}
 				break;
 			default:
 				show_error(error_str,
 					   "Illegal comparison for string");
-				return PEVENT_ERRNO__ILLEGAL_STRING_CMP;
+				return TEP_ERRNO__ILLEGAL_STRING_CMP;
 			}
 
 			op->type = FILTER_ARG_STR;
@@ -568,7 +554,7 @@ add_right(struct filter_arg *op, struct filter_arg *arg, char *error_str)
 			op->str.val = strdup(str);
 			if (!op->str.val) {
 				show_error(error_str, "Failed to allocate string filter");
-				return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+				return TEP_ERRNO__MEM_ALLOC_FAILED;
 			}
 			/*
 			 * Need a buffer to copy data for tests
@@ -576,7 +562,7 @@ add_right(struct filter_arg *op, struct filter_arg *arg, char *error_str)
 			op->str.buffer = malloc(op->str.field->size + 1);
 			if (!op->str.buffer) {
 				show_error(error_str, "Failed to allocate string filter");
-				return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+				return TEP_ERRNO__MEM_ALLOC_FAILED;
 			}
 			/* Null terminate this buffer */
 			op->str.buffer[op->str.field->size] = 0;
@@ -595,7 +581,7 @@ add_right(struct filter_arg *op, struct filter_arg *arg, char *error_str)
 			case FILTER_CMP_NOT_REGEX:
 				show_error(error_str,
 					   "Op not allowed with integers");
-				return PEVENT_ERRNO__ILLEGAL_INTEGER_CMP;
+				return TEP_ERRNO__ILLEGAL_INTEGER_CMP;
 
 			default:
 				break;
@@ -616,7 +602,7 @@ add_right(struct filter_arg *op, struct filter_arg *arg, char *error_str)
 
  out_fail:
 	show_error(error_str, "Syntax error");
-	return PEVENT_ERRNO__SYNTAX_ERROR;
+	return TEP_ERRNO__SYNTAX_ERROR;
 }
 
 static struct filter_arg *
@@ -629,7 +615,7 @@ rotate_op_right(struct filter_arg *a, struct filter_arg *b)
 	return arg;
 }
 
-static enum pevent_errno add_left(struct filter_arg *op, struct filter_arg *arg)
+static enum tep_errno add_left(struct filter_arg *op, struct filter_arg *arg)
 {
 	switch (op->type) {
 	case FILTER_ARG_EXP:
@@ -648,11 +634,11 @@ static enum pevent_errno add_left(struct filter_arg *op, struct filter_arg *arg)
 		/* left arg of compares must be a field */
 		if (arg->type != FILTER_ARG_FIELD &&
 		    arg->type != FILTER_ARG_BOOLEAN)
-			return PEVENT_ERRNO__INVALID_ARG_TYPE;
+			return TEP_ERRNO__INVALID_ARG_TYPE;
 		op->num.left = arg;
 		break;
 	default:
-		return PEVENT_ERRNO__INVALID_ARG_TYPE;
+		return TEP_ERRNO__INVALID_ARG_TYPE;
 	}
 	return 0;
 }
@@ -765,7 +751,7 @@ enum filter_vals {
 	FILTER_VAL_TRUE,
 };
 
-static enum pevent_errno
+static enum tep_errno
 reparent_op_arg(struct filter_arg *parent, struct filter_arg *old_child,
 		struct filter_arg *arg, char *error_str)
 {
@@ -775,7 +761,7 @@ reparent_op_arg(struct filter_arg *parent, struct filter_arg *old_child,
 	if (parent->type != FILTER_ARG_OP &&
 	    arg->type != FILTER_ARG_OP) {
 		show_error(error_str, "can not reparent other than OP");
-		return PEVENT_ERRNO__REPARENT_NOT_OP;
+		return TEP_ERRNO__REPARENT_NOT_OP;
 	}
 
 	/* Get the sibling */
@@ -787,7 +773,7 @@ reparent_op_arg(struct filter_arg *parent, struct filter_arg *old_child,
 		other_child = old_child->op.right;
 	} else {
 		show_error(error_str, "Error in reparent op, find other child");
-		return PEVENT_ERRNO__REPARENT_FAILED;
+		return TEP_ERRNO__REPARENT_FAILED;
 	}
 
 	/* Detach arg from old_child */
@@ -808,7 +794,7 @@ reparent_op_arg(struct filter_arg *parent, struct filter_arg *old_child,
 		ptr = &parent->op.left;
 	else {
 		show_error(error_str, "Error in reparent op");
-		return PEVENT_ERRNO__REPARENT_FAILED;
+		return TEP_ERRNO__REPARENT_FAILED;
 	}
 
 	*ptr = arg;
@@ -817,7 +803,7 @@ reparent_op_arg(struct filter_arg *parent, struct filter_arg *old_child,
 	return 0;
 }
 
-/* Returns either filter_vals (success) or pevent_errno (failfure) */
+/* Returns either filter_vals (success) or tep_errno (failfure) */
 static int test_arg(struct filter_arg *parent, struct filter_arg *arg,
 		    char *error_str)
 {
@@ -912,7 +898,7 @@ static int test_arg(struct filter_arg *parent, struct filter_arg *arg,
 		return rval;
 	default:
 		show_error(error_str, "bad arg in filter tree");
-		return PEVENT_ERRNO__BAD_FILTER_ARG;
+		return TEP_ERRNO__BAD_FILTER_ARG;
 	}
 	return FILTER_VAL_NORM;
 }
@@ -937,7 +923,7 @@ static int collapse_tree(struct filter_arg *arg,
 			arg->boolean.value = ret == FILTER_VAL_TRUE;
 		} else {
 			show_error(error_str, "Failed to allocate filter arg");
-			ret = PEVENT_ERRNO__MEM_ALLOC_FAILED;
+			ret = TEP_ERRNO__MEM_ALLOC_FAILED;
 		}
 		break;
 
@@ -952,7 +938,7 @@ static int collapse_tree(struct filter_arg *arg,
 	return ret;
 }
 
-static enum pevent_errno
+static enum tep_errno
 process_filter(struct event_format *event, struct filter_arg **parg,
 	       char *error_str, int not)
 {
@@ -966,7 +952,7 @@ process_filter(struct event_format *event, struct filter_arg **parg,
 	enum filter_op_type btype;
 	enum filter_exp_type etype;
 	enum filter_cmp_type ctype;
-	enum pevent_errno ret;
+	enum tep_errno ret;
 
 	*parg = NULL;
 
@@ -1004,7 +990,7 @@ process_filter(struct event_format *event, struct filter_arg **parg,
 		case EVENT_DELIM:
 			if (*token == ',') {
 				show_error(error_str, "Illegal token ','");
-				ret = PEVENT_ERRNO__ILLEGAL_TOKEN;
+				ret = TEP_ERRNO__ILLEGAL_TOKEN;
 				goto fail;
 			}
 
@@ -1012,22 +998,22 @@ process_filter(struct event_format *event, struct filter_arg **parg,
 				if (left_item) {
 					show_error(error_str,
 						   "Open paren can not come after item");
-					ret = PEVENT_ERRNO__INVALID_PAREN;
+					ret = TEP_ERRNO__INVALID_PAREN;
 					goto fail;
 				}
 				if (current_exp) {
 					show_error(error_str,
 						   "Open paren can not come after expression");
-					ret = PEVENT_ERRNO__INVALID_PAREN;
+					ret = TEP_ERRNO__INVALID_PAREN;
 					goto fail;
 				}
 
 				ret = process_filter(event, &arg, error_str, 0);
-				if (ret != PEVENT_ERRNO__UNBALANCED_PAREN) {
+				if (ret != TEP_ERRNO__UNBALANCED_PAREN) {
 					if (ret == 0) {
 						show_error(error_str,
 							   "Unbalanced number of '('");
-						ret = PEVENT_ERRNO__UNBALANCED_PAREN;
+						ret = TEP_ERRNO__UNBALANCED_PAREN;
 					}
 					goto fail;
 				}
@@ -1064,7 +1050,7 @@ process_filter(struct event_format *event, struct filter_arg **parg,
 				else
 					*parg = current_exp;
 				free(token);
-				return PEVENT_ERRNO__UNBALANCED_PAREN;
+				return TEP_ERRNO__UNBALANCED_PAREN;
 			}
 			break;
 
@@ -1091,7 +1077,7 @@ process_filter(struct event_format *event, struct filter_arg **parg,
 			case OP_NONE:
 				show_error(error_str,
 					   "Unknown op token %s", token);
-				ret = PEVENT_ERRNO__UNKNOWN_TOKEN;
+				ret = TEP_ERRNO__UNKNOWN_TOKEN;
 				goto fail;
 			}
 
@@ -1179,11 +1165,11 @@ process_filter(struct event_format *event, struct filter_arg **parg,
 
  fail_alloc:
 	show_error(error_str, "failed to allocate filter arg");
-	ret = PEVENT_ERRNO__MEM_ALLOC_FAILED;
+	ret = TEP_ERRNO__MEM_ALLOC_FAILED;
 	goto fail;
  fail_syntax:
 	show_error(error_str, "Syntax error");
-	ret = PEVENT_ERRNO__SYNTAX_ERROR;
+	ret = TEP_ERRNO__SYNTAX_ERROR;
  fail:
 	free_arg(current_op);
 	free_arg(current_exp);
@@ -1192,13 +1178,13 @@ process_filter(struct event_format *event, struct filter_arg **parg,
 	return ret;
 }
 
-static enum pevent_errno
+static enum tep_errno
 process_event(struct event_format *event, const char *filter_str,
 	      struct filter_arg **parg, char *error_str)
 {
 	int ret;
 
-	pevent_buffer_init(filter_str, strlen(filter_str));
+	tep_buffer_init(filter_str, strlen(filter_str));
 
 	ret = process_filter(event, parg, error_str, 0);
 	if (ret < 0)
@@ -1208,7 +1194,7 @@ process_event(struct event_format *event, const char *filter_str,
 	if (!*parg) {
 		*parg = allocate_arg();
 		if (*parg == NULL)
-			return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+			return TEP_ERRNO__MEM_ALLOC_FAILED;
 
 		(*parg)->type = FILTER_ARG_BOOLEAN;
 		(*parg)->boolean.value = FILTER_FALSE;
@@ -1217,13 +1203,13 @@ process_event(struct event_format *event, const char *filter_str,
 	return 0;
 }
 
-static enum pevent_errno
+static enum tep_errno
 filter_event(struct event_filter *filter, struct event_format *event,
 	     const char *filter_str, char *error_str)
 {
 	struct filter_type *filter_type;
 	struct filter_arg *arg;
-	enum pevent_errno ret;
+	enum tep_errno ret;
 
 	if (filter_str) {
 		ret = process_event(event, filter_str, &arg, error_str);
@@ -1234,7 +1220,7 @@ filter_event(struct event_filter *filter, struct event_format *event,
 		/* just add a TRUE arg */
 		arg = allocate_arg();
 		if (arg == NULL)
-			return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+			return TEP_ERRNO__MEM_ALLOC_FAILED;
 
 		arg->type = FILTER_ARG_BOOLEAN;
 		arg->boolean.value = FILTER_TRUE;
@@ -1242,7 +1228,7 @@ filter_event(struct event_filter *filter, struct event_format *event,
 
 	filter_type = add_filter_type(filter, event->id);
 	if (filter_type == NULL)
-		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+		return TEP_ERRNO__MEM_ALLOC_FAILED;
 
 	if (filter_type->filter)
 		free_arg(filter_type->filter);
@@ -1254,23 +1240,23 @@ filter_event(struct event_filter *filter, struct event_format *event,
 static void filter_init_error_buf(struct event_filter *filter)
 {
 	/* clear buffer to reset show error */
-	pevent_buffer_init("", 0);
+	tep_buffer_init("", 0);
 	filter->error_buffer[0] = '\0';
 }
 
 /**
- * pevent_filter_add_filter_str - add a new filter
+ * tep_filter_add_filter_str - add a new filter
  * @filter: the event filter to add to
  * @filter_str: the filter string that contains the filter
  *
  * Returns 0 if the filter was successfully added or a
- * negative error code.  Use pevent_filter_strerror() to see
+ * negative error code.  Use tep_filter_strerror() to see
  * actual error message in case of error.
  */
-enum pevent_errno pevent_filter_add_filter_str(struct event_filter *filter,
-					       const char *filter_str)
+enum tep_errno tep_filter_add_filter_str(struct event_filter *filter,
+					 const char *filter_str)
 {
-	struct pevent *pevent = filter->pevent;
+	struct tep_handle *pevent = filter->pevent;
 	struct event_list *event;
 	struct event_list *events = NULL;
 	const char *filter_start;
@@ -1279,7 +1265,7 @@ enum pevent_errno pevent_filter_add_filter_str(struct event_filter *filter,
 	char *event_name = NULL;
 	char *sys_name = NULL;
 	char *sp;
-	enum pevent_errno rtn = 0; /* PEVENT_ERRNO__SUCCESS */
+	enum tep_errno rtn = 0; /* TEP_ERRNO__SUCCESS */
 	int len;
 	int ret;
 
@@ -1305,7 +1291,7 @@ enum pevent_errno pevent_filter_add_filter_str(struct event_filter *filter,
 		if (this_event == NULL) {
 			/* This can only happen when events is NULL, but still */
 			free_events(events);
-			return PEVENT_ERRNO__MEM_ALLOC_FAILED;
+			return TEP_ERRNO__MEM_ALLOC_FAILED;
 		}
 		memcpy(this_event, filter_str, len);
 		this_event[len] = 0;
@@ -1322,7 +1308,7 @@ enum pevent_errno pevent_filter_add_filter_str(struct event_filter *filter,
 			/* This can only happen when events is NULL, but still */
 			free_events(events);
 			free(this_event);
-			return PEVENT_ERRNO__FILTER_NOT_FOUND;
+			return TEP_ERRNO__FILTER_NOT_FOUND;
 		}
 
 		/* Find this event */
@@ -1349,7 +1335,7 @@ enum pevent_errno pevent_filter_add_filter_str(struct event_filter *filter,
 
 		if (ret >= 0 && pevent->test_filters) {
 			char *test;
-			test = pevent_filter_make_string(filter, event->event->id);
+			test = tep_filter_make_string(filter, event->event->id);
 			if (test) {
 				printf(" '%s: %s'\n", event->event->name, test);
 				free(test);
@@ -1371,7 +1357,7 @@ static void free_filter_type(struct filter_type *filter_type)
 }
 
 /**
- * pevent_filter_strerror - fill error message in a buffer
+ * tep_filter_strerror - fill error message in a buffer
  * @filter: the event filter contains error
  * @err: the error code
  * @buf: the buffer to be filled in
@@ -1379,10 +1365,10 @@ static void free_filter_type(struct filter_type *filter_type)
  *
  * Returns 0 if message was filled successfully, -1 if error
  */
-int pevent_filter_strerror(struct event_filter *filter, enum pevent_errno err,
-			   char *buf, size_t buflen)
+int tep_filter_strerror(struct event_filter *filter, enum tep_errno err,
+			char *buf, size_t buflen)
 {
-	if (err <= __PEVENT_ERRNO__START || err >= __PEVENT_ERRNO__END)
+	if (err <= __TEP_ERRNO__START || err >= __TEP_ERRNO__END)
 		return -1;
 
 	if (strlen(filter->error_buffer) > 0) {
@@ -1393,11 +1379,11 @@ int pevent_filter_strerror(struct event_filter *filter, enum pevent_errno err,
 		return 0;
 	}
 
-	return pevent_strerror(filter->pevent, err, buf, buflen);
+	return tep_strerror(filter->pevent, err, buf, buflen);
 }
 
 /**
- * pevent_filter_remove_event - remove a filter for an event
+ * tep_filter_remove_event - remove a filter for an event
  * @filter: the event filter to remove from
  * @event_id: the event to remove a filter for
  *
@@ -1407,8 +1393,8 @@ int pevent_filter_strerror(struct event_filter *filter, enum pevent_errno err,
  * Returns 1: if an event was removed
  *   0: if the event was not found
  */
-int pevent_filter_remove_event(struct event_filter *filter,
-			       int event_id)
+int tep_filter_remove_event(struct event_filter *filter,
+			    int event_id)
 {
 	struct filter_type *filter_type;
 	unsigned long len;
@@ -1437,12 +1423,12 @@ int pevent_filter_remove_event(struct event_filter *filter,
 }
 
 /**
- * pevent_filter_reset - clear all filters in a filter
+ * tep_filter_reset - clear all filters in a filter
  * @filter: the event filter to reset
  *
  * Removes all filters from a filter and resets it.
  */
-void pevent_filter_reset(struct event_filter *filter)
+void tep_filter_reset(struct event_filter *filter)
 {
 	int i;
 
@@ -1454,11 +1440,11 @@ void pevent_filter_reset(struct event_filter *filter)
 	filter->event_filters = NULL;
 }
 
-void pevent_filter_free(struct event_filter *filter)
+void tep_filter_free(struct event_filter *filter)
 {
-	pevent_unref(filter->pevent);
+	tep_unref(filter->pevent);
 
-	pevent_filter_reset(filter);
+	tep_filter_reset(filter);
 
 	free(filter);
 }
@@ -1478,7 +1464,7 @@ static int copy_filter_type(struct event_filter *filter,
 	/* Can't assume that the pevent's are the same */
 	sys = filter_type->event->system;
 	name = filter_type->event->name;
-	event = pevent_find_event_by_name(filter->pevent, sys, name);
+	event = tep_find_event_by_name(filter->pevent, sys, name);
 	if (!event)
 		return -1;
 
@@ -1515,18 +1501,18 @@ static int copy_filter_type(struct event_filter *filter,
 }
 
 /**
- * pevent_filter_copy - copy a filter using another filter
+ * tep_filter_copy - copy a filter using another filter
  * @dest - the filter to copy to
  * @source - the filter to copy from
  *
  * Returns 0 on success and -1 if not all filters were copied
  */
-int pevent_filter_copy(struct event_filter *dest, struct event_filter *source)
+int tep_filter_copy(struct event_filter *dest, struct event_filter *source)
 {
 	int ret = 0;
 	int i;
 
-	pevent_filter_reset(dest);
+	tep_filter_reset(dest);
 
 	for (i = 0; i < source->filters; i++) {
 		if (copy_filter_type(dest, source, &source->event_filters[i]))
@@ -1537,7 +1523,7 @@ int pevent_filter_copy(struct event_filter *dest, struct event_filter *source)
 
 
 /**
- * pevent_update_trivial - update the trivial filters with the given filter
+ * tep_update_trivial - update the trivial filters with the given filter
  * @dest - the filter to update
  * @source - the filter as the source of the update
  * @type - the type of trivial filter to update.
@@ -1547,11 +1533,11 @@ int pevent_filter_copy(struct event_filter *dest, struct event_filter *source)
  * Returns 0 on success and -1 if there was a problem updating, but
  *   events may have still been updated on error.
  */
-int pevent_update_trivial(struct event_filter *dest, struct event_filter *source,
-			  enum filter_trivial_type type)
+int tep_update_trivial(struct event_filter *dest, struct event_filter *source,
+		       enum filter_trivial_type type)
 {
-	struct pevent *src_pevent;
-	struct pevent *dest_pevent;
+	struct tep_handle *src_pevent;
+	struct tep_handle *dest_pevent;
 	struct event_format *event;
 	struct filter_type *filter_type;
 	struct filter_arg *arg;
@@ -1578,14 +1564,14 @@ int pevent_update_trivial(struct event_filter *dest, struct event_filter *source
 
 		if (src_pevent != dest_pevent) {
 			/* do a look up */
-			event = pevent_find_event_by_name(src_pevent,
-							  event->system,
-							  event->name);
+			event = tep_find_event_by_name(src_pevent,
+						       event->system,
+						       event->name);
 			if (!event)
 				return -1;
 		}
 
-		str = pevent_filter_make_string(source, event->id);
+		str = tep_filter_make_string(source, event->id);
 		if (!str)
 			continue;
 
@@ -1598,7 +1584,7 @@ int pevent_update_trivial(struct event_filter *dest, struct event_filter *source
 }
 
 /**
- * pevent_filter_clear_trivial - clear TRUE and FALSE filters
+ * tep_filter_clear_trivial - clear TRUE and FALSE filters
  * @filter: the filter to remove trivial filters from
  * @type: remove only true, false, or both
  *
@@ -1606,8 +1592,8 @@ int pevent_update_trivial(struct event_filter *dest, struct event_filter *source
  *
  * Returns 0 on success and -1 if there was a problem.
  */
-int pevent_filter_clear_trivial(struct event_filter *filter,
-				 enum filter_trivial_type type)
+int tep_filter_clear_trivial(struct event_filter *filter,
+			     enum filter_trivial_type type)
 {
 	struct filter_type *filter_type;
 	int count = 0;
@@ -1653,14 +1639,14 @@ int pevent_filter_clear_trivial(struct event_filter *filter,
 		return 0;
 
 	for (i = 0; i < count; i++)
-		pevent_filter_remove_event(filter, ids[i]);
+		tep_filter_remove_event(filter, ids[i]);
 
 	free(ids);
 	return 0;
 }
 
 /**
- * pevent_filter_event_has_trivial - return true event contains trivial filter
+ * tep_filter_event_has_trivial - return true event contains trivial filter
  * @filter: the filter with the information
  * @event_id: the id of the event to test
  * @type: trivial type to test for (TRUE, FALSE, EITHER)
@@ -1668,9 +1654,9 @@ int pevent_filter_clear_trivial(struct event_filter *filter,
  * Returns 1 if the event contains a matching trivial type
  *  otherwise 0.
  */
-int pevent_filter_event_has_trivial(struct event_filter *filter,
-				    int event_id,
-				    enum filter_trivial_type type)
+int tep_filter_event_has_trivial(struct event_filter *filter,
+				 int event_id,
+				 enum filter_trivial_type type)
 {
 	struct filter_type *filter_type;
 
@@ -1697,22 +1683,22 @@ int pevent_filter_event_has_trivial(struct event_filter *filter,
 }
 
 static int test_filter(struct event_format *event, struct filter_arg *arg,
-		       struct pevent_record *record, enum pevent_errno *err);
+		       struct tep_record *record, enum tep_errno *err);
 
 static const char *
-get_comm(struct event_format *event, struct pevent_record *record)
+get_comm(struct event_format *event, struct tep_record *record)
 {
 	const char *comm;
 	int pid;
 
-	pid = pevent_data_pid(event->pevent, record);
-	comm = pevent_data_comm_from_pid(event->pevent, pid);
+	pid = tep_data_pid(event->pevent, record);
+	comm = tep_data_comm_from_pid(event->pevent, pid);
 	return comm;
 }
 
 static unsigned long long
 get_value(struct event_format *event,
-	  struct format_field *field, struct pevent_record *record)
+	  struct format_field *field, struct tep_record *record)
 {
 	unsigned long long val;
 
@@ -1728,7 +1714,7 @@ get_value(struct event_format *event,
 	if (field == &cpu)
 		return record->cpu;
 
-	pevent_read_number_field(field, record->data, &val);
+	tep_read_number_field(field, record->data, &val);
 
 	if (!(field->flags & FIELD_IS_SIGNED))
 		return val;
@@ -1748,11 +1734,11 @@ get_value(struct event_format *event,
 
 static unsigned long long
 get_arg_value(struct event_format *event, struct filter_arg *arg,
-	      struct pevent_record *record, enum pevent_errno *err);
+	      struct tep_record *record, enum tep_errno *err);
 
 static unsigned long long
 get_exp_value(struct event_format *event, struct filter_arg *arg,
-	      struct pevent_record *record, enum pevent_errno *err)
+	      struct tep_record *record, enum tep_errno *err)
 {
 	unsigned long long lval, rval;
 
@@ -1800,14 +1786,14 @@ get_exp_value(struct event_format *event, struct filter_arg *arg,
 	case FILTER_EXP_NOT:
 	default:
 		if (!*err)
-			*err = PEVENT_ERRNO__INVALID_EXP_TYPE;
+			*err = TEP_ERRNO__INVALID_EXP_TYPE;
 	}
 	return 0;
 }
 
 static unsigned long long
 get_arg_value(struct event_format *event, struct filter_arg *arg,
-	      struct pevent_record *record, enum pevent_errno *err)
+	      struct tep_record *record, enum tep_errno *err)
 {
 	switch (arg->type) {
 	case FILTER_ARG_FIELD:
@@ -1816,7 +1802,7 @@ get_arg_value(struct event_format *event, struct filter_arg *arg,
 	case FILTER_ARG_VALUE:
 		if (arg->value.type != FILTER_NUMBER) {
 			if (!*err)
-				*err = PEVENT_ERRNO__NOT_A_NUMBER;
+				*err = TEP_ERRNO__NOT_A_NUMBER;
 		}
 		return arg->value.val;
 
@@ -1825,13 +1811,13 @@ get_arg_value(struct event_format *event, struct filter_arg *arg,
 
 	default:
 		if (!*err)
-			*err = PEVENT_ERRNO__INVALID_ARG_TYPE;
+			*err = TEP_ERRNO__INVALID_ARG_TYPE;
 	}
 	return 0;
 }
 
 static int test_num(struct event_format *event, struct filter_arg *arg,
-		    struct pevent_record *record, enum pevent_errno *err)
+		    struct tep_record *record, enum tep_errno *err)
 {
 	unsigned long long lval, rval;
 
@@ -1866,15 +1852,15 @@ static int test_num(struct event_format *event, struct filter_arg *arg,
 
 	default:
 		if (!*err)
-			*err = PEVENT_ERRNO__ILLEGAL_INTEGER_CMP;
+			*err = TEP_ERRNO__ILLEGAL_INTEGER_CMP;
 		return 0;
 	}
 }
 
-static const char *get_field_str(struct filter_arg *arg, struct pevent_record *record)
+static const char *get_field_str(struct filter_arg *arg, struct tep_record *record)
 {
 	struct event_format *event;
-	struct pevent *pevent;
+	struct tep_handle *pevent;
 	unsigned long long addr;
 	const char *val = NULL;
 	unsigned int size;
@@ -1909,7 +1895,7 @@ static const char *get_field_str(struct filter_arg *arg, struct pevent_record *r
 
 		if (arg->str.field->flags & (FIELD_IS_POINTER | FIELD_IS_LONG))
 			/* convert to a kernel symbol */
-			val = pevent_find_function(pevent, addr);
+			val = tep_find_function(pevent, addr);
 
 		if (val == NULL) {
 			/* just use the hex of the string name */
@@ -1922,7 +1908,7 @@ static const char *get_field_str(struct filter_arg *arg, struct pevent_record *r
 }
 
 static int test_str(struct event_format *event, struct filter_arg *arg,
-		    struct pevent_record *record, enum pevent_errno *err)
+		    struct tep_record *record, enum tep_errno *err)
 {
 	const char *val;
 
@@ -1947,13 +1933,13 @@ static int test_str(struct event_format *event, struct filter_arg *arg,
 
 	default:
 		if (!*err)
-			*err = PEVENT_ERRNO__ILLEGAL_STRING_CMP;
+			*err = TEP_ERRNO__ILLEGAL_STRING_CMP;
 		return 0;
 	}
 }
 
 static int test_op(struct event_format *event, struct filter_arg *arg,
-		   struct pevent_record *record, enum pevent_errno *err)
+		   struct tep_record *record, enum tep_errno *err)
 {
 	switch (arg->op.type) {
 	case FILTER_OP_AND:
@@ -1969,13 +1955,13 @@ static int test_op(struct event_format *event, struct filter_arg *arg,
 
 	default:
 		if (!*err)
-			*err = PEVENT_ERRNO__INVALID_OP_TYPE;
+			*err = TEP_ERRNO__INVALID_OP_TYPE;
 		return 0;
 	}
 }
 
 static int test_filter(struct event_format *event, struct filter_arg *arg,
-		       struct pevent_record *record, enum pevent_errno *err)
+		       struct tep_record *record, enum tep_errno *err)
 {
 	if (*err) {
 		/*
@@ -2009,20 +1995,20 @@ static int test_filter(struct event_format *event, struct filter_arg *arg,
 
 	default:
 		if (!*err)
-			*err = PEVENT_ERRNO__INVALID_ARG_TYPE;
+			*err = TEP_ERRNO__INVALID_ARG_TYPE;
 		return 0;
 	}
 }
 
 /**
- * pevent_event_filtered - return true if event has filter
+ * tep_event_filtered - return true if event has filter
  * @filter: filter struct with filter information
  * @event_id: event id to test if filter exists
  *
  * Returns 1 if filter found for @event_id
  *   otherwise 0;
  */
-int pevent_event_filtered(struct event_filter *filter, int event_id)
+int tep_event_filtered(struct event_filter *filter, int event_id)
 {
 	struct filter_type *filter_type;
 
@@ -2035,42 +2021,42 @@ int pevent_event_filtered(struct event_filter *filter, int event_id)
 }
 
 /**
- * pevent_filter_match - test if a record matches a filter
+ * tep_filter_match - test if a record matches a filter
  * @filter: filter struct with filter information
  * @record: the record to test against the filter
  *
- * Returns: match result or error code (prefixed with PEVENT_ERRNO__)
+ * Returns: match result or error code (prefixed with TEP_ERRNO__)
  * FILTER_MATCH - filter found for event and @record matches
  * FILTER_MISS  - filter found for event and @record does not match
  * FILTER_NOT_FOUND - no filter found for @record's event
  * NO_FILTER - if no filters exist
  * otherwise - error occurred during test
  */
-enum pevent_errno pevent_filter_match(struct event_filter *filter,
-				      struct pevent_record *record)
+enum tep_errno tep_filter_match(struct event_filter *filter,
+				struct tep_record *record)
 {
-	struct pevent *pevent = filter->pevent;
+	struct tep_handle *pevent = filter->pevent;
 	struct filter_type *filter_type;
 	int event_id;
 	int ret;
-	enum pevent_errno err = 0;
+	enum tep_errno err = 0;
 
 	filter_init_error_buf(filter);
 
 	if (!filter->filters)
-		return PEVENT_ERRNO__NO_FILTER;
+		return TEP_ERRNO__NO_FILTER;
 
-	event_id = pevent_data_type(pevent, record);
+	event_id = tep_data_type(pevent, record);
 
 	filter_type = find_filter_type(filter, event_id);
 	if (!filter_type)
-		return PEVENT_ERRNO__FILTER_NOT_FOUND;
+		return TEP_ERRNO__FILTER_NOT_FOUND;
 
 	ret = test_filter(filter_type->event, filter_type->filter, record, &err);
 	if (err)
 		return err;
 
-	return ret ? PEVENT_ERRNO__FILTER_MATCH : PEVENT_ERRNO__FILTER_MISS;
+	return ret ? TEP_ERRNO__FILTER_MATCH : TEP_ERRNO__FILTER_MISS;
 }
 
 static char *op_to_str(struct event_filter *filter, struct filter_arg *arg)
@@ -2364,7 +2350,7 @@ static char *arg_to_str(struct event_filter *filter, struct filter_arg *arg)
 }
 
 /**
- * pevent_filter_make_string - return a string showing the filter
+ * tep_filter_make_string - return a string showing the filter
  * @filter: filter struct with filter information
  * @event_id: the event id to return the filter string with
  *
@@ -2373,7 +2359,7 @@ static char *arg_to_str(struct event_filter *filter, struct filter_arg *arg)
  *  NULL is returned if no filter is found or allocation failed.
  */
 char *
-pevent_filter_make_string(struct event_filter *filter, int event_id)
+tep_filter_make_string(struct event_filter *filter, int event_id)
 {
 	struct filter_type *filter_type;
 
@@ -2389,7 +2375,7 @@ pevent_filter_make_string(struct event_filter *filter, int event_id)
 }
 
 /**
- * pevent_filter_compare - compare two filters and return if they are the same
+ * tep_filter_compare - compare two filters and return if they are the same
  * @filter1: Filter to compare with @filter2
  * @filter2: Filter to compare with @filter1
  *
@@ -2397,7 +2383,7 @@ pevent_filter_make_string(struct event_filter *filter, int event_id)
  *  1 if the two filters hold the same content.
  *  0 if they do not.
  */
-int pevent_filter_compare(struct event_filter *filter1, struct event_filter *filter2)
+int tep_filter_compare(struct event_filter *filter1, struct event_filter *filter2)
 {
 	struct filter_type *filter_type1;
 	struct filter_type *filter_type2;
diff --git a/tools/lib/traceevent/parse-utils.c b/tools/lib/traceevent/parse-utils.c
index eda07fa31dca..77e4ec6402dd 100644
--- a/tools/lib/traceevent/parse-utils.c
+++ b/tools/lib/traceevent/parse-utils.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * Copyright (C) 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/lib/traceevent/plugin_cfg80211.c b/tools/lib/traceevent/plugin_cfg80211.c
index 8f8586912da7..a51b366f47da 100644
--- a/tools/lib/traceevent/plugin_cfg80211.c
+++ b/tools/lib/traceevent/plugin_cfg80211.c
@@ -25,19 +25,19 @@ process___le16_to_cpup(struct trace_seq *s, unsigned long long *args)
 	return val ? (long long) le16toh(*val) : 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_print_function(pevent,
-				       process___le16_to_cpup,
-				       PEVENT_FUNC_ARG_INT,
-				       "__le16_to_cpup",
-				       PEVENT_FUNC_ARG_PTR,
-				       PEVENT_FUNC_ARG_VOID);
+	tep_register_print_function(pevent,
+				    process___le16_to_cpup,
+				    TEP_FUNC_ARG_INT,
+				    "__le16_to_cpup",
+				    TEP_FUNC_ARG_PTR,
+				    TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_print_function(pevent, process___le16_to_cpup,
-					 "__le16_to_cpup");
+	tep_unregister_print_function(pevent, process___le16_to_cpup,
+				      "__le16_to_cpup");
 }
diff --git a/tools/lib/traceevent/plugin_function.c b/tools/lib/traceevent/plugin_function.c
index 42dbf73758f3..424747475d37 100644
--- a/tools/lib/traceevent/plugin_function.c
+++ b/tools/lib/traceevent/plugin_function.c
@@ -33,7 +33,7 @@ static int cpus = -1;
 
 #define STK_BLK 10
 
-struct pevent_plugin_option plugin_options[] =
+struct tep_plugin_option plugin_options[] =
 {
 	{
 		.name = "parent",
@@ -53,8 +53,8 @@ struct pevent_plugin_option plugin_options[] =
 	}
 };
 
-static struct pevent_plugin_option *ftrace_parent = &plugin_options[0];
-static struct pevent_plugin_option *ftrace_indent = &plugin_options[1];
+static struct tep_plugin_option *ftrace_parent = &plugin_options[0];
+static struct tep_plugin_option *ftrace_indent = &plugin_options[1];
 
 static void add_child(struct func_stack *stack, const char *child, int pos)
 {
@@ -122,25 +122,25 @@ static int add_and_get_index(const char *parent, const char *child, int cpu)
 	return 0;
 }
 
-static int function_handler(struct trace_seq *s, struct pevent_record *record,
+static int function_handler(struct trace_seq *s, struct tep_record *record,
 			    struct event_format *event, void *context)
 {
-	struct pevent *pevent = event->pevent;
+	struct tep_handle *pevent = event->pevent;
 	unsigned long long function;
 	unsigned long long pfunction;
 	const char *func;
 	const char *parent;
 	int index = 0;
 
-	if (pevent_get_field_val(s, event, "ip", record, &function, 1))
+	if (tep_get_field_val(s, event, "ip", record, &function, 1))
 		return trace_seq_putc(s, '!');
 
-	func = pevent_find_function(pevent, function);
+	func = tep_find_function(pevent, function);
 
-	if (pevent_get_field_val(s, event, "parent_ip", record, &pfunction, 1))
+	if (tep_get_field_val(s, event, "parent_ip", record, &pfunction, 1))
 		return trace_seq_putc(s, '!');
 
-	parent = pevent_find_function(pevent, pfunction);
+	parent = tep_find_function(pevent, pfunction);
 
 	if (parent && ftrace_indent->set)
 		index = add_and_get_index(parent, func, record->cpu);
@@ -163,22 +163,22 @@ static int function_handler(struct trace_seq *s, struct pevent_record *record,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_event_handler(pevent, -1, "ftrace", "function",
-				      function_handler, NULL);
+	tep_register_event_handler(pevent, -1, "ftrace", "function",
+				   function_handler, NULL);
 
-	traceevent_plugin_add_options("ftrace", plugin_options);
+	tep_plugin_add_options("ftrace", plugin_options);
 
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	int i, x;
 
-	pevent_unregister_event_handler(pevent, -1, "ftrace", "function",
-					function_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "ftrace", "function",
+				     function_handler, NULL);
 
 	for (i = 0; i <= cpus; i++) {
 		for (x = 0; x < fstack[i].size && fstack[i].stack[x]; x++)
@@ -186,7 +186,7 @@ void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
 		free(fstack[i].stack);
 	}
 
-	traceevent_plugin_remove_options(plugin_options);
+	tep_plugin_remove_options(plugin_options);
 
 	free(fstack);
 	fstack = NULL;
diff --git a/tools/lib/traceevent/plugin_hrtimer.c b/tools/lib/traceevent/plugin_hrtimer.c
index 12bf14cc1152..b43bfec565d8 100644
--- a/tools/lib/traceevent/plugin_hrtimer.c
+++ b/tools/lib/traceevent/plugin_hrtimer.c
@@ -25,64 +25,64 @@
 #include "event-parse.h"
 
 static int timer_expire_handler(struct trace_seq *s,
-				struct pevent_record *record,
+				struct tep_record *record,
 				struct event_format *event, void *context)
 {
 	trace_seq_printf(s, "hrtimer=");
 
-	if (pevent_print_num_field(s, "0x%llx", event, "timer",
-				   record, 0) == -1)
-		pevent_print_num_field(s, "0x%llx", event, "hrtimer",
-				       record, 1);
+	if (tep_print_num_field(s, "0x%llx", event, "timer",
+				record, 0) == -1)
+		tep_print_num_field(s, "0x%llx", event, "hrtimer",
+				    record, 1);
 
 	trace_seq_printf(s, " now=");
 
-	pevent_print_num_field(s, "%llu", event, "now", record, 1);
+	tep_print_num_field(s, "%llu", event, "now", record, 1);
 
-	pevent_print_func_field(s, " function=%s", event, "function",
+	tep_print_func_field(s, " function=%s", event, "function",
 				record, 0);
 	return 0;
 }
 
 static int timer_start_handler(struct trace_seq *s,
-			       struct pevent_record *record,
+			       struct tep_record *record,
 			       struct event_format *event, void *context)
 {
 	trace_seq_printf(s, "hrtimer=");
 
-	if (pevent_print_num_field(s, "0x%llx", event, "timer",
-				   record, 0) == -1)
-		pevent_print_num_field(s, "0x%llx", event, "hrtimer",
-				       record, 1);
+	if (tep_print_num_field(s, "0x%llx", event, "timer",
+				record, 0) == -1)
+		tep_print_num_field(s, "0x%llx", event, "hrtimer",
+				    record, 1);
 
-	pevent_print_func_field(s, " function=%s", event, "function",
-				record, 0);
+	tep_print_func_field(s, " function=%s", event, "function",
+			     record, 0);
 
 	trace_seq_printf(s, " expires=");
-	pevent_print_num_field(s, "%llu", event, "expires", record, 1);
+	tep_print_num_field(s, "%llu", event, "expires", record, 1);
 
 	trace_seq_printf(s, " softexpires=");
-	pevent_print_num_field(s, "%llu", event, "softexpires", record, 1);
+	tep_print_num_field(s, "%llu", event, "softexpires", record, 1);
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_event_handler(pevent, -1,
-				      "timer", "hrtimer_expire_entry",
-				      timer_expire_handler, NULL);
+	tep_register_event_handler(pevent, -1,
+				   "timer", "hrtimer_expire_entry",
+				   timer_expire_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "timer", "hrtimer_start",
-				      timer_start_handler, NULL);
+	tep_register_event_handler(pevent, -1, "timer", "hrtimer_start",
+				   timer_start_handler, NULL);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_event_handler(pevent, -1,
-					"timer", "hrtimer_expire_entry",
-					timer_expire_handler, NULL);
+	tep_unregister_event_handler(pevent, -1,
+				     "timer", "hrtimer_expire_entry",
+				     timer_expire_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "timer", "hrtimer_start",
-					timer_start_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "timer", "hrtimer_start",
+				     timer_start_handler, NULL);
 }
diff --git a/tools/lib/traceevent/plugin_jbd2.c b/tools/lib/traceevent/plugin_jbd2.c
index 5c23d5bd27ce..45a9acd19640 100644
--- a/tools/lib/traceevent/plugin_jbd2.c
+++ b/tools/lib/traceevent/plugin_jbd2.c
@@ -47,29 +47,29 @@ process_jiffies_to_msecs(struct trace_seq *s, unsigned long long *args)
 	return jiffies;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_print_function(pevent,
-				       process_jbd2_dev_to_name,
-				       PEVENT_FUNC_ARG_STRING,
-				       "jbd2_dev_to_name",
-				       PEVENT_FUNC_ARG_INT,
-				       PEVENT_FUNC_ARG_VOID);
+	tep_register_print_function(pevent,
+				    process_jbd2_dev_to_name,
+				    TEP_FUNC_ARG_STRING,
+				    "jbd2_dev_to_name",
+				    TEP_FUNC_ARG_INT,
+				    TEP_FUNC_ARG_VOID);
 
-	pevent_register_print_function(pevent,
-				       process_jiffies_to_msecs,
-				       PEVENT_FUNC_ARG_LONG,
-				       "jiffies_to_msecs",
-				       PEVENT_FUNC_ARG_LONG,
-				       PEVENT_FUNC_ARG_VOID);
+	tep_register_print_function(pevent,
+				    process_jiffies_to_msecs,
+				    TEP_FUNC_ARG_LONG,
+				    "jiffies_to_msecs",
+				    TEP_FUNC_ARG_LONG,
+				    TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_print_function(pevent, process_jbd2_dev_to_name,
-					 "jbd2_dev_to_name");
+	tep_unregister_print_function(pevent, process_jbd2_dev_to_name,
+				      "jbd2_dev_to_name");
 
-	pevent_unregister_print_function(pevent, process_jiffies_to_msecs,
-					 "jiffies_to_msecs");
+	tep_unregister_print_function(pevent, process_jiffies_to_msecs,
+				      "jiffies_to_msecs");
 }
diff --git a/tools/lib/traceevent/plugin_kmem.c b/tools/lib/traceevent/plugin_kmem.c
index 70650ff48d78..73966b05abce 100644
--- a/tools/lib/traceevent/plugin_kmem.c
+++ b/tools/lib/traceevent/plugin_kmem.c
@@ -23,7 +23,7 @@
 
 #include "event-parse.h"
 
-static int call_site_handler(struct trace_seq *s, struct pevent_record *record,
+static int call_site_handler(struct trace_seq *s, struct tep_record *record,
 			     struct event_format *event, void *context)
 {
 	struct format_field *field;
@@ -31,64 +31,64 @@ static int call_site_handler(struct trace_seq *s, struct pevent_record *record,
 	void *data = record->data;
 	const char *func;
 
-	field = pevent_find_field(event, "call_site");
+	field = tep_find_field(event, "call_site");
 	if (!field)
 		return 1;
 
-	if (pevent_read_number_field(field, data, &val))
+	if (tep_read_number_field(field, data, &val))
 		return 1;
 
-	func = pevent_find_function(event->pevent, val);
+	func = tep_find_function(event->pevent, val);
 	if (!func)
 		return 1;
 
-	addr = pevent_find_function_address(event->pevent, val);
+	addr = tep_find_function_address(event->pevent, val);
 
 	trace_seq_printf(s, "(%s+0x%x) ", func, (int)(val - addr));
 	return 1;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_event_handler(pevent, -1, "kmem", "kfree",
-				      call_site_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kmem", "kfree",
+				   call_site_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kmem", "kmalloc",
-				      call_site_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kmem", "kmalloc",
+				   call_site_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kmem", "kmalloc_node",
-				      call_site_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kmem", "kmalloc_node",
+				   call_site_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kmem", "kmem_cache_alloc",
-				      call_site_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kmem", "kmem_cache_alloc",
+				   call_site_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kmem",
-				      "kmem_cache_alloc_node",
-				      call_site_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kmem",
+				   "kmem_cache_alloc_node",
+				   call_site_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kmem", "kmem_cache_free",
-				      call_site_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kmem", "kmem_cache_free",
+				   call_site_handler, NULL);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_event_handler(pevent, -1, "kmem", "kfree",
-					call_site_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kmem", "kfree",
+				     call_site_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kmem", "kmalloc",
-					call_site_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kmem", "kmalloc",
+				     call_site_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kmem", "kmalloc_node",
-					call_site_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kmem", "kmalloc_node",
+				     call_site_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kmem", "kmem_cache_alloc",
-					call_site_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kmem", "kmem_cache_alloc",
+				     call_site_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kmem",
-					"kmem_cache_alloc_node",
-					call_site_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kmem",
+				     "kmem_cache_alloc_node",
+				     call_site_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kmem", "kmem_cache_free",
-					call_site_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kmem", "kmem_cache_free",
+				     call_site_handler, NULL);
 }
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 18536f756577..1d0d15906225 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -247,17 +247,17 @@ static const char *find_exit_reason(unsigned isa, int val)
 	return strings[i].str;
 }
 
-static int print_exit_reason(struct trace_seq *s, struct pevent_record *record,
+static int print_exit_reason(struct trace_seq *s, struct tep_record *record,
 			     struct event_format *event, const char *field)
 {
 	unsigned long long isa;
 	unsigned long long val;
 	const char *reason;
 
-	if (pevent_get_field_val(s, event, field, record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, field, record, &val, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "isa", record, &isa, 0) < 0)
+	if (tep_get_field_val(s, event, "isa", record, &isa, 0) < 0)
 		isa = 1;
 
 	reason = find_exit_reason(isa, val);
@@ -268,7 +268,7 @@ static int print_exit_reason(struct trace_seq *s, struct pevent_record *record,
 	return 0;
 }
 
-static int kvm_exit_handler(struct trace_seq *s, struct pevent_record *record,
+static int kvm_exit_handler(struct trace_seq *s, struct tep_record *record,
 			    struct event_format *event, void *context)
 {
 	unsigned long long info1 = 0, info2 = 0;
@@ -276,10 +276,10 @@ static int kvm_exit_handler(struct trace_seq *s, struct pevent_record *record,
 	if (print_exit_reason(s, record, event, "exit_reason") < 0)
 		return -1;
 
-	pevent_print_num_field(s, " rip 0x%lx", event, "guest_rip", record, 1);
+	tep_print_num_field(s, " rip 0x%lx", event, "guest_rip", record, 1);
 
-	if (pevent_get_field_val(s, event, "info1", record, &info1, 0) >= 0
-	    && pevent_get_field_val(s, event, "info2", record, &info2, 0) >= 0)
+	if (tep_get_field_val(s, event, "info1", record, &info1, 0) >= 0
+	    && tep_get_field_val(s, event, "info2", record, &info2, 0) >= 0)
 		trace_seq_printf(s, " info %llx %llx", info1, info2);
 
 	return 0;
@@ -291,7 +291,7 @@ static int kvm_exit_handler(struct trace_seq *s, struct pevent_record *record,
 #define KVM_EMUL_INSN_F_CS_L   (1 << 3)
 
 static int kvm_emulate_insn_handler(struct trace_seq *s,
-				    struct pevent_record *record,
+				    struct tep_record *record,
 				    struct event_format *event, void *context)
 {
 	unsigned long long rip, csbase, len, flags, failed;
@@ -299,22 +299,22 @@ static int kvm_emulate_insn_handler(struct trace_seq *s,
 	uint8_t *insn;
 	const char *disasm;
 
-	if (pevent_get_field_val(s, event, "rip", record, &rip, 1) < 0)
+	if (tep_get_field_val(s, event, "rip", record, &rip, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "csbase", record, &csbase, 1) < 0)
+	if (tep_get_field_val(s, event, "csbase", record, &csbase, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "len", record, &len, 1) < 0)
+	if (tep_get_field_val(s, event, "len", record, &len, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "flags", record, &flags, 1) < 0)
+	if (tep_get_field_val(s, event, "flags", record, &flags, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "failed", record, &failed, 1) < 0)
+	if (tep_get_field_val(s, event, "failed", record, &failed, 1) < 0)
 		return -1;
 
-	insn = pevent_get_field_raw(s, event, "insn", record, &llen, 1);
+	insn = tep_get_field_raw(s, event, "insn", record, &llen, 1);
 	if (!insn)
 		return -1;
 
@@ -330,24 +330,24 @@ static int kvm_emulate_insn_handler(struct trace_seq *s,
 }
 
 
-static int kvm_nested_vmexit_inject_handler(struct trace_seq *s, struct pevent_record *record,
+static int kvm_nested_vmexit_inject_handler(struct trace_seq *s, struct tep_record *record,
 					    struct event_format *event, void *context)
 {
 	if (print_exit_reason(s, record, event, "exit_code") < 0)
 		return -1;
 
-	pevent_print_num_field(s, " info1 %llx", event, "exit_info1", record, 1);
-	pevent_print_num_field(s, " info2 %llx", event, "exit_info2", record, 1);
-	pevent_print_num_field(s, " int_info %llx", event, "exit_int_info", record, 1);
-	pevent_print_num_field(s, " int_info_err %llx", event, "exit_int_info_err", record, 1);
+	tep_print_num_field(s, " info1 %llx", event, "exit_info1", record, 1);
+	tep_print_num_field(s, " info2 %llx", event, "exit_info2", record, 1);
+	tep_print_num_field(s, " int_info %llx", event, "exit_int_info", record, 1);
+	tep_print_num_field(s, " int_info_err %llx", event, "exit_int_info_err", record, 1);
 
 	return 0;
 }
 
-static int kvm_nested_vmexit_handler(struct trace_seq *s, struct pevent_record *record,
+static int kvm_nested_vmexit_handler(struct trace_seq *s, struct tep_record *record,
 				     struct event_format *event, void *context)
 {
-	pevent_print_num_field(s, "rip %llx ", event, "rip", record, 1);
+	tep_print_num_field(s, "rip %llx ", event, "rip", record, 1);
 
 	return kvm_nested_vmexit_inject_handler(s, record, event, context);
 }
@@ -370,7 +370,7 @@ union kvm_mmu_page_role {
 	};
 };
 
-static int kvm_mmu_print_role(struct trace_seq *s, struct pevent_record *record,
+static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 			      struct event_format *event, void *context)
 {
 	unsigned long long val;
@@ -379,7 +379,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct pevent_record *record,
 	};
 	union kvm_mmu_page_role role;
 
-	if (pevent_get_field_val(s, event, "role", record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, "role", record, &val, 1) < 0)
 		return -1;
 
 	role.word = (int)val;
@@ -388,8 +388,8 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct pevent_record *record,
 	 * We can only use the structure if file is of the same
 	 * endianess.
 	 */
-	if (pevent_is_file_bigendian(event->pevent) ==
-	    pevent_is_host_bigendian(event->pevent)) {
+	if (tep_is_file_bigendian(event->pevent) ==
+	    tep_is_host_bigendian(event->pevent)) {
 
 		trace_seq_printf(s, "%u q%u%s %s%s %spae %snxe %swp%s%s%s",
 				 role.level,
@@ -406,10 +406,10 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct pevent_record *record,
 	} else
 		trace_seq_printf(s, "WORD: %08x", role.word);
 
-	pevent_print_num_field(s, " root %u ",  event,
-			       "root_count", record, 1);
+	tep_print_num_field(s, " root %u ",  event,
+			    "root_count", record, 1);
 
-	if (pevent_get_field_val(s, event, "unsync", record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, "unsync", record, &val, 1) < 0)
 		return -1;
 
 	trace_seq_printf(s, "%s%c",  val ? "unsync" : "sync", 0);
@@ -417,17 +417,17 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct pevent_record *record,
 }
 
 static int kvm_mmu_get_page_handler(struct trace_seq *s,
-				    struct pevent_record *record,
+				    struct tep_record *record,
 				    struct event_format *event, void *context)
 {
 	unsigned long long val;
 
-	if (pevent_get_field_val(s, event, "created", record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, "created", record, &val, 1) < 0)
 		return -1;
 
 	trace_seq_printf(s, "%s ", val ? "new" : "existing");
 
-	if (pevent_get_field_val(s, event, "gfn", record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, "gfn", record, &val, 1) < 0)
 		return -1;
 
 	trace_seq_printf(s, "sp gfn %llx ", val);
@@ -444,79 +444,79 @@ process_is_writable_pte(struct trace_seq *s, unsigned long long *args)
 	return pte & PT_WRITABLE_MASK;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	init_disassembler();
 
-	pevent_register_event_handler(pevent, -1, "kvm", "kvm_exit",
-				      kvm_exit_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kvm", "kvm_exit",
+				   kvm_exit_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kvm", "kvm_emulate_insn",
-				      kvm_emulate_insn_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kvm", "kvm_emulate_insn",
+				   kvm_emulate_insn_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kvm", "kvm_nested_vmexit",
-				      kvm_nested_vmexit_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kvm", "kvm_nested_vmexit",
+				   kvm_nested_vmexit_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kvm", "kvm_nested_vmexit_inject",
-				      kvm_nested_vmexit_inject_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kvm", "kvm_nested_vmexit_inject",
+				   kvm_nested_vmexit_inject_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_get_page",
-				      kvm_mmu_get_page_handler, NULL);
+	tep_register_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_get_page",
+				   kvm_mmu_get_page_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_sync_page",
-				      kvm_mmu_print_role, NULL);
+	tep_register_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_sync_page",
+				   kvm_mmu_print_role, NULL);
 
-	pevent_register_event_handler(pevent, -1,
-				      "kvmmmu", "kvm_mmu_unsync_page",
-				      kvm_mmu_print_role, NULL);
+	tep_register_event_handler(pevent, -1,
+				   "kvmmmu", "kvm_mmu_unsync_page",
+				   kvm_mmu_print_role, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_zap_page",
-				      kvm_mmu_print_role, NULL);
+	tep_register_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_zap_page",
+				   kvm_mmu_print_role, NULL);
 
-	pevent_register_event_handler(pevent, -1, "kvmmmu",
+	tep_register_event_handler(pevent, -1, "kvmmmu",
 			"kvm_mmu_prepare_zap_page", kvm_mmu_print_role,
 			NULL);
 
-	pevent_register_print_function(pevent,
-				       process_is_writable_pte,
-				       PEVENT_FUNC_ARG_INT,
-				       "is_writable_pte",
-				       PEVENT_FUNC_ARG_LONG,
-				       PEVENT_FUNC_ARG_VOID);
+	tep_register_print_function(pevent,
+				    process_is_writable_pte,
+				    TEP_FUNC_ARG_INT,
+				    "is_writable_pte",
+				    TEP_FUNC_ARG_LONG,
+				    TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_event_handler(pevent, -1, "kvm", "kvm_exit",
-					kvm_exit_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kvm", "kvm_exit",
+				     kvm_exit_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kvm", "kvm_emulate_insn",
-					kvm_emulate_insn_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kvm", "kvm_emulate_insn",
+				     kvm_emulate_insn_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kvm", "kvm_nested_vmexit",
-					kvm_nested_vmexit_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kvm", "kvm_nested_vmexit",
+				     kvm_nested_vmexit_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kvm", "kvm_nested_vmexit_inject",
-					kvm_nested_vmexit_inject_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kvm", "kvm_nested_vmexit_inject",
+				     kvm_nested_vmexit_inject_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_get_page",
-					kvm_mmu_get_page_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_get_page",
+				     kvm_mmu_get_page_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_sync_page",
-					kvm_mmu_print_role, NULL);
+	tep_unregister_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_sync_page",
+				     kvm_mmu_print_role, NULL);
 
-	pevent_unregister_event_handler(pevent, -1,
-					"kvmmmu", "kvm_mmu_unsync_page",
-					kvm_mmu_print_role, NULL);
+	tep_unregister_event_handler(pevent, -1,
+				     "kvmmmu", "kvm_mmu_unsync_page",
+				     kvm_mmu_print_role, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_zap_page",
-					kvm_mmu_print_role, NULL);
+	tep_unregister_event_handler(pevent, -1, "kvmmmu", "kvm_mmu_zap_page",
+				     kvm_mmu_print_role, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "kvmmmu",
+	tep_unregister_event_handler(pevent, -1, "kvmmmu",
 			"kvm_mmu_prepare_zap_page", kvm_mmu_print_role,
 			NULL);
 
-	pevent_unregister_print_function(pevent, process_is_writable_pte,
-					 "is_writable_pte");
+	tep_unregister_print_function(pevent, process_is_writable_pte,
+				      "is_writable_pte");
 }
diff --git a/tools/lib/traceevent/plugin_mac80211.c b/tools/lib/traceevent/plugin_mac80211.c
index 7e15a0f1c2fd..de50a5316203 100644
--- a/tools/lib/traceevent/plugin_mac80211.c
+++ b/tools/lib/traceevent/plugin_mac80211.c
@@ -28,7 +28,7 @@
 static void print_string(struct trace_seq *s, struct event_format *event,
 			 const char *name, const void *data)
 {
-	struct format_field *f = pevent_find_field(event, name);
+	struct format_field *f = tep_find_field(event, name);
 	int offset;
 	int length;
 
@@ -42,7 +42,7 @@ static void print_string(struct trace_seq *s, struct event_format *event,
 
 	if (!strncmp(f->type, "__data_loc", 10)) {
 		unsigned long long v;
-		if (pevent_read_number_field(f, data, &v)) {
+		if (tep_read_number_field(f, data, &v)) {
 			trace_seq_printf(s, "invalid_data_loc");
 			return;
 		}
@@ -53,12 +53,12 @@ static void print_string(struct trace_seq *s, struct event_format *event,
 	trace_seq_printf(s, "%.*s", length, (char *)data + offset);
 }
 
-#define SF(fn)	pevent_print_num_field(s, fn ":%d", event, fn, record, 0)
-#define SFX(fn)	pevent_print_num_field(s, fn ":%#x", event, fn, record, 0)
+#define SF(fn)	tep_print_num_field(s, fn ":%d", event, fn, record, 0)
+#define SFX(fn)	tep_print_num_field(s, fn ":%#x", event, fn, record, 0)
 #define SP()	trace_seq_putc(s, ' ')
 
 static int drv_bss_info_changed(struct trace_seq *s,
-				struct pevent_record *record,
+				struct tep_record *record,
 				struct event_format *event, void *context)
 {
 	void *data = record->data;
@@ -66,7 +66,7 @@ static int drv_bss_info_changed(struct trace_seq *s,
 	print_string(s, event, "wiphy_name", data);
 	trace_seq_printf(s, " vif:");
 	print_string(s, event, "vif_name", data);
-	pevent_print_num_field(s, "(%d)", event, "vif_type", record, 1);
+	tep_print_num_field(s, "(%d)", event, "vif_type", record, 1);
 
 	trace_seq_printf(s, "\n%*s", INDENT, "");
 	SF("assoc"); SP();
@@ -86,17 +86,17 @@ static int drv_bss_info_changed(struct trace_seq *s,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_event_handler(pevent, -1, "mac80211",
-				      "drv_bss_info_changed",
-				      drv_bss_info_changed, NULL);
+	tep_register_event_handler(pevent, -1, "mac80211",
+				   "drv_bss_info_changed",
+				   drv_bss_info_changed, NULL);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_event_handler(pevent, -1, "mac80211",
-					"drv_bss_info_changed",
-					drv_bss_info_changed, NULL);
+	tep_unregister_event_handler(pevent, -1, "mac80211",
+				     "drv_bss_info_changed",
+				     drv_bss_info_changed, NULL);
 }
diff --git a/tools/lib/traceevent/plugin_sched_switch.c b/tools/lib/traceevent/plugin_sched_switch.c
index ec30c2fcbac0..eecb4bd95c11 100644
--- a/tools/lib/traceevent/plugin_sched_switch.c
+++ b/tools/lib/traceevent/plugin_sched_switch.c
@@ -45,7 +45,7 @@ static void write_state(struct trace_seq *s, int val)
 }
 
 static void write_and_save_comm(struct format_field *field,
-				struct pevent_record *record,
+				struct tep_record *record,
 				struct trace_seq *s, int pid)
 {
 	const char *comm;
@@ -61,100 +61,100 @@ static void write_and_save_comm(struct format_field *field,
 	comm = &s->buffer[len];
 
 	/* Help out the comm to ids. This will handle dups */
-	pevent_register_comm(field->event->pevent, comm, pid);
+	tep_register_comm(field->event->pevent, comm, pid);
 }
 
 static int sched_wakeup_handler(struct trace_seq *s,
-				struct pevent_record *record,
+				struct tep_record *record,
 				struct event_format *event, void *context)
 {
 	struct format_field *field;
 	unsigned long long val;
 
-	if (pevent_get_field_val(s, event, "pid", record, &val, 1))
+	if (tep_get_field_val(s, event, "pid", record, &val, 1))
 		return trace_seq_putc(s, '!');
 
-	field = pevent_find_any_field(event, "comm");
+	field = tep_find_any_field(event, "comm");
 	if (field) {
 		write_and_save_comm(field, record, s, val);
 		trace_seq_putc(s, ':');
 	}
 	trace_seq_printf(s, "%lld", val);
 
-	if (pevent_get_field_val(s, event, "prio", record, &val, 0) == 0)
+	if (tep_get_field_val(s, event, "prio", record, &val, 0) == 0)
 		trace_seq_printf(s, " [%lld]", val);
 
-	if (pevent_get_field_val(s, event, "success", record, &val, 1) == 0)
+	if (tep_get_field_val(s, event, "success", record, &val, 1) == 0)
 		trace_seq_printf(s, " success=%lld", val);
 
-	if (pevent_get_field_val(s, event, "target_cpu", record, &val, 0) == 0)
+	if (tep_get_field_val(s, event, "target_cpu", record, &val, 0) == 0)
 		trace_seq_printf(s, " CPU:%03llu", val);
 
 	return 0;
 }
 
 static int sched_switch_handler(struct trace_seq *s,
-				struct pevent_record *record,
+				struct tep_record *record,
 				struct event_format *event, void *context)
 {
 	struct format_field *field;
 	unsigned long long val;
 
-	if (pevent_get_field_val(s, event, "prev_pid", record, &val, 1))
+	if (tep_get_field_val(s, event, "prev_pid", record, &val, 1))
 		return trace_seq_putc(s, '!');
 
-	field = pevent_find_any_field(event, "prev_comm");
+	field = tep_find_any_field(event, "prev_comm");
 	if (field) {
 		write_and_save_comm(field, record, s, val);
 		trace_seq_putc(s, ':');
 	}
 	trace_seq_printf(s, "%lld ", val);
 
-	if (pevent_get_field_val(s, event, "prev_prio", record, &val, 0) == 0)
+	if (tep_get_field_val(s, event, "prev_prio", record, &val, 0) == 0)
 		trace_seq_printf(s, "[%d] ", (int) val);
 
-	if (pevent_get_field_val(s,  event, "prev_state", record, &val, 0) == 0)
+	if (tep_get_field_val(s,  event, "prev_state", record, &val, 0) == 0)
 		write_state(s, val);
 
 	trace_seq_puts(s, " ==> ");
 
-	if (pevent_get_field_val(s, event, "next_pid", record, &val, 1))
+	if (tep_get_field_val(s, event, "next_pid", record, &val, 1))
 		return trace_seq_putc(s, '!');
 
-	field = pevent_find_any_field(event, "next_comm");
+	field = tep_find_any_field(event, "next_comm");
 	if (field) {
 		write_and_save_comm(field, record, s, val);
 		trace_seq_putc(s, ':');
 	}
 	trace_seq_printf(s, "%lld", val);
 
-	if (pevent_get_field_val(s, event, "next_prio", record, &val, 0) == 0)
+	if (tep_get_field_val(s, event, "next_prio", record, &val, 0) == 0)
 		trace_seq_printf(s, " [%d]", (int) val);
 
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_event_handler(pevent, -1, "sched", "sched_switch",
-				      sched_switch_handler, NULL);
+	tep_register_event_handler(pevent, -1, "sched", "sched_switch",
+				   sched_switch_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "sched", "sched_wakeup",
-				      sched_wakeup_handler, NULL);
+	tep_register_event_handler(pevent, -1, "sched", "sched_wakeup",
+				   sched_wakeup_handler, NULL);
 
-	pevent_register_event_handler(pevent, -1, "sched", "sched_wakeup_new",
-				      sched_wakeup_handler, NULL);
+	tep_register_event_handler(pevent, -1, "sched", "sched_wakeup_new",
+				   sched_wakeup_handler, NULL);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_event_handler(pevent, -1, "sched", "sched_switch",
-					sched_switch_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "sched", "sched_switch",
+				     sched_switch_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "sched", "sched_wakeup",
-					sched_wakeup_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "sched", "sched_wakeup",
+				     sched_wakeup_handler, NULL);
 
-	pevent_unregister_event_handler(pevent, -1, "sched", "sched_wakeup_new",
-					sched_wakeup_handler, NULL);
+	tep_unregister_event_handler(pevent, -1, "sched", "sched_wakeup_new",
+				     sched_wakeup_handler, NULL);
 }
diff --git a/tools/lib/traceevent/plugin_scsi.c b/tools/lib/traceevent/plugin_scsi.c
index 5e750af2b461..5ec346f6b842 100644
--- a/tools/lib/traceevent/plugin_scsi.c
+++ b/tools/lib/traceevent/plugin_scsi.c
@@ -413,21 +413,21 @@ unsigned long long process_scsi_trace_parse_cdb(struct trace_seq *s,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_print_function(pevent,
-				       process_scsi_trace_parse_cdb,
-				       PEVENT_FUNC_ARG_STRING,
-				       "scsi_trace_parse_cdb",
-				       PEVENT_FUNC_ARG_PTR,
-				       PEVENT_FUNC_ARG_PTR,
-				       PEVENT_FUNC_ARG_INT,
-				       PEVENT_FUNC_ARG_VOID);
+	tep_register_print_function(pevent,
+				    process_scsi_trace_parse_cdb,
+				    TEP_FUNC_ARG_STRING,
+				    "scsi_trace_parse_cdb",
+				    TEP_FUNC_ARG_PTR,
+				    TEP_FUNC_ARG_PTR,
+				    TEP_FUNC_ARG_INT,
+				    TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_print_function(pevent, process_scsi_trace_parse_cdb,
-					 "scsi_trace_parse_cdb");
+	tep_unregister_print_function(pevent, process_scsi_trace_parse_cdb,
+				      "scsi_trace_parse_cdb");
 }
diff --git a/tools/lib/traceevent/plugin_xen.c b/tools/lib/traceevent/plugin_xen.c
index 690173bfa13e..b2acbd6e9c86 100644
--- a/tools/lib/traceevent/plugin_xen.c
+++ b/tools/lib/traceevent/plugin_xen.c
@@ -119,19 +119,19 @@ unsigned long long process_xen_hypercall_name(struct trace_seq *s,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct pevent *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
-	pevent_register_print_function(pevent,
-				       process_xen_hypercall_name,
-				       PEVENT_FUNC_ARG_STRING,
-				       "xen_hypercall_name",
-				       PEVENT_FUNC_ARG_INT,
-				       PEVENT_FUNC_ARG_VOID);
+	tep_register_print_function(pevent,
+				    process_xen_hypercall_name,
+				    TEP_FUNC_ARG_STRING,
+				    "xen_hypercall_name",
+				    TEP_FUNC_ARG_INT,
+				    TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct pevent *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
-	pevent_unregister_print_function(pevent, process_xen_hypercall_name,
-					 "xen_hypercall_name");
+	tep_unregister_print_function(pevent, process_xen_hypercall_name,
+				      "xen_hypercall_name");
 }
diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
index 292dc9f1d233..e3bac4543d3b 100644
--- a/tools/lib/traceevent/trace-seq.c
+++ b/tools/lib/traceevent/trace-seq.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * Copyright (C) 2009 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 749cc6055dac..e8c972f89357 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -118,6 +118,15 @@ OPTIONS
 --group::
 	Show event group information together
 
+--percent-type::
+	Set annotation percent type from following choices:
+	  global-period, local-period, global-hits, local-hits
+
+	The local/global keywords set if the percentage is computed
+	in the scope of the function (local) or the whole data (global).
+	The period/hits keywords set the base the percentage is computed
+	on - the samples period or the number of samples (hits).
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 917e36fde6d8..474a4941f65d 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -477,6 +477,15 @@ include::itrace.txt[]
 	Display monitored tasks stored in perf data. Displaying pid/tid/ppid
 	plus the command string aligned to distinguish parent and child tasks.
 
+--percent-type::
+	Set annotation percent type from following choices:
+	  global-period, local-period, global-hits, local-hits
+
+	The local/global keywords set if the percentage is computed
+	in the scope of the function (local) or the whole data (global).
+	The period/hits keywords set the base the percentage is computed
+	on - the samples period or the number of samples (hits).
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 225454416ed5..7902a5681fc8 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -84,10 +84,10 @@ endif # has_clean
 endif # MAKECMDGOALS
 
 #
-# The clean target is not really parallel, don't print the jobs info:
+# Explicitly disable parallelism for the clean target.
 #
 clean:
-	$(make)
+	$(make) -j1
 
 #
 # The build-test target is not really parallel, don't print the jobs info,
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1120e39c1b00..5ccfce87e693 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -194,6 +194,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	sper->itr.read_finish = arm_spe_read_finish;
 	sper->itr.alignment = 0;
 
+	*err = 0;
 	return &sper->itr;
 }
 
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 53d83d7e6a09..20e7d74d86cd 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -141,8 +141,10 @@ void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
 	for (i = 0; i < ntevs; i++) {
 		tev = &pev->tevs[i];
 		map__for_each_symbol(map, sym, tmp) {
-			if (map->unmap_ip(map, sym->start) == tev->point.address)
+			if (map->unmap_ip(map, sym->start) == tev->point.address) {
 				arch__fix_tev_from_maps(pev, tev, map, sym);
+				break;
+			}
 		}
 	}
 }
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 3afe8256eff2..44c857388897 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -30,6 +30,7 @@ cpumsf_info_fill(struct auxtrace_record *itr __maybe_unused,
 		 struct auxtrace_info_event *auxtrace_info __maybe_unused,
 		 size_t priv_size __maybe_unused)
 {
+	auxtrace_info->type = PERF_AUXTRACE_S390_CPUMSF;
 	return 0;
 }
 
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 1a38e78117ce..8cc6642fce7a 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -19,9 +19,6 @@ systbl := $(sys)/syscalltbl.sh
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sys)/syscall_64.tbl $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-        (diff -B arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl >/dev/null) \
-        || echo "Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
 
 clean::
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8180319285af..830481b8db26 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -542,6 +542,10 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
 			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
 			     stdio__config_color, "always"),
+	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
+		     "Set percent type local/global-period/hits",
+		     annotate_parse_percent_type),
+
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 54d3f21b0e62..b63bca4b0c2a 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -729,7 +729,7 @@ static char *compact_gfp_string(unsigned long gfp_flags)
 static int parse_gfp_flags(struct perf_evsel *evsel, struct perf_sample *sample,
 			   unsigned int gfp_flags)
 {
-	struct pevent_record record = {
+	struct tep_record record = {
 		.cpu = sample->cpu,
 		.data = sample->raw_data,
 		.size = sample->raw_size,
@@ -747,7 +747,7 @@ static int parse_gfp_flags(struct perf_evsel *evsel, struct perf_sample *sample,
 	}
 
 	trace_seq_init(&seq);
-	pevent_event_info(&seq, evsel->tp_format, &record);
+	tep_event_info(&seq, evsel->tp_format, &record);
 
 	str = strtok_r(seq.buffer, " ", &pos);
 	while (str) {
@@ -1974,7 +1974,7 @@ int cmd_kmem(int argc, const char **argv)
 			goto out_delete;
 		}
 
-		kmem_page_size = pevent_get_page_size(evsel->tp_format->pevent);
+		kmem_page_size = tep_get_page_size(evsel->tp_format->pevent);
 		symbol_conf.use_callchain = true;
 	}
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 02f7a3c27761..76e12bcd1765 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1124,6 +1124,9 @@ int cmd_report(int argc, const char **argv)
 		   "Time span of interest (start,stop)"),
 	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
 		    "Show inline function"),
+	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
+		     "Set percent type local/global-period/hits",
+		     annotate_parse_percent_type),
 	OPT_END()
 	};
 	struct perf_data data = {
@@ -1366,9 +1369,9 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (session->tevent.pevent &&
-	    pevent_set_function_resolver(session->tevent.pevent,
-					 machine__resolve_kernel_addr,
-					 &session->machines.host) < 0) {
+	    tep_set_function_resolver(session->tevent.pevent,
+				      machine__resolve_kernel_addr,
+				      &session->machines.host) < 0) {
 		pr_err("%s: failed to set libtraceevent function resolver\n",
 		       __func__);
 		return -1;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 568ddfac3213..ba481d73f910 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3429,9 +3429,9 @@ int cmd_script(int argc, const char **argv)
 		symbol_conf.use_callchain = false;
 
 	if (session->tevent.pevent &&
-	    pevent_set_function_resolver(session->tevent.pevent,
-					 machine__resolve_kernel_addr,
-					 &session->machines.host) < 0) {
+	    tep_set_function_resolver(session->tevent.pevent,
+				      machine__resolve_kernel_addr,
+				      &session->machines.host) < 0) {
 		pr_err("%s: failed to set libtraceevent function resolver\n", __func__);
 		err = -1;
 		goto out_delete;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 88561eed7950..22ab8e67c760 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -77,7 +77,8 @@ struct trace {
 		struct syscall  *table;
 		struct {
 			struct perf_evsel *sys_enter,
-					  *sys_exit;
+					  *sys_exit,
+					  *augmented;
 		}		events;
 	} syscalls;
 	struct record_opts	opts;
@@ -121,7 +122,6 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
-	int			open_id;
 };
 
 struct tp_field {
@@ -157,13 +157,11 @@ TP_UINT_FIELD__SWAPPED(16);
 TP_UINT_FIELD__SWAPPED(32);
 TP_UINT_FIELD__SWAPPED(64);
 
-static int tp_field__init_uint(struct tp_field *field,
-			       struct format_field *format_field,
-			       bool needs_swap)
+static int __tp_field__init_uint(struct tp_field *field, int size, int offset, bool needs_swap)
 {
-	field->offset = format_field->offset;
+	field->offset = offset;
 
-	switch (format_field->size) {
+	switch (size) {
 	case 1:
 		field->integer = tp_field__u8;
 		break;
@@ -183,18 +181,28 @@ static int tp_field__init_uint(struct tp_field *field,
 	return 0;
 }
 
+static int tp_field__init_uint(struct tp_field *field, struct format_field *format_field, bool needs_swap)
+{
+	return __tp_field__init_uint(field, format_field->size, format_field->offset, needs_swap);
+}
+
 static void *tp_field__ptr(struct tp_field *field, struct perf_sample *sample)
 {
 	return sample->raw_data + field->offset;
 }
 
-static int tp_field__init_ptr(struct tp_field *field, struct format_field *format_field)
+static int __tp_field__init_ptr(struct tp_field *field, int offset)
 {
-	field->offset = format_field->offset;
+	field->offset = offset;
 	field->pointer = tp_field__ptr;
 	return 0;
 }
 
+static int tp_field__init_ptr(struct tp_field *field, struct format_field *format_field)
+{
+	return __tp_field__init_ptr(field, format_field->offset);
+}
+
 struct syscall_tp {
 	struct tp_field id;
 	union {
@@ -240,7 +248,47 @@ static void perf_evsel__delete_priv(struct perf_evsel *evsel)
 	perf_evsel__delete(evsel);
 }
 
-static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel, void *handler)
+static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+
+	if (evsel->priv != NULL) {
+		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr"))
+			goto out_delete;
+		return 0;
+	}
+
+	return -ENOMEM;
+out_delete:
+	zfree(&evsel->priv);
+	return -ENOENT;
+}
+
+static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+
+	if (evsel->priv != NULL) {       /* field, sizeof_field, offsetof_field */
+		if (__tp_field__init_uint(&sc->id, sizeof(long), sizeof(long long), evsel->needs_swap))
+			goto out_delete;
+
+		return 0;
+	}
+
+	return -ENOMEM;
+out_delete:
+	zfree(&evsel->priv);
+	return -EINVAL;
+}
+
+static int perf_evsel__init_augmented_syscall_tp_args(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv;
+
+	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
+}
+
+static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
 	if (evsel->priv != NULL) {
@@ -258,7 +306,7 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel, void *handler)
 	return -ENOENT;
 }
 
-static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void *handler)
+static struct perf_evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *handler)
 {
 	struct perf_evsel *evsel = perf_evsel__newtp("raw_syscalls", direction);
 
@@ -269,7 +317,7 @@ static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void
 	if (IS_ERR(evsel))
 		return NULL;
 
-	if (perf_evsel__init_syscall_tp(evsel, handler))
+	if (perf_evsel__init_raw_syscall_tp(evsel, handler))
 		goto out_delete;
 
 	return evsel;
@@ -805,12 +853,17 @@ static struct syscall_fmt *syscall_fmt__find(const char *name)
 	return bsearch(name, syscall_fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
 }
 
+/*
+ * is_exit: is this "exit" or "exit_group"?
+ * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
+ */
 struct syscall {
 	struct event_format *tp_format;
 	int		    nr_args;
+	bool		    is_exit;
+	bool		    is_open;
 	struct format_field *args;
 	const char	    *name;
-	bool		    is_exit;
 	struct syscall_fmt  *fmt;
 	struct syscall_arg_fmt *arg_fmt;
 };
@@ -1299,6 +1352,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
+	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
 	return syscall__set_arg_fmts(sc);
 }
@@ -1661,6 +1715,37 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	return err;
 }
 
+static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evsel,
+				    struct perf_sample *sample)
+{
+	struct thread_trace *ttrace;
+	struct thread *thread;
+	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	struct syscall *sc = trace__syscall_info(trace, evsel, id);
+	char msg[1024];
+	void *args;
+
+	if (sc == NULL)
+		return -1;
+
+	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	ttrace = thread__trace(thread, trace->output);
+	/*
+	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
+	 * and the rest of the beautifiers accessing it via struct syscall_arg touches it.
+	 */
+	if (ttrace == NULL)
+		goto out_put;
+
+	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	syscall__scnprintf_args(sc, msg, sizeof(msg), args, trace, thread);
+	fprintf(trace->output, "%s", msg);
+	err = 0;
+out_put:
+	thread__put(thread);
+	return err;
+}
+
 static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evsel,
 				    struct perf_sample *sample,
 				    struct callchain_cursor *cursor)
@@ -1722,7 +1807,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 
 	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
-	if (id == trace->open_id && ret >= 0 && ttrace->filename.pending_open) {
+	if (sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
 		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
 		ttrace->filename.pending_open = false;
 		++trace->stats.vfs_getname;
@@ -1957,11 +2042,17 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	fprintf(trace->output, "%s:", evsel->name);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
-		bpf_output__fprintf(trace, sample);
+		if (evsel == trace->syscalls.events.augmented)
+			trace__fprintf_sys_enter(trace, evsel, sample);
+		else
+			bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
-		event_format__fprintf(evsel->tp_format, sample->cpu,
-				      sample->raw_data, sample->raw_size,
-				      trace->output);
+		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
+		    trace__fprintf_sys_enter(trace, evsel, sample)) {
+			event_format__fprintf(evsel->tp_format, sample->cpu,
+					      sample->raw_data, sample->raw_size,
+					      trace->output);
+		}
 	}
 
 	fprintf(trace->output, "\n");
@@ -2242,14 +2333,14 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	struct perf_evlist *evlist = trace->evlist;
 	struct perf_evsel *sys_enter, *sys_exit;
 
-	sys_enter = perf_evsel__syscall_newtp("sys_enter", trace__sys_enter);
+	sys_enter = perf_evsel__raw_syscall_newtp("sys_enter", trace__sys_enter);
 	if (sys_enter == NULL)
 		goto out;
 
 	if (perf_evsel__init_sc_tp_ptr_field(sys_enter, args))
 		goto out_delete_sys_enter;
 
-	sys_exit = perf_evsel__syscall_newtp("sys_exit", trace__sys_exit);
+	sys_exit = perf_evsel__raw_syscall_newtp("sys_exit", trace__sys_exit);
 	if (sys_exit == NULL)
 		goto out_delete_sys_enter;
 
@@ -2671,7 +2762,7 @@ static int trace__replay(struct trace *trace)
 							     "syscalls:sys_enter");
 
 	if (evsel &&
-	    (perf_evsel__init_syscall_tp(evsel, trace__sys_enter) < 0 ||
+	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_enter) < 0 ||
 	    perf_evsel__init_sc_tp_ptr_field(evsel, args))) {
 		pr_err("Error during initialize raw_syscalls:sys_enter event\n");
 		goto out;
@@ -2683,7 +2774,7 @@ static int trace__replay(struct trace *trace)
 		evsel = perf_evlist__find_tracepoint_by_name(session->evlist,
 							     "syscalls:sys_exit");
 	if (evsel &&
-	    (perf_evsel__init_syscall_tp(evsel, trace__sys_exit) < 0 ||
+	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_exit) < 0 ||
 	    perf_evsel__init_sc_tp_uint_field(evsel, ret))) {
 		pr_err("Error during initialize raw_syscalls:sys_exit event\n");
 		goto out;
@@ -2923,6 +3014,36 @@ static void evlist__set_evsel_handler(struct perf_evlist *evlist, void *handler)
 		evsel->handler = handler;
 }
 
+static int evlist__set_syscall_tp_fields(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->priv || !evsel->tp_format)
+			continue;
+
+		if (strcmp(evsel->tp_format->system, "syscalls"))
+			continue;
+
+		if (perf_evsel__init_syscall_tp(evsel))
+			return -1;
+
+		if (!strncmp(evsel->tp_format->name, "sys_enter_", 10)) {
+			struct syscall_tp *sc = evsel->priv;
+
+			if (__tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64)))
+				return -1;
+		} else if (!strncmp(evsel->tp_format->name, "sys_exit_", 9)) {
+			struct syscall_tp *sc = evsel->priv;
+
+			if (__tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap))
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * XXX: Hackish, just splitting the combined -e+--event (syscalls
  * (raw_syscalls:{sys_{enter,exit}} + events (tracepoints, HW, SW, etc) to use
@@ -3123,8 +3244,9 @@ int cmd_trace(int argc, const char **argv)
 	};
 	bool __maybe_unused max_stack_user_set = true;
 	bool mmap_pages_user_set = true;
+	struct perf_evsel *evsel;
 	const char * const trace_subcommands[] = { "record", NULL };
-	int err;
+	int err = -1;
 	char bf[BUFSIZ];
 
 	signal(SIGSEGV, sighandler_dump_stack);
@@ -3147,6 +3269,20 @@ int cmd_trace(int argc, const char **argv)
 				       "cgroup monitoring only available in system-wide mode");
 	}
 
+	evsel = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
+	if (IS_ERR(evsel)) {
+		bpf__strerror_setup_output_event(trace.evlist, PTR_ERR(evsel), bf, sizeof(bf));
+		pr_err("ERROR: Setup trace syscalls enter failed: %s\n", bf);
+		goto out;
+	}
+
+	if (evsel) {
+		if (perf_evsel__init_augmented_syscall_tp(evsel) ||
+		    perf_evsel__init_augmented_syscall_tp_args(evsel))
+			goto out;
+		trace.syscalls.events.augmented = evsel;
+	}
+
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
 		bpf__strerror_setup_stdout(trace.evlist, err, bf, sizeof(bf));
@@ -3182,8 +3318,13 @@ int cmd_trace(int argc, const char **argv)
 		symbol_conf.use_callchain = true;
 	}
 
-	if (trace.evlist->nr_entries > 0)
+	if (trace.evlist->nr_entries > 0) {
 		evlist__set_evsel_handler(trace.evlist, trace__event_handler);
+		if (evlist__set_syscall_tp_fields(trace.evlist)) {
+			perror("failed to set syscalls:* tracepoint fields");
+			goto out;
+		}
+	}
 
 	if ((argc >= 1) && (strcmp(argv[0], "record") == 0))
 		return trace__record(&trace, argc-1, &argv[1]);
@@ -3205,8 +3346,6 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
-	trace.open_id = syscalltbl__id(trace.sctbl, "open");
-
 	err = target__validate(&trace.opts.target);
 	if (err) {
 		target__strerror(&trace.opts.target, err, bf, sizeof(bf));
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index de28466c0186..466540ee8ea7 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -67,8 +67,12 @@ check_2 () {
 
   cmd="diff $* $file1 $file2 > /dev/null"
 
-  test -f $file2 &&
-  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
+  test -f $file2 && {
+    eval $cmd || {
+      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
+      echo diff -u $file1 $file2
+    }
+  }
 }
 
 check () {
@@ -76,7 +80,7 @@ check () {
 
   shift
 
-  check_2 ../$file ../../$file $*
+  check_2 tools/$file $file $*
 }
 
 # Check if we have the kernel headers (tools/perf/../../include), else
@@ -84,6 +88,8 @@ check () {
 # differences.
 test -d ../../include || exit 0
 
+cd ../..
+
 # simple diff check
 for i in $HEADERS; do
   check $i -B
@@ -94,3 +100,8 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
+
+# diff non-symmetric files
+check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
+
+cd tools/perf
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
new file mode 100644
index 000000000000..69a31386d8cd
--- /dev/null
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Augment the openat syscall with the contents of the filename pointer argument.
+ *
+ * Test it with:
+ *
+ * perf trace -e tools/perf/examples/bpf/augmented_syscalls.c cat /etc/passwd > /dev/null
+ *
+ * It'll catch some openat syscalls related to the dynamic linked and
+ * the last one should be the one for '/etc/passwd'.
+ *
+ * This matches what is marshalled into the raw_syscall:sys_enter payload
+ * expected by the 'perf trace' beautifiers, and can be used by them unmodified,
+ * which will be done as that feature is implemented in the next csets, for now
+ * it will appear in a dump done by the default tracepoint handler in 'perf trace',
+ * that uses bpf_output__fprintf() to just dump those contents, as done with
+ * the bpf-output event associated with the __bpf_output__ map declared in
+ * tools/perf/include/bpf/stdio.h.
+ */
+
+#include <stdio.h>
+
+struct bpf_map SEC("maps") __augmented_syscalls__ = {
+       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+       .key_size = sizeof(int),
+       .value_size = sizeof(u32),
+       .max_entries = __NR_CPUS__,
+};
+
+struct syscall_enter_openat_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   dfd;
+	char		   *filename_ptr;
+	long		   flags;
+	long		   mode;
+};
+
+struct augmented_enter_openat_args {
+	struct syscall_enter_openat_args args;
+	char				 filename[64];
+};
+
+int syscall_enter(openat)(struct syscall_enter_openat_args *args)
+{
+	struct augmented_enter_openat_args augmented_args;
+
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	probe_read_str(&augmented_args.filename, sizeof(augmented_args.filename), args->filename_ptr);
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
+			  &augmented_args, sizeof(augmented_args));
+	return 1;
+}
+
+license(GPL);
diff --git a/tools/perf/examples/bpf/hello.c b/tools/perf/examples/bpf/hello.c
new file mode 100644
index 000000000000..cf3c2fdc7f79
--- /dev/null
+++ b/tools/perf/examples/bpf/hello.c
@@ -0,0 +1,9 @@
+#include <stdio.h>
+
+int syscall_enter(openat)(void *args)
+{
+	puts("Hello, world\n");
+	return 0;
+}
+
+license(GPL);
diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
new file mode 100644
index 000000000000..9cd124b09392
--- /dev/null
+++ b/tools/perf/examples/bpf/sys_enter_openat.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hook into 'openat' syscall entry tracepoint
+ *
+ * Test it with:
+ *
+ * perf trace -e tools/perf/examples/bpf/sys_enter_openat.c cat /etc/passwd > /dev/null
+ *
+ * It'll catch some openat syscalls related to the dynamic linked and
+ * the last one should be the one for '/etc/passwd'.
+ *
+ * The syscall_enter_openat_args can be used to get the syscall fields
+ * and use them for filtering calls, i.e. use in expressions for
+ * the return value.
+ */
+
+#include <bpf.h>
+
+struct syscall_enter_openat_args {
+	unsigned long long unused;
+	long		   syscall_nr;
+	long		   dfd;
+	char		   *filename_ptr;
+	long		   flags;
+	long		   mode;
+};
+
+int syscall_enter(openat)(struct syscall_enter_openat_args *args)
+{
+	return 1;
+}
+
+license(GPL);
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index a63aa6241b7f..47897d65e799 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -4,13 +4,33 @@
 
 #include <uapi/linux/bpf.h>
 
+/*
+ * A helper structure used by eBPF C program to describe map attributes to
+ * elf_bpf loader, taken from tools/testing/selftests/bpf/bpf_helpers.h:
+ */
+struct bpf_map {
+        unsigned int type;
+        unsigned int key_size;
+        unsigned int value_size;
+        unsigned int max_entries;
+        unsigned int map_flags;
+        unsigned int inner_map_idx;
+        unsigned int numa_node;
+};
+
 #define SEC(NAME) __attribute__((section(NAME),  used))
 
 #define probe(function, vars) \
 	SEC(#function "=" #function " " #vars) function
 
+#define syscall_enter(name) \
+	SEC("syscalls:sys_enter_" #name) syscall_enter_ ## name
+
 #define license(name) \
 char _license[] SEC("license") = #name; \
 int _version SEC("version") = LINUX_VERSION_CODE;
 
+static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
+static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
+
 #endif /* _PERF_BPF_H */
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
new file mode 100644
index 000000000000..2899cb7bfed8
--- /dev/null
+++ b/tools/perf/include/bpf/stdio.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <bpf.h>
+
+struct bpf_map SEC("maps") __bpf_stdout__ = {
+       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+       .key_size = sizeof(int),
+       .value_size = sizeof(u32),
+       .max_entries = __NR_CPUS__,
+};
+
+static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) =
+	(void *)BPF_FUNC_perf_event_output;
+
+#define puts(from) \
+	({ const int __len = sizeof(from); \
+	   char __from[__len] = from; \
+	   perf_event_output(args, &__bpf_stdout__, BPF_F_CURRENT_CPU, \
+			  &__from, __len & (sizeof(from) - 1)); })
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
new file mode 100644
index 000000000000..bc03c06c3918
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
@@ -0,0 +1,32 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+   },
+   {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index f03e26ecb658..59cd8604b0bd 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -16,3 +16,4 @@
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
+0x00000000500f0000,v1,ampere/emag,core
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 47bedf25ba69..96e7fc1ad3f9 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -16,8 +16,6 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	bm = bitmap_alloc(nbits);
 
 	if (map && bm) {
-		bitmap_zero(bm, nbits);
-
 		for (i = 0; i < map->nr; i++)
 			set_bit(map->map[i], bm);
 	}
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 4892bd2dc33e..6b049f3f5cf4 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -232,6 +232,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	u64 objdump_addr;
 	const char *objdump_name;
 	char decomp_name[KMOD_DECOMP_LEN];
+	bool decomp = false;
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -305,6 +306,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			return -1;
 		}
 
+		decomp = true;
 		objdump_name = decomp_name;
 	}
 
@@ -312,7 +314,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	objdump_addr = map__rip_2objdump(al.map, al.addr);
 	ret = read_via_objdump(objdump_name, objdump_addr, buf2, len);
 
-	if (dso__needs_decompress(al.map->dso))
+	if (decomp)
 		unlink(objdump_name);
 
 	if (ret > 0) {
diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 148dd31cc201..0579a70bbbff 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -5,34 +5,28 @@
 #include "dso.h"
 #include "debug.h"
 
-static int test(const char *path, bool alloc_name, bool alloc_ext,
-		bool kmod, bool comp, const char *name, const char *ext)
+static int test(const char *path, bool alloc_name, bool kmod,
+		int comp, const char *name)
 {
 	struct kmod_path m;
 
 	memset(&m, 0x0, sizeof(m));
 
 	TEST_ASSERT_VAL("kmod_path__parse",
-			!__kmod_path__parse(&m, path, alloc_name, alloc_ext));
+			!__kmod_path__parse(&m, path, alloc_name));
 
-	pr_debug("%s - alloc name %d, alloc ext %d, kmod %d, comp %d, name '%s', ext '%s'\n",
-		 path, alloc_name, alloc_ext, m.kmod, m.comp, m.name, m.ext);
+	pr_debug("%s - alloc name %d, kmod %d, comp %d, name '%s'\n",
+		 path, alloc_name, m.kmod, m.comp, m.name);
 
 	TEST_ASSERT_VAL("wrong kmod", m.kmod == kmod);
 	TEST_ASSERT_VAL("wrong comp", m.comp == comp);
 
-	if (ext)
-		TEST_ASSERT_VAL("wrong ext", m.ext && !strcmp(ext, m.ext));
-	else
-		TEST_ASSERT_VAL("wrong ext", !m.ext);
-
 	if (name)
 		TEST_ASSERT_VAL("wrong name", m.name && !strcmp(name, m.name));
 	else
 		TEST_ASSERT_VAL("wrong name", !m.name);
 
 	free(m.name);
-	free(m.ext);
 	return 0;
 }
 
@@ -45,118 +39,118 @@ static int test_is_kernel_module(const char *path, int cpumode, bool expect)
 	return 0;
 }
 
-#define T(path, an, ae, k, c, n, e) \
-	TEST_ASSERT_VAL("failed", !test(path, an, ae, k, c, n, e))
+#define T(path, an, k, c, n) \
+	TEST_ASSERT_VAL("failed", !test(path, an, k, c, n))
 
 #define M(path, c, e) \
 	TEST_ASSERT_VAL("failed", !test_is_kernel_module(path, c, e))
 
 int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
-	/* path                alloc_name  alloc_ext   kmod  comp   name     ext */
-	T("/xxxx/xxxx/x-x.ko", true      , true      , true, false, "[x_x]", NULL);
-	T("/xxxx/xxxx/x-x.ko", false     , true      , true, false, NULL   , NULL);
-	T("/xxxx/xxxx/x-x.ko", true      , false     , true, false, "[x_x]", NULL);
-	T("/xxxx/xxxx/x-x.ko", false     , false     , true, false, NULL   , NULL);
+	/* path                alloc_name  kmod  comp   name   */
+	T("/xxxx/xxxx/x-x.ko", true      , true, 0    , "[x_x]");
+	T("/xxxx/xxxx/x-x.ko", false     , true, 0    , NULL   );
+	T("/xxxx/xxxx/x-x.ko", true      , true, 0    , "[x_x]");
+	T("/xxxx/xxxx/x-x.ko", false     , true, 0    , NULL   );
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_USER, false);
 
 #ifdef HAVE_ZLIB_SUPPORT
-	/* path                alloc_name  alloc_ext   kmod  comp  name   ext */
-	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, true, "[x]", "gz");
-	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, true, NULL , "gz");
-	T("/xxxx/xxxx/x.ko.gz", true     , false     , true, true, "[x]", NULL);
-	T("/xxxx/xxxx/x.ko.gz", false    , false     , true, true, NULL , NULL);
+	/* path                alloc_name   kmod  comp  name  */
+	T("/xxxx/xxxx/x.ko.gz", true     , true, 1   , "[x]");
+	T("/xxxx/xxxx/x.ko.gz", false    , true, 1   , NULL );
+	T("/xxxx/xxxx/x.ko.gz", true     , true, 1   , "[x]");
+	T("/xxxx/xxxx/x.ko.gz", false    , true, 1   , NULL );
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_USER, false);
 
-	/* path              alloc_name  alloc_ext  kmod   comp  name    ext */
-	T("/xxxx/xxxx/x.gz", true      , true     , false, true, "x.gz" ,"gz");
-	T("/xxxx/xxxx/x.gz", false     , true     , false, true, NULL   ,"gz");
-	T("/xxxx/xxxx/x.gz", true      , false    , false, true, "x.gz" , NULL);
-	T("/xxxx/xxxx/x.gz", false     , false    , false, true, NULL   , NULL);
+	/* path              alloc_name  kmod   comp  name  */
+	T("/xxxx/xxxx/x.gz", true      , false, 1   , "x.gz");
+	T("/xxxx/xxxx/x.gz", false     , false, 1   , NULL  );
+	T("/xxxx/xxxx/x.gz", true      , false, 1   , "x.gz");
+	T("/xxxx/xxxx/x.gz", false     , false, 1   , NULL  );
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_KERNEL, false);
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_USER, false);
 
-	/* path   alloc_name  alloc_ext  kmod   comp  name     ext */
-	T("x.gz", true      , true     , false, true, "x.gz", "gz");
-	T("x.gz", false     , true     , false, true, NULL  , "gz");
-	T("x.gz", true      , false    , false, true, "x.gz", NULL);
-	T("x.gz", false     , false    , false, true, NULL  , NULL);
+	/* path   alloc_name  kmod   comp  name   */
+	T("x.gz", true      , false, 1   , "x.gz");
+	T("x.gz", false     , false, 1   , NULL  );
+	T("x.gz", true      , false, 1   , "x.gz");
+	T("x.gz", false     , false, 1   , NULL  );
 	M("x.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("x.gz", PERF_RECORD_MISC_KERNEL, false);
 	M("x.gz", PERF_RECORD_MISC_USER, false);
 
-	/* path      alloc_name  alloc_ext  kmod  comp  name  ext */
-	T("x.ko.gz", true      , true     , true, true, "[x]", "gz");
-	T("x.ko.gz", false     , true     , true, true, NULL , "gz");
-	T("x.ko.gz", true      , false    , true, true, "[x]", NULL);
-	T("x.ko.gz", false     , false    , true, true, NULL , NULL);
+	/* path      alloc_name  kmod  comp  name  */
+	T("x.ko.gz", true      , true, 1   , "[x]");
+	T("x.ko.gz", false     , true, 1   , NULL );
+	T("x.ko.gz", true      , true, 1   , "[x]");
+	T("x.ko.gz", false     , true, 1   , NULL );
 	M("x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("x.ko.gz", PERF_RECORD_MISC_USER, false);
 #endif
 
-	/* path            alloc_name  alloc_ext  kmod  comp   name             ext */
-	T("[test_module]", true      , true     , true, false, "[test_module]", NULL);
-	T("[test_module]", false     , true     , true, false, NULL           , NULL);
-	T("[test_module]", true      , false    , true, false, "[test_module]", NULL);
-	T("[test_module]", false     , false    , true, false, NULL           , NULL);
+	/* path            alloc_name  kmod  comp   name           */
+	T("[test_module]", true      , true, false, "[test_module]");
+	T("[test_module]", false     , true, false, NULL           );
+	T("[test_module]", true      , true, false, "[test_module]");
+	T("[test_module]", false     , true, false, NULL           );
 	M("[test_module]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("[test_module]", PERF_RECORD_MISC_KERNEL, true);
 	M("[test_module]", PERF_RECORD_MISC_USER, false);
 
-	/* path            alloc_name  alloc_ext  kmod  comp   name             ext */
-	T("[test.module]", true      , true     , true, false, "[test.module]", NULL);
-	T("[test.module]", false     , true     , true, false, NULL           , NULL);
-	T("[test.module]", true      , false    , true, false, "[test.module]", NULL);
-	T("[test.module]", false     , false    , true, false, NULL           , NULL);
+	/* path            alloc_name  kmod  comp   name           */
+	T("[test.module]", true      , true, false, "[test.module]");
+	T("[test.module]", false     , true, false, NULL           );
+	T("[test.module]", true      , true, false, "[test.module]");
+	T("[test.module]", false     , true, false, NULL           );
 	M("[test.module]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("[test.module]", PERF_RECORD_MISC_KERNEL, true);
 	M("[test.module]", PERF_RECORD_MISC_USER, false);
 
-	/* path     alloc_name  alloc_ext  kmod   comp   name      ext */
-	T("[vdso]", true      , true     , false, false, "[vdso]", NULL);
-	T("[vdso]", false     , true     , false, false, NULL    , NULL);
-	T("[vdso]", true      , false    , false, false, "[vdso]", NULL);
-	T("[vdso]", false     , false    , false, false, NULL    , NULL);
+	/* path     alloc_name  kmod   comp   name    */
+	T("[vdso]", true      , false, false, "[vdso]");
+	T("[vdso]", false     , false, false, NULL    );
+	T("[vdso]", true      , false, false, "[vdso]");
+	T("[vdso]", false     , false, false, NULL    );
 	M("[vdso]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[vdso]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdso]", PERF_RECORD_MISC_USER, false);
 
-	T("[vdso32]", true      , true     , false, false, "[vdso32]", NULL);
-	T("[vdso32]", false     , true     , false, false, NULL    , NULL);
-	T("[vdso32]", true      , false    , false, false, "[vdso32]", NULL);
-	T("[vdso32]", false     , false    , false, false, NULL    , NULL);
+	T("[vdso32]", true      , false, false, "[vdso32]");
+	T("[vdso32]", false     , false, false, NULL      );
+	T("[vdso32]", true      , false, false, "[vdso32]");
+	T("[vdso32]", false     , false, false, NULL      );
 	M("[vdso32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[vdso32]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdso32]", PERF_RECORD_MISC_USER, false);
 
-	T("[vdsox32]", true      , true     , false, false, "[vdsox32]", NULL);
-	T("[vdsox32]", false     , true     , false, false, NULL    , NULL);
-	T("[vdsox32]", true      , false    , false, false, "[vdsox32]", NULL);
-	T("[vdsox32]", false     , false    , false, false, NULL    , NULL);
+	T("[vdsox32]", true      , false, false, "[vdsox32]");
+	T("[vdsox32]", false     , false, false, NULL       );
+	T("[vdsox32]", true      , false, false, "[vdsox32]");
+	T("[vdsox32]", false     , false, false, NULL       );
 	M("[vdsox32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[vdsox32]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdsox32]", PERF_RECORD_MISC_USER, false);
 
-	/* path         alloc_name  alloc_ext  kmod   comp   name          ext */
-	T("[vsyscall]", true      , true     , false, false, "[vsyscall]", NULL);
-	T("[vsyscall]", false     , true     , false, false, NULL        , NULL);
-	T("[vsyscall]", true      , false    , false, false, "[vsyscall]", NULL);
-	T("[vsyscall]", false     , false    , false, false, NULL        , NULL);
+	/* path         alloc_name  kmod   comp   name        */
+	T("[vsyscall]", true      , false, false, "[vsyscall]");
+	T("[vsyscall]", false     , false, false, NULL        );
+	T("[vsyscall]", true      , false, false, "[vsyscall]");
+	T("[vsyscall]", false     , false, false, NULL        );
 	M("[vsyscall]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[vsyscall]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vsyscall]", PERF_RECORD_MISC_USER, false);
 
-	/* path                alloc_name  alloc_ext  kmod   comp   name      ext */
-	T("[kernel.kallsyms]", true      , true     , false, false, "[kernel.kallsyms]", NULL);
-	T("[kernel.kallsyms]", false     , true     , false, false, NULL               , NULL);
-	T("[kernel.kallsyms]", true      , false    , false, false, "[kernel.kallsyms]", NULL);
-	T("[kernel.kallsyms]", false     , false    , false, false, NULL               , NULL);
+	/* path                alloc_name  kmod   comp   name      */
+	T("[kernel.kallsyms]", true      , false, false, "[kernel.kallsyms]");
+	T("[kernel.kallsyms]", false     , false, false, NULL               );
+	T("[kernel.kallsyms]", true      , false, false, "[kernel.kallsyms]");
+	T("[kernel.kallsyms]", false     , false, false, NULL               );
 	M("[kernel.kallsyms]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[kernel.kallsyms]", PERF_RECORD_MISC_KERNEL, false);
 	M("[kernel.kallsyms]", PERF_RECORD_MISC_USER, false);
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 0c3c87f86e03..9e9e4d37cc77 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -24,8 +24,6 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	bm = bitmap_alloc(nbits);
 
 	if (map && bm) {
-		bitmap_zero(bm, nbits);
-
 		for (i = 0; i < map->nr; i++) {
 			set_bit(map->map[i], bm);
 		}
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3b4f1c10ff57..1d00e5ec7906 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <sys/ttydefaults.h>
+#include <asm/bug.h>
 
 struct disasm_line_samples {
 	double		      percent;
@@ -115,7 +116,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		ops.width += 1;
 
-	annotation_line__write(al, notes, &ops);
+	annotation_line__write(al, notes, &ops, ab->opts);
 
 	if (ops.current_entry)
 		ab->selection = al;
@@ -227,10 +228,10 @@ static int disasm__cmp(struct annotation_line *a, struct annotation_line *b)
 {
 	int i;
 
-	for (i = 0; i < a->samples_nr; i++) {
-		if (a->samples[i].percent == b->samples[i].percent)
+	for (i = 0; i < a->data_nr; i++) {
+		if (a->data[i].percent == b->data[i].percent)
 			continue;
-		return a->samples[i].percent < b->samples[i].percent;
+		return a->data[i].percent < b->data[i].percent;
 	}
 	return 0;
 }
@@ -314,11 +315,14 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			continue;
 		}
 
-		for (i = 0; i < pos->al.samples_nr; i++) {
-			struct annotation_data *sample = &pos->al.samples[i];
+		for (i = 0; i < pos->al.data_nr; i++) {
+			double percent;
 
-			if (max_percent < sample->percent)
-				max_percent = sample->percent;
+			percent = annotation_data__percent(&pos->al.data[i],
+							   browser->opts->percent_type);
+
+			if (max_percent < percent)
+				max_percent = percent;
 		}
 
 		if (max_percent < 0.01 && pos->al.ipc == 0) {
@@ -380,9 +384,10 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 #define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
 
 static int sym_title(struct symbol *sym, struct map *map, char *title,
-		     size_t sz)
+		     size_t sz, int percent_type)
 {
-	return snprintf(title, sz, "%s  %s", sym->name, map->dso->long_name);
+	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name, map->dso->long_name,
+			percent_type_str(percent_type));
 }
 
 /*
@@ -420,7 +425,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 
 	pthread_mutex_unlock(&notes->lock);
 	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt, browser->opts);
-	sym_title(ms->sym, ms->map, title, sizeof(title));
+	sym_title(ms->sym, ms->map, title, sizeof(title), browser->opts->percent_type);
 	ui_browser__show_title(&browser->b, title);
 	return true;
 }
@@ -595,6 +600,7 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 
 static int annotate_browser__show(struct ui_browser *browser, char *title, const char *help)
 {
+	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct map_symbol *ms = browser->priv;
 	struct symbol *sym = ms->sym;
 	char symbol_dso[SYM_TITLE_MAX_SIZE];
@@ -602,7 +608,7 @@ static int annotate_browser__show(struct ui_browser *browser, char *title, const
 	if (ui_browser__show(browser, title, help) < 0)
 		return -1;
 
-	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso));
+	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso), ab->opts->percent_type);
 
 	ui_browser__gotorc_title(browser, 0, 0);
 	ui_browser__set_color(browser, HE_COLORSET_ROOT);
@@ -610,6 +616,39 @@ static int annotate_browser__show(struct ui_browser *browser, char *title, const
 	return 0;
 }
 
+static void
+switch_percent_type(struct annotation_options *opts, bool base)
+{
+	switch (opts->percent_type) {
+	case PERCENT_HITS_LOCAL:
+		if (base)
+			opts->percent_type = PERCENT_PERIOD_LOCAL;
+		else
+			opts->percent_type = PERCENT_HITS_GLOBAL;
+		break;
+	case PERCENT_HITS_GLOBAL:
+		if (base)
+			opts->percent_type = PERCENT_PERIOD_GLOBAL;
+		else
+			opts->percent_type = PERCENT_HITS_LOCAL;
+		break;
+	case PERCENT_PERIOD_LOCAL:
+		if (base)
+			opts->percent_type = PERCENT_HITS_LOCAL;
+		else
+			opts->percent_type = PERCENT_PERIOD_GLOBAL;
+		break;
+	case PERCENT_PERIOD_GLOBAL:
+		if (base)
+			opts->percent_type = PERCENT_HITS_GLOBAL;
+		else
+			opts->percent_type = PERCENT_PERIOD_LOCAL;
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct perf_evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -624,8 +663,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	char title[256];
 	int key;
 
-	annotation__scnprintf_samples_period(notes, title, sizeof(title), evsel);
-
+	hists__scnprintf_title(hists, title, sizeof(title));
 	if (annotate_browser__show(&browser->b, title, help) < 0)
 		return -1;
 
@@ -701,6 +739,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"k             Toggle line numbers\n"
 		"P             Print to [symbol_name].annotation file.\n"
 		"r             Run available scripts\n"
+		"p             Toggle percent type [local/global]\n"
+		"b             Toggle percent base [period/hits]\n"
 		"?             Search string backwards\n");
 			continue;
 		case 'r':
@@ -781,7 +821,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		}
 		case 'P':
-			map_symbol__annotation_dump(ms, evsel);
+			map_symbol__annotation_dump(ms, evsel, browser->opts);
 			continue;
 		case 't':
 			if (notes->options->show_total_period) {
@@ -800,6 +840,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				notes->options->show_minmax_cycle = true;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'p':
+		case 'b':
+			switch_percent_type(browser->opts, key == 'b');
+			hists__scnprintf_title(hists, title, sizeof(title));
+			annotate_browser__show(&browser->b, title, help);
+			continue;
 		case K_LEFT:
 		case K_ESC:
 		case 'q':
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b604ef334dc9..7efe15b9618d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -87,6 +87,7 @@ libperf-$(CONFIG_AUXTRACE) += intel-pt.o
 libperf-$(CONFIG_AUXTRACE) += intel-bts.o
 libperf-$(CONFIG_AUXTRACE) += arm-spe.o
 libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+libperf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
 libperf-$(CONFIG_AUXTRACE) += cs-etm.o
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f91775b4bc3c..20061cf42288 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -49,6 +49,7 @@ struct annotation_options annotation__default_options = {
 	.jump_arrows    = true,
 	.annotate_src	= true,
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
+	.percent_type	= PERCENT_PERIOD_LOCAL,
 };
 
 static regex_t	 file_lineno;
@@ -1108,7 +1109,7 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 	if (perf_evsel__is_group_event(evsel))
 		nr = evsel->nr_members;
 
-	size += sizeof(al->samples[0]) * nr;
+	size += sizeof(al->data[0]) * nr;
 
 	al = zalloc(size);
 	if (al) {
@@ -1117,7 +1118,7 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 		al->offset     = args->offset;
 		al->line       = strdup(args->line);
 		al->line_nr    = args->line_nr;
-		al->samples_nr = nr;
+		al->data_nr    = nr;
 	}
 
 	return al;
@@ -1297,7 +1298,8 @@ static int disasm_line__print(struct disasm_line *dl, u64 start, int addr_fmt_wi
 static int
 annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
 		       struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
-		       int max_lines, struct annotation_line *queue, int addr_fmt_width)
+		       int max_lines, struct annotation_line *queue, int addr_fmt_width,
+		       int percent_type)
 {
 	struct disasm_line *dl = container_of(al, struct disasm_line, al);
 	static const char *prev_line;
@@ -1309,15 +1311,18 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		const char *color;
 		struct annotation *notes = symbol__annotation(sym);
 
-		for (i = 0; i < al->samples_nr; i++) {
-			struct annotation_data *sample = &al->samples[i];
+		for (i = 0; i < al->data_nr; i++) {
+			double percent;
 
-			if (sample->percent > max_percent)
-				max_percent = sample->percent;
+			percent = annotation_data__percent(&al->data[i],
+							   percent_type);
+
+			if (percent > max_percent)
+				max_percent = percent;
 		}
 
-		if (al->samples_nr > nr_percent)
-			nr_percent = al->samples_nr;
+		if (al->data_nr > nr_percent)
+			nr_percent = al->data_nr;
 
 		if (max_percent < min_pcnt)
 			return -1;
@@ -1330,7 +1335,8 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				if (queue == al)
 					break;
 				annotation_line__print(queue, sym, start, evsel, len,
-						       0, 0, 1, NULL, addr_fmt_width);
+						       0, 0, 1, NULL, addr_fmt_width,
+						       percent_type);
 			}
 		}
 
@@ -1351,18 +1357,20 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		}
 
 		for (i = 0; i < nr_percent; i++) {
-			struct annotation_data *sample = &al->samples[i];
+			struct annotation_data *data = &al->data[i];
+			double percent;
 
-			color = get_percent_color(sample->percent);
+			percent = annotation_data__percent(data, percent_type);
+			color = get_percent_color(percent);
 
 			if (symbol_conf.show_total_period)
 				color_fprintf(stdout, color, " %11" PRIu64,
-					      sample->he.period);
+					      data->he.period);
 			else if (symbol_conf.show_nr_samples)
 				color_fprintf(stdout, color, " %7" PRIu64,
-					      sample->he.nr_samples);
+					      data->he.nr_samples);
 			else
-				color_fprintf(stdout, color, " %7.2f", sample->percent);
+				color_fprintf(stdout, color, " %7.2f", percent);
 		}
 
 		printf(" : ");
@@ -1621,6 +1629,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	char symfs_filename[PATH_MAX];
 	struct kcore_extract kce;
 	bool delete_extract = false;
+	bool decomp = false;
 	int stdout_fd[2];
 	int lineno = 0;
 	int nline;
@@ -1654,6 +1663,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 						 tmp, sizeof(tmp)) < 0)
 			goto out;
 
+		decomp = true;
 		strcpy(symfs_filename, tmp);
 	}
 
@@ -1740,7 +1750,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 out_remove_tmp:
 	close(stdout_fd[0]);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(symfs_filename);
 
 	if (delete_extract)
@@ -1753,34 +1763,45 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	goto out_free_command;
 }
 
-static void calc_percent(struct sym_hist *hist,
-			 struct annotation_data *sample,
+static void calc_percent(struct sym_hist *sym_hist,
+			 struct hists *hists,
+			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
 	unsigned int hits = 0;
 	u64 period = 0;
 
 	while (offset < end) {
-		hits   += hist->addr[offset].nr_samples;
-		period += hist->addr[offset].period;
+		hits   += sym_hist->addr[offset].nr_samples;
+		period += sym_hist->addr[offset].period;
 		++offset;
 	}
 
-	if (hist->nr_samples) {
-		sample->he.period     = period;
-		sample->he.nr_samples = hits;
-		sample->percent = 100.0 * hits / hist->nr_samples;
+	if (sym_hist->nr_samples) {
+		data->he.period     = period;
+		data->he.nr_samples = hits;
+		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
+
+	if (hists->stats.nr_non_filtered_samples)
+		data->percent[PERCENT_HITS_GLOBAL] = 100.0 * hits / hists->stats.nr_non_filtered_samples;
+
+	if (sym_hist->period)
+		data->percent[PERCENT_PERIOD_LOCAL] = 100.0 * period / sym_hist->period;
+
+	if (hists->stats.total_period)
+		data->percent[PERCENT_PERIOD_GLOBAL] = 100.0 * period / hists->stats.total_period;
 }
 
 static void annotation__calc_percent(struct annotation *notes,
-				     struct perf_evsel *evsel, s64 len)
+				     struct perf_evsel *leader, s64 len)
 {
 	struct annotation_line *al, *next;
+	struct perf_evsel *evsel;
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		s64 end;
-		int i;
+		int i = 0;
 
 		if (al->offset == -1)
 			continue;
@@ -1788,14 +1809,17 @@ static void annotation__calc_percent(struct annotation *notes,
 		next = annotation_line__next(al, &notes->src->source);
 		end  = next ? next->offset : len;
 
-		for (i = 0; i < al->samples_nr; i++) {
-			struct annotation_data *sample;
-			struct sym_hist *hist;
+		for_each_group_evsel(evsel, leader) {
+			struct hists *hists = evsel__hists(evsel);
+			struct annotation_data *data;
+			struct sym_hist *sym_hist;
+
+			BUG_ON(i >= al->data_nr);
 
-			hist   = annotation__histogram(notes, evsel->idx + i);
-			sample = &al->samples[i];
+			sym_hist = annotation__histogram(notes, evsel->idx);
+			data = &al->data[i++];
 
-			calc_percent(hist, sample, al->offset, end);
+			calc_percent(sym_hist, hists, data, al->offset, end);
 		}
 	}
 }
@@ -1846,7 +1870,8 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	return symbol__disassemble(sym, &args);
 }
 
-static void insert_source_line(struct rb_root *root, struct annotation_line *al)
+static void insert_source_line(struct rb_root *root, struct annotation_line *al,
+			       struct annotation_options *opts)
 {
 	struct annotation_line *iter;
 	struct rb_node **p = &root->rb_node;
@@ -1859,8 +1884,10 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 
 		ret = strcmp(iter->path, al->path);
 		if (ret == 0) {
-			for (i = 0; i < al->samples_nr; i++)
-				iter->samples[i].percent_sum += al->samples[i].percent;
+			for (i = 0; i < al->data_nr; i++) {
+				iter->data[i].percent_sum += annotation_data__percent(&al->data[i],
+										      opts->percent_type);
+			}
 			return;
 		}
 
@@ -1870,8 +1897,10 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 			p = &(*p)->rb_right;
 	}
 
-	for (i = 0; i < al->samples_nr; i++)
-		al->samples[i].percent_sum = al->samples[i].percent;
+	for (i = 0; i < al->data_nr; i++) {
+		al->data[i].percent_sum = annotation_data__percent(&al->data[i],
+								   opts->percent_type);
+	}
 
 	rb_link_node(&al->rb_node, parent, p);
 	rb_insert_color(&al->rb_node, root);
@@ -1881,10 +1910,10 @@ static int cmp_source_line(struct annotation_line *a, struct annotation_line *b)
 {
 	int i;
 
-	for (i = 0; i < a->samples_nr; i++) {
-		if (a->samples[i].percent_sum == b->samples[i].percent_sum)
+	for (i = 0; i < a->data_nr; i++) {
+		if (a->data[i].percent_sum == b->data[i].percent_sum)
 			continue;
-		return a->samples[i].percent_sum > b->samples[i].percent_sum;
+		return a->data[i].percent_sum > b->data[i].percent_sum;
 	}
 
 	return 0;
@@ -1949,8 +1978,8 @@ static void print_summary(struct rb_root *root, const char *filename)
 		int i;
 
 		al = rb_entry(node, struct annotation_line, rb_node);
-		for (i = 0; i < al->samples_nr; i++) {
-			percent = al->samples[i].percent_sum;
+		for (i = 0; i < al->data_nr; i++) {
+			percent = al->data[i].percent_sum;
 			color = get_percent_color(percent);
 			color_fprintf(stdout, color, " %7.2f", percent);
 
@@ -2029,10 +2058,12 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		evsel_name = buf;
 	}
 
-	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
+	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples, "
+				  "percent: %s)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
 				  symbol_conf.show_nr_samples ? "Samples" : "Percent",
-				  d_filename, evsel_name, h->nr_samples);
+				  d_filename, evsel_name, h->nr_samples,
+				  percent_type_str(opts->percent_type));
 
 	printf("%-*.*s----\n",
 	       graph_dotted_len, graph_dotted_len, graph_dotted_line);
@@ -2052,7 +2083,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 
 		err = annotation_line__print(pos, sym, start, evsel, len,
 					     opts->min_pcnt, printed, opts->max_lines,
-					     queue, addr_fmt_width);
+					     queue, addr_fmt_width, opts->percent_type);
 
 		switch (err) {
 		case 0:
@@ -2129,10 +2160,11 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
+				     struct annotation_options *opts)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct annotation_write_ops ops = {
+	struct annotation_write_ops wops = {
 		.first_line		 = true,
 		.obj			 = fp,
 		.set_color		 = FILE__set_color,
@@ -2146,15 +2178,16 @@ int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 	list_for_each_entry(al, &notes->src->source, node) {
 		if (annotation_line__filter(al, notes))
 			continue;
-		annotation_line__write(al, notes, &ops);
+		annotation_line__write(al, notes, &wops, opts);
 		fputc('\n', fp);
-		ops.first_line = false;
+		wops.first_line = false;
 	}
 
 	return 0;
 }
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel)
+int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel,
+				struct annotation_options *opts)
 {
 	const char *ev_name = perf_evsel__name(evsel);
 	char buf[1024];
@@ -2176,7 +2209,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel)
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
 		ms->sym->name, ms->map->dso->long_name, ev_name);
-	symbol__annotate_fprintf2(ms->sym, fp);
+	symbol__annotate_fprintf2(ms->sym, fp, opts);
 
 	fclose(fp);
 	err = 0;
@@ -2346,7 +2379,8 @@ void annotation__update_column_widths(struct annotation *notes)
 }
 
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
-				  struct rb_root *root)
+				   struct rb_root *root,
+				   struct annotation_options *opts)
 {
 	struct annotation_line *al;
 	struct rb_root tmp_root = RB_ROOT;
@@ -2355,13 +2389,14 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		double percent_max = 0.0;
 		int i;
 
-		for (i = 0; i < al->samples_nr; i++) {
-			struct annotation_data *sample;
+		for (i = 0; i < al->data_nr; i++) {
+			double percent;
 
-			sample = &al->samples[i];
+			percent = annotation_data__percent(&al->data[i],
+							   opts->percent_type);
 
-			if (sample->percent > percent_max)
-				percent_max = sample->percent;
+			if (percent > percent_max)
+				percent_max = percent;
 		}
 
 		if (percent_max <= 0.5)
@@ -2369,18 +2404,19 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 
 		al->path = get_srcline(map->dso, notes->start + al->offset, NULL,
 				       false, true, notes->start + al->offset);
-		insert_source_line(&tmp_root, al);
+		insert_source_line(&tmp_root, al, opts);
 	}
 
 	resort_source_line(root, &tmp_root);
 }
 
 static void symbol__calc_lines(struct symbol *sym, struct map *map,
-			      struct rb_root *root)
+			       struct rb_root *root,
+			       struct annotation_options *opts)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
-	annotation__calc_lines(notes, map, root);
+	annotation__calc_lines(notes, map, root, opts);
 }
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
@@ -2389,7 +2425,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
-	struct annotation *notes = symbol__annotation(sym);
+	struct hists *hists = evsel__hists(evsel);
 	char buf[1024];
 
 	if (symbol__annotate2(sym, map, evsel, opts, NULL) < 0)
@@ -2397,13 +2433,14 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(sym, map, &source_line);
+		symbol__calc_lines(sym, map, &source_line, opts);
 		print_summary(&source_line, dso->long_name);
 	}
 
-	annotation__scnprintf_samples_period(notes, buf, sizeof(buf), evsel);
-	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
-	symbol__annotate_fprintf2(sym, stdout);
+	hists__scnprintf_title(hists, buf, sizeof(buf));
+	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
+		buf, percent_type_str(opts->percent_type), sym->name, dso->long_name);
+	symbol__annotate_fprintf2(sym, stdout, opts);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
@@ -2424,7 +2461,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(sym, map, &source_line);
+		symbol__calc_lines(sym, map, &source_line, opts);
 		print_summary(&source_line, dso->long_name);
 	}
 
@@ -2441,14 +2478,21 @@ bool ui__has_annotation(void)
 }
 
 
-double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes)
+static double annotation_line__max_percent(struct annotation_line *al,
+					   struct annotation *notes,
+					   unsigned int percent_type)
 {
 	double percent_max = 0.0;
 	int i;
 
 	for (i = 0; i < notes->nr_events; i++) {
-		if (al->samples[i].percent > percent_max)
-			percent_max = al->samples[i].percent;
+		double percent;
+
+		percent = annotation_data__percent(&al->data[i],
+						   percent_type);
+
+		if (percent > percent_max)
+			percent_max = percent;
 	}
 
 	return percent_max;
@@ -2487,7 +2531,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 
 static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
 				     bool first_line, bool current_entry, bool change_color, int width,
-				     void *obj,
+				     void *obj, unsigned int percent_type,
 				     int  (*obj__set_color)(void *obj, int color),
 				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
 				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
@@ -2495,7 +2539,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 				     void (*obj__write_graph)(void *obj, int graph))
 
 {
-	double percent_max = annotation_line__max_percent(al, notes);
+	double percent_max = annotation_line__max_percent(al, notes, percent_type);
 	int pcnt_width = annotation__pcnt_width(notes),
 	    cycles_width = annotation__cycles_width(notes);
 	bool show_title = false;
@@ -2514,15 +2558,18 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		int i;
 
 		for (i = 0; i < notes->nr_events; i++) {
-			obj__set_percent_color(obj, al->samples[i].percent, current_entry);
+			double percent;
+
+			percent = annotation_data__percent(&al->data[i], percent_type);
+
+			obj__set_percent_color(obj, percent, current_entry);
 			if (notes->options->show_total_period) {
-				obj__printf(obj, "%11" PRIu64 " ", al->samples[i].he.period);
+				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
 			} else if (notes->options->show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
-						   al->samples[i].he.nr_samples);
+						   al->data[i].he.nr_samples);
 			} else {
-				obj__printf(obj, "%6.2f ",
-						   al->samples[i].percent);
+				obj__printf(obj, "%6.2f ", percent);
 			}
 		}
 	} else {
@@ -2640,13 +2687,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 }
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *ops)
+			    struct annotation_write_ops *wops,
+			    struct annotation_options *opts)
 {
-	__annotation_line__write(al, notes, ops->first_line, ops->current_entry,
-				 ops->change_color, ops->width, ops->obj,
-				 ops->set_color, ops->set_percent_color,
-				 ops->set_jumps_percent_color, ops->printf,
-				 ops->write_graph);
+	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
+				 wops->change_color, wops->width, wops->obj,
+				 opts->percent_type,
+				 wops->set_color, wops->set_percent_color,
+				 wops->set_jumps_percent_color, wops->printf,
+				 wops->write_graph);
 }
 
 int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
@@ -2688,46 +2737,6 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	return -1;
 }
 
-int __annotation__scnprintf_samples_period(struct annotation *notes,
-					   char *bf, size_t size,
-					   struct perf_evsel *evsel,
-					   bool show_freq)
-{
-	const char *ev_name = perf_evsel__name(evsel);
-	char buf[1024], ref[30] = " show reference callgraph, ";
-	char sample_freq_str[64] = "";
-	unsigned long nr_samples = 0;
-	int nr_members = 1;
-	bool enable_ref = false;
-	u64 nr_events = 0;
-	char unit;
-	int i;
-
-	if (perf_evsel__is_group_event(evsel)) {
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
-		ev_name = buf;
-                nr_members = evsel->nr_members;
-	}
-
-	for (i = 0; i < nr_members; i++) {
-		struct sym_hist *ah = annotation__histogram(notes, evsel->idx + i);
-
-		nr_samples += ah->nr_samples;
-		nr_events  += ah->period;
-	}
-
-	if (symbol_conf.show_ref_callgraph && strstr(ev_name, "call-graph=no"))
-		enable_ref = true;
-
-	if (show_freq)
-		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
-
-	nr_samples = convert_unit(nr_samples, &unit);
-	return scnprintf(bf, size, "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
-			 nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
-			 ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
-}
-
 #define ANNOTATION__CFG(n) \
 	{ .name = #n, .value = &annotation__default_options.n, }
 
@@ -2792,3 +2801,55 @@ void annotation_config__init(void)
 	annotation__default_options.show_total_period = symbol_conf.show_total_period;
 	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
 }
+
+static unsigned int parse_percent_type(char *str1, char *str2)
+{
+	unsigned int type = (unsigned int) -1;
+
+	if (!strcmp("period", str1)) {
+		if (!strcmp("local", str2))
+			type = PERCENT_PERIOD_LOCAL;
+		else if (!strcmp("global", str2))
+			type = PERCENT_PERIOD_GLOBAL;
+	}
+
+	if (!strcmp("hits", str1)) {
+		if (!strcmp("local", str2))
+			type = PERCENT_HITS_LOCAL;
+		else if (!strcmp("global", str2))
+			type = PERCENT_HITS_GLOBAL;
+	}
+
+	return type;
+}
+
+int annotate_parse_percent_type(const struct option *opt, const char *_str,
+				int unset __maybe_unused)
+{
+	struct annotation_options *opts = opt->value;
+	unsigned int type;
+	char *str1, *str2;
+	int err = -1;
+
+	str1 = strdup(_str);
+	if (!str1)
+		return -ENOMEM;
+
+	str2 = strchr(str1, '-');
+	if (!str2)
+		goto out;
+
+	*str2++ = 0;
+
+	type = parse_percent_type(str1, str2);
+	if (type == (unsigned int) -1)
+		type = parse_percent_type(str2, str1);
+	if (type != (unsigned int) -1) {
+		opts->percent_type = type;
+		err = 0;
+	}
+
+out:
+	free(str1);
+	return err;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a4c0d91907e6..005a5fe8a8c6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <pthread.h>
+#include <asm/bug.h>
 
 struct ins_ops;
 
@@ -82,6 +83,7 @@ struct annotation_options {
 	int  context;
 	const char *objdump_path;
 	const char *disassembler_style;
+	unsigned int percent_type;
 };
 
 enum {
@@ -101,8 +103,16 @@ struct sym_hist_entry {
 	u64		period;
 };
 
+enum {
+	PERCENT_HITS_LOCAL,
+	PERCENT_HITS_GLOBAL,
+	PERCENT_PERIOD_LOCAL,
+	PERCENT_PERIOD_GLOBAL,
+	PERCENT_MAX,
+};
+
 struct annotation_data {
-	double			 percent;
+	double			 percent[PERCENT_MAX];
 	double			 percent_sum;
 	struct sym_hist_entry	 he;
 };
@@ -122,8 +132,8 @@ struct annotation_line {
 	char			*path;
 	u32			 idx;
 	int			 idx_asm;
-	int			 samples_nr;
-	struct annotation_data	 samples[0];
+	int			 data_nr;
+	struct annotation_data	 data[0];
 };
 
 struct disasm_line {
@@ -134,6 +144,27 @@ struct disasm_line {
 	struct annotation_line	 al;
 };
 
+static inline double annotation_data__percent(struct annotation_data *data,
+					      unsigned int which)
+{
+	return which < PERCENT_MAX ? data->percent[which] : -1;
+}
+
+static inline const char *percent_type_str(unsigned int type)
+{
+	static const char *str[PERCENT_MAX] = {
+		"local hits",
+		"global hits",
+		"local period",
+		"global period",
+	};
+
+	if (WARN_ON(type >= PERCENT_MAX))
+		return "N/A";
+
+	return str[type];
+}
+
 static inline struct disasm_line *disasm_line(struct annotation_line *al)
 {
 	return al ? container_of(al, struct disasm_line, al) : NULL;
@@ -169,22 +200,15 @@ struct annotation_write_ops {
 	void (*write_graph)(void *obj, int graph);
 };
 
-double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes);
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *ops);
+			    struct annotation_write_ops *ops,
+			    struct annotation_options *opts);
 
 int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   char *bf, size_t size,
 					   struct perf_evsel *evsel,
 					   bool show_freq);
 
-static inline int annotation__scnprintf_samples_period(struct annotation *notes,
-						       char *bf, size_t size,
-						       struct perf_evsel *evsel)
-{
-	return __annotation__scnprintf_samples_period(notes, bf, size, evsel, true);
-}
-
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
@@ -340,12 +364,12 @@ int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			    struct perf_evsel *evsel,
 			    struct annotation_options *options);
-int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel);
+int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel,
+				struct annotation_options *opts);
 
 bool ui__has_annotation(void);
 
@@ -373,4 +397,6 @@ static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 
 void annotation_config__init(void);
 
+int annotate_parse_percent_type(const struct option *opt, const char *_str,
+				int unset);
 #endif	/* __PERF_ANNOTATE_H */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index d056447520a2..db1511359c5e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -56,6 +56,7 @@
 #include "intel-pt.h"
 #include "intel-bts.h"
 #include "arm-spe.h"
+#include "s390-cpumsf.h"
 
 #include "sane_ctype.h"
 #include "symbol/kallsyms.h"
@@ -202,6 +203,9 @@ static int auxtrace_queues__grow(struct auxtrace_queues *queues,
 	for (i = 0; i < queues->nr_queues; i++) {
 		list_splice_tail(&queues->queue_array[i].head,
 				 &queue_array[i].head);
+		queue_array[i].tid = queues->queue_array[i].tid;
+		queue_array[i].cpu = queues->queue_array[i].cpu;
+		queue_array[i].set = queues->queue_array[i].set;
 		queue_array[i].priv = queues->queue_array[i].priv;
 	}
 
@@ -920,6 +924,8 @@ int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 		return arm_spe_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_CS_ETM:
 		return cs_etm__process_auxtrace_info(event, session);
+	case PERF_AUXTRACE_S390_CPUMSF:
+		return s390_cpumsf_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e731f55da072..71fc3bd74299 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -44,6 +44,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_INTEL_BTS,
 	PERF_AUXTRACE_CS_ETM,
 	PERF_AUXTRACE_ARM_SPE,
+	PERF_AUXTRACE_S390_CPUMSF,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 3d02ae38ec56..47aac41349a2 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1529,13 +1529,13 @@ int bpf__apply_obj_config(void)
 	bpf_object__for_each_safe(obj, objtmp)	\
 		bpf_map__for_each(pos, obj)
 
-#define bpf__for_each_stdout_map(pos, obj, objtmp)	\
+#define bpf__for_each_map_named(pos, obj, objtmp, name)	\
 	bpf__for_each_map(pos, obj, objtmp) 		\
 		if (bpf_map__name(pos) && 		\
-			(strcmp("__bpf_stdout__", 	\
+			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
-int bpf__setup_stdout(struct perf_evlist *evlist)
+struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
 	struct bpf_object *obj, *tmp;
@@ -1544,11 +1544,11 @@ int bpf__setup_stdout(struct perf_evlist *evlist)
 	int err;
 	bool need_init = false;
 
-	bpf__for_each_stdout_map(map, obj, tmp) {
+	bpf__for_each_map_named(map, obj, tmp, name) {
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
-			return -BPF_LOADER_ERRNO__INTERNAL;
+			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
 
 		/*
 		 * No need to check map type: type should have been
@@ -1561,49 +1561,61 @@ int bpf__setup_stdout(struct perf_evlist *evlist)
 	}
 
 	if (!need_init)
-		return 0;
+		return NULL;
 
 	if (!tmpl_priv) {
-		err = parse_events(evlist, "bpf-output/no-inherit=1,name=__bpf_stdout__/",
-				   NULL);
+		char *event_definition = NULL;
+
+		if (asprintf(&event_definition, "bpf-output/no-inherit=1,name=%s/", name) < 0)
+			return ERR_PTR(-ENOMEM);
+
+		err = parse_events(evlist, event_definition, NULL);
+		free(event_definition);
+
 		if (err) {
-			pr_debug("ERROR: failed to create bpf-output event\n");
-			return -err;
+			pr_debug("ERROR: failed to create the \"%s\" bpf-output event\n", name);
+			return ERR_PTR(-err);
 		}
 
 		evsel = perf_evlist__last(evlist);
 	}
 
-	bpf__for_each_stdout_map(map, obj, tmp) {
+	bpf__for_each_map_named(map, obj, tmp, name) {
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
-			return -BPF_LOADER_ERRNO__INTERNAL;
+			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
 		if (priv)
 			continue;
 
 		if (tmpl_priv) {
 			priv = bpf_map_priv__clone(tmpl_priv);
 			if (!priv)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 
 			err = bpf_map__set_priv(map, priv, bpf_map_priv__clear);
 			if (err) {
 				bpf_map_priv__clear(map, priv);
-				return err;
+				return ERR_PTR(err);
 			}
 		} else if (evsel) {
 			struct bpf_map_op *op;
 
 			op = bpf_map__add_newop(map, NULL);
 			if (IS_ERR(op))
-				return PTR_ERR(op);
+				return ERR_PTR(PTR_ERR(op));
 			op->op_type = BPF_MAP_OP_SET_EVSEL;
 			op->v.evsel = evsel;
 		}
 	}
 
-	return 0;
+	return evsel;
+}
+
+int bpf__setup_stdout(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
+	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
 }
 
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
@@ -1780,8 +1792,8 @@ int bpf__strerror_apply_obj_config(int err, char *buf, size_t size)
 	return 0;
 }
 
-int bpf__strerror_setup_stdout(struct perf_evlist *evlist __maybe_unused,
-			       int err, char *buf, size_t size)
+int bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
+				     int err, char *buf, size_t size)
 {
 	bpf__strerror_head(err, buf, size);
 	bpf__strerror_end(buf, size);
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 5d3aefd6fae7..62d245a90e1d 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -43,6 +43,7 @@ enum bpf_loader_errno {
 	__BPF_LOADER_ERRNO__END,
 };
 
+struct perf_evsel;
 struct bpf_object;
 struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
@@ -82,9 +83,8 @@ int bpf__apply_obj_config(void);
 int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
 int bpf__setup_stdout(struct perf_evlist *evlist);
-int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err,
-			       char *buf, size_t size);
-
+struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
+int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
 
@@ -138,6 +138,12 @@ bpf__setup_stdout(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
+static inline struct perf_evsel *
+bpf__setup_output_event(struct perf_evlist *evlist __maybe_unused, const char *name __maybe_unused)
+{
+	return NULL;
+}
+
 static inline int
 __bpf_strerror(char *buf, size_t size)
 {
@@ -193,11 +199,16 @@ bpf__strerror_apply_obj_config(int err __maybe_unused,
 }
 
 static inline int
-bpf__strerror_setup_stdout(struct perf_evlist *evlist __maybe_unused,
-			   int err __maybe_unused, char *buf,
-			   size_t size)
+bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
+				 int err __maybe_unused, char *buf, size_t size)
 {
 	return __bpf_strerror(buf, size);
 }
+
 #endif
+
+static inline int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err, char *buf, size_t size)
+{
+	return bpf__strerror_setup_output_event(evlist, err, buf, size);
+}
 #endif
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index ecca688a25fb..892e92e7e7fc 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -4,10 +4,12 @@
 
 #ifdef HAVE_ZLIB_SUPPORT
 int gzip_decompress_to_file(const char *input, int output_fd);
+bool gzip_is_compressed(const char *input);
 #endif
 
 #ifdef HAVE_LZMA_SUPPORT
 int lzma_decompress_to_file(const char *input, int output_fd);
+bool lzma_is_compressed(const char *input);
 #endif
 
 #endif /* PERF_COMPRESS_H */
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 5744c12641a5..abd38abf1d91 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -310,8 +310,8 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 	if (flags & FIELD_IS_DYNAMIC) {
 		unsigned long long tmp_val;
 
-		tmp_val = pevent_read_number(fmtf->event->pevent,
-				data + offset, len);
+		tmp_val = tep_read_number(fmtf->event->pevent,
+					  data + offset, len);
 		offset = tmp_val;
 		len = offset >> 16;
 		offset &= 0xffff;
@@ -353,7 +353,7 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 		else {
 			unsigned long long value_int;
 
-			value_int = pevent_read_number(
+			value_int = tep_read_number(
 					fmtf->event->pevent,
 					data + offset + i * len, len);
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 51cf82cf1882..bbed90e5d9bb 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -189,28 +189,34 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	return ret;
 }
 
+enum {
+	COMP_ID__NONE = 0,
+};
+
 static const struct {
 	const char *fmt;
 	int (*decompress)(const char *input, int output);
+	bool (*is_compressed)(const char *input);
 } compressions[] = {
+	[COMP_ID__NONE] = { .fmt = NULL, },
 #ifdef HAVE_ZLIB_SUPPORT
-	{ "gz", gzip_decompress_to_file },
+	{ "gz", gzip_decompress_to_file, gzip_is_compressed },
 #endif
 #ifdef HAVE_LZMA_SUPPORT
-	{ "xz", lzma_decompress_to_file },
+	{ "xz", lzma_decompress_to_file, lzma_is_compressed },
 #endif
-	{ NULL, NULL },
+	{ NULL, NULL, NULL },
 };
 
-bool is_supported_compression(const char *ext)
+static int is_supported_compression(const char *ext)
 {
 	unsigned i;
 
-	for (i = 0; compressions[i].fmt; i++) {
+	for (i = 1; compressions[i].fmt; i++) {
 		if (!strcmp(ext, compressions[i].fmt))
-			return true;
+			return i;
 	}
-	return false;
+	return COMP_ID__NONE;
 }
 
 bool is_kernel_module(const char *pathname, int cpumode)
@@ -239,80 +245,73 @@ bool is_kernel_module(const char *pathname, int cpumode)
 	return m.kmod;
 }
 
-bool decompress_to_file(const char *ext, const char *filename, int output_fd)
-{
-	unsigned i;
-
-	for (i = 0; compressions[i].fmt; i++) {
-		if (!strcmp(ext, compressions[i].fmt))
-			return !compressions[i].decompress(filename,
-							   output_fd);
-	}
-	return false;
-}
-
 bool dso__needs_decompress(struct dso *dso)
 {
 	return dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
 		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 }
 
-static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
+static int decompress_kmodule(struct dso *dso, const char *name,
+			      char *pathname, size_t len)
 {
+	char tmpbuf[] = KMOD_DECOMP_NAME;
 	int fd = -1;
-	struct kmod_path m;
 
 	if (!dso__needs_decompress(dso))
 		return -1;
 
-	if (kmod_path__parse_ext(&m, dso->long_name))
+	if (dso->comp == COMP_ID__NONE)
 		return -1;
 
-	if (!m.comp)
-		goto out;
+	/*
+	 * We have proper compression id for DSO and yet the file
+	 * behind the 'name' can still be plain uncompressed object.
+	 *
+	 * The reason is behind the logic we open the DSO object files,
+	 * when we try all possible 'debug' objects until we find the
+	 * data. So even if the DSO is represented by 'krava.xz' module,
+	 * we can end up here opening ~/.debug/....23432432/debug' file
+	 * which is not compressed.
+	 *
+	 * To keep this transparent, we detect this and return the file
+	 * descriptor to the uncompressed file.
+	 */
+	if (!compressions[dso->comp].is_compressed(name))
+		return open(name, O_RDONLY);
 
 	fd = mkstemp(tmpbuf);
 	if (fd < 0) {
 		dso->load_errno = errno;
-		goto out;
+		return -1;
 	}
 
-	if (!decompress_to_file(m.ext, name, fd)) {
+	if (compressions[dso->comp].decompress(name, fd)) {
 		dso->load_errno = DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE;
 		close(fd);
 		fd = -1;
 	}
 
-out:
-	free(m.ext);
+	if (!pathname || (fd < 0))
+		unlink(tmpbuf);
+
+	if (pathname && (fd >= 0))
+		strncpy(pathname, tmpbuf, len);
+
 	return fd;
 }
 
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name)
 {
-	char tmpbuf[] = KMOD_DECOMP_NAME;
-	int fd;
-
-	fd = decompress_kmodule(dso, name, tmpbuf);
-	unlink(tmpbuf);
-	return fd;
+	return decompress_kmodule(dso, name, NULL, 0);
 }
 
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 				 char *pathname, size_t len)
 {
-	char tmpbuf[] = KMOD_DECOMP_NAME;
-	int fd;
+	int fd = decompress_kmodule(dso, name, pathname, len);
 
-	fd = decompress_kmodule(dso, name, tmpbuf);
-	if (fd < 0) {
-		unlink(tmpbuf);
-		return -1;
-	}
-
-	strncpy(pathname, tmpbuf, len);
 	close(fd);
-	return 0;
+	return fd >= 0 ? 0 : -1;
 }
 
 /*
@@ -332,7 +331,7 @@ int dso__decompress_kmodule_path(struct dso *dso, const char *name,
  * Returns 0 if there's no strdup error, -ENOMEM otherwise.
  */
 int __kmod_path__parse(struct kmod_path *m, const char *path,
-		       bool alloc_name, bool alloc_ext)
+		       bool alloc_name)
 {
 	const char *name = strrchr(path, '/');
 	const char *ext  = strrchr(path, '.');
@@ -372,10 +371,9 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 		return 0;
 	}
 
-	if (is_supported_compression(ext + 1)) {
-		m->comp = true;
+	m->comp = is_supported_compression(ext + 1);
+	if (m->comp > COMP_ID__NONE)
 		ext -= 3;
-	}
 
 	/* Check .ko extension only if there's enough name left. */
 	if (ext > name)
@@ -393,14 +391,6 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 		strxfrchar(m->name, '-', '_');
 	}
 
-	if (alloc_ext && m->comp) {
-		m->ext = strdup(ext + 4);
-		if (!m->ext) {
-			free((void *) m->name);
-			return -ENOMEM;
-		}
-	}
-
 	return 0;
 }
 
@@ -413,8 +403,10 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 		dso->symtab_type = DSO_BINARY_TYPE__GUEST_KMODULE;
 
 	/* _KMODULE_COMP should be next to _KMODULE */
-	if (m->kmod && m->comp)
+	if (m->kmod && m->comp) {
 		dso->symtab_type++;
+		dso->comp = m->comp;
+	}
 
 	dso__set_short_name(dso, strdup(m->name), true);
 }
@@ -468,6 +460,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	int fd = -EINVAL;
 	char *root_dir = (char *)"";
 	char *name = malloc(PATH_MAX);
+	bool decomp = false;
 
 	if (!name)
 		return -ENOMEM;
@@ -491,12 +484,13 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 			goto out;
 		}
 
+		decomp = true;
 		strcpy(name, newpath);
 	}
 
 	fd = do_open(name);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(name);
 
 out:
@@ -1218,6 +1212,7 @@ struct dso *dso__new(const char *name)
 		dso->a2l_fails = 1;
 		dso->kernel = DSO_TYPE_USER;
 		dso->needs_swap = DSO_SWAP__UNSET;
+		dso->comp = COMP_ID__NONE;
 		RB_CLEAR_NODE(&dso->rb_node);
 		dso->root = NULL;
 		INIT_LIST_HEAD(&dso->node);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ef69de2e69ea..c5380500bed4 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -175,6 +175,7 @@ struct dso {
 	u16		 short_name_len;
 	void		*dwfl;			/* DWARF debug info */
 	struct auxtrace_cache *auxtrace_cache;
+	int		 comp;
 
 	/* dso data file */
 	struct {
@@ -250,9 +251,7 @@ int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
 char dso__symtab_origin(const struct dso *dso);
 int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type type,
 				   char *root_dir, char *filename, size_t size);
-bool is_supported_compression(const char *ext);
 bool is_kernel_module(const char *pathname, int cpumode);
-bool decompress_to_file(const char *ext, const char *filename, int output_fd);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
@@ -263,17 +262,15 @@ int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 
 struct kmod_path {
 	char *name;
-	char *ext;
-	bool  comp;
+	int   comp;
 	bool  kmod;
 };
 
 int __kmod_path__parse(struct kmod_path *m, const char *path,
-		     bool alloc_name, bool alloc_ext);
+		     bool alloc_name);
 
-#define kmod_path__parse(__m, __p)      __kmod_path__parse(__m, __p, false, false)
-#define kmod_path__parse_name(__m, __p) __kmod_path__parse(__m, __p, true , false)
-#define kmod_path__parse_ext(__m, __p)  __kmod_path__parse(__m, __p, false, true)
+#define kmod_path__parse(__m, __p)      __kmod_path__parse(__m, __p, false)
+#define kmod_path__parse_name(__m, __p) __kmod_path__parse(__m, __p, true)
 
 void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 			  struct machine *machine);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0c8ecf0c78a4..0cd42150f712 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -541,10 +541,17 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 						      tgid, process, machine) < 0)
 			return -1;
 
+		/*
+		 * send mmap only for thread group leader
+		 * see thread__init_map_groups
+		 */
+		if (pid == tgid &&
+		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
+						       process, machine, mmap_data,
+						       proc_map_timeout))
+			return -1;
 
-		return perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
-							  process, machine, mmap_data,
-							  proc_map_timeout);
+		return 0;
 	}
 
 	if (machine__is_default_guest(machine))
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e7a4b31a84fb..be440df29615 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -803,7 +803,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(&maps[idx], mp, *output)  < 0)
+			if (perf_mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ddf84b941abf..c980bbff6353 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2683,7 +2683,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 
 struct format_field *perf_evsel__field(struct perf_evsel *evsel, const char *name)
 {
-	return pevent_find_field(evsel->tp_format, name);
+	return tep_find_field(evsel->tp_format, name);
 }
 
 void *perf_evsel__rawptr(struct perf_evsel *evsel, struct perf_sample *sample,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 973c03167947..163c960614d3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -452,11 +452,18 @@ static inline int perf_evsel__group_idx(struct perf_evsel *evsel)
 	return evsel->idx - evsel->leader->idx;
 }
 
+/* Iterates group WITHOUT the leader. */
 #define for_each_group_member(_evsel, _leader) 					\
 for ((_evsel) = list_entry((_leader)->node.next, struct perf_evsel, node); 	\
      (_evsel) && (_evsel)->leader == (_leader);					\
      (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
 
+/* Iterates group WITH the leader. */
+#define for_each_group_evsel(_evsel, _leader) 					\
+for ((_evsel) = _leader; 							\
+     (_evsel) && (_evsel)->leader == (_leader);					\
+     (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
+
 static inline bool perf_evsel__has_branch_callstack(const struct perf_evsel *evsel)
 {
 	return evsel->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 5af58aac91ad..3cadc252dd89 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -279,8 +279,6 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (!set)
 		return -ENOMEM;
 
-	bitmap_zero(set, size);
-
 	p = (u64 *) set;
 
 	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
@@ -1285,7 +1283,6 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 		return -ENOMEM;
 	}
 
-	bitmap_zero(n->set, size);
 	n->node = idx;
 	n->size = size;
 
@@ -3207,7 +3204,7 @@ static int read_attr(int fd, struct perf_header *ph,
 }
 
 static int perf_evsel__prepare_tracepoint_event(struct perf_evsel *evsel,
-						struct pevent *pevent)
+						struct tep_handle *pevent)
 {
 	struct event_format *event;
 	char bf[128];
@@ -3221,7 +3218,7 @@ static int perf_evsel__prepare_tracepoint_event(struct perf_evsel *evsel,
 		return -1;
 	}
 
-	event = pevent_find_event(pevent, evsel->attr.config);
+	event = tep_find_event(pevent, evsel->attr.config);
 	if (event == NULL) {
 		pr_debug("cannot find event format for %d\n", (int)evsel->attr.config);
 		return -1;
@@ -3239,7 +3236,7 @@ static int perf_evsel__prepare_tracepoint_event(struct perf_evsel *evsel,
 }
 
 static int perf_evlist__prepare_tracepoint_events(struct perf_evlist *evlist,
-						  struct pevent *pevent)
+						  struct tep_handle *pevent)
 {
 	struct perf_evsel *pos;
 
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 5e94857dfca2..19262f98cd4e 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -22,12 +22,14 @@
 		"$CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
-		"-c \"$CLANG_SOURCE\" -target bpf -O2 -o -"
+		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
 
 struct llvm_param llvm_param = {
 	.clang_path = "clang",
+	.llc_path = "llc",
 	.clang_bpf_cmd_template = CLANG_BPF_CMD_DEFAULT_TEMPLATE,
 	.clang_opt = NULL,
+	.opts = NULL,
 	.kbuild_dir = NULL,
 	.kbuild_opts = NULL,
 	.user_set_param = false,
@@ -51,6 +53,8 @@ int perf_llvm_config(const char *var, const char *value)
 		llvm_param.kbuild_opts = strdup(value);
 	else if (!strcmp(var, "dump-obj"))
 		llvm_param.dump_obj = !!perf_config_bool(var, value);
+	else if (!strcmp(var, "opts"))
+		llvm_param.opts = strdup(value);
 	else {
 		pr_debug("Invalid LLVM config option: %s\n", value);
 		return -1;
@@ -430,11 +434,13 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	unsigned int kernel_version;
 	char linux_version_code_str[64];
 	const char *clang_opt = llvm_param.clang_opt;
-	char clang_path[PATH_MAX], abspath[PATH_MAX], nr_cpus_avail_str[64];
+	char clang_path[PATH_MAX], llc_path[PATH_MAX], abspath[PATH_MAX], nr_cpus_avail_str[64];
 	char serr[STRERR_BUFSIZE];
 	char *kbuild_dir = NULL, *kbuild_include_opts = NULL,
 	     *perf_bpf_include_opts = NULL;
 	const char *template = llvm_param.clang_bpf_cmd_template;
+	char *pipe_template = NULL;
+	const char *opts = llvm_param.opts;
 	char *command_echo = NULL, *command_out;
 	char *perf_include_dir = system_path(PERF_INCLUDE_DIR);
 
@@ -484,6 +490,26 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	force_set_env("PERF_BPF_INC_OPTIONS", perf_bpf_include_opts);
 	force_set_env("WORKING_DIR", kbuild_dir ? : ".");
 
+	if (opts) {
+		err = search_program(llvm_param.llc_path, "llc", llc_path);
+		if (err) {
+			pr_err("ERROR:\tunable to find llc.\n"
+			       "Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
+			       "     \tand 'llc-path' option in [llvm] section of ~/.perfconfig.\n");
+			version_notice();
+			goto errout;
+		}
+
+		if (asprintf(&pipe_template, "%s -emit-llvm | %s -march=bpf %s -filetype=obj -o -",
+			      template, llc_path, opts) < 0) {
+			pr_err("ERROR:\tnot enough memory to setup command line\n");
+			goto errout;
+		}
+
+		template = pipe_template;
+
+	}
+
 	/*
 	 * Since we may reset clang's working dir, path of source file
 	 * should be transferred into absolute path, except we want
@@ -535,6 +561,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	free(obj_buf);
 	free(perf_bpf_include_opts);
 	free(perf_include_dir);
+	free(pipe_template);
 	if (p_obj_buf)
 		*p_obj_buf = NULL;
 	if (p_obj_buf_sz)
diff --git a/tools/perf/util/llvm-utils.h b/tools/perf/util/llvm-utils.h
index d3ad8deb5db4..bf3f3f4c4fe2 100644
--- a/tools/perf/util/llvm-utils.h
+++ b/tools/perf/util/llvm-utils.h
@@ -11,6 +11,8 @@
 struct llvm_param {
 	/* Path of clang executable */
 	const char *clang_path;
+	/* Path of llc executable */
+	const char *llc_path;
 	/*
 	 * Template of clang bpf compiling. 5 env variables
 	 * can be used:
@@ -23,6 +25,13 @@ struct llvm_param {
 	const char *clang_bpf_cmd_template;
 	/* Will be filled in $CLANG_OPTIONS */
 	const char *clang_opt;
+	/*
+	 * If present it'll add -emit-llvm to $CLANG_OPTIONS to pipe
+	 * the clang output to llc, useful for new llvm options not
+	 * yet selectable via 'clang -mllvm option', such as -mattr=dwarfris
+	 * in clang 6.0/llvm 7
+	 */
+	const char *opts;
 	/* Where to find kbuild system */
 	const char *kbuild_dir;
 	/*
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 07498eaddc08..b1dd29a9d915 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -3,9 +3,13 @@
 #include <lzma.h>
 #include <stdio.h>
 #include <linux/compiler.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include "compress.h"
 #include "util.h"
 #include "debug.h"
+#include <unistd.h>
 
 #define BUFSIZE 8192
 
@@ -99,3 +103,19 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 	fclose(infile);
 	return err;
 }
+
+bool lzma_is_compressed(const char *input)
+{
+	int fd = open(input, O_RDONLY);
+	const uint8_t magic[6] = { 0xFD, '7', 'z', 'X', 'Z', 0x00 };
+	char buf[6] = { 0 };
+	ssize_t rc;
+
+	if (fd < 0)
+		return -1;
+
+	rc = read(fd, buf, sizeof(buf));
+	close(fd);
+	return rc == sizeof(buf) ?
+	       memcmp(buf, magic, sizeof(buf)) == 0 : false;
+}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b300a3973448..c4acd2001db0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1212,8 +1212,10 @@ static int map_groups__set_module_path(struct map_groups *mg, const char *path,
 	 * Full name could reveal us kmod compression, so
 	 * we need to update the symtab_type if needed.
 	 */
-	if (m->comp && is_kmod_dso(map->dso))
+	if (m->comp && is_kmod_dso(map->dso)) {
 		map->dso->symtab_type++;
+		map->dso->comp = m->comp;
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 1de7660d93e9..d856b85862e2 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -265,7 +265,7 @@ pid_t machine__get_current_tid(struct machine *machine, int cpu);
 int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid);
 /*
- * For use with libtraceevent's pevent_set_function_resolver()
+ * For use with libtraceevent's tep_set_function_resolver()
  */
 char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, char **modp);
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 89ac5b5dc218..36d0763311ef 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -381,20 +381,6 @@ struct map *map__clone(struct map *from)
 	return map;
 }
 
-int map__overlap(struct map *l, struct map *r)
-{
-	if (l->start > r->start) {
-		struct map *t = l;
-		l = r;
-		r = t;
-	}
-
-	if (l->end > r->start)
-		return 1;
-
-	return 0;
-}
-
 size_t map__fprintf(struct map *map, FILE *fp)
 {
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
@@ -675,20 +661,42 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 {
 	struct rb_root *root;
-	struct rb_node *next;
+	struct rb_node *next, *first;
 	int err = 0;
 
 	down_write(&maps->lock);
 
 	root = &maps->entries;
-	next = rb_first(root);
 
+	/*
+	 * Find first map where end > map->start.
+	 * Same as find_vma() in kernel.
+	 */
+	next = root->rb_node;
+	first = NULL;
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node);
+
+		if (pos->end > map->start) {
+			first = next;
+			if (pos->start <= map->start)
+				break;
+			next = next->rb_left;
+		} else
+			next = next->rb_right;
+	}
+
+	next = first;
 	while (next) {
 		struct map *pos = rb_entry(next, struct map, rb_node);
 		next = rb_next(&pos->rb_node);
 
-		if (!map__overlap(pos, map))
-			continue;
+		/*
+		 * Stop if current map starts after map->end.
+		 * Maps are ordered by start: next will not overlap for sure.
+		 */
+		if (pos->start >= map->end)
+			break;
 
 		if (verbose >= 2) {
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 4cb90f242bed..e0f327b51e66 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -166,7 +166,6 @@ static inline void __map__zput(struct map **map)
 
 #define map__zput(map) __map__zput(&map)
 
-int map__overlap(struct map *l, struct map *r);
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
 char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index fc832676a798..215f69f41672 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -164,7 +164,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
+int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
@@ -191,6 +191,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 		return -1;
 	}
 	map->fd = fd;
+	map->cpu = cpu;
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d82294db1295..05a6d47c7956 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -18,6 +18,7 @@ struct perf_mmap {
 	void		 *base;
 	int		 mask;
 	int		 fd;
+	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
 	u64		 start;
@@ -60,7 +61,7 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd);
+int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct perf_mmap *map);
 
 void perf_mmap__get(struct perf_mmap *map);
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 5be021701f34..cf8bd123cf73 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -139,6 +139,9 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 
+	if (nsi == NULL)
+		return NULL;
+
 	nnsi = calloc(1, sizeof(*nnsi));
 	if (nnsi != NULL) {
 		nnsi->pid = nsi->pid;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 15eec49e71a1..f8cd3e7c9186 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1991,8 +1991,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	int nr_addr_filters = 0;
 	struct perf_pmu *pmu = NULL;
 
-	if (evsel == NULL)
-		goto err;
+	if (evsel == NULL) {
+		fprintf(stderr,
+			"--filter option should follow a -e tracepoint or HW tracer option\n");
+		return -1;
+	}
 
 	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
 		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
@@ -2014,8 +2017,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
 
-	if (!nr_addr_filters)
-		goto err;
+	if (!nr_addr_filters) {
+		fprintf(stderr,
+			"This CPU does not support address filtering\n");
+		return -1;
+	}
 
 	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
@@ -2024,12 +2030,6 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	}
 
 	return 0;
-
-err:
-	fprintf(stderr,
-		"--filter option should follow a -e tracepoint or HW tracer option\n");
-
-	return -1;
 }
 
 int parse_filter(const struct option *opt, const char *str,
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 863b61478edd..ce501ba14b08 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -11,6 +11,7 @@
 #include "cpumap.h"
 #include "print_binary.h"
 #include "thread_map.h"
+#include "mmap.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
@@ -341,7 +342,7 @@ static bool is_tracepoint(struct pyrf_event *pevent)
 static PyObject*
 tracepoint_field(struct pyrf_event *pe, struct format_field *field)
 {
-	struct pevent *pevent = field->event->pevent;
+	struct tep_handle *pevent = field->event->pevent;
 	void *data = pe->sample.raw_data;
 	PyObject *ret = NULL;
 	unsigned long long val;
@@ -351,7 +352,7 @@ tracepoint_field(struct pyrf_event *pe, struct format_field *field)
 		offset = field->offset;
 		len    = field->size;
 		if (field->flags & FIELD_IS_DYNAMIC) {
-			val     = pevent_read_number(pevent, data + offset, len);
+			val     = tep_read_number(pevent, data + offset, len);
 			offset  = val;
 			len     = offset >> 16;
 			offset &= 0xffff;
@@ -364,8 +365,8 @@ tracepoint_field(struct pyrf_event *pe, struct format_field *field)
 			field->flags &= ~FIELD_IS_STRING;
 		}
 	} else {
-		val = pevent_read_number(pevent, data + field->offset,
-					 field->size);
+		val = tep_read_number(pevent, data + field->offset,
+				      field->size);
 		if (field->flags & FIELD_IS_POINTER)
 			ret = PyLong_FromUnsignedLong((unsigned long) val);
 		else if (field->flags & FIELD_IS_SIGNED)
@@ -394,7 +395,7 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 		evsel->tp_format = tp_format;
 	}
 
-	field = pevent_find_any_field(evsel->tp_format, str);
+	field = tep_find_any_field(evsel->tp_format, str);
 	if (!field)
 		return NULL;
 
@@ -976,6 +977,20 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	return Py_BuildValue("i", evlist->nr_entries);
 }
 
+static struct perf_mmap *get_md(struct perf_evlist *evlist, int cpu)
+{
+	int i;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *md = &evlist->mmap[i];
+
+		if (md->cpu == cpu)
+			return md;
+	}
+
+	return NULL;
+}
+
 static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 					  PyObject *args, PyObject *kwargs)
 {
@@ -990,7 +1005,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 					 &cpu, &sample_id_all))
 		return NULL;
 
-	md = &evlist->mmap[cpu];
+	md = get_md(evlist, cpu);
+	if (!md)
+		return NULL;
+
 	if (perf_mmap__read_init(md) < 0)
 		goto end;
 
diff --git a/tools/perf/util/s390-cpumsf-kernel.h b/tools/perf/util/s390-cpumsf-kernel.h
new file mode 100644
index 000000000000..de8c7ad0eca8
--- /dev/null
+++ b/tools/perf/util/s390-cpumsf-kernel.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Auxtrace support for s390 CPU measurement sampling facility
+ *
+ *  Copyright IBM Corp. 2018
+ *  Author(s): Hendrik Brueckner <brueckner@linux.ibm.com>
+ *	       Thomas Richter <tmricht@linux.ibm.com>
+ */
+#ifndef S390_CPUMSF_KERNEL_H
+#define S390_CPUMSF_KERNEL_H
+
+#define	S390_CPUMSF_PAGESZ	4096	/* Size of sample block units */
+#define	S390_CPUMSF_DIAG_DEF_FIRST	0x8001	/* Diagnostic entry lowest id */
+
+struct hws_basic_entry {
+	unsigned int def:16;	    /* 0-15  Data Entry Format		 */
+	unsigned int R:4;	    /* 16-19 reserved			 */
+	unsigned int U:4;	    /* 20-23 Number of unique instruct.  */
+	unsigned int z:2;	    /* zeros				 */
+	unsigned int T:1;	    /* 26 PSW DAT mode			 */
+	unsigned int W:1;	    /* 27 PSW wait state		 */
+	unsigned int P:1;	    /* 28 PSW Problem state		 */
+	unsigned int AS:2;	    /* 29-30 PSW address-space control	 */
+	unsigned int I:1;	    /* 31 entry valid or invalid	 */
+	unsigned int CL:2;	    /* 32-33 Configuration Level	 */
+	unsigned int:14;
+	unsigned int prim_asn:16;   /* primary ASN			 */
+	unsigned long long ia;	    /* Instruction Address		 */
+	unsigned long long gpp;     /* Guest Program Parameter		 */
+	unsigned long long hpp;     /* Host Program Parameter		 */
+};
+
+struct hws_diag_entry {
+	unsigned int def:16;	    /* 0-15  Data Entry Format		 */
+	unsigned int R:15;	    /* 16-19 and 20-30 reserved		 */
+	unsigned int I:1;	    /* 31 entry valid or invalid	 */
+	u8	     data[];	    /* Machine-dependent sample data	 */
+};
+
+struct hws_combined_entry {
+	struct hws_basic_entry	basic;	/* Basic-sampling data entry */
+	struct hws_diag_entry	diag;	/* Diagnostic-sampling data entry */
+};
+
+struct hws_trailer_entry {
+	union {
+		struct {
+			unsigned int f:1;	/* 0 - Block Full Indicator   */
+			unsigned int a:1;	/* 1 - Alert request control  */
+			unsigned int t:1;	/* 2 - Timestamp format	      */
+			unsigned int:29;	/* 3 - 31: Reserved	      */
+			unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
+			unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
+		};
+		unsigned long long flags;	/* 0 - 64: All indicators     */
+	};
+	unsigned long long overflow;	 /* 64 - sample Overflow count	      */
+	unsigned char timestamp[16];	 /* 16 - 31 timestamp		      */
+	unsigned long long reserved1;	 /* 32 -Reserved		      */
+	unsigned long long reserved2;	 /*				      */
+	union {				 /* 48 - reserved for programming use */
+		struct {
+			unsigned long long clock_base:1; /* in progusage2 */
+			unsigned long long progusage1:63;
+			unsigned long long progusage2;
+		};
+		unsigned long long progusage[2];
+	};
+};
+
+#endif
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
new file mode 100644
index 000000000000..d2c78ffd9fee
--- /dev/null
+++ b/tools/perf/util/s390-cpumsf.c
@@ -0,0 +1,945 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2018
+ * Auxtrace support for s390 CPU-Measurement Sampling Facility
+ *
+ * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
+ *
+ * Auxiliary traces are collected during 'perf record' using rbd000 event.
+ * Several PERF_RECORD_XXX are generated during recording:
+ *
+ * PERF_RECORD_AUX:
+ *	Records that new data landed in the AUX buffer part.
+ * PERF_RECORD_AUXTRACE:
+ *	Defines auxtrace data. Followed by the actual data. The contents of
+ *	the auxtrace data is dependent on the event and the CPU.
+ *	This record is generated by perf record command. For details
+ *	see Documentation/perf.data-file-format.txt.
+ * PERF_RECORD_AUXTRACE_INFO:
+ *	Defines a table of contains for PERF_RECORD_AUXTRACE records. This
+ *	record is generated during 'perf record' command. Each record contains up
+ *	to 256 entries describing offset and size of the AUXTRACE data in the
+ *	perf.data file.
+ * PERF_RECORD_AUXTRACE_ERROR:
+ *	Indicates an error during AUXTRACE collection such as buffer overflow.
+ * PERF_RECORD_FINISHED_ROUND:
+ *	Perf events are not necessarily in time stamp order, as they can be
+ *	collected in parallel on different CPUs. If the events should be
+ *	processed in time order they need to be sorted first.
+ *	Perf report guarantees that there is no reordering over a
+ *	PERF_RECORD_FINISHED_ROUND boundary event. All perf records with a
+ *	time stamp lower than this record are processed (and displayed) before
+ *	the succeeding perf record are processed.
+ *
+ * These records are evaluated during perf report command.
+ *
+ * 1. PERF_RECORD_AUXTRACE_INFO is used to set up the infrastructure for
+ * auxiliary trace data processing. See s390_cpumsf_process_auxtrace_info()
+ * below.
+ * Auxiliary trace data is collected per CPU. To merge the data into the report
+ * an auxtrace_queue is created for each CPU. It is assumed that the auxtrace
+ * data is in ascending order.
+ *
+ * Each queue has a double linked list of auxtrace_buffers. This list contains
+ * the offset and size of a CPU's auxtrace data. During auxtrace processing
+ * the data portion is mmap()'ed.
+ *
+ * To sort the queues in chronological order, all queue access is controlled
+ * by the auxtrace_heap. This is basicly a stack, each stack element has two
+ * entries, the queue number and a time stamp. However the stack is sorted by
+ * the time stamps. The highest time stamp is at the bottom the lowest
+ * (nearest) time stamp is at the top. That sort order is maintained at all
+ * times!
+ *
+ * After the auxtrace infrastructure has been setup, the auxtrace queues are
+ * filled with data (offset/size pairs) and the auxtrace_heap is populated.
+ *
+ * 2. PERF_RECORD_XXX processing triggers access to the auxtrace_queues.
+ * Each record is handled by s390_cpumsf_process_event(). The time stamp of
+ * the perf record is compared with the time stamp located on the auxtrace_heap
+ * top element. If that time stamp is lower than the time stamp from the
+ * record sample, the auxtrace queues will be processed. As auxtrace queues
+ * control many auxtrace_buffers and each buffer can be quite large, the
+ * auxtrace buffer might be processed only partially. In this case the
+ * position in the auxtrace_buffer of that queue is remembered and the time
+ * stamp of the last processed entry of the auxtrace_buffer replaces the
+ * current auxtrace_heap top.
+ *
+ * 3. Auxtrace_queues might run of out data and are feeded by the
+ * PERF_RECORD_AUXTRACE handling, see s390_cpumsf_process_auxtrace_event().
+ *
+ * Event Generation
+ * Each sampling-data entry in the auxilary trace data generates a perf sample.
+ * This sample is filled
+ * with data from the auxtrace such as PID/TID, instruction address, CPU state,
+ * etc. This sample is processed with perf_session__deliver_synth_event() to
+ * be included into the GUI.
+ *
+ * 4. PERF_RECORD_FINISHED_ROUND event is used to process all the remaining
+ * auxiliary traces entries until the time stamp of this record is reached
+ * auxtrace_heap top. This is triggered by ordered_event->deliver().
+ *
+ *
+ * Perf event processing.
+ * Event processing of PERF_RECORD_XXX entries relies on time stamp entries.
+ * This is the function call sequence:
+ *
+ * __cmd_report()
+ * |
+ * perf_session__process_events()
+ * |
+ * __perf_session__process_events()
+ * |
+ * perf_session__process_event()
+ * |  This functions splits the PERF_RECORD_XXX records.
+ * |  - Those generated by perf record command (type number equal or higher
+ * |    than PERF_RECORD_USER_TYPE_START) are handled by
+ * |    perf_session__process_user_event(see below)
+ * |  - Those generated by the kernel are handled by
+ * |    perf_evlist__parse_sample_timestamp()
+ * |
+ * perf_evlist__parse_sample_timestamp()
+ * |  Extract time stamp from sample data.
+ * |
+ * perf_session__queue_event()
+ * |  If timestamp is positive the sample is entered into an ordered_event
+ * |  list, sort order is the timestamp. The event processing is deferred until
+ * |  later (see perf_session__process_user_event()).
+ * |  Other timestamps (0 or -1) are handled immediately by
+ * |  perf_session__deliver_event(). These are events generated at start up
+ * |  of command perf record. They create PERF_RECORD_COMM and PERF_RECORD_MMAP*
+ * |  records. They are needed to create a list of running processes and its
+ * |  memory mappings and layout. They are needed at the beginning to enable
+ * |  command perf report to create process trees and memory mappings.
+ * |
+ * perf_session__deliver_event()
+ * |  Delivers a PERF_RECORD_XXX entry for handling.
+ * |
+ * auxtrace__process_event()
+ * |  The timestamp of the PERF_RECORD_XXX entry is taken to correlate with
+ * |  time stamps from the auxiliary trace buffers. This enables
+ * |  synchronization between auxiliary trace data and the events on the
+ * |  perf.data file.
+ * |
+ * machine__deliver_event()
+ * |  Handles the PERF_RECORD_XXX event. This depends on the record type.
+ *    It might update the process tree, update a process memory map or enter
+ *    a sample with IP and call back chain data into GUI data pool.
+ *
+ *
+ * Deferred processing determined by perf_session__process_user_event() is
+ * finally processed when a PERF_RECORD_FINISHED_ROUND is encountered. These
+ * are generated during command perf record.
+ * The timestamp of PERF_RECORD_FINISHED_ROUND event is taken to process all
+ * PERF_RECORD_XXX entries stored in the ordered_event list. This list was
+ * built up while reading the perf.data file.
+ * Each event is now processed by calling perf_session__deliver_event().
+ * This enables time synchronization between the data in the perf.data file and
+ * the data in the auxiliary trace buffers.
+ */
+
+#include <endian.h>
+#include <errno.h>
+#include <byteswap.h>
+#include <inttypes.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+
+#include "cpumap.h"
+#include "color.h"
+#include "evsel.h"
+#include "evlist.h"
+#include "machine.h"
+#include "session.h"
+#include "util.h"
+#include "thread.h"
+#include "debug.h"
+#include "auxtrace.h"
+#include "s390-cpumsf.h"
+#include "s390-cpumsf-kernel.h"
+
+struct s390_cpumsf {
+	struct auxtrace		auxtrace;
+	struct auxtrace_queues	queues;
+	struct auxtrace_heap	heap;
+	struct perf_session	*session;
+	struct machine		*machine;
+	u32			auxtrace_type;
+	u32			pmu_type;
+	u16			machine_type;
+	bool			data_queued;
+};
+
+struct s390_cpumsf_queue {
+	struct s390_cpumsf	*sf;
+	unsigned int		queue_nr;
+	struct auxtrace_buffer	*buffer;
+	int			cpu;
+};
+
+/* Display s390 CPU measurement facility basic-sampling data entry */
+static bool s390_cpumsf_basic_show(const char *color, size_t pos,
+				   struct hws_basic_entry *basic)
+{
+	if (basic->def != 1) {
+		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
+		return false;
+	}
+	color_fprintf(stdout, color, "    [%#08zx] Basic   Def:%04x Inst:%#04x"
+		      " %c%c%c%c AS:%d ASN:%#04x IA:%#018llx\n"
+		      "\t\tCL:%d HPP:%#018llx GPP:%#018llx\n",
+		      pos, basic->def, basic->U,
+		      basic->T ? 'T' : ' ',
+		      basic->W ? 'W' : ' ',
+		      basic->P ? 'P' : ' ',
+		      basic->I ? 'I' : ' ',
+		      basic->AS, basic->prim_asn, basic->ia, basic->CL,
+		      basic->hpp, basic->gpp);
+	return true;
+}
+
+/* Display s390 CPU measurement facility diagnostic-sampling data entry */
+static bool s390_cpumsf_diag_show(const char *color, size_t pos,
+				  struct hws_diag_entry *diag)
+{
+	if (diag->def < S390_CPUMSF_DIAG_DEF_FIRST) {
+		pr_err("Invalid AUX trace diagnostic entry [%#08zx]\n", pos);
+		return false;
+	}
+	color_fprintf(stdout, color, "    [%#08zx] Diag    Def:%04x %c\n",
+		      pos, diag->def, diag->I ? 'I' : ' ');
+	return true;
+}
+
+/* Return TOD timestamp contained in an trailer entry */
+static unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
+{
+	/* te->t set: TOD in STCKE format, bytes 8-15
+	 * to->t not set: TOD in STCK format, bytes 0-7
+	 */
+	unsigned long long ts;
+
+	memcpy(&ts, &te->timestamp[te->t], sizeof(ts));
+	return ts;
+}
+
+/* Display s390 CPU measurement facility trailer entry */
+static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
+				     struct hws_trailer_entry *te)
+{
+	if (te->bsdes != sizeof(struct hws_basic_entry)) {
+		pr_err("Invalid AUX trace trailer entry [%#08zx]\n", pos);
+		return false;
+	}
+	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
+		      " dsdes:%d Overflow:%lld Time:%#llx\n"
+		      "\t\tC:%d TOD:%#lx 1:%#llx 2:%#llx\n",
+		      pos,
+		      te->f ? 'F' : ' ',
+		      te->a ? 'A' : ' ',
+		      te->t ? 'T' : ' ',
+		      te->bsdes, te->dsdes, te->overflow,
+		      trailer_timestamp(te), te->clock_base, te->progusage2,
+		      te->progusage[0], te->progusage[1]);
+	return true;
+}
+
+/* Test a sample data block. It must be 4KB or a multiple thereof in size and
+ * 4KB page aligned. Each sample data page has a trailer entry at the
+ * end which contains the sample entry data sizes.
+ *
+ * Return true if the sample data block passes the checks and set the
+ * basic set entry size and diagnostic set entry size.
+ *
+ * Return false on failure.
+ *
+ * Note: Old hardware does not set the basic or diagnostic entry sizes
+ * in the trailer entry. Use the type number instead.
+ */
+static bool s390_cpumsf_validate(int machine_type,
+				 unsigned char *buf, size_t len,
+				 unsigned short *bsdes,
+				 unsigned short *dsdes)
+{
+	struct hws_basic_entry *basic = (struct hws_basic_entry *)buf;
+	struct hws_trailer_entry *te;
+
+	*dsdes = *bsdes = 0;
+	if (len & (S390_CPUMSF_PAGESZ - 1))	/* Illegal size */
+		return false;
+	if (basic->def != 1)		/* No basic set entry, must be first */
+		return false;
+	/* Check for trailer entry at end of SDB */
+	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
+					      - sizeof(*te));
+	*bsdes = te->bsdes;
+	*dsdes = te->dsdes;
+	if (!te->bsdes && !te->dsdes) {
+		/* Very old hardware, use CPUID */
+		switch (machine_type) {
+		case 2097:
+		case 2098:
+			*dsdes = 64;
+			*bsdes = 32;
+			break;
+		case 2817:
+		case 2818:
+			*dsdes = 74;
+			*bsdes = 32;
+			break;
+		case 2827:
+		case 2828:
+			*dsdes = 85;
+			*bsdes = 32;
+			break;
+		default:
+			/* Illegal trailer entry */
+			return false;
+		}
+	}
+	return true;
+}
+
+/* Return true if there is room for another entry */
+static bool s390_cpumsf_reached_trailer(size_t entry_sz, size_t pos)
+{
+	size_t payload = S390_CPUMSF_PAGESZ - sizeof(struct hws_trailer_entry);
+
+	if (payload - (pos & (S390_CPUMSF_PAGESZ - 1)) < entry_sz)
+		return false;
+	return true;
+}
+
+/* Dump an auxiliary buffer. These buffers are multiple of
+ * 4KB SDB pages.
+ */
+static void s390_cpumsf_dump(struct s390_cpumsf *sf,
+			     unsigned char *buf, size_t len)
+{
+	const char *color = PERF_COLOR_BLUE;
+	struct hws_basic_entry *basic;
+	struct hws_diag_entry *diag;
+	unsigned short bsdes, dsdes;
+	size_t pos = 0;
+
+	color_fprintf(stdout, color,
+		      ". ... s390 AUX data: size %zu bytes\n",
+		      len);
+
+	if (!s390_cpumsf_validate(sf->machine_type, buf, len, &bsdes,
+				  &dsdes)) {
+		pr_err("Invalid AUX trace data block size:%zu"
+		       " (type:%d bsdes:%hd dsdes:%hd)\n",
+		       len, sf->machine_type, bsdes, dsdes);
+		return;
+	}
+
+	/* s390 kernel always returns 4KB blocks fully occupied,
+	 * no partially filled SDBs.
+	 */
+	while (pos < len) {
+		/* Handle Basic entry */
+		basic = (struct hws_basic_entry *)(buf + pos);
+		if (s390_cpumsf_basic_show(color, pos, basic))
+			pos += bsdes;
+		else
+			return;
+
+		/* Handle Diagnostic entry */
+		diag = (struct hws_diag_entry *)(buf + pos);
+		if (s390_cpumsf_diag_show(color, pos, diag))
+			pos += dsdes;
+		else
+			return;
+
+		/* Check for trailer entry */
+		if (!s390_cpumsf_reached_trailer(bsdes + dsdes, pos)) {
+			/* Show trailer entry */
+			struct hws_trailer_entry te;
+
+			pos = (pos + S390_CPUMSF_PAGESZ)
+			       & ~(S390_CPUMSF_PAGESZ - 1);
+			pos -= sizeof(te);
+			memcpy(&te, buf + pos, sizeof(te));
+			/* Set descriptor sizes in case of old hardware
+			 * where these values are not set.
+			 */
+			te.bsdes = bsdes;
+			te.dsdes = dsdes;
+			if (s390_cpumsf_trailer_show(color, pos, &te))
+				pos += sizeof(te);
+			else
+				return;
+		}
+	}
+}
+
+static void s390_cpumsf_dump_event(struct s390_cpumsf *sf, unsigned char *buf,
+				   size_t len)
+{
+	printf(".\n");
+	s390_cpumsf_dump(sf, buf, len);
+}
+
+#define	S390_LPP_PID_MASK	0xffffffff
+
+static bool s390_cpumsf_make_event(size_t pos,
+				   struct hws_basic_entry *basic,
+				   struct s390_cpumsf_queue *sfq)
+{
+	struct perf_sample sample = {
+				.ip = basic->ia,
+				.pid = basic->hpp & S390_LPP_PID_MASK,
+				.tid = basic->hpp & S390_LPP_PID_MASK,
+				.cpumode = PERF_RECORD_MISC_CPUMODE_UNKNOWN,
+				.cpu = sfq->cpu,
+				.period = 1
+			    };
+	union perf_event event;
+
+	memset(&event, 0, sizeof(event));
+	if (basic->CL == 1)	/* Native LPAR mode */
+		sample.cpumode = basic->P ? PERF_RECORD_MISC_USER
+					  : PERF_RECORD_MISC_KERNEL;
+	else if (basic->CL == 2)	/* Guest kernel/user space */
+		sample.cpumode = basic->P ? PERF_RECORD_MISC_GUEST_USER
+					  : PERF_RECORD_MISC_GUEST_KERNEL;
+	else if (basic->gpp || basic->prim_asn != 0xffff)
+		/* Use heuristics on old hardware */
+		sample.cpumode = basic->P ? PERF_RECORD_MISC_GUEST_USER
+					  : PERF_RECORD_MISC_GUEST_KERNEL;
+	else
+		sample.cpumode = basic->P ? PERF_RECORD_MISC_USER
+					  : PERF_RECORD_MISC_KERNEL;
+
+	event.sample.header.type = PERF_RECORD_SAMPLE;
+	event.sample.header.misc = sample.cpumode;
+	event.sample.header.size = sizeof(struct perf_event_header);
+
+	pr_debug4("%s pos:%#zx ip:%#" PRIx64 " P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
+		 __func__, pos, sample.ip, basic->P, basic->CL, sample.pid,
+		 sample.tid, sample.cpumode, sample.cpu);
+	if (perf_session__deliver_synth_event(sfq->sf->session, &event,
+					      &sample)) {
+		pr_err("s390 Auxiliary Trace: failed to deliver event\n");
+		return false;
+	}
+	return true;
+}
+
+static unsigned long long get_trailer_time(const unsigned char *buf)
+{
+	struct hws_trailer_entry *te;
+	unsigned long long aux_time;
+
+	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
+					      - sizeof(*te));
+
+	if (!te->clock_base)	/* TOD_CLOCK_BASE value missing */
+		return 0;
+
+	/* Correct calculation to convert time stamp in trailer entry to
+	 * nano seconds (taken from arch/s390 function tod_to_ns()).
+	 * TOD_CLOCK_BASE is stored in trailer entry member progusage2.
+	 */
+	aux_time = trailer_timestamp(te) - te->progusage2;
+	aux_time = (aux_time >> 9) * 125 + (((aux_time & 0x1ff) * 125) >> 9);
+	return aux_time;
+}
+
+/* Process the data samples of a single queue. The first parameter is a
+ * pointer to the queue, the second parameter is the time stamp. This
+ * is the time stamp:
+ * - of the event that triggered this processing.
+ * - or the time stamp when the last proccesing of this queue stopped.
+ *   In this case it stopped at a 4KB page boundary and record the
+ *   position on where to continue processing on the next invocation
+ *   (see buffer->use_data and buffer->use_size).
+ *
+ * When this function returns the second parameter is updated to
+ * reflect the time stamp of the last processed auxiliary data entry
+ * (taken from the trailer entry of that page). The caller uses this
+ * returned time stamp to record the last processed entry in this
+ * queue.
+ *
+ * The function returns:
+ * 0:  Processing successful. The second parameter returns the
+ *     time stamp from the trailer entry until which position
+ *     processing took place. Subsequent calls resume from this
+ *     position.
+ * <0: An error occurred during processing. The second parameter
+ *     returns the maximum time stamp.
+ * >0: Done on this queue. The second parameter returns the
+ *     maximum time stamp.
+ */
+static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
+{
+	struct s390_cpumsf *sf = sfq->sf;
+	unsigned char *buf = sfq->buffer->use_data;
+	size_t len = sfq->buffer->use_size;
+	struct hws_basic_entry *basic;
+	unsigned short bsdes, dsdes;
+	size_t pos = 0;
+	int err = 1;
+	u64 aux_ts;
+
+	if (!s390_cpumsf_validate(sf->machine_type, buf, len, &bsdes,
+				  &dsdes)) {
+		*ts = ~0ULL;
+		return -1;
+	}
+
+	/* Get trailer entry time stamp and check if entries in
+	 * this auxiliary page are ready for processing. If the
+	 * time stamp of the first entry is too high, whole buffer
+	 * can be skipped. In this case return time stamp.
+	 */
+	aux_ts = get_trailer_time(buf);
+	if (!aux_ts) {
+		pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
+		       sfq->buffer->data_offset);
+		aux_ts = ~0ULL;
+		goto out;
+	}
+	if (aux_ts > *ts) {
+		*ts = aux_ts;
+		return 0;
+	}
+
+	while (pos < len) {
+		/* Handle Basic entry */
+		basic = (struct hws_basic_entry *)(buf + pos);
+		if (s390_cpumsf_make_event(pos, basic, sfq))
+			pos += bsdes;
+		else {
+			err = -EBADF;
+			goto out;
+		}
+
+		pos += dsdes;	/* Skip diagnositic entry */
+
+		/* Check for trailer entry */
+		if (!s390_cpumsf_reached_trailer(bsdes + dsdes, pos)) {
+			pos = (pos + S390_CPUMSF_PAGESZ)
+			       & ~(S390_CPUMSF_PAGESZ - 1);
+			/* Check existence of next page */
+			if (pos >= len)
+				break;
+			aux_ts = get_trailer_time(buf + pos);
+			if (!aux_ts) {
+				aux_ts = ~0ULL;
+				goto out;
+			}
+			if (aux_ts > *ts) {
+				*ts = aux_ts;
+				sfq->buffer->use_data += pos;
+				sfq->buffer->use_size -= pos;
+				return 0;
+			}
+		}
+	}
+out:
+	*ts = aux_ts;
+	sfq->buffer->use_size = 0;
+	sfq->buffer->use_data = NULL;
+	return err;	/* Buffer completely scanned or error */
+}
+
+/* Run the s390 auxiliary trace decoder.
+ * Select the queue buffer to operate on, the caller already selected
+ * the proper queue, depending on second parameter 'ts'.
+ * This is the time stamp until which the auxiliary entries should
+ * be processed. This value is updated by called functions and
+ * returned to the caller.
+ *
+ * Resume processing in the current buffer. If there is no buffer
+ * get a new buffer from the queue and setup start position for
+ * processing.
+ * When a buffer is completely processed remove it from the queue
+ * before returning.
+ *
+ * This function returns
+ * 1: When the queue is empty. Second parameter will be set to
+ *    maximum time stamp.
+ * 0: Normal processing done.
+ * <0: Error during queue buffer setup. This causes the caller
+ *     to stop processing completely.
+ */
+static int s390_cpumsf_run_decoder(struct s390_cpumsf_queue *sfq,
+				   u64 *ts)
+{
+
+	struct auxtrace_buffer *buffer;
+	struct auxtrace_queue *queue;
+	int err;
+
+	queue = &sfq->sf->queues.queue_array[sfq->queue_nr];
+
+	/* Get buffer and last position in buffer to resume
+	 * decoding the auxiliary entries. One buffer might be large
+	 * and decoding might stop in between. This depends on the time
+	 * stamp of the trailer entry in each page of the auxiliary
+	 * data and the time stamp of the event triggering the decoding.
+	 */
+	if (sfq->buffer == NULL) {
+		sfq->buffer = buffer = auxtrace_buffer__next(queue,
+							     sfq->buffer);
+		if (!buffer) {
+			*ts = ~0ULL;
+			return 1;	/* Processing done on this queue */
+		}
+		/* Start with a new buffer on this queue */
+		if (buffer->data) {
+			buffer->use_size = buffer->size;
+			buffer->use_data = buffer->data;
+		}
+	} else
+		buffer = sfq->buffer;
+
+	if (!buffer->data) {
+		int fd = perf_data__fd(sfq->sf->session->data);
+
+		buffer->data = auxtrace_buffer__get_data(buffer, fd);
+		if (!buffer->data)
+			return -ENOMEM;
+		buffer->use_size = buffer->size;
+		buffer->use_data = buffer->data;
+	}
+	pr_debug4("%s queue_nr:%d buffer:%" PRId64 " offset:%#" PRIx64 " size:%#zx rest:%#zx\n",
+		  __func__, sfq->queue_nr, buffer->buffer_nr, buffer->offset,
+		  buffer->size, buffer->use_size);
+	err = s390_cpumsf_samples(sfq, ts);
+
+	/* If non-zero, there is either an error (err < 0) or the buffer is
+	 * completely done (err > 0). The error is unrecoverable, usually
+	 * some descriptors could not be read successfully, so continue with
+	 * the next buffer.
+	 * In both cases the parameter 'ts' has been updated.
+	 */
+	if (err) {
+		sfq->buffer = NULL;
+		list_del(&buffer->list);
+		auxtrace_buffer__free(buffer);
+		if (err > 0)		/* Buffer done, no error */
+			err = 0;
+	}
+	return err;
+}
+
+static struct s390_cpumsf_queue *
+s390_cpumsf_alloc_queue(struct s390_cpumsf *sf, unsigned int queue_nr)
+{
+	struct s390_cpumsf_queue *sfq;
+
+	sfq = zalloc(sizeof(struct s390_cpumsf_queue));
+	if (sfq == NULL)
+		return NULL;
+
+	sfq->sf = sf;
+	sfq->queue_nr = queue_nr;
+	sfq->cpu = -1;
+	return sfq;
+}
+
+static int s390_cpumsf_setup_queue(struct s390_cpumsf *sf,
+				   struct auxtrace_queue *queue,
+				   unsigned int queue_nr, u64 ts)
+{
+	struct s390_cpumsf_queue *sfq = queue->priv;
+
+	if (list_empty(&queue->head))
+		return 0;
+
+	if (sfq == NULL) {
+		sfq = s390_cpumsf_alloc_queue(sf, queue_nr);
+		if (!sfq)
+			return -ENOMEM;
+		queue->priv = sfq;
+
+		if (queue->cpu != -1)
+			sfq->cpu = queue->cpu;
+	}
+	return auxtrace_heap__add(&sf->heap, queue_nr, ts);
+}
+
+static int s390_cpumsf_setup_queues(struct s390_cpumsf *sf, u64 ts)
+{
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < sf->queues.nr_queues; i++) {
+		ret = s390_cpumsf_setup_queue(sf, &sf->queues.queue_array[i],
+					      i, ts);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int s390_cpumsf_update_queues(struct s390_cpumsf *sf, u64 ts)
+{
+	if (!sf->queues.new_data)
+		return 0;
+
+	sf->queues.new_data = false;
+	return s390_cpumsf_setup_queues(sf, ts);
+}
+
+static int s390_cpumsf_process_queues(struct s390_cpumsf *sf, u64 timestamp)
+{
+	unsigned int queue_nr;
+	u64 ts;
+	int ret;
+
+	while (1) {
+		struct auxtrace_queue *queue;
+		struct s390_cpumsf_queue *sfq;
+
+		if (!sf->heap.heap_cnt)
+			return 0;
+
+		if (sf->heap.heap_array[0].ordinal >= timestamp)
+			return 0;
+
+		queue_nr = sf->heap.heap_array[0].queue_nr;
+		queue = &sf->queues.queue_array[queue_nr];
+		sfq = queue->priv;
+
+		auxtrace_heap__pop(&sf->heap);
+		if (sf->heap.heap_cnt) {
+			ts = sf->heap.heap_array[0].ordinal + 1;
+			if (ts > timestamp)
+				ts = timestamp;
+		} else {
+			ts = timestamp;
+		}
+
+		ret = s390_cpumsf_run_decoder(sfq, &ts);
+		if (ret < 0) {
+			auxtrace_heap__add(&sf->heap, queue_nr, ts);
+			return ret;
+		}
+		if (!ret) {
+			ret = auxtrace_heap__add(&sf->heap, queue_nr, ts);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
+static int s390_cpumsf_synth_error(struct s390_cpumsf *sf, int code, int cpu,
+				   pid_t pid, pid_t tid, u64 ip)
+{
+	char msg[MAX_AUXTRACE_ERROR_MSG];
+	union perf_event event;
+	int err;
+
+	strncpy(msg, "Lost Auxiliary Trace Buffer", sizeof(msg) - 1);
+	auxtrace_synth_error(&event.auxtrace_error, PERF_AUXTRACE_ERROR_ITRACE,
+			     code, cpu, pid, tid, ip, msg);
+
+	err = perf_session__deliver_synth_event(sf->session, &event, NULL);
+	if (err)
+		pr_err("s390 Auxiliary Trace: failed to deliver error event,"
+			"error %d\n", err);
+	return err;
+}
+
+static int s390_cpumsf_lost(struct s390_cpumsf *sf, struct perf_sample *sample)
+{
+	return s390_cpumsf_synth_error(sf, 1, sample->cpu,
+				       sample->pid, sample->tid, 0);
+}
+
+static int
+s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
+			  union perf_event *event,
+			  struct perf_sample *sample,
+			  struct perf_tool *tool)
+{
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					      auxtrace);
+	u64 timestamp = sample->time;
+	int err = 0;
+
+	if (dump_trace)
+		return 0;
+
+	if (!tool->ordered_events) {
+		pr_err("s390 Auxiliary Trace requires ordered events\n");
+		return -EINVAL;
+	}
+
+	if (event->header.type == PERF_RECORD_AUX &&
+	    event->aux.flags & PERF_AUX_FLAG_TRUNCATED)
+		return s390_cpumsf_lost(sf, sample);
+
+	if (timestamp) {
+		err = s390_cpumsf_update_queues(sf, timestamp);
+		if (!err)
+			err = s390_cpumsf_process_queues(sf, timestamp);
+	}
+	return err;
+}
+
+struct s390_cpumsf_synth {
+	struct perf_tool cpumsf_tool;
+	struct perf_session *session;
+};
+
+static int
+s390_cpumsf_process_auxtrace_event(struct perf_session *session,
+				   union perf_event *event __maybe_unused,
+				   struct perf_tool *tool __maybe_unused)
+{
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					      auxtrace);
+
+	int fd = perf_data__fd(session->data);
+	struct auxtrace_buffer *buffer;
+	off_t data_offset;
+	int err;
+
+	if (sf->data_queued)
+		return 0;
+
+	if (perf_data__is_pipe(session->data)) {
+		data_offset = 0;
+	} else {
+		data_offset = lseek(fd, 0, SEEK_CUR);
+		if (data_offset == -1)
+			return -errno;
+	}
+
+	err = auxtrace_queues__add_event(&sf->queues, session, event,
+					 data_offset, &buffer);
+	if (err)
+		return err;
+
+	/* Dump here after copying piped trace out of the pipe */
+	if (dump_trace) {
+		if (auxtrace_buffer__get_data(buffer, fd)) {
+			s390_cpumsf_dump_event(sf, buffer->data,
+					       buffer->size);
+			auxtrace_buffer__put_data(buffer);
+		}
+	}
+	return 0;
+}
+
+static void s390_cpumsf_free_events(struct perf_session *session __maybe_unused)
+{
+}
+
+static int s390_cpumsf_flush(struct perf_session *session __maybe_unused,
+			     struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void s390_cpumsf_free_queues(struct perf_session *session)
+{
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					      auxtrace);
+	struct auxtrace_queues *queues = &sf->queues;
+	unsigned int i;
+
+	for (i = 0; i < queues->nr_queues; i++)
+		zfree(&queues->queue_array[i].priv);
+	auxtrace_queues__free(queues);
+}
+
+static void s390_cpumsf_free(struct perf_session *session)
+{
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					      auxtrace);
+
+	auxtrace_heap__free(&sf->heap);
+	s390_cpumsf_free_queues(session);
+	session->auxtrace = NULL;
+	free(sf);
+}
+
+static int s390_cpumsf_get_type(const char *cpuid)
+{
+	int ret, family = 0;
+
+	ret = sscanf(cpuid, "%*[^,],%u", &family);
+	return (ret == 1) ? family : 0;
+}
+
+/* Check itrace options set on perf report command.
+ * Return true, if none are set or all options specified can be
+ * handled on s390.
+ * Return false otherwise.
+ */
+static bool check_auxtrace_itrace(struct itrace_synth_opts *itops)
+{
+	if (!itops || !itops->set)
+		return true;
+	pr_err("No --itrace options supported\n");
+	return false;
+}
+
+int s390_cpumsf_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session)
+{
+	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct s390_cpumsf *sf;
+	int err;
+
+	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event))
+		return -EINVAL;
+
+	sf = zalloc(sizeof(struct s390_cpumsf));
+	if (sf == NULL)
+		return -ENOMEM;
+
+	if (!check_auxtrace_itrace(session->itrace_synth_opts)) {
+		err = -EINVAL;
+		goto err_free;
+	}
+
+	err = auxtrace_queues__init(&sf->queues);
+	if (err)
+		goto err_free;
+
+	sf->session = session;
+	sf->machine = &session->machines.host; /* No kvm support */
+	sf->auxtrace_type = auxtrace_info->type;
+	sf->pmu_type = PERF_TYPE_RAW;
+	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
+
+	sf->auxtrace.process_event = s390_cpumsf_process_event;
+	sf->auxtrace.process_auxtrace_event = s390_cpumsf_process_auxtrace_event;
+	sf->auxtrace.flush_events = s390_cpumsf_flush;
+	sf->auxtrace.free_events = s390_cpumsf_free_events;
+	sf->auxtrace.free = s390_cpumsf_free;
+	session->auxtrace = &sf->auxtrace;
+
+	if (dump_trace)
+		return 0;
+
+	err = auxtrace_queues__process_index(&sf->queues, session);
+	if (err)
+		goto err_free_queues;
+
+	if (sf->queues.populated)
+		sf->data_queued = true;
+
+	return 0;
+
+err_free_queues:
+	auxtrace_queues__free(&sf->queues);
+	session->auxtrace = NULL;
+err_free:
+	free(sf);
+	return err;
+}
diff --git a/tools/perf/util/s390-cpumsf.h b/tools/perf/util/s390-cpumsf.h
new file mode 100644
index 000000000000..fb64d100555c
--- /dev/null
+++ b/tools/perf/util/s390-cpumsf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright IBM Corp. 2018
+ * Auxtrace support for s390 CPU-Measurement Sampling Facility
+ *
+ * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
+ */
+
+#ifndef INCLUDE__PERF_S390_CPUMSF_H
+#define INCLUDE__PERF_S390_CPUMSF_H
+
+union perf_event;
+struct perf_session;
+struct perf_pmu;
+
+struct auxtrace_record *
+s390_cpumsf_recording_init(int *err, struct perf_pmu *s390_cpumsf_pmu);
+
+int s390_cpumsf_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session);
+#endif
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 7b79c413486b..45484f0f7292 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -535,7 +535,7 @@ static int perl_stop_script(void)
 	return 0;
 }
 
-static int perl_generate_script(struct pevent *pevent, const char *outfile)
+static int perl_generate_script(struct tep_handle *pevent, const char *outfile)
 {
 	struct event_format *event = NULL;
 	struct format_field *f;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index bc32e57d17be..dfc6093f118c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -871,8 +871,8 @@ static void python_process_tracepoint(struct perf_sample *sample,
 			offset = field->offset;
 			len    = field->size;
 			if (field->flags & FIELD_IS_DYNAMIC) {
-				val     = pevent_read_number(scripting_context->pevent,
-							     data + offset, len);
+				val     = tep_read_number(scripting_context->pevent,
+							  data + offset, len);
 				offset  = val;
 				len     = offset >> 16;
 				offset &= 0xffff;
@@ -1588,7 +1588,7 @@ static int python_stop_script(void)
 	return 0;
 }
 
-static int python_generate_script(struct pevent *pevent, const char *outfile)
+static int python_generate_script(struct tep_handle *pevent, const char *outfile)
 {
 	struct event_format *event = NULL;
 	struct format_field *f;
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 001be4f9d3b9..97efbcad076e 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,12 +1,20 @@
 #!/usr/bin/python
 
 from os import getenv
+from subprocess import Popen, PIPE
+from re import sub
+
+def clang_has_option(option):
+    return [o for o in Popen(['clang', option], stderr=PIPE).stderr.readlines() if "unknown argument" in o] == [ ]
 
 cc = getenv("CC")
 if cc == "clang":
     from _sysconfigdata import build_time_vars
-    from re import sub
     build_time_vars["CFLAGS"] = sub("-specs=[^ ]+", "", build_time_vars["CFLAGS"])
+    if not clang_has_option("-mcet"):
+        build_time_vars["CFLAGS"] = sub("-mcet", "", build_time_vars["CFLAGS"])
+    if not clang_has_option("-fcf-protection"):
+        build_time_vars["CFLAGS"] = sub("-fcf-protection", "", build_time_vars["CFLAGS"])
 
 from distutils.core import setup, Extension
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index fed2952ab45a..b284276ec963 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -601,7 +601,7 @@ static char *get_trace_output(struct hist_entry *he)
 {
 	struct trace_seq seq;
 	struct perf_evsel *evsel;
-	struct pevent_record rec = {
+	struct tep_record rec = {
 		.data = he->raw_data,
 		.size = he->raw_size,
 	};
@@ -610,10 +610,10 @@ static char *get_trace_output(struct hist_entry *he)
 
 	trace_seq_init(&seq);
 	if (symbol_conf.raw_trace) {
-		pevent_print_fields(&seq, he->raw_data, he->raw_size,
-				    evsel->tp_format);
+		tep_print_fields(&seq, he->raw_data, he->raw_size,
+				 evsel->tp_format);
 	} else {
-		pevent_event_info(&seq, evsel->tp_format, &rec);
+		tep_event_info(&seq, evsel->tp_format, &rec);
 	}
 	/*
 	 * Trim the buffer, it starts at 4KB and we're not going to
@@ -2047,7 +2047,7 @@ static int __sort__hde_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		struct trace_seq seq;
 raw_field:
 		trace_seq_init(&seq);
-		pevent_print_field(&seq, he->raw_data, hde->field);
+		tep_print_field(&seq, he->raw_data, hde->field);
 		str = seq.buffer;
 	}
 
@@ -2074,7 +2074,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 	if (field->flags & FIELD_IS_DYNAMIC) {
 		unsigned long long dyn;
 
-		pevent_read_number_field(field, a->raw_data, &dyn);
+		tep_read_number_field(field, a->raw_data, &dyn);
 		offset = dyn & 0xffff;
 		size = (dyn >> 16) & 0xffff;
 
@@ -2311,7 +2311,7 @@ static int add_all_matching_fields(struct perf_evlist *evlist,
 		if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
 
-		field = pevent_find_any_field(evsel->tp_format, field_name);
+		field = tep_find_any_field(evsel->tp_format, field_name);
 		if (field == NULL)
 			continue;
 
@@ -2378,7 +2378,7 @@ static int add_dynamic_entry(struct perf_evlist *evlist, const char *tok,
 	if (!strcmp(field_name, "*")) {
 		ret = add_evsel_fields(evsel, raw_trace, level);
 	} else {
-		field = pevent_find_any_field(evsel->tp_format, field_name);
+		field = tep_find_any_field(evsel->tp_format, field_name);
 		if (field == NULL) {
 			pr_debug("Cannot find event field for %s.%s\n",
 				 event_name, field_name);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 8bf302cafcec..a97cf8e6be86 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -276,7 +276,7 @@ extern struct sort_entry sort_thread;
 extern struct list_head hist_entry__sort_list;
 
 struct perf_evlist;
-struct pevent;
+struct tep_handle;
 int setup_sorting(struct perf_evlist *evlist);
 int setup_output_field(void);
 void reset_output_field(void);
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index e0a6e9a6a053..920b1d58a068 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -32,7 +32,7 @@
 static int get_common_field(struct scripting_context *context,
 			    int *offset, int *size, const char *type)
 {
-	struct pevent *pevent = context->pevent;
+	struct tep_handle *pevent = context->pevent;
 	struct event_format *event;
 	struct format_field *field;
 
@@ -41,14 +41,14 @@ static int get_common_field(struct scripting_context *context,
 			return 0;
 
 		event = pevent->events[0];
-		field = pevent_find_common_field(event, type);
+		field = tep_find_common_field(event, type);
 		if (!field)
 			return 0;
 		*offset = field->offset;
 		*size = field->size;
 	}
 
-	return pevent_read_number(pevent, context->event_data + *offset, *size);
+	return tep_read_number(pevent, context->event_data + *offset, *size);
 }
 
 int common_lock_depth(struct scripting_context *context)
@@ -99,24 +99,24 @@ raw_field_value(struct event_format *event, const char *name, void *data)
 	struct format_field *field;
 	unsigned long long val;
 
-	field = pevent_find_any_field(event, name);
+	field = tep_find_any_field(event, name);
 	if (!field)
 		return 0ULL;
 
-	pevent_read_number_field(field, data, &val);
+	tep_read_number_field(field, data, &val);
 
 	return val;
 }
 
 unsigned long long read_size(struct event_format *event, void *ptr, int size)
 {
-	return pevent_read_number(event->pevent, ptr, size);
+	return tep_read_number(event->pevent, ptr, size);
 }
 
 void event_format__fprintf(struct event_format *event,
 			   int cpu, void *data, int size, FILE *fp)
 {
-	struct pevent_record record;
+	struct tep_record record;
 	struct trace_seq s;
 
 	memset(&record, 0, sizeof(record));
@@ -125,7 +125,7 @@ void event_format__fprintf(struct event_format *event,
 	record.data = data;
 
 	trace_seq_init(&s);
-	pevent_event_info(&s, event, &record);
+	tep_event_info(&s, event, &record);
 	trace_seq_do_fprintf(&s, fp);
 	trace_seq_destroy(&s);
 }
@@ -136,7 +136,7 @@ void event_format__print(struct event_format *event,
 	return event_format__fprintf(event, cpu, data, size, stdout);
 }
 
-void parse_ftrace_printk(struct pevent *pevent,
+void parse_ftrace_printk(struct tep_handle *pevent,
 			 char *file, unsigned int size __maybe_unused)
 {
 	unsigned long long addr;
@@ -157,11 +157,11 @@ void parse_ftrace_printk(struct pevent *pevent,
 		/* fmt still has a space, skip it */
 		printk = strdup(fmt+1);
 		line = strtok_r(NULL, "\n", &next);
-		pevent_register_print_string(pevent, printk, addr);
+		tep_register_print_string(pevent, printk, addr);
 	}
 }
 
-void parse_saved_cmdline(struct pevent *pevent,
+void parse_saved_cmdline(struct tep_handle *pevent,
 			 char *file, unsigned int size __maybe_unused)
 {
 	char *comm;
@@ -172,24 +172,24 @@ void parse_saved_cmdline(struct pevent *pevent,
 	line = strtok_r(file, "\n", &next);
 	while (line) {
 		sscanf(line, "%d %ms", &pid, &comm);
-		pevent_register_comm(pevent, comm, pid);
+		tep_register_comm(pevent, comm, pid);
 		free(comm);
 		line = strtok_r(NULL, "\n", &next);
 	}
 }
 
-int parse_ftrace_file(struct pevent *pevent, char *buf, unsigned long size)
+int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size)
 {
-	return pevent_parse_event(pevent, buf, size, "ftrace");
+	return tep_parse_event(pevent, buf, size, "ftrace");
 }
 
-int parse_event_file(struct pevent *pevent,
+int parse_event_file(struct tep_handle *pevent,
 		     char *buf, unsigned long size, char *sys)
 {
-	return pevent_parse_event(pevent, buf, size, sys);
+	return tep_parse_event(pevent, buf, size, sys);
 }
 
-struct event_format *trace_find_next_event(struct pevent *pevent,
+struct event_format *trace_find_next_event(struct tep_handle *pevent,
 					   struct event_format *event)
 {
 	static int idx;
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 40b425949aa3..3dfc1db6b25b 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -96,7 +96,7 @@ static void skip(int size)
 	};
 }
 
-static unsigned int read4(struct pevent *pevent)
+static unsigned int read4(struct tep_handle *pevent)
 {
 	unsigned int data;
 
@@ -105,7 +105,7 @@ static unsigned int read4(struct pevent *pevent)
 	return __data2host4(pevent, data);
 }
 
-static unsigned long long read8(struct pevent *pevent)
+static unsigned long long read8(struct tep_handle *pevent)
 {
 	unsigned long long data;
 
@@ -158,7 +158,7 @@ static char *read_string(void)
 	return str;
 }
 
-static int read_proc_kallsyms(struct pevent *pevent)
+static int read_proc_kallsyms(struct tep_handle *pevent)
 {
 	unsigned int size;
 
@@ -181,7 +181,7 @@ static int read_proc_kallsyms(struct pevent *pevent)
 	return 0;
 }
 
-static int read_ftrace_printk(struct pevent *pevent)
+static int read_ftrace_printk(struct tep_handle *pevent)
 {
 	unsigned int size;
 	char *buf;
@@ -208,7 +208,7 @@ static int read_ftrace_printk(struct pevent *pevent)
 	return 0;
 }
 
-static int read_header_files(struct pevent *pevent)
+static int read_header_files(struct tep_handle *pevent)
 {
 	unsigned long long size;
 	char *header_page;
@@ -235,13 +235,13 @@ static int read_header_files(struct pevent *pevent)
 		return -1;
 	}
 
-	if (!pevent_parse_header_page(pevent, header_page, size,
-				      pevent_get_long_size(pevent))) {
+	if (!tep_parse_header_page(pevent, header_page, size,
+				   tep_get_long_size(pevent))) {
 		/*
 		 * The commit field in the page is of type long,
 		 * use that instead, since it represents the kernel.
 		 */
-		pevent_set_long_size(pevent, pevent->header_page_size_size);
+		tep_set_long_size(pevent, pevent->header_page_size_size);
 	}
 	free(header_page);
 
@@ -259,7 +259,7 @@ static int read_header_files(struct pevent *pevent)
 	return ret;
 }
 
-static int read_ftrace_file(struct pevent *pevent, unsigned long long size)
+static int read_ftrace_file(struct tep_handle *pevent, unsigned long long size)
 {
 	int ret;
 	char *buf;
@@ -284,8 +284,8 @@ static int read_ftrace_file(struct pevent *pevent, unsigned long long size)
 	return ret;
 }
 
-static int read_event_file(struct pevent *pevent, char *sys,
-			    unsigned long long size)
+static int read_event_file(struct tep_handle *pevent, char *sys,
+			   unsigned long long size)
 {
 	int ret;
 	char *buf;
@@ -310,7 +310,7 @@ static int read_event_file(struct pevent *pevent, char *sys,
 	return ret;
 }
 
-static int read_ftrace_files(struct pevent *pevent)
+static int read_ftrace_files(struct tep_handle *pevent)
 {
 	unsigned long long size;
 	int count;
@@ -328,7 +328,7 @@ static int read_ftrace_files(struct pevent *pevent)
 	return 0;
 }
 
-static int read_event_files(struct pevent *pevent)
+static int read_event_files(struct tep_handle *pevent)
 {
 	unsigned long long size;
 	char *sys;
@@ -356,7 +356,7 @@ static int read_event_files(struct pevent *pevent)
 	return 0;
 }
 
-static int read_saved_cmdline(struct pevent *pevent)
+static int read_saved_cmdline(struct tep_handle *pevent)
 {
 	unsigned long long size;
 	char *buf;
@@ -399,7 +399,7 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 	int host_bigendian;
 	int file_long_size;
 	int file_page_size;
-	struct pevent *pevent = NULL;
+	struct tep_handle *pevent = NULL;
 	int err;
 
 	repipe = __repipe;
@@ -439,9 +439,9 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 
 	pevent = tevent->pevent;
 
-	pevent_set_flag(pevent, PEVENT_NSEC_OUTPUT);
-	pevent_set_file_bigendian(pevent, file_bigendian);
-	pevent_set_host_bigendian(pevent, host_bigendian);
+	tep_set_flag(pevent, TEP_NSEC_OUTPUT);
+	tep_set_file_bigendian(pevent, file_bigendian);
+	tep_set_host_bigendian(pevent, host_bigendian);
 
 	if (do_read(buf, 1) < 0)
 		goto out;
@@ -451,8 +451,8 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 	if (!file_page_size)
 		goto out;
 
-	pevent_set_long_size(pevent, file_long_size);
-	pevent_set_page_size(pevent, file_page_size);
+	tep_set_long_size(pevent, file_long_size);
+	tep_set_page_size(pevent, file_page_size);
 
 	err = read_header_files(pevent);
 	if (err)
@@ -479,9 +479,9 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 	repipe = false;
 
 	if (show_funcs) {
-		pevent_print_funcs(pevent);
+		tep_print_funcs(pevent);
 	} else if (show_printk) {
-		pevent_print_printk(pevent);
+		tep_print_printk(pevent);
 	}
 
 	pevent = NULL;
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index b1e5c3a2b8e3..b749f812ac70 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -66,7 +66,7 @@ static int python_start_script_unsupported(const char *script __maybe_unused,
 	return -1;
 }
 
-static int python_generate_script_unsupported(struct pevent *pevent
+static int python_generate_script_unsupported(struct tep_handle *pevent
 					      __maybe_unused,
 					      const char *outfile
 					      __maybe_unused)
@@ -130,7 +130,7 @@ static int perl_start_script_unsupported(const char *script __maybe_unused,
 	return -1;
 }
 
-static int perl_generate_script_unsupported(struct pevent *pevent
+static int perl_generate_script_unsupported(struct tep_handle *pevent
 					    __maybe_unused,
 					    const char *outfile __maybe_unused)
 {
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 1aa368603268..58bb72f266f3 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -28,10 +28,10 @@ static bool tevent_initialized;
 
 int trace_event__init(struct trace_event *t)
 {
-	struct pevent *pevent = pevent_alloc();
+	struct tep_handle *pevent = tep_alloc();
 
 	if (pevent) {
-		t->plugin_list = traceevent_load_plugins(pevent);
+		t->plugin_list = tep_load_plugins(pevent);
 		t->pevent  = pevent;
 	}
 
@@ -40,33 +40,33 @@ int trace_event__init(struct trace_event *t)
 
 static int trace_event__init2(void)
 {
-	int be = traceevent_host_bigendian();
-	struct pevent *pevent;
+	int be = tep_host_bigendian();
+	struct tep_handle *pevent;
 
 	if (trace_event__init(&tevent))
 		return -1;
 
 	pevent = tevent.pevent;
-	pevent_set_flag(pevent, PEVENT_NSEC_OUTPUT);
-	pevent_set_file_bigendian(pevent, be);
-	pevent_set_host_bigendian(pevent, be);
+	tep_set_flag(pevent, TEP_NSEC_OUTPUT);
+	tep_set_file_bigendian(pevent, be);
+	tep_set_host_bigendian(pevent, be);
 	tevent_initialized = true;
 	return 0;
 }
 
 int trace_event__register_resolver(struct machine *machine,
-				   pevent_func_resolver_t *func)
+				   tep_func_resolver_t *func)
 {
 	if (!tevent_initialized && trace_event__init2())
 		return -1;
 
-	return pevent_set_function_resolver(tevent.pevent, func, machine);
+	return tep_set_function_resolver(tevent.pevent, func, machine);
 }
 
 void trace_event__cleanup(struct trace_event *t)
 {
-	traceevent_unload_plugins(t->plugin_list, t->pevent);
-	pevent_free(t->pevent);
+	tep_unload_plugins(t->plugin_list, t->pevent);
+	tep_free(t->pevent);
 }
 
 /*
@@ -76,7 +76,7 @@ static struct event_format*
 tp_format(const char *sys, const char *name)
 {
 	char *tp_dir = get_events_file(sys);
-	struct pevent *pevent = tevent.pevent;
+	struct tep_handle *pevent = tevent.pevent;
 	struct event_format *event = NULL;
 	char path[PATH_MAX];
 	size_t size;
@@ -93,7 +93,7 @@ tp_format(const char *sys, const char *name)
 	if (err)
 		return ERR_PTR(err);
 
-	pevent_parse_format(pevent, &event, data, size, sys);
+	tep_parse_format(pevent, &event, data, size, sys);
 
 	free(data);
 	return event;
@@ -116,5 +116,5 @@ struct event_format *trace_event__tp_format_id(int id)
 	if (!tevent_initialized && trace_event__init2())
 		return ERR_PTR(-ENOMEM);
 
-	return pevent_find_event(tevent.pevent, id);
+	return tep_find_event(tevent.pevent, id);
 }
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index dcbdb53dc702..40204ec3a7a2 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -13,14 +13,14 @@ struct thread;
 struct plugin_list;
 
 struct trace_event {
-	struct pevent		*pevent;
+	struct tep_handle	*pevent;
 	struct plugin_list	*plugin_list;
 };
 
 int trace_event__init(struct trace_event *t);
 void trace_event__cleanup(struct trace_event *t);
 int trace_event__register_resolver(struct machine *machine,
-				   pevent_func_resolver_t *func);
+				   tep_func_resolver_t *func);
 struct event_format*
 trace_event__tp_format(const char *sys, const char *name);
 
@@ -34,20 +34,20 @@ void event_format__fprintf(struct event_format *event,
 void event_format__print(struct event_format *event,
 			 int cpu, void *data, int size);
 
-int parse_ftrace_file(struct pevent *pevent, char *buf, unsigned long size);
-int parse_event_file(struct pevent *pevent,
+int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
+int parse_event_file(struct tep_handle *pevent,
 		     char *buf, unsigned long size, char *sys);
 
 unsigned long long
 raw_field_value(struct event_format *event, const char *name, void *data);
 
-void parse_proc_kallsyms(struct pevent *pevent, char *file, unsigned int size);
-void parse_ftrace_printk(struct pevent *pevent, char *file, unsigned int size);
-void parse_saved_cmdline(struct pevent *pevent, char *file, unsigned int size);
+void parse_proc_kallsyms(struct tep_handle *pevent, char *file, unsigned int size);
+void parse_ftrace_printk(struct tep_handle *pevent, char *file, unsigned int size);
+void parse_saved_cmdline(struct tep_handle *pevent, char *file, unsigned int size);
 
 ssize_t trace_report(int fd, struct trace_event *tevent, bool repipe);
 
-struct event_format *trace_find_next_event(struct pevent *pevent,
+struct event_format *trace_find_next_event(struct tep_handle *pevent,
 					   struct event_format *event);
 unsigned long long read_size(struct event_format *event, void *ptr, int size);
 unsigned long long eval_flag(const char *flag);
@@ -83,7 +83,7 @@ struct scripting_ops {
 	void (*process_stat)(struct perf_stat_config *config,
 			     struct perf_evsel *evsel, u64 tstamp);
 	void (*process_stat_interval)(u64 tstamp);
-	int (*generate_script) (struct pevent *pevent, const char *outfile);
+	int (*generate_script) (struct tep_handle *pevent, const char *outfile);
 };
 
 extern unsigned int scripting_max_stack;
@@ -94,7 +94,7 @@ void setup_perl_scripting(void);
 void setup_python_scripting(void);
 
 struct scripting_context {
-	struct pevent *pevent;
+	struct tep_handle *pevent;
 	void *event_data;
 };
 
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index a725b958cf31..902ce6384f57 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -5,6 +5,8 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <zlib.h>
+#include <linux/compiler.h>
+#include <unistd.h>
 
 #include "util/compress.h"
 #include "util/util.h"
@@ -79,3 +81,19 @@ int gzip_decompress_to_file(const char *input, int output_fd)
 
 	return ret == Z_STREAM_END ? 0 : -1;
 }
+
+bool gzip_is_compressed(const char *input)
+{
+	int fd = open(input, O_RDONLY);
+	const uint8_t magic[2] = { 0x1f, 0x8b };
+	char buf[2] = { 0 };
+	ssize_t rc;
+
+	if (fd < 0)
+		return -1;
+
+	rc = read(fd, buf, sizeof(buf));
+	close(fd);
+	return rc == sizeof(buf) ?
+	       memcmp(buf, magic, sizeof(buf)) == 0 : false;
+}

