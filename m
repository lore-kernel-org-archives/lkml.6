Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3741095-1525414180-2-759139262422805405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525414180; b=FAjInR7/alflgBC0HlZH6fY2/3ZSZx7P6E43/B2oAlDuK7UELZ
    gol3ZlXqOxwJeiCLZRrbcULGIrvt5BxZFwsf1UUs1PUF9V/KVd9rA43ZWn/mNjVS
    b/nIpXTZwCLv/7LxORQo5+B0hL75NR0Zf1P4SZSyKXARs/Wa+gjgXqgnliL82Z0v
    RiNeC8E6Paf2HToWqe7wG/+NWkKgdLbZd2SGqBBiPQoF79/yB2m6uDLty+Fe3cNu
    WRppzC5KHVSinRS9sPNrSagv8PdT9qTXJPntZ2UGikV9z55yrDR31OeOgaxmPfHU
    Hyj1/hXZcKoxmxMDfz7ppE1/2Cp21b+6kHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525414180; bh=G7U/CLByeJMrOi+5zXNYUyZrqYKUO2lKfMSd0c9HnBA=; b=Z
    g/+ydxNCarUqBzoIArSF4LICadV+kaplgRChe/XJYttVC9uh2F4cGNnGy52IjL17
    a43uU6gFgNPkgUwl4p11QcG5rhWpR6hIqehbGcBNCsNwsVZ348kuCpwV+9GnpqOo
    DZTsMH13wnVGHvKW95YKbdHmeoqfVWFIQe4H2O4tjTmXEjbaBhyx+r5uwHKp05Ju
    0mPn3hvJ5KMHYUDUzM+qFtYUi7ObEDWQ4wl6u1FawFXv7cpz2yp+XU47pr05xo57
    nAQCz+Qe5N363wXzegV2hEKidixMRd6B1vuy1mWt5tChYl7oThoc2+W/0jc2VfIC
    oV3d91fVD4F/t1D08/L+Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxonhyperv.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB9pM+basX0GZ/nFixhfpbuDDa6/zdb3ODTKS+7Fb1MgHRhCwdfrLQAdD2cZMVzI74KhAb6xaBzSjnhWD5VgfqCHjiSNG0znJwecExNo5fmO4BmtqBnX
    PFkdHBTHnxERAmWyChB+lLdsu0qqS83QAKfFOBSg6jmbIEKNaQt/vMA8oWrxtc0nSCGPH96jgTh1ERQoc4N9px+BZ2DwvxAp71wN4t/hDpyGGNQC7UX+B6bN
    3cvuFmea1sLZOTJPpUSwLw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=Yx2x8uTupucfHzSQLogA:9 a=1mH3txbp0zfulpsW:21
    a=NtzQcHw9mW2MJev1:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V2 3/5] X86: Hyper-V: Enhanced IPI enlightenment
Date: Thu,  3 May 2018 23:08:21 -0700
Message-Id: <20180504060823.3345-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180504060823.3345-1-kys@linuxonhyperv.com>
References: <20180504060653.3240-1-kys@linuxonhyperv.com>
 <20180504060823.3345-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfKaZGpIcRPkEI3q0K+apsAgnPKIpzcm8snjHCaVDqxK4jdhSwjlgHyAMb6K/Me7ByOgcLqdR20g2smWpcalCkCWaMJgxrlzaD7N4EoLvbZ9jDW5dME9w
 EinYlPlMQLzX8QQOGCm7OVqmgoYVxzdNoL9HBT07X6PaondB6Qi/xT596BnSL0KQqziSrtEmh3t1EiJESk/FwhnZA+7pyv8CKL7muElMJNZ+OfPUKeGDoUtl
 INTZUMtyHwfvLW1vkt810StnJCsEM0JV8WiVg8ivglhS5f9E/sWrRTT5H+nVNONf0BlC+ItsSbrDdI+moXqtATVbKBnzP9JVtINTXxIUl+EoUQndavTKeCsu
 faA4OFAKMd5+9rVXnaEgzySVxVkRmOAad2J9TOEd0GxwVCalzbtdAhOd6Fj/1nouS+jOMeWO+6zA4oFvbr5TZ8Y9vcDbGXcLVlc2iwrcR8Pndxl6zT4KsDYa
 kiBPVtTshoBYgM4mYIf+Ei4mZsF+eWWOr9MEjee+JTxgH8BOGOfzSTea1GP2/5FbbCpFOQqkgUv3MmfukcfPnGj7Tc6ycHGObOpaDMYhoeAN75FAhNEfx7lu
 T8hH619+SI5uupFv7r/ZfdI/
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Support enhanced IPI enlightenments (to target more than 64 CPUs).

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c          | 42 +++++++++++++++++++++++++++++++++++++-
 arch/x86/hyperv/mmu.c              |  2 +-
 arch/x86/include/asm/hyperv-tlfs.h | 15 +++++++++++++-
 arch/x86/include/asm/mshyperv.h    | 33 ++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f52d08a7a343..1e269a318c27 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -92,6 +92,40 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
 /*
  * IPI implementation on Hyper-V.
  */
+static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
+{
+	struct ipi_arg_ex **arg;
+	struct ipi_arg_ex *ipi_arg;
+	unsigned long flags;
+	int nr_bank = 0;
+	int ret = 1;
+
+	local_irq_save(flags);
+	arg = (struct ipi_arg_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	ipi_arg = *arg;
+	if (unlikely(!ipi_arg))
+		goto ipi_mask_ex_done;
+
+	ipi_arg->vector = vector;
+	ipi_arg->reserved = 0;
+	ipi_arg->vp_set.valid_bank_mask = 0;
+
+	if (!cpumask_equal(mask, cpu_present_mask)) {
+		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
+	}
+	if (!nr_bank)
+		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
+
+	ret = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
+			      ipi_arg, NULL);
+
+ipi_mask_ex_done:
+	local_irq_restore(flags);
+	return ((ret == 0) ? true : false);
+}
+
 static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	int cur_cpu, vcpu;
@@ -109,6 +143,9 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return false;
 
+	if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+		return __send_ipi_mask_ex(mask, vector);
+
 	local_irq_save(flags);
 	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
@@ -192,7 +229,10 @@ static void hv_send_ipi_self(int vector)
 void __init hv_apic_init(void)
 {
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
-		pr_info("Hyper-V: Using IPI hypercalls\n");
+		if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+			pr_info("Hyper-V: Using ext hypercalls for IPI\n");
+		else
+			pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
 		 * Set the IPI entry points.
 		 */
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 56c9ebac946f..adee39a7a3f2 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -239,7 +239,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.valid_bank_mask = 0;
 
 	if (!cpumask_equal(cpus, cpu_present_mask)) {
-		flush->hv_vp_set.format = HV_GENERIC_SET_SPARCE_4K;
+		flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 		nr_bank = cpumask_to_vp_set(flush, cpus);
 	}
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 332e786d4deb..3bfa92c2793c 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -344,6 +344,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_SEND_IPI				0x000b
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX  0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX   0x0014
+#define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 
@@ -369,7 +370,7 @@ struct hv_tsc_emulation_status {
 #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
 
 enum HV_GENERIC_SET_FORMAT {
-	HV_GENERIC_SET_SPARCE_4K,
+	HV_GENERIC_SET_SPARSE_4K,
 	HV_GENERIC_SET_ALL,
 };
 
@@ -721,4 +722,16 @@ struct ipi_arg_non_ex {
 	u64 cpu_mask;
 };
 
+struct hv_vpset {
+	u64 format;
+	u64 valid_bank_mask;
+	u64 bank_contents[];
+};
+
+struct ipi_arg_ex {
+	u32 vector;
+	u32 reserved;
+	struct hv_vpset vp_set;
+};
+
 #endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 1eff91599c2b..0ee82519957b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -259,6 +259,39 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 	return hv_vp_index[cpu_number];
 }
 
+static inline int cpumask_to_vpset(struct hv_vpset *vpset,
+				    const struct cpumask *cpus)
+{
+	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
+
+	/* valid_bank_mask can represent up to 64 banks */
+	if (hv_max_vp_index / 64 >= 64)
+		return 0;
+
+	/*
+	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
+	 * structs are not cleared between calls, we risk flushing unneeded
+	 * vCPUs otherwise.
+	 */
+	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
+		vpset->bank_contents[vcpu_bank] = 0;
+
+	/*
+	 * Some banks may end up being empty but this is acceptable.
+	 */
+	for_each_cpu(cpu, cpus) {
+		vcpu = hv_cpu_number_to_vp_number(cpu);
+		vcpu_bank = vcpu / 64;
+		vcpu_offset = vcpu % 64;
+		__set_bit(vcpu_offset, (unsigned long *)
+			  &vpset->bank_contents[vcpu_bank]);
+		if (vcpu_bank >= nr_bank)
+			nr_bank = vcpu_bank + 1;
+	}
+	vpset->valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
+	return nr_bank;
+}
+
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void hyper_alloc_mmu(void);
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
