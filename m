Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84072184E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129672;
	bh=g2ANpTCeZEI8hAZrf6LDc95T/rn8u9ckbi04mf+w1f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhGl6zVmb1IgdX0nn4YZOmbxd/NpU6k5KPKFW0yO6eYqQ7xFOaknCSXJJaBiOXzIv
	 IaJSzqODhyeYRpT7s30nWpE1RMoiYhm4N1AcM700UDq3guM42BaAl2ZomFG4KWP2Sp
	 WbeNqajaK/29rrwnoj9Nre/g/Nd4IQt8oylx8wmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfBYVVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730545AbfBYVVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:07 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C96B621848;
        Mon, 25 Feb 2019 21:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129667;
        bh=g2ANpTCeZEI8hAZrf6LDc95T/rn8u9ckbi04mf+w1f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPG7RN9gKT90ukdguM2V8tsmDrv/DQhzM96oj5vKy2FkZrqsbwW1zpYU1kb+KR0A2
         V3sPh3ZKny+O1OE6zH4/04Tt6O4m7S9CoYx7iNppREFwZgy6bM0N0oFLQDYOt/fN5H
         uFZiUTxmJZwIYmvcyPoXAJEZzbQq45xEJqA5a3+U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/37] perf scripts python: exported-sql-viewer.py: Fix missing shebang
Date:   Mon, 25 Feb 2019 18:20:02 -0300
Message-Id: <20190225212035.24781-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

exported-sql-viewer.py is a standalone python script and requires a
shebang. Also only python2 is supported at present. Restore the shebang
but use the more flexible 'env' form.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: a38352de4495 ("perf script python: Remove explicit shebang from Python script")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c3091401df91..b296028386a6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python2
 # SPDX-License-Identifier: GPL-2.0
 # exported-sql-viewer.py: view data from sql database
 # Copyright (c) 2014-2018, Intel Corporation.
-- 
2.20.1

