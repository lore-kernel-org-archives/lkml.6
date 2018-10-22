Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A81ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2058320658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2058320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeJVRpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:45:23 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.6]:9720 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbeJVRpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:45:22 -0400
Received: from [67.219.250.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.us-west-2.aws.symcld.net id 78/60-12668-5089DCB5; Mon, 22 Oct 2018 09:27:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRWlGSWpSXmKPExsXi5LtOQJdlxtl
  og2/91hbzj5xjtdi4+TaLxaqpO1ksNj2+xmrR9Wsls8XlXXPYLJZev8hk0br3CLvF3+2bWCxe
  bBF34PJYM28No8emVZ1sHpuX1HtsfLeDyaP/r4HH501yAWxRrJl5SfkVCawZ+/Y8YSr4yVLRv
  fszYwPjGpYuRi4OIYHVjBKXO/czQThrGCXeT2lmhXC2MEp8uH6VrYuRk4NNQEdiyv7DLCC2iI
  CkxNqVi5hBipgFpjBJnP62C6xIWCBcomPPGaBRHBwsAqoS7dstQMK8Am4Suz92gfVKCMhJ3Dz
  XyQwRF5Q4OfMJWJxZQELi4IsXYHEhAWWJLSsuMELUK0isPXCeaQIj3ywkLbOQtCxgZFrFaJ5U
  lJmeUZKbmJmja2hgoGtoaKRraGyga2Gsl1ilm6hXWqxbnlpcomukl1herFdcmZuck6KXl1qyi
  REY/CkFTcE7GC8sTz/EKMnBpCTKm2h8OlqILyk/pTIjsTgjvqg0J7X4EKMMB4eSBG/G9LPRQo
  JFqempFWmZOcA4hElLcPAoifD6gKR5iwsSc4sz0yFSpxh1OdqeXp/BLMSSl5+XKiXO6w9SJAB
  SlFGaBzcClhIuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmVQKZwpOZVwK36RXQEUxAR1xX
  PwNyREkiQkqqgVFMpefYnqNXr7LWrCtbzZ32drbnTx1nMS2j6Gy+iH7f+OMn3xqVtG9Zsu3Q7
  cZzG9of2rnM3nSq+W3TFOc20X9aPSYly8/c9v/+b07NlNN3/tmqsE63OJDz7pQkw/wfPtdF3v
  L/j13DZcY1y0TNw/FkeFu0lvxig939/cFFDzalzwjff/nExnAlluKMREMt5qLiRAAk26+WBAM
  AAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-11.tower-325.messagelabs.com!1540200451!1051007!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2177 invoked from network); 22 Oct 2018 09:27:32 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-11.tower-325.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Oct 2018 09:27:32 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 22 Oct 2018
 04:27:31 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 22 Oct
 2018 04:27:31 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Oct 2018 11:27:29 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v1] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant
Date:   Mon, 22 Oct 2018 11:27:22 +0200
Message-ID: <1540200443-24773-1-git-send-email-alex.gonzalez@digi.com>
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

Changes since [1]:
* Removed extra new line

[1] https://lore.kernel.org/lkml/1539962141-32418-2-git-send-email-alex.gonzalez@digi.com/

Alex Gonzalez (1):
  ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant

 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

