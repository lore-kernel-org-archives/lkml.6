Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E43DC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B993624454
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbFatzVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B993624454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965101AbeF2SxE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:53:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46780 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936729AbeF2Sw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:52:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so1556328pfl.13;
        Fri, 29 Jun 2018 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4V8ddSLke/gsEPETJSHH2JZLxPsQODdtBbtSduvOQmk=;
        b=YbFatzVY1lU84KzDak5jdhF7wuvKbAf9z34J+tbEOpgz6VQOhVt1mHgSVSIxOhlg0y
         C3hy9nN1gBOXW9m+wkxyLDtahFBCWgA7IgH+Oi3gesayFqTLhUDoAOAh0bApsVvWyf6t
         gRbYJkY/GkN5hExcXM1fxHxUaHQGdgximuIS1gDxh0pBM7hpuM1QGUQbXe/6j2EX8Qq3
         v3C8Ep9YTQt5Zd69Lh+/FngNCqCU6+94nd1X+vrEtoGixZAabP3aMvDaPdejbQMO1/sR
         SNmnbtsOTkBZ29FFD2X7K/YiYh3v+5FkuPOXqOSJtL+TQfyqwot9MoaP9W6jauT5/gZi
         8xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4V8ddSLke/gsEPETJSHH2JZLxPsQODdtBbtSduvOQmk=;
        b=ub5RjJSFn7Z2nwTvm+H9RrEO3hx+e2gWsI4vA7VIcKNv5zh34Y/shzv8HoTDmFyTth
         MJB+zyM8YjzGI/+BCjz4pdik9Sh/mN7yqSu4FsrLZC5sEcLpEZBO7SuK9sOFYX3sFw56
         coYezt2GGlaKlUwK3jVwGQoIusYiJWV7LkEpevsPzh84XlPKyDFl9ZM6kyLFjneApRgT
         zDLMCbGmJ93+fieVnv5iWzwBFxT5K5NLHt8eCGISdewBJVb7xx09nUQcBXqgnVyah1H8
         bUZCrzrhw1rBxjuN3rKOM8xIdugTtl25PrBi2+owB/NZ0JGBbBcxDtgp/IAbBL5nuCI8
         qOTw==
X-Gm-Message-State: APt69E1Ct+irrBb24RYRK18k/5i5Z7cuZwSD4B4Bea2o1zXBTGy1CDGJ
        AZ4kXEDdLp+HfdI/rLR4zLrO+A==
X-Google-Smtp-Source: AAOMgpdQ4vkaHjd97OCI2ecH/qg24YK3Qfv/N6FCFD4E8VT9tLNj1jwcUMrmYIBGpfQxnTf31PKGRQ==
X-Received: by 2002:a62:a104:: with SMTP id b4-v6mr15763168pff.159.1530298376617;
        Fri, 29 Jun 2018 11:52:56 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:52:55 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/17] media: imx: mipi csi-2: Register a subdev notifier
Date:   Fri, 29 Jun 2018 11:49:53 -0700
Message-Id: <1530298220-5097-10-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse neighbor remote devices on the MIPI CSI-2 input port, add
them to a subdev notifier, and register the subdev notifier for the
MIPI CSI-2 receiver, by calling v4l2_async_register_fwnode_subdev().

csi2_parse_endpoints() is modified to be the parse_endpoint callback.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 31 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index ceeeb30..94eb9a1 100644
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
2.7.4

