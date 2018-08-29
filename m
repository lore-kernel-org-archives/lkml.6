Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4865AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BB420658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0tCdq8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BB420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeH2T1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:27:17 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41010 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2T1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:27:17 -0400
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so6178625qtc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sHrpU9/Qk3D0ZVudXq4fSrkqH/oWI0SWLGVfSUJkZBA=;
        b=h0tCdq8QWbpgoou2RfXocHK68owKUe0sGLruPgf30Jkun4T12w61syV5lDxyp1DyCB
         hY6Xth5B74IAD4jZiHeXyxIqXRu2XSdRy1ru8W+O0V/8BIKjMiUmWxO2eBn6ldtERnKe
         +gcHpE3JSfB6W4PWCSqRi1UquDo0QAEbW27Dwr4nwEkhMHhXoIzOg6Ts3g3nyyfpC7uT
         WJFK2sqkotIoJUsApIs2lsKLWfTWiwtB4ruzIfCCvvSaMSYftBd+XYDrHp1g8nR8b9Fd
         qOwKjf76+n7vksmi7Z/5xd2a44EXs3GcY9VXQsmnAfkW18XGzRzMdvTVfQEKhCD6DdZt
         COLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sHrpU9/Qk3D0ZVudXq4fSrkqH/oWI0SWLGVfSUJkZBA=;
        b=ZvNkRWkrCZOIox8qHBcedGY8fhU+zirndLDMoyCTXUa9liDwwPtZDT9jJwmb0moXI8
         kIVkR9iP9QhN7Su8IPfXTy6QsJ4RgY4PoTKrbnieNr8QzaTwtGSvg8W2vS63c53MU530
         Rue7HG49ndRxp0ht+R5XHQuK20wYn+2IxP1JJwUpztlVeo3MAI8P/59lWsYRitj3pdd/
         AxvO7laEPoisFwIfZilg8LutUUfwSX1oQBQspc33Jeao5OT+0LgmGpKuFadgEZ/A8J3l
         mPXGNoFCDB4n8085ly51gfV0VcR07Edyxr+tzfpAXvBbUyOI/9S0nLr8AivlgtVgGPuh
         uIJg==
X-Gm-Message-State: APzg51DI8A0aGf2d2LlPSkUdoK16n/l0M3pvEIqtDOzFT+XN3y7xvWU8
        5agak9SSDsgIM57jgM5LSw==
X-Google-Smtp-Source: ANB0VdZwLDm6bLAP+dwX9iETfZpDvOWtLkFHe1Wh7jkbm8NHk3H+o8KE4og4N4yRdQ17VMB4d/nIjg==
X-Received: by 2002:ac8:36c3:: with SMTP id b3-v6mr7198802qtc.240.1535556589025;
        Wed, 29 Aug 2018 08:29:49 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o18-v6sm2166251qtm.84.2018.08.29.08.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 08:29:48 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Use boot_cpu_data.phys_proc_id instead of hardcorded phy id 0
Date:   Wed, 29 Aug 2018 11:29:23 -0400
Message-Id: <20180829152923.6020-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Physical package id 0 is not always exists. We should use
boot_cpu_data.phys_proc_id here.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 51d7c11..53b981d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3061,7 +3061,7 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 
 void bdx_uncore_cpu_init(void)
 {
-	int pkg = topology_phys_to_logical_pkg(0);
+	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);
 
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
-- 
2.18.0

