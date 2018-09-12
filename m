Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA310C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD5F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA+262S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD5F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeILT3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:29:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40523 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILT3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:29:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17-v6so1058073plp.7;
        Wed, 12 Sep 2018 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RaU2Lm3qPGgM5oSBiaN0Efep8ej4d8vTvibllRQBe3Q=;
        b=JA+262S6d+mDcnUb4Hu3hC+wNgwP4idPCuPhwr5xU+4vNlNVvpsODJO+6QJakVJow6
         DtQs3aCYNNtgjXaB8yZBrSZ1rnqNc9EQvdYH9iUL0l7Oa4odDX+wT0jV2jHMppT9+S8W
         Booow4Cr00T3kiJXdu83/6QBCnihm8SBNeL8LMInVMVtrBozRypT7MeuEIJquQPwoMBE
         4HEM42YO8CUwFQy+TTXylT/8tiPvyXqWDGzkq/LoJjXVBA3P4SBKXhY5ixd1Mo2DVIlq
         xAs16P66EXTmyF5TUtlu6qWwn99cAzgYO3Vm/nV9AfUGXNbs9drsp/nj7q/IoPYNAvHh
         Sakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RaU2Lm3qPGgM5oSBiaN0Efep8ej4d8vTvibllRQBe3Q=;
        b=aIU9lik7NxY3uCVkyPh8KFW6laWdxJjabR/wa807PP8/ffTr8SEs1pHAJ459pNExKr
         8kUy/NwCA8/0rzyvQ+fJ2OP3vXHPT8rwB/naV+GdZQkmge2bAo1QdLJ4N0V/3WDah+q3
         zbQvGnI77sbM5ajHQ43xN9dX8Oao4ZMCz/9LHFNyY4QaV11EC+1LC023upJts+5oD4ex
         ifSnSuMQLXzv5NQZzbXeT3OyPgAhYdSVdxJyaDp4wLwhy+bK1EuPDHcsvq5L0cIhTcrv
         p9W5d6E9bF7a3gAxi80pKs7tUqm/tPFvKKOAqcS1IjsvpvzZNzF8hZuXZ3KA4IuNFzN0
         8eQg==
X-Gm-Message-State: APzg51COXSQZBUryGyervYCVvaril45vFlDGEVEcaCkg8HEvG9XJN0ZZ
        6ywthsFgjPYBIu/r8i/qTOo=
X-Google-Smtp-Source: ANB0VdYTaSbrNANw7/w2meweRbqvY8/o/bspb4aLm6HN8xJcHcOv2Wpc0k5Ont08GBFfBlWDyQPz5Q==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13-v6mr2558424pls.139.1536762273058;
        Wed, 12 Sep 2018 07:24:33 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id t9-v6sm2124213pgi.87.2018.09.12.07.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 07:24:32 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 3/5] PM / hibernate: Encrypt snapshot image
Date:   Wed, 12 Sep 2018 22:23:35 +0800
Message-Id: <20180912142337.21955-4-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180912142337.21955-1-jlee@suse.com>
References: <20180912142337.21955-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To protect the secret in memory snapshot image, this patch adds the
logic to encrypt snapshot pages by AES-CTR. Using AES-CTR is because
it's simple, fast and parallelizable. But this patch didn't implement
parallel encryption.

The encrypt key is derived from the snapshot key. And the initialization
vector will be kept in snapshot header for resuming.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 kernel/power/hibernate.c |   8 ++-
 kernel/power/power.h     |   6 ++
 kernel/power/snapshot.c  | 154 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 871a05e4467c..79f4db284126 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -275,10 +275,14 @@ static int create_image(int platform_mode)
 	if (error)
 		return error;
 
+	error = snapshot_prepare_crypto(false, true);
+	if (error)
+		goto finish_hash;
+
 	error = dpm_suspend_end(PMSG_FREEZE);
 	if (error) {
 		pr_err("Some devices failed to power down, aborting hibernation\n");
-		goto finish_hash;
+		goto finish_crypto;
 	}
 
 	error = platform_pre_snapshot(platform_mode);
@@ -335,6 +339,8 @@ static int create_image(int platform_mode)
 	dpm_resume_start(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 
+ finish_crypto:
+	snapshot_finish_crypto();
  finish_hash:
 	snapshot_finish_hash();
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index c614b0a294e3..41263fdd3a54 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -5,6 +5,7 @@
 #include <linux/freezer.h>
 #include <linux/compiler.h>
 #include <crypto/sha.h>
+#include <crypto/aes.h>
 
 /* The max size of encrypted key blob */
 #define KEY_BLOB_BUFF_LEN 512
@@ -24,6 +25,7 @@ struct swsusp_info {
 	unsigned long		pages;
 	unsigned long		size;
 	unsigned long		trampoline_pfn;
+	u8			iv[AES_BLOCK_SIZE];
 	u8			signature[SNAPSHOT_DIGEST_SIZE];
 } __aligned(PAGE_SIZE);
 
@@ -44,6 +46,8 @@ extern void __init hibernate_image_size_init(void);
 #ifdef CONFIG_HIBERNATION_ENC_AUTH
 /* kernel/power/snapshot.c */
 extern int snapshot_image_verify_decrypt(void);
+extern int snapshot_prepare_crypto(bool may_sleep, bool create_iv);
+extern void snapshot_finish_crypto(void);
 extern int snapshot_prepare_hash(bool may_sleep);
 extern void snapshot_finish_hash(void);
 /* kernel/power/snapshot_key.c */
@@ -53,6 +57,8 @@ extern int snapshot_get_auth_key(u8 *auth_key, bool may_sleep);
 extern int snapshot_get_enc_key(u8 *enc_key, bool may_sleep);
 #else
 static inline int snapshot_image_verify_decrypt(void) { return 0; }
+static inline int snapshot_prepare_crypto(bool may_sleep, bool create_iv) { return 0; }
+static inline void snapshot_finish_crypto(void) {}
 static inline int snapshot_prepare_hash(bool may_sleep) { return 0; }
 static inline void snapshot_finish_hash(void) {}
 static inline int snapshot_key_init(void) { return 0; }
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 949542ed5ffe..c9a6e4983571 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -41,7 +41,11 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 #ifdef CONFIG_HIBERNATION_ENC_AUTH
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+#include <crypto/aes.h>
 #include <crypto/hash.h>
+#include <crypto/skcipher.h>
 #endif
 
 #include "power.h"
@@ -1412,6 +1416,127 @@ static unsigned int nr_copy_pages;
 static void **h_buf;
 
 #ifdef CONFIG_HIBERNATION_ENC_AUTH
+static struct skcipher_request *sk_req;
+static u8 iv[AES_BLOCK_SIZE];
+static void *c_buffer;
+
+static void init_iv(struct swsusp_info *info)
+{
+	memcpy(info->iv, iv, AES_BLOCK_SIZE);
+}
+
+static void load_iv(struct swsusp_info *info)
+{
+	memcpy(iv, info->iv, AES_BLOCK_SIZE);
+}
+
+int snapshot_prepare_crypto(bool may_sleep, bool create_iv)
+{
+	char enc_key[DERIVED_KEY_SIZE];
+	struct crypto_skcipher *tfm;
+	int ret = 0;
+
+	ret = snapshot_get_enc_key(enc_key, may_sleep);
+	if (ret) {
+		pr_warn_once("enc key is invalid\n");
+		return -EINVAL;
+	}
+
+	c_buffer = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!c_buffer) {
+		pr_err("Allocate crypto buffer page failed\n");
+		return -ENOMEM;
+	}
+
+	tfm = crypto_alloc_skcipher("ctr(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		pr_err("failed to allocate skcipher (%d)\n", ret);
+		goto alloc_fail;
+	}
+
+	ret = crypto_skcipher_setkey(tfm, enc_key, AES_MAX_KEY_SIZE);
+	if (ret) {
+		pr_err("failed to setkey (%d)\n", ret);
+		goto set_fail;
+	}
+
+	sk_req = skcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!sk_req) {
+		pr_err("failed to allocate request\n");
+		ret = -ENOMEM;
+		goto set_fail;
+	}
+	if (may_sleep)
+		skcipher_request_set_callback(sk_req, CRYPTO_TFM_REQ_MAY_SLEEP,
+						NULL, NULL);
+	if (create_iv)
+		get_random_bytes(iv, AES_BLOCK_SIZE);
+
+	return 0;
+
+set_fail:
+	crypto_free_skcipher(tfm);
+alloc_fail:
+	__free_page(c_buffer);
+
+	return ret;
+}
+
+void snapshot_finish_crypto(void)
+{
+	struct crypto_skcipher *tfm;
+ 
+	if (!sk_req)
+		return;
+
+	tfm = crypto_skcipher_reqtfm(sk_req);
+	skcipher_request_zero(sk_req);
+	skcipher_request_free(sk_req);
+	crypto_free_skcipher(tfm);
+	__free_page(c_buffer);
+	sk_req = NULL;
+}
+
+static int encrypt_data_page(void *hash_buffer)
+{
+	struct scatterlist src[1], dst[1];
+	u8 iv_tmp[AES_BLOCK_SIZE];
+	int ret = 0;
+
+	if (!sk_req)
+		return 0;
+
+	memcpy(iv_tmp, iv, sizeof(iv));
+	sg_init_one(src, hash_buffer, PAGE_SIZE);
+	sg_init_one(dst, c_buffer, PAGE_SIZE);
+	skcipher_request_set_crypt(sk_req, src, dst, PAGE_SIZE, iv_tmp);
+	ret = crypto_skcipher_encrypt(sk_req);
+
+	copy_page(hash_buffer, c_buffer);
+	memset(c_buffer, 0, PAGE_SIZE);
+
+	return ret;
+}
+
+static int decrypt_data_page(void *encrypted_page)
+{
+	struct scatterlist src[1], dst[1];
+	u8 iv_tmp[AES_BLOCK_SIZE];
+	int ret = 0;
+
+	memcpy(iv_tmp, iv, sizeof(iv));
+	sg_init_one(src, encrypted_page, PAGE_SIZE);
+	sg_init_one(dst, c_buffer, PAGE_SIZE);
+	skcipher_request_set_crypt(sk_req, src, dst, PAGE_SIZE, iv_tmp);
+	ret = crypto_skcipher_decrypt(sk_req);
+
+	copy_page(encrypted_page, c_buffer);
+	memset(c_buffer, 0, PAGE_SIZE);
+
+	return ret;
+}
+
 /*
  * Signature of snapshot image
  */
@@ -1507,22 +1632,30 @@ int snapshot_image_verify_decrypt(void)
 	if (ret || !s4_verify_desc)
 		goto error_prep;
 
+	ret = snapshot_prepare_crypto(true, false);
+	if (ret)
+		goto error_prep;
+
 	for (i = 0; i < nr_copy_pages; i++) {
 		ret = crypto_shash_update(s4_verify_desc, *(h_buf + i), PAGE_SIZE);
 		if (ret)
-			goto error_shash;
+			goto error_shash_crypto;
+		ret = decrypt_data_page(*(h_buf + i));
+		if (ret)
+			goto error_shash_crypto;
 	}
 
 	ret = crypto_shash_final(s4_verify_desc, s4_verify_digest);
 	if (ret)
-		goto error_shash;
+		goto error_shash_crypto;
 
 	pr_debug("Signature %*phN\n", SNAPSHOT_DIGEST_SIZE, signature);
 	pr_debug("Digest    %*phN\n", SNAPSHOT_DIGEST_SIZE, s4_verify_digest);
 	if (memcmp(signature, s4_verify_digest, SNAPSHOT_DIGEST_SIZE))
 		ret = -EKEYREJECTED;
 
- error_shash:
+ error_shash_crypto:
+	snapshot_finish_crypto();
 	snapshot_finish_hash();
 
  error_prep:
@@ -1563,6 +1696,17 @@ __copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 			crypto_buffer = page_address(d_page);
 		}
 
+		/* Encrypt hashed page */
+		encrypt_data_page(crypto_buffer);
+
+		/* Copy encrypted buffer to destination page in high memory */
+		if (PageHighMem(d_page)) {
+			void *kaddr = kmap_atomic(d_page);
+
+			copy_page(kaddr, crypto_buffer);
+			kunmap_atomic(kaddr);
+		}
+
 		/* Generate digest */
 		if (!s4_verify_desc)
 			continue;
@@ -1637,6 +1781,8 @@ __copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 }
 
 static inline void alloc_h_buf(void) {}
+static inline void init_iv(struct swsusp_info *info) {}
+static inline void load_iv(struct swsusp_info *info) {}
 static inline void init_signature(struct swsusp_info *info) {}
 static inline void load_signature(struct swsusp_info *info) {}
 static inline void init_sig_verify(struct trampoline *t) {}
@@ -2285,6 +2431,7 @@ static int init_header(struct swsusp_info *info)
 	info->size = info->pages;
 	info->size <<= PAGE_SHIFT;
 	info->trampoline_pfn = page_to_pfn(virt_to_page(trampoline_virt));
+	init_iv(info);
 	init_signature(info);
 	return init_header_complete(info);
 }
@@ -2523,6 +2670,7 @@ static int load_header(struct swsusp_info *info)
 		nr_copy_pages = info->image_pages;
 		nr_meta_pages = info->pages - info->image_pages - 1;
 		trampoline_pfn = info->trampoline_pfn;
+		load_iv(info);
 		load_signature(info);
 	}
 	return error;
-- 
2.13.6

