Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CC7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386732086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386732086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeIDAs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:48:29 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.194]:29984 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727501AbeIDAs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:48:29 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id BAAFA7F23
        for <linux-kernel@vger.kernel.org>; Mon,  3 Sep 2018 15:26:39 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wvQMflnOXbXuJwvQbf6Ca7; Mon, 03 Sep 2018 15:26:39 -0500
X-Authority-Reason: nr=8
Received: from [189.250.106.191] (port=44510 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fwvQL-003Bnd-KU; Mon, 03 Sep 2018 15:26:13 -0500
Date:   Mon, 3 Sep 2018 15:26:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drxj: fix spelling mistake in fall-through annotations
Message-ID: <20180903202613.GA28844@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.191
X-Source-L: No
X-Exim-ID: 1fwvQL-003Bnd-KU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.191]:44510
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "falltrough" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index 9628d40..551b7d6 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -3555,8 +3555,8 @@ static int ctrl_set_uio_cfg(struct drx_demod_instance *demod, struct drxuio_cfg
 		if (!ext_attr->has_smatx)
 			return -EIO;
 		switch (uio_cfg->mode) {
-		case DRX_UIO_MODE_FIRMWARE_SMA:	/* falltrough */
-		case DRX_UIO_MODE_FIRMWARE_SAW:	/* falltrough */
+		case DRX_UIO_MODE_FIRMWARE_SMA:	/* fall through */
+		case DRX_UIO_MODE_FIRMWARE_SAW:	/* fall through */
 		case DRX_UIO_MODE_READWRITE:
 			ext_attr->uio_sma_tx_mode = uio_cfg->mode;
 			break;
@@ -3579,7 +3579,7 @@ static int ctrl_set_uio_cfg(struct drx_demod_instance *demod, struct drxuio_cfg
 		if (!ext_attr->has_smarx)
 			return -EIO;
 		switch (uio_cfg->mode) {
-		case DRX_UIO_MODE_FIRMWARE0:	/* falltrough */
+		case DRX_UIO_MODE_FIRMWARE0:	/* fall through */
 		case DRX_UIO_MODE_READWRITE:
 			ext_attr->uio_sma_rx_mode = uio_cfg->mode;
 			break;
@@ -3603,7 +3603,7 @@ static int ctrl_set_uio_cfg(struct drx_demod_instance *demod, struct drxuio_cfg
 		if (!ext_attr->has_gpio)
 			return -EIO;
 		switch (uio_cfg->mode) {
-		case DRX_UIO_MODE_FIRMWARE0:	/* falltrough */
+		case DRX_UIO_MODE_FIRMWARE0:	/* fall through */
 		case DRX_UIO_MODE_READWRITE:
 			ext_attr->uio_gpio_mode = uio_cfg->mode;
 			break;
@@ -3639,7 +3639,7 @@ static int ctrl_set_uio_cfg(struct drx_demod_instance *demod, struct drxuio_cfg
 			}
 			ext_attr->uio_irqn_mode = uio_cfg->mode;
 			break;
-		case DRX_UIO_MODE_FIRMWARE0:	/* falltrough */
+		case DRX_UIO_MODE_FIRMWARE0:	/* fall through */
 		default:
 			return -EINVAL;
 			break;
-- 
2.7.4

