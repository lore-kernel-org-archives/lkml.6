Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0547EC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CAE20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X9lOjne7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CAE20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJXTmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:42:13 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:8085
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbeJXTmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5mvTCqOARAU6f58TpLvaE5wS4RcP8929RRASE1eu/w=;
 b=X9lOjne7NDtvlNEeNDexqyYf1RyIjsraadS1TkpYPLNnXYUYk6yae3BaEnbPls3ppEKPtER8BqU9npzv3uTZUP9kkrnvAlt4zHKAjvWFyUnIS8HQJaXSfb6AFh60dDv666lkfDUiMIlEWrN8Lv8J9B+u/EmWsDuRnlP0lwEOBF0=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4764.eurprd04.prod.outlook.com (20.176.233.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Wed, 24 Oct 2018 11:14:29 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 11:14:29 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V1 0/3] Add flexcan support
Thread-Topic: [PATCH V1 0/3] Add flexcan support
Thread-Index: AQHUa4q7drBYXaR3D0+nbku+REHIkA==
Date:   Wed, 24 Oct 2018 11:14:29 +0000
Message-ID: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0098.apcprd06.prod.outlook.com
 (2603:1096:3:14::24) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4764;6:UnisCjoAHI/NIr+8iwlL9zRZyIJZxPqp4aSuiaSYZK5zYbxDaF7x171GD6BjTLav0y/8f7JP7rFsNkZUa5xX4Z46kTWCC/nKAw9BVqjTqy1sDR0nWR48n7kByphrK9TGswt8NlPbMnu5U3rR1fkMMO0u4QXMJ6eaz63O+CDZ3Ydm5heyRLkzK+OEDq8onKCJ2JWV+nycagATEC7SgdkmDxI/EbO+XmBRURN69UIJk8C09kvfu8rH5/6NW88tNmaS340bUPymNve0GNHqda4Z+/lANsMKD5LXfq1CpYkL3ALiPRqNnAxW/ZLcRxgIV+dF7PGHXvsjZDk44lyaQ5F77NfLbAqXtcxIOI+YUmpc28CvG0tNjvMAHviwXeP8PkLpgiewzvHu3OFFhG2gx0lpZvcSOyodWrC7WrFzqwrzK9pNCacH9phasoso7xbHY6l2xDGhMTGnw8Mh7/8yeyQcyw==;5:wf4+nhfff9UXijHaf//hhioVfba/oxx+QKtVZzAxPE6eLxI1Q7noe9JgR90pbV4V9gCfMV7eSs07vZL4wAyQMXoeS5xTWCeBYrg4RZzftpAp5REl5L1qFDCj4jptCVXvtOr7LD/aZIPjJdtSkgQk1tTb/SAHH4Gr37BQt6EMep4=;7:X60OeWSszIKUp1VQrPz+9y5daGCiSqG/O05rE7xu01cKkT1Oltx+oi2Nm9l/JGgPEfmMiSDM1clhBVMFBKT0UJyVu9easQg+02kg6SQ8e6nZFOr2D4okhCXeCZnzAXRLVpO42IAMeJhZIf8lY2ybcA==
x-ms-office365-filtering-correlation-id: 9f6ba64d-4a92-4e3f-5db1-08d639a1dd55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4764;
x-ms-traffictypediagnostic: DB7PR04MB4764:
x-microsoft-antispam-prvs: <DB7PR04MB476450884DC2C5906A7D93F0E6F60@DB7PR04MB4764.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4764;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4764;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(26005)(8676002)(86362001)(53936002)(6486002)(2906002)(81166006)(81156014)(6512007)(68736007)(5660300001)(14454004)(186003)(25786009)(71190400001)(316002)(8936002)(71200400001)(4326008)(36756003)(486006)(256004)(386003)(6506007)(2900100001)(2616005)(476003)(97736004)(6436002)(99286004)(52116002)(3846002)(305945005)(66066001)(50226002)(6116002)(110136005)(54906003)(2501003)(102836004)(7736002)(1076002)(5250100002)(105586002)(106356001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4764;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0Pmud9N9+DBCpV76gKXNmUzAVTs7SzrzODww1ESjFAmIA4jvjOzB3hoPY+OVtrWX3J78890atpaW4/OWJRa5i3n7+ahQgdQz01t1vSeIH9j0wYUD2WkNk2Wvm/U6VLOBKWzhZrr5f76vRKzE4rhkVOjZON+QdBNKPhtQrreyinYfySMqOXEg7tv4KTHhYdn2Z3JfShb45aou3KZuOkPXBoeRAsagmuOHDTXNTFbhRY7JgD9WsT9B5SkAqnIDLOvfKe+vpM5VgpfjMO18dmGri3BPKd17TWct6qEC9ejZv2qhCFmcLWtijhDxLHOqAC7cQm1AVbgGZM4pw3XcQUag4CVihtC0yDxE1zKMM52LgDM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6ba64d-4a92-4e3f-5db1-08d639a1dd55
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 11:14:29.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series intends to add flexcan support for IMX6 platforms.

Dong Aisheng (3):
  ARM: dts: imx6sx-sdb: Add flexcan support
  ARM: dts: imx6sx-sabreauto: Add flexcan support
  ARM: dts: sabreauto: Add flexcan support

 .../boot/dts/imx6dl-sabreauto-flexcan1.dts    | 19 +++++++
 .../arm/boot/dts/imx6q-sabreauto-flexcan1.dts | 19 +++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi      | 48 ++++++++++++++++
 arch/arm/boot/dts/imx6sx-sabreauto.dts        | 57 +++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb-reva.dts         | 12 ++++
 arch/arm/boot/dts/imx6sx-sdb.dts              |  5 ++
 arch/arm/boot/dts/imx6sx-sdb.dtsi             | 42 ++++++++++++++
 7 files changed, 202 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts

--=20
2.17.1

