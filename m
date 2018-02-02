Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeBBBcw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 20:32:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51959 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751708AbeBBBcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 20:32:43 -0500
From: Wu Zongyong <cordius.wu@huawei.com>
To: <kvm@vger.kernel.org>
CC: <kwankhede@nvidia.com>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>, <weijinfen@huawei.com>,
        <wanzongshun@huawei.com>
Subject: [PATCH] vfio-mdev: send KOBJ_CHANGE event after creating mdev sysfs files
Date: Fri, 2 Feb 2018 09:29:06 +0800
Message-ID: <1517534946-49165-1-git-send-email-cordius.wu@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.157.230]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like SR-IOV, driver should notify that sysfs files like some attrs or
symbol links after cretation finished.

Signed-off-by: Wu Zongyong <cordius.wu@huawei.com>
---
 drivers/vfio/mdev/mdev_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 1269910..64cc808 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -351,6 +351,8 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 		goto create_failed;
 	}
 
+	kobject_uevent(&(mdev->dev.kobj), KOBJ_CHANGE);
+
 	mdev->type_kobj = kobj;
 	dev_dbg(&mdev->dev, "MDEV: created\n");
 
-- 
1.9.1
