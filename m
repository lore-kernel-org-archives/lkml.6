Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936151AbeEYKT6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:19:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55706 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S936009AbeEYKT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:19:56 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <ast@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] bpfilter: fix a build err
Date: Fri, 25 May 2018 18:17:57 +0800
Message-ID: <20180525101757.13756-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-7.3.0 report following err:

  HOSTCC  net/bpfilter/main.o
In file included from net/bpfilter/main.c:9:0:
./include/uapi/linux/bpf.h:12:10: fatal error: linux/bpf_common.h: No such file or directory
 #include <linux/bpf_common.h>

remove it by adding a include path.
Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bpfilter/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 2af752c..3f3cb87 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -5,7 +5,7 @@
 
 hostprogs-y := bpfilter_umh
 bpfilter_umh-objs := main.o
-HOSTCFLAGS += -I. -Itools/include/
+HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
 ifeq ($(CONFIG_BPFILTER_UMH), y)
 # builtin bpfilter_umh should be compiled with -static
 # since rootfs isn't mounted at the time of __init
-- 
2.7.0
