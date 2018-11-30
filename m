Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AFCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02C42081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v9XLgoq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02C42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeK3RkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:40:06 -0500
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:54272
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbeK3RkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu/qb46ekv56Q+RDPZJlJ71X/sRzl6D9D51RJDz1Pw8=;
 b=v9XLgoq43sj3LSycI1U5p5/rhl7BjbUOQ+V9qh1gZj8dN0wMcLWCCHwn3gd8S9VUP+8H+2lagLiRILzz2Z92RGE6torUEjrArT1+IeF9UD/OQbrw3tA6Lrjt3I3iG+cb5TT/tj07hz9n/eCFn8K++Nzq99HrjyCKnB8+thS4D9E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3740.eurprd04.prod.outlook.com (52.134.71.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 30 Nov 2018 06:31:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 06:31:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "clement.peron@devialet.com" <clement.peron@devialet.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clk: imx6q: add DCICx clocks gate
Thread-Topic: [PATCH] clk: imx6q: add DCICx clocks gate
Thread-Index: AQHUiHZayy0bOZrqdkiTFRZiNvil4w==
Date:   Fri, 30 Nov 2018 06:31:40 +0000
Message-ID: <1543559158-2891-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3740;6:7dqeWfKHy1/W8jQjPYdiI4kjWAGhIpTu57a0YK60b0QRzw/VtbeaiirE3GKOtHa355kV7Me0Psf54bDGtgMY2sO4407fVjw0JZZYXMRH07hs6TBaAajJ0lCcStvavwsJEGAiuxNZ04v3vFvD3f4LIpNnjy+N/KYU6VBe/klDMNgg2P7vO9R3ZiTz1sz+vWE2RxghRqhma7tf1G6ohGa/o4bqTSY6Qv6qg2/tVeb4TLomFk10qP4161XtaAOKQGHP0w7/KvvHfImyiDoaLkbvN7QXx/+F3VczvVMq/1CaaAw3MtZh9xqOFolUcDQvofTbi5W5uoTHVz1nQ6+osB00kSifsrp++Isuq0NbIlVoc/UvVL7P5O0UGb2BJJonI1EVIQN/3SYFBU1dRG4pWnzN4VYnSFJPTCfVZTgkT+K/HdnRb7RNOUBWiMXT0XFPKEc/YqVyaiR4Dmyd+6LwnGQVAA==;5:LuiFjVRl7UiQ6azee//O6byNh+/vcFyxvimNVj4MDYgJ3TwIb/Lt4cr/kiA9ju0ye96mjcxWcM2PiLORc51XcB9Hdaie3ZuE3RwnDDWMPgcSneSDNIYTfnZB5JnB4OZeoKPkqaei31F7JYi/0IrgcdG2958ArNcL12jSfbapkfY=;7:kKQHQ9N7GJcbM0S5aoC/5JIzOWO1bQn61zGTKLYKX2KeaPswJl5YPAERTTnGTnEhi707pMFRHtC7PobUNZm0h7qfzaQ2aKlpng9GMOByVjYNcOYs4YuSp6FaNNEWxtZNrUkejg7JJ53w4DZrDs51Vw==
x-ms-office365-filtering-correlation-id: 3dec7e35-b6f8-4f9b-1bcf-08d6568d7c9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3740;
x-ms-traffictypediagnostic: DB3PR0402MB3740:
x-microsoft-antispam-prvs: <DB3PR0402MB3740A9F60AE06ED068C0ACD2F5D30@DB3PR0402MB3740.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3740;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3740;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(486006)(476003)(256004)(81166006)(53936002)(14444005)(81156014)(6512007)(2906002)(5660300001)(97736004)(3846002)(2501003)(68736007)(14454004)(8676002)(71190400001)(71200400001)(26005)(6486002)(6436002)(50226002)(8936002)(2616005)(110136005)(316002)(478600001)(99286004)(86362001)(102836004)(6506007)(186003)(52116002)(2201001)(7736002)(25786009)(305945005)(386003)(575784001)(105586002)(106356001)(66066001)(6116002)(36756003)(4326008)(7416002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3740;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tfC3qwgx3/csFPxlZs6RmK/1GQxW3GY4SsEBChFmwqlQGAoTe+Mujvv9Zsp8brB87zTVxavm9VgKSdOANuET4N7Qpr7UklfFO19IBftzZakjHlsoQe3kJGOuppym+hKQ2LlelTXIba5B/Qs3bkB8ILWTQtZqbIOcAfcdwF75WRnDh1PXpU1f3MnyayogGD4AvJWbcc+KW5rHwb+VXPCT9lWTPoKwHHMifwOhzqkh1/Xy7bGYL1Sc6ZkecwhbiKLv03mhqyuCN0s9xlYoXFFX4aq6RZfrHD4GYwhHfDON1YsI04h7f/9kFHI/j1vGt2MPw+vW8NBQmeP0AG3usWfqcwLrK8FIGC5HujnwSrZcS4I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dec7e35-b6f8-4f9b-1bcf-08d6568d7c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 06:31:40.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6QP/i.MX6Q/i.MX6DL, there are DCIC1/DCIC2 clocks
gate in CCM_CCGR0 register, add them into clock tree for
clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c               | 2 ++
 include/dt-bindings/clock/imx6qdl-clock.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index bbe0c60..31a9d94 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -737,6 +737,8 @@ static void __init imx6q_clocks_init(struct device_node=
 *ccm_node)
 	clk[IMX6QDL_CLK_CAN1_SERIAL]  =3D imx_clk_gate2("can1_serial",   "can_roo=
t",          base + 0x68, 16);
 	clk[IMX6QDL_CLK_CAN2_IPG]     =3D imx_clk_gate2("can2_ipg",      "ipg",  =
             base + 0x68, 18);
 	clk[IMX6QDL_CLK_CAN2_SERIAL]  =3D imx_clk_gate2("can2_serial",   "can_roo=
t",          base + 0x68, 20);
+	clk[IMX6QDL_CLK_DCIC1]        =3D imx_clk_gate2("dcic1",         "ipu1_po=
df",         base + 0x68, 24);
+	clk[IMX6QDL_CLK_DCIC2]        =3D imx_clk_gate2("dcic2",         "ipu2_po=
df",         base + 0x68, 26);
 	clk[IMX6QDL_CLK_ECSPI1]       =3D imx_clk_gate2("ecspi1",        "ecspi_r=
oot",        base + 0x6c, 0);
 	clk[IMX6QDL_CLK_ECSPI2]       =3D imx_clk_gate2("ecspi2",        "ecspi_r=
oot",        base + 0x6c, 2);
 	clk[IMX6QDL_CLK_ECSPI3]       =3D imx_clk_gate2("ecspi3",        "ecspi_r=
oot",        base + 0x6c, 4);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-binding=
s/clock/imx6qdl-clock.h
index 87b068f..b3cef29 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -274,6 +274,8 @@
 #define IMX6QDL_CLK_EPIT1			261
 #define IMX6QDL_CLK_EPIT2			262
 #define IMX6QDL_CLK_MMDC_P0_IPG			263
-#define IMX6QDL_CLK_END				264
+#define IMX6QDL_CLK_DCIC1			264
+#define IMX6QDL_CLK_DCIC2			265
+#define IMX6QDL_CLK_END				266
=20
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
--=20
2.7.4

