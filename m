Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C4CC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150BE2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VOOISF93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfBLGol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:44:41 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14050 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfBLGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:44:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c626b420000>; Mon, 11 Feb 2019 22:44:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 22:44:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Feb 2019 22:44:17 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 06:44:17 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 06:44:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 06:44:16 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c626b3f0000>; Mon, 11 Feb 2019 22:44:16 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: [PATCH v3 0/4] Add max77620 charging & low battery support
Date:   Tue, 12 Feb 2019 14:43:49 +0800
Message-ID: <20190212064353.7451-1-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549953858; bh=62s4+2Som6xkEHjkuxxOFy0kEZ8EUQEUxXFmPnyIXbE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=VOOISF93nEkdFaFeIxu2qpzPb5JfGmGcGJXhXqFxdKGnWI5vNdtauTOho0L9x4enh
         zizCO7tFZcZjR3bILrezBqtKStUgU82UFUubXb8/NNz4zhxDzC5iaTp1mRgo+H7sJz
         i+arDoIpo1orVSpC8uUU/bEr8AKQv255C7JAzBg0lxo7sVhSxYU/QCKnYO8syOBYxB
         MM7vd1V2ivJGtyUfQEvCPysTB2P2n+AfhoJ6Bo8DVjSl2We9glRZVacwGjJTlAseeL
         B/P0BcLSXlZacZwQ214xsI42cKCumqHMtxLhnOZHf1Bko/IeLEnmXxd6kNgio2j/sn
         uBKHgBLayCclw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for max77620 backup battery charging and
low battery monitoring.

Changes in v3:
- Add unit suffix to backup battery charging dts properties
- Reduce/optimize the low battery monitoring dts properties

Changes in v2:
- Add devicetree binding documentation

Mark Zhang (4):
  mfd: max77620: Add backup battery charger support
  mfd: max77620: add documentation for backup battery charging
  mfd: max77620: Add low battery monitor support
  mfd: max77620: add documentation for low battery monitoring

 .../devicetree/bindings/mfd/max77620.txt      |  34 ++++++
 drivers/mfd/max77620.c                        | 115 +++++++++++++++++-
 2 files changed, 148 insertions(+), 1 deletion(-)

--=20
2.19.2

