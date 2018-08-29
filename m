Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39873C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBEE2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBEE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeH2Qmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:42:52 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:50783 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728144AbeH2Qmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:42:51 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowABHrx56lYZbqan_BA--.104S2;
        Wed, 29 Aug 2018 20:45:50 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, mchehab@kernel.org, mikhail.jin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v5 15/16] driver/edac: enable Hygon support to AMD64 EDAC driver
Date:   Wed, 29 Aug 2018 20:45:45 +0800
Message-Id: <47e08d8bab1cef667be3955941e7eedc23187ae1.1535459013.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1535459012.git.puwen@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
X-CM-TRANSID: swCowABHrx56lYZbqan_BA--.104S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4xXrW3Jry3JryUCFy8Krg_yoWrAry7pr
        WUJFZ3Xr4Iqa43XFnYyrWDXFyfCan7JF9rKr42ka1Yvayjqa4Uua4IyFWfZFy8GFy8JFW2
        va15Kw45C3WktrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbKLvtUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
support for Hygon by using the code path of AMD family 0x17.

As Hygon will negotiate with AMD to make sure that only Hygon will
use family 0x18, under this consideration try to minimize code
modifications and share most codes with AMD.

Also Hygon PCI Device ID DF_F0/DF_F6(0x1460/0x1466) of Host bridges
is needed for edac driver.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/edac/amd64_edac.c | 20 +++++++++++++++++++-
 drivers/edac/amd64_edac.h |  4 ++++
 drivers/edac/mce_amd.c    |  4 +++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 18aeabb..d8b4b0e 100644
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
index 1d4b74e..6e5f609 100644
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

