Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6295C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D4D218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497589;
	bh=DDTV4TjNw4HFh9VMXTBzv+cky4foe5oxRxCYHwOKMw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2z5UW17aUiQ0s2j7kpJtYoIkA5180CZMPqvPXI1XmVO44A1R/Ox/NBceVV2LdF2n
	 2F3lkWetAdEf+OjYPFBatZtq3xx7rPVF0xgaI/Zy50yL0oWMqGCzLPQHUgADtjPJjT
	 fiIhhq/yuYD0Pxk7tFXyIsceQoF47jXA+ae8+Pik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfBRNq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730512AbfBRNqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88ABE218FC;
        Mon, 18 Feb 2019 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497577;
        bh=DDTV4TjNw4HFh9VMXTBzv+cky4foe5oxRxCYHwOKMw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwFZ0L4b6+e2dfr+2tLen1lKIk3QVYIZ+DQ/myJNuYjr4adBbV7SoaLCXrT6Ha8ld
         dX3y8bUEuqp6l3xKXVjzbj24J+2/4+GPs1nlbpZ+R/rHyICwvj5RSxz6cQibajI9ZA
         n3m88/LELyK/YQM0bA4K9oqtntA+nxAx+IGsnSHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 18/92] drm/bridge: tc358767: add bus flags
Date:   Mon, 18 Feb 2019 14:42:21 +0100
Message-Id: <20190218133456.396742199@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4842379cbe6e851de914a7132f76f4e200b9a98b ]

tc358767 driver does not set DRM bus_flags, even if it does configures
the polarity settings into its registers. This means that the DPI source
can't configure the polarities correctly.

Add sync flags accordingly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190103115954.12785-2-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 8e28e738cb52..29a7e33e8ae0 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1195,6 +1195,10 @@ static int tc_bridge_attach(struct drm_bridge *bridge)
 
 	drm_display_info_set_bus_formats(&tc->connector.display_info,
 					 &bus_format, 1);
+	tc->connector.display_info.bus_flags =
+		DRM_BUS_FLAG_DE_HIGH |
+		DRM_BUS_FLAG_PIXDATA_NEGEDGE |
+		DRM_BUS_FLAG_SYNC_NEGEDGE;
 	drm_connector_attach_encoder(&tc->connector, tc->bridge.encoder);
 
 	return 0;
-- 
2.19.1



