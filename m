Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F2B2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh2gJu5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F2B2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJQHyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:54:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34400 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeJQHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so11767705plr.1;
        Tue, 16 Oct 2018 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwIrt/QiZthUXo9qim2CsYJxYbNHfbi5cRl8NpsI+xE=;
        b=Fh2gJu5v4RNXS0/w2u+wwGiVQ7mxIKzT8TYObGminR3JYEHGs7921rz8TWtegu0Jlk
         mtQjEng4B3pNvQUQtCX7mYeS9miXcqP/CUvuMD6hKsHx66+CzxaVhFgpKD7ZYsh3/uOl
         LASF5u376kmkd4W5ABwOdESDWVJfsN+l9tVOzMAtXznWdVeIeHhFEbG1yzZ9GDIpnLYi
         2nJkddlF8N1ezH3/+Lln6gbiP83f/rU/PBssT2WsQjpHxcjAht6LtxU6b14gFJEX23S7
         7zPGqca5YxRineJGmKMZrEmtDeQUtKXb/R2eGmvOMzHWad8ZBtxOeX71XBKK3YV4T2O8
         EX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwIrt/QiZthUXo9qim2CsYJxYbNHfbi5cRl8NpsI+xE=;
        b=sy1NH6EtY8mcwxsSB+22tXjIEzfG5tlcWMcvIVsEzoQnTZeVJO98FMQlZhprTyTt1d
         5Ob3vpLaXP5OduxSszz+fnzbnlgON5UWgt5scjRJZ6camB77LL6mLG6ecHXrJ81XVH+Q
         VWzAIIpmY+hE5dakc+J9y5eUzt8mukHx6HxxHzKVVKRsVmkyImCdWN7VaLXmyS6x6OQi
         xG/JPqHYSGJ1d2Ll5w4iy8I8uagi+V5rCa0xr1JzQuMS7y1X84+BtOYevgWUvAK/dwuX
         6eE8ftxFUjUNycIYYnTKDwNqt5LQwCQEDqQ0H8fs5GKShA3UJonXeYVh1hRsOYJv65wO
         b4aA==
X-Gm-Message-State: ABuFfoid/wyBqMSs5P9FYg5B9Gj9JT9fsGRli6Q9zP1jrUf+yQUTug8A
        l143AVj8msxqpnma7Gh2r/vh0wkz
X-Google-Smtp-Source: ACcGV63sj5FZtLhqmqZlcKgFzeb1TP4UsJ5T0CXH0puqhtC6/DV/MZLISZQhmhJxriE9zsu2HBsLIA==
X-Received: by 2002:a17:902:e01:: with SMTP id 1-v6mr18779150plw.207.1539734451126;
        Tue, 16 Oct 2018 17:00:51 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:50 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 09/12] media: imx: vdic: rely on VDIC for correct field order
Date:   Tue, 16 Oct 2018 17:00:24 -0700
Message-Id: <20181017000027.23696-10-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare_vdi_in_buffers() was setting up the dma pointers as if the
VDIC is always programmed to receive the fields in bottom-top order,
i.e. as if ipu_vdi_set_field_order() only programs BT order in the VDIC.
But that's not true, ipu_vdi_set_field_order() is working correctly.

So fix prepare_vdi_in_buffers() to give the VDIC the fields in whatever
order they were received by the video source, and rely on the VDIC to
sort out which is top and which is bottom.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-vdic.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
index 482250d47e7c..4a890714193e 100644
--- a/drivers/staging/media/imx/imx-media-vdic.c
+++ b/drivers/staging/media/imx/imx-media-vdic.c
@@ -219,26 +219,18 @@ static void __maybe_unused prepare_vdi_in_buffers(struct vdic_priv *priv,
 
 	switch (priv->fieldtype) {
 	case V4L2_FIELD_SEQ_TB:
-		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0);
-		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + fs;
-		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
-		break;
 	case V4L2_FIELD_SEQ_BT:
 		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0) + fs;
 		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
 		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + fs;
 		break;
+	case V4L2_FIELD_INTERLACED_TB:
 	case V4L2_FIELD_INTERLACED_BT:
+	case V4L2_FIELD_INTERLACED:
 		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0) + is;
 		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
 		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + is;
 		break;
-	default:
-		/* assume V4L2_FIELD_INTERLACED_TB */
-		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0);
-		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + is;
-		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
-		break;
 	}
 
 	ipu_cpmem_set_buffer(priv->vdi_in_ch_p, 0, prev_phys);
-- 
2.17.1

