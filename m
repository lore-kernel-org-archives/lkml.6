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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4ADC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2C52148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCc0qAIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2C52148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeJQHxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37736 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeJQHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so11607060pgq.4;
        Tue, 16 Oct 2018 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vugOjOb9bU/wU1aCXpDs/uKcyEbw9sNMwAJBqgpFIwY=;
        b=ZCc0qAIgHERMROzxNRSvwS//eehcsZEfM0Scg2RNKIJHP6U/+bzjzNvkBALnJHpSQv
         mO1H0cIJ1fhMTzB/RK9Q3nJVVhoYECEhTRgBeMUl13UBBgi3XTj1GsbOLFi9aZlFAQsB
         Ab4pP/5bPJwAEz3UMF5Z7RWENgCcOE1BknYpJrhsuYanyTh0typA9ii9QErtj898WwWf
         08VLhGVRDhUwspcAciWPvaNfa0+3eyjgN2gootGE7TVY99g/idSw9m/EN364AXM7FguZ
         bOdnbboXgBOS9ju6PpniEronLelIs9UIYmgVcLR6uivza2glUwOmrmZPr2EWyH0L2SYa
         6gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vugOjOb9bU/wU1aCXpDs/uKcyEbw9sNMwAJBqgpFIwY=;
        b=t0HMFtotHylwAj3LDrZVzlnDFZNNQL0GwtCUlr/rdqjQa71aW6e00Qt9ughXTyVhxT
         RfY2JwXpUr6d/QCJvlA68K99QB1mJBwr6Y4me7z4jX5KAO8GDTixvrICHxfHLgHkds53
         b6bWq3XRHe/pzBZbNRJuwVXCf/AnCgMqlqjZLopRy1t2jizLtrj1PwlYouRtWIajCB3s
         eSR8hUWLXhd62CgKQ7l4ZwZ9PQl2dDA//G6oPPAGe2A05Tpa23fuACklXRtwEMOCIeAx
         0emMczp+qAsv4nTjGFb9uHcqS8bd+bPArlp44cpkkXQBe6ZYIZYRtYrPTO4CTminIOkJ
         KNmQ==
X-Gm-Message-State: ABuFfojX51vEU8ZTEgLm4qXX4wk/uulzwNkOBeZD2u4TkfLBtyhHNBP0
        yRP6Zg0SkVDLvPaYvTX//SJTeai3
X-Google-Smtp-Source: ACcGV63xKqO1mBLDg9+EN8yKNjppG2LgVbEV317v29TOjTxO/d7+MXD5LLmDdxzNhEemlc3a6UlOyA==
X-Received: by 2002:a63:e05:: with SMTP id d5-v6mr22051194pgl.272.1539734449622;
        Tue, 16 Oct 2018 17:00:49 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:48 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 08/12] media: imx-csi: Allow skipping odd chroma rows for YVU420
Date:   Tue, 16 Oct 2018 17:00:23 -0700
Message-Id: <20181017000027.23696-9-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip writing U/V components to odd rows for YVU420 in addition to
YUV420 and NV12.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 7e648fc9626a..c9110dd39a49 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -452,6 +452,7 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 		passthrough_bits = 16;
 		break;
 	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
 	case V4L2_PIX_FMT_NV12:
 		burst_size = (image.pix.width & 0x3f) ?
 			     ((image.pix.width & 0x1f) ?
-- 
2.17.1

