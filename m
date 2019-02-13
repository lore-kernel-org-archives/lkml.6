Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D1E222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRNnYSF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395264AbfBMWmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52435 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395246AbfBMWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4334882wml.2;
        Wed, 13 Feb 2019 14:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=VlNzKepo585QEAzr1PoW4dWwLybStReaiWjN7bcxj8g=;
        b=JRNnYSF0B32te3X75TLvpnSw06mDUcTqBhWDZIT/xl3GaRwWSaGCTspIg/kzoSC5mm
         EIJLk/ST7d7VJB/A/IWScJOvMItHW/x4hC7d4xNYzOWLJuuLPOOwwg3cAigjgyRalxz0
         o1FjUWhH36b3VnsTQ++e+vJ2oAPs+JVpSx4/39KXA29MMIZFPyRSW98b1oILTuP331/O
         6JljWTMeGp9b2/dQxbgg2WwKybBQQakpaTC/1roZtKCBWoRs+heF3eDKU7dEpYaW/etM
         PiQoYjYnLQmSG1dj/GrKYTYg1WSRu4WfGeyapftL6GmbQnrsyURIUMqN/bQDDamRBWb5
         WQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=VlNzKepo585QEAzr1PoW4dWwLybStReaiWjN7bcxj8g=;
        b=bLmLZDTS7LwIbw5g5hqQUyR+6td8dQkqOnka+eOUdDy3MWlzvV3uk2BaTBmZryhlNl
         CD7uIyFhUqPkoHkIEA1O6I3tuBt7k43m4bB0N1dWPM5wxzf+pxEr/mQOFFxj5q1KrYnc
         CdAqwH+T361fhBJOv5EJ6MAv5Ojggka9BTmouPFYxWoaVFVb+UbM61nYZ8l9WW1lo7NE
         Bm/ngidlSNvhLbFwC02Inpo2e+3areovc4Q08tbISy9AAuFhtWIcDFk2p3RYrr0c7/lR
         HY5N+i5ZKANNaqSla5VY/G22JzqoTd6fCUwmC5bWpk6WIb3RFBCnnP4sIYH0WDUN4RzD
         OrQg==
X-Gm-Message-State: AHQUAubeUg3p4dTz6yvoLv/LeZ63fK2qtRyQs8F9X60PXnLr2G2R+vhc
        /TmIQ+gVU5HB+dV7kfkeRo8=
X-Google-Smtp-Source: AHgI3IYWBD6OYKGNIHnWvKT1+X5xZVNe8vjVhHJodT1atGydjrsUyW8KD1kHYHBWgBaVu1rmWrjCdw==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr289249wmi.135.1550097757879;
        Wed, 13 Feb 2019 14:42:37 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:37 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 12/12] IMA: turn ima_policy_flags into __wr_after_init
Date:   Thu, 14 Feb 2019 00:41:41 +0200
Message-Id: <db669d1d6cd5a830ad80d41487608f8b3cc5a05e.1550097697.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550097697.git.igor.stoppa@huawei.com>
References: <cover.1550097697.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 security/integrity/ima/ima.h        | 3 ++-
 security/integrity/ima/ima_policy.c | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

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
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bc8a1c8cb3f..d49c545b9cfb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -48,7 +48,7 @@
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (FIELD_SIZEOF(struct integrity_iint_cache, measured_pcrs) * 8))
 
-int ima_policy_flag;
+int ima_policy_flag __wr_after_init;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
 
@@ -460,12 +460,13 @@ void ima_update_policy_flag(void)
 
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
@@ -651,7 +652,7 @@ void ima_update_policy(void)
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
 
 	if (ima_rules != policy) {
-		ima_policy_flag = 0;
+		wr_assign(ima_policy_flag, 0);
 		ima_rules = policy;
 
 		/*
-- 
2.19.1

