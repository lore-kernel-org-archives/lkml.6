Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C66DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB0A2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB0A2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHKQEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:04:44 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:42925 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbeHKQEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:04:44 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowABXXpLm5G5bCa9fAA--.130S2;
        Sat, 11 Aug 2018 21:30:18 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC driver
Date:   Sat, 11 Aug 2018 21:30:09 +0800
Message-Id: <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
X-CM-TRANSID: swCowABXXpLm5G5bCa9fAA--.130S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DGr45tw43CF4kGF4xXrb_yoW7Ww1kpr
        WUJFs5Xr1Iqa43Xrn3tr4DXF1fC3Z3JFW7CrsIka1Fyayjva4UuryIyayfZFyUGFykGry2
        ya1rKw4UC3WvyrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUD-B_UUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
vendor checking for Hygon by using the code path of AMD 0x17. Add a
vendor field to struct amd64_pvt and initialize it in per_family_init
for vendor checking.

Also Hygon PCI Device ID DF_F0/DF_F6(0x1460/0x1466) of Host bridges
is needed for edac driver.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/edac/amd64_edac.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/edac/amd64_edac.h |  5 +++++
 drivers/edac/mce_amd.c    | 12 +++++++++++-
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 18aeabb..fb81354 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
 
 	scrubval = scrubrates[i].scrubval;
 
-	if (pvt->fam == 0x17) {
+	if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
 		__f17h_set_scrubval(pvt, scrubval);
 	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
 		f15h_select_dct(pvt, 0);
@@ -273,6 +273,20 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 			scrubval = 0;
 		}
 		break;
+	case 0x18:
+		if (pvt->vendor == X86_VENDOR_HYGON) {
+			amd64_read_pci_cfg(pvt->F6,
+				F17H_SCR_BASE_ADDR, &scrubval);
+			if (scrubval & BIT(0)) {
+				amd64_read_pci_cfg(pvt->F6,
+					F17H_SCR_LIMIT_ADDR, &scrubval);
+				scrubval &= 0xF;
+				scrubval += 0x5;
+			} else {
+				scrubval = 0;
+			}
+			break;
+		}
 
 	default:
 		amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
@@ -1051,6 +1065,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 		else
 			pvt->dram_type = MEM_DDR4;
 		return;
+	case 0x18:
+		if (pvt->vendor == X86_VENDOR_HYGON) {
+			if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
+				pvt->dram_type = MEM_LRDDR4;
+			else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
+				pvt->dram_type = MEM_RDDR4;
+			else
+				pvt->dram_type = MEM_DDR4;
+			return;
+		}
 
 	default:
 		WARN(1, KERN_ERR "%s: Family??? 0x%x\n", __func__, pvt->fam);
@@ -2200,6 +2224,16 @@ static struct amd64_family_type family_types[] = {
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
@@ -3149,6 +3183,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
 	pvt->stepping	= boot_cpu_data.x86_stepping;
 	pvt->model	= boot_cpu_data.x86_model;
+	pvt->vendor	= boot_cpu_data.x86_vendor;
 	pvt->fam	= boot_cpu_data.x86;
 
 	switch (pvt->fam) {
@@ -3192,6 +3227,13 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		pvt->ops	= &family_types[F17_CPUS].ops;
 		break;
 
+	case 0x18:
+		if (pvt->vendor == X86_VENDOR_HYGON) {
+			fam_type	= &family_types[HYGON_F18_CPUS];
+			pvt->ops	= &family_types[HYGON_F18_CPUS].ops;
+			break;
+		}
+
 	default:
 		amd64_err("Unsupported family!\n");
 		return NULL;
@@ -3428,6 +3470,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x17, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_HYGON, 0x18, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1d4b74e..5176b51 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -116,6 +116,9 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
 
+#define PCI_DEVICE_ID_HYGON_18H_DF_F0	0x1460
+#define PCI_DEVICE_ID_HYGON_18H_DF_F6	0x1466
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
 
@@ -328,6 +332,7 @@ struct amd64_pvt {
 	struct pci_dev *F0, *F1, *F2, *F3, *F6;
 
 	u16 mc_node_id;		/* MC index of this MC node */
+	u8 vendor;		/* CPU vendor */
 	u8 fam;			/* CPU family */
 	u8 model;		/* ... model */
 	u8 stepping;		/* ... stepping */
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 2ab4d61..f7adc47 100644
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
@@ -1119,6 +1120,15 @@ static int __init mce_amd_init(void)
 			goto err_out;
 		}
 		break;
+	case 0x18:
+		if (c->x86_vendor == X86_VENDOR_HYGON) {
+			xec_mask = 0x3f;
+			if (!boot_cpu_has(X86_FEATURE_SMCA)) {
+				pr_warn("Decoding supported only on Scalable MCA processors.\n");
+				goto err_out;
+			}
+			break;
+		}
 
 	default:
 		printk(KERN_WARNING "Huh? What family is it: 0x%x?!\n", c->x86);
-- 
2.7.4

