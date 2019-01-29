Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CBCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B962177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TPHrr/a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfA2I4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:56:08 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4729 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfA2I4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:56:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5014ff0001>; Tue, 29 Jan 2019 00:55:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 00:56:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 00:56:06 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:56:06 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:56:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 08:56:06 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5015230008>; Tue, 29 Jan 2019 00:56:05 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <blaws05@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: [PATCH v2 0/4] Add max77620 charging & low battery support
Date:   Tue, 29 Jan 2019 16:55:27 +0800
Message-ID: <20190129085531.32364-1-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548752127; bh=f/mq++xqBF/21HVeyj2ANQ+rL5UkChtvORC4r1o8uZM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=TPHrr/a45+ML7bEUWP/r/vHNz85aFWQ5YzrRt05OOUrlcc5/pWpSpUvwTppiTKlhn
         ohqAMpedRI692MD7mrJMB9SDtfLaM34bCClWawvG2NTebQbZwXM4kyiSXedtKaV5HA
         xt6dhZODJfGDEjzV5pGZgLPz8RdaFfVtqpt41Iwn9ZogjOnjF4+r8AuYd/pOYIR7MW
         7J1nmaDjYq5mHFTahtQ+5k6EfDXQXEDt0Si2BWt604lNnPRvJKihDAO0rvgNLJXTlO
         f75Yg4CN5m0ZizlA/0m4KemSH19TcHDwb9YVwFUHgDUmna/POc9Z9yoQ6dYGzbtlFA
         12r4tOy66p0EA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for max77620 backup battery charging and
low battery monitoring.

Changes in v2:
- Add devicetree binding documentation

Mark Zhang (4):
  mfd: max77620: Add backup battery charger support
  mfd: max77620: add documentation for backup battery charging
  mfd: max77620: Add low battery monitor support
  mfd: max77620: add documentation for low battery monitoring

 .../devicetree/bindings/mfd/max77620.txt      |  34 +++++
 drivers/mfd/max77620.c                        | 137 +++++++++++++++++-
 2 files changed, 170 insertions(+), 1 deletion(-)

--=20
2.19.2

