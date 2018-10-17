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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78894C5ACCD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E6214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKk3VSpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2E6214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeJQHxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34398 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeJQHxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so11767655plr.1;
        Tue, 16 Oct 2018 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0eBTHkSaCphcPmwZ9jVlJ6HcB3DsZnUr5R1VmafRFY=;
        b=bKk3VSpVvrlANGtQ0CXXAEUKnZHRBbLi25e9GeqBgRiieQnGfLp5opYGWCA7SvEI+l
         tGm6IxWY6SCFGD0JMCbigX4aZH4dbZZDDBiuTo9MIzkUpaqlIh20LVAs1a2pxBZ0eeYz
         OkCeg8FvNAb9y0EhTkdDVYVfDOTJzIwnhPBkXWWEhd/UNffdm5/baKXkXlwRd90ftC6W
         jAfC8/kgZTOCBDlsJHSAHeiPybsXduhyX9GzbPCZpA3+NNUaxRpbvJiGgdYMcsmjBG8u
         IAUX9zKTpVmnHKlOLTie8eGYOhV/+kj8sGNpBn2pOhIDXgDP1mWX5UaJOagl+YGGSjSN
         rhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0eBTHkSaCphcPmwZ9jVlJ6HcB3DsZnUr5R1VmafRFY=;
        b=XgKcjMzWR621jbBfMm4CnD/oYXon0bzMJqrn8yjCnGekqE/R0n/37WZdWDtZ5kag7v
         8ZFi0DPwYdCjjBdqo9eBhTnkh/i4dDFxwTjSOnM6krt2XPBmzVkOBS02j7c4K/4IJSCv
         Q/Mp6wMyMx2Kmvjox9jOm0Ud1j8QaxtCK4w7GCxi4B5Heu+fOh4ZJ8S6aRYrAG6H20By
         bOCHGEOlokIwGdqh+Km5J0vV/VnEFAp7YGuSbsl+SPiAPp5d1R4ZTk3HjXPRQGxQeOUK
         rrq6PD6QxlCCmQONw214My3D69wCi0sfZ99b/XTbjekofABJPmQdNNTswtnJ/DnRUjFp
         loTA==
X-Gm-Message-State: ABuFfogYQ4no+/myWOKdxYGjWZS2Y19pax5uWYEzi9k9QASeFedPcLiK
        KT4kXY3Y1ipIYoZgFOiea+K4D3YF
X-Google-Smtp-Source: ACcGV60yhOyX69rEqScgU2+HCyIBA9TIcWXnJisJvPF7k11Xc+/qWF0/Rix05C2vnM3xVvIksQzWkA==
X-Received: by 2002:a17:902:3204:: with SMTP id y4-v6mr18584456plb.135.1539734448006;
        Tue, 16 Oct 2018 17:00:48 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:47 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 07/12] media: imx: interweave and odd-chroma-row skip are incompatible
Date:   Tue, 16 Oct 2018 17:00:22 -0700
Message-Id: <20181017000027.23696-8-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IDMAC interweaving is enabled in a write channel, the channel must
write the odd chroma rows for 4:2:0 formats. Skipping writing the odd
chroma rows produces corrupted captured 4:2:0 images when interweave
is enabled.

Reported-by: Krzysztof Hałasa <khalasa@piap.pl>
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 9 +++++++--
 drivers/staging/media/imx/imx-media-csi.c   | 8 ++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 1a03d4c9d7b8..cf76b0432371 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -391,12 +391,17 @@ static int prp_setup_channel(struct prp_priv *priv,
 	image.phys0 = addr0;
 	image.phys1 = addr1;
 
-	if (channel == priv->out_ch || channel == priv->rot_out_ch) {
+	/*
+	 * Skip writing U and V components to odd rows in the output
+	 * channels for planar 4:2:0 (but not when enabling IDMAC
+	 * interweaving, they are incompatible).
+	 */
+	if (!interweave && (channel == priv->out_ch ||
+			    channel == priv->rot_out_ch)) {
 		switch (image.pix.pixelformat) {
 		case V4L2_PIX_FMT_YUV420:
 		case V4L2_PIX_FMT_YVU420:
 		case V4L2_PIX_FMT_NV12:
-			/* Skip writing U and V components to odd rows */
 			ipu_cpmem_skip_odd_chroma_rows(channel);
 			break;
 		}
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index d5b0f8a66750..7e648fc9626a 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -457,8 +457,12 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 			     ((image.pix.width & 0x1f) ?
 			      ((image.pix.width & 0xf) ? 8 : 16) : 32) : 64;
 		passthrough_bits = 16;
-		/* Skip writing U and V components to odd rows */
-		ipu_cpmem_skip_odd_chroma_rows(priv->idmac_ch);
+		/*
+		 * Skip writing U and V components to odd rows (but not
+		 * when enabling IDMAC interweaving, they are incompatible).
+		 */
+		if (!interweave)
+			ipu_cpmem_skip_odd_chroma_rows(priv->idmac_ch);
 		break;
 	case V4L2_PIX_FMT_YUYV:
 	case V4L2_PIX_FMT_UYVY:
-- 
2.17.1

