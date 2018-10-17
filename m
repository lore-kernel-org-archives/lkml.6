Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2869F2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULUF9ku7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2869F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJQHxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeJQHxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so11619018pgv.3;
        Tue, 16 Oct 2018 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vY/CbkNcqakMjMLyu1WYUkc1UoGI2QdWY8d78wR8nXo=;
        b=ULUF9ku70qabezhFkjAJ/jq9Tits0fErb0paKE297tD2lOag9w3JEKMuf3Vuk5s4/8
         5fbHr+U9z/eMQmZvk/G97OmuRS3c8kEjOb0RGJ9121+Dso+W87hPeWT0WOx4UxrdqHHr
         sjHpWIW2+krUzSgE9bLp/m2pRQSqkwk5J5N2dcIeYR5veg52RqlxoeNlIpRzibsqd+t2
         d0cW6r7PmEKRvMprsynpGZhYOEq/DgrTXJFvAK9lQRNt00SitgJ4k2fRlD9c68TAq+4D
         25CyTByUfn5xOdks5m2aWxymfp3WHKvS3jFmpzjQU7BmToAMEDlwDzU3LJyNM9YPuS9n
         cCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vY/CbkNcqakMjMLyu1WYUkc1UoGI2QdWY8d78wR8nXo=;
        b=JXioTZ2tXAXMj4UgYHQ7SlFAmma07gJcI4t6EJz4zcj7/BijLNsjBcQitRpsmQW6CR
         SQvAZlkQc2ol57VjyxhkNW0oAdoXJaRQ00iOazDhTrDAhjpIirPaNKEb7x7LecyxDzsc
         b+uidonmTEPIEXMKJoGnkKaDDv2Xxesje11hYbvdb5dC3bzXMUutYU//s+Y7s3omYPxp
         9Oxz02RGl5y0jAdmgJv0mTJCjw5Ahj7FXNqqX/vasuVZa5Pz37E/RjGPcs4uMc1FSX4B
         VTcGBAELOqSlym4MOn69FNFAoJMfyP5rT0y+MNlXCE0afiiN/OiNdVJr/+nBE/8AM8CA
         5qPw==
X-Gm-Message-State: ABuFfoj4EQtUfNfB0vt5NriiZYG2pvf8IMdZGSzkJW6R+M4+FiQYlXnl
        wvHNx1eRPFjVj1rB19IuTWfAKmmu
X-Google-Smtp-Source: ACcGV63W/ahGtixGNbrw5iCx9OIclPkfwcOlaiOH8s1i4nLUOy+Y4p0tFk+mPbGbEtNf4DbHmQlyhQ==
X-Received: by 2002:a62:22c7:: with SMTP id p68-v6mr24283601pfj.53.1539734444616;
        Tue, 16 Oct 2018 17:00:44 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:43 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 05/12] media: imx-csi: Input connections to CSI should be optional
Date:   Tue, 16 Oct 2018 17:00:20 -0700
Message-Id: <20181017000027.23696-6-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some imx platforms do not have fwnode connections to all CSI input
ports, and should not be treated as an error. This includes the
imx6q SabreAuto, which has no connections to ipu1_csi1 and ipu2_csi0.
Return -ENOTCONN in imx_csi_parse_endpoint() so that v4l2-fwnode
endpoint parsing will not treat an unconnected endpoint as an error.

Fixes: c893500a16baf ("media: imx: csi: Register a subdev notifier")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 176978c7dfe7..8f52428d2c75 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1813,7 +1813,7 @@ static int imx_csi_parse_endpoint(struct device *dev,
 				  struct v4l2_fwnode_endpoint *vep,
 				  struct v4l2_async_subdev *asd)
 {
-	return fwnode_device_is_available(asd->match.fwnode) ? 0 : -EINVAL;
+	return fwnode_device_is_available(asd->match.fwnode) ? 0 : -ENOTCONN;
 }
 
 static int imx_csi_async_register(struct csi_priv *priv)
-- 
2.17.1

