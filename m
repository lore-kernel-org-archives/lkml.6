Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57997C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D8C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162092;
	bh=AXZIgE/zQ/FtWuFsCsYsP0bcZcJpKFLKpCihEezeqyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=mUOrgklVD2iJnC10gmevKivXEQOxG1lBGmd7NzWOjozNTQgo7GyXS6d6HKUinZDGx
	 MELuMOvFvkHFGmMsHUBK+ARh++JSlqftnN0SIMaUfAD9jIOomqXNlSBN3Wm0ZudiN2
	 nytwliA56eMXpOObuH6OEqNmVjsZOkN7/C+Qbyik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBZGVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:21:30 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51695 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfBZGUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:33 -0500
Received: by mail-it1-f195.google.com with SMTP id e24so2331133itl.1;
        Mon, 25 Feb 2019 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=ndV/o88VaJr2WeRWq3FjxA/p0ZeqMKH2+0t/LRYI9p0=;
        b=I8+lFqx/mxRE3VYbseZSgBTTfyP7C9x8xgkbMxEjMEYL0WdzyMMkjG7dpJj/hQ+m3q
         mllFc74D33X7ymqzfXmt7OO4KKBVRNJTvLVbeyH1VqVVdnPcI2BwLngrgd5ClcAn9UP0
         g+dynDlIpTwQNp33mBP8h+iyOBpmzp8hT7Z4eZheHj69Pt5RUSk1VSRlHBax6MQ3UzeV
         M0bYksVwzgXobJC6T+H1ENS/7ZfDxGerhgM1qqFlsvwa2X5Bs+C9HQnQLZ577M2Hb28+
         FNr0wOtcsB558XDAyLMQ/FJQcs5Y0FvdOxcq2hyr0mdSLM916hxaF75TnHRcgbVV1UMt
         TMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=ndV/o88VaJr2WeRWq3FjxA/p0ZeqMKH2+0t/LRYI9p0=;
        b=H7LKlGDzQUgxdLHepUD4Jg/wh7CUsDD1MW+drDzd7h7GIjg1ubVKWzpdzMXthjo0Uy
         dSpg6j2TiZ4zre9AIWF8GZKfMdDZhjr6P0eG41RBQUpByY2FskDkctiECO+YXiaX7JsW
         AeZPi2p6sXfCjhgT3knUVY0MLR2TiZ1ibwjeTa5jUqBNsPcsK9JUj+O+N6YqK65MsFAz
         MdUXQrnqa508dniToSVbB5jb7vy45J4jnBwy4sxsRH7x9u5Cek9tR5u2/iV8Uu+B/WDs
         Fk9Dktx2Monsnc7U583meFk0GZcBagNlWKO+wYQBB3UojMwroD/4efzAXrbo7fpsrnu2
         iICQ==
X-Gm-Message-State: AHQUAub9GQEm8rIX53stL16XDkmkD9pmQ6Gt0ejuRIhL7umucWBYZAmn
        hKdEEG/6X4+Bo4xtC797LJ4=
X-Google-Smtp-Source: APXvYqys1bnp+G544nQoiLNgFbK6tiC+cT9TNEAn/YFLJc0qkwAYpO1TCwcAWG0X+V69zJCfEtBAdA==
X-Received: by 2002:a24:7b8d:: with SMTP id q135mr1635811itc.30.1551162032530;
        Mon, 25 Feb 2019 22:20:32 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:31 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 08/14] powercap/intel_rapl: Support multi-die/package
Date:   Tue, 26 Feb 2019 01:20:06 -0500
Message-Id: <680e11fe0dcc65e4cfa5bfeaa0d1cdbe7896e3c0.1551160674.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
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

On the hardwares that do not have multi-die, topology_logical_die_id()
equals topology_physical_package_id(), thus there is no functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 6057d9695fed..8723e9ae7436 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *rapl_find_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
 /* called from CPU hotplug notifier, hotplug lock held */
 static struct rapl_package *rapl_add_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
-- 
2.18.0-rc0

