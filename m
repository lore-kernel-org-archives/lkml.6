Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC12ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486D32098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F302ZPoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486D32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJROvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:51:31 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:18656
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbeJROva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seu7WKx/TXcNXfABpTVDD2PtPH9hjuUGTFUaA5ph6Ng=;
 b=F302ZPoOZ8UDcZ4VIZCHpk9tWo9VG+/2iKfrMSFLzAv90I5xCrf+3KOYqBmv7C2Q3ba0IWO2DoNvzaTXAMlE2o/HsLgUt5vgyxSwJJnTlzMQlBU3z9RWnZyOd91f5qj6V46zCvpTV6g4UdwCiw2ThfKZd0YfgIyP8k9fuu7eEBY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3740.eurprd04.prod.outlook.com (52.134.71.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Thu, 18 Oct 2018 06:51:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4%3]) with mapi id 15.20.1250.020; Thu, 18 Oct 2018
 06:51:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clk: imx7d: remove UART1 clock setting
Thread-Topic: [PATCH] clk: imx7d: remove UART1 clock setting
Thread-Index: AQHUZq8OK3Qq5gki5E+U9C5YAVb4Lw==
Date:   Thu, 18 Oct 2018 06:51:55 +0000
Message-ID: <1539845238-24114-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:203:72::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3740;6:yVD9X2k+CXpT3TfViodBY21V1BUXJ1omn2A5l5tQjmTFsE3kVAM/vJfE3LITb7aPW8RX3D52a4XkMgtMIZKMzLCvxPXf6bKq+nGV/kRlmC+DgKCTIusPeLxT33yXKMbDJoxvbiEduK7C7fntom20SdUg2aW3YuhqzRjrr3pQIAx+NqI5w8u75zE1anYZZoP5S16J+RvgVgYxBH5BaR/7/NR7qLpn/tpw/yM4y/m4bwCMDmsgBra21QJEb2N/gj8QfLnSx7EL/cCuwDACcaG10JWero27sBsAei3rbpW0i0WTOv8+V0o22q6cBudqBuF4IN9UQA0JBgwJvmg3K9PEHL05OVFFloE+mII98isM2BQtfTXX657OIroB3yfM8VA0h2iZVg0hpwQ40ZopFc8KzFH8aJvgah0EwfzneSg2z1mzZ5Ec5YauwZ8Cww4d8DAwXHIkLXvEyFYbQCyh8pKUsQ==;5:Oo4HHfgOhGH7wgJr8tOtOrmFiqBDa1rNCt6OUFFOdsuVz5aeHz5Re7tcDDKKh5BZzjnzrT5Uw6LfHaRVLSB9rt7IKoNW8J2ui1K9kJpNRkC/HDkymHeYvQ43KRzgjUO676qfWnY9aLDbr/89MfRlb3Y8OVktr7oQXwP7U5XmONI=;7:+EWKQOjlN3pxReJkQ5thfuzziL4HRlDWuOIyav6NrPE1lADv+JBc4a6B+YHnORJPyvN6meVztiTvZHMF5MODtPeE9HMnX3tOqDAkeyJdY5zmjGwr+sXV9oKOj0oEpwjxVmzipNyCT5sYmME9ISm49lJikoOuu21CePjV94eNA07vnfjWfcCiDZiOpH7ZnWvo7ttAOC73arMpwgWroYETGw/9pDsSrUBmu/Ar0WVnp1yqhtLtKGkC4t/vfN4PTxXi
x-ms-office365-filtering-correlation-id: f1db07bb-5462-40c2-e626-08d634c63110
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3740;
x-ms-traffictypediagnostic: DB3PR0402MB3740:
x-microsoft-antispam-prvs: <DB3PR0402MB37403CBACCB245451E1EEFDFF5F80@DB3PR0402MB3740.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3740;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3740;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(97736004)(66066001)(2201001)(71190400001)(6436002)(71200400001)(486006)(2501003)(2900100001)(53936002)(476003)(86362001)(508600001)(186003)(7736002)(305945005)(102836004)(6486002)(26005)(5660300001)(1857600001)(110136005)(6116002)(316002)(3846002)(256004)(81156014)(50226002)(81166006)(8676002)(8936002)(4326008)(6506007)(386003)(2906002)(106356001)(2616005)(105586002)(6512007)(5250100002)(36756003)(14454004)(25786009)(99286004)(68736007)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3740;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bdiK5FXC/KkK1wp/7mPLcx9uwUJA7HI9jE+SxtzynzrbNcUYsdduPd1wSIfX7yVeAXK6pUm7ri3AmcgmzIhyv3O4a2H3yym0am6Q6zFlUFWy23ZEAF0uZpCnjOlLTYh1MgSNvovUVVbkqZcyjDRdBIA5AmDOc1m3slXrBuVTemw1yL3Gh9/1R5Q1mr+1QoFAvLcn65gNuYsESTvebPfxAWfOPP+3KS/dV6YZBL2ChwTzwraDLRac3Gs/uyWZxORXyB2Us4vb9NoVoeh0oSgI8eoVnUO/4PIHLUvuoprSS7Ty3yg2Vp/2Mzi2G9rvf5HiFMlP3Xo/A/e3rJ0x2zGuRgQ+wP5YNIemDjs0jpQD1jk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1db07bb-5462-40c2-e626-08d634c63110
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 06:51:55.6020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is clock assignment in dtb for UART1, so setting
UART1 clock in clock driver is NOT necessary.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index adb08f6..06c105d 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -886,9 +886,6 @@ static void __init imx7d_clocks_init(struct device_node=
 *ccm_node)
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter fr=
eq */
 	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
=20
-	/* set uart module clock's parent clock source that must be great then 80=
MHz */
-	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
-
 	/* Set clock rate for USBPHY, the USB_PLL at CCM is from USBOTG2 */
 	clks[IMX7D_USB1_MAIN_480M_CLK] =3D imx_clk_fixed_factor("pll_usb1_main_cl=
k", "osc", 20, 1);
 	clks[IMX7D_USB_MAIN_480M_CLK] =3D imx_clk_fixed_factor("pll_usb_main_clk"=
, "osc", 20, 1);
--=20
2.7.4

