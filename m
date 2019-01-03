Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE347C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E786217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546532045;
	bh=lNOpj4g5HIgfoHO4rXfQ6R0O1NXv8GGA2SoF9Dx53r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zmxZfEPidaLVgfETKfpbMFH4WDjuopzGxy3Qn65utL+dm8BHKmuQ1raEOZ8NAJv0c
	 CI6NTBKNHJfPRq3p+0Du7PtG3+jV/p/bbOi8G9sP9nliAYbhd6np7oYQrYkS4tHrFU
	 k6PvPTfFFUwWNhLljP1XY8uhhT8RmXookS/VphBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbfACQOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:14:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732205AbfACQOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:14:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E57DF3DBE6;
        Thu,  3 Jan 2019 16:13:59 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0D1B5D9C5;
        Thu,  3 Jan 2019 16:13:57 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/2] tools iio: Override CFLAGS assignments
Date:   Thu,  3 Jan 2019 17:13:50 +0100
Message-Id: <20190103161350.11446-3-jolsa@kernel.org>
In-Reply-To: <20190103161350.11446-1-jolsa@kernel.org>
References: <20190103161350.11446-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 03 Jan 2019 16:14:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So user could specify outside CFLAGS values.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

