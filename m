Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeCUM3p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:29:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37364 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeCUM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:29:39 -0400
X-Google-Smtp-Source: AG47ELtS4ZrUCau1re95Gz4+ifM3k7wlIG3v1fsmUSGCzTyf7nhs0iU2j46K8kGRhssCfE/s+44o6Q==
From: Geliang Tang <geliangtang@gmail.com>
To: Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: rename two compression functions
Date: Wed, 21 Mar 2018 20:29:32 +0800
Message-Id: <67c9e6bce3d13c70954fec17def66fad0d7a822c.1521626569.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com>
References: <9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have following five functions which deal with pstore compression.
This patch renamed two functions to make the names of those functions
consistent:

allocate_buf_for_compression	-> 	pstore_init_compression
free_buf_for_compression	-> 	pstore_free_compression
pstore_choose_compression		pstore_choose_compression
pstore_compress				pstore_compress
pstore_decompress			pstore_decompress

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/pstore/platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 1143ef351c58..03d16b6ed5ec 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -256,7 +256,7 @@ static int pstore_decompress(void *in, void *out,
 	return outlen;
 }
 
-static void allocate_buf_for_compression(void)
+static void pstore_init_compression(void)
 {
 	if (!zbackend)
 		return;
@@ -285,7 +285,7 @@ static void allocate_buf_for_compression(void)
 	}
 }
 
-static void free_buf_for_compression(void)
+static void pstore_free_compression(void)
 {
 	if (!IS_ERR_OR_NULL(tfm))
 		crypto_free_comp(tfm);
@@ -560,7 +560,7 @@ int pstore_register(struct pstore_info *psi)
 		return -EINVAL;
 	}
 
-	allocate_buf_for_compression();
+	pstore_init_compression();
 
 	if (pstore_is_mounted())
 		pstore_get_records(0);
@@ -611,7 +611,7 @@ void pstore_unregister(struct pstore_info *psi)
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		pstore_unregister_kmsg();
 
-	free_buf_for_compression();
+	pstore_free_compression();
 
 	psinfo = NULL;
 	backend = NULL;
-- 
2.14.1
