Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3322087F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="kIRkfR76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3322087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeHMLtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:49:52 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:24288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728269AbeHMLtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hslPLEYMtXyewojpIcjPiUXJvlxOdGbhADU9BoK4sFQ=;
 b=kIRkfR76SDhece1XwGrNYKGigkCyr6D98BmgFfu2oGVIX1e8O8gaEVz2qtrOQtGON3C4iganF7TwxSepfFScDk0gbXH6/vvbJsiq9xrxsxsg8osxu20XRueaH7ibPKEd3N+RU6Jqzv3rYEu7FUHRLpEvFGR6fuOmqkC4viMiAUc=
Received: from BY2PR07MB2454.namprd07.prod.outlook.com (10.166.115.22) by
 BY2PR07MB968.namprd07.prod.outlook.com (10.141.224.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Mon, 13 Aug 2018 09:08:28 +0000
Received: from BY2PR07MB2454.namprd07.prod.outlook.com
 ([fe80::4d48:a31f:30d0:f01]) by BY2PR07MB2454.namprd07.prod.outlook.com
 ([fe80::4d48:a31f:30d0:f01%3]) with mapi id 15.20.1038.023; Mon, 13 Aug 2018
 09:08:27 +0000
From:   "Shaikh, Shahed" <Shahed.Shaikh@cavium.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Chickles, Derek" <Derek.Chickles@cavium.com>,
        "Burla, Satananda" <Satananda.Burla@cavium.com>,
        "Manlunas, Felix" <Felix.Manlunas@cavium.com>,
        "Vatsavayi, Raghu" <Raghu.Vatsavayi@cavium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] liquidio: remove set but not used variable
 'is25G'
Thread-Topic: [PATCH net-next] liquidio: remove set but not used variable
 'is25G'
Thread-Index: AQHUMtZnE//mIjYOBUO4pL9mY4R946S9Y+uw
Date:   Mon, 13 Aug 2018 09:08:27 +0000
Message-ID: <BY2PR07MB245416297A60474BA77A99A39D390@BY2PR07MB2454.namprd07.prod.outlook.com>
References: <20180813072118.12448-1-yuehaibing@huawei.com>
In-Reply-To: <20180813072118.12448-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shahed.Shaikh@cavium.com; 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR07MB968;6:vGPmp3Ah+oZxcpPbaYQyt5ImoeU/2WIxZ9UyDdi0EQlexN7G7NbcEyUDjFkjNNI6BPfoZ4rBmDzwkSAC+0SdkmRu7JFGGJig0EC+BO3jieRNy9WjH6yNJjRHBuSD/inLRi5zROh+KQBs/xTjXq5ZnYl+K8WmPcFleeadJJapIHzq0cekBh1WdQfLmOKMVme5CD7XejNIF6UL2VVGCwJi02NvC8YvaIPtjdNXgubHFtsX4X2kOqKnR5k08xUhwioq22e9HW5zhLCO0DovRkE6V1HLZi7C2bZSsCImwGc3LwdwY6Ed6t3chlGlaIB4bSBAZdr00TrKwCAty9HRXmi2IzxY1Ct33hckrQvcsP61KdZQMqanyJW9W/6s/ToojRvVIEVcQt87KM0tBRlgf25/rIjikWMMazN3Qg2AFkl6MtFS0Nr71klWYwXe7rWfzIgLzn7sxsgvEowd3wo2Ow4deQ==;5:x3NoEM0xMS5W67f5fzNK4R6itMKbi6MgTUiDHuH0rCXC+n/0ghfa8Vfb40PEpdiP3irKSRXMRQL5LsJNaJvCNrmTjTZEUA5Cp42+veR23hi+BCmGwLEM4nJUOunQ6uSYOxBtHuYddQPsxerxjNPhwgS5pqHeRvmZdLMNa0MzOdE=;7:4ZvQSHCeBV7iv6tgLoJ2Sdq2KqfMroD3W0hJGBLyBioB/VA3c++IujaRlZn7HcbsJfv3DR21UncO4MHZmgnDlD9lsMQ82S3CAeXBF8R92stmChhlV9Db1cYi1HpaaJJPTE9aB3PFg5MMKkIvPNJazPxQ9OyGSSGZSAcfS+b3X90vc0VuuzpCtj1dzsT4fd3TtECBfvMrI6MmxS4X0dPwTiGHk18pN/yQSGOjPSs1RTsoqy7JdAG6buTFxj35q6HN
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(13464003)(189003)(199004)(476003)(486006)(14454004)(446003)(11346002)(72206003)(53546011)(102836004)(478600001)(6506007)(26005)(8936002)(76176011)(7696005)(54906003)(186003)(3846002)(99286004)(14444005)(66066001)(110136005)(256004)(68736007)(2906002)(6116002)(316002)(33656002)(106356001)(2501003)(9686003)(86362001)(2900100001)(53936002)(6636002)(81156014)(81166006)(105586002)(74316002)(97736004)(6246003)(55016002)(305945005)(7736002)(6436002)(25786009)(4326008)(8676002)(5660300001)(229853002)(5250100002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB968;H:BY2PR07MB2454.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 924cd1de-32da-4e25-0687-08d600fc5521
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR07MB968;
x-ms-traffictypediagnostic: BY2PR07MB968:
x-microsoft-antispam-prvs: <BY2PR07MB968307FBCF6B9FA223344EA9D390@BY2PR07MB968.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB968;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB968;
x-forefront-prvs: 07630F72AD
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FTkJ6Wy8Ib/cVx12AH5JvWutAgvgUELxJfB47QcVaMkAETuH4muCYLaFB85yBCqkvMzmoAZbVAWOXLsrdPjiczLYDpMRzVQBAQHZ/YVd9uSl/v5M2/W/qQ+NqlUpSKiWi8HjaHYFl3iDFZcIA3JGZkwEPt/sYDHZc8Qg5jEUEprSJSCvXlEn8hsIBziMdEdoRnHWX2dnjOUK9TF/W+xzvHnAqxWG/IiqNmwxZRWm2rEvVXfacMpyvtFS2k6FbamZrxIS3f7Xj4kfUGy/aHCW1kVuct4uKc0EKfZoQRU0i4bC196dD6TwmpYniUtX0PuraX3LKb3Oe94TEbOTEUS0imv/iyNk1NLLRDALgEMcqbM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924cd1de-32da-4e25-0687-08d600fc5521
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 09:08:27.8083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On
> Behalf Of YueHaibing
> Sent: Monday, August 13, 2018 12:51 PM
> To: davem@davemloft.net; Chickles, Derek <Derek.Chickles@cavium.com>;
> Burla, Satananda <Satananda.Burla@cavium.com>; Manlunas, Felix
> <Felix.Manlunas@cavium.com>; Vatsavayi, Raghu
> <Raghu.Vatsavayi@cavium.com>
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH net-next] liquidio: remove set but not used variable 'is2=
5G'
>=20
> External Email
>=20
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/net/ethernet/cavium/liquidio/lio_ethtool.c: In function
> 'lio_set_link_ksettings':
> drivers/net/ethernet/cavium/liquidio/lio_ethtool.c:392:6: warning:
>  variable 'is25G' set but not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> index 807ea2c..5ce604a 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> @@ -389,16 +389,13 @@ static int lio_set_link_ksettings(struct net_device
> *netdev,
>         struct lio *lio =3D GET_LIO(netdev);
>         struct oct_link_info *linfo;
>         struct octeon_device *oct;
> -       u32 is25G =3D 0;
>=20
>         oct =3D lio->oct_dev;
>=20
>         linfo =3D &lio->linfo;
>=20
> -       if (oct->subsystem_id =3D=3D OCTEON_CN2350_25GB_SUBSYS_ID ||
> -           oct->subsystem_id =3D=3D OCTEON_CN2360_25GB_SUBSYS_ID) {
> -               is25G =3D 1;
> -       } else {
> +       if (!(oct->subsystem_id =3D=3D OCTEON_CN2350_25GB_SUBSYS_ID ||
> +             oct->subsystem_id =3D=3D OCTEON_CN2360_25GB_SUBSYS_ID)) {
>                 return -EOPNOTSUPP;
>         }

You can also remove braces which are not required for single line.

Thanks,
Shahed

