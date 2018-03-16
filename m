Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3031306-1521206716-2-8735303858391873053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521206715; b=lKjikrOVcTLA190sOlmik4/ma0LvH19KPT70NOSZZjwGfV+
    7lcx3wgvYDVJXxO36bcW6M1vtXU6kxHpqP/0+GVEOa9sN3N0ujhdaS03ri7MI150
    L2v7d9Pq/q503eFgIoPpB78VU/fGbHOEMg2pOAyObmv/t56LwD5DWuzB/oGgjUXV
    uwo4TjgcGuMaWIIDoZm/iXhcZSLvBbPziN4oV8361SQ9bT9s/+hC3NCnsb3x1W4w
    wuckH4RY6G5+DfrN8k1uyYJopPmm8CzB1XvcC/COa8mKx6tAGC7XYg3TnNSr4N8U
    6oD2tTERaGjjh56RDzVnPY88Y260rfNU8h6zAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521206715; bh=ydeYkCA2vXmVipoI07GaJ8OwqVMSuIAT8xT7p9XoqmQ=; b=P
    EMOy7Yf2VAw5FgD7zjG+Szk71dSGCtx9GNGJS8qE5D42S7/A66f1Go8LnYPKM9G4
    /yy8qqyHjXuUF2Wlpw4v47tEpeWsvwgtksiWzIXbU20cYa6YAJNQiZAeWCnSHo/N
    VbHNAczFYHeuG7g0uRb9ljavXU3vsOtltgNQvqBA7mtruuQgd4rgkGWdLtraZFMO
    JWid3GXmruoOXi3RYUowS4o1QegHRdQq91d4laIdSsU7OyMVY3RBiD9dIA20KaxB
    KumX0Q1lqTE/UfgdMTlMA5kXPwn27ZJjTYD61FooU3B2l/DGWx9Nrm6SaJtv/rRb
    OmZUfpSuz+p4MT7hm+3+A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=embeddedor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=embeddedor.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=embeddedor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=embeddedor.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeCPNZO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 09:25:14 -0400
Received: from gateway20.websitewelcome.com ([192.185.69.18]:18409 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752522AbeCPNZN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 09:25:13 -0400
Date: Fri, 16 Mar 2018 08:01:41 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] USB: wusbcore: crypto: Remove VLA usage
Message-ID: <20180316130141.GA22594@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1ewozO-004HuT-KJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:41660
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation instead.

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
or a security flaw. Also, in general, as code evolves it is easy to
lose track of how big a VLA can get. Thus, we can end up having runtime
failures that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Notice that in this particular case, an alternative to kzalloc is kcalloc,
in which case the code would look as follows instead:

iv = kcalloc(crypto_skcipher_ivsize(tfm_cbc), sizeof(*iv), GFP_KERNEL);

but if the data type of _iv_ never changes, or the type size is always one
byte, kzalloc is good enough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/wusbcore/crypto.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/wusbcore/crypto.c b/drivers/usb/wusbcore/crypto.c
index 4c00be2d..3511473 100644
--- a/drivers/usb/wusbcore/crypto.c
+++ b/drivers/usb/wusbcore/crypto.c
@@ -202,7 +202,7 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 	struct scatterlist sg[4], sg_dst;
 	void *dst_buf;
 	size_t dst_size;
-	u8 iv[crypto_skcipher_ivsize(tfm_cbc)];
+	u8 *iv;
 	size_t zero_padding;
 
 	/*
@@ -222,9 +222,11 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 		zero_padding;
 	dst_buf = kzalloc(dst_size, GFP_KERNEL);
 	if (!dst_buf)
-		goto error_dst_buf;
+		goto error_alloc;
 
-	memset(iv, 0, sizeof(iv));
+	iv = kzalloc(crypto_skcipher_ivsize(tfm_cbc), GFP_KERNEL);
+	if (!iv)
+		goto error_alloc;
 
 	/* Setup B0 */
 	scratch->b0.flags = 0x59;	/* Format B0 */
@@ -276,8 +278,9 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 	bytewise_xor(mic, &scratch->ax, iv, 8);
 	result = 8;
 error_cbc_crypt:
+	kfree(iv);
 	kfree(dst_buf);
-error_dst_buf:
+error_alloc:
 	return result;
 }
 
-- 
2.7.4

