Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DC2C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878D62084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079227;
	bh=Rt2+52BNE72BF/lN+uyv0Y9KcSOM+TndGG/S8jXlS1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YznWhC3LPO+vjYUUZOP9Xywh8pZaZdRc8k0qKpJVap8RmsT3OCV5GYBe5N4DeRKLh
	 E7xjWUCLOyIOtAsN3/rixk69/ZnhwUNilrK5XEezr2DMaeCpAuCeL8eUv9sny1FVYq
	 +N1zyHeFgkZG66fRVJThgpvSWN8aS6psAQ+vml/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfAUOAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732377AbfAUOAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:00:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734DB2084C;
        Mon, 21 Jan 2019 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079222;
        bh=Rt2+52BNE72BF/lN+uyv0Y9KcSOM+TndGG/S8jXlS1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/TWJcMS0I5bMRavnD1s5P5ZoDEu7ZxsNhucuLGPsv7jMbrC0m5t++hm9d3ooeOO0
         1m9xCDILEXuXRVr78e+YL0ShJ03MHKLmYcy4COlfulpPH6qbZIw2ebJV5eUsh+07yl
         AXgUshRnhH4hYt5a3d/bsr+6nTUlahN4giIWS4xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 51/99] media: v4l: ioctl: Validate num_planes for debug messages
Date:   Mon, 21 Jan 2019 14:48:43 +0100
Message-Id: <20190121134915.914937836@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 7fe9f01c04c2673bd6662c35b664f0f91888b96f upstream.

The num_planes field in struct v4l2_pix_format_mplane is used in a loop
before validating it. As the use is printing a debug message in this case,
just cap the value to the maximum allowed.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: <stable@vger.kernel.org>      # for v4.12 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-ioctl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -286,6 +286,7 @@ static void v4l_print_format(const void
 	const struct v4l2_window *win;
 	const struct v4l2_sdr_format *sdr;
 	const struct v4l2_meta_format *meta;
+	u32 planes;
 	unsigned i;
 
 	pr_cont("type=%s", prt_names(p->type, v4l2_type_names));
@@ -316,7 +317,8 @@ static void v4l_print_format(const void
 			prt_names(mp->field, v4l2_field_names),
 			mp->colorspace, mp->num_planes, mp->flags,
 			mp->ycbcr_enc, mp->quantization, mp->xfer_func);
-		for (i = 0; i < mp->num_planes; i++)
+		planes = min_t(u32, mp->num_planes, VIDEO_MAX_PLANES);
+		for (i = 0; i < planes; i++)
 			printk(KERN_DEBUG "plane %u: bytesperline=%u sizeimage=%u\n", i,
 					mp->plane_fmt[i].bytesperline,
 					mp->plane_fmt[i].sizeimage);


