Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2CFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BA421872
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519600;
	bh=PrViat7Avmn4PsPPfGygbH9EKuiGgXmP1PNJilK5+Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M0hHgOgvYAC/oatwjlMkux3lMEqwPGU3xAq9c6lXaOurSfZpxiRrnot5VBZKgJMc8
	 sPN64WU52wUFVOTkKhpDDCesfctv2EDgtc9caJQZwAJvVXolCv5syGNnsIcUhbpms6
	 PDNTAB8LlxYL9bBa8dDZ8A8TiE/ZelkY7jj+X8WQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfACMqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbfACMqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:33 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124EA21871;
        Thu,  3 Jan 2019 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519592;
        bh=PrViat7Avmn4PsPPfGygbH9EKuiGgXmP1PNJilK5+Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XI9io5McdPWanCxPfFkCCpBE44PCZrFWOcSkibOvcNEBQ3wEPUU/TP6Qhlgmm1+uG
         cyUY95sBpALpy7c61pUInDhfCkATnc01QNmHvr1bj3DZ2x8VVNGmqsgJFtSv7aSSva
         PM4MdkXm++0S8Y2azd4aJW/XBoW47q1VR14IzbRQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/29] perf trace: Use correct SECCOMP prefix spelling, "SECOMP_*" -> "SECCOMP_*"
Date:   Thu,  3 Jan 2019 09:45:45 -0300
Message-Id: <20190103124609.29672-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The spelling of the SECCOMP is incorrect, fix these.

Signed-off-by: Colin King <colin.king@canonical.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Link: http://lkml.kernel.org/r/20181221084809.6108-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/seccomp.c b/tools/perf/trace/beauty/seccomp.c
index 4600c28a3cfe..637722e2796b 100644
--- a/tools/perf/trace/beauty/seccomp.c
+++ b/tools/perf/trace/beauty/seccomp.c
@@ -9,7 +9,7 @@
 static size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "SECOMP_SET_MODE_";
+	const char *prefix = "SECCOMP_SET_MODE_";
 	int op = arg->val;
 	size_t printed = 0;
 
@@ -34,7 +34,7 @@ static size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
 						   struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "SECOMP_FILTER_FLAG_";
+	const char *prefix = "SECCOMP_FILTER_FLAG_";
 	int printed = 0, flags = arg->val;
 
 #define	P_FLAG(n) \
-- 
2.19.2

