Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeBZOTD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:19:03 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:50875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbeBZOS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:18:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: ov5695: mark PM functions as __maybe_unused
Date: Mon, 26 Feb 2018 15:18:04 +0100
Message-Id: <20180226141831.2980626-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180226141831.2980626-1-arnd@arndb.de>
References: <20180226141831.2980626-1-arnd@arndb.de>
X-Provags-ID: V03:K0:cq/0JyFz3e2A6aQ3wmsuFWEFIf5BIKLUuWiWCZK6bIFaYNfeFME
 H6STe5L8Se+fJ8dr/Z0tPzTiLv3x/bXpinKAs4rbyJLGoi1ztqbltzD1ys0jPyanOhcD80i
 xgGJa+kFbDEntXddE6AHOalp8dDlPsa4OslCCI9VN5/q/OfdmLuIR+/zGWG0wesb9iXly3C
 +oLdDeVJieZmAE9VRb83w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IhxUsVU22qg=:6z3TGiRauaZTWez3xuv77r
 hOlCnCmsPH0cphJDroQz6TOujEXLNAPCkm5lchd6uk7/QStfhjnmV0ToDDb/+FULd4Yr1/mMF
 Krp9Xpl5UgjgqBY3A0gbDmeqYtYa9mAW9LN8sbH48RUtZxcHIal+lYWlWdDdCyS4308GrIY1t
 0usdkzLEvg0qumXFBt5XPPJ+fb7o9dXBAVX+4dWSATtzM+EHYIgVuJqNXzONPzYXYy+eHPdoz
 xj1R3vF+AhVg3SEOOgMdH2Mzk90GQFPpcN/hvNa1GReoTqQ2v6HCuEUdNGT/6Wru300rga+Ax
 8xoHGFz8eip2kmiUxiwleETc/TEIvmB+WCpZaJcHRchBbyDQhXlcY7X3dLEELwIpptlvlO1t5
 yMbU5O4/e15OdWy0Y8jfJMGtyLOUMhrThgFeWcu/Rc24hJLjAw2OEOgltwHhuerw7IapaQvRJ
 jJaR7xMMHDBhLe24nkVA0BwTFq4n/+ijl84vu9n4gfKYsN/jCPT72Z9yPQsffRYwVMcB8PgDb
 gZnNObXBCxyh35M3OFFNiEBxbTb19HQW82ZPD5hkdrxkjbaZomsgJS7RlDO8bGIU3NsATfUNi
 m2SQWUPYkhjkYt5etvjLONvvh/sExesGU/gg4E0o+kkp/eCYOFA45fbVwILENMiXvC8SHI8r1
 8rexSbFx1qs+yMO22glatIR6fqntWg0T/edxvH1Ap2C96Py1hEIHFa+u3iYjXASyu7I/9De0o
 BvwH29Wz4zlUQx62bd/N8D94EzgiojV/YyKTeg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_PM, we get a harmless build warning:

drivers/media/i2c/ov2685.c:516:12: error: 'ov2685_runtime_suspend' defined but not used [-Werror=unused-function]
 static int ov2685_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~
drivers/media/i2c/ov2685.c:507:12: error: 'ov2685_runtime_resume' defined but not used [-Werror=unused-function]
 static int ov2685_runtime_resume(struct device *dev)

This marks the affected functions as __maybe_unused.

Fixes: e3861d9118c8 ("media: ov2685: add support for OV2685 sensor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/ov2685.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index 904ac305d499..9ac702e3ae95 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -504,7 +504,7 @@ static int ov2685_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 }
 #endif
 
-static int ov2685_runtime_resume(struct device *dev)
+static int __maybe_unused ov2685_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
@@ -513,7 +513,7 @@ static int ov2685_runtime_resume(struct device *dev)
 	return __ov2685_power_on(ov2685);
 }
 
-static int ov2685_runtime_suspend(struct device *dev)
+static int __maybe_unused ov2685_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
-- 
2.9.0
