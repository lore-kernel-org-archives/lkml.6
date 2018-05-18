Return-Path: <daniel@zonque.org>
X-Google-Smtp-Source: AB8JxZqOuYQFzoYJ8ot4wTaHxcrEkRHK59ekO8unqSLI8LWnS6wpm42oFfbY+YSFixvWLd5UEs/v
ARC-Seal: i=1; a=rsa-sha256; t=1526679065; cv=none;
        d=google.com; s=arc-20160816;
        b=FR4x2sXFYBjG44zMt2zt+tdjnoMmZNMacQKGUQh3u0eBhdQt8I67D+haRIru4i5hE0
         NwbQuo/GMLLzhjm+ef5nsmIPQxtECh9j2sBjcsSSr2skvxihou//Z0beqfylrVfoEZ6w
         05YLOgTp2+pzPBJEt48o7fMFclkTIoyWGIV8MoMaFi+EnKfQB3zx7a0AZw7VvBr9vaRa
         Ow2sB3XiYHGYrAruNai+St4qqy3zUkTlaGfViQJmQ+aaRnxUCwtUx4CARscRXPGPyrnm
         2eGgnO5kyWYw8rV1GlDXMitpnVT9M5vFz8+JZw153GkDgoel733QdERkYG4T4k2jzObn
         Gz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=MooH3a2xJ31/NYZhAat7GN2TIAHzVCgoA37Bn+O/SMo=;
        b=gKhzINZiHBeZ8ZFvOeKnxkNNJI1qA1LugCGAideDQI24wQiKVIfB7OalzOJtcuFliI
         7tOTOR1c+mGP0CSyNGtgZcO3yAOaIFexGhu2dvsFWBkf29QVv0ZrycKyTn37JvZOYQ72
         iV+6NaZycjwuZ2Cy8rcRxhogYQFXwHkTlc36JsFfFBasKxtX5iqEWFqdJI+oRGB1WJ0c
         jkX47+0S6qydFRYaou5Jd2B1jFfdm1iz/JgF7fFWgy/Wt2uGWBqpCArtp+EVismJkFF7
         ivvT3EeWO72CPuxHYXaaH1IKdW0cJ4nVCoyhWwuol0XEzbVjZ2SzIbGLotcrI05EQcqs
         b0xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of daniel@zonque.org designates 46.23.86.59 as permitted sender) smtp.mailfrom=daniel@zonque.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of daniel@zonque.org designates 46.23.86.59 as permitted sender) smtp.mailfrom=daniel@zonque.org
Subject: Re: [PATCH 05/15] mtd: nand: pxa3xx: remove the dmaengine compat need
To: Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Nicolas Pitre <nico@fluxnic.net>, Samuel Ortiz <samuel@sortiz.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
 devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Robert Jarzmik <robert.jarzmik@renault.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-6-robert.jarzmik@free.fr>
From: Daniel Mack <daniel@zonque.org>
Message-ID: <a09d80dc-e8fd-1e9a-1878-8875ddc83134@zonque.org>
Date: Fri, 18 May 2018 23:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180402142656.26815-6-robert.jarzmik@free.fr>
Content-Type: multipart/mixed;
 boundary="------------39EE53F47ACFCC5932325DF0"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644931360963410?=
X-GMAIL-MSGID: =?utf-8?q?1600839027353381994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------39EE53F47ACFCC5932325DF0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Robert,

Thanks for this series.

On Monday, April 02, 2018 04:26 PM, Robert Jarzmik wrote:
> From: Robert Jarzmik <robert.jarzmik@renault.com>
> 
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
> 
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>   drivers/mtd/nand/pxa3xx_nand.c | 10 +---------

This driver was replaced by drivers/mtd/nand/raw/marvell_nand.c 
recently, so this patch can be dropped. I attached a version for the new 
driver which you can pick instead.


Thanks,
Daniel

--------------39EE53F47ACFCC5932325DF0
Content-Type: text/x-patch;
 name="0001-mtd-rawnand-marvell-remove-dmaengine-compat-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mtd-rawnand-marvell-remove-dmaengine-compat-code.patch"

>From c63bc40bdfe2d596e42919235840109a2f1b2776 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Sat, 12 May 2018 21:50:13 +0200
Subject: [PATCH] mtd: rawnand: marvell: remove dmaengine compat code

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index ebb1d141b900..30017cd7d91c 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2612,8 +2612,6 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 						    dev);
 	struct dma_slave_config config = {};
 	struct resource *r;
-	dma_cap_mask_t mask;
-	struct pxad_param param;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_PXA_DMA)) {
@@ -2632,14 +2630,7 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 		return -ENXIO;
 	}
 
-	param.drcmr = r->start;
-	param.prio = PXAD_PRIO_LOWEST;
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	nfc->dma_chan =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param, nfc->dev,
-						 "data");
+	nfc->dma_chan = dma_request_slave_channel(nfc->dev, "data");
 	if (!nfc->dma_chan) {
 		dev_err(nfc->dev,
 			"Unable to request data DMA channel\n");
-- 
2.14.3


--------------39EE53F47ACFCC5932325DF0--
