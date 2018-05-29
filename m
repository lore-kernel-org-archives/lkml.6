Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756073AbeE2COn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:14:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755996AbeE2COU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:14:20 -0400
From: Jason Yan <yanaijie@huawei.com>
To: <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>, <tj@kernel.org>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH 2/8] scsi: libsas: check the lldd callback correctly
Date: Tue, 29 May 2018 10:23:03 +0800
Message-ID: <20180529022309.21071-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180529022309.21071-1-yanaijie@huawei.com>
References: <20180529022309.21071-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using lldd_port_deformed so we'd better check if lldd_port_deformed
is NULL.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/libsas/sas_discover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index a0fa7ef3a071..354f6db5bb66 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -260,7 +260,7 @@ static void sas_suspend_devices(struct work_struct *work)
 	 * phy_list is not being mutated
 	 */
 	list_for_each_entry(phy, &port->phy_list, port_phy_el) {
-		if (si->dft->lldd_port_formed)
+		if (si->dft->lldd_port_deformed)
 			si->dft->lldd_port_deformed(phy);
 		phy->suspended = 1;
 		port->suspended = 1;
-- 
2.13.6
