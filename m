Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411CC20449
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497903;
	bh=ZaN8Xvp0931p9i0YBsp1beuZx0Crizs9oF4tzPPg6w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IbgsLsugYlVOO9W6TXqahrYGuC/X2kqqWesbZuLz430vm82lhHn3haY2fCFzj+czl
	 S9g774WeNtPIqzBm19wHSNN1DW3xv/hB75mDjbiWKYHXH94yjKaSj7gz7hMMTOzkVg
	 +M58xeFWMnkiZ9himLSU1fNsT+O4oqqf0S/Ix7SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfBRNvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:51:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732449AbfBRNvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:51:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0163121905;
        Mon, 18 Feb 2019 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497897;
        bh=ZaN8Xvp0931p9i0YBsp1beuZx0Crizs9oF4tzPPg6w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhcIoGecM7mSGv4YQg1LUvRHkG1H/WrTyuqnKIE2TIEpbTs6hDxtoO1O8uhpM+c08
         1lPGPs9vYySijwfGOxtOYjk1bh46c/0nMlCUCOhKUmVCHSHklcrrqKv0QkkTGK9RRM
         OdKy7EEi1tZ7f1EbeSYc5gc9sdhdKBlZdI7qnsr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 28/85] drm/bridge: tc358767: add bus flags
Date:   Mon, 18 Feb 2019 14:42:54 +0100
Message-Id: <20190218133502.817099167@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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



