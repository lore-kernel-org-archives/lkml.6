Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16133C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15B120883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="nRSyIo/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15B120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeGZFRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:17:53 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42593 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeGZFRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:17:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BDBCF8448A;
        Thu, 26 Jul 2018 16:03:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532577780;
        bh=eEvZ6NYSq3krQtvitbujDblffmsjX2NGlbSFAF7eKA8=;
        h=From:To:Cc:Subject:Date;
        b=nRSyIo/lNDZVXuW9tLr6AjP4cFe5rAd97JHjbYeXQoLuEncGsRD0FxEShLeeiWzFD
         50/Ojnl0eyKp4zdAbRHKrhuHf1cqvSH9/mj3z7vSI+bUgdrpTeQ70xxuiqkMca53jC
         4ZkRkdLXhFVB10DHGc3I1WPM0JrCKodxfpnviHCo=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5947f50000>; Thu, 26 Jul 2018 16:03:01 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id E48D013ED1C;
        Thu, 26 Jul 2018 16:03:01 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8786A1E262C; Thu, 26 Jul 2018 16:03:00 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jason@lakedaemon.net,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/4] ARM: dts: mvebu: updates and new board
Date:   Thu, 26 Jul 2018 16:02:53 +1200
Message-Id: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the armada-xp-98dx3236 SoC and related boards to use the
new style dts bindings for nand.

I've also added a new db-88f6820-amc board which is an Armada-385 based
reference board from Marvell's switch team. It's a plugin card for either the
db-dxbc2 or db-xc3-24g4 which can be used if you disable the internal CPU on
those platforms.

Chris Packham (4):
  ARM: dts: mvebu: 98dx3236: Rename nand controller node
  ARM: dts: mvebu: db-dxbc2: use new style nand binding
  ARM: dts: mvebu: db-xc3-24g4: use new style nand binding
  ARM: dts: mvebu: Add device tree for db-88f6820-amc board

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/armada-385-db-88f6820-amc.dts    | 184 ++++++++++++++++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi     |   2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts      |  18 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts |  18 +-
 5 files changed, 208 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts

-- 
2.18.0

