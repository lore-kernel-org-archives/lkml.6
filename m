Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E87C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F77720863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O08eyBrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F77720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408745AbeKWTjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:39:49 -0500
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:38926
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387605AbeKWTjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzXsVs8o/QaFm963UcK09xEtjxMWgFkNmO0hXMVHWLs=;
 b=O08eyBrw82xqWodNov9jP4ZSZiBO+DJYF/FoJg6iU1iiWT4f/A02DGOrTy2rf4fEhsdHfSFzF0GZT4kvyFAZ5+d7gvj7vRw2dJgdzIIv4UjJzn/Da8aXcp6fviBuUvWJDkbRsbWLOI/wOAeyZaFb58xMigZC1Wdp039tXUwcg8U=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5764.eurprd04.prod.outlook.com (20.178.202.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Fri, 23 Nov 2018 08:56:26 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1339.031; Fri, 23 Nov 2018
 08:56:26 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 0/2] can: flexcan: add can self wakeup support
Thread-Topic: [PATCH V6 0/2] can: flexcan: add can self wakeup support
Thread-Index: AQHUgwd6wXBy9Svf4Uuk1UESPmPUk6VdDjFg
Date:   Fri, 23 Nov 2018 08:56:26 +0000
Message-ID: <AM0PR04MB42115E03F6ABAAE1B1C1631480D40@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5764;6:DgVKCcMD53pPwDb/piXte2cWS8btpaHplfImNGy7h8pCAsoKG5ZQMuaYzwJOpEVLZoWR43Tmykl9RtuQVt8D6GDVGetFMsu8I3zgZSzRa51A8clM2DCF3S8D85inD0rYIVnQQL3yHp0lnLxPVZAB393p4RVyDTPt1PvWCXcXjqUnqNwWtx5GyaXmgunkctmE8dR3Se9cqTQdl9EIkd6xAGHAbjUREL+jkA3e8NG+BrXxwlyXhIcoccvD6CFxmE9HrO+EG/kHkKEokQlNm3vk3DcMiVZ1tHUBfUNM9lf59JiegOU4muBfJ0FgIrmIPRU54VClE3PL/RH/LbZHIBZjniZGZ1D363PhofN+p9Zg+/1PG+n8GZ6KF92/n8uVZ6bQqwcVcOkLyx5xRNx+Dhpal/uAxW3G9mPssn1+4RPIElvbrG/iZnhv1gFjed7ZIx4M5HQPMeAXzcanJJGTLVATkg==;5:7hgECqWqrCDXsS4NtRo7tqJ9XeXTQWvClAmLSz6tF5DHInb0ZkM2wtsmDcvTCu8Yl5Wy/JsN6fR+H5joXfQw4HwKWhFdsFezuqANDPNPqUt40ShfnSgwe/sRI9knDq7biBnkR8eYdb4AHFi/0SPto1GhPyGtiRYiTFHFWcMxkcA=;7:9zw4AWIOdg7SAeILVYRNwzUCNCCx8W29UyNUavPQmwt19J7eO+W2SOlFoL8dzUJli7wps1hbwdy+qWcr3YrOsSeorVMifx817i5Y9OtTYYYWTwlJf6iOFy4UYdXpLV3f3BV45hh1zvD/P9tZTHaXKA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7c9e2057-67a1-4059-1c2d-08d651218d27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5764;
x-ms-traffictypediagnostic: AM0PR04MB5764:
x-microsoft-antispam-prvs: <AM0PR04MB5764C6869F88146027A8E07F80D40@AM0PR04MB5764.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5764;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5764;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(366004)(13464003)(189003)(199004)(446003)(110136005)(74316002)(102836004)(54906003)(68736007)(86362001)(9686003)(186003)(26005)(81156014)(81166006)(7736002)(8936002)(305945005)(53936002)(6506007)(53546011)(11346002)(2201001)(6116002)(229853002)(3846002)(486006)(6436002)(14454004)(2906002)(476003)(55016002)(33656002)(2501003)(66066001)(5660300001)(2900100001)(8676002)(478600001)(97736004)(99286004)(71200400001)(7696005)(106356001)(316002)(6246003)(25786009)(105586002)(76176011)(71190400001)(256004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5764;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1HIIJZzEJpiAQi+Z1CkbOAoOn31A8u2vb621xFiXGzojLv7Uj6xrbVRsOUUf7qOSNZvkvOqBOmQ29TtDnwSTAXit6jymbZCu5NXtv7ORe+AmhaVyVLVVNALdlBFyq35NbOgurKDq5Qv9l9kdya6QkcSdyG5LDvRn568Q43uFnuAXy7XEM9suyJMnmTgHHknx5AFijm8j34LaGZ7l8vjniIA0j2xsOlBF54uU4UCH78GjiQHrGFPetZlC3+JraUrlLw1dkrhePd4DdhuNNSE18YX4UDXUNTEXsMQqwkCfGHCgDPGMdK4DNMq5bHiTo2LRWlCXBiFSAuMc/w9jpVfBKMEcgC5O2NRiff39snbmpgc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9e2057-67a1-4059-1c2d-08d651218d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 08:56:26.2487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joakim Zhang
> Sent: Friday, November 23, 2018 4:35 PM
> To: linux-can@vger.kernel.org; mkl@pengutronix.de; robh+dt@kernel.org
> Cc: wg@grandegger.com; mark.rutland@arm.com; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Joakim
> Zhang <qiangqing.zhang@nxp.com>
> Subject: [PATCH V6 0/2] can: flexcan: add can self wakeup support
>=20
> This patch series intends to add CAN self wakeup support. The CAN control=
ler
> can parse "fsl,stop-mode" property from device tree to enable self wakeup
> feature.
>=20

As I'm already authored, this is just to tell this version looks good to me=
.
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

