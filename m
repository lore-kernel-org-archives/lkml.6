Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-900952-1519327794-2-3533860684152876197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519327793; b=bImAkHMfToGM8CX95EgDkrgsRI+tyql2IbB41Us9PlJT20Z
    xQ1oupdY3JkIExDv/o+DMYpElkWb41/tAzw0+RNMRn1kIecYASHvrlYOgps0s6h9
    EkjmbfpA8viL5gqiFnvKOT5zayw3r1h17eWBCkS/+QTaZTzB9RPgiers/peidLRX
    rUpJPN5J3nLA9JeuZ+SGbCKfPKNUNAic+23mF/kBSns6Snl8lzx6V5mKZKegz8Ij
    LAJE01OVeVPjSdxRQ2RFLJ8P1nnwbgZIxT3CFg0SYOMIReCBzsB6NRoF39/gctkg
    baQlSJZH9PIwkhG98mMpuNzYlHPx5OogKSivQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519327793; bh=L
    iyH618/o/dkhFHI9Q7xO/MNRUPRLi1zjL5Niunpzvs=; b=X36amkQpKiANj2gX3
    0UUvk5kAMj3ebpWNF6TlJKwA5k3yxj5XtVrJWiQ2qYjIV/U7+vI9pSt3vnp1V9Nx
    Hxcf3ZvkFfaMBYZjOBkQnnaJZe4HEGviba9tliebz2F8LL0HY1taHrOnLZbMDu2o
    DYzEXJ0A1yWBkKyK/Zg6igOu/KLb7h682V7KrnJ7FJP/XW4lVs3f5wH4xR+aTpWN
    h8AG4VE9PLS/foqtn0gI+hkJ6d6fYQDG1pmvX6FdminqDPQEDT4GU5qs78a/akEq
    9cWMPzX6T3xtrcSCmtoJJjeOeMPocVmaPAxaphD/es025ZiPU/eBXCE7iwvTKQ4M
    XA7cw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LB/Ys3ib x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E/OSVqcg;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LB/Ys3ib x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E/OSVqcg;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224Bu5nGC62B2yXtU3PMvQ6jDTc52sv5iKRrRSGkOA2eUBvD0xXQ7xMg8jHE+bdBzDba5qlh1A==
From: Debopriyo Ghosh <debopriyosoftdev@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] Staging: rtl8192e: rtllib_crypt_tkip.c: Use __func__ instead
 of function name and proper code ident for else statement
Date: Fri, 23 Feb 2018 00:57:16 +0530
Message-Id: <1519327636-18972-1-git-send-email-debopriyosoftdev@gmail.com>
X-Mailer: git-send-email 2.7.4
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Debopriyo <debopriyosoftdev@gmail.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Debopriyo <debopriyosoftdev@gmail.com>

This is a patch to the rtllib_crypt_tkip.c file that fixes 2 issues found
by the checkpatch.pl tool
1.Use of __func__ instead of function name
2.proper code identation for else statement

Signed-off-by: Debopriyo Ghosh <debopriyosoftdev@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index ae103b0..e462c1e 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -314,7 +314,7 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		tkip_mixing_phase2(rc4key, tkey->key, tkey->tx_ttak,
 				   tkey->tx_iv16);
 	} else
-	tkey->tx_phase1_done = 1;
+		tkey->tx_phase1_done = 1;
 
 
 	len = skb->len - hdr_len;
@@ -512,7 +512,7 @@ static int michael_mic(struct crypto_ahash *tfm_michael, u8 *key, u8 *hdr,
 	int err;
 
 	if (tfm_michael == NULL) {
-		pr_warn("michael_mic: tfm_michael == NULL\n");
+		pr_warn("%s: tfm_michael == NULL\n", __func__);
 		return -1;
 	}
 	sg_init_table(sg, 2);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
