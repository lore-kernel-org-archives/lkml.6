Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754219AbeEWHEF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:04:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754042AbeEWHEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:04:02 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <pablo@netfilter.org>, <kadlec@blackhole.kfki.hu>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <coreteam@netfilter.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] netfilter: uapi: includes linux/types.h
Date: Wed, 23 May 2018 15:03:26 +0800
Message-ID: <20180523070326.15968-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-7.3.0 report following warning:
./usr/include/linux/netfilter/nf_osf.h:27: found __[us]{8,16,32,64} type without #include <linux/types.h>

includes linux/types.h to fix it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/uapi/linux/netfilter/nf_osf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_osf.h b/include/uapi/linux/netfilter/nf_osf.h
index 45376ea..d1dbe00 100644
--- a/include/uapi/linux/netfilter/nf_osf.h
+++ b/include/uapi/linux/netfilter/nf_osf.h
@@ -1,6 +1,8 @@
 #ifndef _NF_OSF_H
 #define _NF_OSF_H
 
+#include <linux/types.h>
+
 #define MAXGENRELEN	32
 
 #define NF_OSF_GENRE	(1 << 0)
-- 
2.7.0
