Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3370BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0F320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0F320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966989AbeFRIaf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:30:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966718AbeFRIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:30:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5AB7AC83;
        Mon, 18 Jun 2018 08:30:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 037/189] drm/msm/dsi: use correct enum in dsi_get_cmd_fmt
Date:   Mon, 18 Jun 2018 10:12:13 +0200
Message-Id: <20180618081210.804082923@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit a4af89286f8fc382459308764ea05935dc477cdc ]

The function dsi_get_cmd_fmt returns enum dsi_cmd_dst_format,
use the correct enum value also for MIPI_DSI_FMT_RGB666/_PACKED.

This has been discovered using clang:
  drivers/gpu/drm/msm/dsi/dsi_host.c:743:35: warning: implicit conversion
        from enumeration type 'enum dsi_vid_dst_format' to different
        enumeration type 'enum dsi_cmd_dst_format' [-Wenum-conversion]
          case MIPI_DSI_FMT_RGB666:       return VID_DST_FORMAT_RGB666;
                                          ~~~~~~ ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -740,7 +740,7 @@ static inline enum dsi_cmd_dst_format ds
 	switch (mipi_fmt) {
 	case MIPI_DSI_FMT_RGB888:	return CMD_DST_FORMAT_RGB888;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-	case MIPI_DSI_FMT_RGB666:	return VID_DST_FORMAT_RGB666;
+	case MIPI_DSI_FMT_RGB666:	return CMD_DST_FORMAT_RGB666;
 	case MIPI_DSI_FMT_RGB565:	return CMD_DST_FORMAT_RGB565;
 	default:			return CMD_DST_FORMAT_RGB888;
 	}


