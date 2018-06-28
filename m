Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA7CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C90B2779C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="L0n8QYnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C90B2779C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030429AbeF1SX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:23:27 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39398 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030428AbeF1SV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:21:59 -0400
Received: by mail-pg0-f68.google.com with SMTP id n2-v6so2822114pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QKg90FTuSuW27iG9WkPEeAv4vw/9V5gf4/0TnS9jz5U=;
        b=L0n8QYnzMafn0UED6KfTLrCCidJg3O8fCiWdR0inqKPjetwFa8ngFimyR8hyMArhec
         Y54zJtlsi4uiIuFueDAln2/zyu9q29zisvPyx9umPHTggVreqMkfmYcc37I9Yna6gt+M
         0KW24dn+jIgWTAKfvme8O6h8ViVyNyny4JVws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QKg90FTuSuW27iG9WkPEeAv4vw/9V5gf4/0TnS9jz5U=;
        b=DRbQhVlaUF1axbyJUdQi7zvXvbDWJPC2tvakq9+bGrpKs44MuDpGZ8+QeOBnkCh4Bg
         kxQDho+4PyyL3xgiRj/ZaCLtTrJUhspL1899LJ46gfT1WaID4KqkqPN1YOPvdGhq5PFd
         DVmrSTecXmChUriVLv2Drt1poeggWEk6IlrjsQxs36tFRN6CWWIZMKBTkFI9thF+uSkY
         dlBZL0HVIx8S/T54RnBTKJOVZMYDfOL1NtGwayrTUCIb2BqL9wjFinHIaUB674/YICPl
         BSJeGNMehSugT4Cy3DZ15I1C3S1rDOBl8YnneuEMT7YQRJo05HlqQEbmvzUjBqftOpIg
         S74w==
X-Gm-Message-State: APt69E2DpQ/6aVJxdjNEhXCFDmtMPx2FhYZehnnl6aINcJrMBGhxH5Bt
        4j7T2Hj+/VsRrqOd2RnoyYlv0JFhgec=
X-Google-Smtp-Source: ADUXVKL+h2nPp6bZUHmT3HxDGWt+QQCi0M7p8fg5oCcg+GklkpCzOzSkohwU/p7NFh4grDLxHGMJbA==
X-Received: by 2002:a63:aa03:: with SMTP id e3-v6mr9792456pgf.169.1530210118745;
        Thu, 28 Jun 2018 11:21:58 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id q10-v6sm13686027pfj.7.2018.06.28.11.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:21:58 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 2/7] srcu: Add notrace variant of srcu_dereference
Date:   Thu, 28 Jun 2018 11:21:44 -0700
Message-Id: <20180628182149.226164-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180628182149.226164-1-joel@joelfernandes.org>
References: <20180628182149.226164-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In the last patch in this series, we are making lockdep register hooks
onto the irq_{disable,enable} tracepoints. These tracepoints use the
_rcuidle tracepoint variant. In this series we switch the _rcuidle
tracepoint callers to use SRCU instead of sched-RCU. Inorder to
dereference the pointer to the probe functions, we could call
srcu_dereference, however this API will call back into lockdep to check
if the lock is held *before* the lockdep probe hooks have a chance to
run and annotate the IRQ enabled/disabled state.

For this reason we need a notrace variant of srcu_dereference since
otherwise we get lockdep splats. This patch adds the needed
srcu_dereference_notrace variant.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/srcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 3e72a291c401..67135d4a8a30 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -169,6 +169,11 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
  */
 #define srcu_dereference(p, sp) srcu_dereference_check((p), (sp), 0)
 
+/**
+ * srcu_dereference_notrace - no tracing and no lockdep calls from here
+ */
+#define srcu_dereference_notrace(p, sp) srcu_dereference_check((p), (sp), 1)
+
 /**
  * srcu_read_lock - register a new reader for an SRCU-protected structure.
  * @sp: srcu_struct in which to register the new reader.
-- 
2.18.0.rc2.346.g013aa6912e-goog

