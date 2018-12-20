Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A44721741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMVV/XOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeLTI4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:56:35 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:49567
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbeLTI4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiPt1ICpOUSWSrLVgxfupB7bNmf3ucLjQUDr+sqLGbU=;
 b=AMVV/XOQdBT2iKziXtpg+hOzolKDW62VMrzEbjuh873L8w9kxHyop99L8nXqWugHRkCjDlpsx45Z+lLuToIQ+NE/nZ0zNVGF2MPSvYxyS1Uu0a+8gvW/EEAOn50qmZtKbBwb5JyEeoM7P/9gNsUBWQE9kfC3MQSJynmyh8snmto=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3653.eurprd04.prod.outlook.com (52.133.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 08:56:25 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 08:56:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 3/4] defconfig: arm64: add i.MX system controller RTC
 support
Thread-Topic: [PATCH V5 3/4] defconfig: arm64: add i.MX system controller RTC
 support
Thread-Index: AQHUmEHjxu+dVHKVvUqH/OBKM8Rc8Q==
Date:   Thu, 20 Dec 2018 08:56:25 +0000
Message-ID: <1545295872-20169-4-git-send-email-Anson.Huang@nxp.com>
References: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3653;6:Oc5P4iGhWg4/1wAtxwQ/nKg16+Azc3geN/WqPXEmm7fuw+tc/UwO54A1RNNqY5+1laKi/0+zsVxGWgiueU7tw3N419ZxflZJW9tOAXoc7gcqM2jKHMf9nY1nvE9xcy6qoj2Nlx6Ipe+l4kAKnt/OqtEu8LXTX1J6n4Bu7OtgRkOC5HPXm2UsClbRAxtapbYn4sHyhdTroEPd5y7rrjK6Fdw6lkaeTmtQDIPS4d/xbOL/qB7JU7sidltF8ud13huUg0Uv381vn2huKlge9qpQ4zTm4AxB91H3j7n8ZAmB8xyadEHLDgNTvHK8tEG8V34xvYwml9YvO1kTfUc7q3GbOljsecRoZBrXnRSpaIgn9xGCwg1MsWHqd/rPlG9qNozFyBij9cZAc6pLJ39q9xck46s124qe8hahuKJy55EX+gzmH/gO4rrGGJmc+tKIPbiObwlwTFdZilauu13FEcnv3A==;5:B98os/KGCEljKqkd6hxDIY5V8C7R6z7rfhM5ratwsc6Dxn0wk+r1ZsOIom8pqXQOLdw7ypTU/sBEys8jmHR2vbdSrjSqaxOy1QoUYL2F5t7NYbPyx01RSJFmk9Jgkj4KL1o+bOXwZKC1+5VkCQ9dgalT4ZwzqeBdARXMwdm4n38=;7:DvYaLp1BjO7z7Rx1hNg8VSI3eaOy3q0ewNU4tGbpzNE2nPyCAQTxvqFT9dKp2N7wQPfe/mHykgIOnydTD6OCsiKquPERZUB4ST74nbAxfH0/hwQyHhCNZRnu5n5LnJIy1iXKj4kbKMmX5+Mu5gFBRQ==
x-ms-office365-filtering-correlation-id: 9ec5e1a3-8799-48ac-78ab-08d666590542
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3653;
x-ms-traffictypediagnostic: AM6PR0402MB3653:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB36531322908CB4B43863111DF5BF0@AM6PR0402MB3653.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3653;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3653;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(76176011)(102836004)(11346002)(446003)(2616005)(6506007)(14454004)(386003)(478600001)(52116002)(53936002)(2201001)(6512007)(86362001)(25786009)(71200400001)(71190400001)(50226002)(110136005)(4326008)(6436002)(68736007)(6486002)(5660300001)(106356001)(105586002)(305945005)(316002)(66066001)(2501003)(97736004)(7416002)(99286004)(81166006)(81156014)(8936002)(8676002)(7736002)(3846002)(6116002)(2906002)(256004)(6346003)(26005)(476003)(36756003)(486006)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3653;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: Xr5WVSO51yneJWFIbaxUZw4MxWduQz4wT406WuEI9AZOx1QrRYky6V7J2HO8nX7oVI+90rBARWB7V+SjUWJcrei2Oyc+ltYbGmm8VEFINiaw33I5DQTfAWskMzynbDDK9gbg2QYSXeRh3IwtTKfGig2IaR3QyJWgYxvqMsH5bq+V6sr9KP/bAYQvSi8+xgU+Z9HnXZl+m+Uca5WvYv1BwjsFFUc8gfcyVinspkrqPMw99VM68iH6/1KXIjFA5lUx38FwuLq/BdjU10rcCYb4hwNwd45kHZx2UdU5i67iUS6CynmWslZIiapo1q/JnbNv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec5e1a3-8799-48ac-78ab-08d666590542
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 08:56:25.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_RTC_DRV_IMX_SC as module by default.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V4.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d3aa3f7..abd80c5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -572,6 +572,7 @@ CONFIG_RTC_DRV_PL031=3Dy
 CONFIG_RTC_DRV_SUN6I=3Dy
 CONFIG_RTC_DRV_ARMADA38X=3Dy
 CONFIG_RTC_DRV_TEGRA=3Dy
+CONFIG_RTC_DRV_IMX_SC=3Dm
 CONFIG_RTC_DRV_XGENE=3Dy
 CONFIG_DMADEVICES=3Dy
 CONFIG_DMA_BCM2835=3Dm
--=20
2.7.4

