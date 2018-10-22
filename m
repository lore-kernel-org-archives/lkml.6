Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBEEC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184F20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D184F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeJVSvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:51:33 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.209]:9178 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728692AbeJVSvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:51:32 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-west-2.aws.symcld.net id BC/B6-11821-777ADCB5; Mon, 22 Oct 2018 10:33:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRWlGSWpSXmKPExsXi5LtOQLd8+dl
  og3c3uS3mHznHarFx820Wi1VTd7JYbHp8jdWi69dKZovLu+awWSy9fpHJonXvEXaLv9s3sVi8
  2CLuwOWxZt4aRo9NqzrZPDYvqffY+G4Hk0f/XwOPz5vkAtiiWDPzkvIrElgzns7dxFTwgLni7
  JriBsbJzF2MXBxCAqsZJVa9P8AK4axhlOid1soE4WxhlGh9cxEow8nBJqAjMWX/YRYQW0RAUm
  LtykVg7cwCU5gkTn/bxQaSEBaIkvh4cwZYEYuAqkTP3152EJtXwE1i0+dLzCC2hICcxM1zncw
  QcUGJkzOfgNUzC0hIHHzxAiwuJKAssWXFBUaIegWJtQfOM01g5JuFpGUWkpYFjEyrGM2SijLT
  M0pyEzNzdA0NDHQNDY10DY0tdM31Eqt0k/VKi3XLU4tLdI30EsuL9Yorc5NzUvTyUks2MQJDP
  6Wgi30H47IV6YcYJTmYlER5E41PRwvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4E1ddjZaSLAoNT
  21Ii0zBxiFMGkJDh4lEd6JIGne4oLE3OLMdIjUKUZFKXHeGSAJAZBERmkeXBss8i8xykoJ8zI
  yMDAI8RSkFuVmlqDKv2IU52BUEubNBJnCk5lXAjf9FdBiJqDF19XPgCwuSURISTUwrhF7lT+5
  0aV8yUFFRVk2y715sxgl9quVtAgfWWq4YhrDxS8nlkWpXU+XVUnzL7xf5Gx193lc/cbSz0Z3q
  8O3LGEIFbV+NNMr/BSL2AWDbMsLt7uSfvNaav9Wn8q0OeZVyJM0o3VKT46pKNqWXN247c2Gjj
  i2ws+F7mVz/S+dKJ2q5Fc5yfizEktxRqKhFnNRcSIAX1MncfcCAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-29.tower-365.messagelabs.com!1540204406!982554!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21358 invoked from network); 22 Oct 2018 10:33:27 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-29.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Oct 2018 10:33:27 -0000
Received: from MTK-SMS-XCH03.digi.com (10.10.8.197) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 22 Oct 2018
 05:33:25 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH03.digi.com
 (10.10.8.197) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 22 Oct
 2018 05:33:25 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Oct 2018 12:33:23 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH 0/2] ARM: dts: ccimx6ulsbcpro: Add 10" AUO/Goodix LVDS panel accessory kit
Date:   Mon, 22 Oct 2018 12:33:17 +0200
Message-ID: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a LVDS panel accessory kit consisting of:

* AU Optronics G101EVN010 10.1 inches TFT-LCD display
* Goodix GT911 capacitive touch controller

Alex Gonzalez (2):
  ARM: dts: ccimx6ulsbcpro: Add support for AUO G101EVN010 display
  ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller

 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 44 +++++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig        |  1 +
 2 files changed, 45 insertions(+)

