Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37673C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4082087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy9/6y8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4082087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJQHxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46308 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeJQHxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so11591483pgv.13;
        Tue, 16 Oct 2018 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AtLoo3VIxB2BrTDYsbUW3ewCrV6NJ5u/G+P5mLFc6Dc=;
        b=Hy9/6y8YAECZH/Mj+87lWHqgx5Csojz3USjPie4PUQnd78MrylW3S9VoxRSVpQCyHP
         9vbi3Tf2ixCFNlCOJHhE5+icFyy6Q6ApuyNbPMaaCkb3DIj7c8A9k5aC7aoLI8EjEmYK
         Q/zTQUanuJMZ3qtA74aLuy7QEurd7Fl8b9VLP3ZENVZmo7OuCKju5MJcFnVPv0dmyndL
         /QwwzfDZXqsBAI5lcs4kHbdtwfb8XqgRFLVCSHfy5PXnmuKqKbr31rOo9lqFgTO4dLs0
         vwWLHeQ8SC5kTqdBJtpAi569iPszg1+PPbredWgTIfirlpmLhY1yifTfD8nF2GN4fNAz
         mXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AtLoo3VIxB2BrTDYsbUW3ewCrV6NJ5u/G+P5mLFc6Dc=;
        b=RPHEkVAchYBl6JnB4x8TdhyjuLB/RlPew3MStAzK+iLyjhnrspVSSJVpRAkdPX1KnD
         pGFnRxrmEBMcvO0Ik4ZYE+hJPtywK89/DsfgFS/9+JVEB5t5YDY89EXv27F5Kd/StB9z
         dkgDPbqvc9U61+/v3YshcFg/xjrfUVBCh2tJDsAN1UUKCv/UmwDV+jVVlSyJ+YsKsamr
         AlhzObEqAk1l9nIZeuiMukmmwvyoGKJVwvBKrfvSYyiaYDR+asq2PfSLV1qNeuW6LKwg
         9YNfROGilVj9C6+J9RBaraPJr98rYMxLx+B8+DtSuwOcQ4kWB3VJCgFhvoGRv43AAbpS
         SLYw==
X-Gm-Message-State: ABuFfoi34OUfxBxXjEZ4FaqgOK+937ZzevmCEkWCdZIJ2txajkDFQcNw
        jP9CugY8R7GtjYTM/lOv1WK6Pwuy
X-Google-Smtp-Source: ACcGV63iB9geQwG14DIHLDeiIDsUgLCDJ4FbkDCn10k3Y+oMYcqz8j6bVOwHG1Uoi9+mIDWbR/3rPw==
X-Received: by 2002:a62:99cd:: with SMTP id t74-v6mr23868388pfk.179.1539734455736;
        Tue, 16 Oct 2018 17:00:55 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:54 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 12/12] media: imx.rst: Update doc to reflect fixes to interlaced capture
Date:   Tue, 16 Oct 2018 17:00:27 -0700
Message-Id: <20181017000027.23696-13-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add an example pipeline for unconverted capture with interweave
on SabreAuto.

Cleanup some language in various places in the process.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v4:
- Make clear that it is IDMAC channel that does pixel reordering and
  interweave, not the CSI. Caught by Philipp Zabel.
Changes since v3:
- none.
Changes since v2:
- expand on idmac interweave behavior in CSI subdev.
- switch second SabreAuto pipeline example to PAL to give
  both NTSC and PAL examples.
- Cleanup some language in various places.
---
 Documentation/media/v4l-drivers/imx.rst | 103 +++++++++++++++---------
 1 file changed, 66 insertions(+), 37 deletions(-)

diff --git a/Documentation/media/v4l-drivers/imx.rst b/Documentation/media/v4l-drivers/imx.rst
index 65d3d15eb159..45f3b68865dd 100644
--- a/Documentation/media/v4l-drivers/imx.rst
+++ b/Documentation/media/v4l-drivers/imx.rst
@@ -22,8 +22,8 @@ memory. Various dedicated DMA channels exist for both video capture and
 display paths. During transfer, the IDMAC is also capable of vertical
 image flip, 8x8 block transfer (see IRT description), pixel component
 re-ordering (for example UYVY to YUYV) within the same colorspace, and
-even packed <--> planar conversion. It can also perform a simple
-de-interlacing by interleaving even and odd lines during transfer
+packed <--> planar conversion. The IDMAC can also perform a simple
+de-interlacing by interweaving even and odd lines during transfer
 (without motion compensation which requires the VDIC).
 
 The CSI is the backend capture unit that interfaces directly with
@@ -173,15 +173,21 @@ via the SMFC and an IDMAC channel, bypassing IC pre-processing. This
 source pad is routed to a capture device node, with a node name of the
 format "ipuX_csiY capture".
 
-Note that since the IDMAC source pad makes use of an IDMAC channel, it
-can do pixel reordering within the same colorspace. For example, the
-sink pad can take UYVY2X8, but the IDMAC source pad can output YUYV2X8.
-If the sink pad is receiving YUV, the output at the capture device can
-also be converted to a planar YUV format such as YUV420.
-
-It will also perform simple de-interlace without motion compensation,
-which is activated if the sink pad's field type is an interlaced type,
-and the IDMAC source pad field type is set to none.
+Note that since the IDMAC source pad makes use of an IDMAC channel,
+pixel reordering within the same colorspace can be carried out by the
+IDMAC channel. For example, if the CSI sink pad is receiving in UYVY
+order, the capture device linked to the IDMAC source pad can capture
+in YUYV order. Also, if the CSI sink pad is receiving a packed YUV
+format, the capture device can capture a planar YUV format such as
+YUV420.
+
+The IDMAC channel at the IDMAC source pad also supports simple
+interweave without motion compensation, which is activated if the source
+pad's field type is sequential top-bottom or bottom-top, and the
+requested capture interface field type is set to interlaced (t-b, b-t,
+or unqualified interlaced). The capture interface will enforce the same
+field order as the source pad field order (interlaced-bt if source pad
+is seq-bt, interlaced-tb if source pad is seq-tb).
 
 This subdev can generate the following event when enabling the second
 IDMAC source pad:
@@ -323,14 +329,14 @@ ipuX_vdic
 
 The VDIC carries out motion compensated de-interlacing, with three
 motion compensation modes: low, medium, and high motion. The mode is
-specified with the menu control V4L2_CID_DEINTERLACING_MODE. It has
-two sink pads and a single source pad.
+specified with the menu control V4L2_CID_DEINTERLACING_MODE. The VDIC
+has two sink pads and a single source pad.
 
 The direct sink pad receives from an ipuX_csiY direct pad. With this
 link the VDIC can only operate in high motion mode.
 
 When the IDMAC sink pad is activated, it receives from an output
-or mem2mem device node. With this pipeline, it can also operate
+or mem2mem device node. With this pipeline, the VDIC can also operate
 in low and medium modes, because these modes require receiving
 frames from memory buffers. Note that an output or mem2mem device
 is not implemented yet, so this sink pad currently has no links.
@@ -343,8 +349,8 @@ ipuX_ic_prp
 This is the IC pre-processing entity. It acts as a router, routing
 data from its sink pad to one or both of its source pads.
 
-It has a single sink pad. The sink pad can receive from the ipuX_csiY
-direct pad, or from ipuX_vdic.
+This entity has a single sink pad. The sink pad can receive from the
+ipuX_csiY direct pad, or from ipuX_vdic.
 
 This entity has two source pads. One source pad routes to the
 pre-process encode task entity (ipuX_ic_prpenc), the other to the
@@ -367,8 +373,8 @@ color-space conversion, resizing (downscaling and upscaling),
 horizontal and vertical flip, and 90/270 degree rotation. Flip
 and rotation are provided via standard V4L2 controls.
 
-Like the ipuX_csiY IDMAC source, it can also perform simple de-interlace
-without motion compensation, and pixel reordering.
+Like the ipuX_csiY IDMAC source, this entity also supports simple
+de-interlace without motion compensation, and pixel reordering.
 
 ipuX_ic_prpvf
 -------------
@@ -378,18 +384,18 @@ pad from ipuX_ic_prp, and a single source pad. The source pad is routed
 to a capture device node, with a node name of the format
 "ipuX_ic_prpvf capture".
 
-It is identical in operation to ipuX_ic_prpenc, with the same resizing
-and CSC operations and flip/rotation controls. It will receive and
-process de-interlaced frames from the ipuX_vdic if ipuX_ic_prp is
+This entity is identical in operation to ipuX_ic_prpenc, with the same
+resizing and CSC operations and flip/rotation controls. It will receive
+and process de-interlaced frames from the ipuX_vdic if ipuX_ic_prp is
 receiving from ipuX_vdic.
 
-Like the ipuX_csiY IDMAC source, it can perform simple de-interlace
-without motion compensation. However, note that if the ipuX_vdic is
-included in the pipeline (ipuX_ic_prp is receiving from ipuX_vdic),
-it's not possible to use simple de-interlace in ipuX_ic_prpvf, since
-the ipuX_vdic has already carried out de-interlacing (with motion
-compensation) and therefore the field type output from ipuX_ic_prp can
-only be none.
+Like the ipuX_csiY IDMAC source, this entity supports simple
+interweaving without motion compensation. However, note that if the
+ipuX_vdic is included in the pipeline (ipuX_ic_prp is receiving from
+ipuX_vdic), it's not possible to use interweave in ipuX_ic_prpvf,
+since the ipuX_vdic has already carried out de-interlacing (with
+motion compensation) and therefore the field type output from
+ipuX_vdic can only be none (progressive).
 
 Capture Pipelines
 -----------------
@@ -514,10 +520,33 @@ On the SabreAuto, an on-board ADV7180 SD decoder is connected to the
 parallel bus input on the internal video mux to IPU1 CSI0.
 
 The following example configures a pipeline to capture from the ADV7180
-video decoder, assuming NTSC 720x480 input signals, with Motion
-Compensated de-interlacing. Pad field types assume the adv7180 outputs
-"interlaced". $outputfmt can be any format supported by the ipu1_ic_prpvf
-entity at its output pad:
+video decoder, assuming NTSC 720x480 input signals, using simple
+interweave (unconverted and without motion compensation). The adv7180
+must output sequential or alternating fields (field type 'seq-bt' for
+NTSC, or 'alternate'):
+
+.. code-block:: none
+
+   # Setup links
+   media-ctl -l "'adv7180 3-0021':0 -> 'ipu1_csi0_mux':1[1]"
+   media-ctl -l "'ipu1_csi0_mux':2 -> 'ipu1_csi0':0[1]"
+   media-ctl -l "'ipu1_csi0':2 -> 'ipu1_csi0 capture':0[1]"
+   # Configure pads
+   media-ctl -V "'adv7180 3-0021':0 [fmt:UYVY2X8/720x480 field:seq-bt]"
+   media-ctl -V "'ipu1_csi0_mux':2 [fmt:UYVY2X8/720x480]"
+   media-ctl -V "'ipu1_csi0':2 [fmt:AYUV32/720x480]"
+   # Configure "ipu1_csi0 capture" interface (assumed at /dev/video4)
+   v4l2-ctl -d4 --set-fmt-video=field=interlaced_bt
+
+Streaming can then begin on /dev/video4. The v4l2-ctl tool can also be
+used to select any supported YUV pixelformat on /dev/video4.
+
+This example configures a pipeline to capture from the ADV7180
+video decoder, assuming PAL 720x576 input signals, with Motion
+Compensated de-interlacing. The adv7180 must output sequential or
+alternating fields (field type 'seq-tb' for PAL, or 'alternate').
+$outputfmt can be any format supported by the ipu1_ic_prpvf entity
+at its output pad:
 
 .. code-block:: none
 
@@ -529,11 +558,11 @@ entity at its output pad:
    media-ctl -l "'ipu1_ic_prp':2 -> 'ipu1_ic_prpvf':0[1]"
    media-ctl -l "'ipu1_ic_prpvf':1 -> 'ipu1_ic_prpvf capture':0[1]"
    # Configure pads
-   media-ctl -V "'adv7180 3-0021':0 [fmt:UYVY2X8/720x480]"
-   media-ctl -V "'ipu1_csi0_mux':2 [fmt:UYVY2X8/720x480 field:interlaced]"
-   media-ctl -V "'ipu1_csi0':1 [fmt:AYUV32/720x480 field:interlaced]"
-   media-ctl -V "'ipu1_vdic':2 [fmt:AYUV32/720x480 field:none]"
-   media-ctl -V "'ipu1_ic_prp':2 [fmt:AYUV32/720x480 field:none]"
+   media-ctl -V "'adv7180 3-0021':0 [fmt:UYVY2X8/720x576 field:seq-tb]"
+   media-ctl -V "'ipu1_csi0_mux':2 [fmt:UYVY2X8/720x576]"
+   media-ctl -V "'ipu1_csi0':1 [fmt:AYUV32/720x576]"
+   media-ctl -V "'ipu1_vdic':2 [fmt:AYUV32/720x576 field:none]"
+   media-ctl -V "'ipu1_ic_prp':2 [fmt:AYUV32/720x576 field:none]"
    media-ctl -V "'ipu1_ic_prpvf':1 [fmt:$outputfmt field:none]"
 
 Streaming can then begin on the capture device node at
-- 
2.17.1

