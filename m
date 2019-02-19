Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45B8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634F21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547635;
	bh=waaRFgSBIHeKfLGwb7G43M5wCIVTqz0cC4k5AstYCwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=ihAoLWc9kCA9UtElQ6Q0RzklBL35w/UkuQpGCV45AXF+r+nSXzwnBHrAX9/gQMEXF
	 UNgF1hRuIe4kom57r51yA+XI1J48I0Vzq5lDbnzBgZcfgAFU/EIpXwEYljUc9D8XCa
	 lcN1rokT1HfaEv/1aeE6BqD/fawd7y9zr8jxLlFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfBSDke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:40:34 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42074 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfBSDkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id y140so11245139qkb.9;
        Mon, 18 Feb 2019 19:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=0bkBhlZLwP0+CkBpq0MCToedKfvIRPENpISccQCmWHc=;
        b=es4XB11RZcKTOAIfruUnBqZi7VwGu0c+JWkmvnPZ6yOfdWEQZL9iQtUTm5QAwxOqo7
         yrfhxbJ0hfEBo4CXbCXWU/Lbwmvjpkd2D1AWOy1zfw0VGWUwbCJnYftC7+P7t1QtwVJZ
         Aks81w3SpTJxr31LFLui1fP6IwhrGChInkLZAtBQGES2wl8Do4QZHabC8dXLDFuKY1Eh
         PnPP0U/hiSp8/3kNMCiY4zGGBuzwp62j7hYZTMls0hyKiTCs8S17bPcN1tYppLraidsf
         ACvDF1wgTaLFbR/1en6fWSIQY57RiK6KFNO4oEc0hHak0Cfhttb4OwnQNWyWglhZ65Xs
         KUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=0bkBhlZLwP0+CkBpq0MCToedKfvIRPENpISccQCmWHc=;
        b=QpNTLPoMVbaUP6vAnjR0IIF6KGnnYq+FO4aGan6LV8K6rFkwasA4v+iVp8IYInMkUR
         dMYSZgJt1arkG2VaQI6fcMKZPrXIaoJnqeyetJHjfh/yotIMJhRlLaD56Z52bzwc0ENA
         InzAv4OvC6vmu7nhJjazgJ0FoBdebkjF79v6bmHzTszAsokz4LYNcsoq6QMrxiRTpiaz
         zDGU5uMqONnEkbLH+Q766qHU0v4Dg4QLkOnRyh6UvDIKE3AQWhfMnLR47M8UpP924STv
         FhFHmm6meDK9KRfxdqMuza50rC9NJDOC3tp4UGaEO/Eu/poNuLTh3EZFmXJYyoYgFXp4
         /CrQ==
X-Gm-Message-State: AHQUAuY7RdLm9JwWrR0lQILvqrCS05E+Wv0vmXwYwQ2yZDSzu2uqi49T
        JbpbKbo7SCL/LBwm336e2Q4=
X-Google-Smtp-Source: AHgI3IYuVh0AIcWJx5RLFwAEYuVyKLPQq1y7HqHm8FJX2plRXigjh4Vgi5jHPeCJVJAsF/D4d91Jqg==
X-Received: by 2002:a37:b381:: with SMTP id c123mr19018860qkf.346.1550547632534;
        Mon, 18 Feb 2019 19:40:32 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:31 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
Date:   Mon, 18 Feb 2019 22:40:10 -0500
Message-Id: <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

On the new dual-die/package systems, the RAPL MSR becomes die-scope.
Thus instead of one powercap device per physical package, now there
should be one powercap device for each unique die on these systems.

This patch introduces intel_rapl driver support for new
dual-die/package systems.

On the hardwares that do not have multi-die, topology_unique_die_id()
equals topology_physical_package_id(), thus there is no functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/powercap/intel_rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 6057d9695fed..e004707283da 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *rapl_find_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_unique_die_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
 /* called from CPU hotplug notifier, hotplug lock held */
 static struct rapl_package *rapl_add_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_unique_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
-- 
2.18.0-rc0

