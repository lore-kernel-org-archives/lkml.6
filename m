Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0660C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oXsetDa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfAQKzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:55:01 -0500
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:44640
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfAQKzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMKRDOHkyccojutmwLVzYKjKTtEBB2Peh8JXIlxxiWs=;
 b=oXsetDa/hXBFNHg1CIIleD04vala4ms2og5nql3l8P72IU1kfr1a2JmzBKLPx9Pl2zLPEVp7XQ3ffJxhA94G80kktaFKpUwb9eAWVlxbT8jW1I+YacAtY0nJVOGrRfJyut+pbf4OdVyMD26buZCWfI0Axv7votrgEr6tXmh7EsE=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3010.eurprd08.prod.outlook.com (52.134.92.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Thu, 17 Jan 2019 10:54:57 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::915f:e024:438d:7f2]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::915f:e024:438d:7f2%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 10:54:57 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI devel <dri-devel@lists.freedesktop.org>
Subject: Re: drm: arm/komeda: Remove IRQ parsing from initial series
Thread-Topic: drm: arm/komeda: Remove IRQ parsing from initial series
Thread-Index: AQHUrlMV2Jrgf7OCVUeSuU1n5chEOQ==
Date:   Thu, 17 Jan 2019 10:54:57 +0000
Message-ID: <20190117105442.GA29542@james-ThinkStation-P300>
References: <20190115101544.8653-1-Liviu.Dudau@arm.com>
In-Reply-To: <20190115101544.8653-1-Liviu.Dudau@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:1:15::27) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3010;6:g7X+uJkA25tbIPmdCi+Kk0lKigweYxKF3oEIvKBISjltpXxCsEbyQ7iADxAE6HHLljdnAc8BagovMC8uwE1W9c1BkzEZK3ds8Mw2BC4s3j3qC55MviIiFtMLxgI3Q1I/rJ8Ky1gEWUKuikwrRV979i5W4pbLQlS2HXSheCEiLcxr0qcL/sBwCjWhu5+fpKfbYAEmZZRSSxv/HKqBMxra5seXEUOq3SpWNO8LWwd7JlQi/MsvCPmCovm9u18X+dNW6Cj3963CKbbjo2fIKfV3hGasAGgxgP71FVF2l4TSKvPULn+CYJm3ZnCQmAQBuFrk2YIrfzYFGGKAn/2RrAOpGTnGAo4cepFnrzz0oyDjI4YUj9kdLSF29QwCe6L+WNYtie51s7ECVafZiA9meU40xg8ys9j/eNKtJngiUd3qU9fMKN3PjnVYtKqCBJUshP8ATgmQuLV88gk2wy04w70GNw==;5:+Hb2p45SyOMOolacUy5COnXQTg248oGEhxk6D772wI0rLHlj6aCV43uAN9E48UDQA8cG9gMnRHa2r/oJx14uZ2dj9eEPJfZQScjh16zCbII53gVg+Sa1CQ2fj28yozBBw+yW7I7vCig26EA8Sltura1v9xZbLOsptT1oyICdtyjA/mq1nHFXYSXWbmelMeVMuNhkF4FaHg3gMJWoK/XdVg==;7:rRzmdockvlp1NdP16C+GnJxsgtpYbHhhdU/mJW7mwKclwnkacUplfWrmDlEbJF4HNjr1GFGVnHEn30E1/HYkBBrygOY9HhtRBc081TNSZVt6FdwHllgodfiEpr9cJHzyONeDHE8fZpsfvnnVSxFwoQ==
x-ms-office365-filtering-correlation-id: 0401e6c7-9a10-44e3-496c-08d67c6a382d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3010;
x-ms-traffictypediagnostic: AM0PR08MB3010:
x-microsoft-antispam-prvs: <AM0PR08MB3010134A7A7662046A35BA1AB3830@AM0PR08MB3010.eurprd08.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(40434004)(97736004)(6486002)(54906003)(33896004)(58126008)(6636002)(229853002)(305945005)(86362001)(7736002)(5660300001)(8936002)(14454004)(476003)(99286004)(52116002)(81156014)(81166006)(8676002)(76176011)(1076003)(71200400001)(71190400001)(478600001)(33716001)(316002)(4326008)(68736007)(105586002)(446003)(11346002)(106356001)(486006)(6246003)(53936002)(6512007)(6506007)(9686003)(256004)(6436002)(102836004)(55236004)(33656002)(3846002)(6116002)(6862004)(386003)(25786009)(186003)(2906002)(66066001)(14444005)(5024004)(26005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3010;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5u3ZRF36sk+uBnuw/MI8XLBNpe4C7w/f/ZtqmZDDglpEcpHi6ocS7XF/C6XwgaxjVuanmF+mYZZ5tO1hLOAgZdAnVTbOiLk+zz0kBkCAUJAVL1tytL68qzAl4glUDoQT4aEBssuOISf8roXDjAm/wUTAkwzV4qK1BkOwXiC/ay4enW/GXOpDD2fMiNeBqht/tfB04eQAextVrg/ivkUt4NvlgCgBICEzrO6SFZu37dUjpNzQnFpjs+vZOaqQEY/A7/eSdTKZJYTinyQiUdSVumpHsv/jbpRGBwxVm0jLLylBBnp3CmfiNPZ1/M9F1ZfVEpvIcJ93nw81iMEGQoYn/2K4GDkC9JOEn6MhmgsqiNm2+I+AbXrL3rwGG0MBEDtU+k8Ob4drHnkbUF1os2vYrbBADx0HdLRdqJq6eaGb43M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5EA7B742F334C40A418E37FC392C460@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0401e6c7-9a10-44e3-496c-08d67c6a382d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 10:54:56.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:44AM +0000, Liviu Dudau wrote:
> The initial series is only introducing the basic components and not
> implementing IRQ handling. Remove the left over code that touches
> IRQs until the proper implementation is introduced in a later series.
>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 5 -----
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 3 ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 +---
>  3 files changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 84fdf707f2107..16f4e72abc1a3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -59,11 +59,6 @@ static int komeda_parse_dt(struct device *dev, struct =
komeda_dev *mdev)
>  return PTR_ERR(clk);
>
>  mdev->mclk =3D clk;
> -mdev->irq  =3D platform_get_irq(pdev, 0);
> -if (mdev->irq < 0) {
> -DRM_ERROR("could not get IRQ number.\n");
> -return mdev->irq;
> -}
>
>  for_each_available_child_of_node(np, child) {
>  if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index a0bf7050037a0..0f77dead6a237 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -81,9 +81,6 @@ struct komeda_dev {
>  /** @mck: HW main engine clk */
>  struct clk *mclk;
>
> -/** @irq: irq number */
> -u32 irq;
> -
>  int n_pipelines;
>  struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index f41b20235130b..3fc096d3883e8 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -142,12 +142,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
eda_dev *mdev)
>
>  err =3D drm_dev_register(drm, 0);
>  if (err)
> -goto uninstall_irq;
> +goto cleanup_mode_config;
>
>  return kms;
>
> -uninstall_irq:
> -drm_irq_uninstall(drm);
>  cleanup_mode_config:
>  drm_mode_config_cleanup(drm);
>  free_kms:
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
