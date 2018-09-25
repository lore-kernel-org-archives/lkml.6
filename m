Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920F7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517E520867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517E520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeIYPhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:37:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53401 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:37:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9U6T53386007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:30:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9U6ZU3386004;
        Tue, 25 Sep 2018 02:30:06 -0700
Date:   Tue, 25 Sep 2018 02:30:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ding Xiang <tipbot@zytor.com>
Message-ID: <tip-01ab2e91103b8c23dfedfeb799bc8b810d585bd0@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        dingxiang@cmss.chinamobile.com, hpa@zytor.com, namhyung@kernel.org,
        mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, acme@redhat.com
Reply-To: hpa@zytor.com, namhyung@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          dingxiang@cmss.chinamobile.com, peterz@infradead.org,
          acme@redhat.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools include: Adopt PTR_ERR_OR_ZERO from the
 kernel err.h header
Git-Commit-ID: 01ab2e91103b8c23dfedfeb799bc8b810d585bd0
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

Commit-ID:  01ab2e91103b8c23dfedfeb799bc8b810d585bd0
Gitweb:     https://git.kernel.org/tip/01ab2e91103b8c23dfedfeb799bc8b810d585bd0
Author:     Ding Xiang <dingxiang@cmss.chinamobile.com>
AuthorDate: Fri, 7 Sep 2018 09:34:41 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:08 -0300

tools include: Adopt PTR_ERR_OR_ZERO from the kernel err.h header

Add PTR_ERR_OR_ZERO, so that tools can use it, just like the kernel.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/err.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 7a8b61ad44cb..094649667bae 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -52,4 +52,11 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
 	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
 }
 
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
 #endif /* _LINUX_ERR_H */
