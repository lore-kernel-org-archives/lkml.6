Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F680C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D8621A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D8621A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbeHFSwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:52:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732571AbeHFSwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:52:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76GcfB5043372
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 12:42:12 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpsma14my-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:42:12 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rosattig@linux.vnet.ibm.com>;
        Mon, 6 Aug 2018 12:42:11 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 12:42:05 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76Gg4Nd15925678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 16:42:04 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE563112063;
        Mon,  6 Aug 2018 12:41:46 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CD54112064;
        Mon,  6 Aug 2018 12:41:46 -0400 (EDT)
Received: from localhost (unknown [9.80.218.40])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 12:41:46 -0400 (EDT)
From:   "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        agust@denx.de, arnd@arndb.de, mgreer@animalcreek.com,
        linux@roeck-us.net, maurosr@linux.vnet.ibm.com,
        rosattig@linux.vnet.ibm.com, dale@farnsworth.org, hare@suse.de,
        npiggin@gmail.com, christophe.leroy@c-s.fr, tglx@linutronix.de,
        kstewart@linuxfoundation.org, sfr@canb.auug.org.au,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        nfont@linux.vnet.ibm.com, ast@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, daniel@iogearbox.net,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/Makefiles: Convert ifeq to ifdef where possible
Date:   Mon,  6 Aug 2018 13:42:03 -0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18080616-0040-0000-0000-0000045A176C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009496; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070378; UDB=6.00550834; IPR=6.00849595;
 MB=3.00022540; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-06 16:42:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080616-0041-0000-0000-00000861177C
Message-Id: <1533573723-29692-1-git-send-email-rosattig@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060173
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Makefiles if we're testing a CONFIG_FOO symbol for equality with 'y'
we can instead just use ifdef. The latter reads easily, so convert to
it where possible.

Signed-off-by: Rodrigo R. Galvao <rosattig@linux.vnet.ibm.com>
Reviewed-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 arch/powerpc/Makefile                   | 26 +++++++++++++-------------
 arch/powerpc/boot/Makefile              |  2 +-
 arch/powerpc/kernel/Makefile            | 14 ++++++++------
 arch/powerpc/mm/Makefile                |  4 ++--
 arch/powerpc/net/Makefile               |  2 +-
 arch/powerpc/platforms/52xx/Makefile    |  2 +-
 arch/powerpc/platforms/cell/Makefile    |  2 +-
 arch/powerpc/platforms/pseries/Makefile |  2 +-
 arch/powerpc/sysdev/Makefile            |  2 +-
 9 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index fb96206..9aee790 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -36,7 +36,7 @@ else
 KBUILD_DEFCONFIG := ppc64_defconfig
 endif
 
-ifeq ($(CONFIG_PPC64),y)
+ifdef CONFIG_PPC64
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)
 
 ifeq ($(new_nm),y)
@@ -74,7 +74,7 @@ KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
 endif
 endif
 
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS	+= -mlittle-endian
 LDFLAGS		+= -EL
 LDEMULATION	:= lppc
@@ -117,7 +117,7 @@ LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
 LDFLAGS_vmlinux += $(call ld-option,--orphan-handling=warn)
 
-ifeq ($(CONFIG_PPC64),y)
+ifdef CONFIG_PPC64
 ifeq ($(call cc-option-yn,-mcmodel=medium),y)
 	# -mcmodel=medium breaks modules because it uses 32bit offsets from
 	# the TOC pointer to create pointers where possible. Pointers into the
@@ -134,7 +134,7 @@ endif
 endif
 
 CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+ifdef CONFIG_CPU_LITTLE_ENDIAN
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
 else
@@ -148,8 +148,8 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
-ifeq ($(CONFIG_PPC_BOOK3S_64),y)
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+ifdef CONFIG_PPC_BOOK3S_64
+ifdef CONFIG_CPU_LITTLE_ENDIAN
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power8
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power9,-mtune=power8)
 else
@@ -173,7 +173,7 @@ CFLAGS-$(CONFIG_POWER9_CPU) += $(call cc-option,-mcpu=power9)
 CFLAGS-$(CONFIG_PPC_8xx) += $(call cc-option,-mcpu=860)
 
 # Altivec option not allowed with e500mc64 in GCC.
-ifeq ($(CONFIG_ALTIVEC),y)
+ifdef CONFIG_ALTIVEC
 E5500_CPU := -mcpu=powerpc64
 else
 E5500_CPU := $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
@@ -181,8 +181,8 @@ endif
 CFLAGS-$(CONFIG_E5500_CPU) += $(E5500_CPU)
 CFLAGS-$(CONFIG_E6500_CPU) += $(call cc-option,-mcpu=e6500,$(E5500_CPU))
 
-ifeq ($(CONFIG_PPC32),y)
-ifeq ($(CONFIG_PPC_E500MC),y)
+ifdef CONFIG_PPC32
+ifdef CONFIG_PPC_E500MC
 CFLAGS-y += $(call cc-option,-mcpu=e500mc,-mcpu=powerpc)
 else
 CFLAGS-$(CONFIG_E500) += $(call cc-option,-mcpu=8540 -msoft-float,-mcpu=powerpc)
@@ -204,7 +204,7 @@ else
 CHECKFLAGS	+= -D__LITTLE_ENDIAN__
 endif
 
-ifeq ($(CONFIG_476FPE_ERR46),y)
+ifdef CONFIG_476FPE_ERR46
 	KBUILD_LDFLAGS_MODULE += --ppc476-workaround \
 		-T $(srctree)/arch/powerpc/platforms/44x/ppc476_modules.lds
 endif
@@ -231,12 +231,12 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-ifeq ($(CONFIG_6xx),y)
+ifdef CONFIG_6xx
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
 # Work around a gcc code-gen bug with -fno-omit-frame-pointer.
-ifeq ($(CONFIG_FUNCTION_TRACER),y)
+ifdef CONFIG_FUNCTION_TRACER
 KBUILD_CFLAGS		+= -mno-sched-epilog
 endif
 
@@ -381,7 +381,7 @@ install:
 	$(Q)$(MAKE) $(build)=$(boot) install
 
 vdso_install:
-ifeq ($(CONFIG_PPC64),y)
+ifdef CONFIG_PPC64
 	$(Q)$(MAKE) $(build)=arch/$(ARCH)/kernel/vdso64 $@
 endif
 	$(Q)$(MAKE) $(build)=arch/$(ARCH)/kernel/vdso32 $@
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index deea20c..0fb96c2 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -354,7 +354,7 @@ image-$(CONFIG_AMIGAONE)		+= cuImage.amigaone
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
-ifeq ($(CONFIG_PPC32),y)
+ifdef CONFIG_PPC32
 image-$(CONFIG_PPC_PMAC)	+= zImage.coff zImage.miboot
 endif
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b2..7b09182 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -7,10 +7,10 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
-ifeq ($(CONFIG_PPC64),y)
+ifdef CONFIG_PPC64
 CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
 endif
-ifeq ($(CONFIG_PPC32),y)
+ifdef CONFIG_PPC32
 CFLAGS_prom_init.o      += -fPIC
 CFLAGS_btext.o		+= -fPIC
 endif
@@ -62,13 +62,13 @@ obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_FA_DUMP)		+= fadump.o
-ifeq ($(CONFIG_PPC32),y)
+ifdef CONFIG_PPC32
 obj-$(CONFIG_E500)		+= idle_e500.o
 endif
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o
-ifeq ($(CONFIG_FSL_BOOKE),y)
+ifdef CONFIG_FSL_BOOKE
 obj-$(CONFIG_HIBERNATION)	+= swsusp_booke.o
 else
 obj-$(CONFIG_HIBERNATION)	+= swsusp_$(BITS).o
@@ -109,9 +109,11 @@ obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o crash.o \
 				   machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file_$(BITS).o kexec_elf_$(BITS).o
-ifeq ($(CONFIG_HAVE_IMA_KEXEC)$(CONFIG_IMA),yy)
+ifdef CONFIG_HAVE_IMA_KEXEC
+ifdef CONFIG_IMA
 obj-y				+= ima_kexec.o
 endif
+endif
 
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
@@ -164,7 +166,7 @@ PHONY += systbl_chk
 systbl_chk: $(src)/systbl_chk.sh $(obj)/systbl_chk.i
 	$(call cmd,systbl_chk)
 
-ifeq ($(CONFIG_PPC_OF_BOOT_TRAMPOLINE),y)
+ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
 $(obj)/built-in.a:		prom_init_check
 
 quiet_cmd_prom_init_check = CALL    $<
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index f06f357..cdf6a99 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
-ifeq ($(CONFIG_PPC_BOOK3S_64),y)
+ifdef CONFIG_PPC_BOOK3S_64
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
 obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
 endif
@@ -31,7 +31,7 @@ obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-y				+= hugetlbpage.o
-ifeq ($(CONFIG_HUGETLB_PAGE),y)
+ifdef CONFIG_HUGETLB_PAGE
 obj-$(CONFIG_PPC_BOOK3S_64)	+= hugetlbpage-hash64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= hugetlbpage-radix.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= hugetlbpage-book3e.o
diff --git a/arch/powerpc/net/Makefile b/arch/powerpc/net/Makefile
index 809f019..c2dec3a 100644
--- a/arch/powerpc/net/Makefile
+++ b/arch/powerpc/net/Makefile
@@ -2,7 +2,7 @@
 #
 # Arch-specific network modules
 #
-ifeq ($(CONFIG_PPC64),y)
+ifdef CONFIG_PPC64
 obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
 else
 obj-$(CONFIG_BPF_JIT) += bpf_jit_asm.o bpf_jit_comp.o
diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index ff2f86f..f40d48e 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
 obj-$(CONFIG_PPC_MEDIA5200)	+= media5200.o
 
 obj-$(CONFIG_PM)		+= mpc52xx_sleep.o mpc52xx_pm.o
-ifeq ($(CONFIG_PPC_LITE5200),y)
+ifdef CONFIG_PPC_LITE5200
 	obj-$(CONFIG_PM)	+= lite5200_sleep.o lite5200_pm.o
 endif
 
diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index d5f808e..10064a3 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_CBE_CPUFREQ_SPU_GOVERNOR)	+= cpufreq_spudemand.o
 
 obj-$(CONFIG_PPC_IBM_CELL_POWERBUTTON)	+= cbe_powerbutton.o
 
-ifeq ($(CONFIG_SMP),y)
+ifdef CONFIG_SMP
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
 endif
 
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 13eede6..7e89d5c 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -25,6 +25,6 @@ obj-$(CONFIG_LPARCFG)		+= lparcfg.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_IBMEBUS)		+= ibmebus.o
 
-ifeq ($(CONFIG_PPC_PSERIES),y)
+ifdef CONFIG_PPC_PSERIES
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 endif
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index ea2f595..f730539 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 obj-$(CONFIG_PPC_MPC512x)	+= mpc5xxx_clocks.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc5xxx_clocks.o
 
-ifeq ($(CONFIG_SUSPEND),y)
+ifdef CONFIG_SUSPEND
 obj-$(CONFIG_6xx)		+= 6xx-suspend.o
 endif
 
-- 
2.7.4

