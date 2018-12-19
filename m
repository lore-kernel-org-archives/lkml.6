Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D736BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775D920874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tO+18lHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeLSIjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:39:02 -0500
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:16906
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbeLSIjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LGkCzI7KvnK1gt4xlnQ+FWgGECzOYzNsYqKLgafjrY=;
 b=tO+18lHLIdErQrBwuaQMqdBbrQcPiNeEYPPjuOX4IyGPmlzXef1WZFEUNlTRN5bqF6CQnOqboNiZFrWX3nWBTyGLVIoVrK/a6BoaBbi8FO70dOOuQORzn40PmoYA+mTbqlbEKwCJRNHrvhLGUVIjXf9eDm8dGm5oZYScj+tJq8o=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4154.eurprd04.prod.outlook.com (52.135.130.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 08:38:57 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9%4]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 08:38:57 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/3] can: flexcan: add imx8qm support
Thread-Topic: [PATCH 0/3] can: flexcan: add imx8qm support
Thread-Index: AQHUl3ZIyDiPbeOVSkuQb8q6fDKkQg==
Date:   Wed, 19 Dec 2018 08:38:57 +0000
Message-ID: <20181219083637.641-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0601CA0014.apcprd06.prod.outlook.com (2603:1096:3::24)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4154;6:koQowi0EpP351T1DLhjmJ2et0eS9ScjhvazZBDQE9AbFzk2Is+Q8Z1LEZ4XKefCxXl2ACtXXGQ9TcBzuFZY1CiEtnxBpPAnmZjs2UlSZLra/iDQd/+JB/CsbNO2tdE+XSGXWHgERZBJVwu36Gz4/4mA19JSGr4dp5t7kQUEk1JQ6/TBdsM2YtV8kJmYGp3aATvhVHTg24qeSrIK6xBnSvUY402APXzQzPz35UO7B8XvpseOaTvyFK4D/L/noHkI88QWpgdFDw4aubFHUuCcwhCgDsfm8OXJ/hppiC5utMVLI0rSsXCILVhOlF1gZDMl6TcX+mhRPPnVf01zq2Hkynv7rGcEcRpQ99XEa0TAk48l+HRM50OulHuNd8lMLSTDzfQE5hZibuSLmZ2sdyxFQ/JMEEO9DvMm+av0WsGKwN1nPtxuJNqj/YGQmfM5uxtcjQroKYBDkCqULR4Ivyjy9BQ==;5:ETL1FbiSLd489F86AzQlrwOotEitp3HZNmeb9DPE4mJM+yYaizbbzQurETIQigBQJWkBnYQI+L4jvsPZpWwAfLuUBtlHiZXniQH2JLCBYkfwCa0+prAdm5pXIgYBTTpczUdFd1j20YCw3JfzmBctOFJ1vlyyWcSSKuG89kzLk14=;7:iNV++cX+KnzYmK7H0LQyVD+euflXES6rcxkmw+G0oeSBHHfTLucNxw5E+2aJ+12R7b2kEvpnbvbXJHp128fXU40ukpChQ5sQGjTbS/d47/6he7TlUtUm2Ih+7q5jOy0KtvfQ0mVxRHGZOR2m/hbhTQ==
x-ms-office365-filtering-correlation-id: b728fd85-246d-453e-91f8-08d6658d6a4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4154;
x-ms-traffictypediagnostic: DB7PR04MB4154:
x-microsoft-antispam-prvs: <DB7PR04MB4154C411FAEA41E64C6E7716E6BE0@DB7PR04MB4154.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4154;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4154;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(7736002)(6116002)(6512007)(8676002)(81156014)(3846002)(2906002)(1076003)(53936002)(71190400001)(71200400001)(5660300001)(110136005)(52116002)(99286004)(316002)(6506007)(386003)(26005)(54906003)(50226002)(8936002)(81166006)(186003)(6486002)(86362001)(102836004)(6436002)(2501003)(97736004)(68736007)(25786009)(66066001)(478600001)(305945005)(4326008)(476003)(105586002)(2616005)(486006)(106356001)(36756003)(14454004)(256004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4154;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eGwTf+lFaHD6jWtVaZY3AppawKmkapj4qOJS1ZoSFH/xpqdE2rT/lrF+czMy/kxQQZWko3tyNgbFbU++hoDD0zVV7Jne55UZRXvoUjt13rWqiBfc68gkukudzY4F0ZQKYvPCiZFVv0IxeLqaaQ8bBJGuXDNBUL4lXUI4rEtz368RaZvfC1/QgWfsxysBT5vBeBrmtgWFec19cMiE3rzN4e6SQiKExOEAPSMMY9xXVMFmoZDD6qyagChemZEmf9qpy6fMaQzvh9yEjA8UpbapZO6fFYe5z27LYk3kga4a9MtKNXDS9WFwtaAiaq6KyIGp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b728fd85-246d-453e-91f8-08d6658d6a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 08:38:57.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set intends to add Flexcan support for i.MX8QM platform which
defaultly supports CAN FD protocol. Although BRS enabled by system reset
when the driver sets CAN FD mode, now this patch serial does not support
BRS in the driver. And then I will send patch to enable BRS by changing the
register to set bit timing.

Dong Aisheng (3):
  can: rx-offload: add CANFD support based on offload
  can: flexcan: add CAN FD mode support
  can: flexcan: add imx8qm support

 drivers/net/can/flexcan.c      | 114 ++++++++++++++++++++++++++++++---
 drivers/net/can/rx-offload.c   |  16 +++--
 include/linux/can/rx-offload.h |   4 +-
 3 files changed, 117 insertions(+), 17 deletions(-)

--=20
2.17.1

