Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E442720663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="QfJgZcFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfBYTIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:08:47 -0500
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:32000
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfBYTIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5yn1mO8MWZFHD2Rq6jvr1t7xA0YhkLUBtbmfoe4XJo=;
 b=QfJgZcFSEfHbpcC2jJ69jtbUsq0pjorNqAbRqB1A+VfHmgXXiWoWlZt9+r0WkDAXlA7dOsyInGzgOk20TiD51NLAGk64TiUT5aFpd5q0ocnuPI6ydCjtPPIvie8G4b5u0NtdXOLBtFOzxRxAtiXr6GIBzCNIueyP7NQr/+aB+40=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1343.namprd22.prod.outlook.com (10.174.162.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 19:08:43 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 19:08:43 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: ingenic: Add support for appended devicetree
Thread-Topic: [PATCH v2] MIPS: ingenic: Add support for appended devicetree
Thread-Index: AQHUyjbaT7pzbvBC60eYuTjG+R5/9aXw5pyA
Date:   Mon, 25 Feb 2019 19:08:42 +0000
Message-ID: <MWHPR2201MB12770F268B98909D06D114C8C17A0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190221224310.9507-1-paul@crapouillou.net>
In-Reply-To: <20190221224310.9507-1-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52df6755-63ff-4263-0b15-08d69b54a880
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1343;
x-ms-traffictypediagnostic: MWHPR2201MB1343:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1343;23:RZvJNkx7L3zJEAvPxYhWnvcl4tUaeF18oiFc/?=
 =?iso-8859-1?Q?+MCtGJu3V9odsSqYBBDCfgQ7zMK4KrQzm1XOsMQ6AzbIQnTImazLuZ4Vuw?=
 =?iso-8859-1?Q?88WRn5wH7JyR23+28DLhwc6iKXY+Bp+3xy463WxFzaSI1K0D4Vg7hZSXJT?=
 =?iso-8859-1?Q?kAPeH1XZJUwcFUXP8+2jb0gmpUQcSAvemk6Z4/TEfqEeYErNW+uf0KyADl?=
 =?iso-8859-1?Q?apMBfqnSUi+GZlzXDF/e7eB5UAjGXfRgV4XcHfiiFNVJWtp2WnP+Jy6J9b?=
 =?iso-8859-1?Q?fWkb3XkUB7CxbxSr9ZIwDNCTpVcZsiE+i9pX+fJM8GK6j7JpsfxmpUWC3C?=
 =?iso-8859-1?Q?csHdVrTQXsRnfrBrFFG6dBXXmw/4WDJd4UHHqmiqGe38aHBmEEbVs37nEf?=
 =?iso-8859-1?Q?a5uFzKACSpvMfGI6DEDBSoYqb4rx/r+xkWaBoJTWEVxd3de6joK/KsFWUm?=
 =?iso-8859-1?Q?XCuw1+96xQr2F92+eNbstSL2jTRjsRKxeLUZUHXKbmtns6OknS1z42AfYu?=
 =?iso-8859-1?Q?5UIC5Ort4WM7adT9N5v2gVeHPozrT5odkxQVhNPKOv3zWW9xnf/dlN53UX?=
 =?iso-8859-1?Q?Jo2pTbNm62xnHp7Nz9eJoVQQ+CJsgTYHRc8tqCHAoaojaS9q9hO1vW/lWh?=
 =?iso-8859-1?Q?u1MNUhNnPWHdf2ir9I40Wh3OjQb4/tceEurqU6ROdHkQfH+guf3c8K/ubS?=
 =?iso-8859-1?Q?WrDeNAi+EfT9I3OqJBwxyokFsoF3k3W3GI64snr+HFM9P/XNGWOeO4eKya?=
 =?iso-8859-1?Q?JTS3hTYo1BpOJsTXddhjnw7r5a81PQnsYe544cN9aMDXwBEZxzgeSN3xDG?=
 =?iso-8859-1?Q?JuCbhq54fM2vdxPVKNcWhbcBrTdUiqsUXLN7AhYdLg4lnZFZsn4zs5v7SB?=
 =?iso-8859-1?Q?KsdvH9Ul6VAQfC7Wv/k1JlxEcl2lDkVbBJZ1BPPPB1hzhnsaopnSDTkGEy?=
 =?iso-8859-1?Q?dh7xljCNIzgJTMlEc7XgYY0/x+mmS2WPQSEKJg3SgUirWRBwedghdwpzbl?=
 =?iso-8859-1?Q?qe+tVsSr37tpmZHC8HQAnRshmO4ofO0H1hat0taVUZYJ/RuXwxBX3ip5ih?=
 =?iso-8859-1?Q?vpNW3eKSc2eULR+hJZCWr+Wgum3Ai3slxOcKMWasQS7PSlgnOM6XWLDgF9?=
 =?iso-8859-1?Q?uFono23DR5nRJ+oTTrrwKVnOnVOa3qZ/Rma8zJst57gHTw4cRXt0wPbkRf?=
 =?iso-8859-1?Q?QCeFdvbLoteoeRzbcIugbq8kbBbhRR0X8IZpAER4m9i6h7BTspFFlPll44?=
 =?iso-8859-1?Q?cDzwdLbLPpjmFX7oUeVweeVOkG4YWMYJUiShVQaGUaT7iksWDnWotYBo7A?=
 =?iso-8859-1?Q?4bv8WSuDGkMfAbZb9/mn8eM0j7Wq/AlmWsCQImvkdOiBqMQ=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB134326754C6E824CCC02F9BDC17A0@MWHPR2201MB1343.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39840400004)(199004)(189003)(316002)(33656002)(26005)(6916009)(71190400001)(71200400001)(52116002)(256004)(42882007)(54906003)(55016002)(2906002)(76176011)(99286004)(7696005)(9686003)(6116002)(3846002)(186003)(7736002)(305945005)(102836004)(44832011)(386003)(6506007)(74316002)(486006)(11346002)(476003)(53936002)(446003)(8676002)(106356001)(8936002)(81156014)(81166006)(6246003)(105586002)(66066001)(4744005)(68736007)(25786009)(4326008)(97736004)(229853002)(14454004)(5660300002)(478600001)(52536013)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1343;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GsTIgqzGbClPgEEsitMX0MonuysXebgHA3xmgiTbMS9DtRMa13/hUTpllxDkX/WYODKvBQsa0jJZvTZJp6wJKkjho7Ag6B3tw8pc8x9TbAV2MPhIvWjfhZ6aEzvOdqiCGFgkDnLMBoufTX/dFE1FbQ7biRYX4UMF4KkKQyw5Acjq1MhyZeUn3CuEHXsK0dz8Mbp7/NQN+Fkv+G8YInEUiTvfbbzLX4KlaKdfHDjDfoKbLLjsIAS60oBx7/TAim0cTBR7f03GZwtQrPaW2comVrvGpyDWsRvyhqEYJPyOe+GD+WstGH8aKFuTllY61x//+/Kr2S1R7mQYTKi9CBGMzbOO3xpRswCdB1R96jHKWuSQv3e00qZscm4keHxWEEbJ2zKzjnubiimproRaoXFWyNqjfetJTzAWjNgt7FqqxYw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52df6755-63ff-4263-0b15-08d69b54a880
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 19:08:42.4874
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

Paul Cercueil wrote:
> Add support for booting the kernel from an externally-appended
> devicetree, if no devicetree was built-in.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
