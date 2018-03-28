Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2270871-1522242419-2-13720864200434166801
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522242419; b=C2OygCTPalQtC5L8xs3+8rcHuMkNDN1LLmgpeywTPGWHD7f
    RQ5c8lMcKROIX/BS9VY+5bHJ9ZT773+XMC6EQxo3LmHppogEveUU2So+a6rXQnBu
    77tr3p+kccFCtMTsUAt0HiFTMI7qckB3fS+QgudP+iJpFfipvn2pJVt32RaWuM+x
    WdNg7tMtpelX4xcLpJG/CE/QA3i/a9KyLasH0De7xMvpmXFzZHvcFy9tyW1W841r
    a/UltnpUOWK3yLGUxlYZ5FaZ7JXoIaNGKmz/ZQzwS8/AY4S+USVwJeoaojofUyCo
    3d0CVR6CUiBR1a7JR2PSUl9Ba3xg/vFnnruezSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522242419;
    bh=I7uexv43KeJZEJ1ce0QV/y/b0+3lOUchZs2NgZcgxRs=; b=OfG0YkIX+yRm
    zo1f5kHtAkU3gq6IEpL/Q1Vgrs9BNoOJzW/CVmzQ8hTaSHG1Yb5HqEPGK2klFN3/
    MVbunN8vmsDcT9E2h9l070UUFY8aSWznIyiQUb1fO8m/Mvg3/BKLhARMGe4T0y65
    +YbhTaXcVtOWu0IqZE4H1xi93YbtOprTqYeaeR9LbBcTw04xMY/Snk/nWqAk8Cdn
    6VBZbLg9J8PXJE3hgX+5tTsBNSHvZIsipFs7oCcMm7rJMB50W6a+FLZ08nQ3qAB9
    LDKFE3RP6/NTN3Rs9Pivziuqe4V9YIsrV8GT1ZKwTiBcHt1MLb94E/gp4TSOip4H
    kD+dCGkC2w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cavium.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wb5brzBa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cavium.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cavium.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wb5brzBa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cavium.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBAJUixLPI6aPGa/uqq3m6Kd58Dbdlx9Jwn8hlhXYz5z6VYmUXA9ijYAXQme8dxoQUT3vK5BKfSHH8C/fZpgAWhFTNg1Rc8z4uckxh5vQ/DAhPfIBYLZ
    M9xvbM7M5UY3gy8801EjEYQYDAz1UYbrSEHwVIapaULC63SXKc6gfS9ArwfQkTZKzfIRlNw+93OlqdvbSFSVe/xRZGPJDmxf8EmFy5ATxulwHFURAgbl5SsR
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=zAyngx5bAAAA:8
    a=VwQbUJbxAAAA:8 a=pivBIqmD17lqHx8roB8A:9 a=4LA4qAFo6bo561LpWNDU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeC1NGq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 09:06:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36937 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbeC1NGo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 09:06:44 -0400
X-Google-Smtp-Source: AIpwx4/Q0a8Azhyr7Nd5NBBKLCa7SwGhfoMWnGvOJ5bxL9jlw6hNFwQaa4VKg5luxm878b2dsLZ1uQ==
From: Jan Glauber <jglauber@cavium.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mahipal Challa <Mahipal.Challa@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 2/2] crypto: thunderx_zip: Limit result reading attempts
Date: Wed, 28 Mar 2018 15:05:57 +0200
Message-Id: <20180328130557.10560-2-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328130557.10560-1-jglauber@cavium.com>
References: <20180328130557.10560-1-jglauber@cavium.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After issuing a request an endless loop was used to read the
completion state from memory which is asynchronously updated
by the ZIP coprocessor.

Add an upper bound to the retry attempts to prevent a CPU getting stuck
forever in case of an error. Additionally, add a read memory barrier
and a small delay between the reading attempts.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Reviewed-by: Robert Richter <rrichter@cavium.com>
Cc: stable <stable@vger.kernel.org> # 4.14
---
 drivers/crypto/cavium/zip/common.h      | 22 ++++++++++++++++++++++
 drivers/crypto/cavium/zip/zip_deflate.c |  4 ++--
 drivers/crypto/cavium/zip/zip_inflate.c |  4 ++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/zip/common.h b/drivers/crypto/cavium/zip/common.h
index dc451e0..9067451 100644
--- a/drivers/crypto/cavium/zip/common.h
+++ b/drivers/crypto/cavium/zip/common.h
@@ -46,8 +46,10 @@
 #ifndef __COMMON_H__
 #define __COMMON_H__
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -149,6 +151,26 @@ struct zip_operation {
 	u32   sizeofzops;
 };
 
+#define ZIP_POLL_DELAY 20 /* microseconds */
+#define ZIP_POLL_TIMEOUT (msecs_to_jiffies(1000))
+
+static inline int zip_poll_result(union zip_zres_s *result)
+{
+	u64 end = get_jiffies_64() + ZIP_POLL_TIMEOUT;
+
+	while (!result->s.compcode) {
+		/*
+		 * Force re-reading of compcode which is updated
+		 * by the ZIP coprocessor.
+		 */
+		rmb();
+		if (time_after64(get_jiffies_64(), end))
+			return -ETIMEDOUT;
+		usleep_range(ZIP_POLL_DELAY / 2, ZIP_POLL_DELAY);
+	}
+	return 0;
+}
+
 /* error messages */
 #define zip_err(fmt, args...) pr_err("ZIP ERR:%s():%d: " \
 			      fmt "\n", __func__, __LINE__, ## args)
diff --git a/drivers/crypto/cavium/zip/zip_deflate.c b/drivers/crypto/cavium/zip/zip_deflate.c
index 9a944b8..d7133f8 100644
--- a/drivers/crypto/cavium/zip/zip_deflate.c
+++ b/drivers/crypto/cavium/zip/zip_deflate.c
@@ -129,8 +129,8 @@ int zip_deflate(struct zip_operation *zip_ops, struct zip_state *s,
 	/* Stats update for compression requests submitted */
 	atomic64_inc(&zip_dev->stats.comp_req_submit);
 
-	while (!result_ptr->s.compcode)
-		continue;
+	/* Wait for completion or error */
+	zip_poll_result(result_ptr);
 
 	/* Stats update for compression requests completed */
 	atomic64_inc(&zip_dev->stats.comp_req_complete);
diff --git a/drivers/crypto/cavium/zip/zip_inflate.c b/drivers/crypto/cavium/zip/zip_inflate.c
index 50cbdd8..7e0d73e 100644
--- a/drivers/crypto/cavium/zip/zip_inflate.c
+++ b/drivers/crypto/cavium/zip/zip_inflate.c
@@ -143,8 +143,8 @@ int zip_inflate(struct zip_operation *zip_ops, struct zip_state *s,
 	/* Decompression requests submitted stats update */
 	atomic64_inc(&zip_dev->stats.decomp_req_submit);
 
-	while (!result_ptr->s.compcode)
-		continue;
+	/* Wait for completion or error */
+	zip_poll_result(result_ptr);
 
 	/* Decompression requests completed stats update */
 	atomic64_inc(&zip_dev->stats.decomp_req_complete);
-- 
2.7.4
