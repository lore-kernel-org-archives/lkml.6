Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F424C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0850214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UCjSLZef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0850214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbeKOV4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:56:51 -0500
Received: from mail-eopbgr780041.outbound.protection.outlook.com ([40.107.78.41]:9600
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeKOV4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX58dxxOdRVo7jLdKh1UmPd7zpRIPjhS7eDONhiFcTQ=;
 b=UCjSLZef1mNyBZhRG4g01LTFgH9N/vDxnRQhDaOX9urc85xilDPg+uicCdpDIsi/6Au0xrHVYz+ejFaeA3QguchYhTHWfFHo3FoZo546MXI89fVcKeJjrHe6gOpE26YrnMiyhm2r2U7WWKtQXDwKBMujwh/q463YNwkd04sBjMQ=
Received: from BY2PR12MB0040.namprd12.prod.outlook.com (10.160.66.15) by
 BY2PR12MB0146.namprd12.prod.outlook.com (10.162.82.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.35; Thu, 15 Nov 2018 11:49:18 +0000
Received: from BY2PR12MB0040.namprd12.prod.outlook.com
 ([fe80::1146:ddb5:347a:da]) by BY2PR12MB0040.namprd12.prod.outlook.com
 ([fe80::1146:ddb5:347a:da%3]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 11:49:12 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "Xu, Feifei" <Feifei.Xu@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring'
Thread-Topic: [PATCH -next] drm/amdgpu: remove set but not used variable
 'ring'
Thread-Index: AQHUfM/9bG2Ak5COO0afzsF2yAtbm6VQt/gQ
Date:   Thu, 15 Nov 2018 11:49:12 +0000
Message-ID: <BY2PR12MB0040A0E1C221A3EBBF270C30ECDC0@BY2PR12MB0040.namprd12.prod.outlook.com>
References: <1542279133-103893-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1542279133-103893-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR12MB0146;20:WfarP4Hn8aNFDJTKDC9epyDy+v6+J+qBjOJA/kU0ZlFHx5z+JBzkHgLkHmqWPe+YdB+Z4aXJIBAErWK8agtFUGhcGyRNrxwektoo9wS/KV/hOcKV6PJ22JobYLfRiToKckzrapp+IMMKREeLIXhBw4VrcVuB+BhUjX6i7zM8vmGBHyjVNrLXHEWzllA83CxMqdNfCIdei2zDXkhvp9DM8N97dYNajVa9W0d0FzE8v3pNsyPHUyYWkCl1hpoJnl3T
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(366004)(376002)(13464003)(199004)(189003)(6636002)(14454004)(66066001)(478600001)(8936002)(3846002)(55016002)(305945005)(186003)(8676002)(72206003)(5660300001)(7736002)(81156014)(6116002)(53936002)(81166006)(106356001)(105586002)(33656002)(6246003)(6436002)(9686003)(71200400001)(71190400001)(4326008)(7696005)(486006)(2501003)(68736007)(14444005)(256004)(25786009)(229853002)(99286004)(476003)(53546011)(26005)(446003)(316002)(76176011)(54906003)(74316002)(2900100001)(6506007)(110136005)(86362001)(102836004)(2906002)(11346002)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0146;H:BY2PR12MB0040.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 2c4c562d-5897-474f-194f-08d64af05cac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0146;
x-ms-traffictypediagnostic: BY2PR12MB0146:
x-microsoft-antispam-prvs: <BY2PR12MB0146E5611C1E2071C443031CECDC0@BY2PR12MB0146.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(217544274631240)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR12MB0146;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0146;
x-forefront-prvs: 08572BD77F
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c9AcbnetQm91T4CzmEHqeJtXsb2cJe0Zfnka0xaHtwEqj6wIDGeKx6ajXoeba4rQVa/eJJ0g/t2mIBz9AgBQANz11upohCIcyOpgte0sdwpqkLJNHtxUVrkuyI+n2j2oU3PUSGSh2tS3DgqfGGjaTZGNNkWdqV9LkMep/8a171jV1vU3An/ZdJTWxv8eltmuNoD5ssNNqKrWE4Lanr/rsESYcx7nZiT/9d0WH+NwziVYVsyqKyNPcefB9tBageWdNSwI/e9KtIiQsMypPyhBaCk+vU+Bfy2h0Vmi+Aq/JTv5yOR/2Z+WOq33muiwo+ox0bHFgQmhgaHxLS1M6zmli7+wJ6qBqUve6p1HhMMrIIo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4c562d-5897-474f-194f-08d64af05cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 11:49:12.5081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: YueHaibing [mailto:yuehaibing@huawei.com]
> Sent: Thursday, November 15, 2018 6:52 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; airlied@linux.ie; Liu, Shaoyun
> <Shaoyun.Liu@amd.com>; Francis, David <David.Francis@amd.com>; Huang,
> Ray <Ray.Huang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gao, Likun
> <Likun.Gao@amd.com>
> Cc: YueHaibing <yuehaibing@huawei.com>; amd-gfx@lists.freedesktop.org;
> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring=
'
>=20
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: In function
> 'psp_v10_0_ring_stop':
> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c:230:19: warning:
>  variable 'ring' set but not used [-Wunused-but-set-variable]
>=20
> It not used since commit
> 4ef72453311a ("drm/amdgpu: added api for stopping psp ring (v2)")

Thanks, please also remove the similar code in psp_v3_1.=20
With that updates, patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> index 295c220..d78b430 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -240,12 +240,9 @@ static int psp_v10_0_ring_stop(struct psp_context
> *psp,
>  			       enum psp_ring_type ring_type)  {
>  	int ret =3D 0;
> -	struct psp_ring *ring;
>  	unsigned int psp_ring_reg =3D 0;
>  	struct amdgpu_device *adev =3D psp->adev;
>=20
> -	ring =3D &psp->km_ring;
> -
>  	/* Write the ring destroy command to C2PMSG_64 */
>  	psp_ring_reg =3D 3 << 16;
>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
>=20
>=20
>=20
>=20

