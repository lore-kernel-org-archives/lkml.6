Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D27C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABAD20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fik8vswr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfAQLCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:02:21 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:24205
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfAQLCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyFJBdJT1XkRNMYpX+oyMMzPUkjGSzhZbT/a0uFYD80=;
 b=fik8vswrcBHqbRqCLTJ5wVIUIPwMIpi5Cw0VVf99X6HYpTzcOowGU5s3T0/Cyggo7tfFwzsdUKRClqx3+kzw511dlSW7mw32dAogGXCJch2NoHBp1TWd6H6VR40WlbVLgzxjc4J5xlF6mCjgyBQkGgDnLdYEm9c9RuljTBON1s8=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB4225.eurprd08.prod.outlook.com (20.179.32.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 11:02:16 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::915f:e024:438d:7f2]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::915f:e024:438d:7f2%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 11:02:16 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI devel <dri-devel@lists.freedesktop.org>
Subject: Re: drm: arm/komeda: Remove IRQ parsing from initial series
Thread-Topic: drm: arm/komeda: Remove IRQ parsing from initial series
Thread-Index: AQHUrlQS2Jrgf7OCVUeSuU1n5chEOQ==
Date:   Thu, 17 Jan 2019 11:02:16 +0000
Message-ID: <20190117110201.GA29795@james-ThinkStation-P300>
References: <20190115101544.8653-1-Liviu.Dudau@arm.com>
In-Reply-To: <20190115101544.8653-1-Liviu.Dudau@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0095.ausprd01.prod.outlook.com
 (2603:10c6:10:3::35) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB4225;6:2WSAOEnJ31WRx9FL1rdqHN9RCIKNPLDu2TvqKWmP1B5RSAR52v5yjsiuiyVE4iPu49TQhr1y5DwanAGWphgf3WkFP3gFWxWa1KdU3LQOaGQvA4zZPT/yu/Pb3uQQ0MXmBlgrfjPQ9UI+c+PDXADboHrcCPcXmhYh9zphBXlib94DH1k7JTCHKmW5r+FbGlE+HG4EMPshEMKZbYWmJ6pTJH4kcvJKkHFQBckGenQ3ZtLfOU+KM5b8vhYuLx3trRy/ovTfr+jUvDkpy7tZF6su93XMM07kVPAmxl76K+IJDwLBuwIhwXBylQs2P8TQLoN3sF9RYHPFcoby8OVieN3AGoaW84FXw/QLcu9cAV+RsNNjUa5X7WB0pRd5ktuwvMOvhwivjVfdjzBDhdOAB3fHDrarYC7vNnQq7Koav/7bTEQHqXHlS+oj6F/yVDe1z9YmHN7VmyaoCCpmAP/Lx3dhPQ==;5:69++U5Bcaprga/dXZJSDmDUwlqgYI7SJ/rkaRjZY1fvCdjhm7+cttulWUpF5XKSrGkyIVp0bR3qKUi/hYfJ1jSPCfqfBIizRMCtez7GpGNOOv3IgAaljsadf9ufCADPufLMT2bqs9btFvv+SE1Ek6nZT2K+Rv6MoirXHhTAYmxxrofYlk2i+ayfSqpklJg3Z/xkobT0pUa7svl2zB5ptEQ==;7:5URX4xTCrHV5Qc2P+ku9qyoXRVKesQTAc7SC0TbVfNJ5c/9Av/IrR8jT9QwrC7YzrXzJDygXSIZmntH4CTl8/93FUNdMP1YbipcQDke6CZTCz8M9U2O67tFQwmMusczxMQDFVJFoxapLUy/gdjyLew==
x-ms-office365-filtering-correlation-id: 7ee8102a-b553-4def-4a43-08d67c6b3de9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4225;
x-ms-traffictypediagnostic: AM0PR08MB4225:
x-microsoft-antispam-prvs: <AM0PR08MB4225CF1B9322476DD350F704B3830@AM0PR08MB4225.eurprd08.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(40434004)(189003)(199004)(66066001)(4326008)(14454004)(26005)(305945005)(68736007)(11346002)(446003)(55236004)(25786009)(76176011)(9686003)(6512007)(33716001)(52116002)(97736004)(6862004)(102836004)(99286004)(2906002)(8936002)(53936002)(1076003)(8676002)(5660300001)(6436002)(81166006)(81156014)(71200400001)(71190400001)(33896004)(6636002)(6246003)(186003)(478600001)(6116002)(86362001)(3846002)(54906003)(476003)(6486002)(5024004)(316002)(7736002)(58126008)(486006)(256004)(14444005)(6506007)(386003)(105586002)(106356001)(229853002)(33656002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4225;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 68Gxz7mTgkv/E1dmTA+9FWidVCPIrMPYMvZ4zahXH8+iOn0c7599cuzCVeUz1X211eQe0zGl4urB2rK/eSu2EY4gLUvanZwRTvBEAcKwmCy+ciVD8/VgFjN9Qs/gPtu4n6BNtlYP49T5jb0uhe34KZglSZAHDpxUySXmsZ4yG+YBI6yD3ATc2bBsL1Ok5ewFeIUTit12ml6o71VNaWGqIpifVUG5dXMr4Xatf5V2JBCAezPsPVv+j7ygf34BaLR7RG+pnOOIFzwVX+UQhJBPJNeoDqVqZNfd6DTulLbHpLgH9Sk9udMgmmKDnUxNHN3fVMZT/roUXInE0cgUeASDjGszhXUpNu0jg7ABp3cvuafXmUvoddQeZFYv2K0nZGIUgFC+m723DHgKhMyH4DGX6CERe1Vnj08+QMLDlcRuzyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F2FA491C5769A4FBEEF88721A3899C9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee8102a-b553-4def-4a43-08d67c6b3de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 11:02:15.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4225
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
