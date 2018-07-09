Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE985C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771E32086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UonV0Vif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771E32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933565AbeGIWmy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:42:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46689 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933410AbeGIWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so14641802pfl.13;
        Mon, 09 Jul 2018 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=51wEMag0nSriXhLVh5SEgyHUb2lkEnvR9R783urdXKM=;
        b=UonV0VifKcCyU/XJK2iEOAWdhhzi5wyIb2sA6/cv4bjIbNdGoF6hA2+5aXwfSaDFHu
         zv5hNyPp4jPb3GBx7OUtYPGYHftbYy7OwBiGMPIb84dQY+0zppQuAkGNli6q4FnLD31w
         ELe/egvCui6DmEQho+UYd2Bk6Ve0F9wdQJJrN5fzGj78+gOXKyCE/AZkBr3gf8twW8RU
         djzAy+rM5CIbG3AXGmTo1P4pw6oBDW1+RRy3vqtX4YLeMcghB5MJvxtLuAH1q1oriqzY
         lAYbwKqdARGdesIhVD0UXTxwsLuRc+QgLqnEUapWYGpI/HjgvEHo9PK0th/9v5y6LG31
         JNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=51wEMag0nSriXhLVh5SEgyHUb2lkEnvR9R783urdXKM=;
        b=ShmeE8VrFgHtVpmp2tLtv6LBrmkHr3bcdYcy7bxkGIwQpGwUW+fMjEGMrKC05oIWbi
         ex93b6d4oaWP2NAQpXuaTtO2cYQ6M9BnsTkhuZWWqyjncMMWrNAje3OSMAkVDlY3yXS1
         /ub8BplmS/kuQRYoe21n/rVDifeb9F1qwQjTCnVPFaPCgmriwhQ9JTq/tqGHIcJitque
         ao4DqA0ODw65ZOl7WpNfHDmxXFWg21q8+KirRKrjVnjl5ipE//z/JAdCmDnU5FmNABPE
         311Eus7pvNEHeS8oJoLJprYTbScR9TNsPOmBzYZnIyPZFt6/03ELxYr3Ei0KnnViGgks
         G7dw==
X-Gm-Message-State: APt69E0YGVIb+K2ViLVYKcQxhRZxF+FZwkqEYKcRihYEo1XnK5UUmdwV
        KApT71QHxExYLEdW5XY8Xc6xBA==
X-Google-Smtp-Source: AAOMgpeHGkx6EtPMHywmmSlenHiCNx4LTiiCdIpvKXncyF6HzPPhq+osiB1A0M7kzE/x7bwY89enBg==
X-Received: by 2002:a65:60d2:: with SMTP id r18-v6mr15840156pgv.306.1531175992336;
        Mon, 09 Jul 2018 15:39:52 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:51 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 08/17] media: imx: csi: Register a subdev notifier
Date:   Mon,  9 Jul 2018 15:39:08 -0700
Message-Id: <1531175957-1973-9-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse neighbor remote devices on the CSI port, and add them to a subdev
notifier, by calling v4l2_async_notifier_parse_fwnode_endpoints_by_port()
using the CSI's port id. And register the subdev notifier for the CSI.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v5:
- add call to v4l2_async_notifier_init().
Changes since v4:
- none
Changes since v3:
- v4l2_async_register_fwnode_subdev() no longer supports parsing
  port sub-devices, so call
  v4l2_async_notifier_parse_fwnode_endpoints_by_port() directly.
---
 drivers/staging/media/imx/imx-media-csi.c | 57 ++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 4647206..19ef377 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1780,6 +1780,61 @@ static const struct v4l2_subdev_internal_ops csi_internal_ops = {
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
@@ -1849,7 +1904,7 @@ static int imx_csi_probe(struct platform_device *pdev)
 			goto free;
 	}
 
-	ret = v4l2_async_register_subdev(&priv->sd);
+	ret = imx_csi_async_register(priv);
 	if (ret)
 		goto free;
 
-- 
2.7.4

