Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B5CC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E7C2089D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr5bTV0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E7C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeI3CYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44716 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeI3CYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so6748073pgu.11;
        Sat, 29 Sep 2018 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ek7aMvAhww7wXIT36gN37Bk4zsXEvCBRyTYVNW5/+Jc=;
        b=dr5bTV0RVtaI4ClLrVtb0fBZUq4d7Ss3bWGHFBVpdYDafLO8KoKuUqEoFqcBtQdITG
         OtL40G5dQ4n9ce3Me42SJAZt6fPp5Dc8Gvm8KJ0Z8E5DvxpoNNiiNvQjCyuzDVT70M+0
         17X91BEh8KnY+6Ikd0XUrnfI9STeuWjY94yyDIjgfmB8WUJ2JwVzvUOMMzO2NQMVEvwl
         7oaMTIGCpkD/hcXH0hj6pvcIiM5DQooJZrlln1v93qd2yWgPPnPgOJoKKIfkEKCDWSXE
         dgz4LqSXAzhvncHfHHSxI8kEGzQPla/LMf0N5O+nsXCodUJbWzDH0YhmT7hP3YEtfLyS
         IF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ek7aMvAhww7wXIT36gN37Bk4zsXEvCBRyTYVNW5/+Jc=;
        b=OhYGzlJ6TCEDk8TkPGT88ZA6ZVHIcD1koV6MfHraXuo6qJJL/Ez1ste4tobwc/Zoxz
         NQvSyo0YuKYAUJNOlaFuVp1t+/39UBhSNHM81LO51rJ9h9aTpSI/9SYA9XkYJKjwC5Ho
         gVnemBioTbd2PNmtZHhVL4jtkUcRBZwO2TASdczrH8H3od+57gh2cDyObrMOWeWPGTLo
         2YF2uIncxp8oTx7rUb9QQASiH6JD+F8CewQB8orq3zo2DT6HzX1FW/ErDi5sMmGsKRz7
         dT9rWcj6j3DX2La0808NWzcSuOuOXvLYISYVGR1O3Fu8QLSq7K8yZ3fIW8wBrR5FKeG7
         4frQ==
X-Gm-Message-State: ABuFfoiMCVC2CjZJ9TtP/7SROOyLWODKCgTM2t6hkzX8mx6sxZkEizJa
        q5v9VZn3kGluvmspN/bSJTuDi5k+
X-Google-Smtp-Source: ACcGV60J2VDHi/BOcGSV7AmQNW//nPcQaF2Z0hJt/C34ZNdd1rMTnlruUwNU0OaQr92mJT4f9Md4mw==
X-Received: by 2002:a62:898d:: with SMTP id n13-v6mr4315103pfk.57.1538250896631;
        Sat, 29 Sep 2018 12:54:56 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:55 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 08/17] media: imx: csi: Register a subdev notifier
Date:   Sat, 29 Sep 2018 12:54:11 -0700
Message-Id: <20180929195420.28579-9-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse neighbor remote devices on the CSI port, and add them to a subdev
notifier, by calling v4l2_async_notifier_parse_fwnode_endpoints_by_port()
using the CSI's port id. And register the subdev notifier for the CSI.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v6:
- none
Changes since v5:
- add call to v4l2_async_notifier_init().
Changes since v4:
- none
Changes since v3:
- v4l2_async_register_fwnode_subdev() no longer supports parsing
  port sub-devices, so call
  v4l2_async_notifier_parse_fwnode_endpoints_by_port() directly.
---
 drivers/staging/media/imx/imx-media-csi.c | 57 ++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 4acdd7ae612b..bca13846ce6d 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1783,6 +1783,61 @@ static const struct v4l2_subdev_internal_ops csi_internal_ops = {
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
+	v4l2_async_notifier_init(notifier);
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
@@ -1852,7 +1907,7 @@ static int imx_csi_probe(struct platform_device *pdev)
 			goto free;
 	}
 
-	ret = v4l2_async_register_subdev(&priv->sd);
+	ret = imx_csi_async_register(priv);
 	if (ret)
 		goto free;
 
-- 
2.17.1

