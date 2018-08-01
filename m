Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B90C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E402D20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOG0t0tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E402D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbeHAVAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:00:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44857 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbeHAVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:00:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so11277288pgp.11;
        Wed, 01 Aug 2018 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+4fTSjJ9qr6z0CdGSqqT0aewFdBL1/h41q/NxuvRPo=;
        b=QOG0t0tqVTRE+QhHU9EIW52E6G0qyYatjYd/Rc5y8LA2JJ5mTozV75auPhDjmFJOQK
         /Zcs5tS2kaOkOzmic0IKMZS87wvuDBVEAEyoaIwMREduk5oOqN8NFgDuioOTHC/12P/1
         fXxHj5WugX2kVGqoqL79BUN0spgVcJBh1x8Q+x6cJRkJuL8YrEcVx8BHVZV193EBe45w
         uSUPH4oZdm8NrITbedqiptqSenHnWZbilhn857LgCZIgwGP4Pa9M/AjAADIyFJJwnX4w
         QDn/6WKaF2/fGIs/PfaC1jbxKRa1k1DYnuupyB+C9tjTWNofN0I9fwmdEe2JzeKC+6f0
         6A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+4fTSjJ9qr6z0CdGSqqT0aewFdBL1/h41q/NxuvRPo=;
        b=hEBfwCbBfdFMgxkuHYEYSas3hWx3nvX1a8jSIag7oyAS/cnwmPcJv9uzR4WY2UGrVL
         1xfh9XNn3zl7L0mmYROYblxguI2Ts84ROFuF8AbXM4kfDttYAO4jsUE8BfFLBUiIk1Um
         7wBc3PXG3m/RJRL41tyQ7AVJsUuNzel+8tNYYxbA+cTRHfnQitmauhLR8fbn8wxQDEqK
         GpsUVXMBz/8rd7QRDSLrp8t+cAfW1MQ0HtMqVjmPKxfuO3Tc00sGmXIpxMsD3w3J+6DF
         UVPyPk3TTYkzEgzxBbmxEuSLPpqw8gYWCQzTngyHOXryJqW4EWJW837HJp3wCRj/Js7j
         Iwgg==
X-Gm-Message-State: AOUpUlHjgQMfXuz0Ggh57Yk3HpfA/ORbb+p9K7Wr8c+xTz327mVtwrMC
        +FmoyjXLuVpWZrR4lRwEsnXy1X8b
X-Google-Smtp-Source: AAOMgpfr2m7pXsD7iAypOe/5whKC6tU+PpXr+UJtACEL02rgpcJi9aldQpTpN3RqeQORD85ubK5YMw==
X-Received: by 2002:a63:aa44:: with SMTP id x4-v6mr26090828pgo.120.1533150773055;
        Wed, 01 Aug 2018 12:12:53 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:52 -0700 (PDT)
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
Subject: [PATCH v3 10/14] media: imx-csi: Allow skipping odd chroma rows for YVU420
Date:   Wed,  1 Aug 2018 12:12:23 -0700
Message-Id: <1533150747-30677-11-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip writing U/V components to odd rows for YVU420 in addition to
YUV420 and NV12.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 1155d50d..139c694 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -449,6 +449,7 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 		passthrough_bits = 16;
 		break;
 	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
 	case V4L2_PIX_FMT_NV12:
 		burst_size = (image.pix.width & 0x3f) ?
 			     ((image.pix.width & 0x1f) ?
-- 
2.7.4

