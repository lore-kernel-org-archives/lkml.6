Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36367C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F71920861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfAULRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:17:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfAULRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:17:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A48915AB;
        Mon, 21 Jan 2019 03:17:33 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561A03F5C1;
        Mon, 21 Jan 2019 03:17:31 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com
Cc:     mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] PM / EM: Fix broken kerneldoc
Date:   Mon, 21 Jan 2019 11:17:22 +0000
Message-Id: <20190121111724.18234-2-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121111724.18234-1-quentin.perret@arm.com>
References: <20190121111724.18234-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the kerneldoc comments about the Energy Model framework are
slightly broken, hence causing errors when compiling the html doc.

Fix them.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h | 4 ++--
 kernel/power/energy_model.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index aa027f7bcb3e..57889589e638 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_ENERGY_MODEL
 /**
- * em_cap_state - Capacity state of a performance domain
+ * struct em_cap_state - Capacity state of a performance domain
  * @frequency:	The CPU frequency in KHz, for consistency with CPUFreq
  * @power:	The power consumed by 1 CPU at this level, in milli-watts
  * @cost:	The cost coefficient associated with this level, used during
@@ -24,7 +24,7 @@ struct em_cap_state {
 };
 
 /**
- * em_perf_domain - Performance domain
+ * struct em_perf_domain - Performance domain
  * @table:		List of capacity states, in ascending order
  * @nr_cap_states:	Number of capacity states
  * @cpus:		Cpumask covering the CPUs of the domain
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9dc2c38764a..1e3a88ea4728 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -137,7 +137,7 @@ EXPORT_SYMBOL_GPL(em_cpu_get);
  * If multiple clients register the same performance domain, all but the first
  * registration will be ignored.
  *
- * Return 0 on success
+ * Return: 0 on success
  */
 int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
 						struct em_data_callback *cb)
-- 
2.20.1

