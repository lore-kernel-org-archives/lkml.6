Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2AAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD122150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD122150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeHVOnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:43:25 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.2]:15617 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728884AbeHVOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:43:24 -0400
Received: from [67.219.250.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.us-west-2.aws.symcld.net id C0/78-18894-9964D7B5; Wed, 22 Aug 2018 11:18:49 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRWlGSWpSXmKPExsXi5LtOQHeGW22
  0waFtVhbzj5xjtdi4+TaLxaqpO1ksNj2+xmrR9Wsls8XlXXPYLJZev8hk0br3CLvF3+2bWCxe
  bBF34PJYM28No8emVZ1sHpuX1HtsfLeDyaP/r4HH501yAWxRrJl5SfkVCawZ+6btYip4zFKxc
  O40lgbGNpYuRi4OIYFVjBL/2w+zQjhbGCX6J61g7mLk5GAT0JGYsv8wC4gtIiApsXblImaQIm
  aBKUwSp7/tYuti5OAQFrCRmNwhBFLDIqAqcedGLyuIzSvgJvF65wI2EFtCQE7i5rlOZoi4oMT
  JmU/AZjILSEgcfPECLC4koCyxZcUFRoh6BYm1B84zTWDknYWkZRaSlgWMTKsYLZKKMtMzSnIT
  M3N0DQ0MdA0NjXQNjYG0mYleYpVuol5psW55anGJrpFeYnmxXnFlbnJOil5easkmRmCQMwDBD
  saLh1IOMUpyMCmJ8t6SrY0W4kvKT6nMSCzOiC8qzUktPsQow8GhJMG7xhUoJ1iUmp5akZaZA4
  w3mLQEB4+SCK8WSJq3uCAxtzgzHSJ1ilGX48/7qZOYhVjy8vNSpcR5C0GKBECKMkrz4EbAYv8
  So6yUMC8j0FFCPAWpRbmZJajyrxjFORiVhHnLQabwZOaVwG16BXQEE9ARrMxgR5QkIqSkGhij
  Onov5yx+JMG14Gn9aZOmnJZvXZN/hU90n8B/1F+JPzJwlYJvXWmOV12vwYdVG1/uyH5w6FTwo
  +676Su+tQd8vCrd7dp4r8OlPOqiiWmtSMoS6/XWJ7yq62eel/eReNS/5vQOZ27eTwXxdQtKY7
  Q9D38NszTR5X3y8OyH+WHKOfIitm/P3lJiKc5INNRiLipOBAAHZk7V+AIAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-16.tower-325.messagelabs.com!1534936727!4287907!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28880 invoked from network); 22 Aug 2018 11:18:48 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-16.tower-325.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Aug 2018 11:18:48 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 22 Aug 2018
 06:18:47 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 22 Aug 2018 13:18:45 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH] Add support for the ConnectCore 6UL SBC Pro
Date:   Wed, 22 Aug 2018 13:18:38 +0200
Message-ID: <1534936719-13770-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device tree for the ConnectCore 6UL SBC Pro board

The ConnectCore 6UL SBC Pro includes the ConnectCore 6UL System-On-Module.

More information about the hardware can be found at:
https://www.digi.com/products/embedded-systems/single-board-computers/connectcore-for-i-mx6ul-sbc-pro

Alex Gonzalez (1):
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 466 ++++++++++++++++++++++++++++
 2 files changed, 467 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts

