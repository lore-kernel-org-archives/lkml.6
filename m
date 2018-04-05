Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeDEJud (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:50:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60650 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeDEJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:50:31 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, ykk@rock-chips.com, kernel@collabora.com,
        m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org,
        jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v6 08/30] drm/bridge: analogix_dp: Extend hpd check time to 100ms
Date: Thu,  5 Apr 2018 11:49:38 +0200
Message-Id: <20180405095000.9756-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405095000.9756-1-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

There was a 1ms delay to detect the hpd signal, which is too short to
detect a short pulse. This patch extends this delay to 100ms.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Cc: 征增 王 <wzz@rock-chips.com>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5957e2338071..1f4f34149019 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -76,7 +76,7 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 			return 0;
 
 		timeout_loop++;
-		usleep_range(10, 11);
+		usleep_range(1000, 1100);
 	}
 
 	/*
-- 
2.16.3
