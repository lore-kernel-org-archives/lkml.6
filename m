Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBD1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7802176F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977616;
	bh=rejYkvPPlpHnxSM0JDgf/qh77do9i2RpyYG2kmG1x5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lMEcI+brANLisiFV6vYlVKJ8mQuv3QoIj+zL7tPIZk6U2dq+mxxkJi7VY6WRIwlcX
	 XUWqFMi4nYwBWHiEB3BRxloVQ/WzgQcV61Fr6JqGUogK8vuG7u9a3k9nQpc8AKSp/L
	 M7S6LRR1yAQyS16Sa9Y5rww7kTbsqrD/VDabA2jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfAHUAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733061AbfAHUAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:00:10 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CBE2176F;
        Tue,  8 Jan 2019 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977610;
        bh=rejYkvPPlpHnxSM0JDgf/qh77do9i2RpyYG2kmG1x5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v50EUy487l9MQ8rF6K+9kzPSNrMRnzHM2KGT7xHN47f40vu0+BWdnxXl3MAWKxqW3
         CQlccC3ddCL/sXOTnXdjAIKLZzWg1l0fKH35xUFucJFVVZIYJAhbBWazD4fBLl4/g4
         hi08MNh9el2QBqv4pTSm4MzxGotM8EBlYFzn/y9c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 14/16] perf beauty: Switch from using uapi/linux/fs.h to uapi/linux/mount.h
Date:   Tue,  8 Jan 2019 16:59:08 -0300
Message-Id: <20190108195910.17726-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As now we'll update our fs.h copy and what tools/perf/trace/beauty/mount_flags.sh
needs just got moved to mount.h, use that instead.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ls19h376xukeouxrw9dswkcn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mount_flags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mount_flags.sh b/tools/perf/trace/beauty/mount_flags.sh
index 45547573a1db..847850b2ef6c 100755
--- a/tools/perf/trace/beauty/mount_flags.sh
+++ b/tools/perf/trace/beauty/mount_flags.sh
@@ -5,11 +5,11 @@
 
 printf "static const char *mount_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
-egrep $regex ${header_dir}/fs.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
+egrep $regex ${header_dir}/mount.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
 	sed -r "s/$regex/\2 \2 \1/g" | sort -n | \
 	xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+\(1<<([[:digit:]]+)\)[[:space:]]*.*'
-egrep $regex ${header_dir}/fs.h | \
+egrep $regex ${header_dir}/mount.h | \
 	sed -r "s/$regex/\2 \1/g" | \
 	xargs printf "\t[%s + 1] = \"%s\",\n"
 printf "};\n"
-- 
2.20.1

