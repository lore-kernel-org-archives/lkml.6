Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91164C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6049F214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="njbpg3q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfBUKS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:18:56 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17406 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBUKSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:18:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6e7b130000>; Thu, 21 Feb 2019 02:18:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 02:18:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Feb 2019 02:18:53 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:18:53 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:18:53 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:18:52 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6e7b0a0001>; Thu, 21 Feb 2019 02:18:52 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 00/12] Add some functionalities for Tegra soctherm
Date:   Thu, 21 Feb 2019 18:18:35 +0800
Message-ID: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550744339; bh=no6cRkG3wd5VqvNqeG4SGg7Ptb40dq1jqpxg95akVE0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=njbpg3q97GHeYfhe4EFIy6tXBS1bCrtRmovCm5OWT2I/HV/8mc1U1+hS+ngXdUlxo
         4ibriSGtBFGDeeHOR12KvXKSDBWfLukoLOQQmgt9O4qD56IbICLSKu0EkYV4mwyvIZ
         IgiZYUsabV2IomwTs4jd5M2XJQoC7qV1AU0An2odj3SMax8zjnBeH1GlRi0kaJlt/y
         dod5tbmhi9Yriclt8iOFCf9TdiDYXKstraRzya3hFR9DsgbKxsHbfY3E0+ZDoeOjja
         xcVXzbLzXQlrDFBrxNeN2GmJZmsrKGRDhqTfQcNDxEOfbXyFzSMaf3K/TVIka+pRkK
         SHRKb5WNPWIjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the hw/sw shutdown patches into this serial. There already have
some discussion for it in https://lkml.org/lkml/2018/12/7/225.
Support GPU HW throttle, thermal IRQ, set_trips(), EDP IRQ and OC
hw throttle.

Main change from v1:
1. Use boolean for "nvidia,polarity-active-low".
2. Add suffix "-us" for "nvidia,throttle-period".


Wei Ni (12):
  of: Add bindings of thermtrip for Tegra soctherm
  thermal: tegra: support hw and sw shutdown
  arm64: dts: tegra210: set thermtrip
  of: Add bindings of gpu hw throttle for Tegra soctherm
  thermal: tegra: add support for gpu hw-throttle
  arm64: dts: tegra210: set gpu hw throttle level
  thermal: tegra: add support for thermal IRQ
  thermal: tegra: add set_trips functionality
  thermal: tegra: add support for EDP IRQ
  arm64: dts: tegra210: set EDP interrupt line
  of: Add bindings of OC hw throttle for Tegra soctherm
  thermal: tegra: enable OC hw throttle

 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  62 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  20 +-
 drivers/thermal/tegra/soctherm.c                   | 961 +++++++++++++++++++--
 drivers/thermal/tegra/soctherm.h                   |  16 +
 drivers/thermal/tegra/tegra124-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra132-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra210-soctherm.c          |  15 +-
 include/dt-bindings/thermal/tegra124-soctherm.h    |   8 +-
 8 files changed, 1020 insertions(+), 76 deletions(-)

-- 
2.7.4

