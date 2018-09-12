Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3ADC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD9E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8I5XQ59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD9E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeILT3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:29:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44516 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILT3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:29:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so1087010pff.11;
        Wed, 12 Sep 2018 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b4QbV5/izBBk04/XxTj2GLqtb8eRHVrVbQmwmvpKlrM=;
        b=P8I5XQ59Cta9NCY7QNhBNLZHgqCKQYOwJnYJ2huXOECExAe8HseYyXaRdww+x9s2IU
         FLUzuQ0d/nxj50XVHext6wFe1w2S6paaXnFKCb6ai3g0w9DPHV6lUvfMprlrJEPmjOHP
         yl0017jSZlRuHlSmQnoqFP3zC8mwx44EFEko7vOAs6OPpu36fO0w/eGNO/71ytoqfuri
         MLb3jAuOo+8/G9MsMTvTEQ4+JNDbJBC8RCIyv1ZBQJZY2XMtTMRAJvBQxTXHYehs8zCk
         ffzAF9lA61hy1EKG7Qy/dxMHQ1xaA6BLHoqQsqmRmWiHbzVmoH8VEg7fTtEwj7kv5JEI
         CrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b4QbV5/izBBk04/XxTj2GLqtb8eRHVrVbQmwmvpKlrM=;
        b=LP03HmHoBNvnL9GGCAuRi6MEZFyONXlCakK1k7ixmAtIPl6blpn58O5AqnDomQOzvT
         K1iY8bLgFUQmRixImszncPcszBFsvKmQTDTkwlwcbLHohL9jwGNKUfImkfVUlcwmxrAl
         4ujWZYWJ78Fvs4jirDRJs28iXJq/caRlQUkD0fT4KzsdkHghPX8aoGKjFB43okopRmRp
         HOKodd0ykbBHcYr5AVYP71rElVUiVrH7f+Zdps0f5h7dxbsBtSkhTByBAZJeDMDupGCy
         4NVJtPDOadL7RfF+9RrUNSwyZ5d53xa3yw75WSZ/A9ZNkw72ZeVkaMrOJBYKklkhCt5p
         M5HQ==
X-Gm-Message-State: APzg51DLOe4R7k5g8KE58vBabknMlGIsWDAHw4buYxa/PkVaMzsLrotl
        qTBytCAq6mi6+2IFmkZAE8XcyOKR
X-Google-Smtp-Source: ANB0Vdbyzd2J4pNPYcJahSBeEHXtgIXoAYe8ahTYmlP7dtgwYYHQVSuoCzLJnzr5PCYzaDCSgnzxug==
X-Received: by 2002:a63:9a42:: with SMTP id e2-v6mr2678838pgo.263.1536762279995;
        Wed, 12 Sep 2018 07:24:39 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id t9-v6sm2124213pgi.87.2018.09.12.07.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 07:24:39 -0700 (PDT)
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
Subject: [PATCH 4/5] PM / hibernate: Erase the snapshot master key in snapshot pages
Date:   Wed, 12 Sep 2018 22:23:36 +0800
Message-Id: <20180912142337.21955-5-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180912142337.21955-1-jlee@suse.com>
References: <20180912142337.21955-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the encryption key be guessed then the snapshot master key can
also be grabbed from snapshot image. Which means that the authentication
key can also be calculated. So kernel erases master key in snapshot
pages.

Because the master key in image kernel be erased, kernel uses the
trampoline page to forward snapshot master key to image kernel.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 kernel/power/power.h        |  6 +++++
 kernel/power/snapshot.c     |  5 ++++
 kernel/power/snapshot_key.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 41263fdd3a54..d2fc73b2e200 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -36,6 +36,7 @@ struct swsusp_info {
 struct trampoline {
 	bool snapshot_key_valid;
 	int sig_verify_ret;
+	u8 snapshot_key[SNAPSHOT_KEY_SIZE];
 } __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_HIBERNATION
@@ -55,6 +56,9 @@ extern int snapshot_key_init(void);
 extern bool snapshot_key_initialized(void);
 extern int snapshot_get_auth_key(u8 *auth_key, bool may_sleep);
 extern int snapshot_get_enc_key(u8 *enc_key, bool may_sleep);
+extern void snapshot_key_page_erase(unsigned long pfn, void *buff_addr);
+extern void snapshot_key_trampoline_backup(struct trampoline *t);
+extern void snapshot_key_trampoline_restore(struct trampoline *t);
 #else
 static inline int snapshot_image_verify_decrypt(void) { return 0; }
 static inline int snapshot_prepare_crypto(bool may_sleep, bool create_iv) { return 0; }
@@ -62,6 +66,8 @@ static inline void snapshot_finish_crypto(void) {}
 static inline int snapshot_prepare_hash(bool may_sleep) { return 0; }
 static inline void snapshot_finish_hash(void) {}
 static inline int snapshot_key_init(void) { return 0; }
+static inline void snapshot_key_trampoline_backup(struct trampoline *t) {}
+static inline void snapshot_key_trampoline_restore(struct trampoline *t) {}
 #endif	/* !CONFIG_HIBERNATION_ENC_AUTH */
 
 #ifdef CONFIG_ARCH_HIBERNATION_HEADER
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c9a6e4983571..dd176df75d2b 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1696,6 +1696,9 @@ __copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 			crypto_buffer = page_address(d_page);
 		}
 
+		/* Erase key data in snapshot */
+		snapshot_key_page_erase(pfn, crypto_buffer);
+
 		/* Encrypt hashed page */
 		encrypt_data_page(crypto_buffer);
 
@@ -2481,6 +2484,7 @@ void snapshot_init_trampoline(void)
 	t = (struct trampoline *)trampoline_buff;
 
 	init_sig_verify(t);
+	snapshot_key_trampoline_backup(t);
 
 	pr_info("Hibernation trampoline page prepared\n");
 }
@@ -2504,6 +2508,7 @@ void snapshot_restore_trampoline(void)
 	t = (struct trampoline *)trampoline_virt;
 
 	handle_sig_verify(t);
+	snapshot_key_trampoline_restore(t);
 	snapshot_free_trampoline();
 }
 
diff --git a/kernel/power/snapshot_key.c b/kernel/power/snapshot_key.c
index 091f33929b47..c0f179283f9e 100644
--- a/kernel/power/snapshot_key.c
+++ b/kernel/power/snapshot_key.c
@@ -29,11 +29,26 @@ static struct snapshot_key {
 	const char *key_name;
 	bool initialized;
 	unsigned int key_len;
+	unsigned long pfn;			/* pfn of keyblob */
+	unsigned long addr_offset;		/* offset in page for keyblob */
 	u8 key[SNAPSHOT_KEY_SIZE];
+	u8 fingerprint[SHA512_DIGEST_SIZE];	/* fingerprint of keyblob */
 } skey = {
 	.key_name = "swsusp-kmk",
 };
 
+static void snapshot_key_clean(void)
+{
+	crypto_free_shash(hash_tfm);
+	hash_tfm = NULL;
+	skey.pfn = 0;
+	skey.key_len = 0;
+	skey.addr_offset = 0;
+	memzero_explicit(skey.key, SNAPSHOT_KEY_SIZE);
+	memzero_explicit(skey.fingerprint, SHA512_DIGEST_SIZE);
+	skey.initialized = false;
+}
+
 static int calc_hash(u8 *digest, const u8 *buf, unsigned int buflen,
 		     bool may_sleep)
 {
@@ -74,6 +89,53 @@ static int calc_key_hash(u8 *key, unsigned int key_len, const char *salt,
 	return ret;
 }
 
+static int get_key_fingerprint(u8 *fingerprint, u8 *key, unsigned int key_len,
+				bool may_sleep)
+{
+	return calc_key_hash(key, key_len, "FINGERPRINT", fingerprint, may_sleep);
+}
+
+void snapshot_key_page_erase(unsigned long pfn, void *buff_addr)
+{
+	if (!skey.initialized || pfn != skey.pfn)
+		return;
+
+	/* erase key data from snapshot buffer page */
+	if (!memcmp(skey.key, buff_addr + skey.addr_offset, skey.key_len)) {
+		memzero_explicit(buff_addr + skey.addr_offset, skey.key_len);
+		pr_info("Erased swsusp key in snapshot pages.\n");
+	}
+}
+
+/* this function may sleeps because snapshot_key_init() */
+void snapshot_key_trampoline_backup(struct trampoline *t)
+{
+	if (!t || snapshot_key_init())
+		return;
+
+	memcpy(t->snapshot_key, skey.key, skey.key_len);
+}
+
+/* Be called after snapshot image restored success */
+void snapshot_key_trampoline_restore(struct trampoline *t)
+{
+	u8 fingerprint[SHA512_DIGEST_SIZE];
+
+	if (!skey.initialized || !t)
+		return;
+
+	/* check key fingerprint before restore */
+	get_key_fingerprint(fingerprint, t->snapshot_key, skey.key_len, true);
+	if (memcmp(skey.fingerprint, fingerprint, SHA512_DIGEST_SIZE)) {
+		pr_warn("Restored swsusp key failed, fingerprint mismatch.\n");
+		snapshot_key_clean();
+		return;
+	}
+
+	memcpy(skey.key, t->snapshot_key, skey.key_len);
+	memzero_explicit(t->snapshot_key, SNAPSHOT_KEY_SIZE);
+}
+
 /* Derive authentication/encryption key */
 static int get_derived_key(u8 *derived_key, const char *derived_type_str,
 			   bool may_sleep)
@@ -223,9 +285,13 @@ int snapshot_key_init(void)
 	if (err)
 		goto key_fail;
 
+	skey.pfn = page_to_pfn(virt_to_page(skey.key));
+	skey.addr_offset = (unsigned long) skey.key & ~PAGE_MASK;
+	get_key_fingerprint(skey.fingerprint, skey.key, skey.key_len, true);
 	skey.initialized = true;
 
 	pr_info("Snapshot key is initialled.\n");
+	pr_debug("Fingerprint %*phN\n", SHA512_DIGEST_SIZE, skey.fingerprint);
 
 	return 0;
 
-- 
2.13.6

