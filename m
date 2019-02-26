Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B65AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E56217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162055;
	bh=+hmIA6J3xzhhj0EBuQ5cxZY43or4OX3LirZ2VLfbplg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=GFF+TASLTOON1D0ck0HcF9PHnLIIG2h9btcQ/a/EZhtDKdBM4qw8CJcAVWRdxmpPN
	 Vlp0z4BdeGFCwYEbIpaujx37FeqZK9qLO70OL/9DByHWz0o4rjkZ9XtehImV9O0tBJ
	 4KlDmlASnfn0PxzDJnsqkufwYaw29OIsxRwYowhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfBZGUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:43 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38175 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBZGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:37 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so2441052itg.3;
        Mon, 25 Feb 2019 22:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=cOQ9Mqdvt9WYryBTzeuet0z6FEgVKdqlQkfL8BULl5A=;
        b=WZwfdiiMrL93Jstdw4WXOPnxuoyrRlMgaZxRpMglEyeRQ4GV5BZDzFGWP7gYFTqwcS
         X0MWlgKx9RucDvbhECv2HzqREyU4qA4Jf49p15Cs5kkndB9JqLdAWdR4rBgu2axFQWdt
         j4Cbj29Q6lw7s8b4lkd74TjRxs6l3Y78SDvbdYbcKqs/90EC6S5HnN9Azx1Nvmc1Y4f8
         VK02LUcem6hVg3DFOylO5gbQc9x4WgDKPiqlA537gPYR3VY4xKryLREVvOFEH9aNaG2w
         lIB2k0yywghuCVXXQ/6uplteYGarAAJXYaCBjhdlTjb6MSZBJ8Pkab9RHAD3D18hA29Z
         6xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=cOQ9Mqdvt9WYryBTzeuet0z6FEgVKdqlQkfL8BULl5A=;
        b=umk4h2zqENmN1vgaw2UCk+T4Uvki6nCn8JSTVlkfL3R8OZMAWv+oE3jjOrbJmyZu2W
         CVLKWOnIWwTTXrXkJ50sTFVUDUF5j3PiebIGAA25jJoFKhKwZZtFlkNJTd64EKqAhnz2
         T0mLeJFQhEaOwcJVeXGr+LTerCCPRAipQ31WckRhZanVNi1RALrPJvbNqk74f5Ma0hgd
         j6BbOgE8ggVmZBi0GZTsep2cxsj+KYiT8o+888liaB/ZaECxyBx1cnOqNSXvs37hl90Z
         CmLF8RApR1qVeXZuAYboSKYYm9D+hJ8pH+SSB56NyUBRJ4YSBK9Wzc/OxV3sc5MtqpdQ
         t/GQ==
X-Gm-Message-State: AHQUAuZJ6UgJf4OQJZKYdLYn3yX3W0roC/7wbDUh2FJb6vMueZDiX8fG
        VlDWC2mXYyaMNhXWjJhVJPs=
X-Google-Smtp-Source: AHgI3IZuA55xfyqfkT3w9xHSTYUADogSzdPU98ulVcYeRwsV+acjLGynLjiFhe6SjINFtTNLUh2PbA==
X-Received: by 2002:a02:8884:: with SMTP id n4mr11142324jaj.110.1551162036627;
        Mon, 25 Feb 2019 22:20:36 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:35 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 11/14] hwmon/coretemp: Support multi-die/package
Date:   Tue, 26 Feb 2019 01:20:09 -0500
Message-Id: <b91ef931b054bacf5b4a34799560062615ff4e25.1551160674.git.len.brown@intel.com>
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

This patch introduces coretemp driver support
for new dual-die/package systems.

On the new dual-die/package systems, the package temperature MSRs becomes
die-scope. Thus instead of one hwmon device per physical package, now
there should be one hwmon device for each die on these systems.

On the hardwares that do not have multi-die support,
topology_logical_die_id() equals topology_physical_package_id(), thus the
only difference is that physical package id is used as the coretemp
platform device id, instead of logical package id on these systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/coretemp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5d34f7271e67..57f348d43819 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -435,7 +435,7 @@ static int chk_ucode_version(unsigned int cpu)
 
 static struct platform_device *coretemp_get_pdev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return pkg_devices[pkgid];
@@ -579,7 +579,7 @@ static struct platform_driver coretemp_driver = {
 
 static struct platform_device *coretemp_device_add(unsigned int cpu)
 {
-	int err, pkgid = topology_logical_package_id(cpu);
+	int err, pkgid = topology_logical_die_id(cpu);
 	struct platform_device *pdev;
 
 	if (pkgid < 0)
@@ -703,7 +703,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * the rest.
 	 */
 	if (cpumask_empty(&pd->cpumask)) {
-		pkg_devices[topology_logical_package_id(cpu)] = NULL;
+		pkg_devices[topology_logical_die_id(cpu)] = NULL;
 		platform_device_unregister(pdev);
 		return 0;
 	}
@@ -732,6 +732,7 @@ static enum cpuhp_state coretemp_hp_online;
 static int __init coretemp_init(void)
 {
 	int err;
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	/*
 	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
@@ -741,7 +742,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * c->x86_max_dies;
 	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!pkg_devices)
-- 
2.18.0-rc0

