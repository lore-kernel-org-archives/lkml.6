Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A3FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6536208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB5USoJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6536208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJFC3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:29:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35444 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeJFC3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:29:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so2905847wmf.0;
        Fri, 05 Oct 2018 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJslNTIhKlX4jBTV6vpXO0I7iz/yHIycv0/frUOM21c=;
        b=JB5USoJ0c2xdE2ZfBFmHHhUFHZ3IMz/4qF1N6pRwqAP7FVoFlQ3kV98//pD9EVne0K
         EgFZSoSkkf1ZN+psd7Pv7XCBTGVkBCDnbR7/T81VNLbS++Suz22mklsLc6hrY08vY6R4
         UFBa0nIwXVOgg05VdcDUwnb5U56FfXcJUyV0shWMhG6634mhT4OXpVrIYh399FELiuJR
         CGKYloKf21BrUKio3zEUGyGPluVELZeCCWKGGfmD64UzCGNXGHiK/RTGV30VJb71Z7Ub
         S6DNta4RB/TLzXA0gYte1/G05wZIXctE4NAE4UXBhzbYaL6+hgnkXayctI9HCYsN+cGY
         Nvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJslNTIhKlX4jBTV6vpXO0I7iz/yHIycv0/frUOM21c=;
        b=e+yfibCuW+cewkLGUk9eHktliPJ+sSfiEhXlPEA8UKJrwE8uRzc/Q8qcjrKFIyoKMN
         ceiIZAvl2aiAsaNc0deUv1a6HasxVR1TPk4zGwZ0ryP8smhe24f2NVzERxhPVFCH3CF0
         LAvGQ54zFvFYJ0PJyVvLtmbvg0PQqMx6aPgqzG2TamSvaIjhFIJjI/x7ALtiOr0CmzjV
         8/K9V7bb2XWACGbFqW4njyoun6ImeTGFC5ys5qYGG7UX0XbTKxFhBs16bQw08v72FnsN
         at1cFlVz3AA0bBfAMj0D82cGODiQB/LFhzrF4p1iQEldWkyJFULjU826ybD3YwABwnn/
         xsiw==
X-Gm-Message-State: ABuFfojs6kBS+bS7G2poIKEnJiM+W/kPQHUahN/3xpSHmQFLI7TMfImd
        1Zu1997axRZsGOO+gJM9Wj0=
X-Google-Smtp-Source: ACcGV61Cn29Y2RyiE0Urz+oUtv7S9+zciBArgzZ2xiQiJYpMenVeqYDGsHO4X5f/lVAqqyjJoqlsMA==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr9134823wme.111.1538767743558;
        Fri, 05 Oct 2018 12:29:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u191-v6sm3034403wmd.31.2018.10.05.12.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:29:02 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3] spi: spi-ep93xx: Use dma_data_direction for ep93xx_spi_dma_{finish,prepare}
Date:   Fri,  5 Oct 2018 12:25:09 -0700
Message-Id: <20181005192508.18659-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004024010.15986-1-natechancellor@gmail.com>
References: <20181004024010.15986-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:428:58: note: expanded from macro
'dma_map_sg'
#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
                               ~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
3 warnings generated.

dma_{,un}map_sg expect an enum of type dma_data_direction but this
driver uses dma_transfer_direction for everything. Convert the driver to
use dma_data_direction for these two functions.

There are two places that strictly require an enum of type
dma_transfer_direction: the direction member in struct dma_slave_config
and the direction parameter in dmaengine_prep_slave_sg. To avoid using
an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
to safely map between the two types because they are not 1 to 1 in
meaning.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix escaped hash symbols for '#define' lines (\# -> #)

v2 -> v3:

* Instead of changing the dir parameter in the prepare and finish
  functions, convert the driver to use dma_data_direction for everywhere
  that makes sense. Add a helper function to convert between the two
  types as there is still a couple of locations that need a transfer
  enum (and no such function exists). Alternatively, the function could
  just convert from transfer -> data and be used in dma_{,un}map_sg and
  the rest of the driver be left alone. Hopefully I understood what Mika
  wanted!

 drivers/spi/spi-ep93xx.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index f1526757aaf6..667da7964d63 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -246,6 +246,19 @@ static int ep93xx_spi_read_write(struct spi_master *master)
 	return -EINPROGRESS;
 }
 
+static enum dma_transfer_direction
+ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		return DMA_MEM_TO_DEV;
+	case DMA_FROM_DEVICE:
+		return DMA_DEV_TO_MEM;
+	default:
+		return DMA_TRANS_NONE;
+	}
+}
+
 /**
  * ep93xx_spi_dma_prepare() - prepares a DMA transfer
  * @master: SPI master
@@ -257,7 +270,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
  */
 static struct dma_async_tx_descriptor *
 ep93xx_spi_dma_prepare(struct spi_master *master,
-		       enum dma_transfer_direction dir)
+		       enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer = master->cur_msg->state;
@@ -277,9 +290,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	memset(&conf, 0, sizeof(conf));
-	conf.direction = dir;
+	conf.direction = ep93xx_dma_data_to_trans_dir(dir);
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		buf = xfer->rx_buf;
 		sgt = &espi->rx_sgt;
@@ -343,7 +356,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 	if (!nents)
 		return ERR_PTR(-ENOMEM);
 
-	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir, DMA_CTRL_ACK);
+	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents,
+				      ep93xx_dma_data_to_trans_dir(dir),
+				      DMA_CTRL_ACK);
 	if (!txd) {
 		dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
 		return ERR_PTR(-ENOMEM);
@@ -360,13 +375,13 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
  * unmapped.
  */
 static void ep93xx_spi_dma_finish(struct spi_master *master,
-				  enum dma_transfer_direction dir)
+				  enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_chan *chan;
 	struct sg_table *sgt;
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		sgt = &espi->rx_sgt;
 	} else {
@@ -381,8 +396,8 @@ static void ep93xx_spi_dma_callback(void *callback_param)
 {
 	struct spi_master *master = callback_param;
 
-	ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
-	ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+	ep93xx_spi_dma_finish(master, DMA_TO_DEVICE);
+	ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 
 	spi_finalize_current_transfer(master);
 }
@@ -392,15 +407,15 @@ static int ep93xx_spi_dma_transfer(struct spi_master *master)
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_async_tx_descriptor *rxd, *txd;
 
-	rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
+	rxd = ep93xx_spi_dma_prepare(master, DMA_FROM_DEVICE);
 	if (IS_ERR(rxd)) {
 		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
 		return PTR_ERR(rxd);
 	}
 
-	txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
+	txd = ep93xx_spi_dma_prepare(master, DMA_TO_DEVICE);
 	if (IS_ERR(txd)) {
-		ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+		ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
 		return PTR_ERR(txd);
 	}
-- 
2.19.0

