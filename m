Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A83DC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFB9222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVKqyCWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfBLRRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:17:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35512 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbfBLRQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so1555750pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F3htzumhw0wsBNPb1jzbmXRsC9SD4nCo3kem2V3UyCY=;
        b=EVKqyCWCkFmsCIw/cwaM55FNXGvjvtuhlkDhHlLuPyeOPf1jNJCvsyST22FJeP3N08
         SaUxsMOgtm6P50sL15JMmR15PmSkCrH7Rttno88S5ejE67CA5y6fcMGBHTgku9Qvoldn
         6LHz6eMcW4WrUw+DLg2ZzIZX7HE3TADx1uCL/CAwi7l7OolGwnyBVPQLc58u51PjOREH
         j09tKlsRce7Blh6xjKlly0m9P2mkNaI0jIfNrVusW8yp/oJGh184U583VnC1fFtUtlGE
         l+U+UiptDpUXCrhGP5Dkj4MK8dEzNwss8XtKGp9yE+5xMLnzlv0bxS4HsJFkAnp4orIa
         m2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F3htzumhw0wsBNPb1jzbmXRsC9SD4nCo3kem2V3UyCY=;
        b=S1d3kSd8fVziToUiiMZkLvYB0EjTu0IUF9xdDZaYImzaL55Cys2H/jUcYyx6iHcdM7
         j53y5k8Juv8qW0g3ph3RroeTLWi4B2hU7X+mPgOA/ieFCtTGGtcfNNqboPhUob3k5jbQ
         Vzg/T96AViy/f1QAc7dJwinT1QNdZ4rMszKGnV55pfsdoqSohKSXL7tUdo/yS4ZZxlM8
         Pa1x60pl/8aYZgeLY60jJlejjLJZC1ZySIA+uE0Z81v0wfinBYuqS0O4ZRN7JPyygQ0T
         62TlYlwszbq02JzDqW5fPgxdhEFTu7w/RjPI7Gw35bhIiPxcF1TGYn3lxG0h0q8j6uG3
         OnXw==
X-Gm-Message-State: AHQUAubAxphw9SPh8ySSeSGIahvIGE6N+fmZKPGc/IkAXToz4qCKkbaR
        OErFjGjV2eLf79SIEtwA+Nf5LQ==
X-Google-Smtp-Source: AHgI3IYVQEgGd8GVx9h2KcqYyLeFJbvp2oQ5fHkPZJ8hTsJjwnPaCpYreGyEhGFYJKr1a9wmYlkuBg==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr4499520pgi.291.1549991781471;
        Tue, 12 Feb 2019 09:16:21 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:20 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] perf tools: Remove unused structure field "state"
Date:   Tue, 12 Feb 2019 10:16:06 -0700
Message-Id: <20190212171618.25355-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Field "state" in structure cs_etm_queue is no longer used and needs
to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0b11d653cfbe..ebd68eb43da9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -65,7 +65,6 @@ struct cs_etm_queue {
 	struct thread *thread;
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
-	const struct cs_etm_state *state;
 	union perf_event *event_buf;
 	unsigned int queue_nr;
 	pid_t pid, tid;
-- 
2.17.1

