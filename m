Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47162C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2BF20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sFPEMqS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2BF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeIMNIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:08:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46180 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeIMNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:07:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180913075902euoutp02b74ce579b28c0173091da2c47d23c523~T5rBOXvxV1588815888euoutp02N
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:59:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180913075902euoutp02b74ce579b28c0173091da2c47d23c523~T5rBOXvxV1588815888euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536825542;
        bh=cVIWIDgzxQJvZJwjNs8/CFdUKLfJzxfuX+WbJ8itMJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFPEMqS/RRcE9F79GK0j4RcWPKS9iOuVjr33RCCURmf7gzoqksfhH11UktWvpDpkv
         6hmZScIwbDVmjLB9fu5nSyY6jq5A+ad8LhUgvaT/qK3/3mWWEFP9ScDONtou1F8SOJ
         zDve9CYJ2qinw+ZmYvp/rpP3yBC+7HaldqUOqaqo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180913075901eucas1p2712da9bbbb199608e91526580a26ae2d~T5rAXi9Mi2420824208eucas1p27;
        Thu, 13 Sep 2018 07:59:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.DE.04806.5C81A9B5; Thu, 13
        Sep 2018 08:59:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd~T5q-ljNj41220012200eucas1p2N;
        Thu, 13 Sep 2018 07:59:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180913075900eusmtrp240e8c180e3a1ad75691dff931c2bcc1f~T5q-PbmGb2501625016eusmtrp2O;
        Thu, 13 Sep 2018 07:59:00 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-18-5b9a18c5c980
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.F8.04128.4C81A9B5; Thu, 13
        Sep 2018 08:59:00 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913075900eusmtip1ae9e9acee588528f340829df3a9355e2~T5q_ycHdQ1574715747eusmtip1Y;
        Thu, 13 Sep 2018 07:59:00 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] crypto: s5p-sss: Add aes-ctr support
Date:   Thu, 13 Sep 2018 09:58:42 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536825522-6027-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned2jErOiDQ4vl7c4vnspo8Wc8y0s
        Ft2vZCz69v1ntDh/fgO7xf17P5ksLu+aw2Yx4/w+Jov/v5qZHTg9tqy8yeSx7YCqx6ZVnWwe
        /xZOYfE4+G4Pk0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBltF3fzVywUaVi0SzbBsaLsl2M
        nBwSAiYSz692M4LYQgIrGCXO7xbvYuQCsr8wSmw6MIUZIvGZUeLOI58uRg6whu9P2SBqljNK
        HNi6lxWu4eX9TlaQBjYBU4nbdz+xgTSICChIzPuqA1LDLHCGSeLihLlgQ4UFLCVuLT/HAmKz
        CKhKrHywjw3iIjmJm+c6mUF6OQU8JE5vcwfplRDoZpe493ch2HxegTKJfZv+skMc5CJx9p0q
        RKuwxKvjW9ghbBmJ/zvnM0H0NjNK3PpyjRXCmcAocXB1FwtElbXEphuvmEAGMQtoSqzfpQ8R
        dpT4fbqdEWI+n8SNt4IgYWYgc9K26cwQYV6JjjYhiGo1iddbtrDBrH3x+StUp4fEjQt1kNCZ
        zSgxdeUn9gmM8rMQdi1gZFzFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmD5O/zv+dQfj
        vj9JhxgFOBiVeHg/aM6MFmJNLCuuzD3EKMHBrCTC+5odKMSbklhZlVqUH19UmpNafIhRmoNF
        SZyXTystWkggPbEkNTs1tSC1CCbLxMEp1cDY2xCx28hAbElwyJTaJ6xbmf1mTi7bfevtFxt7
        pbWrxcKmTmv4u6pmzSZDQakVz2MbC1322jvc0/i+wlXnnesGC42Spn/N63jyvi/8/PP8sw1M
        l+p5UotcX2jc8b+tuFtJNqXwxoPuGI2z/sqn1nhwftvHrnZjvsATjblMAeUMQaJXhEx/7nNQ
        YinOSDTUYi4qTgQAarzi6xsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xu7pHJGZFG2zZoWhxfPdSRos551tY
        LLpfyVj07fvPaHH+/AZ2i/v3fjJZXN41h81ixvl9TBb/fzUzO3B6bFl5k8lj2wFVj02rOtk8
        /i2cwuJx8N0eJo++LasYPT5vkgtgj9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DLaLu+m7lgo0rFolm2DYwXZbsYOTgkBEwkvj9l62Lk5BASWMoo
        cfR0GYgtISAjMe9sHxuELSzx51oXkM0FVPOJUeLqzGfMIAk2AVOJ23c/sYHMERFQkJj3VQek
        hlngEpPEksmLwWqEBSwlbi0/xwJiswioSqx8sA9sKK+Au8T9x41MEAvkJG6e62QGmcMp4CFx
        eps7xD3uEpM+bWSfwMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmBAbzv2c8sOxq53
        wYcYBTgYlXh4XyjNjBZiTSwrrsw9xCjBwawkwvuaHSjEm5JYWZValB9fVJqTWnyI0RToponM
        UqLJ+cBoyyuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwMh3JsL0
        RS5Px9foqO8y6w8lTjW+eMnz5bVlyZ/d8sWcPgbqH1i7Y+MepxPHdpXe9l1pbbOEW1h+A+fT
        M8wXLWwu3br9aJmBhO++dUlz5l3exyyvaCGeXhFl1ZaUUOLTr/FaZdmije+YbR1/njz1uuP+
        y08Kpx4uevlB/fZi3wd1m1OFCu44u11TYinOSDTUYi4qTgQA99+18H4CAAA=
Message-Id: <20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd~T5q-ljNj41220012200eucas1p2N@eucas1p2.samsung.com>
X-CMS-MailID: 20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd
References: <1536825522-6027-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180913075901eucas1p2dfb1900b71d70ee64a9d51eb4c8b61fd@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for aes counter(ctr) block cipher mode of operation for
Exynos Hardware. In contrast to ecb and cbc modes, aes-ctr allows
encyption/decryption for request sizes not being a multiple of 16(bytes).

Hardware requires block sizes being a multiple of 16(bytes). In order to
achieve this, copy request source and destination memory, and align it's size
to 16. That way hardware processes additional bytes, that are omitted
when copying the result back to its original destination.

Tested on Odroid-U3 with Exynos 4412 CPU, kernel 4.19-rc2 with crypto
run-time self test testmgr and with tcrypt module:
insmod tcrypt.ko sec=1 mode=500.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/crypto/s5p-sss.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 817a4b2b71e6..cfa104f6e468 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -1814,7 +1814,7 @@ static struct ahash_alg algs_sha1_md5_sha256[] = {
 };
 
 static void s5p_set_aes(struct s5p_aes_dev *dev,
-			const u8 *key, const u8 *iv,
+			const u8 *key, const u8 *iv, const u8 *ctr,
 			unsigned int keylen)
 {
 	void __iomem *keystart;
@@ -1822,6 +1822,9 @@ static void s5p_set_aes(struct s5p_aes_dev *dev,
 	if (iv)
 		memcpy_toio(dev->aes_ioaddr + SSS_REG_AES_IV_DATA(0), iv, 0x10);
 
+	if (ctr)
+		memcpy_toio(dev->aes_ioaddr + SSS_REG_AES_CNT_DATA(0), ctr, 0x10);
+
 	if (keylen == AES_KEYSIZE_256)
 		keystart = dev->aes_ioaddr + SSS_REG_AES_KEY_DATA(0);
 	else if (keylen == AES_KEYSIZE_192)
@@ -1903,8 +1906,9 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	u32 aes_control;
 	unsigned long flags;
 	int err;
-	u8 *iv;
+	u8 *iv, *ctr;
 
+	/* This sets bit [13:12] to 00, which selects 128-bit counter */
 	aes_control = SSS_AES_KEY_CHANGE_MODE;
 	if (mode & FLAGS_AES_DECRYPT)
 		aes_control |= SSS_AES_MODE_DECRYPT;
@@ -1912,11 +1916,14 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC) {
 		aes_control |= SSS_AES_CHAIN_MODE_CBC;
 		iv = req->info;
+		ctr = NULL;
 	} else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR) {
 		aes_control |= SSS_AES_CHAIN_MODE_CTR;
-		iv = req->info;
+		iv = NULL;
+		ctr = req->info;
 	} else {
 		iv = NULL; /* AES_ECB */
+		ctr = NULL;
 	}
 
 	if (dev->ctx->keylen == AES_KEYSIZE_192)
@@ -1948,7 +1955,7 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 		goto outdata_error;
 
 	SSS_AES_WRITE(dev, AES_CONTROL, aes_control);
-	s5p_set_aes(dev, dev->ctx->aes_key, iv, dev->ctx->keylen);
+	s5p_set_aes(dev, dev->ctx->aes_key, iv, ctr, dev->ctx->keylen);
 
 	s5p_set_dma_indata(dev,  dev->sg_src);
 	s5p_set_dma_outdata(dev, dev->sg_dst);
@@ -2026,7 +2033,8 @@ static int s5p_aes_crypt(struct ablkcipher_request *req, unsigned long mode)
 	struct s5p_aes_ctx *ctx = crypto_ablkcipher_ctx(tfm);
 	struct s5p_aes_dev *dev = ctx->dev;
 
-	if (!IS_ALIGNED(req->nbytes, AES_BLOCK_SIZE)) {
+	if (!IS_ALIGNED(req->nbytes, AES_BLOCK_SIZE) &&
+			((mode & FLAGS_AES_MODE_MASK) != FLAGS_AES_CTR)) {
 		dev_err(dev->dev, "request size is not exact amount of AES blocks\n");
 		return -EINVAL;
 	}
@@ -2073,6 +2081,11 @@ static int s5p_aes_cbc_decrypt(struct ablkcipher_request *req)
 	return s5p_aes_crypt(req, FLAGS_AES_DECRYPT | FLAGS_AES_CBC);
 }
 
+static int s5p_aes_ctr_crypt(struct ablkcipher_request *req)
+{
+	return s5p_aes_crypt(req, FLAGS_AES_CTR);
+}
+
 static int s5p_aes_cra_init(struct crypto_tfm *tfm)
 {
 	struct s5p_aes_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -2127,6 +2140,28 @@ static struct crypto_alg algs[] = {
 			.decrypt	= s5p_aes_cbc_decrypt,
 		}
 	},
+	{
+		.cra_name		= "ctr(aes)",
+		.cra_driver_name	= "ctr-aes-s5p",
+		.cra_priority		= 100,
+		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
+					  CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_KERN_DRIVER_ONLY,
+		.cra_blocksize		= AES_BLOCK_SIZE,
+		.cra_ctxsize		= sizeof(struct s5p_aes_ctx),
+		.cra_alignmask		= 0x0f,
+		.cra_type		= &crypto_ablkcipher_type,
+		.cra_module		= THIS_MODULE,
+		.cra_init		= s5p_aes_cra_init,
+		.cra_u.ablkcipher = {
+			.min_keysize	= AES_MIN_KEY_SIZE,
+			.max_keysize	= AES_MAX_KEY_SIZE,
+			.ivsize		= AES_BLOCK_SIZE,
+			.setkey		= s5p_aes_setkey,
+			.encrypt	= s5p_aes_ctr_crypt,
+			.decrypt	= s5p_aes_ctr_crypt,
+		}
+	},
 };
 
 static int s5p_aes_probe(struct platform_device *pdev)
-- 
2.7.4

