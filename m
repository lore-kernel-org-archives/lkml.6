Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AG47ELsS5H9PI8WLdreFRJwY6pAin6CZELMrAhZjMcPFvUTY+wbJvaBI5nqJVdZbU2RU3+pIkR3o
ARC-Seal: i=1; a=rsa-sha256; t=1519877380; cv=none;
        d=google.com; s=arc-20160816;
        b=dXYOC+faXkDfscF2Mb33N/uJAh2mL+uk8vYks6haWKnoT8jUyz/Vpr8JngND+0iJL6
         xLqcmr7syWV/Fdx0CM/JXPtRB+ppeJZWXfKONH4yMQa40c7b1y/VRT3PGpKJHqYAdg7a
         fl2TXC/ek+Idd4Slt29IUDxom+w5YLEUS5F1MCAVuBgovFQ9C/l7A1ocwR0pq5NzQoy8
         hBfxrqgmN/mldCuY2jEsKUG51POITvM7Z3waojlEcGfC9nwbIFwa2CDkh0CkJV6Rgxbz
         nqvP8VA8e1zLRflThsR2kkSSjMtoqZTTdQvXptXX2c5BZSlpW1dG4qXoP/zZYNH67/+w
         0ZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=23EwDOGMo3Npqzn49bimbRmzpd3D1ZPh1V37HrsGmeM=;
        b=fvxu6aWet7GCdZvtVCBfjYcWhGrGyQqxP7X/HoUCd/XpVvpa9LA+2PbLeaAVg999MD
         pVoQXoCzu8YdEw9s98Z2HWDOOqOAN8oAAjWp0Xb2yjHH2Q7BvMyknpFntIJ68Fn6DLGT
         XhbafjGOBl4He0I6zl1grLhsJtmDYUmGCnloih/a874lMzB0dX2rKN5Wb1VnoBOo1GW9
         l3NE9vExrDjqcQFGnrzdwmGx0YY/uG8kmsJ+G0N3fmq/OM+XgaDmJtPz29hOU3oW77D4
         2VLWDYYPNjXfekds3vNKmA0k0z2ucFisXzD+2drrtb8ejEbNrAd9HJo1KpAwfKJNbNKn
         JlqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.148.214 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.148.214 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Date: Wed, 28 Feb 2018 22:09:39 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Steve Longerbeam <slongerbeam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] staging/imx: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20180301040939.GA13274@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1erFXI-002bYM-4I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:55922
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593706944440057524?=
X-GMAIL-MSGID: =?utf-8?q?1593706944440057524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix inconsistent IS_ERR and PTR_ERR in imx_csi_probe.
The proper pointer to be passed as argument is pinctrl
instead of priv->vdev.

This issue was detected with the help of Coccinelle.

Fixes: 52e17089d185 ("media: imx: Don't initialize vars that won't be used")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 5a195f8..4f290a0 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1798,7 +1798,7 @@ static int imx_csi_probe(struct platform_device *pdev)
 	priv->dev->of_node = pdata->of_node;
 	pinctrl = devm_pinctrl_get_select_default(priv->dev);
 	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(priv->vdev);
+		ret = PTR_ERR(pinctrl);
 		goto free;
 	}
 
-- 
2.7.4
