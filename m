Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF627C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8AF20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8AF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeIYPmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:42:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46639 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeIYPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:42:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9Xqrh3386446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:33:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9XqZJ3386443;
        Tue, 25 Sep 2018 02:33:52 -0700
Date:   Tue, 25 Sep 2018 02:33:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for =?UTF-8?Q?J=C3=A9r=C3=A9mie?= Galarneau" 
        <tipbot@zytor.com>
Message-ID: <tip-c04c859f439fb4de9039246370d60a07b9b5bcb5@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, jeremie.galarneau@efficios.com,
        mingo@kernel.org, hpa@zytor.com
Reply-To: alexander.shishkin@linux.intel.com,
          jeremie.galarneau@efficios.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
          jolsa@kernel.org, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20180829201648.19588-1-jeremie.galarneau@efficios.com>
References: <20180829201648.19588-1-jeremie.galarneau@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Initialize perf_data_file fd field
Git-Commit-ID: c04c859f439fb4de9039246370d60a07b9b5bcb5
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

Commit-ID:  c04c859f439fb4de9039246370d60a07b9b5bcb5
Gitweb:     https://git.kernel.org/tip/c04c859f439fb4de9039246370d60a07b9b5bcb5
Author:     Jérémie Galarneau <jeremie.galarneau@efficios.com>
AuthorDate: Wed, 29 Aug 2018 16:16:48 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:13 -0300

perf tools: Initialize perf_data_file fd field

Building the perf CTF converter fails with gcc 4.8.4 on Ubuntu 14.04
with the following error:

  error: missing initializer for field ‘fd’ of ‘struct perf_data_file’
  [-Werror=missing-field-initializers]

Per 4b838b0db4e9 ("perf tools: Add compression id into 'struct
kmod_path'") and the ensuing discussion on the mailing list, it appears
that this affects other distributions and gcc versions.

Signed-off-by: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180829201648.19588-1-jeremie.galarneau@efficios.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data-convert-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index abd38abf1d91..f75d4aa612c5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1578,7 +1578,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file.path = input,
+		.file      = { .path = input, .fd = -1 },
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
