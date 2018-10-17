Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C85DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA5C2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLTqIUx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA5C2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJQHxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44645 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeJQHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so12230508pff.11;
        Tue, 16 Oct 2018 17:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RZspm3Qdd+CBQ5BKu9QQloYDT701vAd6GkNdc0u66mg=;
        b=aLTqIUx6449r0/wvt7EcMkNMbg2siGLgfyQlqkmktGsYRXRZiYZgUwMI3PO+B8GYQl
         JZHlkWgSgUym8fgGEl8jEr3bayJMQLSYvb9tAt0Yu1ULyyF2UB8Nhvk6W8tG/tj6ih/Q
         5a8SmfFBh7cGBlnNL3RIko2XBc+skW1YfEo2LDwNt4qQXbaYgnw7EYeir912lkLX9Tbq
         nkyGA8vOU9PGKnIy0BgYpIF1IloOeIdc68xMzR3715OdVbJG5yphClGRhd3fGiPjGvmW
         Z7LDJw6ZOkRAofQnCu2en43cVghR0+EugQZ+8FHUonGuE3JolDOL/W/Egkdra/qmX69g
         CSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RZspm3Qdd+CBQ5BKu9QQloYDT701vAd6GkNdc0u66mg=;
        b=EnZRasW9NV+6rrCJd46/Esd4G2bX7XnLgioGyFBnnfbenWvP+wlzFtsV9m0NvDR+sP
         eBcO+uzsp1q1UXWfo9yg0Aix6DKw+lfliqVCq+FgcSb63fEMXWnvgdW0h2zDOc+vujvX
         8DOsHCkoenpRRwWApcEkdGlFC7lH90y8RL7tTc10O12nDYLgIuvpAtOaG7V7eW+t7Wsq
         tdqaAKBC5N5IPBAI1ksZnzNfV3ZoW2P510TIOI/8I2KmK2M6qolW6qpJrJNZGy3ziLuH
         cybC6gVmIgtaignbUKWTQ6hFUFJX3oBC5Ftje6dByVISx1cf61CVMJd8BMIbgs3ofoEu
         4kPA==
X-Gm-Message-State: ABuFfogGlWJBKtLj/5eElF36hfPCZAUFCRWy711wL/b2NBKZK1UgeKO3
        NaZIr55DohEPsLLLJVo6rXazd95V
X-Google-Smtp-Source: ACcGV60sU/cxyy0ycn62tD00vyjxvSFR9J7WQPm0Qi5qxp5eYiyiTah4oQWvrcW93iQPQTfmmP8Qeg==
X-Received: by 2002:a62:d206:: with SMTP id c6-v6mr9862711pfg.8.1539734441334;
        Tue, 16 Oct 2018 17:00:41 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:40 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
Subject: [PATCH v5 03/12] gpu: ipu-v3: Add planar support to interlaced scan
Date:   Tue, 16 Oct 2018 17:00:18 -0700
Message-Id: <20181017000027.23696-4-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support interlaced scan with planar formats, cpmem SLUV must
be programmed with the correct chroma line stride. For full and
partial planar 4:2:2 (YUV422P, NV16), chroma line stride must
be doubled. For full and partial planar 4:2:0 (YUV420, YVU420, NV12),
chroma line stride must _not_ be doubled, since a single chroma line
is shared by two luma lines.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/ipu-v3/ipu-cpmem.c              | 26 +++++++++++++++++++--
 drivers/staging/media/imx/imx-ic-prpencvf.c |  3 ++-
 drivers/staging/media/imx/imx-media-csi.c   |  3 ++-
 include/video/imx-ipu-v3.h                  |  3 ++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
index a9d2501500a1..d41df8034c5b 100644
--- a/drivers/gpu/ipu-v3/ipu-cpmem.c
+++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
@@ -273,9 +273,10 @@ void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off)
 }
 EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
 
-void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
+void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride,
+			       u32 pixelformat)
 {
-	u32 ilo, sly;
+	u32 ilo, sly, sluv;
 
 	if (stride < 0) {
 		stride = -stride;
@@ -286,9 +287,30 @@ void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
 
 	sly = (stride * 2) - 1;
 
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
+		sluv = stride / 2 - 1;
+		break;
+	case V4L2_PIX_FMT_NV12:
+		sluv = stride - 1;
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		sluv = stride - 1;
+		break;
+	case V4L2_PIX_FMT_NV16:
+		sluv = stride * 2 - 1;
+		break;
+	default:
+		sluv = 0;
+		break;
+	}
+
 	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
 	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, ilo);
 	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, sly);
+	if (sluv)
+		ipu_ch_param_write_field(ch, IPU_FIELD_SLUV, sluv);
 };
 EXPORT_SYMBOL_GPL(ipu_cpmem_interlaced_scan);
 
diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 28f41caba05d..af7224846bd5 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -412,7 +412,8 @@ static int prp_setup_channel(struct prp_priv *priv,
 	if (image.pix.field == V4L2_FIELD_NONE &&
 	    V4L2_FIELD_HAS_BOTH(infmt->field) &&
 	    channel == priv->out_ch)
-		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline);
+		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline,
+					  image.pix.pixelformat);
 
 	ret = ipu_ic_task_idma_init(priv->ic, channel,
 				    image.pix.width, image.pix.height,
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 7ecbd4d76d09..4aa20ae72608 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -512,7 +512,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	if (image.pix.field == V4L2_FIELD_NONE &&
 	    V4L2_FIELD_HAS_BOTH(infmt->field))
 		ipu_cpmem_interlaced_scan(priv->idmac_ch,
-					  image.pix.bytesperline);
+					  image.pix.bytesperline,
+					  image.pix.pixelformat);
 
 	ipu_idmac_set_double_buffer(priv->idmac_ch, true);
 
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index f44a35192313..e888c66b9d9d 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -255,7 +255,8 @@ void ipu_cpmem_set_stride(struct ipuv3_channel *ch, int stride);
 void ipu_cpmem_set_high_priority(struct ipuv3_channel *ch);
 void ipu_cpmem_set_buffer(struct ipuv3_channel *ch, int bufnum, dma_addr_t buf);
 void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off);
-void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride);
+void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride,
+			       u32 pixelformat);
 void ipu_cpmem_set_axi_id(struct ipuv3_channel *ch, u32 id);
 int ipu_cpmem_get_burstsize(struct ipuv3_channel *ch);
 void ipu_cpmem_set_burstsize(struct ipuv3_channel *ch, int burstsize);
-- 
2.17.1

