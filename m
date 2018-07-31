Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A2AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFDB20890
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8n2h4o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFDB20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeGaEuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:50:04 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36557 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeGaEuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:50:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so6474070plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=xuUxIuBR1M46+u1lel5XrEXu3LJXeQSAT8HdS6H6wzw=;
        b=H8n2h4o+Koh/PHwJC0xMyMc+Le3CLETwpQ/r8JBDfGBcJfZGty0TO0w3clVa/RQ4nG
         0TmVBkg6JXosFcjnfJCruos5oe5f2WqPGgWqrdbA8wnzPKAPwqUzL636zZWFqwbiMatP
         gvXbzaf52yznwTgK7Ngp8QGZRzoNUa3GKifGSAXC1WA0/5qy5toS27AhHVz0d57y64Q4
         srOW06WqLmxO44wdtrJnlk6TKIV/8jr7SVLQXDV7kxiT1a2deXGCVFLU17CYVpj1RiK2
         JoTJ1223V0NJ9SefNKWYo61phjmSZm80XNqVDIXIhutDODyKXLfbWvDSc+zMimT4n9hC
         ZhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuUxIuBR1M46+u1lel5XrEXu3LJXeQSAT8HdS6H6wzw=;
        b=DYMDlBuMo/pG1B1PjzXAbEuHJyVdBZOajFRd/XsQ5XAGiJavp6vqs5K9hRLJo2kZr4
         ACDrgmPB/g0q+1AH8xJoYpO9Zk9E6kY5HMwZlnnKhakIAaWY7W9s0CtiGiWglXU1m9IV
         uaFI3UoqDz7LuLsbTn8hfkmJzx8WiFHVMcaLv5wp1d9b50KlXZ73R8YKoOjz6oCsCT2O
         urmvZKu5HstLAJKUHlkZa1YkQA76Kb+PJ0JLH4QwWlk3i+Cjmg+DFcEY9TuCy5nbVSNh
         aDlfLqqzD2fAYGAsMG8S5IHX/s2s3WlbT7dRRwIpGyKeABlmH70aTVMJOdY3E7V02Vtc
         lLLQ==
X-Gm-Message-State: AOUpUlE/lDFq8YF3odXAHBU6OCnCpJIK5W2P+xsB55Esc8J26IIXSSwS
        5YiE2V6YJEs6UCwsDFbFSkw=
X-Google-Smtp-Source: AAOMgpcrm9L9iSNbUxXJFkYuKDmRf03HJ8Lq4vB6tHvkqfy2PSfTHPgK58TOF8xNr9RPx1l5fs79jQ==
X-Received: by 2002:a17:902:8a87:: with SMTP id p7-v6mr18567411plo.281.1533006720799;
        Mon, 30 Jul 2018 20:12:00 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.207])
        by smtp.gmail.com with ESMTPSA id t88-v6sm33300246pfg.10.2018.07.30.20.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 20:12:00 -0700 (PDT)
From:   mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH char-misc 1/1] Drivers: hv: vmbus: Make synic_initialized flag per-cpu
Date:   Mon, 30 Jul 2018 19:34:44 -0700
Message-Id: <1533004484-3937-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

The synic_initialized flag is part of the global hv_context
structure.  But the Hyper-V synthetic interrupt controller is
fundamentally a per-cpu device, and other synic related
fields are in hv_per_cpu_context.  In a multi-CPU system,
synic_initialized gets set multiple times, making the test in
hv_synic_cleanup() invalid.  Fix this by moving the flag to
hv_per_cpu_context and adjusting the references.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/hv.c           | 16 +++++++---------
 drivers/hv/hyperv_vmbus.h |  4 ++--
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 312fe5e..8d4fe0e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -33,9 +33,7 @@
 #include "hyperv_vmbus.h"
 
 /* The one and only */
-struct hv_context hv_context = {
-	.synic_initialized	= false,
-};
+struct hv_context hv_context;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -315,7 +313,7 @@ int hv_synic_init(unsigned int cpu)
 
 	hv_set_synic_state(sctrl.as_uint64);
 
-	hv_context.synic_initialized = true;
+	hv_cpu->synic_initialized = true;
 
 	/*
 	 * Register the per-cpu clockevent source.
@@ -354,6 +352,8 @@ void hv_synic_clockevents_cleanup(void)
  */
 int hv_synic_cleanup(unsigned int cpu)
 {
+	struct hv_per_cpu_context *hv_cpu
+		= per_cpu_ptr(hv_context.cpu_context, cpu);
 	union hv_synic_sint shared_sint;
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
@@ -362,7 +362,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	bool channel_found = false;
 	unsigned long flags;
 
-	if (!hv_context.synic_initialized)
+	if (!hv_cpu->synic_initialized)
 		return -EFAULT;
 
 	/*
@@ -395,12 +395,8 @@ int hv_synic_cleanup(unsigned int cpu)
 
 	/* Turn off clockevent device */
 	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
-		struct hv_per_cpu_context *hv_cpu
-			= this_cpu_ptr(hv_context.cpu_context);
-
 		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
 		hv_ce_shutdown(hv_cpu->clk_evt);
-		put_cpu_ptr(hv_cpu);
 	}
 
 	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
@@ -428,5 +424,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	sctrl.enable = 0;
 	hv_set_synic_state(sctrl.as_uint64);
 
+	hv_cpu->synic_initialized = false;
+
 	return 0;
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 72eaba3..eadd3df 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -202,6 +202,8 @@ enum {
 struct hv_per_cpu_context {
 	void *synic_message_page;
 	void *synic_event_page;
+	bool synic_initialized;
+
 	/*
 	 * buffer to post messages to the host.
 	 */
@@ -230,8 +232,6 @@ struct hv_context {
 
 	void *tsc_page;
 
-	bool synic_initialized;
-
 	struct hv_per_cpu_context __percpu *cpu_context;
 
 	/*
-- 
1.8.3.1

