Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D73C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 04:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00EC24B26
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 04:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ltXJatiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00EC24B26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbeFWElL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 00:41:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43201 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeFWElJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 00:41:09 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so4085431pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CW3gtRZPbTm2ilrBisLi7BBMmZuYVObAHL2BztC1qpo=;
        b=ltXJatiYkVpJdvymlwmFmTPK69caCHB3TOU2obwFTltYATeRF3fEKO7FIrige8LRX4
         5OhiOIDUowHBoGbISrs3DJF7DDhC24RbcQw/IsI0xa/gsNCXI4WDCWsL5YBJZ32cO201
         n/oHTO8/PHcABos6SWXBzl1CzCLtE/updVIWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CW3gtRZPbTm2ilrBisLi7BBMmZuYVObAHL2BztC1qpo=;
        b=Aey1FwZmyenxMpIQ9s5TtbA10sr8vJ+6y4ak4K6SMQ1RxwNNpcZc5TkEFksQ+0O97X
         A+6rg/sTH40oR2m8pkMM0/GVZFX92+Fs+aHl3XSIbpfncfhsqpGCBbok5cAIXjglTGcl
         HBJlu3vBywyXDFrWBhxcikAQL1ufg4IG/6B13Q0TpEPDRjLnOfyvFLGWU3yuarTB9QP5
         hLh1lRY4ZtLel6rW9ggjmB4nw4jwy/g3wolk0mVVFE1hzLP2LslQG6Od0a0CFU8R6KEQ
         PCL8vY/nwmEimz4EAXp1YAyFaXoWeSJCqlXdUYvZySBrL62m4Fp14bJryqaZ6pOR5pYe
         FjNQ==
X-Gm-Message-State: APt69E2EgR734jMWmsxo7Q+ZcBNdYuRPYxlIbRIik2pq/HQqkg6dMKAI
        4dcaXRTdng6e1fLto4k7htR205wFgG8=
X-Google-Smtp-Source: ADUXVKIBW7NiMXp2kpR0mLurErTRLfxmdaJQ/l06LGymlPbhsnpKs+o/eybTRJKzGOOdjSqBJb5ofQ==
X-Received: by 2002:a65:410d:: with SMTP id w13-v6mr3609456pgp.414.1529728868523;
        Fri, 22 Jun 2018 21:41:08 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id 29-v6sm22695637pfp.24.2018.06.22.21.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 21:41:07 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] Documentation: RCU: Fix broken link to LKML archive
Date:   Fri, 22 Jun 2018 21:40:55 -0700
Message-Id: <20180623044055.118383-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

While going through the RCU requirements for interrupts, I noticed that
one of the LKML links is broken. This patch changes it to use the
archive from lore.kernel.org which works fine.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/Design/Requirements/Requirements.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 9b808402f8ce..58b6557007a3 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2269,10 +2269,10 @@ Thankfully, RCU update-side primitives, including
 The name notwithstanding, some Linux-kernel architectures
 can have nested NMIs, which RCU must handle correctly.
 Andy Lutomirski
-<a href="https://lkml.kernel.org/g/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=va7anBWDA@mail.gmail.com">surprised me</a>
+<a href="https://lkml.kernel.org/r/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=va7anBWDA@mail.gmail.com">surprised me</a>
 with this requirement;
 he also kindly surprised me with
-<a href="https://lkml.kernel.org/g/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjMPsq5dOtzso=g@mail.gmail.com">an algorithm</a>
+<a href="https://lkml.kernel.org/r/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjMPsq5dOtzso=g@mail.gmail.com">an algorithm</a>
 that meets this requirement.
 
 <p>
-- 
2.18.0.rc2.346.g013aa6912e-goog

