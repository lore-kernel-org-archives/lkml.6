Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0196BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61FB2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61FB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937321AbeFSHc3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:32:29 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.197]:42085 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755674AbeFSHc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:32:27 -0400
Received: from [216.82.241.196] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta-8.messagelabs.com id EA/78-05848-A81B82B5; Tue, 19 Jun 2018 07:32:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRWlGSWpSXmKPExsXi5LtOQLdro0a
  0wYQZ7Bbzj5xjtdi4+TaLxaqpO1ksNj2+xmrR9Wsls8XlXXPYLJZev8hk0br3CLvF3+2bWCxe
  bBF34PJYM28No8emVZ1sHpuX1HtsfLeDyaP/r4HH501yAWxRrJl5SfkVCawZC+fvZCro4qrom
  7mGuYHxHEcXIxeHkMBqRokDp9rYIZw1jBKd828wQjhbGCUm/HnF1MXIycEmoCMxZf9hFhBbRE
  BSYu3KRcwgRcwCvxglXv45zgaSEBbwkWj518gKYrMIqEq8/j8VrJlXwFWib8knZhBbQkBO4ua
  5TmaIuKDEyZlPwIYyC2hKtG7/zQ5hy0s0b50NViMkoCyxZcUFRoheBYm1B84zTWDkn4WkfRaS
  9llI2hcwMq9i1ChOLSpLLdI1NtBLKspMzyjJTczM0TU0sNDLTS0uTkxPzUlMKtZLzs/dxAiMi
  HoGBsYdjO+XRR9ilORgUhLlFYvTiBbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwSu4ASgnWJSanl
  qRlpkDjE2YtAQHj5IIryZImre4IDG3ODMdInWKUZfjTltPD7MQS15+XqqUOK8CSJEASFFGaR7
  cCFiauMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmNcJZApPZl4J3KZXQEcwAR2xpUod5IiS
  RISUVANjuI/T9oObuFjfdOqUpV19vXrTvDWL7ksnaihlK6yffKn3SvGvh6Hr34RbFS+bLRda1
  5b3z+fNr3XvpogvY3kaFHun6X10Uaxeodj6zZuUDnJP/P1GI18hT7xl6ctfJw/7lK3evoi5al
  50lATz/YW6Jxq2h/mvdtG5ueqZkL2JbPa5MAPvhD2dSizFGYmGWsxFxYkAwNdvMQ4DAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-15.tower-46.messagelabs.com!1529393545!80868646!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6173 invoked from network); 19 Jun 2018 07:32:25 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-15.tower-46.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Jun 2018 07:32:25 -0000
Received: from MTK-SMS-XCH03.digi.com (10.10.8.197) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 19 Jun 2018
 02:32:25 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH03.digi.com
 (10.10.8.197) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 19 Jun
 2018 02:32:24 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Tue, 19 Jun 2018 09:32:23 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] Add support for the ConnectCore 6UL SOM and SBC Express
Date:   Tue, 19 Jun 2018 09:32:12 +0200
Message-ID: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
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
v4.18-rc1.

More information about the hardware can be found at:

ConnectCore 6UL SOM:
https://www.digi.com/products/embedded-systems/system-on-modules/connectcore-for-i-mx6ul

ConnectCore 6UL SBC Express board:
https://www.digi.com/products/embedded-systems/single-board-computers/connectcore-for-i-mx6ul-sbc-express

Alex Gonzalez (2):
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL System-On-Module (SOM)
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Express

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts | 205 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi       | 199 +++++++++++++++++++++++
 3 files changed, 405 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi

