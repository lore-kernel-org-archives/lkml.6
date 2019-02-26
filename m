Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D10FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9352173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162074;
	bh=/LvNSlIz8up6JSQaJpK+BUSx9jTdLZu6yKTkBvNeEU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=R9jm9gokWi80v4DG51eRyza2/FoUlGIIBxWXql0vewL/vDid12TGBJweO+HUYB3Hs
	 dsnmto9oFviN5tfj9kMDm3rlYBRAfOa6Wv3n7fPupBDExDmzMYyEFXH3EnCVFZSjUD
	 wEZ5Hi83C9It7pzrU1p98KazPril5U2PeaC1Z6gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBZGVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:21:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39199 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfBZGUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:35 -0500
Received: by mail-io1-f67.google.com with SMTP id x3so9620399ior.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=b/Kzn17Vf6dzrUo0Ue4UVG8xwRuP07tjAkgwmkdmxSM=;
        b=BSNXx0Y8D8Z3Sj11YTOyh+wDc31GXugYYqzl7wnDwpOIXeJT/VI3LPLsKPW873GuEv
         +spHg1ZUm32n9/qd3E3dCpupcPkKEJMeRM9WiIswb5/VNKVYp4/QOFVnW7ztsBIMrGZk
         dhM1GhyEDSCBbGZCH/sctLJtzY1VMlnRCs/D+dN08dMSjcae7wpDasSEJkJbQhKxRvGH
         FR+KbKugu9AKKuE0PD8pveulQDWn7f2MVQjIT5IIRWinqWsXkPAzleIIHaMyulNnJOqK
         KQuMO1MlRkDt1h00PWnk9HcW5unAzolJT4GRt5w7A+g8hs0IzEvt0ahEABjOgiFB52PE
         pR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=b/Kzn17Vf6dzrUo0Ue4UVG8xwRuP07tjAkgwmkdmxSM=;
        b=KYVOz76xEK/ZaBVNJyPhiUiCle+VYKdgGyTai7W15S2IFu2zrLVaHRPieu7RqRLb83
         WyZj8fMGx3Q1EqCHjw2d8WsyEc4Y0Mihm6M/EAvvi9FE86IyJHYM7kpHsQ772bRButuU
         7mDdSA4FLs05TWA+hB97FQMjerzMdC/maVnpc2vJkXUHs9JuGLY+cbYNHVWzGKMQEUKJ
         Hb65cDD/PccMgjv6lBy5/TLrsnvmvv4LLUU/bqr5WgGzjCKgR0CKQqPZSuX5gBiI1vEs
         Y2SheJfNAP74DtFzn36UOaen0iUCoJBlj4/hl8GCaxgXhbe3WI9q7yJ7MdiW/U9rykFJ
         vQtA==
X-Gm-Message-State: AHQUAuZH97A45a1d1ovYh3rR+dtZyaprKSvLpVklE6mCm2JCUse41IBJ
        GLjhOUQ814WbM3EEmlPzFGZ5Y3ki
X-Google-Smtp-Source: AHgI3Ibog5EEGd6D8M7S/GNjCBw9WUj+/k71RhHiIC/q/GwQlkUBc7P1E/QbLuzNVLvtTZ3rq170xA==
X-Received: by 2002:a6b:6e11:: with SMTP id d17mr11333553ioh.297.1551162033956;
        Mon, 25 Feb 2019 22:20:33 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:33 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 09/14] thermal/x86_pkg_temp_thermal: Support multi-die/package
Date:   Tue, 26 Feb 2019 01:20:07 -0500
Message-Id: <863054888eb8f1a595369c49ec24740501e9c175.1551160674.git.len.brown@intel.com>
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

On the new dual-die/package systems, the package temperature MSR becomes
die-scope. Thus instead of one thermal zone device per physical package,
now there should be one thermal_zone for each die on these systems.

This patch introduces x86_pkg_temp_thermal support for new
dual-die/package systems.

On the hardwares that do not have multi-die, topology_logical_die_id()
equals topology_physical_package_id(), thus there is no functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1ef937d799e4..1b03ab3ee20c 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -122,7 +122,7 @@ static int pkg_temp_debugfs_init(void)
  */
 static struct pkg_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return packages[pkgid];
@@ -353,7 +353,7 @@ static int pkg_thermal_notify(u64 msr_val)
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 	u32 tj_max, eax, ebx, ecx, edx;
 	struct pkg_device *pkgdev;
 	int thres_count, err;
@@ -449,7 +449,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	 * worker will see the package anymore.
 	 */
 	if (lastcpu) {
-		packages[topology_logical_package_id(cpu)] = NULL;
+		packages[topology_logical_die_id(cpu)] = NULL;
 		/* After this point nothing touches the MSR anymore. */
 		wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
 		      pkgdev->msr_pkg_therm_low, pkgdev->msr_pkg_therm_high);
@@ -511,11 +511,12 @@ MODULE_DEVICE_TABLE(x86cpu, pkg_temp_thermal_ids);
 static int __init pkg_temp_thermal_init(void)
 {
 	int ret;
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * c->x86_max_dies;
 	packages = kcalloc(max_packages, sizeof(struct pkg_device *),
 			   GFP_KERNEL);
 	if (!packages)
-- 
2.18.0-rc0

