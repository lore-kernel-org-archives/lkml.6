Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036B220874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrHzwn0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbeLSVea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:34:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38434 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeLSVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so16169127lfg.5;
        Wed, 19 Dec 2018 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=nFnYEqhQKjGId61gpPa5/uxgrXQl8+JI/cWK8VDpS5Y=;
        b=PrHzwn0tF5cZJ8rUcPtjyhBB7fZbNtctJAOvNrx1Oxs6IMttMC5N2zeIsjKNeWRc2R
         Tcb/3vkEBkE2YnLCKxy9k9DbdgE13xmPle3IC+iMSLMIvuyesjXYTBm8xAwyVIa2AGcH
         /beeel78v6AhNyt9ytcSLTURukyHaSXKh/ZGctqzdCRkOSX03aZjHTlPJUUD4eH/jCbA
         x5db8A4YA9MP5Pd45shyIQ4fsqljhgcbJ6WilKnFlCSamAsG00YPl93aOk2b33ZoBRhO
         5vMcOFPsCVitBtYv9jQVk1ZaWS2BCUou741tRiulXeuCPZlWtNKjx/KJnY369bIvBg7O
         zg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=nFnYEqhQKjGId61gpPa5/uxgrXQl8+JI/cWK8VDpS5Y=;
        b=YHhGfWt4JqqI0Ipa/oplbWJj0wiDNtGAEmrUgDfxglj/Ww25rjAHjVu0d8ZdIPfvP9
         qV4gRiGtVi/kTM+aUiZ4BYrl2e9dXyOz05RPr9RmlN3hb+3RutQbAapgzq6k+Bow+HmO
         eBFk4R5tK1EQaYgC5craYp4f1e8nGRGIPD5VJwiD4C+2oy8q4iyZIuZ50jt8bKyS9f4r
         N28nfYfoW+9VUAICyy0Li78jvQPNSdWjUG7ROPtgj+FBa2ZYei087JzDPkdupU4eVI1z
         GVaoUItyZJMTluTmLCpCVNHv7/lXK0ULRPlEGsv37CPnz7j3P5y9mh9iNdJHcQJYdRY3
         jySA==
X-Gm-Message-State: AA+aEWagvfiXSGUNia8WGECR8xRRDvJS/JqauxdI3HIgg/MvBTG+wleq
        m/DRx0fgzq5jNoZG2IL2zHE=
X-Google-Smtp-Source: AFSGD/WDSV/bqitpFVUBqXDWqTMforPVSVFRSbH5BBwX6cUs0/Ablg68IJ90z+EsAlf/wTbs5JI07g==
X-Received: by 2002:a19:a149:: with SMTP id k70mr13332526lfe.5.1545255264592;
        Wed, 19 Dec 2018 13:34:24 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:24 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] IMA: turn ima_policy_flags into __wr_after_init
Date:   Wed, 19 Dec 2018 23:33:37 +0200
Message-Id: <20181219213338.26619-12-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181219213338.26619-1-igor.stoppa@huawei.com>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The policy flags could be targeted by an attacker aiming at disabling IMA,
so that there would be no trace of a file system modification in the
measurement list.

Since the flags can be altered at runtime, it is not possible to make
them become fully read-only, for example with __ro_after_init.

__wr_after_init can still provide some protection, at least against
simple memory overwrite attacks

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 security/integrity/ima/ima.h        | 3 ++-
 security/integrity/ima/ima_init.c   | 5 +++--
 security/integrity/ima/ima_policy.c | 9 +++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cc12f3449a72..297c25f5122e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -24,6 +24,7 @@
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
+#include <linux/prmem.h>
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
@@ -50,7 +51,7 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 #define IMA_TEMPLATE_IMA_FMT "d|n"
 
 /* current content of the policy */
-extern int ima_policy_flag;
+extern int ima_policy_flag __wr_after_init;
 
 /* set during initialization */
 extern int ima_hash_algo;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 59d834219cd6..5f4e13e671bf 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -21,6 +21,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/prmem.h>
 
 #include "ima.h"
 
@@ -98,9 +99,9 @@ void __init ima_load_x509(void)
 {
 	int unset_flags = ima_policy_flag & IMA_APPRAISE;
 
-	ima_policy_flag &= ~unset_flags;
+	wr_assign(ima_policy_flag, ima_policy_flag & ~unset_flags);
 	integrity_load_x509(INTEGRITY_KEYRING_IMA, CONFIG_IMA_X509_PATH);
-	ima_policy_flag |= unset_flags;
+	wr_assign(ima_policy_flag, ima_policy_flag | unset_flags);
 }
 #endif
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7489cb7de6dc..2004de818d92 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -47,7 +47,7 @@
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (FIELD_SIZEOF(struct integrity_iint_cache, measured_pcrs) * 8))
 
-int ima_policy_flag;
+int ima_policy_flag __wr_after_init;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
 
@@ -452,12 +452,13 @@ void ima_update_policy_flag(void)
 
 	list_for_each_entry(entry, ima_rules, list) {
 		if (entry->action & IMA_DO_MASK)
-			ima_policy_flag |= entry->action;
+			wr_assign(ima_policy_flag,
+				  ima_policy_flag | entry->action);
 	}
 
 	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
 	if (!ima_appraise)
-		ima_policy_flag &= ~IMA_APPRAISE;
+		wr_assign(ima_policy_flag, ima_policy_flag & ~IMA_APPRAISE);
 }
 
 static int ima_appraise_flag(enum ima_hooks func)
@@ -574,7 +575,7 @@ void ima_update_policy(void)
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
 
 	if (ima_rules != policy) {
-		ima_policy_flag = 0;
+		wr_assign(ima_policy_flag, 0);
 		ima_rules = policy;
 	}
 	ima_update_policy_flag();
-- 
2.19.1

