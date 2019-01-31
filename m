Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43330C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20860218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iNNaCx1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfAaIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:03:40 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:27568
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfAaIDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klJ2GYCzCHxBLG7H+hS3UneMwlpUMVkl6VYssk6RblI=;
 b=iNNaCx1ll4wBq3goqqYtZ9h7A2TM7kYNWy+fjlbGJbCHKbGyWbko/ouTohEmyIOMLqixJXAzzHuFDuSacRB6++4SP79gjA55KVFKgG1FtWzgwn/93JFsMKCc7yUquc82BPqj4tCnUBjiz0BUyF0/JyKxfaUm2Zn+8gQl1wBEfZ0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5298.eurprd04.prod.outlook.com (20.177.42.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 08:03:35 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 08:03:35 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH V3 0/4] irq: imx-irqsteer: add 32 interrupts chan and multi
 outputs support
Thread-Topic: [PATCH V3 0/4] irq: imx-irqsteer: add 32 interrupts chan and
 multi outputs support
Thread-Index: AQHUuTt3gHGMIiTe50SSroR3Hc4rgw==
Date:   Thu, 31 Jan 2019 08:03:35 +0000
Message-ID: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5298;6:KjAuIO60IU9SgG0CkidFCxvpRgIllcvQmrkOsHu4xjRoQK6g2sWIEsqV03R5/jtKmL/YszrCtOfWRh76iknOBzruqBSURdlgXxW2GNiLn3W35wAoRtCzKBSRgF8d/dGdYyxIySNlZRDwX4tx0HPSmV1ojvpeKOZY6hP3Mg1Ntb6GoV34linQbMeXqdHOPNwOg8HIZQzV623C6EluVhlqmz6I7A9xP6CZhnrHa7ALS4vdS9pkf0GGjCwWe3il1qlO4G4u/d0AndIMGI1WcPK+l92PQChTWFCqZ5Pa3lXSwJrgfspWXjY01RjxbzZjsoKutzYjvjxerFi5LJEzYH5pjSQMt96GoCdTSgn3Fs5vRX1z/aDpsnaxlww9dyLt5L80XDgMPlLXtiapfyAZduk9fvAjDPJwdj4MLcCBxtmA4QchPeO75GwC5CQbnFNoBlnBGSQr648L+yFUBfCanaY5sw==;5:aZagzyv9c61FYG1OsZGuvxyRDyuf7247tAu8Dk2VdO7qLwaCfkhIEt5VbK/0EiqRScU33W72eHKezgcoxaoydhv1GuRIpUPeFNk2dPAEVxKOKHz1lx2e5Zl+4+HonJp7sd9J/X6UkoG+5HUCHdbXGa57krPnroPkcQ6TxMWb1YhBGrcwL56gzEHKxPmgR6rMGfNt78W6ib2Pp6HGoSHXgQ==;7:r2h25FlKJQliRUAIhwrA4wEj8LZT1zByxrbPEVl8NQHKL/e7RO7sUaUuPqXc65zfqiRn0PJCnD3mn6Q1uiTwRdh3o5hZqLRsN98yjgW8rJPEp//PE+kYF0ZSCk4cPUOeXdfVoMYDLkm98DmLtejurg==
x-ms-office365-filtering-correlation-id: 325105ba-4dff-4174-9b22-08d68752994b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5298;
x-ms-traffictypediagnostic: AM0PR04MB5298:
x-microsoft-antispam-prvs: <AM0PR04MB5298AFE4BC8EA98C4112553E80910@AM0PR04MB5298.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(189003)(199004)(97736004)(256004)(102836004)(5640700003)(316002)(6486002)(386003)(6506007)(71200400001)(71190400001)(114624004)(2351001)(36756003)(2501003)(4326008)(54906003)(4744005)(2906002)(6512007)(25786009)(6436002)(99286004)(53936002)(86362001)(305945005)(52116002)(81166006)(44832011)(105586002)(8676002)(486006)(3846002)(7736002)(6116002)(81156014)(2616005)(8936002)(476003)(106356001)(50226002)(478600001)(6916009)(14454004)(186003)(68736007)(66066001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5298;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HjohCTGebRUTI360qlsDZZ9iGKKks0EWyb7F2V4/A9uR6v5fuQUj+3aSiR7T2eZsELBx2mj0HLUp5LvNr1ZV/riL2s2UPN4xxwfsy2Yno/4/PSnkrXWrpU0aXQwopbrBnpP+4Xi9R6eBoWzXGKMeBrTMrrrTMYnPorFKIozC6+c5dNq2qniqtqNcJbF+IoC59I9zP8INd7nQsUHMPyf31y+3CflotibRLhaFzFFfLtKJa0V3SBS4bq69RGnTDTgkSGm5kHn+2SFLyEgNH8CdTvP9r5ds8f3tpVrkIfXmSXD0gCxI5xucSjw6r1o08VG9AyFNGE9X+/YiZ1fUnVkncal/WxhSWH728K8+H59kISlOTvQD3bHN+L7ARF1/hxlwyU11wuioRjuR6HXbVuV3Yfl6GzEH17vx3jvwKUDGHB0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325105ba-4dff-4174-9b22-08d68752994b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 08:03:31.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5298
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all 64 interrupts may be used in one group. e.g. most irqsteer in
imx8qxp and imx8qm subsystems supports only 32 interrupts.
And one irqsteer channel can support up to 8 output interrupts.

This patch series aims to support 32 interrupts chan and multi output
interrupts.

Tested on:
iMX8QXP MEK with MIPI CSI capture and DC Display
iMX8MQ EVK with MIPI DSI Display

Dong Aisheng (4):
  dt-binding: irq: imx-irqsteer: use irq number instead of group number
  dt-bindings: irq: imx-irqsteer: add multi output interrupts support
  irq: imx-irqsteer: change to use reg_num instead of irq_group
  irq: imx: irqsteer: add multi output interrupts support

 .../bindings/interrupt-controller/fsl,irqsteer.txt |  11 +-
 drivers/irqchip/irq-imx-irqsteer.c                 | 115 +++++++++++++++--=
----
 2 files changed, 89 insertions(+), 37 deletions(-)

--=20
2.7.4

