Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C7BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6369205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6369205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeJSCRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:17:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:54051 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbeJSCRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:17:22 -0400
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="scan'208";a="19728509"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 18 Oct 2018 11:15:13 -0700
Received: from validation1-HP-EliteBook-8540p.mchp-main.com (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Thu, 18 Oct 2018 11:15:11 -0700
From:   Yuiko Oshino <yuiko.oshino@microchip.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <f.fainelli@gmail.com>,
        <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <m.felsch@pengutronix.de>, <Markus.Niebel@tqs.de>,
        <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH v3 net-next 0/2] Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet PHY
Date:   Thu, 18 Oct 2018 15:06:00 -0400
Message-ID: <1539889562-21458-1-git-send-email-yuiko.oshino@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is the initial driver for Microchip KSZ9131 10/100/1000 Ethernet PHY

v3:
- KSZ9131 uses picosecond units for values of devicetree properties.
- rewrite micrel.c and micrel-ksz90x1.txt to use the picosecond values.
v2:
- Creating a series from two related patches.

Yuiko Oshino (2):
  net: phy: micrel: add Microchip KSZ9131 initial driver
  dt-bindings: net: add support for Microchip KSZ9131

 .../devicetree/bindings/net/micrel-ksz90x1.txt     |  28 ++++-
 drivers/net/phy/micrel.c                           | 130 ++++++++++++++++++++-
 include/linux/micrel_phy.h                         |   1 +
 3 files changed, 157 insertions(+), 2 deletions(-)

-- 
2.7.4

