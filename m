Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58429C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0EB2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxaoezr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0EB2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJQHxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32959 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeJQHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so11620907pge.0;
        Tue, 16 Oct 2018 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v1ovWtU7rw02LvSZ+0cIdgCkrY1FUFkyMNDz8xxcZYs=;
        b=dxaoezr+l5VkYMw+FdNUw5gXA6unzmKDdp1PRGh0f/2Qy1mGt3ASjCIlXZUXCcMgx0
         dgYsgVI7OcELiNnCyXVqOXz8G0uX5Ldkf2HWEfKAtVlOymfYI9pc74Xvy4FLYUqT7Ffn
         T6nMPqm9FhwCqZyEKKC2+UHlWhVtUfpWbdmOXujO1pbqGgYg2o6K2enE/tDQMjJmo8lk
         e/9T/pZaojhXFiO8SW0S969GqY3dPzabKAtkI4dhb2r7W6E5AMUJrtcTztdeZuzkkhbN
         GIx3QIMdVWSbx1qDCCvaWFntg5E2p3U/LZxpta+ot5sOssh4crR/kCV1RT5RFwoxzTRi
         kwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v1ovWtU7rw02LvSZ+0cIdgCkrY1FUFkyMNDz8xxcZYs=;
        b=FQ8FacFktwwoPtBpUetVnX4t9pgVNbAqcwQvwJY8TRvf1vD7+31wViVV7setak7V4l
         jKm1nNtvucRspH/JXPhOXrgTaATW/iRVZ+9Lk4/Xfm6kmwkutdJ0XUEUtUag4cV6ug+U
         DxNIykS/cXBY5Y/a1HAJJfyVnd8K808VROzFgA8CCyeCxWFuepSxNEeI9IYDMP8muJi+
         rfcC/bDUkSwohaajd2hLrfg+IDg9u6mdfGzyGJz+RUABWGokB6qubGTuiCOQbBK2hKqE
         5dfq6JUcDsbj1uR2hh4HbiSQuUyD6cB/lw2dz4x9PPWFOm295P8723EIjCo/msUabtd8
         w3Rw==
X-Gm-Message-State: ABuFfogI9C20m5B5xrVyIB9Dz5vvgysprURS2FqWRSkvOQyF7soEAEkh
        tUpUqdaF3fz7bTVTzVMOk+igMVts
X-Google-Smtp-Source: ACcGV61ijrwr7xslsp3nuKfBh+fJVH/p+zQpqTLGYDth7nlfm9y0NhSEyHaBj37d+DlehVOG+w9aCg==
X-Received: by 2002:a62:5887:: with SMTP id m129-v6mr24045222pfb.254.1539734452653;
        Tue, 16 Oct 2018 17:00:52 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:51 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 10/12] media: imx-csi: Move crop/compose reset after filling default mbus fields
Date:   Tue, 16 Oct 2018 17:00:25 -0700
Message-Id: <20181017000027.23696-11-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If caller passes un-initialized field type V4L2_FIELD_ANY to CSI
sink pad, the reset CSI crop window would not be correct, because
the crop window depends on a valid input field type. To fix move
the reset of crop and compose windows to after the call to
imx_media_fill_default_mbus_fields().

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 27 ++++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index c9110dd39a49..0d494a7db211 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1407,19 +1407,6 @@ static void csi_try_fmt(struct csi_priv *priv,
 				      W_ALIGN, &sdformat->format.height,
 				      MIN_H, MAX_H, H_ALIGN, S_ALIGN);
 
-		/* Reset crop and compose rectangles */
-		crop->left = 0;
-		crop->top = 0;
-		crop->width = sdformat->format.width;
-		crop->height = sdformat->format.height;
-		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
-			crop->height *= 2;
-		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
-		compose->left = 0;
-		compose->top = 0;
-		compose->width = crop->width;
-		compose->height = crop->height;
-
 		*cc = imx_media_find_mbus_format(sdformat->format.code,
 						 CS_SEL_ANY, true);
 		if (!*cc) {
@@ -1435,6 +1422,20 @@ static void csi_try_fmt(struct csi_priv *priv,
 		imx_media_fill_default_mbus_fields(
 			&sdformat->format, infmt,
 			priv->active_output_pad == CSI_SRC_PAD_DIRECT);
+
+		/* Reset crop and compose rectangles */
+		crop->left = 0;
+		crop->top = 0;
+		crop->width = sdformat->format.width;
+		crop->height = sdformat->format.height;
+		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
+			crop->height *= 2;
+		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
+		compose->left = 0;
+		compose->top = 0;
+		compose->width = crop->width;
+		compose->height = crop->height;
+
 		break;
 	}
 }
-- 
2.17.1

