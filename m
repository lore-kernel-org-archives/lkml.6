Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1E1C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8149C20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hqqmwKQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8149C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeLMJqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:46:42 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19251 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeLMJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:46:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c122a7e0000>; Thu, 13 Dec 2018 01:46:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Dec 2018 01:46:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 01:46:41 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 09:46:41 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 09:46:40 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 09:46:40 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.11.125]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c122a7e0000>; Thu, 13 Dec 2018 01:46:40 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Stephen Boyd <sboyd@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Drop SMP dependency from CPU APIs
Date:   Thu, 13 Dec 2018 09:46:14 +0000
Message-ID: <1544694374-21231-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544694398; bh=Ft5+8lbZU/6fig0awjsgyduQwVTou1c07JLVKO965bg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=hqqmwKQEMaRBplE4VT9jv7c0Yp6SW5eoztZwpURq7QrV9MAcSipFBB7Y6gfhNJKqU
         sWM8h5VvDuvlN3J0J1lEukCq5OxM5//+d3O8kPnkwupYo1KepYSrqBXdI/3tPpBLMI
         Y0cexVkgowozglmI1+Z79TNrPaf6eqtHOgFXK+H0V4BVBIo5sbayQ7+49yS0k/2FKp
         7glCQyXzkSX3tfd/Ux0Ej0DE+ClWSZjrMQCJXY1HwV/9VCWWBOVydgFWdJmTYFnpu/
         PGDTsRWDsay+x6WGXSe2ATUz51Ikw4O2ENpDb1WDpo8SB3adJYdxcveMUo3Breb/H3
         fR6Chws73o26w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SMP is disabled, the tegra clk driver now fails to build:

drivers/clk/tegra/clk-tegra30.c: In function =E2=80=98tegra30_cpu_rail_off_=
ready=E2=80=99:
drivers/clk/tegra/clk-tegra30.c:1151:2: error: implicit declaration of func=
tion =E2=80=98tegra_pmc_cpu_is_powered=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
  cpu_pwr_status =3D tegra_pmc_cpu_is_powered(1) ||
    ^
Fix the above error by removing the CONFIG_SMP ifdef around the
declaration around the PMC CPU APIs because although these are not
needed for non-SMP configurations, there is no harm in including these
for non-SMP builds either.

Fixes: 61866523ed6e ("clk: tegra30: Use Tegra CPU powergate helper function=
")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 2 --
 include/soc/tegra/pmc.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 8c46b0aace0b..7ea3280279ff 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -689,7 +689,6 @@ int tegra_powergate_sequence_power_up(unsigned int id, =
struct clk *clk,
 }
 EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
=20
-#ifdef CONFIG_SMP
 /**
  * tegra_get_cpu_powergate_id() - convert from CPU ID to partition ID
  * @cpuid: CPU partition ID
@@ -749,7 +748,6 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid)
=20
 	return tegra_powergate_remove_clamping(id);
 }
-#endif /* CONFIG_SMP */
=20
 static int tegra_pmc_restart_notify(struct notifier_block *this,
 				    unsigned long action, void *data)
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index fd816f6aa9cc..a9db1b501de1 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -26,11 +26,9 @@
 struct clk;
 struct reset_control;
=20
-#ifdef CONFIG_SMP
 bool tegra_pmc_cpu_is_powered(unsigned int cpuid);
 int tegra_pmc_cpu_power_on(unsigned int cpuid);
 int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
-#endif /* CONFIG_SMP */
=20
 /*
  * powergate and I/O rail APIs
--=20
2.7.4

