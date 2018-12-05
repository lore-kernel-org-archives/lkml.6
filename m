Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6494C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4D520850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="aX7f5RAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4D520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeLEIYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:24:18 -0500
Received: from mail-eopbgr1410120.outbound.protection.outlook.com ([40.107.141.120]:28320
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeLEIYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO2mwXftCUJLbQE1RQXJmIx1++lOIUi0bjpXIcHs7DY=;
 b=aX7f5RAydMY6RQqABUrwc6g2yNG6ihHIftEF6dCvOsE4Cn/vJ0a7MxkMw7V6r+avcWui17EXEflXSDFskhCJA47GWatGa9vv7+9KMDGG9hwNF040BY7FGYSvAcjaJqd4jmVgOhzFh7SqVtoGa9DlBbJkn5kdczfDSYO+Pj9Xwww=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB4094.jpnprd01.prod.outlook.com (20.178.140.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:24:14 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:24:14 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] irqchip: irq-renesas-xxx: convert to SPDX identifiers
Thread-Topic: [PATCH 0/2] irqchip: irq-renesas-xxx: convert to SPDX
 identifiers
Thread-Index: AQHUjHPoIV/t23sItUOBl/4pDblIbA==
Date:   Wed, 5 Dec 2018 08:24:14 +0000
Message-ID: <87zhtkbdar.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::18) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB4094;20:G/da3k9AdgdqG4dKspo1/Ya8T1IIaw5c1yCz9xk1vQNH9WSQAI/2xg0afojwurz77Vy4AmBuXjlkOr7+s5TTT/OFcX73wMhGRYZuyuT+d90NAFUKt3dZYFVkaEGtTPLJkioGk48ERU+H/wthPurAwaMA4XAOtoB+on2HL4mPsYg=
x-ms-office365-filtering-correlation-id: 47ecf77f-3546-4d22-cefb-08d65a8b0a4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB4094;
x-ms-traffictypediagnostic: TYAPR01MB4094:
x-microsoft-antispam-prvs: <TYAPR01MB40945CBCB96311CE190C8882D4A80@TYAPR01MB4094.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB4094;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB4094;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(71200400001)(81156014)(6116002)(81166006)(105586002)(106356001)(8676002)(478600001)(486006)(476003)(68736007)(256004)(6436002)(2616005)(6486002)(86362001)(71190400001)(8936002)(25786009)(3846002)(6512007)(102836004)(66066001)(386003)(99286004)(2906002)(53936002)(5660300001)(305945005)(7736002)(6506007)(316002)(36756003)(110136005)(26005)(4326008)(186003)(97736004)(52116002)(14454004)(13513002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4094;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1ziLjFCNGFk2eaMBgNljU8BTliARd6o+LsHQ55g1wEHsVYkTD4QP7JjInWJeX+pT4dIuqKyGJFJ+CIbxj7vOzMhO9phrgpaw52URlDFKv+yf2l79SrTj0qXNdcESAX79WvoVDE25MS/tgBy3H/g5v95mdfGhr65qq3uxDpOSvBR/KYccViNqSnmkR+62Ejn7qp+QmYj0nHRSQTkHtxKEDP3kGGRy6CbEFrV8uYIRlnN4SnDPO0S6f679mUiPC+4e8TrCwKJyGZQv9fcK/O61nukt+qn+0GtwTNp6lyQv/TGybcXPgaw6Sf7BfwBQBDeZDksaxTRIsVE9r443N5CvNJSXBAHmdhh5IwCAIxG6CFY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B698748451F624EB0559C87A781094E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ecf77f-3546-4d22-cefb-08d65a8b0a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:24:14.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas, Jason, Marc

I have posted these with confusable Subject before.
I re-post these with correct Subject

Kuninori Morimoto (2):
  irqchip: irq-renesas-irqc: convert to SPDX identifiers
  irqchip: irq-renesas-intc-irqpin: convert to SPDX identifiers

 drivers/irqchip/irq-renesas-intc-irqpin.c | 14 +-------------
 drivers/irqchip/irq-renesas-irqc.c        | 14 +-------------
 2 files changed, 2 insertions(+), 26 deletions(-)

--=20
2.7.4



Best regards
---
Kuninori Morimoto
