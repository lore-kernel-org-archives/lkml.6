Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A2C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B09E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLNNeswc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B09E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeKUCfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:35:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34478 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUCfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:35:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so1217232pfg.1;
        Tue, 20 Nov 2018 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v7hJLl0nspNEvb5LwkAvDpIYRT2ClkaKvvqCVQdKmBE=;
        b=jLNNeswcf3FOJ5G9jP4ic5x1MQ49CRXg7PKspUXRRdKJUYjSMXRKktrVm0xfUPSWWt
         Nn1dx1poJP7Y6x16+OscSuhwpLAMDbPWYH9pZoEdNSeOozcL79KAja4XbNfYpPRrH/Gu
         KLoPN1Le6IXlfBIjXpuctvAqNUMnOFLzyczaAqSBb/ixxt3J+awRiA3fGbgyq1Nz+J/S
         9Jb+UfiZ1SD4f3IXrWax/47fq8Qok6nZrVmbanf232Te9TVu5FHZHOrzbxXe6d/Gh1Qj
         ZTnLh89jOpCL/nyBcQVStfXo2yt9yWInLVEfKSYQ4JcLQEi+R2NqsIWBIuqkIREXjMC0
         TlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v7hJLl0nspNEvb5LwkAvDpIYRT2ClkaKvvqCVQdKmBE=;
        b=mlWjt9k4BW1gSTp4e18Aq8B/OsxvyumU+RCZgFKeiqznT+DxqkcWepa1bcbnxNTOXn
         xpc0TsrtnrC9eRmb8JySClD3ysBO2Hc0vdKrJOyz64I/Sh+j3yWCE1KWn05uvFtHGzN5
         Qf80iOEhAeBgeRE+vPjxKTsdSEelOmNWt7u/mpprTrvwg0hyAyBN0M92ubgx6/dq8wyI
         aJ5pibtI2k1fLjFgVksYGd43E/c9aKz3rjrN6++GS3z4zQhn7MQwHKBRNnateDBN+y3j
         g6CD8ZhJGV4Yxd3LDgQQS6CP/Kz9Ng/3M6au1rNFVC95uT5GAojaZBsBvcTD6+D2oC05
         Oaiw==
X-Gm-Message-State: AA+aEWYoVfCu9RmvYadvAqGbf7OPdRTCk1YygrMsXUoDiGULQRaHTtBY
        uk+SWCir3Zd0LYbQWntHAKc=
X-Google-Smtp-Source: AJdET5f9hOLNARt5YmCnrd1st/tsZu05GUlkalcnzc0Pg4UW1WxNW0kADQMEVgT4jAPWiAVs3R2GGg==
X-Received: by 2002:a63:2d82:: with SMTP id t124mr2422551pgt.260.1542729932942;
        Tue, 20 Nov 2018 08:05:32 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i63-v6sm10019749pfi.66.2018.11.20.08.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 08:05:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpufreq: powernv: add of_node_put()
Date:   Tue, 20 Nov 2018 11:05:30 -0500
Message-Id: <20181120160530.21015-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_node_by_path() returns a node pointer with refcount
incremented,but there is the lack of use of the of_node_put() when
done.Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2
-update changelog
---
 drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index bf6519cf64bc..7e7ad3879c4e 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -253,18 +253,18 @@ static int init_powernv_pstates(void)
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
 		pr_warn("ibm,pstate-min node not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
 		pr_warn("ibm,pstate-max node not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-nominal",
 				 &pstate_nominal)) {
 		pr_warn("ibm,pstate-nominal not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
@@ -293,14 +293,14 @@ static int init_powernv_pstates(void)
 	pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
 	if (!pstate_ids) {
 		pr_warn("ibm,pstate-ids not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	pstate_freqs = of_get_property(power_mgt, "ibm,pstate-frequencies-mhz",
 				      &len_freqs);
 	if (!pstate_freqs) {
 		pr_warn("ibm,pstate-frequencies-mhz not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (len_ids != len_freqs) {
@@ -311,7 +311,7 @@ static int init_powernv_pstates(void)
 	nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
 	if (!nr_pstates) {
 		pr_warn("No PStates found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	powernv_pstate_info.nr_pstates = nr_pstates;
@@ -352,7 +352,12 @@ static int init_powernv_pstates(void)
 
 	/* End of list marker entry */
 	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
+
+	of_node_put(power_mgt);
 	return 0;
+out:
+	of_node_put(power_mgt);
+	return -ENODEV;
 }
 
 /* Returns the CPU frequency corresponding to the pstate_id. */
-- 
2.17.0

