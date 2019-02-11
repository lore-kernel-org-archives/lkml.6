Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58007C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220E8222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896190;
	bh=TshDJp4rhht05eVUbSaIMCMxJGIebZdz/BibrXPO5jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2LRKgwvofQANt167yKGtlHSaTVAbCgb00OwqCO1n2xIjhmbVdy6FK674M2XTvC2O
	 iXglJdiKyq9Maw7c5xuuXcvabqzHU8oKlnozcuyOkHtuGhoMr02yj5ODCzhOLJsE37
	 eQ9T3ehFovr4aJ6ygAjR1PkAXpC+6cMEsTD6v/JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbfBKOnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731778AbfBKOnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AABAF2081B;
        Mon, 11 Feb 2019 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896185;
        bh=TshDJp4rhht05eVUbSaIMCMxJGIebZdz/BibrXPO5jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvYEAE3GcOE/cVsovpuuOsyjTyNic+zcRyo5UxVX78Z2VJjn3EodtDO5CM6RwP+4y
         /ayinqY6yVOfqXEoxCI0YE8oVIIWoN71Nem7rw00oeWvBFPKNcuUA4t2xjuvbevJmu
         o82ecEbaFzN/jXIy2Otg07/QcLbj18suIdp41tYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 101/313] media: imx274: select REGMAP_I2C
Date:   Mon, 11 Feb 2019 15:16:21 +0100
Message-Id: <20190211141900.611214578@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4f9d7225c70dd9d3f406b79e60f8dbd2cd5ae743 ]

The imx274 driver uses regmap and the build will fail without it.

Fixes:

  drivers/media/i2c/imx274.c:142:21: error: variable ‘imx274_regmap_config’ has initializer but incomplete type
   static const struct regmap_config imx274_regmap_config = {
                       ^~~~~~~~~~~~~
  drivers/media/i2c/imx274.c:1869:19: error: implicit declaration of function ‘devm_regmap_init_i2c’ [-Werror=implicit-function-declaration]
    imx274->regmap = devm_regmap_init_i2c(client, &imx274_regmap_config);
                     ^~~~~~~~~~~~~~~~~~~~

and others.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 041a777dfdee..63c9ac2c6a5f 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -611,6 +611,7 @@ config VIDEO_IMX274
 	tristate "Sony IMX274 sensor support"
 	depends on I2C && VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
 	depends on MEDIA_CAMERA_SUPPORT
+	select REGMAP_I2C
 	---help---
 	  This is a V4L2 sensor driver for the Sony IMX274
 	  CMOS image sensor.
-- 
2.19.1



