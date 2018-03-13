Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeCMMlM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:41:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55263 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752432AbeCMMlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:41:11 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <acme@redhat.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <namhyung@kernel.org>,
        <jolsa@redhat.com>, <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <kan.liang@linux.intel.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v2 -perf/core 2/2] perf debug: Avoid set quiet once more
Date: Tue, 13 Mar 2018 20:31:14 +0800
Message-ID: <1520944274-37001-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1520944274-37001-1-git-send-email-xieyisheng1@huawei.com>
References: <1520944274-37001-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use --quiet to disable log, we will set quiet first, then check the
quiet to decide whether need to call perf_quiet_option, so no need to set
the quiet once more.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 - This is a new add-on patch

 tools/perf/util/debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index f3a71db..3d64596 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -232,7 +232,6 @@ int perf_quiet_option(void)
 		var++;
 	}
 
-	quiet = true;
 	return 0;
 }
 
-- 
1.7.12.4
