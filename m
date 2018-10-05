Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943CFC65BD0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FE8206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hiN7Esss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FE8206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeJFGTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:19:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34528 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeJFGT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:19:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so5751389pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 16:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuiGGF4tGE77ZoRCuOu2WaKGuaS8nUiVz1gvo4RFW90=;
        b=hiN7Esssa+biM79y02dxKh1TZZvxnQJy5tklCPgKWM+YfpFRQIcdicfNXBg/yQE9oU
         e/LmRkuN7kRe0SYBIor5hFFTi3BVP2LlEIfqtYzJx7Dd3iVCBJ+GAG3O9Tn7WKSOozs8
         GW2YI+MvUbNatlojnrf2PjQg+C7HG6B5okCF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuiGGF4tGE77ZoRCuOu2WaKGuaS8nUiVz1gvo4RFW90=;
        b=Z8mdheyVKsZSJ23ccboqwTZo7jTAEBJjFt27ySc8kNZ6LeAly4PSOThWmMw4kfsfwq
         95aPNrxT68XdcHj6FZAPkQFgXHFzSCQLixLxY4n0E/IOjxaIIuE4Hj31zxN97Hy1uV0v
         HhGRaToRw4xLdz/cjfckWAPp7FHHIuUxWsmLzOqqT5FEuNKp6hp7N0xoW0Zg8brXonj5
         +caTz6QYQIx9VvWHnrQR00fqFwbkaGpxexx7t1dkw8EYBuhuJ7fSUT/oCw42MbseEc9e
         4RyD8DRoWMaSWp+1YDKy6Fl8FHtz7eyiBVQWJCofe1ItVOecHFGuCtecd0/cfi2DCjdg
         fLew==
X-Gm-Message-State: ABuFfojQLQFEm/2zjXCYQ4+YMO8e5uEti73eC6NpRb+at9G9R1Oxn4gI
        alvmQKlQ1h88JGGP92PiCktKt3ria9M=
X-Google-Smtp-Source: ACcGV60Icikt2yjKJfW7Zqn6YndlLIcqwfGZCNjvCoanu+j3nzpfv7j4sAdC7AAtbhjIsq8stybaOQ==
X-Received: by 2002:a63:4745:: with SMTP id w5-v6mr12254899pgk.377.1538781513088;
        Fri, 05 Oct 2018 16:18:33 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q76-v6sm16641028pfa.18.2018.10.05.16.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 16:18:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: [PATCH RFC 3/5] doc: rcu: Remove obsolete suggestion from checklist
Date:   Fri,  5 Oct 2018 16:18:12 -0700
Message-Id: <20181005231815.170433-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181005231815.170433-1-joel@joelfernandes.org>
References: <20181005231815.170433-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_rcu_bh is now implemented in terms of call_rcu, so the suggestion
to use a different API for speed benefits is not accurate anymore.
Update the document accordingly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/checklist.txt | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
index 8860ab2a897a..cc22ce49618d 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.txt
@@ -285,11 +285,7 @@ over a rather long period of time, but improvements are always welcome!
 		here is that superuser already has lots of ways to crash
 		the machine.
 
-	d.	Use call_rcu_bh() rather than call_rcu(), in order to take
-		advantage of call_rcu_bh()'s faster grace periods.  (This
-		is only a partial solution, though.)
-
-	e.	Periodically invoke synchronize_rcu(), permitting a limited
+	d.	Periodically invoke synchronize_rcu(), permitting a limited
 		number of updates per grace period.
 
 	The same cautions apply to call_rcu_bh(), call_rcu_sched(),
-- 
2.19.0.605.g01d371f741-goog

