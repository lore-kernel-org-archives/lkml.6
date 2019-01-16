Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FF3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DDC20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GMZNpsia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfAPKDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:03:22 -0500
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:55661
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728780AbfAPKDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDa/a6TZbD6vH9SUZ8t2aFiVRhRGEJC/h0YqP9ItD44=;
 b=GMZNpsiagZN1+qnWhw+j+DIQxs/Uy5O/rx1Dt8dwCE59LH2Zxt9fEIP7mqG8JLP1f0qizeLlOJqtfOFDtepT54p97Xb0JLPvk3gsbCvsjIwUS6t8DWM/TTXQ8lZU7Dieot4bwjflCQuCMoEIcAQW/5MpT/4JT14p0ahsSogHUos=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4066.eurprd04.prod.outlook.com (52.134.125.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 10:03:14 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 10:03:14 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: RE: [PATCH v3] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [PATCH v3] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUrX+6iNHNEsNwY0OPyE6azmOAN6WxpjpA
Date:   Wed, 16 Jan 2019 10:03:14 +0000
Message-ID: <AM0PR04MB4211D63E8CEAEB8EF1D9664D80820@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4066;6:2EDKdkbYiWWUOwm53erAWWE4S6fRqf6GgSnSSnihqLl/KXyZ10KHB9OIotXrfX8T3cGqbakkwvYIxxpBxJpU4LphxmKxIicSkuc2UhxOeKQ9LTzmN1wD6HqxggjilxSFUYuO9qH4XzKWmsCN2qsVxzRAWuPLfOHoBP6hHbb9EexeI5eCnwwOI79sY2t/W/bY6TMr8gv80qNdr9fziES5hreYnDgiC5Mg3knGyJo+aHM9ttwlW4Kwj+wHB3QY1kjqhOsafoIXV1ZZ8M13yO19YP2uXT1x9JAASt0ozAhacgYg40NzTl8j8ckoS9aCusksQkAPdQaDXM7D+eAeN846NjU1cPzVOjz0M8QeFrTdD6uwnn2XH2lWKohcyTnmkhNRyGcajHltY2MQFM5zrSY2Yf12a1ReqLHj74f8UU3VHgfwAY+Utp9pU5N5IlmzN44mu+cFzV3FclgtmMKdf3rcUA==;5:hPfw4y4i4fJNdfsnBmMHDajK3pPWbK8q9DtjLXOkDcCfGzAozUH4PjX9kXjgoNizC4BQwAta+PPSs+fL9z49sR+yz4V4ENghPFA0JCVbOLbtGk5EwH+IvO914QiveI71+jKLyvnq71oC8ctfXB236hwUsCRDHlK5QOGJVah94mo7YCtl8wGPIu0SJ5hem4pbJqnYD3LZT5QYx4VXYbpVtQ==;7:Qfso2opAkQpNcElYgqetiO9L7GDDKDo+/kfA0IKvoyv68XVL9tP8xHt6iHn9auhanGt4HOnieN3bz9vytQFos5V5bGfDR3xHaibYLJJBRTo6NYgbRQaSdxfBB/AKMA7dSeFrY40TZLuPoGM/385OtA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1919586a-2c98-425a-3d4a-08d67b99d48d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4066;
x-ms-traffictypediagnostic: AM0PR04MB4066:
x-microsoft-antispam-prvs: <AM0PR04MB40668D8784F36F34A08CF1C580820@AM0PR04MB4066.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(97736004)(74316002)(99286004)(53546011)(6506007)(26005)(186003)(6116002)(102836004)(3846002)(5660300001)(55016002)(76176011)(229853002)(71200400001)(71190400001)(6436002)(8936002)(2906002)(25786009)(476003)(305945005)(7736002)(11346002)(86362001)(446003)(105586002)(14454004)(81156014)(6246003)(8676002)(66066001)(68736007)(33656002)(81166006)(53936002)(110136005)(316002)(4326008)(478600001)(256004)(54906003)(106356001)(4744005)(486006)(2501003)(44832011)(9686003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4066;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: //t3Z5GkL3j/Vz1HVCr1xh7wUMWa0LL+HOhTmtZYy5JhJga6ShzyIICWrOPEkMa6B+XljKvmo96Hybp6+gykoSXgaFcA640Y4PvIIxqGRWZCi5eEXF2Le3U6VX/xxZaygtDTdeFB+MbCUnbeE65ahlingKeDQlmZhV17re9MSbg1qwN9t0bWJ1ZdAIenOwMsTOwICClySr2Ey/HOydFpPY2VhGPcoMEZU5f0DxrBLSwy/fqA0PJkGA0qZMbvlnvTMXHOdNK2t+5AMZ1EilVAopRIuk2+C1P+0Elg2N1GIsVR+NT56hSZ2tDMxxSeUqzR5lKXmNpk5lrZoIwI+60lNF1tedLDyVhtVuB/D6ZI4UpgFdeCKhPSUSJZTxY7S5yDVm5VrbKjmLiaT+uYsKe4LZk8gWUtTSem0luFr8eQxnI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1919586a-2c98-425a-3d4a-08d67b99d48d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 10:03:14.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Abel Vesa
> Sent: Wednesday, January 16, 2019 5:42 PM
> Subject: [PATCH v3] arm64: defconfig: Add i.MX8MQ boot necessary configs
>=20
> Enable all the i.MX8MQ configs necessary to boot.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
