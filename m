Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8C2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0C2214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="opTikQ+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0C2214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbeKUXGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:06:20 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:44352
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728428AbeKUXGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4deHreI/JGMmvAdii/FmbIFP1i3kqBIWmI/sY6Q1FM=;
 b=opTikQ+Y+3oNw94MLMQXDuReRPb1fwLOnpqkB6fh9keBkBZ0aJ5Rmb+DxsokXlEYLSXZQ97IjJwfkdjy4Iol5Wk3PcDlSDZkxmA3G27cL4NFGkXmJOAsgYzjsa0bBw97FpQXjto0Kp2TGUnF5HVUCHwBwymP1ULWv5iR3Myaq8o=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4987.eurprd04.prod.outlook.com (20.176.234.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 12:32:05 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%3]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 12:32:05 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V4 0/1] can: flexcan: add self wakeup support
Thread-Topic: [PATCH V4 0/1] can: flexcan: add self wakeup support
Thread-Index: AQHUgZY2jbX1fwn0/UyjDuG4t3MZig==
Date:   Wed, 21 Nov 2018 12:32:05 +0000
Message-ID: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4987;6:+mJDwjdVdks28hf8yeihZLPky7GzyAOcxQzMmFsLORmL48gIoLIu0j+lssU8eS/pwsDJgOrOFr2qDKaz1GRVKZj/nA6kWH1PTEozeCIEwJD0kAcOdp9kaQl3elAp49P/bFNAbdQDCZ/4x+LATmD/NvW7gJlKo7KFV21893RO+jlUYd3gRrXySK7BtUo1yPApixeB9nXWELr5cm3lTZpto9FD1az523d/mgdp44OqlXDcZzAhBxVCyQlbBbovKcKDkQzz2m0sAcDtORHJCrZuanziJV74BGFYYuCjbvnFhkfbyzl5I9D+DdLd0+KP6MlFMgnBTwr25EDLMd4We2u4Ew+tzWuZm3E4Fk7FrgMhy+1aZeCGiZ1SKVb7mqxcIqc+2KbtVkghRfKKqujFKMCqK2y1ln+oDZTGPG94NsL7qgFPNoupkwKR7qw63UvppqClzGhOy3u2fg7/RimYvFL3/Q==;5:MNP7NrmNNB4AtZZOsVPUyyC/t8HwqrX+3E/CA/JgeNCiSSMtU9W92u3h2DeZsNjLLGfbSfeO/D2J8UgbhBb4JXJDjhRDoWnSo+RLrwcX3fxcpZHwDpyO1ssP065SCLQHKf2eaP/IWBQsz3Z7wIMOorfORQpjqpqJJB954HeoGrU=;7:usilyHRTkySXunnjlHLRqx0agB8MDJ9HT1Jd+ELpBhu9YFj7db2dfZ05223rKc5Yex8oWNGZHwBr/X9OdmGglv8+7CRTxgm5ZOYOVskVgFmqi6+vGBZNR3g01UDyuL8OH4s5ju0iGi3BkB5x+H/H5w==
x-ms-office365-filtering-correlation-id: 37d98503-1a95-4d45-cfb5-08d64fad5844
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4987;
x-ms-traffictypediagnostic: DB7PR04MB4987:
x-microsoft-antispam-prvs: <DB7PR04MB498771DA516B453117D4DD05E6DA0@DB7PR04MB4987.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4987;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4987;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(54534003)(478600001)(99286004)(102836004)(6436002)(14454004)(52116002)(6506007)(486006)(2616005)(3846002)(6116002)(476003)(386003)(6486002)(256004)(14444005)(26005)(106356001)(54906003)(110136005)(86362001)(25786009)(105586002)(66066001)(2900100001)(6512007)(53936002)(5660300001)(81156014)(81166006)(4326008)(186003)(1076002)(2906002)(8676002)(50226002)(305945005)(8936002)(7736002)(316002)(36756003)(97736004)(68736007)(71190400001)(71200400001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4987;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mcFtB6+SPrHI9ebI6NBvh5OKukK4ZZ/FU+j5P2Hzmdc71xvycE1Tplrx8HlOrANDLE9F570DpbK3Tp7qYvpg91ZJi/dY1pyziSsrewbXLdzm/eXMAEbXEvdiaeVZfeN2Sp8LzAec5j9Q/2QW1z/mc1QVu4zI6bmSl8hG1ISQh2hsdQzzeQ7eA3BvxRrqe0fhoOc7eTwjblb12kUjRG8bR0SX+2DkTDUDoWePsYpBcFbsJHnPo8o78VuF6SoSL7X+mU1aCIcvREomhchh2TFnCqnt7hLEeYybZlN3tom3I/dzY7GsB1NhjG3ZUDNoo/j1wATe1G4Jmh0jqfi7JWW6y3Ej1zW+kw1wGxizefPyDeI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d98503-1a95-4d45-cfb5-08d64fad5844
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 12:32:05.5063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch intends to add CAN self wakeup support. The CAN controller can
parse stop mode property from device tree to enable self wakeup feature.

ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
V2->V3:
	*add FLEXCAN_QUIRK_SETUP_STOP_MODE quirk.
	*rename function.
	*fix system can't be wakeuped during suspend.
V3->V4:
	*normalize the code following Aisheng Dong's comments.

Aisheng Dong (1):
  can: flexcan: add self wakeup support

 drivers/net/can/flexcan.c | 163 +++++++++++++++++++++++++++++++++++---
 1 file changed, 154 insertions(+), 9 deletions(-)

--=20
2.17.1

