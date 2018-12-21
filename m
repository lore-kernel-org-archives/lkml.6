Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8553C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA8F2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1aWqsy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbeLUSPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:15:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34100 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404397AbeLUSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:15:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so4554200lfc.1;
        Fri, 21 Dec 2018 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=9kpmCY6dszhDuHojBIZmAzgP6TFY8woIDvUXpPQug1w=;
        b=i1aWqsy0VvtYOOA+H+FaFy454gTvRTd9toczqI+B2j3w8dJaT6MdrohN2Nucdkx2uT
         O7heRehVrBUK1v8nRNP7Qq9H8Hm1aZI05b3pvICKey+/lupkRDm0HDM02tGB+gdbYQ2H
         QkchLfTMTMrz8CoF5dWFSFNhGcidh1S2e9bKy8KBN+sBGQrfCN/Culgu41PU1KSjx4pC
         1PwMUt1P5owoEyJQGQUJa2a1XdLa6n6vqGFNYWOMHkP/0R6R7QYRclERrymq615h3mVP
         zzjrHTxZh+NZNwUtU17p0X0jbZ0nxaYv7NnWwdHIx+LRUPOg8BzvteriVLu/n62OLVpl
         xZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=9kpmCY6dszhDuHojBIZmAzgP6TFY8woIDvUXpPQug1w=;
        b=am/NtbB1oxRQvJnRXWqyu5h7FQ1jOOm2LKBcFX1E6a8+cfgv3aPYA3GzxP1AKhDqVP
         ptCcdgtv1lmVLME2BGIC3G7OmJWhvkHNHHwhJtVPL1g502ZUEjddzQuxBfzuL3Xy+2Nr
         y+z7xdK/XKo2TaUM9+Kag3IFNTNQBE33Zff7cRbw1WemZ2tzoIHg+doce9zru9F8rxrv
         uXTl0wpgYYqAv0gSXTP8iIFihSwL0Nu1IplyV8rydIo47JXPZO7r9G/5tHmO2IaMw5Dp
         yE9od81dv+UTSR07ord06h73vShLpyM4ZKIa+z03jt/EJTfcA5CvT0TMgNVXDHtZXu7P
         6ybQ==
X-Gm-Message-State: AA+aEWZwjQFXcgRRzHBRxVK7BEWzA8LWu2PsU31nGemPuYwPmWGWLdP3
        wUgB9kbRrVBNV55J3KeQN0E=
X-Google-Smtp-Source: AFSGD/VE3JmdMqhdSd8pGYwVsC5amAsiJm8OyCVcYMpbQ5Os9r4eJcEGMW+sUTS5gk2WY62Z99HL/A==
X-Received: by 2002:a19:3b9c:: with SMTP id d28mr2119418lfl.30.1545416107450;
        Fri, 21 Dec 2018 10:15:07 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:15:06 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] IMA: turn ima_policy_flags into __wr_after_init
Date:   Fri, 21 Dec 2018 20:14:22 +0200
Message-Id: <20181221181423.20455-12-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221181423.20455-1-igor.stoppa@huawei.com>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
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

