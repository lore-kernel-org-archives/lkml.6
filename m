Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC9BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97046218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626860;
	bh=tan8gm503CyMNbO/zyyLRB6S3W/rvHSlWQ6JBA1wnBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B5f6DvHaRml47dSdvGu0egLJRcHsLeuO70pwZjlKouKGkDLA5Cws4q8eWlVDxrHjY
	 K1staHuACcRhEg1gDsZiXOMHV29kBSCQvb20oTJSXfbf+V/RRFph9pl24VLAEW/h0l
	 aApLDEenfRzJ6X3TuQiyv3EruvCE5U2gB/SE1MXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfADSeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbfADSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 003C9218DE;
        Fri,  4 Jan 2019 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626856;
        bh=tan8gm503CyMNbO/zyyLRB6S3W/rvHSlWQ6JBA1wnBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QysLHP8e96k38JwWbOmV+f3cMx7RPE9IGCsHflPAqKZ8QP3D3DldrP+/ufQ8E1iVa
         tUTuoGeGuETwl4E70vdJAw6bnf55zflwx31l7SXhNvptbJ2y38Pq1YtXko5U+ZstVH
         U5sRs4qxKv9aWVLUoCV3C5Sc+Ja1datRdwxJn4S0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/16] tools iio: Override CFLAGS assignments
Date:   Fri,  4 Jan 2019 15:33:27 -0300
Message-Id: <20190104183337.12771-7-acme@kernel.org>
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

So user could specify outside CFLAGS values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190103161350.11446-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/iio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 332ed2f6c2c2..e22378dba244 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -12,7 +12,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
-- 
2.20.1

