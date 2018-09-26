Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F897214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a49+gt5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F897214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeIZSKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:10:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50172 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbeIZSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:10:22 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QBv3WY128921;
        Wed, 26 Sep 2018 06:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537963023;
        bh=FIb1e9XmdUhlcBGyVICkczHALmEYYGtQX/GBiz9T2QU=;
        h=From:To:CC:Subject:Date;
        b=a49+gt5H94uUQu4fmS+ttAim4OOJxldEvA4bBNC15dpRtxKdkKPylvGsRnJeR69Om
         Mq33P1U3tgutLOR9kr3BuYMytx3e5GFGN2BCUywmK0vbt2TJ/DmFmqPkSUjC0gN/Kr
         tAG3+/MOcLR4wlR9oT58Momu5egVqKC4kyOc1dIE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QBv2VC025343;
        Wed, 26 Sep 2018 06:57:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 06:57:02 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 06:57:02 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QBuwVc002625;
        Wed, 26 Sep 2018 06:56:59 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Date:   Wed, 26 Sep 2018 17:27:49 +0530
Message-ID: <20180926115751.20421-1-vigneshr@ti.com>
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

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 1 +
 drivers/i2c/busses/Kconfig                         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.0

