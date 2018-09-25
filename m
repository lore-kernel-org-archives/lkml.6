Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF799206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bX7DIYfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF799206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeIZAfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:35:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37055 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeIZAfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:35:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id x26-v6so1751316pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxI1FgJwMERM3UAhQcklkAKLrTq7+Ffd56oaBhs9q2Y=;
        b=bX7DIYfq1TChJhi9OeUZVUPD/bUJU9KtYrS++kKV1v4hwpxJPazdz1oaWTt4ZY6FaH
         3Cgzv03qQBO6VYO7Hqdg43006DEnetOYFmDSI0F/o0i5rZd2ECV183Q8wtN6ya4Bcjex
         m/vG80PsKKOeRN04CgD0U8d/swBA8w04gYQug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxI1FgJwMERM3UAhQcklkAKLrTq7+Ffd56oaBhs9q2Y=;
        b=tUVsW8hDmVBeloUEi69fvTeLFej8cy8d5rWkjevy083iQ3gY3yembID13y9cIxR/D/
         obODFXZbmtQUYyIAd0mPO3O8xjspkTKJPKIPkIzW6kLXzMK/tNFXPAn9bAUhXYyUKGzJ
         f+9fRiKBVENMMG+Yza7ES/quYSUXWwzCrNxqmsBtYSU2rWuJZa5729SLWstppVsxbHc7
         dciI+4+EmjJYKR90rMOwOBmv1UiKQrauptwYLXiBYIrHJKuxrAoHtHmgvguoWLZjPWj/
         siTzaibYsJIQVvHF3/duV3Naajde5c/BpLzFPf0DhEugkvBhEXJ++Uxlg1eX6l77BRtA
         svQg==
X-Gm-Message-State: ABuFfojqD/cgBI/3kMaOe36ZVucXF6EqbvijL+qIL1MwqkxuIyEOvB1c
        Ryqb8Uh//qe19xGVivUcKURWvD/pyCc=
X-Google-Smtp-Source: ACcGV6004pCiQ5OGNOj/0U5kQopZ+EBGCnc/IrPqo13yWR3XCD8orlWqCksF3ExmHai8rMRiQuhG+Q==
X-Received: by 2002:a65:53c9:: with SMTP id z9-v6mr2123970pgr.203.1537899986543;
        Tue, 25 Sep 2018 11:26:26 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com (c-98-210-118-128.hsd1.ca.comcast.net. [98.210.118.128])
        by smtp.gmail.com with ESMTPSA id x70-v6sm6883626pfk.85.2018.09.25.11.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:26:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [1/5] doc: rcu: Update information about resched_cpu
Date:   Tue, 25 Sep 2018 11:25:57 -0700
Message-Id: <20180925182601.37421-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180925182601.37421-1-joel@joelfernandes.org>
References: <20180925182601.37421-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fced9c8cfe6b ("rcu: Avoid resched_cpu() when rescheduling
the current CPU"), resched_cpu is not directly called from
sync_sched_exp_handler. Update the documentation about the same.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../Expedited-Grace-Periods/Expedited-Grace-Periods.html    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
index e62c7c34a369..8e4f873b979f 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
@@ -160,9 +160,9 @@ was in flight.
 If the CPU is idle, then <tt>sync_sched_exp_handler()</tt> reports
 the quiescent state.
 
-<p>
-Otherwise, the handler invokes <tt>resched_cpu()</tt>, which forces
-a future context switch.
+<p> Otherwise, the handler forces a future context switch by setting the
+NEED_RESCHED flag of the current task's thread flag and the CPU preempt
+counter.
 At the time of the context switch, the CPU reports the quiescent state.
 Should the CPU go offline first, it will report the quiescent state
 at that time.
-- 
2.19.0.444.g18242da7ef-goog

