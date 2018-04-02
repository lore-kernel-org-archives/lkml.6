Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx4+CkIiBnwPbkawPwpAsijc84N0NhXHeyICJlKactFTpC6D9INTIr5yNrsGr+qNmXCxPPtaN
ARC-Seal: i=1; a=rsa-sha256; t=1522679286; cv=none;
        d=google.com; s=arc-20160816;
        b=yzSEQ1tJCQIPxzp3uvJYhdNmmw3jRUpYShXgahzJmXsioN4cI6uiWOPZyUMs6NvQi9
         Ph+puaYRna6OmlTv2W9yyC/qEzBBPVqqMznh86ycVCRnvGSVlZRmbzIBp5Yg9xd05cqm
         FfJlBroWP52x5I7VOELZ2XQRazLTtlDkYGu7n0/unREBeRufBqMO9XRCC4aU3+TW48m7
         mAPCwngdrd7fufkpGK/JmAY2zw2vGYekjmE4ccg7aVU9n0XT+S/+uxI4vhb7tKMWLzB4
         e7+jVbEc7+nZFGWItqLnT7sLg2ubSBpeQJH7E11wY5lxVCdxzL6yWyKzDTJh9ql0Fx8U
         jORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mvSPgJ/2uoXHRSyekrtaBAjtTP4XOLo2fLM1zc1FOEs=;
        b=FRP8RBi4L8+cbwI6ck0KqbH3v8zXFPwk0/tvEW+VFzGbX/vX5XvVWlUTYqhk2fvm9v
         KobselqMDcq97wDPpI1PeFDtiBSI00BPFeawPfi5+fWPT3ThGyyHziak3rIw2K20goXT
         9AS6NSObZUAAUo/03OSIU1KBtJ1qU4R/34zCO73JI252imeEmmVBH/cUEjLBdIq7RvNN
         ZwuEU4xMBngt68xxFGMCGpmp5baQPJRCab1ptomSU0j25BZDtlmvNBA/rgpxHpLInbBV
         bzgvWvyldDf8jI88kuTiypm86WwupzMFTgEBjs6bKNJV0lYFcH6+dRjKv43v7YH1CNwq
         A8qQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:28:05 +0200
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
	"David S. Miller" <davem@davemloft.net>,
	Robert Jarzmik <robert.jarzmik@renault.com>,
	"yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	devel@driverdev.osuosl.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 07/15] net: smc91x: remove the dmaengine compat need
Date: Mon,  2 Apr 2018 16:26:48 +0200
Message-Id: <20180402142656.26815-8-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644955289874784?=
X-GMAIL-MSGID: =?utf-8?q?1596644955289874784?=
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
 drivers/net/ethernet/smsc/smc91x.c | 12 +-----------
 drivers/net/ethernet/smsc/smc91x.h |  1 -
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 080428762858..4c600f430f6d 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2018,18 +2018,8 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	lp->cfg.flags |= SMC91X_USE_DMA;
 #  endif
 	if (lp->cfg.flags & SMC91X_USE_DMA) {
-		dma_cap_mask_t mask;
-		struct pxad_param param;
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		param.prio = PXAD_PRIO_LOWEST;
-		param.drcmr = -1UL;
-
 		lp->dma_chan =
-			dma_request_slave_channel_compat(mask, pxad_filter_fn,
-							 &param, &dev->dev,
-							 "data");
+			dma_request_slave_channel(lp->device, "data");
 	}
 #endif
 
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 08b17adf0a65..e849b6c2fa60 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -327,7 +327,6 @@ struct smc_local {
  * as RX which can overrun memory and lose packets.
  */
 #include <linux/dma-mapping.h>
-#include <linux/dma/pxa-dma.h>
 
 #ifdef SMC_insl
 #undef SMC_insl
-- 
2.11.0
