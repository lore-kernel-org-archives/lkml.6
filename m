Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5977C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DBE2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547640;
	bh=fvZlRQX8Y3edxWwiYxiMdJJwfq4DJEkvYPuzmkaOY3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=2F5k2OsSNBhmf4nsUnQhHo/OyVTY/zVFjY+JwuoDVD+h2Fh1Q0X9QPdnMZV3NEVTI
	 FoylvPB0OO6eHIKHsAxfHoZXJHxCihBAye758HxW/jSlddAT4AwFiP/a/zHRBJXpUu
	 4LOXJJ6bTD71c3sSoEtJtP5u2+1rg0Ku77amxf2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfBSDkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:40:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43566 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfBSDkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so21607291qtc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=kJ9FUW3IcKMyRTcPH2qDXeCEf5isDA9+ZO46r25o66g=;
        b=ABO7z+hS7AVcQLFxvPRfBiuCEGf9SfNSJllHmvn7HkgdxweRJ7lrSj84yvEv0Rkzd5
         QXdz3KGF5+3IC4PbuKUvwnyO+xuyW9rsfKwA4NhBF52ic4iMtZ7upHFY1rmykx6XmyJP
         g99TqKZ3TVZvvIvPxTr7qpFwumjlEKghe9mFZKjXf9lR5MoOwSbFkoE7jo/zwQ0JhAOS
         o5p/Xf+a8oxkq/ONTjQNY/qQsCYplyE4G8rA19qNkOskGmSb0oSoE5pu+6H1cMIpMO4m
         FHIcXC4Au0IxadjNzDW/NTD3xSd7bo+RgvXXLIbZHp70/mtcYmAC9ikr2nbe6sAOHLmB
         KMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=kJ9FUW3IcKMyRTcPH2qDXeCEf5isDA9+ZO46r25o66g=;
        b=Xn3ygNNBI6IMgTr6mdUa4I9qT5knCDqmQD3diMvHgZBrVuBt6l0sMce8DDtPlUi0A4
         7mncGxtVQKrOEzTuVi6+2UT2xgu566VUCd/fGEs8MwmBxEpaeoLTtuNC1pYDNJg6fNAO
         t9ZA3p4J89XVo5RhfLRCMP8CuJhOhC7JRsCnISaIcoDs+fs66y6UWoURbsGt2QGnaMEm
         DrmM5TA+vy9yl0UOfhAocgwsva2okw8BeCu6IbaCFbwcFk5x62++lJuOy/oSJo5Fl6UM
         khBfAoGWKkext5mb+/AsEQr5KlFOq9EFYmHFPtXjVHWiqqd7JeX6t4oHPCWlem8N8u3D
         Midw==
X-Gm-Message-State: AHQUAuarC+28hKSedZo7W/UBGaKV/3JGbLAYIt3OER96hk/V9jkg1ntg
        FCdnU+dH4r/+sIZECl2xBviwSlwG
X-Google-Smtp-Source: AHgI3Iam78s/Qlm+MJKJijURl9qRRdT06ZWZsv12M770ehd6vV1zqVl87WclUU9IjFuQpr0obAZE8g==
X-Received: by 2002:a0c:a326:: with SMTP id u35mr20173663qvu.190.1550547634877;
        Mon, 18 Feb 2019 19:40:34 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:34 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 10/11] thermal/x86_pkg_temp_thermal: Support multi-die/package
Date:   Mon, 18 Feb 2019 22:40:12 -0500
Message-Id: <1e81b76b84c572a7bfe9468d33c6fdcfbf7cf513.1550545163.git.len.brown@intel.com>
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

On the new dual-die/package systems, the package temperature MSR becomes
die-scope. Thus instead of one thermal zone device per physical package,
now there should be one thermal_zone for each die on these systems.

This patch introduces x86_pkg_temp_thermal support for new
dual-die/package systems.

On the hardwares that do not have multi-die, topology_die_id() equals
topology_physical_package_id(), thus there is no functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1ef937d799e4..a2eb9136105e 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -122,7 +122,7 @@ static int pkg_temp_debugfs_init(void)
  */
 static struct pkg_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_unique_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return packages[pkgid];
@@ -353,7 +353,7 @@ static int pkg_thermal_notify(u64 msr_val)
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_unique_die_id(cpu);
 	u32 tj_max, eax, ebx, ecx, edx;
 	struct pkg_device *pkgdev;
 	int thres_count, err;
@@ -449,7 +449,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	 * worker will see the package anymore.
 	 */
 	if (lastcpu) {
-		packages[topology_logical_package_id(cpu)] = NULL;
+		packages[topology_unique_die_id(cpu)] = NULL;
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

