Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3081BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE93A21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OWJHkGg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLRHfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:09 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18420 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRHfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a3250002>; Mon, 17 Dec 2018 23:35:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 23:35:06 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:06 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:06 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a3280006>; Mon, 17 Dec 2018 23:35:06 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 00/12] Add some functionalities for Tegra soctherm
Date:   Tue, 18 Dec 2018 15:34:31 +0800
Message-ID: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118501; bh=hk219me9ZduMY8DTOflhQCRhusELCHiqNwelYLjaI4k=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=OWJHkGg7AfeZsqHQgcUDcojU8OaJsNHbdDM61t9MykbZf+pHQPVuceIHl8ngyvmz8
         gLjdQo5LcnGLRozLtPuJ5MWt5ISJuB26a3x4ivE6ODYiG5Sj3xO4mcsgksJ7BXmdK8
         /CDHeGVkm3MsH/KxQ/5nXI+t8c7gL/0nb0RfGbdIwpvKqSpueahF2VVQohTu7KbTWB
         VrLA0QRJF1bOj8wWFYENlAkYgJ+Wjl9HsMARt3WQEtjtrLMPn0I5t6gpu83b2Lb0Od
         Ty7W+UCCz5QtyfILP1L2UAR7aVHY7hNdegUfNwZMSfnD2vBWdvyoOwNhoxXvCmp8q2
         h9qAkRg8B1U6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the hw/sw shutdown patches into this serial. There already have
some discussion for it in https://lkml.org/lkml/2018/12/7/225.
Support GPU HW throttle, thermal IRQ, set_trips(), EDP IRQ and OC
hw throttle.

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

 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  63 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  20 +-
 drivers/thermal/tegra/soctherm.c                   | 955 +++++++++++++++++++--
 drivers/thermal/tegra/soctherm.h                   |  16 +
 drivers/thermal/tegra/tegra124-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra132-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra210-soctherm.c          |  15 +-
 include/dt-bindings/thermal/tegra124-soctherm.h    |  22 +-
 8 files changed, 1029 insertions(+), 76 deletions(-)

-- 
2.7.4

