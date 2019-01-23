Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC1EC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B465820868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfAWA2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:28:07 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.104]:14794 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbfAWA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:28:06 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id C500410132
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 18:28:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m6OjgzZtc2qH7m6Ojgbld8; Tue, 22 Jan 2019 18:28:05 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=38138 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gm6Oj-0047E7-00; Tue, 22 Jan 2019 18:28:05 -0600
Date:   Tue, 22 Jan 2019 18:28:01 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/vmwgfx: Replace PTR_RET with PTR_ERR_OR_ZERO
Message-ID: <20190123002801.GA10357@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gm6Oj-0047E7-00
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:38138
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_RET is deprecated and will be removed soon.

Use PTR_ERR_OR_ZERO instead.

Notice that these are the last instances of PTR_RET in the
whole codebase.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index f2d13a72c05d..137cb1a4d6b0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2521,7 +2521,7 @@ static int vmw_cmd_dx_clear_rendertarget_view(struct vmw_private *dev_priv,
 		SVGA3dCmdDXClearRenderTargetView body;
 	} *cmd = container_of(header, typeof(*cmd), header);
 
-	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_rt,
+	return PTR_ERR_OR_ZERO(vmw_view_id_val_add(sw_context, vmw_view_rt,
 					   cmd->body.renderTargetViewId));
 }
 
@@ -2542,7 +2542,7 @@ static int vmw_cmd_dx_clear_depthstencil_view(struct vmw_private *dev_priv,
 		SVGA3dCmdDXClearDepthStencilView body;
 	} *cmd = container_of(header, typeof(*cmd), header);
 
-	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_ds,
+	return PTR_ERR_OR_ZERO(vmw_view_id_val_add(sw_context, vmw_view_ds,
 					   cmd->body.depthStencilViewId));
 }
 
@@ -2916,7 +2916,7 @@ static int vmw_cmd_dx_genmips(struct vmw_private *dev_priv,
 		SVGA3dCmdDXGenMips body;
 	} *cmd = container_of(header, typeof(*cmd), header);
 
-	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_sr,
+	return PTR_ERR_OR_ZERO(vmw_view_id_val_add(sw_context, vmw_view_sr,
 					   cmd->body.shaderResourceViewId));
 }
 
-- 
2.20.1

