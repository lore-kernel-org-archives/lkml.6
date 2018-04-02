Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx4/a97ri/1RyU3lU3460KcSkkCZzozIucIzskNf6yOms7wSHYkrr/Hl1o+VEt6WsQgq71Wrg
ARC-Seal: i=1; a=rsa-sha256; t=1522679263; cv=none;
        d=google.com; s=arc-20160816;
        b=iqiv0QbZIS6E0pL//zqBxlEksezW5iwoqrGM7/2MqhwxiKKoMartAaPluOU1AgRehR
         QeLkHqvn1RBqrWdY8cDq5Co4JF3+oR1kXRTtwNBdi6FbmWclennc5E2CiVPC5dMzxobi
         UR87mdSB0F+aSHajwzj/ws91Z5NjJtfDXpCXeY0BFsTqILawb+QAnu8jbvkfmVe0q05c
         tyvQvohzUJQ1PH12+bh+dCa0dKOZ2WG5VtJF0gKdiL9SFDSDi8sbew8c5aER8gUgJMgZ
         aLymLBpb3yc+DQVvh00ExJXGgkoNVklylnKRtrC590p4gONmbjfVymAhmFnkbgviKm2O
         w+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gFgJviuQ4gN30UHSe6Y8DHNIFeqVVROJ7HLRGNzpMCs=;
        b=ivzcz4Vt5gNXbzy/QW1COaqv6MILp+8SBIrHLDf4Q03lJUQ/eSNTbnmq/O0pZN3d7M
         nXRruN0oGsPHgaINJ1F5GxjcPTI5YxXCVgoZNF/4CFmEQiHW1FRgcxHjF3e0DckirzuH
         jdUYVkOW9U+fmvgE6Bk3WSjrKls8xffQhaTwyzj3rLkP9YEvnPdDpfSSXansznlKEZWN
         8A2cUNtcmY3lOxvh9lADNVCWJpu9PnUf4PWA2fRtgsJBmx5/iwC4dEAFzELu0xjusJUh
         damujquFnfqIAkw7u5Jl7P4s/e0TEU8GnKVfzvDzVqwJWO3H5pW3gZr6xEWF+swS0s3Y
         yF9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:27:42 +0200
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
	Arnd Bergmann <arnd@arndb.de>
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
	Robert Jarzmik <robert.jarzmik@renault.com>
Subject: [PATCH 05/15] mtd: nand: pxa3xx: remove the dmaengine compat need
Date: Mon,  2 Apr 2018 16:26:46 +0200
Message-Id: <20180402142656.26815-6-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644931360963410?=
X-GMAIL-MSGID: =?utf-8?q?1596644931360963410?=
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
 drivers/mtd/nand/pxa3xx_nand.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index d1979c7dbe7e..4a56a0aef5b1 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1518,8 +1518,6 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 {
 	struct platform_device *pdev = info->pdev;
 	struct dma_slave_config	config;
-	dma_cap_mask_t mask;
-	struct pxad_param param;
 	int ret;
 
 	info->data_buff = kmalloc(info->buf_size, GFP_KERNEL);
@@ -1533,13 +1531,7 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 		return ret;
 
 	sg_init_one(&info->sg, info->data_buff, info->buf_size);
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	param.prio = PXAD_PRIO_LOWEST;
-	param.drcmr = info->drcmr_dat;
-	info->dma_chan = dma_request_slave_channel_compat(mask, pxad_filter_fn,
-							  &param, &pdev->dev,
-							  "data");
+	info->dma_chan = dma_request_slave_channel(&pdev->dev, "data");
 	if (!info->dma_chan) {
 		dev_err(&pdev->dev, "unable to request data dma channel\n");
 		return -ENODEV;
-- 
2.11.0
