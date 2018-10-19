Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA81ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8372D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8372D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJSXW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:22:27 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.212]:56108 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbeJSXW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:22:27 -0400
Received: from [67.219.246.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-east-1.aws.symcld.net id EC/98-10938-A25F9CB5; Fri, 19 Oct 2018 15:15:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRWlGSWpSXmKPExsXi5LtOQFfz68l
  ogzPdRhbzj5xjtdi4+TaLxaqpO1ksNj2+xmrR9Wsls8XlXXPYLJZev8hk0br3CLvF3+2bWCxe
  bBF34PJYM28No8emVZ1sHpuX1HtsfLeDyaP/r4HH501yAWxRrJl5SfkVCawZ16ZvYin4wFwx6
  ehrpgbG9cxdjFwcQgKrGSVajx5hg3DWMEr0TpnJCuFsYZTY+OciexcjJwebgI7ElP2HWUBsEQ
  FJibUrF4G1MwtMYZI4/W0XG0hCWCBE4suvvWBFLAKqEme3/WcGsXkF3CQWdzaA2RICchI3z3V
  CxQUlTs58AlbPLCAhcfDFC7C4kICyxJYVFxgh6hUk1h44zzSBkW8WkpZZSFoWMDKtYjRLKspM
  zyjJTczM0TU0MNA1NDTSNdY1MjTWS6zSTdIrLdZNTSwu0TXUSywv1iuuzE3OSdHLSy3ZxAgM/
  pQC5qs7GOd3pB9ilORgUhLlLVA/GS3El5SfUpmRWJwRX1Sak1p8iFGGg0NJgpfvC1BOsCg1Pb
  UiLTMHGIcwaQkOHiUR3imfgdK8xQWJucWZ6RCpU4y6HG1Pr89gFmLJy89LlRLntQWZIQBSlFG
  aBzcClhIuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLm/QayiiczrwRu0yugI5iAjjhhegLk
  iJJEhJRUA+MdNfWGx0XqPGwP9qZ72096lB2Zdm9WCfcvCQuXpeKv30e9e/3/qMR1+7LNWapHd
  Vaf/5LT9+KxyP2SoF+9rK9fyb24pXJ508TsO2YrtwjN+X2tbeoXMZOaROeF15O9E5ff3b/+T1
  qoQdos/o1SWfJOfPsTa97LcF7O8eN4tjdo6v50972rpi5UYinOSDTUYi4qTgQAfzn2sQQDAAA
  =
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-12.tower-385.messagelabs.com!1539962153!919622!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21344 invoked from network); 19 Oct 2018 15:15:53 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-12.tower-385.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Oct 2018 15:15:53 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 19 Oct 2018
 10:15:53 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 19 Oct
 2018 10:15:52 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 19 Oct 2018 17:15:50 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant
Date:   Fri, 19 Oct 2018 17:15:40 +0200
Message-ID: <1539962141-32418-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wireless variants of the ConnecCore 6UL SOM include a Qualcomm
QCA6564 wireless chip with dual WiFi and Bluetooth.

The QCA6564 uses the out-of-tree driver at:
https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qcacld-2.0/

Blueooth uses the HCI H4 UART driver.

Alex Gonzalez (1):
  ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant

 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 65 +++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

