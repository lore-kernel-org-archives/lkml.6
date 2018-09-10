Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C59CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2059220866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2059220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeIJObL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:31:11 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.215]:44022 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbeIJObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:31:11 -0400
Received: from [67.219.246.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.us-east-1.aws.symcld.net id 7D/FA-30461-87B369B5; Mon, 10 Sep 2018 09:38:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRWlGSWpSXmKPExsXi5LtOQLfcelq
  0wfzf+hbzj5xjtdi4+TaLxaqpO1ksNj2+xmrR9Wsls8XlXXPYLJZev8hk0br3CLvF3+2bWCxe
  bBF34PJYM28No8emVZ1sHpuX1HtsfLeDyaP/r4HH501yAWxRrJl5SfkVCawZH25tZCtYw16x+
  VM7cwPjNLYuRi4OIYHVjBIfu8+xQzhrGCW23dkIldnCKNF++TWQw8nBJqAjMWX/YRYQW0RAUm
  LtykXMIEXMAlOYJE5/2wVWJCzgKfFh/3GwIhYBVYnGLTvBbF4BN4mGU0vAbAkBOYmb5zqZIeK
  CEidnPgGLMwtISBx88QIsLiSgLLFlxQVGiHoFibUHzjNNYOSbhaRlFpKWBYxMqxjNkooy0zNK
  chMzc3QNDQx0DQ2NdE10DU0M9BKrdJP1Sot1UxOLS3QN9RLLi/WKK3OTc1L08lJLNjECgz+lg
  KVnB+OxpemHGCU5mJREeSUUp0UL8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuBNtgLKCRalpqdWpG
  XmAOMQJi3BwaMkwqsMkuYtLkjMLc5Mh0idYtTl+PN+6iRmIZa8/LxUKXFeN5AiAZCijNI8uBG
  wlHCJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvUpApPJl5JXCbXgEdwQR0xLrzU0COKElE
  SEk1MPIejMmculp/xmGOv0+eR+YLBs3ac/rX1WkLZh2VeGS2LrP14M6LzjfWuz396FbY2JhjF
  PT8KpOgdcG/5bd/py+9Z1zMXWQgcs3JvtY1gqPJoDmsRDS8fp/7gYcfC+IeNQZcuJO3/rD3oy
  1Fgb9m+7K9tHzpmSrG9dZP8ePetX8z+AP5fdh+fFViKc5INNRiLipOBACD0z8lBAMAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-5.tower-405.messagelabs.com!1536572279!5948285!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22867 invoked from network); 10 Sep 2018 09:37:59 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-5.tower-405.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Sep 2018 09:37:59 -0000
Received: from MTK-SMS-XCH02.digi.com (10.10.8.196) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 10 Sep 2018
 04:37:59 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH02.digi.com
 (10.10.8.196) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 10 Sep
 2018 04:37:58 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 10 Sep 2018 11:37:56 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v3] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
Date:   Mon, 10 Sep 2018 11:37:51 +0200
Message-ID: <1536572272-18590-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device tree for the ConnectCore 6UL SBC Pro board, based on
the ConnectCore 6UL SOM.

Changes since v2 [2]:

* Removed redundant clocks from pwm nodes
* Use real iomux pad values
* Spelling change in regulator-usb-otg1 node name

Changes since v1 [1]:

* Removed unused pinctrl nodes
* Replace undocumented vendor BSP node by using GPIO hogs
* Formatting changes:
        * Change node names to use dashes instead of underscores

[1] https://lore.kernel.org/lkml/1534936719-13770-2-git-send-email-alex.gonzalez@digi.com/
[2] https://lore.kernel.org/lkml/1536074909-8654-1-git-send-email-alex.gonzalez@digi.com/

Alex Gonzalez (1):
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 390 ++++++++++++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts

