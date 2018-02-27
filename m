Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeB0WCk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:02:40 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41128 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeB0WCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:02:38 -0500
X-Google-Smtp-Source: AG47ELvfMDaOGN4bSFJjYkLBTiH8lJkzBGrXqp4mG4mcxPJPuG9saxtpCjKETXxdNsR5ercCjh2YGw==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: herbert@gondor.apana.org.au, davem@davemloft.net,
        hernan@vanguardiasur.com.ar, steven.lin1@broadcom.com,
        arvind.yadav.cs@gmail.com, colin.king@canonical.com,
        raveendra.padasalagi@broadcom.com, ray.jui@broadcom.com,
        scott.branden@broadcom.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] crypto: bcm: Constify *hash_alg_name[]
Date: Tue, 27 Feb 2018 19:01:27 -0300
Message-Id: <1519768888-19866-3-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519768888-19866-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519768888-19866-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is compile only tested.
No gain from this except some self-documenting.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/crypto/bcm/spu.c | 5 +++--
 drivers/crypto/bcm/spu.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
index efaf3cf..c7bb79e 100644
--- a/drivers/crypto/bcm/spu.c
+++ b/drivers/crypto/bcm/spu.c
@@ -23,8 +23,9 @@
 #include "cipher.h"
 
 /* This array is based on the hash algo type supported in spu.h */
-char *hash_alg_name[] = { "None", "md5", "sha1", "sha224", "sha256", "aes",
-	"sha384", "sha512", "sha3_224", "sha3_256", "sha3_384", "sha3_512" };
+char const * const hash_alg_name[] = { "None", "md5", "sha1", "sha224",
+	"sha256", "aes", "sha384", "sha512", "sha3_224", "sha3_256", "sha3_384",
+	"sha3_512" };
 
 /* Assumes SPU-M messages are in big endian */
 void spum_dump_msg_hdr(u8 *buf, unsigned int buf_len)
diff --git a/drivers/crypto/bcm/spu.h b/drivers/crypto/bcm/spu.h
index f252367..71cf6b5 100644
--- a/drivers/crypto/bcm/spu.h
+++ b/drivers/crypto/bcm/spu.h
@@ -111,7 +111,7 @@ enum aead_type {
 	AEAD_TYPE_LAST
 };
 
-extern char *hash_alg_name[HASH_ALG_LAST];
+extern const char * const hash_alg_name[HASH_ALG_LAST];
 
 struct spu_request_opts {
 	bool is_inbound;
-- 
2.7.4
