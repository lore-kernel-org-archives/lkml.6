Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F4420862
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F4420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeGLI3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:29:17 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.3]:9941 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbeGLI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:29:17 -0400
Received: from [67.219.250.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.us-west-2.aws.symcld.net id BD/7F-01617-D5F074B5; Thu, 12 Jul 2018 08:20:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42Jx8l0noBvL7x5
  tsGOykMX8I+dYLTZuvs1isWrqThaLTY+vsVp0/VrJbHF51xw2i6XXLzJZtO49wm7xd/smFosX
  W8QduDzWzFvD6LFpVSebx+Yl9R4b3+1g8uj/a+DxeZNcAFsUa2ZeUn5FAmvG+2efGAt281R8O
  H2cvYHxMFcXIxeHkMAqRomlx8+yQzhbGCX65hwDcjg52AR0JKbsP8wCYosISEqsXbmIGaSIWW
  AKk8Tpb7vYQBLCAv4S6743AjVwcLAIqErsP2QBEuYVcJVYtPYCM4gtISAncfNcJzNEXFDi5Mw
  nYDOZBTQlWrf/Zoew5SWat84GqxESUJbYsuICI0SvgsTaA+eZJjDyzULSPgtJ+ywk7QsYmVcx
  WiQVZaZnlOQmZuboGhoY6BoaGukaGlnoGhkZ6iVW6SbqlRbrlqcWl+ga6SWWF+sVV+Ym56To5
  aWWbGIERgUDEOxg/PYi5RCjJAeTkiivlJVrtBBfUn5KZUZicUZ8UWlOavEhRhkODiUJXiY+92
  ghwaLU9NSKtMwcYHzCpCU4eJREeJVB0rzFBYm5xZnpEKlTjMYcp5p7JjFz/Hk/dRKzEEtefl6
  qlDhvOUipAEhpRmke3CBY2rjEKCslzMsIdJoQT0FqUW5mCar8K0ZxDkYlYV57kCk8mXklcPte
  AZ3CBHRKXIobyCkliQgpqQbGgFXv3UQupbt3HeLfov/5Tnbbu4iKNYcvXJzZ/SI23/XFDxlTe
  49Qy+sGMkE7aoPsX5xpVM7WehtjsLj6f/UbB8no9aHsps1t/PMPpOaUfKrdY5Ok96jpb8G/ZZ
  LzUhLXNH0681kw4V+Vx0SDK01GkvX8cRE50T/5+feJbN/Hpb/xzq4Hb44osRRnJBpqMRcVJwI
  Ao2BWIhYDAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-12.tower-325.messagelabs.com!1531383644!1480087!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5392 invoked from network); 12 Jul 2018 08:20:45 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-12.tower-325.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Jul 2018 08:20:45 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 12 Jul 2018
 03:20:43 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Thu, 12 Jul 2018 10:20:41 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v2 0/2] Add support for the ConnectCore 6UL SOM and SBC Express
Date:   Thu, 12 Jul 2018 10:20:34 +0200
Message-ID: <1531383636-3406-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a device tree include for the ConnectCore 6UL
System-On-Module and a device tree for the ConnectCore 6UL SBC Express board
that includes it.

Not all the SOM hardware is supported in this initial patchset, specifically
the 802.11 WiFi and BT chipset and the extended functionality provided by
the on module NXP Kinetis KL03 are not supported.

The SOM is based on NXP's i.MX6UL SoC, and the patchset is tested against
v4.18-rc4.

More information about the hardware can be found at:

ConnectCore 6UL SOM:
https://www.digi.com/products/embedded-systems/system-on-modules/connectcore-for-i-mx6ul

ConnectCore 6UL SBC Express board:
https://www.digi.com/products/embedded-systems/single-board-computers/connectcore-for-i-mx6ul-sbc-express

Changes since v1 [1]:

* Remove not needed DT properties
* Formatting changes:
        * Re-order nodes alphabetically
        * Add empty lines between properties and child nodes
        * Use generic node names

[1] https://lore.kernel.org/lkml/1529393534-7827-1-git-send-email-alex.gonzalez@digi.com/

Alex Gonzalez (2):
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL System-On-Module (SOM)
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Express

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts | 200 +++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi       | 202 ++++++++++++++++++++++++
 3 files changed, 403 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi

