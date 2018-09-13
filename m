Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E66C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9673920C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PYrygLqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9673920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIMNHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:07:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46167 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeIMNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:07:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180913075901euoutp025705dbc7c646f1b13af1bfc9347f87f9~T5q-57VwZ1584915849euoutp02W
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:59:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180913075901euoutp025705dbc7c646f1b13af1bfc9347f87f9~T5q-57VwZ1584915849euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536825541;
        bh=l9dzKZhZyTX907wXIXPg0iGCADhosQ5oYevz4OylNyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYrygLqKPiFjuywSNiMgrQGytgvkljYfQEwN/cF6Z6RILVj7oXD4F4OxgIt/ol1MR
         eHuYueoy9eDkW7OT7943F3mWYi6YZFKLl3yS/M/APL51I+QpyaSILkoFO9VBUd646z
         LO3m2tTaXI0J1BzV6NAeuFZUMClLa3/U411Erhzw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180913075900eucas1p2c648e0d9b35b48e55769366cc6cf7bc4~T5q-Wi0g41220012200eucas1p2L;
        Thu, 13 Sep 2018 07:59:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3D.D7.04294.4C81A9B5; Thu, 13
        Sep 2018 08:59:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b~T5q_dx0q42420924209eucas1p2D;
        Thu, 13 Sep 2018 07:58:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180913075859eusmtrp2daf71033d70b7e1f154b07597dda9f16~T5q_Mf-6D2501625016eusmtrp2K;
        Thu, 13 Sep 2018 07:58:59 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-8b-5b9a18c4891d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3C.9A.04284.3C81A9B5; Thu, 13
        Sep 2018 08:58:59 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913075859eusmtip1efab34492c378462c29ec6426d2daba0~T5q9vmtMT1717917179eusmtip1p;
        Thu, 13 Sep 2018 07:58:58 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] crypto: s5p-sss: Minor code cleanup
Date:   Thu, 13 Sep 2018 09:58:41 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536825522-6027-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd0jErOiDZ7PELM4vnspo8Wc8y0s
        Ft2vZCz69v1ntDh/fgO7xf17P5ksLu+aw2Yx4/w+Jov/v5qZHTg9tqy8yeSx7YCqx6ZVnWwe
        /xZOYfE4+G4Pk0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlNN94zljQIl0xYV4TUwPjGtEu
        Rk4OCQETib7GtWxdjFwcQgIrGCVOb7rGDOF8YZSYv2M1K4TzmVFi64pjzDAtd1f+h6pazigx
        tek/K1zLl3edrCBVbAKmErfvfgIazMEhIqAgMe+rDkgNs8AZJomLE+aCTRIWsJBof9TIAmKz
        CKhK9EzYyAqxQU7i5rlOZpBeTgEPidPb3EF6JQS62SX6vn8Bq+cVKJPYcWcGC0S9i8SkxfOZ
        IGxhiVfHt7BD2DIS/3eCxEGamxklbn25xgrhTGCUOLi6C6rbWmLTjVdMINuYBTQl1u/Shwg7
        Srx6vx7sAQkBPokbbwVBwsxA5qRt05khwrwSHW1CENVqEq+3bGGDWfvi81dGCNtD4uPZldDA
        ms0oMX3nc5YJjPKzEJYtYGRcxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZhKTv87/mUH
        464/SYcYBTgYlXh4Z6jPjBZiTSwrrsw9xCjBwawkwvuaHSjEm5JYWZValB9fVJqTWnyIUZqD
        RUmcl08rLVpIID2xJDU7NbUgtQgmy8TBKdXAKPa7M9+LY87jGT9eZXTbu++62hRUJfVPaXHA
        hPX8xs9cWzxkjv8VTexTeHW0vKj67fEv0YlvnYvSFYy7Jn5qNZKtyXSVa/otwMuzL7JRwOrY
        glfWE0NltOecTI69ouVSaCV0brP5B9u565hmP3HzPrnU2sbeLfpXxYugrWkfs24ue7+Rb+E7
        JZbijERDLeai4kQAitGL8iEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xu7qHJWZFG+x+IGlxfPdSRos551tY
        LLpfyVj07fvPaHH+/AZ2i/v3fjJZXN41h81ixvl9TBb/fzUzO3B6bFl5k8lj2wFVj02rOtk8
        /i2cwuJx8N0eJo++LasYPT5vkgtgj9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DLaL7xnLGgRbpiwrwmpgbGNaJdjJwcEgImEndX/mfuYuTiEBJY
        yihxZutTJoiEjMS8s31sELawxJ9rXWwQRZ8YJd6ePA2WYBMwlbh99xOQzcEhIqAgMe+rDkgN
        s8AlJoklkxczg9QIC1hItD9qZAGxWQRUJXombGQFsXkF3CXutP9lhFggJ3HzXCczyBxOAQ+J
        09vcQcJCQCWTPm1kn8DIt4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgWG879nPzDsZL
        G4MPMQpwMCrx8L5QmhktxJpYVlyZe4hRgoNZSYT3NTtQiDclsbIqtSg/vqg0J7X4EKMp0E0T
        maVEk/OBMZdXEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoFRmmOC
        uq3pQhWvE0x7Mo792SDEs+Nt9uqDln3V5xWVhRYlSk33MC06ZrtNfddE9ex7ajPeTvu3XipZ
        QUtmY+j6wnnrTxWw/mRYuvwV26OH9/PTdcO1OTaJbeeynvPCz1D7Dmt+s0/+pb6JGs0xdz/8
        ++tUsTitXDF639soux2Xtm/bJXPdaX6VEktxRqKhFnNRcSIA6mH3gYECAAA=
Message-Id: <20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b~T5q_dx0q42420924209eucas1p2D@eucas1p2.samsung.com>
X-CMS-MailID: 20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b
References: <1536825522-6027-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifications in s5p-sss.c:

- remove unnecessary 'goto' statements,

- change uint_8 and uint_32 to u8 and u32 types,

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/crypto/s5p-sss.c | 54 +++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index ce9bd13ea166..817a4b2b71e6 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -249,8 +249,8 @@ struct s5p_aes_reqctx {
 struct s5p_aes_ctx {
 	struct s5p_aes_dev		*dev;
 
-	uint8_t				aes_key[AES_MAX_KEY_SIZE];
-	uint8_t				nonce[CTR_RFC3686_NONCE_SIZE];
+	u8				aes_key[AES_MAX_KEY_SIZE];
+	u8				nonce[CTR_RFC3686_NONCE_SIZE];
 	int				keylen;
 };
 
@@ -518,46 +518,28 @@ static int s5p_make_sg_cpy(struct s5p_aes_dev *dev, struct scatterlist *src,
 
 static int s5p_set_outdata(struct s5p_aes_dev *dev, struct scatterlist *sg)
 {
-	int err;
-
-	if (!sg->length) {
-		err = -EINVAL;
-		goto exit;
-	}
+	if (!sg->length)
+		return -EINVAL;
 
-	err = dma_map_sg(dev->dev, sg, 1, DMA_FROM_DEVICE);
-	if (!err) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	if (!dma_map_sg(dev->dev, sg, 1, DMA_FROM_DEVICE))
+		return -ENOMEM;
 
 	dev->sg_dst = sg;
-	err = 0;
 
-exit:
-	return err;
+	return 0;
 }
 
 static int s5p_set_indata(struct s5p_aes_dev *dev, struct scatterlist *sg)
 {
-	int err;
-
-	if (!sg->length) {
-		err = -EINVAL;
-		goto exit;
-	}
+	if (!sg->length)
+		return -EINVAL;
 
-	err = dma_map_sg(dev->dev, sg, 1, DMA_TO_DEVICE);
-	if (!err) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	if (!dma_map_sg(dev->dev, sg, 1, DMA_TO_DEVICE))
+		return -ENOMEM;
 
 	dev->sg_src = sg;
-	err = 0;
 
-exit:
-	return err;
+	return 0;
 }
 
 /*
@@ -662,8 +644,7 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
 	bool tx_end = false;
 	bool hx_end = false;
 	unsigned long flags;
-	uint32_t status;
-	u32 st_bits;
+	u32 status, st_bits;
 	int err;
 
 	spin_lock_irqsave(&dev->lock, flags);
@@ -1833,7 +1814,7 @@ static struct ahash_alg algs_sha1_md5_sha256[] = {
 };
 
 static void s5p_set_aes(struct s5p_aes_dev *dev,
-			const uint8_t *key, const uint8_t *iv,
+			const u8 *key, const u8 *iv,
 			unsigned int keylen)
 {
 	void __iomem *keystart;
@@ -1919,7 +1900,7 @@ static int s5p_set_outdata_start(struct s5p_aes_dev *dev,
 static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 {
 	struct ablkcipher_request *req = dev->req;
-	uint32_t aes_control;
+	u32 aes_control;
 	unsigned long flags;
 	int err;
 	u8 *iv;
@@ -2027,7 +2008,7 @@ static int s5p_aes_handle_req(struct s5p_aes_dev *dev,
 	err = ablkcipher_enqueue_request(&dev->queue, req);
 	if (dev->busy) {
 		spin_unlock_irqrestore(&dev->lock, flags);
-		goto exit;
+		return err;
 	}
 	dev->busy = true;
 
@@ -2035,7 +2016,6 @@ static int s5p_aes_handle_req(struct s5p_aes_dev *dev,
 
 	tasklet_schedule(&dev->tasklet);
 
-exit:
 	return err;
 }
 
@@ -2057,7 +2037,7 @@ static int s5p_aes_crypt(struct ablkcipher_request *req, unsigned long mode)
 }
 
 static int s5p_aes_setkey(struct crypto_ablkcipher *cipher,
-			  const uint8_t *key, unsigned int keylen)
+			  const u8 *key, unsigned int keylen)
 {
 	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
 	struct s5p_aes_ctx *ctx = crypto_tfm_ctx(tfm);
-- 
2.7.4

