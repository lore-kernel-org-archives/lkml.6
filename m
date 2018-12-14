Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C920C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBABD208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbeLNUTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:19:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbeLNUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:19:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKIwxE1450633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:18:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKIvXI1450630;
        Fri, 14 Dec 2018 12:18:57 -0800
Date:   Fri, 14 Dec 2018 12:18:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lnxqszts6aq2c9jy4b7mlnym@git.kernel.org>
Cc:     dsahern@gmail.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com, eranian@google.com,
        wangnan0@huawei.com, jolsa@kernel.org, acme@redhat.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org,
          mingo@kernel.org, dsahern@gmail.com,
          linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
          wangnan0@huawei.com, adrian.hunter@intel.com, eranian@google.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build: Give better hint about devel package
 for libssl
Git-Commit-ID: 7d0df6572c455eeed498a110d5db64be16941fbc
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

Commit-ID:  7d0df6572c455eeed498a110d5db64be16941fbc
Gitweb:     https://git.kernel.org/tip/7d0df6572c455eeed498a110d5db64be16941fbc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 29 Nov 2018 20:41:54 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:46 -0300

perf build: Give better hint about devel package for libssl

In debian/ubuntu its libssl-dev, but for fedora/RHEL/Centos/etc its
openssl-devel, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 8ee4646038e4 ("perf build: Add libcrypto feature detection")
Link: https://lkml.kernel.org/n/tip-lnxqszts6aq2c9jy4b7mlnym@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e110010e7faa..c643d5e0c26b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -588,7 +588,7 @@ endif
 
 ifndef NO_LIBCRYPTO
   ifneq ($(feature-libcrypto), 1)
-    msg := $(warning No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev);
+    msg := $(warning No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev);
     NO_LIBCRYPTO := 1
   else
     CFLAGS += -DHAVE_LIBCRYPTO_SUPPORT
