Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F26C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655B22086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="eSU/iHcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfBUKmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:42:05 -0500
Received: from mailout.micron.com ([137.201.242.129]:14514 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:42:05 -0500
Received: from mail.micron.com (boexchangeum.micron.com [137.201.21.209])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x1LAfaA6028750;
        Thu, 21 Feb 2019 03:41:36 -0700
Received: from bowex17e.micron.com (137.201.21.213) by bowex17a.micron.com
 (137.201.21.209) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Thu, 21 Feb
 2019 03:41:36 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (137.201.20.7) by
 bowex17e.micron.com (137.201.21.213) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Thu, 21 Feb 2019 03:41:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vvLVxi3yAWa/MW6aN8aFy45a+kqCegpF2Ol75yOHTM=;
 b=eSU/iHcLiK+HqnURKZq0Bv2MyzT8fQxrP1qbg2QiEwsN6yMdfCpGbmeCeq89HvGDsfFupCW3HVoDu1JrAznubyE1C9YQbwPLPyY5XTgV8W6u7N7SbOS+YrWOe77/twRik92uz9KGUvdFZ1okNkYoU4kIV6VezS82KpeiGMCts4Q=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB5493.namprd08.prod.outlook.com (20.178.48.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 10:41:34 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%3]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 10:41:34 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Vignesh R <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: RE: [EXT] [PATCH v6 2/2] mtd: spi-nor: cadence-quadspi: Add support
 for Octal SPI controller
Thread-Topic: [EXT] [PATCH v6 2/2] mtd: spi-nor: cadence-quadspi: Add support
 for Octal SPI controller
Thread-Index: AQHUwq5RYJ1TJnt3OUGbuG3DxMNL2aXqHBqg
Date:   Thu, 21 Feb 2019 10:41:33 +0000
Message-ID: <BYAPR08MB453362F4253ADA149D05315FDB7E0@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <20190212083809.6534-1-vigneshr@ti.com>
 <20190212083809.6534-3-vigneshr@ti.com>
In-Reply-To: <20190212083809.6534-3-vigneshr@ti.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d67ad6c-a2b9-4f02-c4ee-08d697e92617
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB5493;
x-ms-traffictypediagnostic: BYAPR08MB5493:|BYAPR08MB5493:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR08MB5493;23:anmj4Gqj1V4v9QUeP7rgf2E3vnJAjRcHCOHarYoSu?=
 =?us-ascii?Q?t85Bp0bKszIa2hR139k0QbTxAaWHN5sdovuwEkzJWRtvH0j6ji/hI6VKVT0P?=
 =?us-ascii?Q?MCpix63cvMqpmbhov8YQBEIRWkC9Gv7K+hH7Tk6CHHCcnAYPrNJuglQEbrJu?=
 =?us-ascii?Q?TeGx7GEcShOQbzdrc+qjhjtJh7irHpmOKksP8nHr6G7NesK6OwXwSqMZrmYi?=
 =?us-ascii?Q?6bqJT/dMrY0IleheWzgpcXzYUTPGnZ5aU7ncXekR5WqT+YMHwXpdVJfbLb9n?=
 =?us-ascii?Q?ji64YnNr1ggbPLLjX69wD6NN8Uv3fsVq3CEfEQrNkPDBe7RRY3VidJCxb48C?=
 =?us-ascii?Q?1FSYFP/9f0yl/sgLWZ/R2ceO9+r58XfFonPwZEHzFX4SjnhRxboEnXeAUau5?=
 =?us-ascii?Q?tJu9nwyaOn1oVm5f3aOd/bwJAQMHU6WdUxsBHHcGalLXXNTAhk9PExxYHiqV?=
 =?us-ascii?Q?8M1h13OaqgBFODWeKPUybSoAWZb1sKak+4YndSTiiinMVoXY6bNlkXs7cB+J?=
 =?us-ascii?Q?5Hux2PanO47KEtSkyo4TkNqwwFky6NszgD3lRggtigBzU+TnR4Wk95rxL5R0?=
 =?us-ascii?Q?cfOpLokkbLqbO606HTJH+lifLAIXLpVzi4fNogs5JALxFf4AGSQe+ZOz0nCn?=
 =?us-ascii?Q?OyJ/iIFdcZ8+uIzFUQKqGTWnkqY53qkvsCao0Ei+OMHp69VmqdsgpmQTzO9A?=
 =?us-ascii?Q?r+b41U3AJRwbmS9AXZzKBzWNMmlMGXxXdJIFgmKL07yJnFtA82I3apCYDXDU?=
 =?us-ascii?Q?zwrWh2M2ukDpnhnTKyMHw8+9wiBfokaSIvgRQjk9KDFGCO9t7NSvbVmSrcnt?=
 =?us-ascii?Q?rmS/rQLF9+Frs8820A2xNwPDPg2pPMKrLJR+ubiGlzu7pwoANy51C740HQKq?=
 =?us-ascii?Q?+j1vXddgO20F/40VOtP+UMMyX2Z8bNkOHM+7irTNsyGdmOxpHYpCK6NGQS3i?=
 =?us-ascii?Q?AhzCYSeISvlvr77OO9PhEwrzx6XMceNr6MzV/x7bq9zmGxk1kl8K8IT2rCaw?=
 =?us-ascii?Q?OJS/3y32YC63T+NpEaVlzru2cC1FSoTqyunfb+y/v+pb08TkWq8qK/lFAn3x?=
 =?us-ascii?Q?gEu7mW1t3xscMPU0liSiyOCvmcMHz8FGfwfBzoGOkpXEG58NXxYd9dL1BEgR?=
 =?us-ascii?Q?gzYX3Jdyl38ALKRvBn9Qd5eum3E5h+Xzu2WDxhOb343RRME/xZTO713hruXa?=
 =?us-ascii?Q?ASMMQzVAXDU9Lyjvksy6QPD9NESft/zPA+Tt7kudRe6qRVU0uXxrFhhja8ZO?=
 =?us-ascii?Q?7O5wJ9Vv6/2rwKKXJm5nsLPN9UW7OYAwzBjh7RS?=
x-microsoft-antispam-prvs: <BYAPR08MB5493DE6BEADDD7350A3FE91BDB7E0@BYAPR08MB5493.namprd08.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(110136005)(86362001)(7736002)(74316002)(26005)(99286004)(11346002)(2906002)(102836004)(486006)(54906003)(6116002)(316002)(476003)(81156014)(8936002)(81166006)(25786009)(4326008)(8676002)(305945005)(446003)(76176011)(7696005)(33656002)(55016002)(105586002)(256004)(106356001)(53936002)(55236004)(6246003)(186003)(5660300002)(68736007)(4744005)(9686003)(478600001)(6306002)(229853002)(71200400001)(71190400001)(3846002)(97736004)(14454004)(66066001)(2501003)(6506007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB5493;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7+uEW2YZiRMVNtpOTDgppal68y7jxnTw+mbbGZCU46Wk9bkkfnif7jE4jHmzkwh38vnVK2av3plftTQxN2MtTioz4cC+cX8HY0sBU7+1loRdMYpuY8Y0axFTUk9F6Pzy4gPCv4UK7781Y7M0ZEkp8m70Wg0CCIhx34IBlk1nbMtwtSU4aDFH4hDwB+B4iQWLCfwv4wmWRdQjN4q0gW/5P9YBQ9PJrHZvZMIeBAJAByRw4Sz6jF2gZV9wKdpgVts8i000V8KO6Wwpkde8bqA3OWAbsW4zf+te15JKHoFdxWUV6NykNoXCSBKeHV8i4Nw1UdxfQFKCT/2BwQ/3XJU/0M/tJ2lGbmom+DJwnciUgEq+emqhUI/DXP8fsVljByrUq9MYm0SAeyiugpX3i4q0QH5qO3KpBU1v6sO35YbOorM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d67ad6c-a2b9-4f02-c4ee-08d697e92617
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 10:41:34.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5493
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24444.005
X-TM-AS-Result: No--1.971100-0.000000-31
X-TM-AS-MatchedID: 150567-139010-704318-703529-704171-708060-702020-702898-7
        80016-700648-710970-701249-139704-700047-148004-148007-148020-148050-10019-
        20020-41000-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vignesh

>
>Cadence OSPI controller IP supports Octal IO (x8 IO lines), It also has an
>integrated PHY. IP register layout is very similar to existing QSPI IP exc=
ept for
>additional bits to support Octal and Octal DDR mode. Therefore, extend
>current driver to support Octal mode. Only Octal SDR read (1-1-8)mode is
>supported for now.

Does this your Cadence OSPI controller support 8-8-8 IO mode, if yes,
Why not directly enable 8-8-8 mode?=20

>Tested with mt35xu512aba Octal flash on TI's AM654 EVM.
>
>Signed-off-by: Vignesh R <vigneshr@ti.com>
>______________________________________________________
>Linux MTD discussion mailing list
>http://lists.infradead.org/mailman/listinfo/linux-mtd/
