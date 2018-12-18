Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D883C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49176217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171440;
	bh=gZ+4urcYmkxyzZYOrmG6t4xhFoNWJsDAX/qQAKzBJXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2NaZmQbcpvJV9UCK5GSoPUPqvW8hlTqQdaS9BOB2HIAigqokXhE7Sy8tPB/8GaZGL
	 KaCD2YBOBsnwCjGyNpyXMz/sdpIJgT2V8c8WtpxcLpykpTEymZ3Ompk2Q/L2jUmWbz
	 XZCKFDM6luRirrU0NawHFIJzSi5os+DVKiEkxfQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeLRWRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRWRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:17:17 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A82218A2;
        Tue, 18 Dec 2018 22:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171437;
        bh=gZ+4urcYmkxyzZYOrmG6t4xhFoNWJsDAX/qQAKzBJXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPRRfpLGzFv5gHJVHJXW8eNtdJq29UeSKIkXjNNKStdkYbt+1ii15bdSW+ATIct7e
         88qOuLDjcnfG/dqhdNIilP3ADCEN5rrtvCJMEFMViQ3BID7BO5CZXaAZ9I0EdmGVsM
         vufVji1e5lTHLVIsV13hLY+azGGHKAq9R/KpEF6g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 59/63] tools headers uapi: Grab a copy of fadvise.h
Date:   Tue, 18 Dec 2018 19:07:29 -0300
Message-Id: <20181218220733.15839-60-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used to generate the string table for fadvise64's 'advice'
argument.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-muswpnft8q9krktv052yrgsc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fadvise.h | 22 ++++++++++++++++++++++
 tools/perf/check-headers.sh        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 tools/include/uapi/linux/fadvise.h

diff --git a/tools/include/uapi/linux/fadvise.h b/tools/include/uapi/linux/fadvise.h
new file mode 100644
index 000000000000..0862b87434c2
--- /dev/null
+++ b/tools/include/uapi/linux/fadvise.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef FADVISE_H_INCLUDED
+#define FADVISE_H_INCLUDED
+
+#define POSIX_FADV_NORMAL	0 /* No further special treatment.  */
+#define POSIX_FADV_RANDOM	1 /* Expect random page references.  */
+#define POSIX_FADV_SEQUENTIAL	2 /* Expect sequential page references.  */
+#define POSIX_FADV_WILLNEED	3 /* Will need these pages.  */
+
+/*
+ * The advise values for POSIX_FADV_DONTNEED and POSIX_ADV_NOREUSE
+ * for s390-64 differ from the values for the rest of the world.
+ */
+#if defined(__s390x__)
+#define POSIX_FADV_DONTNEED	6 /* Don't need these pages.  */
+#define POSIX_FADV_NOREUSE	7 /* Data will be accessed once.  */
+#else
+#define POSIX_FADV_DONTNEED	4 /* Don't need these pages.  */
+#define POSIX_FADV_NOREUSE	5 /* Data will be accessed once.  */
+#endif
+
+#endif	/* FADVISE_H_INCLUDED */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 10d97dc632da..8e811ea0cf85 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -4,6 +4,7 @@
 HEADERS='
 include/uapi/drm/drm.h
 include/uapi/drm/i915_drm.h
+include/uapi/linux/fadvise.h
 include/uapi/linux/fcntl.h
 include/uapi/linux/fs.h
 include/uapi/linux/kcmp.h
-- 
2.19.2

