Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-969494-1526507687-2-3839067530096307960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526507686; b=blRsoNszygkwVGmffejApUuNmhLuTXyW1+JJFKMW2tGdoWhXqJ
    8D7n9i/0+6+ZCQmBGKNcKpRpBbKOyr7TAuTair+WSMVhjQ6MnEeIv7AGo2O5rkOH
    yleGhpBSdA3lfC3ubc6H5GmgByfm7PJsQfL74As12sJWEAZgCJ/bZIY5lcVdaznV
    bxGCu2a1jJ8VOiKF3RHgM4FZADE5nvjSlVioW87le2h0tzOiC/Pt/7qUyqBbDid5
    A2fSw+LRGn3wozuyxb1X8PX5WMi6Bk7zPz81tyF8lXqQThbeL7gkm0cCWXXoEEHv
    XYrSe2VL88+9tK8DCHcf50k9wI4iKAWiSqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1526507686; bh=gluO9xm56wQoUWNNJFt1CgPVeK1dAI54YSsfNoOD5xY=; b=Y
    NN/PuJmZH/9ipEbqu1T1jqbdYTWS4iPd0ZPgCn4GVB1ugl6fqnRPAi/nUqmu0g2N
    C34cvswnv8CD7NtVHempLvYm4HYOpMMvH8YD81jEVDBLuaaan15xyCHXiNRGIazc
    NeBPfxUa6uqV5tLzLfcsjrOAxgvRqhZ6fU91Nyjs5kkIONmJPJ6DuvrlgQAjf/Zz
    yddpztoqXX36Mu8mrTg7z2AkCGP1w5HyTq+gHxqE2tOdpKQDwEBoWgAUsOJvor0z
    bffCMSP2GQ88QokNcT6Zfg3qqkzhZ8xlv5J+F7pGn5oR57VlXG2h5YCOL+MgeS7s
    NQUdVpaxrBgE8q0ZdgiqQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxonhyperv.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLLutZ6142YSpZAXtH8jdmSMYuncXBADuiuowfT6LfzCLJ8rkwi1hY4BFcZZdXUYxogm4+KMy/l2Sswp6pOeDBX8s3nej+uAecsdt+5fGpqqqQbAaFpZ
    oANXcwI4TVTNtKlE8wQmHztzr36Y45W0CAF3sSJ8MvH12q+t+HlzPG9FNflTbYBXkM2vRRWAqBCq7rt9i3nz9rSUJGQxCH3FW2chdNBoCvj8O2GecUgdb7F1
    BmI8F/Z/V0H0UD2tmF7bzg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=Yx2x8uTupucfHzSQLogA:9 a=ni4m4Y02Wl-A_A2T:21
    a=-Fp3gnxeFQYJ4ZMZ:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V3 3/5] X86: Hyper-V: Enhanced IPI enlightenment
Date: Wed, 16 May 2018 14:53:32 -0700
Message-Id: <20180516215334.6547-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516215334.6547-1-kys@linuxonhyperv.com>
References: <20180516215144.6481-1-kys@linuxonhyperv.com>
 <20180516215334.6547-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfAy3QvZd4w4jIkqAd1ZeKCCuMSRyUaHdwesQxISM9q0ivjBb7J7KlEX0SFstFHb1Co+N3UjcPR+f10h2OHFexvIIyRMX9qdUNmwa72BNacwsZNB0nlXP
 mUf37MzdwoWq0eG8rytWmL+P29HE3WWXYb0sZ128Q50s5Fg6sIcJo1CeGo3qgRCZ1e+uxZzhQZGBTwV2PtDrOekGzUkFQGpzXYIK//p0KXQRpqvdFhJ7TN9h
 1hanoSkN9n+THFmOgyRPabZs2xYiyGKaO3Do0y5ILZiaVr8hYw95QRfJnxANyYc2e00+ZQlwM1rw51RQaUsZV2xhfRKGmC52+mzNTJ501WHVC+S7p6b+Bk1T
 nUC305fGlV0xSJaoNH3dKaiqEEc2DvTIbGdBnezLcFtz8RJ6ULrLd7RmfIzgnIoKWBgg0kaonUT/lrVkZ79u/9U+AN2kPNWodPr8j4X0VHw+U8Y7n+g8jfM4
 Itzg7/r+AvsbDPe1Bm/JeEvdBJqJqEroihBjyoXRR1YkYGHG88JTzJZFJZ5F2y28uDqrgmV9rqDOOmTqfjdxzziSQOmwhokW10r42WKoDq8XxxalukRyJePS
 514631cxatRGElJURhf6FtvB
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c          | 42 +++++++++++++++++++++++++++++-
 arch/x86/hyperv/mmu.c              |  2 +-
 arch/x86/include/asm/hyperv-tlfs.h | 15 ++++++++++-
 arch/x86/include/asm/mshyperv.h    | 33 +++++++++++++++++++++++
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 3e0de61f1a7c..192b6ad6a361 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -93,6 +93,40 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
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
@@ -110,6 +144,9 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return false;
 
+	if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+		return __send_ipi_mask_ex(mask, vector);
+
 	local_irq_save(flags);
 	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
@@ -193,7 +230,10 @@ static void hv_send_ipi_self(int vector)
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
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
