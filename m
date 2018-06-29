Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E38C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A4027C48
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEyo+95I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A4027C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936817AbeF2Sw6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:52:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41333 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933159AbeF2Swx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:52:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so4612681pff.8;
        Fri, 29 Jun 2018 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxigthHu1AM8Vx5XTX0i+P8p5MyB1vffC7g7ly8qY0Q=;
        b=oEyo+95IdXe7egYTsC+WrW1RZsKXbh5a6Zns48je0t1rOosbWId24gAUKxSS/ppcVo
         u5M0btKML70N7TCcgTm5RzFbJ2f5ePO6D87lXWB0QhInvNJK/a6BO3t1GDwjizSdybQS
         p46Okt5KD/wgwaSkU56anelHM0IekobooAEAmSmpgMzfELOJ/aK2w52sXUg0bCwuCe3F
         Kz6k8P61EpPZhRd4xDKQE8jHVoW/gyKhCavtli4hQ1C2v+O+OZ/pwVmIDCA5A1Ob8Etf
         Wm1eTGikBsaQrWDSrEvYd0LBsBpE6LcWUa9t8zhrmrhZK+ML2fA/kN1p6IUvxljkmOB1
         eKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxigthHu1AM8Vx5XTX0i+P8p5MyB1vffC7g7ly8qY0Q=;
        b=nT1rpqjbOjTpP275F1LWAaOflZsm5n5YbATOPKKmQGHKSRZ1ynxJAe5RgzQRmKKYrE
         LACPsaponsloZ2XM6gT3xPOPPt/CsEQJ494BGkhpooEOmqNftcx8LJTmryJ0HSTUy3Ol
         PCgn0alT+IldarngWBwqHLLywbZcyU1Ezz4WKpA7vc2Rb1rarsLhE5DkLMwxEwlebkc4
         5Fm3hme7z5/cXt3fJapIbf6a7cBJ+/Elnuc9M+XNiOk2gtATQV+4m+N2q8et8Fk4Kd/T
         S0RlmKdGL/QwFECKWEqAwdZQGbw4X1nlhrZwQuNIoogPfv0ecBKsyKSVu0v1CBHtAcUh
         dPaw==
X-Gm-Message-State: APt69E147nJcEDL4xmnHFz89HtErX9jxITl/5HPrrpeWtwaWCRZmVAl0
        1MLesEQcqCZVdumaTE0LhpltFw==
X-Google-Smtp-Source: AAOMgpeHhE1muDtnVQZDOE/a650kCBsntKbbZyWbMBOYZAG8RTEFNa6xhXs4+v8/aQKhoiDeKIwPqg==
X-Received: by 2002:a62:9b57:: with SMTP id r84-v6mr15474728pfd.6.1530298372822;
        Fri, 29 Jun 2018 11:52:52 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:52:52 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/17] media: imx: csi: Register a subdev notifier
Date:   Fri, 29 Jun 2018 11:49:52 -0700
Message-Id: <1530298220-5097-9-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse neighbor remote devices on the CSI port, and add them to a subdev
notifier, by calling v4l2_async_notifier_parse_fwnode_endpoints_by_port()
using the CSI's port id. And register the subdev notifier for the CSI.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v4:
- none
Changes since v3:
- v4l2_async_register_fwnode_subdev() no longer supports parsing
  port sub-devices, so call
  v4l2_async_notifier_parse_fwnode_endpoints_by_port() directly.
---
 drivers/staging/media/imx/imx-media-csi.c | 55 ++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 06af76d..d5cc4e9 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1740,6 +1740,59 @@ static const struct v4l2_subdev_internal_ops csi_internal_ops = {
 	.unregistered = csi_unregistered,
 };
 
+static int imx_csi_parse_endpoint(struct device *dev,
+				  struct v4l2_fwnode_endpoint *vep,
+				  struct v4l2_async_subdev *asd)
+{
+	return fwnode_device_is_available(asd->match.fwnode) ? 0 : -EINVAL;
+}
+
+static int imx_csi_async_register(struct csi_priv *priv)
+{
+	struct v4l2_async_notifier *notifier;
+	struct fwnode_handle *fwnode;
+	unsigned int port;
+	int ret;
+
+	notifier = kzalloc(sizeof(*notifier), GFP_KERNEL);
+	if (!notifier)
+		return -ENOMEM;
+
+	fwnode = dev_fwnode(priv->dev);
+
+	/* get this CSI's port id */
+	ret = fwnode_property_read_u32(fwnode, "reg", &port);
+	if (ret < 0)
+		goto out_free;
+
+	ret = v4l2_async_notifier_parse_fwnode_endpoints_by_port(
+		priv->dev->parent, notifier, sizeof(struct v4l2_async_subdev),
+		port, imx_csi_parse_endpoint);
+	if (ret < 0)
+		goto out_cleanup;
+
+	ret = v4l2_async_subdev_notifier_register(&priv->sd, notifier);
+	if (ret < 0)
+		goto out_cleanup;
+
+	ret = v4l2_async_register_subdev(&priv->sd);
+	if (ret < 0)
+		goto out_unregister;
+
+	priv->sd.subdev_notifier = notifier;
+
+	return 0;
+
+out_unregister:
+	v4l2_async_notifier_unregister(notifier);
+out_cleanup:
+	v4l2_async_notifier_cleanup(notifier);
+out_free:
+	kfree(notifier);
+
+	return ret;
+}
+
 static int imx_csi_probe(struct platform_device *pdev)
 {
 	struct ipu_client_platformdata *pdata;
@@ -1809,7 +1862,7 @@ static int imx_csi_probe(struct platform_device *pdev)
 			goto free;
 	}
 
-	ret = v4l2_async_register_subdev(&priv->sd);
+	ret = imx_csi_async_register(priv);
 	if (ret)
 		goto free;
 
-- 
2.7.4

