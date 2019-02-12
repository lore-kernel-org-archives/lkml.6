Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6210C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFF8222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvD3sPQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfBLRRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:17:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45128 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfBLRQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so1584407pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/lnWMMCIsg4/tFUsl2j1cd75JRahCaG7A5ViWQnd0OY=;
        b=nvD3sPQVTmPup1RY7P6dkHQg3RQbopWaNl2R7n0ekAHhDAV5NE/q69+aIzpOmXe6XU
         IcwLyhmnoL2lS90lSvUSI/ta9vrDvlC1/Ub3O/uynQAv0zL3YY+dqzL2GZ3Yw8m49APy
         +OzEmV3koMukBg5tYr/x0HFN3dTnYQuSOy0JH9M2qBzjO9DMzqagpMDhG/GBa8f247iQ
         gAz0RJOK0D+R30EfucoL6waUOOzflugJpiWEJATPoMRo61FvUY8AnX9CnnQWTuAYsnN6
         SZfaOJBeasDCJpcvhKRJYeqCXl7sKm7S+utqmOCNtl5qcQqPoucR/aXS4Zu03+DOsAYY
         v19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/lnWMMCIsg4/tFUsl2j1cd75JRahCaG7A5ViWQnd0OY=;
        b=PLXTjCX5HiBX3/3i2mJYdJvxGC2WjXNc2qyfvVIB/KGVxPF8GOFiTUj0bWG2fOE2WI
         RIZbxYhpEVD82FWiW/S3d2aNeinZ8dfZ6YMHpoq2r1i8JMWxqs9C5Xr8eUuCHEYni63R
         LOW3H8kMAQJvmfHGE3lBrwxRlcEoKFvCtUPs03J5JX5iMuoo4VfKUIAy0P8aMb4JTpcQ
         tm2b+q4r9/ubeZo4P27Ar3mK1fAuL7v2HGUL6WXRjlT79AF9Sg4BWaMmzLJg6hN0Tf8z
         HJgn2044WGfwDrrutC19QYD/naw1PIdbni1fx136Hzm3rwmY5IWdvqS24LDRMcLyDHlz
         h14Q==
X-Gm-Message-State: AHQUAub/Z8+vcdgoDFJM4TDAJ5n34ddT0YkmDIq5QfqjlPvok3Ik1rZd
        aE+76zbCOImofkJgA9/PcUpngg==
X-Google-Smtp-Source: AHgI3Ibg4yRTiwUB97N4T/Zowkzyk+Qz66rIKYI5nXP8LBvvnCG7LvRXo7CLmn5dSW1yFeu7OplNiQ==
X-Received: by 2002:a17:902:9884:: with SMTP id s4mr4777634plp.1.1549991783804;
        Tue, 12 Feb 2019 09:16:23 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:23 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] perf tools: Fix wrong return values in error path
Date:   Tue, 12 Feb 2019 10:16:08 -0700
Message-Id: <20190212171618.25355-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function cs_etm__mem_access() is supposed to return a u32 but the error
path returns negative values at a couple of places, something that really
throws off the clients using it.  Fix the situation by return '0'.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1d9419a0cf0c..f396fee9bb95 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -324,7 +324,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	struct	 addr_location al;
 
 	if (!etmq)
-		return -1;
+		return 0;
 
 	machine = etmq->etm->machine;
 	cpumode = cs_etm__cpu_mode(etmq, address);
@@ -332,7 +332,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	thread = etmq->thread;
 	if (!thread) {
 		if (cpumode != PERF_RECORD_MISC_KERNEL)
-			return -EINVAL;
+			return 0;
 		thread = etmq->etm->unknown_thread;
 	}
 
-- 
2.17.1

