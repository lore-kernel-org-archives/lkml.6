Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28135C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7C221479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131764;
	bh=YZTFvmO11zcoJZzuBbtID0ksxXrQ4oj2T5lOlqAFB0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jV8+XpDxsaWBd/YeNgxlQEr7yO1oSKeQf9HuPge5dDGJQh5RlRDaVo0q0GEA4QnC8
	 OxwCZu/J0VS+PYeKnw6wLJo2s1YVcN5YBCOMJsXn6D4PvvKCgx7yTuGM0kSw0fCVR1
	 ZiIHfEekNBDdk6O38gcmK9tizeMLP5LdgmswAagI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7C221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeLFV3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbeLFV3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:20 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3987420989;
        Thu,  6 Dec 2018 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131759;
        bh=YZTFvmO11zcoJZzuBbtID0ksxXrQ4oj2T5lOlqAFB0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLTWPJw0ERJAEwxpL5bI9lKlAQ6w+b9JJvYiERg/SKNtAKjf0tmWv8aLM0BXwY4m+
         Llvb0mivn0LsQj0pKAmLX2bf7to/zsNGer1yfUbnIFWX/+1DLy/7nWgqV3TxyYbrem
         pjShtDgFGMKIzz1SLkgE7zIgjavp7+7cWvXu92U0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 42/75] tools lib subcmd: Fix a few source code comment typos
Date:   Thu,  6 Dec 2018 18:25:29 -0300
Message-Id: <20181206212602.20474-43-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease
cherry-picking and/or backporting, split this into multiple patches.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 6ca2a8bfe716..af9def589863 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -71,7 +71,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `argh`::
  *   token to explain the kind of argument this option wants. Keep it
- *   homogenous across the repository.
+ *   homogeneous across the repository.
  *
  * `help`::
  *   the short help associated to what the option does.
@@ -80,7 +80,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `flags`::
  *   mask of parse_opt_option_flags.
- *   PARSE_OPT_OPTARG: says that the argument is optionnal (not for BOOLEANs)
+ *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
  *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBACKs
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed in
-- 
2.19.2

