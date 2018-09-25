Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1971FECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3F62089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eDTqNBBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3F62089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeIZAfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:35:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34174 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbeIZAfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:35:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so12178580pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IygWM3hka5n5utS1J0WFLLtcDdg6o71RjTbDWC5Bxyo=;
        b=eDTqNBBUTZGjbhy5B3O6qv7jotrYfa2Z88CnlGoiGY/iOoT3yrI5wudyRXKU/CrX33
         HUD5YCQdAB6VdRlPonb0WtJ4nrO9hIxyz0TBIKEGCicD414FpcjLdhvTPbsfrj5C3tjk
         yANr73du2qIZaOBcjZJIqyFAXTLX2b5pH/xiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IygWM3hka5n5utS1J0WFLLtcDdg6o71RjTbDWC5Bxyo=;
        b=V95TvQnGkaI3vPtU1Q+ZYhdYy9sD7stXEQ5IWNlHOffyDLFIOyGvTMeZalYdYM4VUt
         wgdr5TAAnpzOkwO+vKw068Hfr+4zS8b9wsyOKERy1OZhQGvyMY5ccX1W5U8NoZ5rnWGv
         NwbVihb1no+8c+Hpe1cIc6dPS0k5GScZKaogoPUcg3Q+ec1GOakzA32sQUwa1dmUS33c
         LNyquJ1emAwwIrADS9618n3u0e6ZOIUnFHCQk4kIg18UDuB5g+XE0nvvfxmaDuY3eJOC
         8W2MNHoKBUe4P79HDYLzM6pBbi9eO9EkYvhsSdK60qd4pfxtqpjwPcpqRmrqa6SdKmaa
         +fSA==
X-Gm-Message-State: ABuFfohn8zm+JlAHCFbBbiDWtMkhr4Z8ct2Uu86B8XsBYhTzaIZK6T2W
        IFfOSwvHIvLDlBNUHqpImzYz+LeZaD4=
X-Google-Smtp-Source: ACcGV61tG3KUOsw4ULrk1MCWslizXUGlCXGh2/uIZlrlKMnlks4X+Vnu5U0h5Oss2kV292l4pTiV6A==
X-Received: by 2002:a63:1342:: with SMTP id 2-v6mr2159564pgt.19.1537899993150;
        Tue, 25 Sep 2018 11:26:33 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com (c-98-210-118-128.hsd1.ca.comcast.net. [98.210.118.128])
        by smtp.gmail.com with ESMTPSA id x70-v6sm6883626pfk.85.2018.09.25.11.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:26:32 -0700 (PDT)
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
Subject: [4/5] doc: rcu: Clarify better the rcu_segcblist len field
Date:   Tue, 25 Sep 2018 11:26:00 -0700
Message-Id: <20180925182601.37421-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180925182601.37421-1-joel@joelfernandes.org>
References: <20180925182601.37421-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An important note under the rcu_segcblist description could use a
more detailed description. Especially explanation of the scenario
where the ->head field may be temporarily NULL making it not wise to
rely on it to determine if callbacks are associated with the
rcu_segcblist. Thanks Paul for clarifying over email.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../RCU/Design/Data-Structures/Data-Structures.html    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 3f9a8ae4287e..a45fc326d990 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -928,10 +928,16 @@ this <tt>rcu_segcblist</tt> structure, <i>not</i> the <tt>-&gt;head</tt>
 pointer.
 The reason for this is that all the ready-to-invoke callbacks
 (that is, those in the <tt>RCU_DONE_TAIL</tt> segment) are extracted
-all at once at callback-invocation time.
+all at once at callback-invocation time (<tt>rcu_do_batch</tt>), due
+to which <tt>-&gt;head</tt> may be set to NULL if there are no more
+callbacks on the <tt>rcu_segcblist</tt>.
 If callback invocation must be postponed, for example, because a
 high-priority process just woke up on this CPU, then the remaining
-callbacks are placed back on the <tt>RCU_DONE_TAIL</tt> segment.
+callbacks are placed back on the <tt>RCU_DONE_TAIL</tt> segment and
+<tt>-&gt;head</tt> would point to the start of the segment. So as you
+can see, the head field is briefly NULL even though not all callbacks
+could be invoked, so we can't rely on it to tell us if there are no
+callbacks associated with the <tt>rcu_segcb_list</tt>.
 Either way, the <tt>-&gt;len</tt> and <tt>-&gt;len_lazy</tt> counts
 are adjusted after the corresponding callbacks have been invoked, and so
 again it is the <tt>-&gt;len</tt> count that accurately reflects whether
-- 
2.19.0.444.g18242da7ef-goog

