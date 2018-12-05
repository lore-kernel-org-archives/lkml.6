Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EBCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5EF2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="loNJNIJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5EF2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeLERGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:06:39 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:51846 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLERGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:06:37 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1C54410C11A2;
        Wed,  5 Dec 2018 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544029597; bh=MhY2zqECzgAgOwGwefpRZ3WiWfEyyLAEyNmFF4e43nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loNJNIJPfhNtrMnT8GzavgOLjYoI1B2FxAKyNydCZZeO9baEHVi6NQVDuY1AClGXR
         PzrTHM5CL40HxwTWsYkx6kWoqWwcoC3MvR6RdeAKsYsvr/2YJg6720J6IZw6QG7Qnx
         Pa7We5xmWK+WkmGGI+K8wL0c+gPCihqBnOaGlEcmfFxlVP8pfHAlwZ2UY3Jc0MjMtP
         FMu6o8ZeMSHh8AfyE0rv4aiwkIfsNnAxRi/CtnUJsZ+zaZU7TEKpOzNo6ek8glI06p
         OFRTHAZyCWzI42dgG3L1MQBU8/l75lIp6BeAmVyR4v51UonHa8yQA8W0hXP0gEMDd8
         2BQrclmgUwM9A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 58B0A598B;
        Wed,  5 Dec 2018 09:06:34 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 4/5] ARC: perf: fix description comment
Date:   Wed,  5 Dec 2018 20:06:08 +0300
Message-Id: <20181205170609.18690-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix description comment as this code doesn't belong only to
ARC700 anymore.

Also while I'm at it, use SPDX License Identifier.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 8c88837fcd83..b6207090aaa7 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -1,15 +1,10 @@
-/*
- * Linux performance counter support for ARC700 series
- *
- * Copyright (C) 2013-2015 Synopsys, Inc. (www.synopsys.com)
- *
- * This code is inspired by the perf support of various other architectures.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Linux performance counter support for ARC CPUs.
+// This code is inspired by the perf support of various other architectures.
+//
+// Copyright (C) 2013-2018 Synopsys, Inc. (www.synopsys.com)
+
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-- 
2.14.5

