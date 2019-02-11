Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784A6C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423FE21934
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI2AisEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfBKX2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55653 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfBKX2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so991238wmh.5;
        Mon, 11 Feb 2019 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=VlNzKepo585QEAzr1PoW4dWwLybStReaiWjN7bcxj8g=;
        b=BI2AisEr9GW64YlypsEsgzISrsfXnzkEjXKfspuUjubyPjQUZeYyTJsNWfamyXpj28
         CgpAScsAf8IZ1P4wcgWzrKhfDOZpJKvDiiSA1Gv0AKtGLp9Pr7+QJvlRkwrHQydw9YXJ
         ras/v8CRf+ug8I2VtFx/txAEkoyDb2GFIydZ3Z70vOkH6vXAgc7rcUYlKmbRJDUojLE6
         EPEbI25rqik5A1usnzwzAAmQfHxjH/Rhl6eR8jA4jOBebaR4/w8+alWM05wleyXmZdc4
         ENHs8fK+3TEpKW3p/CyPVjpuBNdt/+LnYDPo5TCRizbKgOHwgwBB6g4/ozhOWVUJc6am
         cN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=VlNzKepo585QEAzr1PoW4dWwLybStReaiWjN7bcxj8g=;
        b=ocRYv/c9s55YI6f4JQP1EuaeGeEhpRAmQ5Xmojw5iAWOFMnURIRnxi3TmnYP3JC7eq
         zetGSy4Ld8VOeO7MemRbfhmcyZaDHEKraej/Wj26GQhcOUZi4gA7TweWOuML5sdvdfpp
         HMayOam2AzEufYT592Ca3GPvUneNwyfPXu/nC+GdqAeJIRaC58fWLHPhKZTG3gZAh9K0
         Av+WgfQFG6xQkEzBfp7tW+RCLCqttlfuLcmcoC7EsPqMvrx/ocMuREn8UXz2GroGWn18
         AuY5MaqAXA37QqIyJ0/cJWygzFqD5e/jJEP9sGWQOGmj6rUVU7kXx/8VZi0YwQjqFaUF
         QGfw==
X-Gm-Message-State: AHQUAuaX01Q80Z+X8ZsSGj9NyPZMvvbSia9c9i4niJbZJRVhNLTKjJqp
        iCPwSNwgLnhFDapjqji/NHk=
X-Google-Smtp-Source: AHgI3IYAStsHXTbFOi9toTUJa7sYc2xWbjGcnPdHeaXJGeDxn/CbffDpZEeCBK0xVjj3LAdOW97ZlA==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr528939wmh.18.1549927724197;
        Mon, 11 Feb 2019 15:28:44 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:43 -0800 (PST)
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
Subject: [RFC PATCH v4 12/12] IMA: turn ima_policy_flags into __wr_after_init
Date:   Tue, 12 Feb 2019 01:27:49 +0200
Message-Id: <93a44c8854b914fb9558fd37b7c4c9ee6051c20c.1549927666.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
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

