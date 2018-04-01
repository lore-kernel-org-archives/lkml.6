Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeDALEP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 07:04:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38140 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753471AbeDALEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 07:04:13 -0400
X-Google-Smtp-Source: AIpwx496dTAdQ8Ds0stxMg8xbNK4LwcErmQRQtPWiBhuHdyOQu2YgWYNKIwlWqq6vGCn2oV9fB575A==
Date: Sun, 1 Apr 2018 04:04:10 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] phy: tegra: Remove self cast in tegra_xusb_port_find_lane
Message-ID: <20180401110410.GA3405@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns about casting variables to themselves because it is rarely
necessary. Removing the cast should not change anything regarding the
code and silences the warning.

../drivers/phy/tegra/xusb.c:421:11: warning: explicitly assigning value
of variable of type 'const struct tegra_xusb_lane_map *' to itself
[-Wself-assign]
        for (map = map; map->type; map++) {
             ~~~ ^ ~~~

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
I am not entirely sure if this is the correct solution, especially since
I don't have the hardware and I am not too familiar with this code. If
there is a better solution, please let me know.

Changes from v1 -> v2: Fix spelling error in commit title

 drivers/phy/tegra/xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 63e916d4d069..11aa5902a9ac 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -418,7 +418,7 @@ tegra_xusb_port_find_lane(struct tegra_xusb_port *port,
 {
 	struct tegra_xusb_lane *lane, *match = ERR_PTR(-ENODEV);
 
-	for (map = map; map->type; map++) {
+	for (; map->type; map++) {
 		if (port->index != map->port)
 			continue;
 
-- 
2.16.3
