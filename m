Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D733C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD1C214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HjSJoLiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfAHV7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:59:14 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9607 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfAHV7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:59:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c351d180000>; Tue, 08 Jan 2019 13:58:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Jan 2019 13:59:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Jan 2019 13:59:13 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Jan
 2019 21:59:12 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Jan 2019 21:59:12 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.151]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c351d300001>; Tue, 08 Jan 2019 13:59:12 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5] i2c: tegra: Fix Maximum transfer size
Date:   Tue, 8 Jan 2019 13:59:09 -0800
Message-ID: <1546984750-26199-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546984729; bh=EJ1NnfBEwUAsT7nEE3ok8p7RA3/5IAQ72DrKCHZi9LM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=HjSJoLiR8xSZarmovJY7KfOMHlE4v4qCIJ9H5djLW3h+d4lmLGFM7B2zv0eakpr1F
         1R1wYYUcqeVDI1xwN2KSPbdBhfOHUcbnHga2NYBbaUt74L8Kj4Au0NLt0GjLyvOGlt
         QS9rfAqUzQmdHyGaSmjAucVzKEsEJyKwYtNBJPK1ZD+q/Uf126UbN0HEMnVtFf1YE1
         HU1TKO0j6iSTUMmOBJCqsOZTUs5sgHHw1AcZgdJ5lSnkoihg/KjvSg7VIImBpcM/oB
         6O5p0qAFw4Fcf+5vDb7Wqd4TCcUPMrQkF180uUHVV9GgAuyHA6YxcytoUBZ6g3SIiU
         d6mq6iO15JOpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V5 is same as V4 Patch rebased to 5.0-rc1

Sowjanya Komatineni (1):
  i2c: tegra: Fix Maximum transfer size

 drivers/i2c/busses/i2c-tegra.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.7.4

