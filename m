Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDB4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DA0206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DA0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIDTyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:54:18 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.3]:3041 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbeIDTyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:54:18 -0400
Received: from [67.219.250.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.us-west-2.aws.symcld.net id 12/95-13482-8A4AE8B5; Tue, 04 Sep 2018 15:28:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRWlGSWpSXmKPExsXi5LtOQHfFkr5
  og3uP1CzmHznHarFx820Wi1VTd7JYbHp8jdWi69dKZovLu+awWSy9fpHJonXvEXaLv9s3sVi8
  2CLuwOWxZt4aRo9NqzrZPDYvqffY+G4Hk0f/XwOPz5vkAtiiWDPzkvIrElgzbpy+wlRwiLXi+
  orLTA2MJ1i6GLk4hARWMUr0vvrIBOGsZpSYu2YPI4SzmVHi8eW1QGWcHGwCOhJT9h8Gs0UEJC
  XWrlzEDFLELDCFSeL0t11sIAlhAU+Jn2shilgEVCTuLjvHCGLzCrhKXN5+HKxGQkBO4ua5Tma
  IuKDEyZlPwOqZBSQkDr54ARYXElCW2LLiAiNEvYLE2gPnmSYw8s1C0jILScsCRqZVjBZJRZnp
  GSW5iZk5uoYGBrqGhka6hkaWuoZmhnqJVbqJeqXFuuWpxSW6RnqJ5cV6xZW5yTkpenmpJZsYg
  RGQUtC4cAfjphXphxglOZiURHnZFvdFC/El5adUZiQWZ8QXleakFh9ilOHgUJLg3QqSEyxKTU
  +tSMvMAcYiTFqCg0dJhNcLJM1bXJCYW5yZDpE6xajL8ef91EnMQix5+XmpUuK830GKBECKMkr
  z4EbA0sIlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK85SBTeDLzSuA2vQI6ggnoiCUHekCO
  KElESEk1ME5Mapq/sb3ciDF20c2abWnWKj+ZIuYmFR/t+xrvXGftevTvje+m3xbV9xXO+MO5Z
  Mpp3jNR8pNvWT3h+fTg/lzP405qb9/uzlOzZY+2zz1kX7A8rdY3SsVM1erw9ON7Y4PnJqqsFd
  +vu3X6dYN72wKtj9V0bPf4cOHO54q7JRLqq/+n3pB8sE2JpTgj0VCLuag4EQBDHD5hBgMAAA=
  =
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-24.tower-325.messagelabs.com!1536074919!5222929!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18605 invoked from network); 4 Sep 2018 15:28:40 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-24.tower-325.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Sep 2018 15:28:40 -0000
Received: from MTK-SMS-XCH03.digi.com (10.10.8.197) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Sep 2018
 10:28:39 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH03.digi.com
 (10.10.8.197) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Sep 2018
 10:28:38 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 4 Sep 2018 17:28:37 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
Date:   Tue, 4 Sep 2018 17:28:28 +0200
Message-ID: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device tree for the ConnectCore 6UL SBC Pro board, based
on the ConnectCore 6UL SOM.

Changes since v1 [1]:

* Removed unused pinctrl nodes
* Replace undocumented vendor BSP node by using GPIO hogs
* Formatting changes:
        * Change node names to use dashes instead of underscores

[1] https://lore.kernel.org/lkml/1534936719-13770-2-git-send-email-alex.gonzalez@digi.com/

Alex Gonzalez (1):
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 394 ++++++++++++++++++++++++++++
 2 files changed, 395 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts

