Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1388873-1523288856-2-907221157898506907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523288856; b=kBqOzGDVXjqwqV8hQ4wTbpRV+x3m8VTscI2afWLghL3okwrFMI
    OmEWmjysaIdgk/5xXGldXR5mwopUzzZuWEi2VhHTT1lpbXVM57EWaoutE2Rfm6MN
    n4/A7DDnkPvI1VD5U4ndZbj1ag3pEQ5R2JBjpDGIsqoxX5nYJzgzGGKWQzIeSgBL
    2Nm/GMS7sRvapiIMub/PNdRZ3wnAAUlzh5tqK1wqxJ/3QxG0khgsr8y5rq6VgedE
    x5PXK2qCrR1fN6oBxiQisb5Z3zEzy4rK7m1Qp9mF9kt/SjNvBJXZjT0pRAgoKwqC
    vjI06GSW8LoJjVgfKoC488Zqbq4Yk0fOQSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523288856; bh=
    9hhZuEegfK9YwbPIKMHGVaCuCNe0Ikr7Dt8wziYFYlE=; b=XJR7BwUJ6KAQvJZJ
    4w465Ged2pSngz/adehP2Cbcu9F45X9v5u913UrqA0Kxr2dXnFWS8EuJnlXiKkIs
    P0fTB6LNeceneypA4LiANXgJbQmIkgkYVNoo91Ic26aZWx14pPUSgDENxealw2SF
    xOPPp6OWkgcx51S509ebKT0XLghKTX4jgGwN0l5Tt0CIYLKRuRpTuXvJWjGS+jYT
    k8NSQk/GaPNCOPggtofmSNCe4sEVTwWJ5689HOpu3XvFmoM3DPRAu4nmsY4co9bs
    FaCZ7zTF+fZO/6B0WRJ1JQHZ3XC4MS8NVGvPURd9sfydkOLseKmCnfyZgIVLlBVb
    jnTYVw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cavium.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hl6eXyy7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cavium.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cavium.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hl6eXyy7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cavium.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAoXJ8id6exEAHehghlo0YWl0xghl1JCb+PLlMRCwef+peO52bC4FQinoUjGiWiKr+mAXekXcrR0ZqLfa/A1ZYBZCIJ321C8KC+knhyB1H/cRBxJrXw0
    VMMpNddk7zYuCGQRNdSTsoWB60dWXWmyNea/FgdxjSWKP66J4GrOmOaoIi4L3TS0iigf8Zy7KLgtvFgDJyXafACRt6b+s1er6kyQreoqgQp+8vNduHp+p5xn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=zAyngx5bAAAA:8
    a=VwQbUJbxAAAA:8 a=pivBIqmD17lqHx8roB8A:9 a=4LA4qAFo6bo561LpWNDU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeDIPqo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 11:46:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38593 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbeDIPqi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 11:46:38 -0400
X-Google-Smtp-Source: AIpwx48k5sEht6NRPL148oSSlV5/06GxTn7G1zPC7ik/p6E6pVLA0blDhYGH3pqHJYrrMN4lNmdM3w==
From: Jan Glauber <jglauber@cavium.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mahipal Challa <Mahipal.Challa@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH v2 2/5] crypto: thunderx_zip: Limit result reading attempts
Date: Mon,  9 Apr 2018 17:45:51 +0200
Message-Id: <20180409154554.7578-3-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180409154554.7578-1-jglauber@cavium.com>
References: <20180409154554.7578-1-jglauber@cavium.com>
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
 drivers/crypto/cavium/zip/common.h      | 21 +++++++++++++++++++++
 drivers/crypto/cavium/zip/zip_deflate.c |  4 ++--
 drivers/crypto/cavium/zip/zip_inflate.c |  4 ++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/zip/common.h b/drivers/crypto/cavium/zip/common.h
index dc451e0a43c5..58fb3ed6e644 100644
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
@@ -149,6 +151,25 @@ struct zip_operation {
 	u32   sizeofzops;
 };
 
+static inline int zip_poll_result(union zip_zres_s *result)
+{
+	int retries = 1000;
+
+	while (!result->s.compcode) {
+		if (!--retries) {
+			pr_err("ZIP ERR: request timed out");
+			return -ETIMEDOUT;
+		}
+		udelay(10);
+		/*
+		 * Force re-reading of compcode which is updated
+		 * by the ZIP coprocessor.
+		 */
+		rmb();
+	}
+	return 0;
+}
+
 /* error messages */
 #define zip_err(fmt, args...) pr_err("ZIP ERR:%s():%d: " \
 			      fmt "\n", __func__, __LINE__, ## args)
diff --git a/drivers/crypto/cavium/zip/zip_deflate.c b/drivers/crypto/cavium/zip/zip_deflate.c
index 9a944b8c1e29..d7133f857d67 100644
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
index 50cbdd83dbf2..7e0d73e2f89e 100644
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
2.16.2
