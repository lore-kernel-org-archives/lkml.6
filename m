Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC99C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0DF2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TwjmnWFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfABU6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:58:02 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5644 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfABU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:57:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2d25c80000>; Wed, 02 Jan 2019 12:57:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Jan 2019 12:57:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Jan 2019 12:57:57 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 20:57:57 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 20:57:55 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 20:57:55 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2d25d30002>; Wed, 02 Jan 2019 12:57:55 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V3 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad drive strength config
Date:   Wed, 2 Jan 2019 12:57:52 -0800
Message-ID: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546462664; bh=TwO8HBC/yN7+e87ym/9OvpnSJ+PvBnYMkAz3aWnRwOs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=TwjmnWFAENTq4Ty0rD9ARSxffTJF7GhGqyaoPraUVQRscpUDE86rlTKGJ027/XJs4
         HrmIyiCUcRjR8w/y/eKucph7E1szarltDGafGke60jcRTqBOqwcVANBD2DDVA8X0EL
         PHsm636lCoyst9V5S3KOpBIOpO3JqNf2OLi/Zds8YgqKUnX97NihWUBfQgSJcuVdgf
         hzieKLvJ5IsiUrb09hxSJ/kpGZiwn/G+/5Pk+jziNZDMCi/0x6brnUSTZaeWfWe7+d
         NSR/fFbmufhEEyqSL5DQ+8hg7atJ96q5JBGPOMu7do+1ij4yRXKexEoeVnPJqwN6fn
         VXJwjbVDBn5KQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
Tegra210 sdmmc which has pad configuration registers in the pinmux
reigster domain.
Pad drive strengths for Tegra186 and Later are
part of SDMMC device node itself.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 32b4b4e41923..2cecdc71d94c 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -39,12 +39,16 @@ sdhci@c8000200 {
 	bus-width = <8>;
 };
 
-Optional properties for Tegra210 and Tegra186:
+Optional properties for Tegra210, Tegra186 and Tegra194:
 - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
   configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
   for controllers supporting multiple voltage levels. The order of names
   should correspond to the pin configuration states in pinctrl-0 and
   pinctrl-1.
+- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for
+  Tegra210 where pad config registers are in the pinmux register domain
+  for pull-up-strength and pull-down-strength values configuration when
+  using pads at 3V3 and 1V8 levels.
 - nvidia,only-1-8-v : The presence of this property indicates that the
   controller operates at a 1.8 V fixed I/O voltage.
 - nvidia,pad-autocal-pull-up-offset-3v3,
-- 
2.7.4

