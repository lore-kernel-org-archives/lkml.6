Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3ACC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF82214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCLsawBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF82214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJIIJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeJIIJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:09:16 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE67214C3;
        Tue,  9 Oct 2018 00:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539046495;
        bh=AgUs6qqkcgIxzlIs0/CaS25p8f38Q6XbjkJjMf5tEKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCLsawBom6FriePYmHKMmeOoEwJx+KG+GRZ8QQt/k5FSCIDWPxRzpkyfUWVwV3kJT
         Gdp0dprY8veKCx+Qlv/kdqBfey/HjrTKh9FBUoVyiCrKK2N0HPWg2sMcl+saGRUEOj
         YCjunPkVvwVJSa4KNwDQIa/gGmt/k7UFQ2JN7J0M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/12] perf auxtrace: Include missing asm/bitsperlong.h to get BITS_PER_LONG
Date:   Mon,  8 Oct 2018 21:54:17 -0300
Message-Id: <20181009005427.6607-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The auxtrace.h header references BITS_PER_LONG without including the
header where it is defined, getting it by luck from some other header,
fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-v04ydmbh7tvpcctf3zld9j9s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 0a6ce9c4fc11..d88f6e9eb461 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <asm/bitsperlong.h>
 
 #include "../perf.h"
 #include "event.h"
-- 
2.14.4

