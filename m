Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id C4THJ02YGVshAwAAmS7hNA
	; Thu, 07 Jun 2018 20:40:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8432A6074D; Thu,  7 Jun 2018 20:40:45 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxdZUW+g"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C4F2B6063F;
	Thu,  7 Jun 2018 20:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4F2B6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeFGUkl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:40:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45661 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932402AbeFGUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:38:51 -0400
Received: by mail-pl0-f68.google.com with SMTP id c23-v6so6850365plz.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AWoBYQ8bMrAiiXbUJHYe7Jit5HOxGoUa1mPhDkxbGUg=;
        b=sxdZUW+gWhu5r9nI3nLuF6/h6853wnkAaZcrtt/l0mpkm4BO4WKaaleSr/UryJPYKM
         wQRaC/+/03rpyJsbs3wBZ6yLdEQlgvOVBjb1x/tt1nPD8Ia4qLBHNN+0T9OcC72o+gG5
         ZW5pPI0OBvKUmtWaAJHFERJ9WpgJrpf+IA0pZ8txpSv9c6L/9Ww4rMjmVT/Wkj6YFkJG
         TVmWPzxR/191XCG+tn1p0KKQuQOuaohI4eHP17+q46X2GHAtfjHa8kQriAKKwUeJiCMS
         RocXft4GrRVDBLQBPE1r8Be1G1HZDFYmZXwDNwkd4KH/51BWhUK+QL+S2fNGWWF7RADK
         kjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AWoBYQ8bMrAiiXbUJHYe7Jit5HOxGoUa1mPhDkxbGUg=;
        b=e8VVRuuLedST/huy27okHFmcnzUMA38Z2+5zWZj0yyae7VUzYBibBKxadD6CyjU4Wa
         9OAuGgk/awlFioTryJGy8zKB2NQPcCGVGe/NGbM0sSQHIfSpuzibDtPPH5LCkuQrFZLr
         sjNxkoxz+ZT3PV0ypPeDKZKIAr88X0TtyQvBMzDxYgw2BGBFLw8y+hnXA8+lPE7Ddm3Y
         zqFVWvW9dNC0NOcszEBCJx+833Z9qvMQQuSLZiupK6zzQbwL59PmEURfvAINZXidEt2y
         BlKA/qIaAuHLHUFq4VA0KzOFH1V0ZRphlJUWUQ82q+Fh2dbzQmfznvUxk5lAzq/o7f8E
         SGuA==
X-Gm-Message-State: APt69E31q/H2fCJ11MKHCXPHVJ1niTJAUboLxD7BtoMiZz2+eCCHqwE+
        uFN+ilKQVh36YvnlH15dMVXT2i6SREE=
X-Google-Smtp-Source: ADUXVKKGpfTlmGQBiR81/aLVTWxNO7kcsbYyTapLTETvnfOcGeWbPMvt643h/AHePAgtnm+rsKUX/w==
X-Received: by 2002:a17:902:6b8b:: with SMTP id p11-v6mr3463423plk.212.1528403930567;
        Thu, 07 Jun 2018 13:38:50 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id v27-v6sm10324174pfi.23.2018.06.07.13.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:38:49 -0700 (PDT)
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 1/7] srcu: Add notrace variants of srcu_read_{lock,unlock}
Date: Thu,  7 Jun 2018 13:38:09 -0700
Message-Id: <20180607203815.255845-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607203815.255845-1-joel@joelfernandes.org>
References: <20180607203815.255845-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul McKenney <paulmck@linux.vnet.ibm.com>

This is needed for a future tracepoint patch that uses srcu, and to make
sure it doesn't call into lockdep.

tracepoint code already calls notrace variants for rcu_read_lock_sched
so this patch does the same for srcu which will be used in a later
patch. Keeps it consistent with rcu-sched.

[Joel: Added commit message]
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Paul McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/srcu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 33c1c698df09..2ec618979b20 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -161,6 +161,16 @@ static inline int srcu_read_lock(struct srcu_struct *sp) __acquires(sp)
 	return retval;
 }
 
+/* Used by tracing, cannot be traced and cannot invoke lockdep. */
+static inline notrace int
+srcu_read_lock_notrace(struct srcu_struct *sp) __acquires(sp)
+{
+	int retval;
+
+	retval = __srcu_read_lock(sp);
+	return retval;
+}
+
 /**
  * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
  * @sp: srcu_struct in which to unregister the old reader.
@@ -175,6 +185,13 @@ static inline void srcu_read_unlock(struct srcu_struct *sp, int idx)
 	__srcu_read_unlock(sp, idx);
 }
 
+/* Used by tracing, cannot be traced and cannot call lockdep. */
+static inline notrace void
+srcu_read_unlock_notrace(struct srcu_struct *sp, int idx) __releases(sp)
+{
+	__srcu_read_unlock(sp, idx);
+}
+
 /**
  * smp_mb__after_srcu_read_unlock - ensure full ordering after srcu_read_unlock
  *
-- 
2.17.1.1185.g55be947832-goog
