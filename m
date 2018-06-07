Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sKkQM8GXGVubdwAAmS7hNA
	; Thu, 07 Jun 2018 20:39:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D2B2C606FA; Thu,  7 Jun 2018 20:39:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Muzo4xVg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3D99060452;
	Thu,  7 Jun 2018 20:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D99060452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeFGUi6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:38:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45663 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFGUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:38:53 -0400
Received: by mail-pl0-f68.google.com with SMTP id c23-v6so6850391plz.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6iRhcuxv7LYs9+eTV7AewL3TxlzUcdpZCae2r7yiQpU=;
        b=Muzo4xVgkpEDMqlgP/+gaZ2Wx2mmaTc4hREd0JFwyP8hl+nvSlAwBNTKijooaZoEqr
         Ttp4c4AkbQcCAwFV/sCcvjnEY/NDJUHXKJZWWesGvZmk0x6gyuAhfytSCi1J5ntxUgBw
         imqfEDJu7i0wVM0M2uquWSFNUb3PrfpHaGau+wshZXN1HP4wWfngCsHyTBzpYaqIFxgs
         2Xw+hbcdeq3WdylLIL8yMjRlRUiqGa76kuyJRktYsLkBgfSTvQ4Bnk2cDoImkIN2ubdV
         Meb/1ZKQdIIGKC3YZCjaP9QwdWpey6tG2/D01OUu7RojlxawDQE+mPwyT1wZ6dC1Pqnt
         Cxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6iRhcuxv7LYs9+eTV7AewL3TxlzUcdpZCae2r7yiQpU=;
        b=N86WthxhOApk6jhznUUyRREn1Y50fbtXPEfCrO65KQpZtgN6YOaBwJeaX/GLiu9uye
         IPxlAS4m7o6HQ91zE1f4HTus03iptATbjv/WlE/6ehKlnkK/O+vl+vAc1i7Eqc6sOG4O
         zN+D7vtlAAmqXNcKVrDufX+Yhc7fFq7HkYdBBmNx6rpTRRKJRLVCEXYq1fTzr1dOUn6G
         xQQDd+h3EFsOOnyAR4I+TAIgvNFE+1OIh+KsreYW3i0ZZQxNVmKKnLtIWa9WFaxIQmEu
         guVZPBSOApbanPq6oO+zqVX5xB+R8s5p2No2m2pgW9v9GrgrvgwaEGPYs11sXZBEji/G
         Equw==
X-Gm-Message-State: APt69E06Jy8wXuH/naqY3V51zhce0fhxL3hQJ3DI9qk5+GsN/Gwz9TCZ
        D9AhLsZWo+NfwTqZ66CJXRJiEFmcfPw=
X-Google-Smtp-Source: ADUXVKIdru7e6eZf+yycv5YQ/k/CNUIUwSUq51+HNwLSeS8N7NhrWGcbBbQ8sG9cF97H/pKYe5TJJg==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr3507704plb.274.1528403931995;
        Thu, 07 Jun 2018 13:38:51 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id v27-v6sm10324174pfi.23.2018.06.07.13.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:38:51 -0700 (PDT)
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 2/7] srcu: Add notrace variant of srcu_dereference
Date: Thu,  7 Jun 2018 13:38:10 -0700
Message-Id: <20180607203815.255845-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607203815.255845-1-joel@joelfernandes.org>
References: <20180607203815.255845-1-joel@joelfernandes.org>
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
index 2ec618979b20..a1c4947be877 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -135,6 +135,11 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
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
2.17.1.1185.g55be947832-goog
