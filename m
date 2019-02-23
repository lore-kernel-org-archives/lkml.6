Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BE7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACF720684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HN3Ro2I4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfBWIss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:48:48 -0500
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:18401
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfBWIsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhpRYr9lshxkelRrL3AG5iO6RfRXyTmOtsbNzlCy1oU=;
 b=HN3Ro2I4tRdleFYjYml3c2nsIogdrMhnurl63EVDJ8pxjLaVVYXmF/b0TdYCSeE4mCW4VFfpZgtoFO8Moblk6AOTihlWkI+G7VAXlWNSBwMPGW4TgPOQxF9CxGF5bKP+Vw7gbaFfmVOfwNPfV2etLRCablSEkSITulgo/CQENv0=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3855.eurprd04.prod.outlook.com (52.134.16.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Sat, 23 Feb 2019 08:48:43 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%5]) with mapi id 15.20.1643.019; Sat, 23 Feb 2019
 08:48:43 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
Thread-Topic: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
Thread-Index: AQHUy1SUKSv6icZdy0+EHj+pLsN67g==
Date:   Sat, 23 Feb 2019 08:48:42 +0000
Message-ID: <20190223084816.28985-1-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:805:2a::38) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.8.3
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ca718a0-4454-4791-62f7-08d6996bb6ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3855;
x-ms-traffictypediagnostic: VI1PR0402MB3855:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3855;23:lBG2yAqrA3etHF0CmATJGnejqpAtLccIjG7T0?=
 =?iso-8859-1?Q?McYqVnPSak1BWSXXneUNr4sJIh1e97BoIMZlpuWwKGdt+63GB5mXiO+vo0?=
 =?iso-8859-1?Q?Gpq/SQrlHvILZyl1zYRrj5wVo+dvnfj9QWUqSv7rAX9221YoEThPwVGuxZ?=
 =?iso-8859-1?Q?+t+wJCIJareRWQHjAlRnqLNolvaYYvaWVzS1xRJ99xPDYlHjGvpEi6FKl8?=
 =?iso-8859-1?Q?VNDvWqXjZD5PrqTznpuKM9c/h6zRvhUwuPGc5ltI1rdR/c9BKwYvVrU1KQ?=
 =?iso-8859-1?Q?xf9XPhBcYYob00uULM+19tpv8bJfUDs9mcbRnw3SnI8H3UXred/D22IJY2?=
 =?iso-8859-1?Q?KSSXqO/3eFUiJwIdYl/y8CvxjrMvTaNHAqH9g9qlsMePvGH92WOp4aC+ew?=
 =?iso-8859-1?Q?OC1joMhL62NQzKD7nypVLR0GOi41/G8VbTnFXatpcC29lp0RVylDFFaZkA?=
 =?iso-8859-1?Q?gcnadzqsrJeRycVKYPvzjw9CkVkyo8wbXsLR5+2h2TAbqNK3VT564Z7tRY?=
 =?iso-8859-1?Q?j2dQ9l+w7InpS90piAU6sAlXRiblepl0SkaJhA8Q9hhEePXhPf1T69Ir3w?=
 =?iso-8859-1?Q?Yk6Mrlqf70eyLeUjwezz5N4nKRE82oq5eHAyUxr/lQZvuhXzr/tOoJ6aSd?=
 =?iso-8859-1?Q?zX/8fos+SjeGsw0xEF1W4VWrqJFkLhcAIHZ53IOWFuw1pRJL/3AXhd+9qn?=
 =?iso-8859-1?Q?KO5ScvdnwcAibl+NSSmS8HUSFz4doo5hBrldV380LUVDNKNoeT2n1iQCQx?=
 =?iso-8859-1?Q?OBPzL2gSNmDrwJWc1D7SPdtCyxCIUUFVBTlTXG5amtFeSVHcCRvodM5mvb?=
 =?iso-8859-1?Q?E+CGd38Lqc7/x71P6K51AUDah9vKcNflDQpKanpxt0ZfUlMzppH8zc4HY3?=
 =?iso-8859-1?Q?RdTPhen+HsSanDYVNBgDPLPBCsS8ujkYCk41rNRa7eTR/nc24ER2oy9Bsj?=
 =?iso-8859-1?Q?sJS8eWvklXOo4WTU02drRasIkAIBTgA+jn+DbT/AcdAPQw4tIJjQuGj3Zy?=
 =?iso-8859-1?Q?u2f4YmM5ZTo12EddCsYT999tYhcYCQ8x74/7wk+CiYMXeBes3r52MQxPne?=
 =?iso-8859-1?Q?uUeJ+AcWW5HW1mkea4MB+hzS9fmSuUOMqL3aVcnkzCmOSxcu9DR+xEI5XQ?=
 =?iso-8859-1?Q?6XQ8co0nnWGRqO7fR7+cisY2WEh0xTOc5sSIrHJyk/oQw700xoWc/iTpV7?=
 =?iso-8859-1?Q?Jrp7lLBHlvdlALc6gOuUgK0jvqMhiVFPnN+e5Ecw4DPV5Q2dmKwFrMDcbw?=
 =?iso-8859-1?Q?NVY6VFA7pdpkd7pf+Lf7IhG8MDsW5LZBtOYEQkMHA=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB385573F9D930BCE6B8F3BA82E0780@VI1PR0402MB3855.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(486006)(14454004)(50226002)(71190400001)(26005)(44832011)(186003)(2616005)(478600001)(71200400001)(99286004)(52116002)(68736007)(4326008)(102836004)(2906002)(25786009)(476003)(6636002)(6862004)(105586002)(4744005)(6506007)(6436002)(54906003)(386003)(8936002)(3846002)(305945005)(8676002)(37006003)(6486002)(86362001)(5660300002)(106356001)(53936002)(256004)(7736002)(97736004)(6512007)(66066001)(36756003)(316002)(81166006)(6116002)(1076003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3855;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ttl4YY7XognEt/4lpZLMdNXMD0p40PrWO7JR38AxroWYR4d2b/s7O1zOAydJyjz1y1u9yvUFH1XJokNGsS9bVmBkFOB9EcVt65vGJ9tdqYD8IvB+tOKWrw6EjXPQmd9lKBTAciuaLYFIR6L0OXM0eM+TK7eoX8v/XCsF/V2zn4S3l+3LnhslwNXDwaBcYS1WWvC9+PakB2a+o1cwQE7XUsU4s+chwJkJ70M89vubJOSQF0CmoQU6wPTxrehcABH8LUdwjZ9PBZQMhZPdfsWwracbKkP1tcZlQX2Cdfvn9H0PQTR/EOKW2S43+V0t0zgydrqbnLh3/UT1sAap3bBzkxCO9Ys+wUwUVAIA52Sbvq2R3DPYxWTv9Sb3mG3mEgF2K9QOLZc0uxVrtqYP5Ggh/D3QuvcrCEwa0SGnygYxX7E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca718a0-4454-4791-62f7-08d6996bb6ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 08:48:40.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches enable cache stashing and configure the core cluster
destination per software portal while the third patch is the one
configuring the amount of stashing on a queue.

Ioana Ciornei (3):
  soc: fsl: dpio: enable frame data cache stashing per software portal
  soc: fsl: dpio: configure cache stashing destination
  dpaa2-eth: configure the cache stashing amount on a queue

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  7 +++-
 drivers/soc/fsl/Kconfig                          |  1 +
 drivers/soc/fsl/dpio/dpio-cmd.h                  |  5 +++
 drivers/soc/fsl/dpio/dpio-driver.c               | 52 ++++++++++++++++++++=
++++
 drivers/soc/fsl/dpio/dpio.c                      | 16 ++++++++
 drivers/soc/fsl/dpio/dpio.h                      |  5 +++
 drivers/soc/fsl/dpio/qbman-portal.c              |  4 +-
 7 files changed, 87 insertions(+), 3 deletions(-)

--=20
1.9.1

