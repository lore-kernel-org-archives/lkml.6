Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CJzCEBLXG1s6JQAAmS7hNA
	; Sat, 09 Jun 2018 13:33:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F465608BA; Sat,  9 Jun 2018 13:33:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C133F6032D;
	Sat,  9 Jun 2018 13:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C133F6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeFINd0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:33:26 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:48137 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753171AbeFINdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:33:23 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowACHfroW1RtbZ1tEBA--.937S2;
        Sat, 09 Jun 2018 21:24:45 +0800 (CST)
From: Pu Wen <puwen@hygon.cn>
To: bp@alien8.de, mchehab@kernel.org, zhangpanyong@hygon.cn
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, peterz@infradead.org,
        tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, trenn@suse.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-x86_64@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH 10/11] driver/edac: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:24:30 +0800
Message-Id: <1528550670-28529-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowACHfroW1RtbZ1tEBA--.937S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1rCF4UZFW5uFy5tFy7ZFb_yoWrAFW8pr
        WUJFsxXrWIqa43JFnYyrWDWFyfC3Z7JFZrK39FkayFvayjqa4UW3s2yFWfAFyUGFykJFW2
        va15Kw4UC3WktFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
        xVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE
        14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUFa0PUUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the EDAC driver support to Hygon Family 18h CPU:
- Add MCE support for Hygon Family 18h.
- Add HYGON_F18_CPUS in amd_families enum to enable Hygon Family 18h support.
- Add HYGON_F18_CPUS in family_types[] to support Hygon Family 18h.
- Add Hygon Family 18h support in determine_memory_type(), per_family_init()
  and scrub rate codes.
- Add X86_VENDOR_HYGON in amd64_cpuids[].

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/edac/amd64_edac.c | 20 +++++++++++++++++++-
 drivers/edac/amd64_edac.h |  4 ++++
 drivers/edac/mce_amd.c    |  4 +++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 329cb96..a2e02c5 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
 
 	scrubval = scrubrates[i].scrubval;
 
-	if (pvt->fam == 0x17) {
+	if (pvt->fam == 0x17 || pvt->fam == 0x18) {
 		__f17h_set_scrubval(pvt, scrubval);
 	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
 		f15h_select_dct(pvt, 0);
@@ -264,6 +264,7 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 		break;
 
 	case 0x17:
+	case 0x18:
 		amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
 		if (scrubval & BIT(0)) {
 			amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
@@ -1044,6 +1045,7 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 		goto ddr3;
 
 	case 0x17:
+	case 0x18:
 		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
 		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
@@ -2200,6 +2202,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_base_addr_to_cs_size,
 		}
 	},
+	[HYGON_F18_CPUS] = {
+		/* Hygon F18h uses the same AMD F17h support */
+		.ctl_name = "Hygon_F18h",
+		.f0_id = PCI_DEVICE_ID_HYGON_18H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_HYGON_18H_DF_F6,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_base_addr_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3192,6 +3204,11 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		pvt->ops	= &family_types[F17_CPUS].ops;
 		break;
 
+	case 0x18:
+		fam_type	= &family_types[HYGON_F18_CPUS];
+		pvt->ops	= &family_types[HYGON_F18_CPUS].ops;
+		break;
+
 	default:
 		amd64_err("Unsupported family!\n");
 		return NULL;
@@ -3428,6 +3445,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x17, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_HYGON, 0x18, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1d4b74e..3dec27d 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -116,6 +116,9 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
 
+#define PCI_DEVICE_ID_HYGON_18H_DF_F0	PCI_DEVICE_ID_AMD_17H_DF_F0
+#define PCI_DEVICE_ID_HYGON_18H_DF_F6	PCI_DEVICE_ID_AMD_17H_DF_F6
+
 /*
  * Function 1 - Address Map
  */
@@ -281,6 +284,7 @@ enum amd_families {
 	F16_CPUS,
 	F16_M30H_CPUS,
 	F17_CPUS,
+	HYGON_F18_CPUS,
 	NUM_FAMILIES,
 };
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 2ab4d61..c605089 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1059,7 +1059,8 @@ static int __init mce_amd_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	if (c->x86_vendor != X86_VENDOR_AMD)
+	if (c->x86_vendor != X86_VENDOR_AMD &&
+	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
 	fam_ops = kzalloc(sizeof(struct amd_decoder_ops), GFP_KERNEL);
@@ -1113,6 +1114,7 @@ static int __init mce_amd_init(void)
 		break;
 
 	case 0x17:
+	case 0x18:
 		xec_mask = 0x3f;
 		if (!boot_cpu_has(X86_FEATURE_SMCA)) {
 			printk(KERN_WARNING "Decoding supported only on Scalable MCA processors.\n");
-- 
2.7.4
