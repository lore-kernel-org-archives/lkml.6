Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312B4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F319D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkMehuNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F319D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeJEBtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:49:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45620 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeJEBtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:49:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so11027273wrw.12;
        Thu, 04 Oct 2018 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXacz9Q0cRU4uFZyGTiMdqLnF71e22XhX6hhANpYR3o=;
        b=PkMehuNOOlShfp0AkgvxlUMZYoAEgy4MhlEKgL4EPoYe6Ig1sUeHsTGhht1UnC0HIc
         ThUIjsXZn7si6Ddqd0CTw5qGfNmpUpIGik4mfbTuyPKlMsW7oFgdxmhOXk0qSs2MyIM0
         S0aoyq6X8WtwoPuKSCGnunYpFvPHVMvK2Y3KS+jFU01H8ZA4DfTr+oi1tBfFDv0WLLRy
         0vcwsy8g1MjN0VXA0ulKhLnN0pSE+4kPz1Rl1pjlRhBvhS7h9+Ggp46cBiWv3OLkLlG4
         /re3S4DAJ5EbQlipE5RkGN2+D2K34oaFQOA5MogG/5dA/9y7RpfIAyX7UBM9BrQDjEHB
         /Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXacz9Q0cRU4uFZyGTiMdqLnF71e22XhX6hhANpYR3o=;
        b=UnwkYiT6yaIEePQliIZvkR3YrDCnnRORVWUMO2TsnXtzYjhsCq5Euv4MuYSDKHfr1d
         nAlIb2cQEoqd7NfJQZq5gEu2L1hyZo0cGjktYJmXizzPABHQYVDWGf53aBUbkiVAwgfr
         wAC3i/5Xz8oJUj5RrnZ3yK8+UWTO1gE6thc1j0wG9x90P/S6PhG2GX27ymTcdf2uJ+fY
         gY3VWYVaArtfz3493mGpHJplmHdDN28CNTKV4C8FwuyUz0b7MZsk4d0Y9gVnggZQw28K
         vs7pm/z+3R5lqOV+s/cIeH2Jjakx/J890j9WAOpJAmFpYnB8L72NYP6MJMtLOaCF6cNS
         Ywfg==
X-Gm-Message-State: ABuFfojf11n/JPTNcRf82GvfkSnBiHyhi8gkZcunLEajcwCSc4mVPz37
        1kgKXwbGr9gl3GBQexhkYJVNznbl
X-Google-Smtp-Source: ACcGV61U1D1i3CaCTbcgVtHgbn4xAgVCHBQok/qhjx5lKpC9oZdkQ1npAMskF3wffDGJriZ0G5PIHg==
X-Received: by 2002:adf:c88b:: with SMTP id k11-v6mr5869182wrh.6.1538679268020;
        Thu, 04 Oct 2018 11:54:28 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:27 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 06/11] media: imx: interweave and odd-chroma-row skip are incompatible
Date:   Thu,  4 Oct 2018 11:53:56 -0700
Message-Id: <20181004185401.15751-7-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
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
index ca6328f53b75..4b075bc949de 100644
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

