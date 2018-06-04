Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeFDG7h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752251AbeFDG7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 09/29] tools include: Introduce atomic_cmpxchg_{relaxed,release}()
Date: Mon,  4 Jun 2018 08:58:05 +0200
Message-Id: <20180604065802.533217856@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 tools/include/linux/atomic.h |    6 ++++++
 1 file changed, 6 insertions(+)

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
