Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CA5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DE221773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547660;
	bh=ctuB6HQ7t4dDjmMLoZUKtjdDAEpaQjwTSGmWpOD9GyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=VTct+OC2Ejj7I404N9P+656TDhZhbO5DWJpaR0TCCl9K7c6fmCvYtl/x34wGR4DaT
	 4KzVSFWzWvg4nEDSd6u4RkXTA3FY3sLBgJ13a59ug3a0KvxyGeoo3INFjk/ZUxWf9A
	 APdGMWJ74xPslo2iNl0KdsflriPG3/5N/xid+t6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfBSDk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:40:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32927 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBSDkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:32 -0500
Received: by mail-qk1-f195.google.com with SMTP id x9so11280715qkf.0;
        Mon, 18 Feb 2019 19:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=MAczlCx3mIAKVe8ps2sOQcXtmOH1S9j5/HyQaCUgiyQ=;
        b=aNVDM5Eduf+HK54rx9q3r74mqa+lvMGBpZrrOlCgGe/1UNFxukOh9a6tYLwi5kRoFb
         mwN/5S2LMWcFyNX/p2HchOTfzgXkI+w68leEIWzuIy/cTPwFU0J8Tq+uf9jvBnGu6Hrc
         3SNjZ2OjT4tm7zAbfWtaGEhJFO7WbyHE6hHCFZLTF5s36OImQIXzDO5DPj3nRADImnUC
         /Wd15Rg7/pgU0Fj5ss993fadnYcpflVQkYJ03nMqDudRwxB4hL50tGEljQXsvC+hxjrH
         6NhklfebI+3gdrON4II7ivR7qXz09iPCLr1ufuelbsgV+qrePsE1yUcUsDEgepQVf2B0
         8X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=MAczlCx3mIAKVe8ps2sOQcXtmOH1S9j5/HyQaCUgiyQ=;
        b=mVrEhfQeQA2lDPhlzywcW7CNvsJqU0+ZGhThsWtWplEhlUSLH5no3XPss6AULXPVAM
         GM+IXcT/X+znMIqniCOEIUUPa9Iy+/9v0N8anPn3UYp95Et1AVtJ5A1BIr17DL+xzn3W
         qt/yZFWH6OgWvC8O/1KlmFCANuSvHUiPDLc6anuaoYNoijb1bes/wTY8Ua25dI3IGwGj
         0u0wZPBtiTirbrcXP5joE82d8gPBctEkA6E9p5MslX+FiQ2mnvssxhl7wLDL9DYm0/z/
         44c3IGsRg6+RY7jeqY8fCWCn1GQaJPRLqVYi1ckC/l+UJgE5fmgpbZc+b5Q6IpxLHF8W
         Qtdg==
X-Gm-Message-State: AHQUAubqpyNkJFankjzkdiwq0XU4EEqFFldrR0wktVeRZZkVDsVmlbGL
        rNWmseUkx6P5OMMriIziSlw=
X-Google-Smtp-Source: AHgI3IZwyh+3fv8WFmpVb/GQ31KPY9GpDStCojNU97RH9opDcQGIn166uv7d0tCiD/hHBlUxdylFJA==
X-Received: by 2002:a37:4d52:: with SMTP id a79mr3390686qkb.75.1550547631341;
        Mon, 18 Feb 2019 19:40:31 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:30 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 07/11] powercap/intel_rapl: simplify rapl_find_package()
Date:   Mon, 18 Feb 2019 22:40:09 -0500
Message-Id: <c21fb21e1cd476b2806d5f88c96e8cc54d3fd08a.1550545163.git.len.brown@intel.com>
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

Simplify how the code to discover a package is called.
Rename find_package_by_id() to rapl_find_package()

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/powercap/intel_rapl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 6cdb2c14eee4..6057d9695fed 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -264,8 +264,9 @@ static struct powercap_control_type *control_type; /* PowerCap Controller */
 static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 
 /* caller to ensure CPU hotplug lock is held */
-static struct rapl_package *find_package_by_id(int id)
+static struct rapl_package *rapl_find_package(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1298,7 +1299,7 @@ static int __init rapl_register_psys(void)
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
 	rd->rpl[1].name = pl2_name;
-	rd->rp = find_package_by_id(0);
+	rd->rp = rapl_find_package(0);
 
 	power_zone = powercap_register_zone(&rd->power_zone, control_type,
 					    "psys", NULL,
@@ -1454,8 +1455,9 @@ static void rapl_remove_package(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-static struct rapl_package *rapl_add_package(int cpu, int pkgid)
+static struct rapl_package *rapl_add_package(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
@@ -1464,7 +1466,7 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
 		return ERR_PTR(-ENOMEM);
 
 	/* add the new package to the list */
-	rp->id = pkgid;
+	rp->id = id;
 	rp->lead_cpu = cpu;
 
 	/* check if the package contains valid domains */
@@ -1495,12 +1497,11 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
  */
 static int rapl_cpu_online(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package(cpu);
 	if (!rp) {
-		rp = rapl_add_package(cpu, pkgid);
+		rp = rapl_add_package(cpu);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -1510,11 +1511,10 @@ static int rapl_cpu_online(unsigned int cpu)
 
 static int rapl_cpu_down_prep(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package(cpu);
 	if (!rp)
 		return 0;
 
-- 
2.18.0-rc0

