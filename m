Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18DDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7549C20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL/x5Ri8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7549C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbeHAVAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:00:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33853 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeHAVAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:00:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so11286816pgv.1;
        Wed, 01 Aug 2018 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSPF0uv+LV63rAW2xHOcPWmuyOhu/C4pUSRq2lopMiU=;
        b=NL/x5Ri8Ljv2qYm06H5CR/L//i2n5iMsJUA5TyYuvnVerw7fsrcoYPrijfCcUmCZsT
         bCGuvM5SIzL87+cbJr6w600k6OxBGzsZ/+tq4mAmAzv5KyBiINTYWluSMDsun8YZGQhD
         EzxtB1zcaYWS4UZcvPdHn+6btue5Q8fKYt5nz9kO8s49qssuZ5HpRWINy+LfAW3VmA8D
         eDhuanOAHHiPvpwwIf3ha6r/jil45VFzy4dSQetnpR51GyLjBJKZoaIta115NcCbiYT5
         7zluc4QB0x7TyPc4QnAfEtuLk8SXMtq7wnT3RomRWDRkuAlkEH9ub4rgRCNMlIwl6yW5
         WE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSPF0uv+LV63rAW2xHOcPWmuyOhu/C4pUSRq2lopMiU=;
        b=R1ON1Fj7uUImxPvCLa95gcjEMjrv87feE5YrCtm3UY6CX5VgTafLUIk9XoJfMmk2Ut
         jL+ItYAZv1eyw4N+59kLmcNtlCStCLWoAyBPNzxTlHdhO61HrvfR68QlI3E4TUhm2J7e
         CyKgwAizhmOW6M33BtxHQRP16XgCK9x9Oag8QYXl8FBmxi1XgYGS5k7Cqo4JOwlE/ip7
         /4Kjm3LFkSIjAfe4Po3Z5GZo1gFvFKhE2vkYXaxdAMOR1MLiJfRFZBtPnGunCeEM9taY
         ZFC67q2U8QXAfvQtH2GXn2Zb1YzEqIvsdQ47p6Bl5BhjGkz1WjO8Yqs4NsBmV3/bDPP+
         oHow==
X-Gm-Message-State: AOUpUlFWlOwVMFURZyNNuW8DZ8yE06ej8TDnos6fBwYXsibl103yeRxG
        KGQJYz6wFrPskWcBaU37HosIe82k
X-Google-Smtp-Source: AAOMgpc6vS5vhgmqHvq1WpkuM0ZiSiuOtIE5Q5XpehKYosTRw+G9nlQRBdxss5aSCRntQJw8QSQZmg==
X-Received: by 2002:a65:5784:: with SMTP id b4-v6mr26333967pgr.315.1533150771303;
        Wed, 01 Aug 2018 12:12:51 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:50 -0700 (PDT)
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
Subject: [PATCH v3 09/14] media: imx: interweave and odd-chroma-row skip are incompatible
Date:   Wed,  1 Aug 2018 12:12:22 -0700
Message-Id: <1533150747-30677-10-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
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
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 9 +++++++--
 drivers/staging/media/imx/imx-media-csi.c   | 8 ++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 1a03d4c..cf76b04 100644
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
index 3a09a9b..1155d50d 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -454,8 +454,12 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
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
2.7.4

