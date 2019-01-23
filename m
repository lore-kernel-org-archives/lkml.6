Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9139BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9D720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfAWMBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:01:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbfAWMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:01:55 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NBtLqc179934
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:01:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q6phckgh8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:01:53 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 23 Jan 2019 12:01:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 12:01:49 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0NC1mD66750688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 12:01:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108DE42041;
        Wed, 23 Jan 2019 12:01:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5CC94203F;
        Wed, 23 Jan 2019 12:01:47 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.97.128])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Jan 2019 12:01:47 +0000 (GMT)
Date:   Wed, 23 Jan 2019 13:01:47 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for 5.0 #2
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19012312-0008-0000-0000-000002B4DD2C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012312-0009-0000-0000-000022210D07
Message-Id: <20190123130147.079a7007@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull s390 fixes [and features] for 4.xx

The following changes since commit 1bdbe227492075d058e37cb3d400e6468d0095b5:

  Merge tag 'vfio-v5.0-rc2' of git://github.com/awilliam/linux-vfio (2019-01-10 09:20:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.0-2

for you to fetch changes up to 60f1bf29c0b2519989927cae640cd1f50f59dc7f:

  s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU (2019-01-11 17:12:03 +0100)

----------------------------------------------------------------
s390 update with bug fixes for 5.0-rc4

 - Do not claim to run under z/VM if the hypervisor can not be identified

 - Fix crashes due to outdated ASCEs in CR1

 - Avoid a deadlock in regard to CPU hotplug

 - Really fix the vdso mapping issue for compat tasks

 - Avoid crash on restart due to an incorrect stack address

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/early: improve machine detection

David Hildenbrand (1):
      s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Gerald Schaefer (1):
      s390/smp: fix CPU hotplug deadlock with CPU rescan

Martin Schwidefsky (1):
      s390/mm: always force a load of the primary ASCE on context switch

Vasily Gorbik (1):
      s390/vdso: correct vdso mapping for compat tasks

 arch/s390/include/asm/mmu_context.h |  7 +++----
 arch/s390/kernel/early.c            |  4 ++--
 arch/s390/kernel/setup.c            |  2 ++
 arch/s390/kernel/smp.c              | 11 ++++++++++-
 arch/s390/kernel/vdso.c             |  5 ++---
 drivers/s390/char/sclp_config.c     |  2 ++
 6 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index ccbb53e..8d04e6f 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -25,7 +25,7 @@ static inline int init_new_context(struct task_struct *tsk,
 	atomic_set(&mm->context.flush_count, 0);
 	mm->context.gmap_asce = 0;
 	mm->context.flush_mm = 0;
-	mm->context.compat_mm = 0;
+	mm->context.compat_mm = test_thread_flag(TIF_31BIT);
 #ifdef CONFIG_PGSTE
 	mm->context.alloc_pgste = page_table_allocate_pgste ||
 		test_thread_flag(TIF_PGSTE) ||
@@ -90,8 +90,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	int cpu = smp_processor_id();
 
-	if (prev == next)
-		return;
 	S390_lowcore.user_asce = next->context.asce;
 	cpumask_set_cpu(cpu, &next->context.cpu_attach_mask);
 	/* Clear previous user-ASCE from CR1 and CR7 */
@@ -103,7 +101,8 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		__ctl_load(S390_lowcore.vdso_asce, 7, 7);
 		clear_cpu_flag(CIF_ASCE_SECONDARY);
 	}
-	cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
+	if (prev != next)
+		cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
 }
 
 #define finish_arch_post_lock_switch finish_arch_post_lock_switch
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index af5c2b3..a8c7789 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -63,10 +63,10 @@ static noinline __init void detect_machine_type(void)
 	if (stsi(vmms, 3, 2, 2) || !vmms->count)
 		return;
 
-	/* Running under KVM? If not we assume z/VM */
+	/* Detect known hypervisors */
 	if (!memcmp(vmms->vm[0].cpi, "\xd2\xe5\xd4", 3))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_KVM;
-	else
+	else if (!memcmp(vmms->vm[0].cpi, "\xa9\x61\xe5\xd4", 4))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_VM;
 }
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 72dd23e..7ed90a7 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1006,6 +1006,8 @@ void __init setup_arch(char **cmdline_p)
 		pr_info("Linux is running under KVM in 64-bit mode\n");
 	else if (MACHINE_IS_LPAR)
 		pr_info("Linux is running natively in 64-bit mode\n");
+	else
+		pr_info("Linux is running as a guest in 64-bit mode\n");
 
 	/* Have one command line that is parsed and saved in /proc/cmdline */
 	/* boot_command_line has been already set up in early.c */
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index f82b3d3..b198ece 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -381,8 +381,13 @@ void smp_call_online_cpu(void (*func)(void *), void *data)
  */
 void smp_call_ipl_cpu(void (*func)(void *), void *data)
 {
+	struct lowcore *lc = pcpu_devices->lowcore;
+
+	if (pcpu_devices[0].address == stap())
+		lc = &S390_lowcore;
+
 	pcpu_delegate(&pcpu_devices[0], func, data,
-		      pcpu_devices->lowcore->nodat_stack);
+		      lc->nodat_stack);
 }
 
 int smp_find_processor_id(u16 address)
@@ -1166,7 +1171,11 @@ static ssize_t __ref rescan_store(struct device *dev,
 {
 	int rc;
 
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		return rc;
 	rc = smp_rescan_cpus();
+	unlock_device_hotplug();
 	return rc ? rc : count;
 }
 static DEVICE_ATTR_WO(rescan);
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index ebe748a..4ff3548 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -224,10 +224,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	vdso_pages = vdso64_pages;
 #ifdef CONFIG_COMPAT
-	if (is_compat_task()) {
+	mm->context.compat_mm = is_compat_task();
+	if (mm->context.compat_mm)
 		vdso_pages = vdso32_pages;
-		mm->context.compat_mm = 1;
-	}
 #endif
 	/*
 	 * vDSO has a problem and was disabled, just don't "enable" it for
diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index 194ffd5..039b207 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -60,7 +60,9 @@ static void sclp_cpu_capability_notify(struct work_struct *work)
 
 static void __ref sclp_cpu_change_notify(struct work_struct *work)
 {
+	lock_device_hotplug();
 	smp_rescan_cpus();
+	unlock_device_hotplug();
 }
 
 static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)

