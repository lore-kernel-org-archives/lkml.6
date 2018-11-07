Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92C3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804F120883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ncYXQeO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804F120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeKGUI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:08:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50552 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGUI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:08:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA7AcXcR003736;
        Wed, 7 Nov 2018 04:38:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541587113;
        bh=UV/pWTHMseKbciWvp3tTvDepmV3SEumM/6UlrBg5cXY=;
        h=From:To:CC:Subject:Date;
        b=ncYXQeO6FdMAlBxm6Bq9hyBLZznbpibw7oNLEoxJrPx5knIculF9iEAwk8tdqYj0x
         1TiGk4965KCCWJWujg+Krag/XJbXu2LI1gEn3yQXNogBKc4OWEsIeR4K/y5LFUDcrw
         xbAHmQ6ABGjbpe8yyq3KjTdJLQIfowZAu3vDgNic=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA7AcXKB120873
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 04:38:33 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 7 Nov
 2018 04:38:33 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 7 Nov 2018 04:38:32 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA7AcU7P016409;
        Wed, 7 Nov 2018 04:38:31 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <linux-spi@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] McSPI: Enable mcspi driver for AM654 SoCs
Date:   Wed, 7 Nov 2018 16:09:24 +0530
Message-ID: <20181107103926.32550-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of patches to enable mcspi driver to be used with TI's new
AM654 SoCs.

Vignesh R (2):
  dt-bindings: spi: omap-spi: Add compatible for AM654 SoC
  spi: Kconfig: Enable McSPI driver for K3 platforms

 Documentation/devicetree/bindings/spi/omap-spi.txt | 1 +
 drivers/spi/Kconfig                                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.1

