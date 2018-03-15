Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeCOJCY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:02:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751826AbeCOJCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:02:21 -0400
From: Honggang LI <honli@redhat.com>
To: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Cc: noaos@mellanox.com, linux-kernel@vger.kernel.org, honli@redhat.com
Subject: [PATCH 1/2] IB/core: Set speed string to SDR for invalid active rates
Date: Thu, 15 Mar 2018 17:02:13 +0800
Message-Id: <20180315090214.21706-2-honli@redhat.com>
In-Reply-To: <20180315090214.21706-1-honli@redhat.com>
References: <20180315090214.21706-1-honli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honggang Li <honli@redhat.com>

commit f1b65df5a232 ("IB/mlx5: Add support for active_width and
active_speed in RoCE"). Before this patch applied, the mlx5_ib
driver set default active_width and active_speed to IB_WIDTH_4X
and IB_SPEED_QDR.

Now, the active_width and active_speed are zeros if the RoCE port
is in DOWN state. The speed string should be set to " SDR" instead of
a blank string when active_speed is zero.

Signed-off-by: Honggang Li <honli@redhat.com>
---
 drivers/infiniband/core/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 8ae1308eecc7..cf36ff1f0068 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -273,6 +273,7 @@ static ssize_t rate_show(struct ib_port *p, struct port_attribute *unused,
 		break;
 	case IB_SPEED_SDR:
 	default:		/* default to SDR for invalid rates */
+		speed = " SDR";
 		rate = 25;
 		break;
 	}
-- 
2.14.GIT
