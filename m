Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2317CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="pbxeqX0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfBYTIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:08:34 -0500
Received: from mail-eopbgr720117.outbound.protection.outlook.com ([40.107.72.117]:46832
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbfBYTId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isDmD2AuRxpmKkpzZXYdccacVx5tnYurFmCuWKD4waY=;
 b=pbxeqX0YD6RIRf0VhKgi0UprjJR49ndjE/fPXrLbuskgc2oi4+nr2DIA1Y2XbCyehM5j6hY1DXoHvwjfvAdHOZXZT5+CiFjbRff1XOYZ+AzfB6bhtYbgtJIwvQLcsImNbXQu4jVP/+IHaXtr4ThZWmNF8v2D5BV66BCVZ0rPTZ8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1343.namprd22.prod.outlook.com (10.174.162.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 19:08:30 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 19:08:30 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] MIPS: SGI-IP27: get rid of volatile and hubreg_t
Thread-Topic: [PATCH v2 01/10] MIPS: SGI-IP27: get rid of volatile and
 hubreg_t
Thread-Index: AQHUyiup1kJEaqrTL0OABUZFVWcA2KXw5qSA
Date:   Mon, 25 Feb 2019 19:08:30 +0000
Message-ID: <MWHPR2201MB1277A7245CF82C72050BC984C17A0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190219155728.19163-2-tbogendoerfer@suse.de>
In-Reply-To: <20190219155728.19163-2-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9b9c5a7-26ce-4c9b-6f7f-08d69b54a126
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1343;
x-ms-traffictypediagnostic: MWHPR2201MB1343:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1343;23:9sdO9w4pDifNJyS2f/e5wcz7GyFG24QL3ARru?=
 =?iso-8859-1?Q?c5j8RQa+IHOmD22dPp6r3hT2X2W2rfcrDSS3nZW36JzhS869J/I0OzNo/q?=
 =?iso-8859-1?Q?Q4oxtRYXLUW+20R+BnJoQCagYBPbjpLdMT17rVlk3FyJqRnkvV0ytSQDSD?=
 =?iso-8859-1?Q?wqgYkmaPgWPR4tvEftYNwA67o6u0vTBC0XCa2sAkUWjrZzuzRSB1D+qlP5?=
 =?iso-8859-1?Q?pQfORPOdk8T6Pdw+Tp+9KcQxY/9b1wx0edACE/zHOTW1xWySi+hcFZFqdJ?=
 =?iso-8859-1?Q?JNh5CNPw+B6qIwPMMFTax+1KkONfKReU8PccmEl7kmo8juWHwjMWZKaJUm?=
 =?iso-8859-1?Q?CtRuXyl4WfcOQLi1uCHRmOrv3CXJXhDHiIN1mgJ1jgLIK+k1qffvJujG2f?=
 =?iso-8859-1?Q?XGCuBNpjozeouopQD6pu2BuyryqG+RiytYiJaJAx2M8OGL00cMhE1mBlGg?=
 =?iso-8859-1?Q?em+jn9mMClLupRBKyTExj8avhTedPaTthy2Zm9rUBiMERPoNowH3PUMEoh?=
 =?iso-8859-1?Q?ULtErxIZjD45aFf8HiPHLSplhVU96BR8VWPrZzGPj+4wV32WJ9fh3AEbpV?=
 =?iso-8859-1?Q?rtsylEsl2R0QhDvXUZVicRtPUh3QWy7LPJy2+MUbWrO+xsEFNtxzS2YquZ?=
 =?iso-8859-1?Q?5J2IGI1NPNfj3UfO0XCDvt8PniOcLC0odgrfM5Bm1qh8eucL5rn8VhVS4u?=
 =?iso-8859-1?Q?X8XkF2l0fAsImpcdohQvdiuqZadt6Wa2/rEFYUfmAGJsMDDlNJH+7OwWD3?=
 =?iso-8859-1?Q?3NRwBGjH3eyc1gTZIyfmNz4ryPqieBAY4yHmyo9mvdhY2N+w09XD6yJ3/o?=
 =?iso-8859-1?Q?9MZcvzv5bN29E5YxpsU1wT3XX9vbpNdy7KxoGQ0toAGu6k3IPzuYFVmLSK?=
 =?iso-8859-1?Q?TqMZ6urfVwm1q9nSj1EDFs2URzrBU4rx4/u39Md7Dg9nH3L/ZJZoeXnktu?=
 =?iso-8859-1?Q?xRrp33LcPJDTEcfEEKMq7fQVMKNHsHcSlbyv7QseDy8zuGRMxqzKH09HIJ?=
 =?iso-8859-1?Q?Dq97Eo+pnurOmw2wVOXlajD4iiEg3CTDB0tYNTJx8xEBdBYDt4YiN34cjn?=
 =?iso-8859-1?Q?Z63iRwmWsRAh5L/9Nktnt510UNSgQK5wmx24J/VWcrZu2JCJlwyKn1QvdV?=
 =?iso-8859-1?Q?T1YdpPYU3QY2BvKlFbP3pVaHvkmYGjoUnNRs2aQRlcISDGgWQzAkin0CMU?=
 =?iso-8859-1?Q?yeRAD1/tC2V5CC+1o5+xmFJ0iJlncLaKiHSYl9RR9zRP4z7lbl3MkwzyRr?=
 =?iso-8859-1?Q?dKECzBhcCbsf1LwBrRXzyB9dU5LEkYgcqJhMLhHtuCNNtk4O7JarEHtxRy?=
 =?iso-8859-1?Q?goHBc1Qoaxk4cF9diAjM0oyRHQzcF6/gIIED03sdIhDvd2L1vSHadUD9VQ?=
 =?iso-8859-1?Q?G1Rs5GDFlIeyqf7Vr3UfLaOUReLCstl?=
x-microsoft-antispam-prvs: <MWHPR2201MB1343F0A568418443A98162A6C17A0@MWHPR2201MB1343.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39840400004)(199004)(189003)(316002)(33656002)(26005)(6916009)(71190400001)(71200400001)(52116002)(256004)(42882007)(54906003)(55016002)(2906002)(76176011)(99286004)(7696005)(9686003)(6116002)(3846002)(14444005)(186003)(7736002)(305945005)(102836004)(44832011)(386003)(6506007)(74316002)(486006)(11346002)(476003)(53936002)(446003)(8676002)(106356001)(8936002)(81156014)(81166006)(6246003)(105586002)(66066001)(4744005)(68736007)(25786009)(4326008)(97736004)(229853002)(14454004)(5660300002)(478600001)(52536013)(6436002)(26583001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1343;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nBGZ9Z5SoECgeyUCWMX6/AQrJ82XLjcJSno3PXfoOJEIlmQ4A5oDZGMD2WVsPHFCzl9bte6YAjkcZ09VyMOVvZ0TEg65iNPV2huHqX+EGZnwrD31XH5YmHECMb/sOCm0n9TMOCu3l9dP2K5qtYWo9rrdI0/42UMslGOEY53w9Kv1psFuhMrImsI82KPjiGn5olgJJNmERToPhuDqc17Z7yuMAMLVBj9Xb6eihgDKamHCbVRK1Jy3FFnSk3WZC7zsIGvak0AhgtNy0tIBQkCjuFRwD9w3NwfBMH/P9XlMHx5k6z2RT3UpFho4flE9GqOYW9kt+D5WDKf24hImx/ez9Y2Lx+FdkEsqXluGek7vAljfX3OY3ho+FYBdUcBXw7LDzkuJmdy0CneTchmKtz5aqHjiMDn9c1yT7aoFpko9PSY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b9c5a7-26ce-4c9b-6f7f-08d69b54a126
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 19:08:30.1551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> Replace hub register access with __raw_readq/__raw_writeq and get
> rid of hubreg_t completely. Also remove no longer (probably never
> used) used defines
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
