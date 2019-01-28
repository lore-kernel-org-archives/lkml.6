Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE94C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EC220870
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dA75PMuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfA1Fsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:48:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55902 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Fss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 00:48:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0S5maHE005684;
        Sun, 27 Jan 2019 23:48:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548654516;
        bh=mX3yJ3Julq4LUhAGw3aZhrD+3gRTkWL9WMSrHiLwmQ0=;
        h=From:To:CC:Subject:Date;
        b=dA75PMuZRzCrKeLZRDOVUDScOywrdUuT0cZ1sfobz3kT/6VrZ0fOijb8aZ1BAJWiI
         B2Nxukw3Y9gexTALrFIcRHkvzlWpZoUGDKdHPg7ru7xTDDrShRC0Xd8iSp4gHBNtUq
         CFK256BUH4W6DB55yYVaVHFtR1VFvK4f9gDuRXO0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0S5mZ3c025737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 23:48:36 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 27
 Jan 2019 23:48:35 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 27 Jan 2019 23:48:35 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0S5mW5O020800;
        Sun, 27 Jan 2019 23:48:33 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        <Tudor.Ambarus@microchip.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v5 0/2] cadence-quadspi: Add Octal mode support
Date:   Mon, 28 Jan 2019 11:19:33 +0530
Message-ID: <20190128054935.4972-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for OSPI version of Cadence QSPI controller IP.
Tested with AM654 EVM with MT35x512 Octal flash

Changes:
v5:
Fix comments from by on v4.

v4:
Fix comments on v3 by Tudor.
Rebase on top latest linux-next(all dependencies are now part of -next)

v3:
Rebase on top of v7 of Yogesh's series[1]

v2:
spi-nor core patches dropped, are now part of Yogesh's series [1]
Declare Octal mode capability based on compatible.

Vignesh R (2):
  dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
  mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller

 .../bindings/mtd/cadence-quadspi.txt          |  1 +
 drivers/mtd/spi-nor/cadence-quadspi.c         | 58 +++++++++++++++----
 2 files changed, 47 insertions(+), 12 deletions(-)

-- 
2.20.1

