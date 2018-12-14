Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C8EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EE92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbeLNU0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:26:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:26:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKPxwa1453282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:25:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKPweb1453279;
        Fri, 14 Dec 2018 12:25:58 -0800
Date:   Fri, 14 Dec 2018 12:25:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tlt97p066zyhzqhl5jt86og7@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, namhyung@kernel.org, julia.lawall@lip6.fr,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, dsahern@gmail.com,
        tglx@linutronix.de, hpa@zytor.com, wangnan0@huawei.com,
        mingo@kernel.org, adrian.hunter@intel.com,
        yellowriver2010@hotmail.com, dhowells@redhat.com
Reply-To: adrian.hunter@intel.com, yellowriver2010@hotmail.com,
          dhowells@redhat.com, wangnan0@huawei.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          dsahern@gmail.com, tglx@linutronix.de, hpa@zytor.com,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, namhyung@kernel.org, julia.lawall@lip6.fr
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools include: Adopt ERR_CAST() from the kernel
 err.h header
Git-Commit-ID: c4838c7bad14c3cf6c779c24794044bc48b53002
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c4838c7bad14c3cf6c779c24794044bc48b53002
Gitweb:     https://git.kernel.org/tip/c4838c7bad14c3cf6c779c24794044bc48b53002
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 27 Nov 2018 09:56:55 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:48 -0300

tools include: Adopt ERR_CAST() from the kernel err.h header

Add ERR_CAST(), so that tools can use it, just like the kernel.

This addresses coccinelle checks that are being performed to tools/ in
addition to kernel sources, so lets add this to cover that and to get
tools code closer to kernel coding standards.

This originally was introduced in the kernel headers in this cset:

  d1bc8e954452 ("Add an ERR_CAST() function to complement ERR_PTR and co.")

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/n/tip-tlt97p066zyhzqhl5jt86og7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/err.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 094649667bae..2f5a12b88a86 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -59,4 +59,17 @@ static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 	else
 		return 0;
 }
+
+/**
+ * ERR_CAST - Explicitly cast an error-valued pointer to another pointer type
+ * @ptr: The pointer to cast.
+ *
+ * Explicitly cast an error-valued pointer to another pointer type in such a
+ * way as to make it clear that's what's going on.
+ */
+static inline void * __must_check ERR_CAST(__force const void *ptr)
+{
+	/* cast away the const */
+	return (void *) ptr;
+}
 #endif /* _LINUX_ERR_H */
