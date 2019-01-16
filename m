Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E35C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0019520675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pH8pTym9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404866AbfAPP2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:28:14 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:64480
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404853AbfAPP2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VNmF/YwvKHXlZffIEk38VhL6XUrutkeatbExpPYkWY=;
 b=pH8pTym9OKxAgT9PaPtoQMX7RbzC3GlEPRpOKKd6jetrdEgOV/eqa1jUBgAU5+j96OEshz6aKpBAhbrZPosHslwHM8K6jEXC1MMuoawQ+iYPLXuC8LXOwlHVr+afhfuYbRzxZr6noB+QYcFyzBLQC3K+aedu63UL5BTAFMJSCJ4=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3042.eurprd08.prod.outlook.com (52.134.93.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 15:28:10 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:28:10 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH 11/14] staging: android: ion: Allow heap name to be null
Thread-Topic: [PATCH 11/14] staging: android: ion: Allow heap name to be null
Thread-Index: AQHUrbAW++HflphYKkCPMn3Yls+WVw==
Date:   Wed, 16 Jan 2019 15:28:10 +0000
Message-ID: <20190116152807.phyq5pqrmbkj6oxk@DESKTOP-E1NTVVP.localdomain>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-12-afd@ti.com>
In-Reply-To: <20190111180523.27862-12-afd@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::29) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3042;6:bzJb7g7NO6WKX03sl/aoJp5Xpd/aczpdgqEochE4WBMr+fYhsYciMXvf9F/+Q/ybhxvnMA4dV4fFSCUp43KFCWbXVHB1+HJhWKg15ZixyZbEx+qBSM8e7ekr9W8JxQtoWHibvGzlfHGD+MhvEnYxjTk0T1m1cRrDqD0ISN2c1FkLG8HufaKNYZikUPVJiIqqzY0scqbXhlXC+WKneR2IXOjWv9+eptnQG6Hbubmm7Qb5UNx5HM6KcvrgwENjoKv8Su31Uib2lzrfQh0wCBv42fFRtbou2Xg/r9vaOjJOP/HZRtL7A0AoqZFrYtg3tXvhF6VNVhi5KOX7Bn1woVymQ5epdeRnT27kMTr+DRuzEKBpn/v82akJVJhxkpWFpQ3JflAEN3ZDGsnBK2oeAyKeKGGsUkCnw67Ow4lWjtJkMczSpYDBtzhiRlVYMliZCmpQ/BIrSQwzkcNLyGhHzO72vw==;5:DqaJgWSt2rwzPmu3tUAYEII9gf3ZPpoxEXfbhrGUtT9UpJC8OL8PSmkIQLlwDqFLZtwwi4eh9sX0lF9udi7MmhYAFR+c80nb1ZRVjN0AZwxGVAkyFFV756qTAQzcd8vVbhQGqjixefu9mvjyrkf7GvTaGZPFLgQcHGlbYPkzb209V1y+x4bBocrMkqIOKaZdvy489V9/xViPzL25mZ4kmA==;7:vOSeLWNZGWBmfLn3tcnVdKS3zpj38P1gjyJk7iM9RG/V2yitR5LuKhX2UGAPt6ywpnDI1vp+BV10HHbzDSG9qsKhIP8wyMPkuyIYTBiFYjU6ZPQQVZs2mojoLBjKU7d1KraiDTUiYxwkS4186LMwfg==
x-ms-office365-filtering-correlation-id: e9c8567f-fdcf-4908-5e38-08d67bc7388f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3042;
x-ms-traffictypediagnostic: AM0PR08MB3042:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3042F3ED27254B51B17AA5CDF0820@AM0PR08MB3042.eurprd08.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(229853002)(99286004)(7736002)(25786009)(53936002)(105586002)(305945005)(1076003)(966005)(33896004)(6436002)(14454004)(6486002)(8936002)(68736007)(76176011)(3846002)(6116002)(386003)(52116002)(6506007)(102836004)(106356001)(97736004)(5660300001)(478600001)(86362001)(72206003)(81166006)(81156014)(8676002)(6916009)(2906002)(54906003)(58126008)(4326008)(71200400001)(316002)(186003)(6306002)(476003)(6246003)(26005)(446003)(66066001)(6512007)(71190400001)(486006)(11346002)(256004)(44832011)(9686003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3042;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 82zFAqgOpjcCsvyTH81DGC4Pfu1R3XimJ2hqW2cUY74kPj7XvknKTs23UDoQW8m7JbAKRL32b2htbOg8awaAnLfyyheDV+WXLQA7rg9SigwxS4dK9TMUG4Ni0UJ0J96cRw+wgkesDV9wDUW9y2NSt5FapmsjEM+bQVWGiw3NcuLC1g2+dt3VXHmUQg83rtDqwdctHl7sCmc2NN/DLCTSbD/ssrPFRGcXHUf05FvllFYNWuTfMutF5niOpTSF1M3obuPMZyBLb7C9JI9dCV0qepqxTULX1pHhVefSmRzVyrACRFRsaILb6CAwY+F4+YoGJu84ZVOTOix/882u8PQ882qKGop+0UCVtZnUJKDIGbgkQdtXbuaGJN5W9BDjc3qwvjrhDa7IqhGpXh2cyevpE2FZC9NvlilDsTFLVzZ9U3Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5CE60EAE78B4B140AB0E7FE3C390D1CB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c8567f-fdcf-4908-5e38-08d67bc7388f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:28:08.8538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Jan 11, 2019 at 12:05:20PM -0600, Andrew F. Davis wrote:
> The heap name can be used for debugging but otherwise does not seem
> to be required and no other part of the code will fail if left NULL
> except here. We can make it required and check for it at some point,
> for now lets just prevent this from causing a NULL pointer exception.

I'm not so keen on this one. In the "new" API with heap querying, the
name string is the only way to identify the heap. I think Laura
mentioned at XDC2017 that it was expected that userspace should use
the strings to find the heap they want.

I'd actually be in favor of making the string a more strict UAPI than
allowing it to be empty (at least, if heap name strings is the API we
decide on for identifying heaps - which is another discussion).

Cheers,
-Brian

>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/staging/android/ion/ion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/=
ion/ion.c
> index bba5f682bc25..14e48f6eb734 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -467,7 +467,7 @@ static int ion_query_heaps(struct ion_heap_query *que=
ry)
>  	max_cnt =3D query->cnt;
> =20
>  	plist_for_each_entry(heap, &dev->heaps, node) {
> -		strncpy(hdata.name, heap->name, MAX_HEAP_NAME);
> +		strncpy(hdata.name, heap->name ?: "(null)", MAX_HEAP_NAME);
>  		hdata.name[sizeof(hdata.name) - 1] =3D '\0';
>  		hdata.type =3D heap->type;
>  		hdata.heap_id =3D heap->id;
> --=20
> 2.19.1
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
