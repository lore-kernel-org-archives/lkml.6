Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699702173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk83/0uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfBZKEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:04:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37121 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfBZKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id q3so6010088pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T8PEITo4hgwI3Ud97GyB2V2HzIGkWk0ISKir1FA4dRQ=;
        b=Wk83/0uQA6FBfPbD3T/4z0/uYeT3QElUcd1OUxOaYExTCyky2P5JDL+s0+k/hkurYq
         x41SByXrZDbLLGnma855PcEWCiI0I/BImAAEmzd3hjldPGiFf8++CM/TSiLAqcuzQU0a
         tN9szxPoQX+zkJz75X8Zd6wLQCeteqSN10BPlxlpqVqugjvyEUhiC7i4RbUSg+9qovt6
         NXUbC/9/IwrV/Tw8aw9tdIR5DYhJMowwL/YJLnNNegyjI1VQkoVHAl1VAe1hyZDmAtg7
         tIKJScjtzA+jmOZObfPRgWFBbo4norv+j2vuXuo9XsfsQzQVYQAf4NFtxLyxCuRzBbys
         Qz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T8PEITo4hgwI3Ud97GyB2V2HzIGkWk0ISKir1FA4dRQ=;
        b=GkbZe7KXClza/yd/0ncBDHhwjIpxEorqRLXZQ8TpZkP15eqyxLqeHWCxb8o9x4NfNk
         +Bo2bQondFggrVwSKiT0/CW79z6xIUf07tQbJ+Zx3jdoD436+GaMCfDZFOXW9xn0DgyB
         1RaMTU8DXh99cIMotwkgdaietqC4dE2tF8lDeWpeDKHw66Nxie+NPVYbKbKNggP4hrzg
         ziBvRKXEvQbFwrN78MAuFyGgDp0imdBknsuu30XP5qEjTWiFa+j0Thcje2r4TD9WkYN5
         KCQ5lWRUwktPNDQSTQk8X1IJwwF32Y+TIHryjCGGDvZrcNSCH8A9x51jPHDIQVgwU3ZA
         BIYQ==
X-Gm-Message-State: AHQUAuYqA6tENolvsi0em5U3hEoTezSbFh9UzezQkxPyEmrRsLsdOuPx
        39aFai3op9oDzFaE3TPGCOA=
X-Google-Smtp-Source: AHgI3Ibzf6HqMohsFhrzddNjO5G6qzb9ONAN3zbWRj7NPnipKfceKYE4HtRak2PKnMkKjdNjzWCoFA==
X-Received: by 2002:a17:902:ca4:: with SMTP id 33mr4585505plt.99.1551175426106;
        Tue, 26 Feb 2019 02:03:46 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:45 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 4/8] locking/lockdep: Remove useless conditional macro
Date:   Tue, 26 Feb 2019 18:03:23 +0800
Message-Id: <20190226100327.19340-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190226100327.19340-1-duyuyang@gmail.com>
References: <20190226100327.19340-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since #defined(CONFIG_PROVE_LOCKING) is used in the scope of #ifdef
CONFIG_PROVE_LOCKING, it can be removed.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8b8495e..0610c0b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1331,7 +1331,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	return result;
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 /*
  * Forwards and backwards subgraph searching, for the purposes of
  * proving that two subgraphs can be connected by a new dependency
@@ -1709,7 +1709,7 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
-#endif
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void print_deadlock_scenario(struct held_lock *nxt,
 				    struct held_lock *prv)
@@ -2363,7 +2363,7 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
-#endif
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * We are building curr_chain_key incrementally, so double-check
-- 
1.8.3.1

