Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx4/KgcK1sYxtEviLLtv7RQSSApR9nZbHv4mvWYzs7P6GC2/bhyY0D0bLrD1Xa2PLyR1PBy9U
ARC-Seal: i=1; a=rsa-sha256; t=1522679261; cv=none;
        d=google.com; s=arc-20160816;
        b=P73KI4G7BnpHr7BftiEUlYrw0hXDy5kWvvKFbDu23vzC0jNdWOd6AbLo0VCrbOkIzk
         NwqN0u5gxYiScZrdo8uXSanC64kG9Q71Wz32Oeo8iujqTzSBDcGQypduEz2JC2Ek/Xa+
         fkMpPIsUlYhVcd8p+49O0b4hlQiX50AgPz7gaszXNmQEnGnpz5fsMh3Ana7lfOQOr4eI
         FQ0xP/8lcbhgE+qXQ8lVtBDnSafPVNbw3ptraYrDyWuJersX0v2gNEd7y039geuhcp/z
         uc8SQEpHd5oJ0+/W9L9bt84E+h/h74R0RichLd34o1tbMp+mOFAfIJGA/oLq3XLuSt1H
         EhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=zLeB3/6cn/b0MZ2zBEIIxUt5oBS/fZ77qQIhL+Ctbzo=;
        b=XW5fY3qFStWPPup3x7DagP/nwghqWUcq+m37TavgamrbLU7Z7mGxFHy/q2l6NQsnCy
         67pWeQkuJhcPq8cE/uS5bUGBrQfk8BxIU4awZhFi9uowb9dJN1f89979tZHm+gJUXS7u
         IPHakKJIB/GKadXw4X8x37eLqKsEMHeIkEq5YpwO1UBvD0ZhgNfoY9jOqqT6uZMNWVTy
         nnvLf1zeckZhp/um5q0XRY4CirDaNgNYP1GZVB+s7+5cffDKlW2puuGsYlhkI75ktLup
         Hclh9ztMfWKp8h7IVaVLsP3XYMaabkGy0pokRlBGxb78dpqvhM8Q/g/68hAKJs2GgiJ9
         GIFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:27:40 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Samuel Ortiz <samuel@sortiz.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Petr Cvek <petr.cvek@tul.cz>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Pravin Shedge <pravin.shedge4linux@gmail.com>,
	Flavio Ceolin <flavio.ceolin@intel.com>,
	Robert Jarzmik <robert.jarzmik@renault.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	devel@driverdev.osuosl.org,
	alsa-devel@alsa-project.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 04/15] media: pxa_camera: remove the dmaengine compat need
Date: Mon,  2 Apr 2018 16:26:45 +0200
Message-Id: <20180402142656.26815-5-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644928520099498?=
X-GMAIL-MSGID: =?utf-8?q?1596644928520099498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Jarzmik <robert.jarzmik@renault.com>

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/media/platform/pxa_camera.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index c71a00736541..4c82d1880753 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -2357,8 +2357,6 @@ static int pxa_camera_probe(struct platform_device *pdev)
 		.src_maxburst = 8,
 		.direction = DMA_DEV_TO_MEM,
 	};
-	dma_cap_mask_t mask;
-	struct pxad_param params;
 	char clk_name[V4L2_CLK_NAME_SIZE];
 	int irq;
 	int err = 0, i;
@@ -2432,34 +2430,20 @@ static int pxa_camera_probe(struct platform_device *pdev)
 	pcdev->base = base;
 
 	/* request dma */
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_cap_set(DMA_PRIVATE, mask);
-
-	params.prio = 0;
-	params.drcmr = 68;
-	pcdev->dma_chans[0] =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &params, &pdev->dev, "CI_Y");
+	pcdev->dma_chans[0] = dma_request_slave_channel(&pdev->dev, "CI_Y");
 	if (!pcdev->dma_chans[0]) {
 		dev_err(&pdev->dev, "Can't request DMA for Y\n");
 		return -ENODEV;
 	}
 
-	params.drcmr = 69;
-	pcdev->dma_chans[1] =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &params, &pdev->dev, "CI_U");
+	pcdev->dma_chans[1] = dma_request_slave_channel(&pdev->dev, "CI_U");
 	if (!pcdev->dma_chans[1]) {
 		dev_err(&pdev->dev, "Can't request DMA for Y\n");
 		err = -ENODEV;
 		goto exit_free_dma_y;
 	}
 
-	params.drcmr = 70;
-	pcdev->dma_chans[2] =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &params, &pdev->dev, "CI_V");
+	pcdev->dma_chans[2] = dma_request_slave_channel(&pdev->dev, "CI_V");
 	if (!pcdev->dma_chans[2]) {
 		dev_err(&pdev->dev, "Can't request DMA for V\n");
 		err = -ENODEV;
-- 
2.11.0
