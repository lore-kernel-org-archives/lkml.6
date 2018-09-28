Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECEAC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5C92170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ym2dhcCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5C92170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeI1LsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:48:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38638 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1LsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:48:08 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8S5PQPQ054834;
        Fri, 28 Sep 2018 00:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538112326;
        bh=EVuuDRLCLpUHLyEh72LswGFEUncS/17kZp/VOOPRPos=;
        h=From:To:CC:Subject:Date;
        b=Ym2dhcCNUcTmsMJe4uAhVasc89vh5NNxHEC9BHNmpXSPIYKgRIMN0Cd47EdJl+juH
         0sStGckuXONbtf9198ONzPDGoFovmO+aEajmQTrEnu477q797ogkfR/ClQFbMh2nAV
         VEAFuiAGPqIWhvsOuD4Deew9+hM1Jp9gcTsJq9Bs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S5PQ4N013542;
        Fri, 28 Sep 2018 00:25:26 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 00:25:26 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 00:25:25 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S5PMGo012173;
        Fri, 28 Sep 2018 00:25:23 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>, Peter Rosin <peda@axentia.se>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Date:   Fri, 28 Sep 2018 10:55:55 +0530
Message-ID: <20180928052557.21663-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of patches to enable i2c-omap driver to be used with TI's new
AM654 platforms.


Vignesh R (2):
  dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
  i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
 drivers/i2c/busses/Kconfig                         | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.19.0

