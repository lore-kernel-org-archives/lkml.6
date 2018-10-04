Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549FFC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0457D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBsSd7dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0457D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJDJcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:32:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45186 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJDJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:32:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so8146540wrw.12;
        Wed, 03 Oct 2018 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJSKrio22NlkYYDsuqgweH6hG0jGbKbbsbhpnCHyk8E=;
        b=gBsSd7dzCNZoBQJ3CeqYYhZa1xFrGIH8vhVzyBwji3Yt3TTM5Sio0bwV9bxE3rDP4g
         FBOJdyUUiSQmsj87eLdocLAMBr+Zvq5Kn4T2clYinhVyJAHAsan35nC7WhGgMHJM5wEr
         btDw4Rkd31y0DdPEHNyynLq79ugEz3lj3xzKpDrTncj2CKpGGUHdWA8jvuZ9R2YguCBm
         f23WbrkQC8pO1WJn+bwk5KJ1XnNX+UZXg5g3hNoDnaZIYYDwVjdw7iOAUgJ1zxAqJucD
         oXU691/PbFw4YmQZXEznnGh23Lnt3IxviwtnFux++x2pLQZEXVNjHQmzsI/1qx0aIIQY
         GYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJSKrio22NlkYYDsuqgweH6hG0jGbKbbsbhpnCHyk8E=;
        b=F+o3FfxtDFsC+YqA+zHdidqkl/ocg+uiEW63kIzQUocFVWnS6DJcPQHPFICXIaC4kJ
         Bj5jQsZGD7UxVslXGHCzq33nx9x9U7u9S0inNswwFpholeJtA7qIeJ+pw4xnrMfEPez8
         74OSuU1IznqA6n5p7J6ctog76RCEPMpIOq8VB5DpWJ5ZFBWPMW9C2ms/zRAhKBhf4gEF
         J59+B1nfl6QvkqRc9dhtQDpdNwdEe7ahzcq4TiCSU+yjeg7CowOdBY41JAzHq/8TuyX/
         cGYuNFhfuxs+aNOn2zXlUAZ6bZ0q6RnKwD4LPP0muRzpOoQHzItYqPr6N20wxDtduHxV
         Gg6w==
X-Gm-Message-State: ABuFfoiUFupUyaqIkICPIOTcmvIMF6X81fPPiboeVGV0v9YwucxRTXT7
        liAH/+ophR0i9xYziekZ0KE=
X-Google-Smtp-Source: ACcGV61c3QcU3yXb4dW60po9wqQYM18Xs+TN0Wws+DHUKgUJKyluCDUtvBQchPmlLgEQQR34i2RmzA==
X-Received: by 2002:a5d:44ce:: with SMTP id z14-v6mr3298107wrr.286.1538620877165;
        Wed, 03 Oct 2018 19:41:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 12-v6sm4313319wms.11.2018.10.03.19.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 19:41:16 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] spi: spi-ep93xx: Change dir type in ep93xx_spi_dma_{finish,prepare}
Date:   Wed,  3 Oct 2018 19:40:11 -0700
Message-Id: <20181004024010.15986-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004023926.15847-1-natechancellor@gmail.com>
References: <20181004023926.15847-1-natechancellor@gmail.com>
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

dma_{,un}map_sg expects an enum of type dma_data_direction but this
driver uses dma_transfer_direction for everything. Converting to
dma_data_direction would be desirable but there are a few shared
structures that expect dma_transfer_direction so it is just simpler to
change the parameter here. dma_transfer_direction and dma_data_direction
are different sizes but this driver only uses the 1 and 2 values which
mean the same thing so this change is safe.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix escaped hash symbols for '#define' lines

 drivers/spi/spi-ep93xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index f1526757aaf6..189fc2225b69 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -256,8 +256,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
  * in case of failure.
  */
 static struct dma_async_tx_descriptor *
-ep93xx_spi_dma_prepare(struct spi_master *master,
-		       enum dma_transfer_direction dir)
+ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer = master->cur_msg->state;
@@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
  * Function finishes with the DMA transfer. After this, the DMA buffer is
  * unmapped.
  */
-static void ep93xx_spi_dma_finish(struct spi_master *master,
-				  enum dma_transfer_direction dir)
+static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_chan *chan;
-- 
2.19.0

