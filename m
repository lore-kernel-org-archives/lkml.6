Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722952150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722952150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeISRPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:15:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeISRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:15:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8JBbRFq1145316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Sep 2018 04:37:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8JBbQK31145313;
        Wed, 19 Sep 2018 04:37:26 -0700
Date:   Wed, 19 Sep 2018 04:37:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ben Hutchings <tipbot@zytor.com>
Message-ID: <tip-169e366c08084aeb49a3793c892c9abfaa47eeda@git.kernel.org>
Cc:     peterz@infradead.org, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, ben@decadent.org.uk
Reply-To: peterz@infradead.org, acme@redhat.com, namhyung@kernel.org,
          tglx@linutronix.de, jolsa@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          ben@decadent.org.uk, alexander.shishkin@linux.intel.com
In-Reply-To: <20180916151704.GF4765@decadent.org.uk>
References: <20180916151704.GF4765@decadent.org.uk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf Documentation: Fix out-of-tree asciidoctor
 man page generation
Git-Commit-ID: 169e366c08084aeb49a3793c892c9abfaa47eeda
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

Commit-ID:  169e366c08084aeb49a3793c892c9abfaa47eeda
Gitweb:     https://git.kernel.org/tip/169e366c08084aeb49a3793c892c9abfaa47eeda
Author:     Ben Hutchings <ben@decadent.org.uk>
AuthorDate: Sun, 16 Sep 2018 16:17:05 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Sep 2018 10:17:16 -0300

perf Documentation: Fix out-of-tree asciidoctor man page generation

The dependency for the man page rule using asciidoctor incorrectly
specifies a source file in $(OUTPUT).  When building out-of-tree, the
source file is not found, resulting in a fall-back to the following rule
which uses xmlto.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180916151704.GF4765@decadent.org.uk
Fixes: ffef80ecf89f ("perf Documentation: Support for asciidoctor")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 42261a9b280e..ac841bc5c35b 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -280,7 +280,7 @@ $(MAN_HTML): $(OUTPUT)%.html : %.txt
 	mv $@+ $@
 
 ifdef USE_ASCIIDOCTOR
-$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.txt
+$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b manpage -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
