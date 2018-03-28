Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2270871-1522242425-2-16858309766440037199
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
    t=1522242425; b=JpgvJrSSczkPcog8IkQJjrb8JT7zMeL0dJtPHmPe6IWiNDf
    6iGPMR24Vd4ZV5/XLNQJwqRdoGQnFSH8JAf7UNiA/3UoInXIV1VdNREOMEP62rx5
    v1WEQtH3UorfmY85lD9RwLPbe7dfBfL7WBlAqlTxfLelHq0YpuWwVeyDCrbOatLZ
    JvZgVCXtjRKpSyfn5wPoel/wJfmYkaq38A8ecRsNjiij8C9g1QIhWEAMihN3qeC3
    QEshOMapUsgk7hvo9oA2CviZjVnGN9ib87VEaM2tTkfHA2/ZgzMPUUzFINdvKMWO
    G/0p1fxG+ZiQ4N2txERWSbdWKstySN93GydvrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522242425; bh=zZi1P5wlQWwSdHcPhsiUlxsFrh
    +WechaWkc7BzUwW3s=; b=obNJfImSGvi519Jk7GWa+2CznVHNXQy8x0inVnpwol
    0P0dtrCA0wePf0zPQ54APzAXOM0uS6Wxqmq49DUwIlaBMP1youWvFNrhvhSJjgfX
    l0BSOGQUv6MuPWwAFrbpXPCL87s/j8EYxJYPyWmdIxe5WBgb49WNHv1ryPhM2cXh
    RpoRQxEql/J+FOs9vo4VR7Umy1iy+T4XszecmvxhZdwuM4uNBzoGgQY4d8O2hmGI
    /GvYkx7JuMKP5cmQgUB2F1+XLqDZzU8wsO+g7s45ikzebLI2WXosHFLDgXY6zXQe
    roeeObf4aBktFzTWYR5RrB0o+3NZhX5UWYSCh8uY+e4w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cavium.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Dxgeipm1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cavium.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cavium.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Dxgeipm1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cavium.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFM+EPTEadXeN/JDYj1DIhOo1YfhRs1Vvi9OJRG6Fgt4MkG9tu02sg2ksym+aPzy1Er/lxG5gCrzDcE6qgd3vyjatWxuf8uEZ6SxgG5cqXDxudROc/Ot
    eZm4pBg+h/j4ylqd5IELDvQ17/ayTVVC5J2Ce8ASymins/x7b5gc73P0nYIo6MCifx7QxzuQrl5PczLq9yUvosGBCcj1ssIeyIMuFpDOr7YeZQf4KfIYpglO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=zAyngx5bAAAA:8
    a=VwQbUJbxAAAA:8 a=pivBIqmD17lqHx8roB8A:9 a=U7sfXVdiR0QEhD2M:21
    a=Hq7CQNCm8Fqj4nxR:21 a=4LA4qAFo6bo561LpWNDU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeC1NGi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 09:06:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38554 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752978AbeC1NGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 09:06:34 -0400
X-Google-Smtp-Source: AIpwx4/tWjCTgvOPVM2fp9N/kEMKlFpuOzWypkHwbITqFDat04tKE8+i0fwKngzJ+8gQIfGSkpftnQ==
From: Jan Glauber <jglauber@cavium.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mahipal Challa <Mahipal.Challa@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 1/2] crypto: thunderx_zip: Fix fallout from CONFIG_VMAP_STACK
Date: Wed, 28 Mar 2018 15:05:56 +0200
Message-Id: <20180328130557.10560-1-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Enabling virtual mapped kernel stacks breaks the thunderx_zip
driver. On compression or decompression the executing CPU hangs
in an endless loop. The reason for this is the usage of __pa
by the driver which does no longer work for an address that is
not part of the 1:1 mapping.

The zip driver allocates a result struct on the stack and needs
to tell the hardware the physical address within this struct
that is used to signal the completion of the request.

As the hardware gets the wrong address after the broken __pa
conversion it writes to an arbitrary address. The zip driver then
waits forever for the completion byte to contain a non-zero value.

Allocating the result struct from 1:1 mapped memory resolves this
bug.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Reviewed-by: Robert Richter <rrichter@cavium.com>
Cc: stable <stable@vger.kernel.org> # 4.14
---
 drivers/crypto/cavium/zip/zip_crypto.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/cavium/zip/zip_crypto.c b/drivers/crypto/cavium/zip/zip_crypto.c
index 8df4d26..2fc9b03 100644
--- a/drivers/crypto/cavium/zip/zip_crypto.c
+++ b/drivers/crypto/cavium/zip/zip_crypto.c
@@ -124,7 +124,7 @@ int zip_compress(const u8 *src, unsigned int slen,
 		 struct zip_kernel_ctx *zip_ctx)
 {
 	struct zip_operation  *zip_ops   = NULL;
-	struct zip_state      zip_state;
+	struct zip_state      *zip_state;
 	struct zip_device     *zip = NULL;
 	int ret;
 
@@ -135,20 +135,23 @@ int zip_compress(const u8 *src, unsigned int slen,
 	if (!zip)
 		return -ENODEV;
 
-	memset(&zip_state, 0, sizeof(struct zip_state));
+	zip_state = kzalloc(sizeof(*zip_state), GFP_KERNEL);
+	if (!zip_state)
+		return -ENOMEM;
+
 	zip_ops = &zip_ctx->zip_comp;
 
 	zip_ops->input_len  = slen;
 	zip_ops->output_len = *dlen;
 	memcpy(zip_ops->input, src, slen);
 
-	ret = zip_deflate(zip_ops, &zip_state, zip);
+	ret = zip_deflate(zip_ops, zip_state, zip);
 
 	if (!ret) {
 		*dlen = zip_ops->output_len;
 		memcpy(dst, zip_ops->output, *dlen);
 	}
-
+	kfree(zip_state);
 	return ret;
 }
 
@@ -157,7 +160,7 @@ int zip_decompress(const u8 *src, unsigned int slen,
 		   struct zip_kernel_ctx *zip_ctx)
 {
 	struct zip_operation  *zip_ops   = NULL;
-	struct zip_state      zip_state;
+	struct zip_state      *zip_state;
 	struct zip_device     *zip = NULL;
 	int ret;
 
@@ -168,7 +171,10 @@ int zip_decompress(const u8 *src, unsigned int slen,
 	if (!zip)
 		return -ENODEV;
 
-	memset(&zip_state, 0, sizeof(struct zip_state));
+	zip_state = kzalloc(sizeof(*zip_state), GFP_KERNEL);
+	if (!zip_state)
+		return -ENOMEM;
+
 	zip_ops = &zip_ctx->zip_decomp;
 	memcpy(zip_ops->input, src, slen);
 
@@ -179,13 +185,13 @@ int zip_decompress(const u8 *src, unsigned int slen,
 	zip_ops->input_len  = slen;
 	zip_ops->output_len = *dlen;
 
-	ret = zip_inflate(zip_ops, &zip_state, zip);
+	ret = zip_inflate(zip_ops, zip_state, zip);
 
 	if (!ret) {
 		*dlen = zip_ops->output_len;
 		memcpy(dst, zip_ops->output, *dlen);
 	}
-
+	kfree(zip_state);
 	return ret;
 }
 
-- 
2.7.4
