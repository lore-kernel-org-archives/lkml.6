Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4064C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF7921566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opDQ/MtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF7921566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbeHBUGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:06:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40103 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbeHBUG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:06:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id e13-v6so1765523pff.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=hWp+eBPLdquHAGWBZZ+MXbGV8XHhHtBSGvdbdXPrxEA=;
        b=opDQ/MtC0/K2EhwJZyUgLjFDYKBFbC/ymFo6ooosm6mNVRBkEBZ3j9oDbnT3y5sB4d
         cFBNfaQMwxsr/5l6bMLTkhVJncNL31KJIIo9ibFytZt9uajyOrR4XkOuUvFdrNKrtSSS
         nLXH3+rhi4Ul50FC9sgnyaD0i2e0l5PhzTXaJGRF4EhF/wAah2boJzoVEg3ig+UslO8l
         tN8NkDhDM/o+qnVIySkA/MDEr36xAmGw/yAfvrQy0W8H9BENvLuH+zKlvkghy/Xxg/Kp
         5EZ4ZOh/w2NgkzLF97Z+ZrrWJXWqbUKrW0bNAU1y29XFVqGzgUetipAj7Q12iz05sMFE
         +SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWp+eBPLdquHAGWBZZ+MXbGV8XHhHtBSGvdbdXPrxEA=;
        b=cAOdWorXiyg7RzjTfGzMtoYi0wVyubjwhaxH4WS0IxcB0EqW3HNuUvbAhIk3/NL9L4
         uupbBVfElwQ3sGGOQHOGjqNDGJdV1J0Lw9R1daSzSWn8YVM6aXEBDdBULamsqJa9S6RS
         X7dO68jk1sawE9mpwuquWoKwUqdEVpw+NFT/TIqaqjiLixDIz8Ftk9KVxmmAb3YBarlr
         QiRxv1uabv4sT3AXpRVM+eega8zz/Ox5mbKiD+VhxldGHrm6UC7rhhgV3CC2ORyjMMbc
         kNj9Zxcm4fFRLjH59Ib/c02y36fsGebSMdo7rv/yd2VYbIN6rg5FVFqPaSW8t97s22uT
         HNHA==
X-Gm-Message-State: AOUpUlH1CEuIAPCsk4AktZfQIRICCWdtPjkbT67eBu9wOVs1rz2yuAYt
        QQ4CEPuElN68rL/vVUuNlh0=
X-Google-Smtp-Source: AAOMgpdIwUrsxitBxBxAMw8tcm4+cJQUweN+6rZf7Nt3Z+y+Mpf5e2o5b8scwmWbUHrj84nA4Xr7ww==
X-Received: by 2002:a63:2906:: with SMTP id p6-v6mr544406pgp.204.1533233655664;
        Thu, 02 Aug 2018 11:14:15 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.147.207])
        by smtp.gmail.com with ESMTPSA id m15-v6sm6884435pfj.171.2018.08.02.11.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 11:14:15 -0700 (PDT)
From:   mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix synic per-cpu context initialization
Date:   Thu,  2 Aug 2018 10:36:52 -0700
Message-Id: <1533231412-10776-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

If hv_synic_alloc() errors out, the state of the per-cpu context
for some CPUs is unknown since the zero'ing is done as each
CPU is iterated over.  In such case, hv_synic_cleanup() may try to
free memory based on uninitialized values.  Fix this by zero'ing
the per-cpu context for all CPUs before doing any memory
allocations that might fail.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/hv/hv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 1fb9a6b..7703df2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -187,6 +187,17 @@ static void hv_init_clockevent_device(struct clock_event_device *dev, int cpu)
 int hv_synic_alloc(void)
 {
 	int cpu;
+	struct hv_per_cpu_context *hv_cpu;
+
+	/*
+	 * First, zero all per-cpu memory areas so hv_synic_free() can
+	 * detect what memory has been allocated and cleanup properly
+	 * after any failures.
+	 */
+	for_each_present_cpu(cpu) {
+		hv_cpu = per_cpu_ptr(hv_context.cpu_context, cpu);
+		memset(hv_cpu, 0, sizeof(*hv_cpu));
+	}
 
 	hv_context.hv_numa_map = kcalloc(nr_node_ids, sizeof(struct cpumask),
 					 GFP_KERNEL);
@@ -196,10 +207,8 @@ int hv_synic_alloc(void)
 	}
 
 	for_each_present_cpu(cpu) {
-		struct hv_per_cpu_context *hv_cpu
-			= per_cpu_ptr(hv_context.cpu_context, cpu);
+		hv_cpu = per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		memset(hv_cpu, 0, sizeof(*hv_cpu));
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-- 
1.8.3.1

