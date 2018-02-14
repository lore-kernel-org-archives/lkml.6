Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031292AbeBNP0u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:26:50 -0500
Received: from mout.web.de ([212.227.15.4]:36201 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031243AbeBNP0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:26:48 -0500
Subject: [PATCH 2/2] crypto: omap: Improve a size determination in three
 functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joel Fernandes <joelf@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <28780631-d093-a581-8690-3868f8fa327e@users.sourceforge.net>
Message-ID: <0a45e47f-5ed0-5dd6-7545-adc8df2d7972@users.sourceforge.net>
Date: Wed, 14 Feb 2018 16:26:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <28780631-d093-a581-8690-3868f8fa327e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:F6IdtW2R36jTuBtu2ArWP9UyF4b6nhPHcKjK/x09ZotpVyIrvNl
 GoGIPhnWMZgp0vc/mCjB5Oaslkf/WGEVVglsSxqeRL7jqMleR9TNiR6EtHfR2rVwPJCKNmy
 opvGklAxB7/J3xU78E4++E47H4xJTlnEqTG8R14ohXshp/IVJdYF3dVpA/FI6KQf90D1A9k
 10g2w5l7ryJ/44SE8XHTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PM+TLYRmcdk=:kuwfI7IqTiTco/Rx0eow+f
 qtnCxODHn3vZjldJoqj7zC2L3nCW7xInIJqy1IHzc80UHzTADWJ9FRMsWnJ0s3+gDim6dHJZU
 /AcQKX3wHvi1qHi45UCfgF87QAkNIwwoVpFWqTh7f00RXpoOgAvjvdT0HYm6O8BdI32I9Lcls
 qcgaObBI8FoiHDCIFHaDo8jYfx0/VeBEEd+fFtPnMD8AdkHkoO2oVSuwWBHrM790VTVzolram
 gjtXrVMPpT8f7Ix6rQCzLthYqQ3v8obLACdtlQ0mbgNrl+iEZPzzy/lcu0q2ZJwJSrmc8mzTY
 yEsIn40bRmrgfyDgjtPxAWbNIyH8SNjKlo0ARKrPuCdNz1VfPfzf8o6REVdOTOG7HnhNQRidR
 dgRQNQkwXWV4zziqTXVFRiKmYh8SvvnxHCk5P7ZsDY1O76L4iOR/kx0dcEkxy+WthTOPXGODO
 SwKT1XdwEM0sb0JpjDZhLIvVJdq6sjkwbJvmSZfrus45WIhfuYR13gEqMlE0X0OfguZbF61sC
 hriuWUKgkotEERQED7s78sXi5M4g9tOQ7BDDR1ph63utz60rP2RPWVV5XWIu8debiwqQx0oID
 LwXUTPGkF/QOHASoy3jYrIGd5Q3cMbyKzZVJbW0mFTwjVDuPWLVK1ToMWZY85zC5lh9d0mKi8
 wAKvTSanH1ESXddxd28Wz7WtaSWX8eYdmo6F9DPsBQ6XHOS3+RD9QRTU1kx9Ez50eLvQTYc+j
 nyeqred9oEhX9ENHKnL1OIwNVEc9O5E/Dm2xcrwgZIdktGRAiyFshcrkBgdN1ozUwQrPfnqUN
 d4I1m6eA+LMQzAZwkrDYFjP8q5Q6VEhvtlp8bL6ShZVFM8em5g=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 16:12:05 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/omap-aes.c  | 3 +--
 drivers/crypto/omap-des.c  | 3 +--
 drivers/crypto/omap-sham.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index a2bac3b869b6..82282a5e9b3f 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -1032,14 +1032,13 @@ static int omap_aes_get_res_pdev(struct omap_aes_dev *dd,
 static int omap_aes_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct omap_aes_dev *dd;
 	struct crypto_alg *algp;
 	struct aead_alg *aalg;
 	struct resource res;
 	int err = -ENOMEM, i, j, irq = -1;
 	u32 reg;
+	struct omap_aes_dev *dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
 
-	dd = devm_kzalloc(dev, sizeof(struct omap_aes_dev), GFP_KERNEL);
 	if (!dd)
 		goto err_data;
 
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index f4199be783a9..09833709fbed 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -957,13 +957,12 @@ static int omap_des_get_pdev(struct omap_des_dev *dd,
 static int omap_des_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct omap_des_dev *dd;
 	struct crypto_alg *algp;
 	struct resource *res;
 	int err = -ENOMEM, i, j, irq = -1;
 	u32 reg;
+	struct omap_des_dev *dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
 
-	dd = devm_kzalloc(dev, sizeof(struct omap_des_dev), GFP_KERNEL);
 	if (!dd)
 		goto err_data;
 
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 7aa4eb50ebc9..ffa3ac3bde55 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2015,14 +2015,13 @@ static int omap_sham_get_res_pdev(struct omap_sham_dev *dd,
 
 static int omap_sham_probe(struct platform_device *pdev)
 {
-	struct omap_sham_dev *dd;
 	struct device *dev = &pdev->dev;
 	struct resource res;
 	dma_cap_mask_t mask;
 	int err, i, j;
 	u32 rev;
+	struct omap_sham_dev *dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
 
-	dd = devm_kzalloc(dev, sizeof(struct omap_sham_dev), GFP_KERNEL);
 	if (dd == NULL) {
 		err = -ENOMEM;
 		goto data_err;
-- 
2.16.1
