Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14200C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2247218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626861;
	bh=4arDZU/HYsDjY4ubKYHFKfF9v/pSuITuf/ZumrJ7cKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qojrUIMcrxkU+WJ0cgeSKR0J3Ev8xpa/Llm7LBMygpX84s+A+SRxXaZxAd/hFStaI
	 GLiun6766LBAJnSin9xoB4YNn8ek8fdmpjDHaIa9w50UCGXQXLnSYOUvzsGHq2Iia8
	 SXAmjsIIwLZtm9tLEeXaFA0E3qU72d7XfWYRD1bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfADSeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbfADSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:14 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26EF218D8;
        Fri,  4 Jan 2019 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626853;
        bh=4arDZU/HYsDjY4ubKYHFKfF9v/pSuITuf/ZumrJ7cKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFP/hb6mUCELLBJXU/9zjABH02sKDuO4JDBsOMzGAfw8fw4O+Xe5sBFeffGjUBZTM
         QYN5iJpbYj2ZiWWXojdfKp5nU1WKIm9T9qzRsrTAdyZ0IxPxokc2bVenPx5eGJuxFD
         ZRNOGmkXoCuVjDInux9D+fKByExsR+o23+5h3ebw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/16] tools thermal tmon: Use -O3 instead of -O1 if available
Date:   Fri,  4 Jan 2019 15:33:26 -0300
Message-Id: <20190104183337.12771-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Using -O3 instead of -O1 if it's supported by compiler.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: http://lkml.kernel.org/r/20190103161350.11446-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/thermal/tmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 89a2444c1df2..59e417ec3e13 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -6,7 +6,7 @@ VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-override CFLAGS+= -O1 ${WARNFLAGS}
+override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
 override CFLAGS+= $(call cc-option,-fstack-protector-strong)
 CC?= $(CROSS_COMPILE)gcc
-- 
2.20.1

