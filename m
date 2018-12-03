Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E35C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AC620881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EPdfuVFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AC620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbeLCFUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:20:20 -0500
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:5296
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbeLCFUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeDWku8nAbBO8EjCDYmGbe09MmohXnWfN6ck3hSKghE=;
 b=EPdfuVFWjsMP8FSVZOir9IqHF1OeEBIDoYuNaWGylzjXzJeV9Cf1rRMMcJOvj+fiKOw2wfk3SYH+htnlcN81Ni7SsCJFOocyhqdoViWPQ8bJkCVI1/BsT68yqkr+ytAjWcr2581Z5frpBF3z54bdq2XuImO07hDO0ZGRLJ4TFMI=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4138.eurprd04.prod.outlook.com (52.135.130.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Mon, 3 Dec 2018 05:20:16 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 05:20:16 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND V2 0/4] ARM: dts: imx: Add flexcan stop mode wake
Thread-Topic: [PATCH RESEND V2 0/4] ARM: dts: imx: Add flexcan stop mode wake
Thread-Index: AQHUisff/FIFl8alIUGJHUeqllbD9Q==
Date:   Mon, 3 Dec 2018 05:20:16 +0000
Message-ID: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4138;6:Xh1UolDrR6ChUqCikew8ErFvNcf6DQczrux6kFDiwSbBUvscZKH0aGRH1qXqLXANe/18Tmw09xb0DFHbzXthB9AkxLRm66x+48ROhT64CJJaUXaFAvI4/4bN6zecW1TFiDf75Hsw6NMbNQWSWiajRXx0nokEYR+xqw9rVKvW5hazPq/9g1xNXH2XW48TcPw5Ai9DIsObji3vQDGqql61/ZVba+vccM+BhAV+5e53jloqbvxGGIcUjOMtRzmEKzsjw9v54ClVfYHzglXfNgdK0CexEMctPr1NM2NbPbKNYFXO13hNv40NA9UDVWxAK1rknqBZWG9pJwvJ8XAP6TQdfsPHHK31bzRysAekXA2ofUCSbEgPABi7Ix2jk//Kumq06466BxdoVGZGSX2yJvp7cHilVqFU5XdKIxyWU5+TQddGZlxGafw2XZGKSLfDSwWfMTBEW/sMQ8FY0J8xYHe8Zw==;5:8TDKB6i/KA458SijZAAdcaxp0mErSHUJVh8ysxCoKEODWYKGyYBGq5vK0h35QcMaTUCKEIJMP30vKt5YT1GUuRgMMRXtWzxgh8zi6F7UXw4zcZmrYRhw+JYOL45u1C0gYES1+yujGMJZPkSlJgVxluUI9qDk0LeI9w22+L57I7c=;7:+Pc7AZEDM81gM15Qp3GK6Ju+3tCzy47lWbePaWZfN1q7hT4pHRAJuPStkTiv37tsHwegIptBRQGSTgYiaVtFcpn8eZjqN7qRSJLeMbgYKRCGoq0btJ1RKLeV3RxCJA28S970202zyln25ZAQ/lcRcQ==
x-ms-office365-filtering-correlation-id: db4700d9-d859-4b1e-57c7-08d658df0222
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4138;
x-ms-traffictypediagnostic: DB7PR04MB4138:
x-microsoft-antispam-prvs: <DB7PR04MB4138D442EEE9BE949840AAF1E6AE0@DB7PR04MB4138.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4138;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4138;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(366004)(189003)(199004)(54534003)(6512007)(2906002)(81156014)(478600001)(8676002)(6486002)(110136005)(14454004)(486006)(81166006)(476003)(2616005)(71190400001)(53936002)(25786009)(6436002)(316002)(68736007)(54906003)(4326008)(50226002)(86362001)(2501003)(186003)(8936002)(66066001)(105586002)(106356001)(7736002)(97736004)(5660300001)(305945005)(14444005)(102836004)(52116002)(99286004)(217873002)(6506007)(386003)(3846002)(6116002)(71200400001)(256004)(26005)(36756003)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4138;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KD/755YGNhZmStBBSce+V6CR0sMUvbv937wSqA78cElTQ6wuNVJp5OFgZMrbyNrWbQCn+idb/8RoJztofGEQmdFdXfzo/xLOXsSFt5cb0qP6T5/FHzooxlFTLsDVnVaYJukFmIkjrA5UZyUZBlfW6piPq/b1aUBhk9U9BWTnTieoMzmS+4x19TJb/rDdgkRqUFCNCaZs+8bmCGwKUjp68kKJb+D0yH9pk25wdo/Rkj08R9tr8bm6Bn/TsxeYjiNSU0+P5Z+xkmJLtnvCMIdcHEFNY69BiH7grdrgsSdrFxAcxGDKOqSX0n8gXx8ez6mXr3curOp8Ck5/qmJmLss/K1A1cpZJt7SFocnd0zkl9I0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4700d9-d859-4b1e-57c7-08d658df0222
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 05:20:16.0333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset intends to add flexcan stop mode wakeup support on IMX6/7 pla=
tforms.

ChangeLog:
V1->V2:
	*update stop mode property(stop-mode -> fsl,stop-mode).

Hi Shawn,
   This property has been merged both flexcan bindings doc and kernel
   driver.

Best Regards,
Joakim Zhang

Aisheng Dong (4):
  ARM: dts: imx6sx: Add flexcan stop mode wakeup support
  ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
  ARM: dts: imx6ul: Add flexcan stop mode wakeup support
  ARM: dts: imx7s: Add flexcan stop mode wakeup support

 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 arch/arm/boot/dts/imx6sx.dtsi  | 2 ++
 arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
 arch/arm/boot/dts/imx7s.dtsi   | 2 ++
 4 files changed, 8 insertions(+)

--=20
2.17.1

