Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5022086B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5022086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeGJMsh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:48:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18447 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932752AbeGJMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:48:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b44ab1d0000>; Tue, 10 Jul 2018 05:48:29 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 10 Jul 2018 05:48:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 10 Jul 2018 05:48:34 -0700
Received: from dhcp-10-21-25-168.Nvidia.com (10.21.25.201) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Tue, 10 Jul 2018 12:48:31 +0000
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] Tegra PMC pinctrl pad configuration
Date:   Tue, 10 Jul 2018 15:47:53 +0300
Message-ID: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Tegra Power Management Controller (PMC) can set pad power states
and voltage configuration. This series implements pinctrl interfaces
for configuring said pad properties.

Aapo Vienamo (6):
  soc/tegra: pmc: Fix pad voltage configuration for Tegra186
  soc/tegra: pmc: Factor out DPD register bit calculation
  soc/tegra: pmc: Implement tegra_io_pad_is_powered()
  soc/tegra: pmc: Use X macro to generate IO pad tables
  dt-bindings: Add Tegra PMC pad configuration bindings
  soc/tegra: pmc: Implement pad configuration via pinctrl

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  84 ++++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  95 ++++
 drivers/soc/tegra/pmc.c                            | 504 ++++++++++++++++-----
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 +
 include/soc/tegra/pmc.h                            |   1 +
 5 files changed, 580 insertions(+), 122 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

-- 
2.7.4

