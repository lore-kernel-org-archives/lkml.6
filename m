Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909331-2-6957185382908301674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909330; b=B8qiMVh6H4WPhWH5rkMuD2XwkMGMuCn2//q37SY5DgJxmxo
    p+QQXyYxRxPZCblvAbd3/QMTq2nl7D/RBnxnuyyuy/F7s0P1A+0Wv1r2OJRaV5Qr
    adNAVAYfw/LV3OGnxDMyjpDxwbTGgYw8WHDF1myXQng81XOoBT0ctkZoZa/UwCiu
    5S7XM7VbpqoYvxtJKwO/i/Iwk0P7p64q3AKmz7JyukH3NKxI005hobbyK7mWqIUL
    ahXt08of9s3/I5PSn+Rh9cmKkHedUcOEHhs9ersf5ALpEkO3P1uho8Ev3cgFaVcU
    NrrAPjnnOUilO06O/GGg/TT0P+6+lr/zzj67vcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909330;
    bh=HEY4UErd4E33sLr2mfE4fjyOkfyGVz0DVWFLdDXHqoI=; b=az7FXQaKpx5i
    YFRb2pn6e5TEDttNX+grGDuL4+YJZCUgup18N55XBgUjpm1fRCctbcAezDf2s9Gw
    itY3xXScKK94o5cp1+GmiFWGDc5e5F/t31Ma8dLlnBSGblLD0NcD02KqDn1eF5YC
    DYUZV+M7/DKYX0kXmniNUEZcbbHzztTIceK3xJGPZDw/Ca/m1tKjHNHA+rtXF4QQ
    B34lh+c/3YbCssrbBKQc3LOd7VHjs79d8lo1BruXtJMyfwgqgjX30lQOtFKSOUWy
    sMAV9x9dFLHHGL9VJJY5mV1YZGGUQlU1XXl1XbKVfXMREq1y36rKjtQ6LV0kda32
    Cfpmdw1PwQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OsId/04A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YuJJeTxQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OsId/04A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YuJJeTxQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030539AbeCANCG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:02:06 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40265 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030739AbeCANAu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 08:00:50 -0500
X-Google-Smtp-Source: AG47ELvQqnGqop2TBN8hv8AWjq4YbCsz4i+AuqmSvTMEN2TFxuw7Q/KfIRkMsDsPnJ55jXJhZeLDFg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 41/45] firmware/psci: Expose SMCCC version through psci_ops
Date: Thu,  1 Mar 2018 20:54:18 +0800
Message-Id: <1519908862-11425-42-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit e78eef554a91 upstream.

Since PSCI 1.0 allows the SMCCC version to be (indirectly) probed,
let's do that at boot time, and expose the version of the calling
convention as part of the psci_ops structure.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 drivers/firmware/psci.c | 27 +++++++++++++++++++++++++++
 include/linux/psci.h    |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index a49196a..79a48c3 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -61,6 +61,7 @@ bool psci_tos_resident_on(int cpu)
 
 struct psci_operations psci_ops = {
 	.conduit = PSCI_CONDUIT_NONE,
+	.smccc_version = SMCCC_VERSION_1_0,
 };
 
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
@@ -511,6 +512,31 @@ static void __init psci_init_migrate(void)
 	pr_info("Trusted OS resident on physical CPU 0x%lx\n", cpuid);
 }
 
+static void __init psci_init_smccc(void)
+{
+	u32 ver = ARM_SMCCC_VERSION_1_0;
+	int feature;
+
+	feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
+
+	if (feature != PSCI_RET_NOT_SUPPORTED) {
+		u32 ret;
+		ret = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
+		if (ret == ARM_SMCCC_VERSION_1_1) {
+			psci_ops.smccc_version = SMCCC_VERSION_1_1;
+			ver = ret;
+		}
+	}
+
+	/*
+	 * Conveniently, the SMCCC and PSCI versions are encoded the
+	 * same way. No, this isn't accidental.
+	 */
+	pr_info("SMC Calling Convention v%d.%d\n",
+		PSCI_VERSION_MAJOR(ver), PSCI_VERSION_MINOR(ver));
+
+}
+
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
@@ -559,6 +585,7 @@ static int __init psci_probe(void)
 	psci_init_migrate();
 
 	if (PSCI_VERSION_MAJOR(ver) >= 1) {
+		psci_init_smccc();
 		psci_init_cpu_suspend();
 		psci_init_system_suspend();
 	}
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 66ff547..347077c 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -31,6 +31,11 @@ enum psci_conduit {
 	PSCI_CONDUIT_HVC,
 };
 
+enum smccc_version {
+	SMCCC_VERSION_1_0,
+	SMCCC_VERSION_1_1,
+};
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
@@ -41,6 +46,7 @@ struct psci_operations {
 			unsigned long lowest_affinity_level);
 	int (*migrate_info_type)(void);
 	enum psci_conduit conduit;
+	enum smccc_version smccc_version;
 };
 
 extern struct psci_operations psci_ops;
-- 
2.7.4
