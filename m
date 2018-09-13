Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22B3C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952DF20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g2PZxyNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952DF20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIMNHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:07:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46122 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeIMNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:07:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180913075858euoutp02b52e280a7d545598b3363062a0f031a0~T5q9rbMXt1584915849euoutp02O
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180913075858euoutp02b52e280a7d545598b3363062a0f031a0~T5q9rbMXt1584915849euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536825539;
        bh=qVqt63eB7B8WilHkP6rJsuI8o+vRlPYy+S3yKwso9PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2PZxyNh3n5GznvGEMaAzj3d7JNC29VyrkwVK5c3grzrzKPeWMK4Yv7EHLdEzjcMr
         /Zg0SrBb7WV9woDUFxsr55ETOwOoqZzMOj+bGVVuS8R/21Wd0ZJmFeBLKcaDnxKnbo
         27BPT0cIM7welR+NIfo0nOhpU22JKFEOWdJ/Dbfc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180913075858eucas1p1135395fbd35739d2a5031818fda40321~T5q8zSrRF0787307873eucas1p1X;
        Thu, 13 Sep 2018 07:58:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E6.04.04441.1C81A9B5; Thu, 13
        Sep 2018 08:58:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44~T5q8CpLOD2420024200eucas1p24;
        Thu, 13 Sep 2018 07:58:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180913075856eusmtrp2e3cf2b383468271d37f9cac4dc57a3fd~T5q7xgXXd2501325013eusmtrp2O;
        Thu, 13 Sep 2018 07:58:56 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-7d-5b9a18c1b859
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.9A.04284.0C81A9B5; Thu, 13
        Sep 2018 08:58:56 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913075856eusmtip1d33a7337638c1cf78fa31de16d1335a1~T5q7Kn7A31717917179eusmtip1o;
        Thu, 13 Sep 2018 07:58:56 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] crypto: s5p-sss: Fix race in error handling
Date:   Thu, 13 Sep 2018 09:58:39 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536825522-6027-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSXUxSYRjH957Dx4GJndDyTZ01nJFUfmzaTkVGq9a5ceuiC5cXSXn8mILG
        8SPrhtKVH8XQ3CLUrAtnUU1HyAqTAZbOdGKmTEsrvXANsqlATrc08OC8+z3P+/u//+3di6HC
        B+xorFBZRqmU8mIRh88yD6yNHrVDfXZKbaeEGOztAESrs4ZFNLhjCY11ExBOZzeX+PF9DSG+
        WFo5hM5pRYjN9WpUxiNNL6YR0mxLII2GOg658ayZRdr/vEdIjckASK8x7iL3Ml+aSxUXVlCq
        5IwcfkGPax6UeiNu2CZfc9VgCK8HPAziadC7+hfUAz4mxJ8D+G/ajjCDD8Cntx1sZvACOPlG
        z9mOqK26kNUJoE1n3ol4bctbFgdPh99mVwKMYZH4AfjEfyTooPgIAj9r29CgE4HL4JC/estn
        4Qmw/05jqCEOTo/WocEsDyfhsPlCMAvxBi4c9tWwgo4Ar4CWod8o45+DH3sechmOgO5BU4hj
        4ea7doQJVwP41ediM4MWQPvLehZjnYTGKTcSbEPxRNhlSQ4ixM/AVxNnGQyHU4u7gzIawCbz
        I5RZC2DtXSFzx0HoMZk4262/vH7AMAnHLG2hR2wBsLN/AGjBfv1O11MADCCKKqcV+RSdqqQq
        k2i5gi5X5iddK1EYQeCTDG8MrrwF/vGrDoBjQBQm0IkfZwvZ8gq6SuEAEENFkQIPN7AS5Mqr
        blKqkiuq8mKKdoAYjCWKEoRL8rKFeL68jCqiqFJKtX2KYLxoNWj2yFaPHZ+7VMReuDdiup6s
        OT3gEbnS0g2J+zra8/aeb5IRPzWN8dPrlWJfrZOs0bsPC7t3ab1jRknXqd7lrJm+Q1lLc30d
        KTOLMWXmTDpTZciL94I9c/OfrNLZD+NLheoM8QmxUTbquh/WPGGrKmhbcCmldrrh1lgO0SIV
        segCeaoEVdHy/+yT3PcgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xu7oHJGZFGzQtNbE4vnspo8Wc8y0s
        Ft2vZCz69v1ntDh/fgO7xf17P5ksLu+aw2Yx4/w+Jov/v5qZHTg9tqy8yeSx7YCqx6ZVnWwe
        /xZOYfE4+G4Pk0ffllWMHp83yQWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8da
        GZkq6dvZpKTmZJalFunbJehlbL32iLHgs3DFgatr2RsYTwp0MXJySAiYSDTsm8HUxcjFISSw
        lFHi2I8jrBAJGYl5Z/vYIGxhiT/XusBsIYFPjBJvDuiC2GwCphK3734CinNwiAgoSMz7qgMy
        h1ngEpPEksmLmUFqhAUcJE5+bQbrZRFQlTjcNBHM5hVwl5i+ZDELxHw5iZvnOplB5nAKeEic
        3uYOscpdYtKnjewTGPkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAzqbcd+bt7BeGlj
        8CFGAQ5GJR7eF0ozo4VYE8uKK3MPMUpwMCuJ8L5mBwrxpiRWVqUW5ccXleakFh9iNAW6aSKz
        lGhyPjDi8kriDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MAo0sKhP
        djv2QdxvfnHd1Gf3ltR8Y7GTuqTWdqbmqeXNyow/KzoW3I/MbDvEvGyJrZd31a6Le48z7j6/
        eEVrvlP9b7XAr2fX1whazVDZvG3liZIl8uuufrYz/LSrQXknG5/Lhn8eKnWB5pE/Th5k3yi9
        7fbmv3+Dv1xKvvjwdXrYPYHUafrVL3mUWIozEg21mIuKEwG4S9PJgAIAAA==
Message-Id: <20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44~T5q8CpLOD2420024200eucas1p24@eucas1p2.samsung.com>
X-CMS-MailID: 20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44
References: <1536825522-6027-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a race condition introduced by error path in functions:
s5p_aes_interrupt and s5p_aes_crypt_start. Setting the busy field of
struct s5p_aes_dev to false made it possible for s5p_tasklet_cb to
change the req field, before s5p_aes_complete was called.

Change the first parameter of s5p_aes_complete to struct
ablkcipher_request. Before spin_unlock, make a copy of the currently
handled request, to ensure s5p_aes_complete function call with the
correct request.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/crypto/s5p-sss.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index faa282074e5a..0cf3f12d8f74 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -475,9 +475,9 @@ static void s5p_sg_done(struct s5p_aes_dev *dev)
 }
 
 /* Calls the completion. Cannot be called with dev->lock hold. */
-static void s5p_aes_complete(struct s5p_aes_dev *dev, int err)
+static void s5p_aes_complete(struct ablkcipher_request *req, int err)
 {
-	dev->req->base.complete(&dev->req->base, err);
+	req->base.complete(&req->base, err);
 }
 
 static void s5p_unset_outdata(struct s5p_aes_dev *dev)
@@ -655,6 +655,7 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
 	struct s5p_aes_dev *dev = platform_get_drvdata(pdev);
+	struct ablkcipher_request *req;
 	int err_dma_tx = 0;
 	int err_dma_rx = 0;
 	int err_dma_hx = 0;
@@ -725,9 +726,10 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
 		if (err_dma_hx == 1)
 			s5p_set_dma_hashdata(dev, dev->hash_sg_iter);
 
+		req = dev->req;
 		spin_unlock_irqrestore(&dev->lock, flags);
 
-		s5p_aes_complete(dev, 0);
+		s5p_aes_complete(req, 0);
 		/* Device is still busy */
 		tasklet_schedule(&dev->tasklet);
 	} else {
@@ -755,8 +757,9 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
 	if (err_dma_hx == 1)
 		s5p_set_dma_hashdata(dev, dev->hash_sg_iter);
 
+	req = dev->req;
 	spin_unlock_irqrestore(&dev->lock, flags);
-	s5p_aes_complete(dev, err);
+	s5p_aes_complete(req, err);
 
 hash_irq_end:
 	/*
@@ -1983,7 +1986,7 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	s5p_sg_done(dev);
 	dev->busy = false;
 	spin_unlock_irqrestore(&dev->lock, flags);
-	s5p_aes_complete(dev, err);
+	s5p_aes_complete(req, err);
 }
 
 static void s5p_tasklet_cb(unsigned long data)
-- 
2.7.4

