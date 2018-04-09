Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1365147-1523288893-2-15293197663955101102
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
    1523288893; b=Q0gmgtlhtGhFq2Et389mFWRl9lIfPXFTujT5XHCxrVHWxN59dq
    1ogiiE3oOb3fkbzf/sKO5bTRXuwC2+fQGsU8/a4yVlGa6yhuxBRHkXijwNl5dTS8
    V/olqCGu0pZHzmEWwt7d2sOvbm3oeA5fvc2rjNBq6OSpTNlUtMuqCGf1UZSUnJaj
    ffMDz0KjvUoqMRXcIsU4WMSlw11g58kLfY/pZ7rnc/XJ4R8Ow+Jp5+yR8OdhTc98
    dPYB8ppEg2gxZ75T31andRUjmff65My+Y30BBQhiih4w8YuQ7KcfO+FYkpwASqHG
    XBJFK8ulhx6m5YSeHP+I0K9ps3R5Os6N5kdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523288893; bh=
    0v1lQVJNGcHOMyE4flzH5k1U1H1u0EgITMeDANJZIKs=; b=KBU6zi6qNHw1eEjr
    9+sPoK0zB4naaj0woYvIdDWfGJu/1xxRRvrRU648saXkG1LflsqgWKyMfZXlh9ca
    sEbFHjbuxWPEDnn1SCOF05v9rEHhMSRMeBYp1fJo/ni2EZLG3oBG+wdhIwkxd0Kx
    DdedDq2JBI3MBla75d2hU3tjy9Vj8Z3Q9P5XdNMFiDx+L6Y0CBCPzK0lVbsUDhY1
    7SnznV4ejrN42cstIFiCQOIjI6KujK8BUuVyB7Hc395893h4h702kSMqrwP7KT4d
    h7Ps+OxrehKbu9dcOQqVG+E/brbkXiDiKAXyinM2tCq0o0MjjqgPyO4vkdngm58d
    1MXqEg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cavium.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HeJNmZV8;
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
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HeJNmZV8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cavium.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMEOvTVgMs1nEDxKgjRU+UBx4DGCwWZyD6s2pWTjXfNRMyhJ8s6OMtVPyTXDTPN60Gu0xxOAyELpSox0SU4vEs89pjtx+oJOSyNIU6fvcUE0GtpHAAE7
    9tbhSNRxiTeE2PWbqVHpV+7jMSheXvgCdYj3d7QfXX3k9k0HtKHyLY10MrDH0A1TQfPRCw3r7xqoyF4DtOou4bPkyF8k51YaQnCM+zaSyjSQvL7ERKIznWTk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=zAyngx5bAAAA:8
    a=VwQbUJbxAAAA:8 a=pivBIqmD17lqHx8roB8A:9 a=Yw1PtPbgJkyCB52E:21
    a=Hq7CQNCm8Fqj4nxR:21 a=4LA4qAFo6bo561LpWNDU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeDIPsD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 11:48:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39070 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbeDIPqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 11:46:37 -0400
X-Google-Smtp-Source: AIpwx4+h0OZfxyEybuFZ8okehnly+Byi7p4G01yAmJDgbUu2Guj3a7BvipjkEdhop/ZCtUOA1/lyKg==
From: Jan Glauber <jglauber@cavium.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mahipal Challa <Mahipal.Challa@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH v2 1/5] crypto: thunderx_zip: Fix fallout from CONFIG_VMAP_STACK
Date: Mon,  9 Apr 2018 17:45:50 +0200
Message-Id: <20180409154554.7578-2-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180409154554.7578-1-jglauber@cavium.com>
References: <20180409154554.7578-1-jglauber@cavium.com>
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
index 8df4d26cf9d4..b92b6e7e100f 100644
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
+	zip_state = kzalloc(sizeof(*zip_state), GFP_ATOMIC);
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
+	zip_state = kzalloc(sizeof(*zip_state), GFP_ATOMIC);
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
2.16.2
