Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1931DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD5320C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD5320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJIMnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:43:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44927 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJIMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:43:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995SMGH909823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:28:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995SM0C909820;
        Mon, 8 Oct 2018 22:28:22 -0700
Date:   Mon, 8 Oct 2018 22:28:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-v04ydmbh7tvpcctf3zld9j9s@git.kernel.org>
Cc:     alexander.sverdlin@nokia.com, jolsa@kernel.org, mingo@kernel.org,
        hpa@zytor.com, dsahern@gmail.com, wangnan0@huawei.com,
        acme@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          dsahern@gmail.com, acme@redhat.com, wangnan0@huawei.com,
          mingo@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          alexander.sverdlin@nokia.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace: Include missing asm/bitsperlong.h to
 get BITS_PER_LONG
Git-Commit-ID: 291ed51deee49ff35d0824fb7050538b449964d6
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

Commit-ID:  291ed51deee49ff35d0824fb7050538b449964d6
Gitweb:     https://git.kernel.org/tip/291ed51deee49ff35d0824fb7050538b449964d6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Sep 2018 11:52:10 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 14:23:43 -0300

perf auxtrace: Include missing asm/bitsperlong.h to get BITS_PER_LONG

The auxtrace.h header references BITS_PER_LONG without including the
header where it is defined, getting it by luck from some other header,
fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-v04ydmbh7tvpcctf3zld9j9s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 0a6ce9c4fc11..d88f6e9eb461 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <asm/bitsperlong.h>
 
 #include "../perf.h"
 #include "event.h"
