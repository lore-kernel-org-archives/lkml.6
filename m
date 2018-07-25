Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3EEC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF2420833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLhHdFNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF2420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbeGYTOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbeGYTOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:14:01 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431AF20833;
        Wed, 25 Jul 2018 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541675;
        bh=QoJR396xYUDzCFtExD/5lEFfmy2YOIvkbjXNIxFBcmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLhHdFNfB9CiZLLqiXa0RSO8M+mmqqDw3fZRTlwRN80yQKP+UirDfy/TiHu4xDMxQ
         t4xaSUWD996HLdfyVgplPGT9XOwJmhV/CygIuhvFsV2hAQ2h2Ek2TsDyqw78H3+SxV
         myOPQO9PCA53F6SUu3lYFrCZbf0Cf0ekS0ctldPo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/27] perf list: Add missing documentation for --desc and --debug options
Date:   Wed, 25 Jul 2018 14:59:44 -0300
Message-Id: <20180725180001.15108-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

Add missing documentation for --desc and --debug options to the 'perf
list' man page.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180717110738.10779-1-qpakzk@gmail.com
[ Clarify that --desc is by default active ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14e13512c05f..236b9b97dfdb 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -18,6 +18,10 @@ various perf commands with the -e option.
 
 OPTIONS
 -------
+-d::
+--desc::
+Print extra event descriptions. (default)
+
 --no-desc::
 Don't print descriptions.
 
@@ -25,11 +29,13 @@ Don't print descriptions.
 --long-desc::
 Print longer event descriptions.
 
+--debug::
+Enable debugging output.
+
 --details::
 Print how named events are resolved internally into perf events, and also
 any extra expressions computed by perf stat.
 
-
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
-- 
2.14.4

