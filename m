Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeBZOSs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:18:48 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:55901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbeBZOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:18:46 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: ov5695: mark PM functions as __maybe_unused
Date: Mon, 26 Feb 2018 15:18:03 +0100
Message-Id: <20180226141831.2980626-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:EY/Nq/ZgCO0E15vVUsJ2wb+WJ7BLbVbCoD641PlhYDXk3mCv4WN
 xBkY3re3M+6lkFU9xJwLTCPL52GkaO5doCl8gSP6pZdO473zXRgOPEINw9VKdHaqydCGdKa
 143jDWcaHOdcHvHGPHVRtJZKQ50g/smCJMJgUaems8mGiNURWU7lqkLY7El0BQv1slsOopy
 LZQ055tJPWLNEFmxvOhCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UXgjA/VqxtE=:qZ743rnjmoBC7+XI2AyQDa
 Qcni/RCP4yqO3dKpFcB6Vm7J1vpI0s+1k5Ys1Ss9EDR0ay8NoAcj4BiX6lgAW4GQBCzvBG/uf
 AnYvjRRqpcvdmPJ27Axs7OS08BJw18a33LoXJQ4QV0l3VYuAZGOFNKIJIhs0oP4EG9DdfptZ0
 gEULfeouQHCzBHmE2jqn1fdDRqZ/+Lzn4EgDsxiNC9xqasiDj/VNACbGqTz5XMOEIzma34UNW
 +qdAC4hopsVujonpVQSckz8g9f2PxYMWq/LBomkWz8pPeP85km95DwsfLkKuEd/jVtuEhV5Z/
 1kSHBsY0ovjLeuXEwB0khCq+CflNcNapb9QzjYcCnv7KyWTHg9g+9tn2ShfEFqujNmSumk79F
 s5BWpnBSR98NpsnEwlo1quajWSemEbHA2UMcKHcGHf59bcSo3cEMvX1SpK8BBQZKfrWt+ZBys
 u7XqO8o3aBf/RyiEJ/XmWJ8m7JU0oKCE+MrsiReNqSA98oiwzHwKT3khFYsrbENfriWTRQUu1
 OGoVJF9uy+kdDguYmGkEBR8IS4SJ6Xi4uFxJHNN4yZn6tjRNQAVNFaa2aj5LHKPjv3Lv2qnQ3
 xt++Lnx0CBITlZWaCl0pPfzU5DRR9b6BXH0zsrSAEe6K6/H/SJlR7XDL06DAg2Iu6pkN/yj5o
 UK1wlB2lpwMWiXkPFqHTf3yXqNKwk4TSgmfm3DYwzW2BKKHQzayxW7tddiDtt2hE0oNb7XloZ
 lky/O1WEEvFCxQYTAGl0oXBy73UfL+wVURuNSA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_PM, we get a harmless build warning:

drivers/media/i2c/ov5695.c:1033:12: error: 'ov5695_runtime_suspend' defined but not used [-Werror=unused-function]
 static int ov5695_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~
drivers/media/i2c/ov5695.c:1024:12: error: 'ov5695_runtime_resume' defined but not used [-Werror=unused-function]
 static int ov5695_runtime_resume(struct device *dev)

This marks the affected functions as __maybe_unused.

Fixes: 8a77009be4be ("media: ov5695: add support for OV5695 sensor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/ov5695.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
index 2db7d2e535b9..a4985a4715f5 100644
--- a/drivers/media/i2c/ov5695.c
+++ b/drivers/media/i2c/ov5695.c
@@ -1021,7 +1021,7 @@ static void __ov5695_power_off(struct ov5695 *ov5695)
 	regulator_bulk_disable(OV5695_NUM_SUPPLIES, ov5695->supplies);
 }
 
-static int ov5695_runtime_resume(struct device *dev)
+static int __maybe_unused ov5695_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
@@ -1030,7 +1030,7 @@ static int ov5695_runtime_resume(struct device *dev)
 	return __ov5695_power_on(ov5695);
 }
 
-static int ov5695_runtime_suspend(struct device *dev)
+static int __maybe_unused ov5695_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
-- 
2.9.0
