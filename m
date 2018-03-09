Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607056; cv=none;
        d=google.com; s=arc-20160816;
        b=djLF25KTBrFrZnLPJFYjRiPTd59XfZVUsiDam9qzVPokyXgEQd2vF2e5/7fcrfkVvK
         A71XmGzOO4O/5Fp0jFGLyoDjLQjdQbJnMHrvK9CC8CV95Dhac8eBmLv30+F4l26LN3/W
         WQ2OfTkTiUErLOW+kCrxNCQKyAIUd767iMOi4pbc8QTGvObQxHyKXtN1MGpvAhytcr2O
         7yCKI59luVX3x+R3TYSOzoS7kxcSeyMOd60eln4aXAYdxvOLObNxmR4LdI+E8frh7gAJ
         3orhrCai9pEnah9Y8TSycJu+aHPPfq/7dKNMUPOUWhrh887TlOrnhv7KsCj4n03lX29u
         KUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=1xqCUxyI79DAmSeIUQbewmE0e3acBTiWN2U03OuSA80=;
        b=k8FQRcxb9Zo+N+RVNIBGMk16aKf1rBu6NpxCNz4O+1/Co1z/cxvXY48ecAV5x1xqca
         gBBpvEO9s8JnY59lGmhMpqOtjETZPsJYfmMt2CB3KKCMerdP2PUwdzFIrEB0QmOfC7U3
         VUA4879rIEiAHUcJLjwr99roTeLySRBsokMKOxDqxqy57tfg0KyNjRvRzXGMx1AgezEI
         i8dLJzrkFqPnl5Z0O9qeGClK0yshyM+WHuDFIy/AQgyB5ivZUOAyUAsjaAz8Dk+J8Qvd
         L6Qbjmp/OVTNx9/iKt86fiO21T1IGX8whTKxj/mzRaqQd/LrusdmAuVwE3HudhH5I+oO
         U19g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Yzlc/oc2;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Yzlc/oc2;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELujbGy4SNfjSMOhuQFYljB76fP8qMnYRg9HiYAqaLDkBCnLbBWE0ETpEwAiBBeMvPSW//3kRw==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 25/25] nvmem: imx-ocotp: remove unused dead code
Date: Fri,  9 Mar 2018 14:47:19 +0000
Message-Id: <20180309144719.29904-26-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472064739493832?=
X-GMAIL-MSGID: =?utf-8?q?1594472064739493832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dong Aisheng <aisheng.dong@nxp.com>

remove unused dead code

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index f1482c664b19..60816c856dd6 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -439,7 +439,6 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 
 static int imx_ocotp_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct ocotp_priv *priv;
@@ -460,7 +459,6 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	of_id = of_match_device(imx_ocotp_dt_ids, dev);
 	priv->params = of_device_get_match_data(&pdev->dev);
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
-- 
2.15.1
