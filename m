Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AD0C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CDE217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCwapnbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CDE217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeHEF0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 01:26:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38252 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeHEF0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 01:26:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so5185351pfh.5;
        Sat, 04 Aug 2018 20:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ZF6r9bNjhRtpl7cdP+PHafOqszJX3zIJFSwk4iCGq8=;
        b=JCwapnbBDGofCVbd+M9USzgmxbq4njEZXMUvjxxrIYdoFNJPYrmYUgAMn3hsRgRAt9
         eBsUT7edSTZErkaLuHNDbXDzC/2qcfSUPs9nmKHGo8CYkYoeti5++3grJvpp1jp6ixIN
         Wo3qX3w4ZLRSBFTEOK5iX+0fRCq16cskygq1SvCs4rSDnwGWDCKhkS8qYUmcEGEY1gFW
         5TnccOuzM7nqmwIdjbj6L7AcwI9uHKm3p79zgMwWFjHtYFEO9kC4hlGjPkF/xBuEdCZJ
         xbuiz24dMU9TP69pEnmKdHjU+8j9S4yMUS0aVP2Gk3q3WyCMWclpuaeP+20a6Y6sbaVh
         YbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ZF6r9bNjhRtpl7cdP+PHafOqszJX3zIJFSwk4iCGq8=;
        b=uRPYjK7oHRqhbrSpRJYR4UvMTFx5TjYyYuhKu1aL4SWRe+2LQa6hRu5Je/ESMBdJ9Q
         Jfv8IuEh8rUgcY1BSR01LsmnxKxv+nl4LzLctgl1sxGQHAm7n8uwl4ug0NNB07f7sFcc
         ibfR36lc2tMeHwlyF9C7OpWjxO9q3WwEIXSIZt6M0hsbv3tWUYl5UnQQK8dejJivLxuq
         QoFSrp8Wx9Y4CzTAmnt0M4NvCq34Mu2vuIzZqyZ1VXcR1HpEMJiz56V4otcjEoiaoa/V
         xwbfrBbW7+eXTENUgqEh0EMq+rMHmJC+80iNDsFq+OSHoMiyJH4WGDyTlro2tanFqjnl
         bZBg==
X-Gm-Message-State: AOUpUlGEVlANB4shzTatS6+XWehBrwv5j/Pvd0LmOHVHT7A6IYPuRHq5
        JD4Nt3QOEA/5H8uCLKK1VW15Tqqj
X-Google-Smtp-Source: AAOMgpc9/5Gp7UvzqImpMozODYu297FY4kdukgREeREymplA167y7ovr6nBxsoFHqrWHYZ8T1SMtww==
X-Received: by 2002:a62:4add:: with SMTP id c90-v6mr11356605pfj.23.1533439430356;
        Sat, 04 Aug 2018 20:23:50 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id x87-v6sm15971922pfa.143.2018.08.04.20.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 20:23:49 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 5/6] key: add EFI secure key as a master key type
Date:   Sun,  5 Aug 2018 11:21:18 +0800
Message-Id: <20180805032119.20485-6-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180805032119.20485-1-jlee@suse.com>
References: <20180805032119.20485-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EFI secure key can be a new master key type that it's used for
generate encrypted key.

Compared with trusted key or user key, the advantage of using
EFI master key is that it doesn't need TPM or password from user
space.

As other master key types, keyctl can be used to create new encrypted
key by EFI secure key. Using the "efi:" prefix string with master
key name:

e.g. keyctl add encrypted evm-key "new efi:kmk-efi 32" @u

Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/firmware/efi/efi-secure-key.c    | 21 +++++++++++++++++++++
 include/keys/efi-type.h                  |  7 +++++++
 security/keys/encrypted-keys/encrypted.c | 10 ++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/firmware/efi/efi-secure-key.c b/drivers/firmware/efi/efi-secure-key.c
index 5e72a8c9e13e..aa422ee87f70 100644
--- a/drivers/firmware/efi/efi-secure-key.c
+++ b/drivers/firmware/efi/efi-secure-key.c
@@ -676,6 +676,27 @@ struct key_type key_type_efi = {
 };
 EXPORT_SYMBOL_GPL(key_type_efi);
 
+/*
+ * request_efi_key - request the efi key
+ */
+struct key *request_efi_key(const char *master_desc,
+			    const u8 **master_key, size_t *master_keylen)
+{
+	struct efi_key_payload *epayload;
+	struct key *ekey;
+
+	ekey = request_key(&key_type_efi, master_desc, NULL);
+	if (IS_ERR(ekey))
+		goto error;
+
+	down_read(&ekey->sem);
+	epayload = ekey->payload.data[0];
+	*master_key = epayload->key;
+	*master_keylen = epayload->key_len;
+error:
+	return ekey;
+}
+
 static int __init init_efi_secure_key(void)
 {
 	int ret;
diff --git a/include/keys/efi-type.h b/include/keys/efi-type.h
index 57524b22d42f..bbe649f3eec0 100644
--- a/include/keys/efi-type.h
+++ b/include/keys/efi-type.h
@@ -39,12 +39,19 @@ extern struct key_type key_type_efi;
 #if defined(CONFIG_EFI_SECURE_KEY)
 extern long efi_read_blob(const struct key *key, char __user *buffer,
 			  char *kbuffer, size_t buflen);
+extern struct key *request_efi_key(const char *master_desc,
+			const u8 **master_key, size_t *master_keylen);
 #else
 inline long efi_read_blob(const struct key *key, char __user *buffer,
 			  char *kbuffer, size_t buflen)
 {
 	return 0;
 }
+static inline struct key *request_efi_key(const char *master_desc,
+			const u8 **master_key, size_t *master_keylen)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif
 
 #endif /* _KEYS_EFI_TYPE_H */
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index d92cbf9687c3..b396506afdfc 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -24,6 +24,7 @@
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
+#include <keys/efi-type.h>
 #include <linux/key-type.h>
 #include <linux/random.h>
 #include <linux/rcupdate.h>
@@ -40,6 +41,7 @@
 
 static const char KEY_TRUSTED_PREFIX[] = "trusted:";
 static const char KEY_USER_PREFIX[] = "user:";
+static const char KEY_EFI_PREFIX[] = "efi:";
 static const char hash_alg[] = "sha256";
 static const char hmac_alg[] = "hmac(sha256)";
 static const char blkcipher_alg[] = "cbc(aes)";
@@ -50,6 +52,7 @@ static int blksize;
 
 #define KEY_TRUSTED_PREFIX_LEN (sizeof (KEY_TRUSTED_PREFIX) - 1)
 #define KEY_USER_PREFIX_LEN (sizeof (KEY_USER_PREFIX) - 1)
+#define KEY_EFI_PREFIX_LEN (sizeof (KEY_EFI_PREFIX) - 1)
 #define KEY_ECRYPTFS_DESC_LEN 16
 #define HASH_SIZE SHA256_DIGEST_SIZE
 #define MAX_DATA_SIZE 4096
@@ -142,6 +145,8 @@ static int valid_master_desc(const char *new_desc, const char *orig_desc)
 		prefix_len = KEY_TRUSTED_PREFIX_LEN;
 	else if (!strncmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN))
 		prefix_len = KEY_USER_PREFIX_LEN;
+	else if (!strncmp(new_desc, KEY_EFI_PREFIX, KEY_EFI_PREFIX_LEN))
+		prefix_len = KEY_EFI_PREFIX_LEN;
 	else
 		return -EINVAL;
 
@@ -434,6 +439,11 @@ static struct key *request_master_key(struct encrypted_key_payload *epayload,
 		mkey = request_user_key(epayload->master_desc +
 					KEY_USER_PREFIX_LEN,
 					master_key, master_keylen);
+	} else if (!strncmp(epayload->master_desc, KEY_EFI_PREFIX,
+			    KEY_EFI_PREFIX_LEN)) {
+		mkey = request_efi_key(epayload->master_desc +
+					KEY_EFI_PREFIX_LEN,
+					master_key, master_keylen);
 	} else
 		goto out;
 
-- 
2.13.6

