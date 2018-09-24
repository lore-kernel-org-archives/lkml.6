Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FE8ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639C52087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBlN4Ltk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639C52087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeIXVFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbeIXVFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:05:47 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37CB2087A;
        Mon, 24 Sep 2018 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801393;
        bh=R1LbUZZIIajrKIWypLS5nsqXMOCCXVpt2sdIUSQBWiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBlN4LtkjEGhPGb+BDsFHaRlqFClouCH7of2RQGO3FtDM3ABzd4TWCvI5YiOHiRfQ
         eIborc9Bbw4aTEYiBzYc9ApGkvkJyTT1/n/7yMDPMyIABxjsJOiPcsLyWmKoWcvadf
         Th0irSveI+BiH72EUgiU5lWhg2Ihp//Jc/OLTbM8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/27] perf help: Add missing subcommand `version`
Date:   Mon, 24 Sep 2018 12:02:16 -0300
Message-Id: <20180924150242.14235-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

There isn't subcommand `version` when typing `perf help`.

Before :

  $ perf help | grep version
   usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

So add perf-version in command-list.txt for listing it when typing `perf
help`.

After :

$ perf help | grep version

 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
   version         display the version of perf binary

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180919074911.41931-1-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index 2d0caf20ff3a..bc6c585f74fc 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -30,3 +30,4 @@ perf-test			mainporcelain common
 perf-timechart			mainporcelain common
 perf-top			mainporcelain common
 perf-trace			mainporcelain audit
+perf-version			mainporcelain common
-- 
2.14.4

