Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5134720C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5134720C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeHTM1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:27:43 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:43619 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:27:43 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 08:27:38 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95b7a83ec8b6-6e35c; Mon, 20 Aug 2018 17:03:40 +0800 (CST)
X-RM-TRANSID: 2ee95b7a83ec8b6-6e35c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from bclinux72.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75b7a83ebc47-2dd7c;
        Mon, 20 Aug 2018 17:03:40 +0800 (CST)
X-RM-TRANSID: 2ee75b7a83ebc47-2dd7c
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: acpi: Remove some redundant code
Date:   Mon, 20 Aug 2018 06:15:11 -0400
Message-Id: <1534760111-31614-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For single statement blocks,braces are not necessary.
And "else" is not useful after return. So,remove these code.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b61f4ec..0751a0a 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -423,9 +423,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	unsigned int next_perf_state = 0; /* Index into perf table */
 	int result = 0;
 
-	if (unlikely(!data)) {
+	if (unlikely(!data))
 		return -ENODEV;
-	}
 
 	perf = to_perf_data(data);
 	next_perf_state = policy->freq_table[index].driver_data;
@@ -521,11 +520,10 @@ static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 		}
 		perf->state = perf->state_count-1;
 		return freqn;
-	} else {
-		/* assume CPU is at P0... */
-		perf->state = 0;
-		return perf->states[0].core_frequency * 1000;
 	}
+	/* assume CPU is at P0... */
+	perf->state = 0;
+	return perf->states[0].core_frequency * 1000;
 }
 
 static void free_acpi_perf_data(void)
-- 
1.8.3.1



