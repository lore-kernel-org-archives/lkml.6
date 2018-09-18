Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA2ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0586214FA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+AjhEm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0586214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbeIRVLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbeIRVLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:11:09 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A6D214C2;
        Tue, 18 Sep 2018 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537285082;
        bh=ZGC74nv7qI548JUKpTvMDdbPBvD4vk1zqvOVncpS3FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+AjhEm4c8fb9VlEV+8iahYcqrL/Kvb99ba+ZdFUtjgaBVs0g1JAOkRQDVPLkOs29
         nUhPcnIG24eGjPoleV5ppcFmC7w/MpYCVC/TLesxJCbIh35huxDwyLFTcAjph/zNGk
         EOTz3kZYizKu+JJGfx7InS2TQcgJgLwxLDbH3+kc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/2] perf Documentation: Fix out-of-tree asciidoctor man page generation
Date:   Tue, 18 Sep 2018 12:37:25 -0300
Message-Id: <20180918153725.7022-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918153725.7022-1-acme@kernel.org>
References: <20180918153725.7022-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

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
-- 
2.14.4

