Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbeE1N5r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162465AbeE1Kko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:40:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 290/329] drm/panel: simple: Fix the bus format for the Ontat panel
Date: Mon, 28 May 2018 12:03:39 +0200
Message-Id: <20180528100305.805344717@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Anholt <eric@anholt.net>

[ Upstream commit 5651e5e094591f479adad5830ac1bc45196a39b3 ]

This fixes bad color output.  When I was first testing the device I
had the DPI hardware set to 666 mode, but apparently in the refactor
to use the bus_format information from the panel driver, I failed to
actually update the panel.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: e8b6f561b2ee ("drm/panel: simple: Add the 7" DPI panel from Adafruit")
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180309233332.1769-1-eric@anholt.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/panel/panel-simple.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1250,7 +1250,7 @@ static const struct panel_desc ontat_yx7
 		.width = 154,
 		.height = 83,
 	},
-	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
 static const struct drm_display_mode ortustech_com43h4m85ulc_mode  = {
