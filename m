Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BEFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1E720883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfAHPkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:40:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfAHPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:40:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08FdvUW3566531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:39:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08Fdvbb3566528;
        Tue, 8 Jan 2019 07:39:57 -0800
Date:   Tue, 8 Jan 2019 07:39:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-536cdb684d2d5139708d290b9dc124b1420886c1@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        peterz@infradead.org, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org, lars@metafoo.de, knaack.h@gmx.de,
        alexander.shishkin@linux.intel.com
Reply-To: andriy.shevchenko@linux.intel.com, acme@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, jic23@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, knaack.h@gmx.de,
          jolsa@kernel.org, namhyung@kernel.org, lars@metafoo.de
In-Reply-To: <20190103161350.11446-3-jolsa@kernel.org>
References: <20190103161350.11446-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools iio: Override CFLAGS assignments
Git-Commit-ID: 536cdb684d2d5139708d290b9dc124b1420886c1
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

Commit-ID:  536cdb684d2d5139708d290b9dc124b1420886c1
Gitweb:     https://git.kernel.org/tip/536cdb684d2d5139708d290b9dc124b1420886c1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 3 Jan 2019 17:13:50 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 4 Jan 2019 12:54:49 -0300

tools iio: Override CFLAGS assignments

So user could specify outside CFLAGS values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190103161350.11446-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/iio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 332ed2f6c2c2..e22378dba244 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -12,7 +12,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
