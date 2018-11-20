Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99184C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1412087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv3OyuNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1412087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbeKTX0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:26:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38578 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeKTX0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:26:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so970644pfi.5;
        Tue, 20 Nov 2018 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ehElaOGNaa+9uehoMuZC2eArC7M9wbegSB7h/+nKnWI=;
        b=Qv3OyuNISewIMaQsvKFFvhoFhObzRyAV6Sg/hro1DiEddVXaaos5VhlJ4qE4nV3IoZ
         AzkWyEx9LTJYFcD0/CLiZPze0zzEwPrvchr54J0zScsgUXR6Rs1Yad8pQBuRJ9Hafb/i
         sAclzJxvIQN04YlktaKAOFXWRueACQLbof7zEprxpT/coTU7V/3w/vvSweRg3n+9Vmh6
         bgEUcoOYAkKNsRhOPftLQ1S8YSbfswV/1yqfllGkA1GGdc1WkvJ+6aJ9MJNrYelaa1kV
         V1Ui0zq3olUb2DAU8nThrIni7P87VW9fwsZuT0w5ft0sDWZquZogU8StL9jInccTH2Ao
         IReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ehElaOGNaa+9uehoMuZC2eArC7M9wbegSB7h/+nKnWI=;
        b=NFejPGz9mr8gwAMu8Yv9lWTAQ2whnkb8s4dcPOf3iavn7nwRriTVNEeROp2vVMnnni
         iXfRfOP3HOh7uuu0dMaPCY0BoeyLI4tlI3ew1DlqztiONr0VC5Pu9aPDblLtC4mC3/ON
         bQ0A9p/vmABy0/lKsWYpUAgLus0sKUeWnEOE/7TMf6MywgZgr6U3k3ZqymDHk/2atP6x
         /oFRQzWgwtPaP3pCUHD+RwKq1I3ZIS4c30IKP1tWjgNn8OcmNw+iIgaVxoEUTSMTaaR6
         vm7hIrJmqvao63Edy2sEFBM9CD9ajwnNTpEP/mk3nR0PiJm7ROakvOuikHjX1uLJm+24
         QG7A==
X-Gm-Message-State: AA+aEWa5FgWsaPUJ663SSKEi5Zk39h8GQFnrqT3KTZvnjn3sH8OeHTPp
        WnH+GUfPJzGE4NcmkZwidNg=
X-Google-Smtp-Source: AFSGD/WNJ6Z0Ru49H+Qch6MbX+3qreMsatnQ3/MIToC6DDyHW7UKJ27WnPq4yC3OmYbBgPATGBCjFA==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr1790628pgq.189.1542718656979;
        Tue, 20 Nov 2018 04:57:36 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e123sm43854673pgc.58.2018.11.20.04.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 04:57:36 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: powernv: add of_node_put()
Date:   Tue, 20 Nov 2018 07:57:31 -0500
Message-Id: <20181120125731.19368-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
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

