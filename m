Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B9AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E842083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qVaEUgPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E842083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGKOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:14:24 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1332 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGKOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:14:24 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0a47fe0000>; Fri, 07 Dec 2018 02:14:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Dec 2018 02:14:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Dec 2018 02:14:23 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 10:14:22 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Dec 2018 10:14:22 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c0a47fc0002>; Fri, 07 Dec 2018 02:14:21 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 0/3] support nvidia,thermtrip property
Date:   Fri, 7 Dec 2018 18:10:04 +0800
Message-ID: <1544177407-20203-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544177663; bh=vB16v/KCnRWW2eJLjrAzNb2vKriAVocF2j8Kqs4CMXQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=qVaEUgPDe4AL3PxWhD8XiNzRhU0iaELELeGL7GcT20/WU3bN/JiZN/ygEp2OyzwMV
         BylOSHQ6hgXyOuPy7lM50kGkDdTfVUOmEdC3IW6oSNMBQz1fpwj8+uJbvkuHSgGfAE
         gY24XCZNWKz3sIx7WWohnlmNCIgXH0/lcmi2GHMNnCD6ybGDactw2W5B1x8AuDcRKH
         qW+pgm9kvbvn2woxb+vLoZPEvoy0pCP8Np3YDA+pO8IJNPJW+5MVkglErB25zbFFit
         bK/PRfJBKuvufRDSONzizzPM4YCsjoRhDv8j1KuKl0iZS5dWhhjtidwse0aIN+XjIa
         Cm78IzZTeEmdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "nvidia,thermtrip" property to implement HW and SW
shutdown.

Wei Ni (3):
  of: add nvidia,thermtrips property
  thermal: tegra: support hw and sw shutdown
  arm64: dts: tegra210: set thermtrip

 .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 20 ++++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 15 ++--
 drivers/thermal/tegra/soctherm.c                   | 99 ++++++++++++++++++----
 drivers/thermal/tegra/soctherm.h                   |  6 ++
 drivers/thermal/tegra/tegra210-soctherm.c          |  8 ++
 5 files changed, 124 insertions(+), 24 deletions(-)

-- 
2.7.4

