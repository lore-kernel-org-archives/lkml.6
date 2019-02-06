Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468DFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09006218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478969;
	bh=l78sgM6WcvkXlUcCEjvhzjfjycvymzt3JLDlNU2q0+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WOjEzUckrMNJ4+4w94YVBD9GVrBrzU2HYvYv+6r5BD6mCd6EquMrq3CTaSCPhCzJL
	 R8JYnDESPpcIx9bK+s7LtZO1o8o5Agib1S0VYeFVMO9KECCH36CwGeZAts+I5OuBdQ
	 xIprAuIHZbNQWy7/GOdaZ9ZoeHrOaKDjdUO4Ck6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfBFStZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfBFStY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:24 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D78A206DD;
        Wed,  6 Feb 2019 18:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478964;
        bh=l78sgM6WcvkXlUcCEjvhzjfjycvymzt3JLDlNU2q0+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGsb2wTUXqiGEz8/aRFGPC9IDjIiYRqzruD4I/Ld3QvZ+DHFgjn31GjLBdpoWkgzP
         v2COdWgOVThcaIrNAdxMlKoad9+Vng4HuBSbYpvF9amzAvlUgnpS2UVHXMB32QIsLe
         TFoEvmoJqqCHaJ3t2R/98jDgZm3+ZePnsF7QFLQw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 02/53] perf arm pmu: Add missing linux/string.h header
Date:   Wed,  6 Feb 2019 15:48:12 -0300
Message-Id: <20190206184903.24054-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It uses strstarts(), that is defined in linux/string.h but that was
being including by sheer luck, indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-vub5lp82wb7vy5wssfad0xu8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index e047571e6080..64a677b518d0 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <linux/coresight-pmu.h>
 #include <linux/perf_event.h>
+#include <linux/string.h>
 
 #include "cs-etm.h"
 #include "arm-spe.h"
-- 
2.20.1

