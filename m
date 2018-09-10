Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B19620645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8kBMiyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B19620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeIJTnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:43:11 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45284 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbeIJTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:43:11 -0400
Received: by mail-qt0-f193.google.com with SMTP id g44-v6so24387402qtb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sHrpU9/Qk3D0ZVudXq4fSrkqH/oWI0SWLGVfSUJkZBA=;
        b=R8kBMiyRlxg/g0JS92jSkHm2Mns+am6C7RCTHWQKwPC2u38RF2NzZTfhLEvyDXDFOu
         CLlTli+kEer8KqWv5EAPyMFRpepWQJWJJwHCWg0DO9jrG/d3t861Pr10dF5UZrI7NSJk
         5oSHzcHCbW1YSb7G/xlTWal3rKIylefbMHM2DWbhFBmyKE6EjzhkIjkP9P6pJ/E89vuq
         nFQIlYDpgJt9rw3ytBhWZTCZQ2Lbz2uxy2BBBkVjROqyNdT0wB+ULfbiJrbYiap38hE+
         AUmHeVuWhcqs8NaUnW2B79vL70+m/1TLZVLUVDY0HgHaFcEvHXBn/peJXFt0jxPe0MMt
         eb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sHrpU9/Qk3D0ZVudXq4fSrkqH/oWI0SWLGVfSUJkZBA=;
        b=qKX5h77MUWDLYdUQAJtON4mJSa7w4McJfvAqqwyiQ+WHVczy9iGm32AcHzmcADtQ1E
         sWcX3uMJtjm/0keoKLC1TC7tdd7Mdnu8Xl0BDqSh/diPKwDjvMaDgOzptpdHwwgCykQC
         LdnfPXgHjzigTyKAJDkxkmdXvK0jNnDxJIdwkRK5FY625fRPyudZ/lu341FMLb3JpkD9
         SzpHPNGoFpfvtfNczmpTyP1OKBUZPpf313kJ7BbfeymuLHvT1WaHElCw6baWuNEx0Mo3
         D5LHZQhrUnQmMfX2ZIyQPixSVFZ0v+LL7D8ziLunSS+zvGbJBEtX804jMJNwjoTwwzvR
         UiZw==
X-Gm-Message-State: APzg51CF6I9BPCwSp0EqMkXWZmxXcwm52WhhNZd47iANW7ipRUQLop3U
        qtKEfw57ZTQ+NwKy/eXUsg==
X-Google-Smtp-Source: ANB0VdZm4y7CHa8LsUCGd8+GWiQdZWBXO+37iqcaeyEdooO9o5Tcf7sIuFKTAnhTUX5q9k5D+kZG1A==
X-Received: by 2002:ac8:6989:: with SMTP id o9-v6mr7267266qtq.244.1536590924374;
        Mon, 10 Sep 2018 07:48:44 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d138-v6sm9086610qke.18.2018.09.10.07.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 07:48:44 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND] [PATCH] perf/x86/intel/uncore: Use boot_cpu_data.phys_proc_id instead of hardcorded phy id 0
Date:   Mon, 10 Sep 2018 10:47:50 -0400
Message-Id: <20180910144750.6782-1-msys.mizuma@gmail.com>
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

