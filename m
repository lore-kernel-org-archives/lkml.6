Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225ga2fAOqQI3K+hc+HjzPdaGGMYIPixAHpiem5aQD6wDH6SHQLVPi1+m3Mft0IJTypWCmfU
ARC-Seal: i=1; a=rsa-sha256; t=1519264614; cv=none;
        d=google.com; s=arc-20160816;
        b=wJh1xRJ+EnQRiz09FTlYqL0ATKTlZIw2uXuhA2mm090bconDrfRe2UzAAMqN+pyr26
         PD84k8LANKv6Z0nWTS5JLWToHcuoicHLonDBMzBTthXDkstKWkbSRk7KVP5T94KV8Mmn
         ugB3RwbGEV6Bo03CgEzLDYwtEx8f/pNnl+RvmcSTOqE2abU7mmdh2FvaNXiCQ+V7+Kx3
         6wDT0CWLf2nu7jBvuV4Zr6BiVvyR377tV2fCpJmebHVT8PJM3GJx9G1xgvLWTIg4QQRa
         chqf6I4Tsic9KbHwDCyu1I5yMlNcELVYb6E63dPvtPUX4eZw0gxgdZ5cHAgDPUJImO3r
         wMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xszkis8pPRr59QsMZThnpn5/IzHJ8D81I9MxTKXXe+c=;
        b=UB+7eNCTViwfqY4HDjSRUIDbzPNJ2EAUz0QwvB8JC72w1c1RnzWgYKCi1RfApekMs7
         zbLZe/Enb+MsxUQ1l5eDd+uqgz7dpubdYaNbtvviHZe2/5sE8fuPm7QkL+TgwjPt+UZE
         blJ/uYy1B1Lhgd0MU3cpe1JXDWAOHt0twU3Oew6BAwsNMIGpkst4ZOkj0misA+LS8qES
         I1Zpv28dZnm9o3j87WUtYRFDMONzxUPW2Wm+u89LSrGmMQHFy+g9uqNgRtYfDvgNgLXk
         NFTlCBHiVb8xVY7tlBr89E3uSelpLt8e14WrxqcmfoOiKPFWYkLbMIpka9V/DhO/7Mq1
         z6rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ShJbCsuL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ShJbCsuL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeBVB4x (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:56:53 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42347 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeBVB4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:49 -0500
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, arnd@arndb.de
Subject: [PATCH v12 12/22] selftests/vm: generic cleanup
Date: Wed, 21 Feb 2018 17:55:31 -0800
Message-Id: <1519264541-7621-13-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064411823518229?=
X-GMAIL-MSGID: =?utf-8?q?1593064411823518229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cleanup the code to satisfy coding styles.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   81 ++++++++++++++------------
 1 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 6054093..6fdd8f5 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -4,7 +4,7 @@
  *
  * There are examples in here of:
  *  * how to set protection keys on memory
- *  * how to set/clear bits in pkey registers (the rights register)
+ *  * how to set/clear bits in Protection Key registers (the rights register)
  *  * how to handle SEGV_PKUERR signals and extract pkey-relevant
  *    information from the siginfo
  *
@@ -13,13 +13,18 @@
  *	prefault pages in at malloc, or not
  *	protect MPX bounds tables with protection keys?
  *	make sure VMA splitting/merging is working correctly
- *	OOMs can destroy mm->mmap (see exit_mmap()), so make sure it is immune to pkeys
- *	look for pkey "leaks" where it is still set on a VMA but "freed" back to the kernel
- *	do a plain mprotect() to a mprotect_pkey() area and make sure the pkey sticks
+ *	OOMs can destroy mm->mmap (see exit_mmap()),
+ *			so make sure it is immune to pkeys
+ *	look for pkey "leaks" where it is still set on a VMA
+ *			 but "freed" back to the kernel
+ *	do a plain mprotect() to a mprotect_pkey() area and make
+ *			 sure the pkey sticks
  *
  * Compile like this:
- *	gcc      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
- *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
+ *	gcc      -o protection_keys    -O2 -g -std=gnu99
+ *			 -pthread -Wall protection_keys.c -lrt -ldl -lm
+ *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99
+ *			 -pthread -Wall protection_keys.c -lrt -ldl -lm
  */
 #define _GNU_SOURCE
 #include <errno.h>
@@ -251,26 +256,11 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	dprintf1("signal pkey_reg from  pkey_reg: %016lx\n", __rdpkey_reg());
 	dprintf1("pkey from siginfo: %jx\n", siginfo_pkey);
 	*(u64 *)pkey_reg_ptr = 0x00000000;
-	dprintf1("WARNING: set PRKU=0 to allow faulting instruction to continue\n");
+	dprintf1("WARNING: set PKEY_REG=0 to allow faulting instruction "
+			"to continue\n");
 	pkey_faults++;
 	dprintf1("<<<<==================================================\n");
 	return;
-	if (trapno == 14) {
-		fprintf(stderr,
-			"ERROR: In signal handler, page fault, trapno = %d, ip = %016lx\n",
-			trapno, ip);
-		fprintf(stderr, "si_addr %p\n", si->si_addr);
-		fprintf(stderr, "REG_ERR: %lx\n",
-				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
-		exit(1);
-	} else {
-		fprintf(stderr, "unexpected trap %d! at 0x%lx\n", trapno, ip);
-		fprintf(stderr, "si_addr %p\n", si->si_addr);
-		fprintf(stderr, "REG_ERR: %lx\n",
-				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
-		exit(2);
-	}
-	dprint_in_signal = 0;
 }
 
 int wait_all_children(void)
@@ -415,7 +405,7 @@ void pkey_disable_set(int pkey, int flags)
 {
 	unsigned long syscall_flags = 0;
 	int ret;
-	int pkey_rights;
+	u32 pkey_rights;
 	pkey_reg_t orig_pkey_reg = rdpkey_reg();
 
 	dprintf1("START->%s(%d, 0x%x)\n", __func__,
@@ -453,7 +443,7 @@ void pkey_disable_clear(int pkey, int flags)
 {
 	unsigned long syscall_flags = 0;
 	int ret;
-	int pkey_rights = pkey_get(pkey, syscall_flags);
+	u32 pkey_rights = pkey_get(pkey, syscall_flags);
 	pkey_reg_t orig_pkey_reg = rdpkey_reg();
 
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
@@ -516,9 +506,10 @@ int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 	return sret;
 }
 
-int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
+int sys_pkey_alloc(unsigned long flags, u64 init_val)
 {
 	int ret = syscall(SYS_pkey_alloc, flags, init_val);
+
 	dprintf1("%s(flags=%lx, init_val=%lx) syscall ret: %d errno: %d\n",
 			__func__, flags, init_val, ret, errno);
 	return ret;
@@ -542,7 +533,7 @@ void pkey_set_shadow(u32 key, u64 init_val)
 int alloc_pkey(void)
 {
 	int ret;
-	unsigned long init_val = 0x0;
+	u64 init_val = 0x0;
 
 	dprintf1("%s()::%d, pkey_reg: 0x%016lx shadow: %016lx\n", __func__,
 			__LINE__, __rdpkey_reg(), shadow_pkey_reg);
@@ -692,7 +683,9 @@ void record_pkey_malloc(void *ptr, long size)
 		/* every record is full */
 		size_t old_nr_records = nr_pkey_malloc_records;
 		size_t new_nr_records = (nr_pkey_malloc_records * 2 + 1);
-		size_t new_size = new_nr_records * sizeof(struct pkey_malloc_record);
+		size_t new_size = new_nr_records *
+				sizeof(struct pkey_malloc_record);
+
 		dprintf2("new_nr_records: %zd\n", new_nr_records);
 		dprintf2("new_size: %zd\n", new_size);
 		pkey_malloc_records = realloc(pkey_malloc_records, new_size);
@@ -716,9 +709,11 @@ void free_pkey_malloc(void *ptr)
 {
 	long i;
 	int ret;
+
 	dprintf3("%s(%p)\n", __func__, ptr);
 	for (i = 0; i < nr_pkey_malloc_records; i++) {
 		struct pkey_malloc_record *rec = &pkey_malloc_records[i];
+
 		dprintf4("looking for ptr %p at record[%ld/%p]: {%p, %ld}\n",
 				ptr, i, rec, rec->ptr, rec->size);
 		if ((ptr <  rec->ptr) ||
@@ -799,11 +794,13 @@ void setup_hugetlbfs(void)
 	char buf[] = "123";
 
 	if (geteuid() != 0) {
-		fprintf(stderr, "WARNING: not run as root, can not do hugetlb test\n");
+		fprintf(stderr,
+			"WARNING: not run as root, can not do hugetlb test\n");
 		return;
 	}
 
-	cat_into_file(__stringify(GET_NR_HUGE_PAGES), "/proc/sys/vm/nr_hugepages");
+	cat_into_file(__stringify(GET_NR_HUGE_PAGES),
+				"/proc/sys/vm/nr_hugepages");
 
 	/*
 	 * Now go make sure that we got the pages and that they
@@ -824,7 +821,8 @@ void setup_hugetlbfs(void)
 	}
 
 	if (atoi(buf) != GET_NR_HUGE_PAGES) {
-		fprintf(stderr, "could not confirm 2M pages, got: '%s' expected %d\n",
+		fprintf(stderr, "could not confirm 2M pages, got:"
+			       " '%s' expected %d\n",
 			buf, GET_NR_HUGE_PAGES);
 		return;
 	}
@@ -957,6 +955,7 @@ void __save_test_fd(int fd)
 int get_test_read_fd(void)
 {
 	int test_fd = open("/etc/passwd", O_RDONLY);
+
 	__save_test_fd(test_fd);
 	return test_fd;
 }
@@ -998,7 +997,8 @@ void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	int ptr_contents;
 
-	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n", pkey, ptr);
+	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n",
+			 pkey, ptr);
 	rdpkey_reg();
 	pkey_access_deny(pkey);
 	ptr_contents = read_ptr(ptr);
@@ -1120,13 +1120,14 @@ void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
 /* Assumes that all pkeys other than 'pkey' are unallocated */
 void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 {
-	int err;
+	int err = 0;
 	int allocated_pkeys[NR_PKEYS] = {0};
 	int nr_allocated_pkeys = 0;
 	int i;
 
 	for (i = 0; i < NR_PKEYS*2; i++) {
 		int new_pkey;
+
 		dprintf1("%s() alloc loop: %d\n", __func__, i);
 		new_pkey = alloc_pkey();
 		dprintf4("%s()::%d, err: %d pkey_reg: 0x%016lx "
@@ -1134,9 +1135,11 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 			__func__, __LINE__, err, __rdpkey_reg(),
 			shadow_pkey_reg);
 		rdpkey_reg(); /* for shadow checking */
-		dprintf2("%s() errno: %d ENOSPC: %d\n", __func__, errno, ENOSPC);
+		dprintf2("%s() errno: %d ENOSPC: %d\n",
+				__func__, errno, ENOSPC);
 		if ((new_pkey == -1) && (errno == ENOSPC)) {
-			dprintf2("%s() failed to allocate pkey after %d tries\n",
+			dprintf2("%s() failed to allocate pkey "
+					"after %d tries\n",
 				__func__, nr_allocated_pkeys);
 			break;
 		}
@@ -1338,7 +1341,8 @@ void run_tests_once(void)
 		tracing_off();
 		close_test_fds();
 
-		printf("test %2d PASSED (iteration %d)\n", test_nr, iteration_nr);
+		printf("test %2d PASSED (iteration %d)\n",
+				test_nr, iteration_nr);
 		dprintf1("======================\n\n");
 	}
 	iteration_nr++;
@@ -1350,7 +1354,7 @@ int main(void)
 
 	setup_handlers();
 
-	printf("has pku: %d\n", cpu_has_pku());
+	printf("has pkey: %d\n", cpu_has_pku());
 
 	if (!cpu_has_pku()) {
 		int size = PAGE_SIZE;
@@ -1358,7 +1362,8 @@ int main(void)
 
 		printf("running PKEY tests for unsupported CPU/OS\n");
 
-		ptr  = mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+		ptr  = mmap(NULL, size, PROT_NONE,
+				MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 		assert(ptr != (void *)-1);
 		test_mprotect_pkey_on_unsupported_cpu(ptr, 1);
 		exit(0);
-- 
1.7.1

