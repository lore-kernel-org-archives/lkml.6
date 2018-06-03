Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeFCM2r (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeFCM2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/29] tools include: Introduce atomic_cmpxchg_{relaxed,release}()
Date: Sun,  3 Jun 2018 14:26:32 +0200
Message-Id: <20180603122652.17453-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 2bcdeadbc094b4f6511aedea1e5b8052bf0cc89c upstream.

Will be used by refcnt.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-jszriruqfqpez1bkivwfj6qb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/atomic.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
index 4e3d3d18ebab..9f21fc2b092b 100644
--- a/tools/include/linux/atomic.h
+++ b/tools/include/linux/atomic.h
@@ -3,4 +3,10 @@
 
 #include <asm/atomic.h>
 
+/* atomic_cmpxchg_relaxed */
+#ifndef atomic_cmpxchg_relaxed
+#define  atomic_cmpxchg_relaxed		atomic_cmpxchg
+#define  atomic_cmpxchg_release         atomic_cmpxchg
+#endif /* atomic_cmpxchg_relaxed */
+
 #endif /* __TOOLS_LINUX_ATOMIC_H */
-- 
2.17.1
