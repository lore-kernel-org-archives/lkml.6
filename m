Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56F7C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1551208B3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNcwqRtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1551208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeI3CYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35923 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeI3CYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so3257353pgv.3;
        Sat, 29 Sep 2018 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVp5a2nWozC6KcAR667nDInnw3w1AXgzDlQwp5Coil8=;
        b=KNcwqRtdtmoxhyptGVVnwq/3pMLJqvLrubhvPCKqa5oaBc7RIYH6ERVb1KFIITjRIA
         i7hgG3nbPnBIwFAlv2Epm2VJfcNafKQE7NKJUnGC+NxDOpFnDDTWgBL2Rw1h2EcQn50w
         XZoX33JgFgBfL1LdVF0xp5puuhk9L7v5mC45P9qkp8yWtGyMC2Aq4VqXBqedW0htgUoG
         ToLFoGUAsO/0GgN8cNopqIZ4OBffTTi/z1SmZlBGKlbFjOBrzJsNi0d0RGJivqFpFJAA
         RO4dWVO0LwjXouqidyIu5dFN/snyUfEaplUm8XWzekiwy4ujxh3p5F7VErloSx6AcLJ1
         ph9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVp5a2nWozC6KcAR667nDInnw3w1AXgzDlQwp5Coil8=;
        b=j2ydDWEwwaOK0cPujpprfgsrJu2aVOuLr0R6rzjHWz/vV3CEdUD1a0TTTU5r84rMMk
         KHI7ExDlMlOkcJh1iE7adPYVPtPSTxfhbjPDS1Z7gx1cNk6rJGaAxXC3NJcM8Eil0K8I
         Pg8Ol/HXRJRonXSwqD3jSgh3LnsCe+t/Z6b+wdM5yUa3ZJ0hvkTTRiIyuzOs7bY4xnCJ
         xJb/SvJBgbaY5M9leJG/JXk0EHkaffGChaDJCtDOrbMVUxcqhq2N5fvISQQvOkPPWzBQ
         lQtHtwyeXmGZnShcvr+IqcWqDkGKf7ZM9oA5etng++TNBwJHq3gqvx4E+yhVkl4ttbbx
         agRg==
X-Gm-Message-State: ABuFfojiA/YiZ3TEVVaXqDKECAqfRAfZ4t/M3N+dQ4XjFGGoiucfDdHA
        PxvjrPnqtYRorldtU53UPSX3nv/e
X-Google-Smtp-Source: ACcGV62gErIkI1/s09bQuObWZpk8dAO73/I9SdIz304zhwgrXRbOb06UTddg5lihbwwbMPNtu7F6zw==
X-Received: by 2002:a17:902:4281:: with SMTP id h1-v6mr4487112pld.134.1538250898399;
        Sat, 29 Sep 2018 12:54:58 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:57 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 09/17] media: imx: mipi csi-2: Register a subdev notifier
Date:   Sat, 29 Sep 2018 12:54:12 -0700
Message-Id: <20180929195420.28579-10-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse neighbor remote devices on the MIPI CSI-2 input port, add
them to a subdev notifier, and register the subdev notifier for the
MIPI CSI-2 receiver, by calling v4l2_async_register_fwnode_subdev().

csi2_parse_endpoints() is modified to be the parse_endpoint callback.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 31 ++++++++++------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 7b457a4b7df5..d60a52cfc69c 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -551,35 +551,34 @@ static const struct v4l2_subdev_internal_ops csi2_internal_ops = {
 	.registered = csi2_registered,
 };
 
-static int csi2_parse_endpoints(struct csi2_dev *csi2)
+static int csi2_parse_endpoint(struct device *dev,
+			       struct v4l2_fwnode_endpoint *vep,
+			       struct v4l2_async_subdev *asd)
 {
-	struct device_node *node = csi2->dev->of_node;
-	struct device_node *epnode;
-	struct v4l2_fwnode_endpoint ep;
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct csi2_dev *csi2 = sd_to_dev(sd);
 
-	epnode = of_graph_get_endpoint_by_regs(node, 0, -1);
-	if (!epnode) {
-		v4l2_err(&csi2->sd, "failed to get sink endpoint node\n");
+	if (!fwnode_device_is_available(asd->match.fwnode)) {
+		v4l2_err(&csi2->sd, "remote is not available\n");
 		return -EINVAL;
 	}
 
-	v4l2_fwnode_endpoint_parse(of_fwnode_handle(epnode), &ep);
-	of_node_put(epnode);
-
-	if (ep.bus_type != V4L2_MBUS_CSI2) {
+	if (vep->bus_type != V4L2_MBUS_CSI2) {
 		v4l2_err(&csi2->sd, "invalid bus type, must be MIPI CSI2\n");
 		return -EINVAL;
 	}
 
-	csi2->bus = ep.bus.mipi_csi2;
+	csi2->bus = vep->bus.mipi_csi2;
 
 	dev_dbg(csi2->dev, "data lanes: %d\n", csi2->bus.num_data_lanes);
 	dev_dbg(csi2->dev, "flags: 0x%08x\n", csi2->bus.flags);
+
 	return 0;
 }
 
 static int csi2_probe(struct platform_device *pdev)
 {
+	unsigned int sink_port = 0;
 	struct csi2_dev *csi2;
 	struct resource *res;
 	int ret;
@@ -601,10 +600,6 @@ static int csi2_probe(struct platform_device *pdev)
 	csi2->sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
 	csi2->sd.grp_id = IMX_MEDIA_GRP_ID_CSI2;
 
-	ret = csi2_parse_endpoints(csi2);
-	if (ret)
-		return ret;
-
 	csi2->pllref_clk = devm_clk_get(&pdev->dev, "ref");
 	if (IS_ERR(csi2->pllref_clk)) {
 		v4l2_err(&csi2->sd, "failed to get pll reference clock\n");
@@ -654,7 +649,9 @@ static int csi2_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &csi2->sd);
 
-	ret = v4l2_async_register_subdev(&csi2->sd);
+	ret = v4l2_async_register_fwnode_subdev(
+		&csi2->sd, sizeof(struct v4l2_async_subdev),
+		&sink_port, 1, csi2_parse_endpoint);
 	if (ret)
 		goto dphy_off;
 
-- 
2.17.1

