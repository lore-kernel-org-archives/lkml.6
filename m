Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF3DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D984620657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QmIVYB3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfAQLJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:09:28 -0500
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:8064
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfAQLJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksxe4c1zINsTD2ThFKpcC55kjx7q2Kt4a8d/6pqit9o=;
 b=QmIVYB3VDBked799M4GlBsd0PbdopJvy9Jzf7isZKp/Le4JHy4DVR3t8UGH8xyZ3MTZ/CS+xDKp7WYYWQsR+NWMab5mGV6M7oIU6gHrbdcyrkQnhkHk+CfbtD+nwmD2+IcfPuEUj5ZuzOa3TYJ8RTw2BYCZWtz6v1n998O2X5x4=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3124.eurprd08.prod.outlook.com (52.134.93.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Thu, 17 Jan 2019 11:09:23 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::915f:e024:438d:7f2]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::915f:e024:438d:7f2%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 11:09:23 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Subject: Re: drm: arm/komeda: Remove IRQ parsing from initial series
Thread-Topic: drm: arm/komeda: Remove IRQ parsing from initial series
Thread-Index: AQHUrlUQ2Jrgf7OCVUeSuU1n5chEOQ==
Date:   Thu, 17 Jan 2019 11:09:22 +0000
Message-ID: <20190117110907.GC29795@james-ThinkStation-P300>
References: <20190115101544.8653-1-Liviu.Dudau@arm.com>
In-Reply-To: <20190115101544.8653-1-Liviu.Dudau@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0001.ausprd01.prod.outlook.com
 (2603:10c6:1:14::13) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3124;6:zBV/bGi486XBwPasc9k1r3XM2vox47HPs55AQhdZf/puaiYUnRSP66QbXJcg+niPPBks4sst5b7IYEBD4/QsoAtYaVYJQbcEkMcaI93Bx77mOKuILySAln4G9+duRCYMJjK7vzhIlpyXvpXxhwEbzJrnrqvBnPwXZRu9nGhKuz5DNMshkdbRsxpX5Me/FCkUiwLEO9cTlJla1no01E594P5jYRurOU0rnDbSZjwpp9mjUe/scMSiELIc4A2pjQXw2BIO4zaFJddxFEjKLgK7zM0Qw/w1QDDBLzIOJzrc1Qscn51ji3Oln7VHJfJdW3D7nR+EnLuz6Te6HtXlLYns6lu7XE+HzpCtdcxBhd+BNhkz6cAcHf3MSndrJilrqHzf7AdfmoBUFPZwtmGadBMG6DWYoy9/h3+Ic44tBjl4ud74n0l6xt/6rEX4wnerxpcnXbkd6TPoFV035RkrLcxxwA==;5:7lT/cdLx3rJ6jISL92gWxe0N+AYVwJVXup2QOYSK+W9i0ooHO4LS9OrePle1sL1p8sx4bI7zk4PgxzTZfvyChmnAvx6vXHddDqvMOcFjx7su2lWvysH85eqMBrdYW/ixuLDWtZkaXn2wdsFydd7fbQqSI17yaH4TJ9zXBGmk5TA/ZsR/PXI37G6MdzmAlQzoZXFxmLTWij2iY8s3UNpKIw==;7:zl2Wmnoexr0xuhV8aic0HbxCz0Ppe4vK9SOeIQbO4yS3awxmZc9NDeNwJ9pWRB3Fg7FgcYG8BoydWleazlhqFesQqKiJ+KEs2BwcceuU8NCvJqalEwhceE4X3TwbpNta7e8qwnW8aF3tl1Rm5SQlGA==
x-ms-office365-filtering-correlation-id: e6b7fbae-357f-4f06-591d-08d67c6c3c3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3124;
x-ms-traffictypediagnostic: AM0PR08MB3124:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB31249A18E1E5A1A71C1FEFC0B3830@AM0PR08MB3124.eurprd08.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(6636002)(106356001)(316002)(102836004)(33656002)(55236004)(6506007)(386003)(97736004)(6246003)(99286004)(54906003)(5660300001)(9686003)(7736002)(8936002)(68736007)(58126008)(2906002)(33716001)(486006)(25786009)(6512007)(105586002)(476003)(256004)(5024004)(305945005)(4326008)(229853002)(1076003)(52116002)(66066001)(33896004)(446003)(53936002)(76176011)(71190400001)(8676002)(11346002)(3846002)(26005)(186003)(14454004)(478600001)(81166006)(81156014)(6486002)(71200400001)(6862004)(6436002)(6116002)(86362001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3124;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EG0oiPGxdtkTHrzDWECORdjkl1av6x7LHqkVAR+tMwx86LaViRdEKCDK9FHS7Vvrntf9G8uIZfcJ83QPDNPhdCXqKogS4ySoJ/d3OdYgqwHpFxIusVqozfL+3HM8h3Wih0FTRxLpRuoRm9Li8ovCzt6A2BT1tYEmvG2i2nbcM4EkH9Aiv+KfjVyN4XkgCHZMvJXc1svf/KMMgtZG/O3fNksYfnW6lcqb5mcvYY3GL4cty14alFSfRgq0BuKDAWhAV78C3T/uyqyrSO7dlYQTXcNxqYDQ6IaMPYIXUDwgmPMFl5TQJcAEF2AbTqZDvvIKsfcpJvpEMo8+7OEfUUfrLy7Hlnp/GTa0qOiA8oFhWA0cbZvRsVNbuKF4UDPIKvkilbEb3bbXjWfPXFCSVdEGCabadv/HHsBCp71NncSuU80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C430BE9F26F74D41B0CBD9A439B277EB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b7fbae-357f-4f06-591d-08d67c6c3c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 11:09:21.8416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:44AM +0000, Liviu Dudau wrote:
> The initial series is only introducing the basic components and not
> implementing IRQ handling. Remove the left over code that touches
> IRQs until the proper implementation is introduced in a later series.
>=20
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 5 -----
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 3 ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 +---
>  3 files changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 84fdf707f2107..16f4e72abc1a3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -59,11 +59,6 @@ static int komeda_parse_dt(struct device *dev, struct =
komeda_dev *mdev)
>  		return PTR_ERR(clk);
> =20
>  	mdev->mclk =3D clk;
> -	mdev->irq  =3D platform_get_irq(pdev, 0);
> -	if (mdev->irq < 0) {
> -		DRM_ERROR("could not get IRQ number.\n");
> -		return mdev->irq;
> -	}
> =20
>  	for_each_available_child_of_node(np, child) {
>  		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index a0bf7050037a0..0f77dead6a237 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -81,9 +81,6 @@ struct komeda_dev {
>  	/** @mck: HW main engine clk */
>  	struct clk *mclk;
> =20
> -	/** @irq: irq number */
> -	u32 irq;
> -
>  	int n_pipelines;
>  	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index f41b20235130b..3fc096d3883e8 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -142,12 +142,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
eda_dev *mdev)
> =20
>  	err =3D drm_dev_register(drm, 0);
>  	if (err)
> -		goto uninstall_irq;
> +		goto cleanup_mode_config;
> =20
>  	return kms;
> =20
> -uninstall_irq:
> -	drm_irq_uninstall(drm);
>  cleanup_mode_config:
>  	drm_mode_config_cleanup(drm);
>  free_kms:
