Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeFCM2p (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751849AbeFCM2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH 10/29] tools include: Add UINT_MAX def to kernel.h
Date: Sun,  3 Jun 2018 14:26:33 +0200
Message-Id: <20180603122652.17453-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit eaa75b5117d52adf1efd3c6c3fb4bd8f97de648b upstream.

The kernel has it and some files we got from there would require us
including the userland header for that, so add it conditionally.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-gmwyal7c9vzzttlyk6u59rzn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/kernel.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 28607db02bd3..adb4d0147755 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -5,6 +5,10 @@
 #include <stddef.h>
 #include <assert.h>
 
+#ifndef UINT_MAX
+#define UINT_MAX	(~0U)
+#endif
+
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 
 #define PERF_ALIGN(x, a)	__PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
-- 
2.17.1
