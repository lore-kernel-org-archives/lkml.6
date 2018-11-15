Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A23C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53062145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53062145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbeKPBAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:00:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42915 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388562AbeKPA64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:58:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 56AC220D7C; Thu, 15 Nov 2018 15:50:47 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6B76E20D83;
        Thu, 15 Nov 2018 15:50:28 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 06/15] soc: sunxi: sram: Add support for the H5 SoC system control
Date:   Thu, 15 Nov 2018 15:50:04 +0100
Message-Id: <20181115145013.3378-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the H5 SoC compatible to the list of device-tree matches for
the SRAM driver. Since the variant is the same as the A64 (that precedes
the H5), the same variant description is used.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index afa86b5506eb..9df844dffffe 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -393,6 +393,10 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun50i-a64-system-control",
 		.data = &sun50i_a64_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,sun50i-h5-system-control",
+		.data = &sun50i_a64_sramc_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
-- 
2.19.1

