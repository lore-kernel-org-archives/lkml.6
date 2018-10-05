Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB6C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1636F213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlXLT5ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1636F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJEQwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:52:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46311 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeJEQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:51:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id a2-v6so5822374wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hU42QQImrTEB3+W7CsyirtfETrEQ8FN3d2yAH/4oReI=;
        b=AlXLT5ZK7T75nbsMGuptJTc1CLACo0UOw+qJObRf8VT8D8i+l4hX4qzP8axPK6dybY
         C6aDtVA8MLcgHYECO/FSLRrFmuT6DOvh7X4kmZkGlonXNk+Y3yMGXXdI6zXorwwaPoEb
         Z55u/gzQIfawxruSWpsy64DHnviiepBgBJNk9AKPPdmkpwfEkWMnFnu8lHM6slr0EJ08
         CLaDvQamFimLGOLUWaBZ2q8pmxZ0XOyjOo6R/qMvQQKMNC24aXgivHLL42UadXtHex9z
         eYiyDMjNOzTvfpIyisUo24xxAM/auO7KkngNJwGMuy/WU+ZZFCbiqtfOQ21VzcS1HTIi
         946w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hU42QQImrTEB3+W7CsyirtfETrEQ8FN3d2yAH/4oReI=;
        b=MnhGjzn2GxD9oN5U0Dyyat1yFxe/RHwS4AJGIUfTAKMgtdXFyLcb7tOdnXHksm/iHQ
         m3ppVQETOXlKuCKGrL62udW7XODsg0vpvhXGIeHatUh/Z2ylk0Uy9IiFzj6z37G3pjsK
         Bt9G6DNXmuu3LNcHNX8Do8Ron0DDKzrUxXvb7k4yBi2IuhrfUlCWu9pFCAHmZQ5qVnHj
         BP6QM8cd7I70YzDxe5eHq6RylLMV6uWGimq91dfIvfg8Lv5ef7gRAyQiLywcHOYgimmp
         ghBhumtGPifeeZoz94ge1yW2lrhUwkozfo8Tfn43zwnplHdpjtsXrFnd/NDYkZhZfLMg
         iqnw==
X-Gm-Message-State: ABuFfojPWTAdttXRFFA8iAcMnLg7tlIXFYDHNjh+OsW8XxzXLDeuk/Go
        k44DIEBQuurOh+syy0Q+8eI=
X-Google-Smtp-Source: ACcGV60+LUN0cZwKcsLUc4PPStjrSmd0/Ro4O3uWdsTuPz0TdF77YoYx8nPgyXRBiDF3YVAxt6WBxA==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr7823973wrx.310.1538733237262;
        Fri, 05 Oct 2018 02:53:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z69-v6sm1270670wmz.18.2018.10.05.02.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 02:53:56 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:53:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20181005095354.GA103160@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 02e425668f5c9deb42787d10001a3b605993ad15 x86/vdso: Fix vDSO syscall fallback asm constraint regression

Misc fixes:

 - fix various vDSO bugs: asm constraints and retpolines
 - add vDSO test units to make sure they never re-appear
 - fix UV platform TSC initialization bug
 - fix build warning on Clang

 Thanks,

	Ingo

------------------>
Andy Lutomirski (4):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks
      selftests/x86: Add clock_gettime() tests to test_vdso
      x86/vdso: Only enable vDSO retpolines when enabled and supported
      x86/vdso: Fix vDSO syscall fallback asm constraint regression

Mike Travis (2):
      x86/platform/uv: Provide is_early_uv_system()
      x86/tsc: Fix UV TSC initialization

Nathan Chancellor (1):
      x86/cpu/amd: Remove unnecessary parentheses


 arch/x86/entry/vdso/Makefile            |  16 ++-
 arch/x86/entry/vdso/vclock_gettime.c    |  26 ++---
 arch/x86/include/asm/uv/uv.h            |   6 ++
 arch/x86/kernel/cpu/amd.c               |   2 +-
 arch/x86/kernel/tsc.c                   |   4 +
 tools/testing/selftests/x86/test_vdso.c | 172 ++++++++++++++++++++++++++++++++
 6 files changed, 211 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index fa3f439f0a92..141d415a8c80 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -68,7 +68,13 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
        -fno-omit-frame-pointer -foptimize-sibling-calls \
-       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO $(RETPOLINE_VDSO_CFLAGS)
+       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
+
+ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_VDSO_CFLAGS),)
+  CFL += $(RETPOLINE_VDSO_CFLAGS)
+endif
+endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
@@ -138,7 +144,13 @@ KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
+
+ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_VDSO_CFLAGS),)
+  KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
+endif
+endif
+
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
 $(obj)/vdso32.so.dbg: FORCE \
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index f19856d95c60..e48ca3afa091 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -43,8 +43,9 @@ extern u8 hvclock_page
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 {
 	long ret;
-	asm("syscall" : "=a" (ret) :
-	    "0" (__NR_clock_gettime), "D" (clock), "S" (ts) : "memory");
+	asm ("syscall" : "=a" (ret), "=m" (*ts) :
+	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
+	     "memory", "rcx", "r11");
 	return ret;
 }
 
@@ -52,8 +53,9 @@ notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
 {
 	long ret;
 
-	asm("syscall" : "=a" (ret) :
-	    "0" (__NR_gettimeofday), "D" (tv), "S" (tz) : "memory");
+	asm ("syscall" : "=a" (ret), "=m" (*tv), "=m" (*tz) :
+	     "0" (__NR_gettimeofday), "D" (tv), "S" (tz) :
+	     "memory", "rcx", "r11");
 	return ret;
 }
 
@@ -64,13 +66,13 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 {
 	long ret;
 
-	asm(
+	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[clock], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
-		: "=a" (ret)
-		: "0" (__NR_clock_gettime), "g" (clock), "c" (ts)
+		: "=a" (ret), "=m" (*ts)
+		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
 		: "memory", "edx");
 	return ret;
 }
@@ -79,13 +81,13 @@ notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
 {
 	long ret;
 
-	asm(
+	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[tv], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
-		: "=a" (ret)
-		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
+		: "=a" (ret), "=m" (*tv), "=m" (*tz)
+		: "0" (__NR_gettimeofday), [tv] "g" (tv), "c" (tz)
 		: "memory", "edx");
 	return ret;
 }
diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index a80c0673798f..e60c45fd3679 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -10,8 +10,13 @@ struct cpumask;
 struct mm_struct;
 
 #ifdef CONFIG_X86_UV
+#include <linux/efi.h>
 
 extern enum uv_system_type get_uv_system_type(void);
+static inline bool is_early_uv_system(void)
+{
+	return !((efi.uv_systab == EFI_INVALID_TABLE_ADDR) || !efi.uv_systab);
+}
 extern int is_uv_system(void);
 extern int is_uv_hubless(void);
 extern void uv_cpu_init(void);
@@ -23,6 +28,7 @@ extern const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
 #else	/* X86_UV */
 
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
+static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubless(void)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 22ab408177b2..eeea634bee0a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -922,7 +922,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 static unsigned int amd_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 {
 	/* AMD errata T13 (order #21922) */
-	if ((c->x86 == 6)) {
+	if (c->x86 == 6) {
 		/* Duron Rev A0 */
 		if (c->x86_model == 3 && c->x86_stepping == 0)
 			size = 64;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6490f618e096..b52bd2b6cdb4 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -26,6 +26,7 @@
 #include <asm/apic.h>
 #include <asm/intel-family.h>
 #include <asm/i8259.h>
+#include <asm/uv/uv.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -1433,6 +1434,9 @@ void __init tsc_early_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
+	/* Don't change UV TSC multi-chassis synchronization */
+	if (is_early_uv_system())
+		return;
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();
diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 235259011704..35edd61d1663 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -17,6 +17,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <stdbool.h>
+#include <limits.h>
 
 #ifndef SYS_getcpu
 # ifdef __x86_64__
@@ -31,6 +32,14 @@
 
 int nerrs = 0;
 
+typedef int (*vgettime_t)(clockid_t, struct timespec *);
+
+vgettime_t vdso_clock_gettime;
+
+typedef long (*vgtod_t)(struct timeval *tv, struct timezone *tz);
+
+vgtod_t vdso_gettimeofday;
+
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
 
 getcpu_t vgetcpu;
@@ -95,6 +104,15 @@ static void fill_function_pointers()
 		printf("Warning: failed to find getcpu in vDSO\n");
 
 	vgetcpu = (getcpu_t) vsyscall_getcpu();
+
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	if (!vdso_clock_gettime)
+		printf("Warning: failed to find clock_gettime in vDSO\n");
+
+	vdso_gettimeofday = (vgtod_t)dlsym(vdso, "__vdso_gettimeofday");
+	if (!vdso_gettimeofday)
+		printf("Warning: failed to find gettimeofday in vDSO\n");
+
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
@@ -103,6 +121,16 @@ static long sys_getcpu(unsigned * cpu, unsigned * node,
 	return syscall(__NR_getcpu, cpu, node, cache);
 }
 
+static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
+{
+	return syscall(__NR_clock_gettime, id, ts);
+}
+
+static inline int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	return syscall(__NR_gettimeofday, tv, tz);
+}
+
 static void test_getcpu(void)
 {
 	printf("[RUN]\tTesting getcpu...\n");
@@ -155,10 +183,154 @@ static void test_getcpu(void)
 	}
 }
 
+static bool ts_leq(const struct timespec *a, const struct timespec *b)
+{
+	if (a->tv_sec != b->tv_sec)
+		return a->tv_sec < b->tv_sec;
+	else
+		return a->tv_nsec <= b->tv_nsec;
+}
+
+static bool tv_leq(const struct timeval *a, const struct timeval *b)
+{
+	if (a->tv_sec != b->tv_sec)
+		return a->tv_sec < b->tv_sec;
+	else
+		return a->tv_usec <= b->tv_usec;
+}
+
+static char const * const clocknames[] = {
+	[0] = "CLOCK_REALTIME",
+	[1] = "CLOCK_MONOTONIC",
+	[2] = "CLOCK_PROCESS_CPUTIME_ID",
+	[3] = "CLOCK_THREAD_CPUTIME_ID",
+	[4] = "CLOCK_MONOTONIC_RAW",
+	[5] = "CLOCK_REALTIME_COARSE",
+	[6] = "CLOCK_MONOTONIC_COARSE",
+	[7] = "CLOCK_BOOTTIME",
+	[8] = "CLOCK_REALTIME_ALARM",
+	[9] = "CLOCK_BOOTTIME_ALARM",
+	[10] = "CLOCK_SGI_CYCLE",
+	[11] = "CLOCK_TAI",
+};
+
+static void test_one_clock_gettime(int clock, const char *name)
+{
+	struct timespec start, vdso, end;
+	int vdso_ret, end_ret;
+
+	printf("[RUN]\tTesting clock_gettime for clock %s (%d)...\n", name, clock);
+
+	if (sys_clock_gettime(clock, &start) < 0) {
+		if (errno == EINVAL) {
+			vdso_ret = vdso_clock_gettime(clock, &vdso);
+			if (vdso_ret == -EINVAL) {
+				printf("[OK]\tNo such clock.\n");
+			} else {
+				printf("[FAIL]\tNo such clock, but __vdso_clock_gettime returned %d\n", vdso_ret);
+				nerrs++;
+			}
+		} else {
+			printf("[WARN]\t clock_gettime(%d) syscall returned error %d\n", clock, errno);
+		}
+		return;
+	}
+
+	vdso_ret = vdso_clock_gettime(clock, &vdso);
+	end_ret = sys_clock_gettime(clock, &end);
+
+	if (vdso_ret != 0 || end_ret != 0) {
+		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
+		       vdso_ret, errno);
+		nerrs++;
+		return;
+	}
+
+	printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
+	       (unsigned long long)start.tv_sec, start.tv_nsec,
+	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
+	       (unsigned long long)end.tv_sec, end.tv_nsec);
+
+	if (!ts_leq(&start, &vdso) || !ts_leq(&vdso, &end)) {
+		printf("[FAIL]\tTimes are out of sequence\n");
+		nerrs++;
+	}
+}
+
+static void test_clock_gettime(void)
+{
+	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
+	     clock++) {
+		test_one_clock_gettime(clock, clocknames[clock]);
+	}
+
+	/* Also test some invalid clock ids */
+	test_one_clock_gettime(-1, "invalid");
+	test_one_clock_gettime(INT_MIN, "invalid");
+	test_one_clock_gettime(INT_MAX, "invalid");
+}
+
+static void test_gettimeofday(void)
+{
+	struct timeval start, vdso, end;
+	struct timezone sys_tz, vdso_tz;
+	int vdso_ret, end_ret;
+
+	if (!vdso_gettimeofday)
+		return;
+
+	printf("[RUN]\tTesting gettimeofday...\n");
+
+	if (sys_gettimeofday(&start, &sys_tz) < 0) {
+		printf("[FAIL]\tsys_gettimeofday failed (%d)\n", errno);
+		nerrs++;
+		return;
+	}
+
+	vdso_ret = vdso_gettimeofday(&vdso, &vdso_tz);
+	end_ret = sys_gettimeofday(&end, NULL);
+
+	if (vdso_ret != 0 || end_ret != 0) {
+		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
+		       vdso_ret, errno);
+		nerrs++;
+		return;
+	}
+
+	printf("\t%llu.%06ld %llu.%06ld %llu.%06ld\n",
+	       (unsigned long long)start.tv_sec, start.tv_usec,
+	       (unsigned long long)vdso.tv_sec, vdso.tv_usec,
+	       (unsigned long long)end.tv_sec, end.tv_usec);
+
+	if (!tv_leq(&start, &vdso) || !tv_leq(&vdso, &end)) {
+		printf("[FAIL]\tTimes are out of sequence\n");
+		nerrs++;
+	}
+
+	if (sys_tz.tz_minuteswest == vdso_tz.tz_minuteswest &&
+	    sys_tz.tz_dsttime == vdso_tz.tz_dsttime) {
+		printf("[OK]\ttimezones match: minuteswest=%d, dsttime=%d\n",
+		       sys_tz.tz_minuteswest, sys_tz.tz_dsttime);
+	} else {
+		printf("[FAIL]\ttimezones do not match\n");
+		nerrs++;
+	}
+
+	/* And make sure that passing NULL for tz doesn't crash. */
+	vdso_gettimeofday(&vdso, NULL);
+}
+
 int main(int argc, char **argv)
 {
 	fill_function_pointers();
 
+	test_clock_gettime();
+	test_gettimeofday();
+
+	/*
+	 * Test getcpu() last so that, if something goes wrong setting affinity,
+	 * we still run the other tests.
+	 */
 	test_getcpu();
 
 	return nerrs ? 1 : 0;
