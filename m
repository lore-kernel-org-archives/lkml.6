Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D983C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1A6214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CZ+r16s+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeLRHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:13 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7732 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeLRHfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a3240000>; Mon, 17 Dec 2018 23:35:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 23:35:08 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:08 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a32a0003>; Mon, 17 Dec 2018 23:35:08 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 00/12] Add some functionalities for Tegra soctherm
Date:   Tue, 18 Dec 2018 15:34:32 +0800
Message-ID: <1545118484-23641-2-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118500; bh=g3abqK16pmixOrUCH8NtW0d20RplocShqM3+KYI/8G0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=CZ+r16s+i3yOHJs22kcyQf6KMCPGDizxZkpNTizNK28lzf1LP4IUA/qFYtgb3Z7Hx
         xdDFhnP7qJMPwVWtBtmIMGpoQbrSiUTq1cqqUaylI3AAUan8dG06AXE9FZ5wVfSV/N
         lKu3rGflTen9Gsyj5Fsyib+G8VuxvjatQkC7j4eMsDRq+/3Cp56OsWyLnVo/Pr9mcV
         21F3Rr7ihvkW2LfVFirHqaRkolccQi4yA6sM4HT+25bfSIjC3zrgCURQkdKsFS3hWb
         HKfIIg0bgsBLdVnT2xMUX++9zhLR8oM+ePQ/+Af41mYkc7PLxl2Fudc3gi+84Gjtep
         JiKka2LKQzrng==
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
 drivers/thermal/tegra/soctherm.c                   | 959 +++++++++++++++++++--
 drivers/thermal/tegra/soctherm.h                   |  16 +
 drivers/thermal/tegra/tegra124-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra132-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra210-soctherm.c          |  15 +-
 include/dt-bindings/thermal/tegra124-soctherm.h    |  22 +-
 8 files changed, 1033 insertions(+), 76 deletions(-)

-- 
2.7.4

