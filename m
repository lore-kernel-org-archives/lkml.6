Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E47C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE72E2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfBSX2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:28:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59927 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbfBSX2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:28:04 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id ea03d70d688a5585; Wed, 20 Feb 2019 00:28:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/4] cpufreq: Fix two debug messages in cpufreq_set_policy()
Date:   Wed, 20 Feb 2019 00:25:18 +0100
Message-ID: <2486777.RhoGZOM3Wg@aspire.rjw.lan>
In-Reply-To: <11668536.bBDtnvkYQE@aspire.rjw.lan>
References: <11668536.bBDtnvkYQE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Remove the redundant "cpufreq:" prefix from two debug messages in
cpufreq_set_policy().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2290,7 +2290,7 @@ static int cpufreq_set_policy(struct cpu
 	}
 
 	if (new_policy->governor == policy->governor) {
-		pr_debug("cpufreq: governor limits update\n");
+		pr_debug("governor limits update\n");
 		cpufreq_governor_limits(policy);
 		return 0;
 	}
@@ -2311,7 +2311,7 @@ static int cpufreq_set_policy(struct cpu
 	if (!ret) {
 		ret = cpufreq_start_governor(policy);
 		if (!ret) {
-			pr_debug("cpufreq: governor change\n");
+			pr_debug("governor change\n");
 			sched_cpufreq_governor_change(policy, old_gov);
 			return 0;
 		}

