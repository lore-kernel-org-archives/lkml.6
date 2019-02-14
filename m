Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6535AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B815222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z+fXL3qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405164AbfBNFJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:09:50 -0500
Received: from mail-eopbgr720042.outbound.protection.outlook.com ([40.107.72.42]:35977
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfBNFJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 00:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhsgMN7EH1KAN9RkqD/P3gg/M8Uf6mEeRztpXb/JAdQ=;
 b=Z+fXL3qRoQHAcsH2LJmhfhWP+DrCckGc3voPAKVwx8DC9IhdOY3diHyqKa3d/WV5HNVaDdnxs7EUNfQYtzSXFrvhxzXiYPKO7g2Ya8RxrG9wNw1pDmq8w6xOuTFFhd7xZ+ig27lUosyWHABbAo7intcr9CIJ2WZ7ILOtUU8wAHw=
Received: from DM6PR12MB2908.namprd12.prod.outlook.com (20.179.71.214) by
 DM6PR12MB3228.namprd12.prod.outlook.com (20.179.105.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 05:09:45 +0000
Received: from DM6PR12MB2908.namprd12.prod.outlook.com
 ([fe80::6448:8368:c5f9:fe62]) by DM6PR12MB2908.namprd12.prod.outlook.com
 ([fe80::6448:8368:c5f9:fe62%3]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 05:09:45 +0000
From:   "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
To:     Bo YU <tsu.yubo@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>, "Zhu, Rex" <Rex.Zhu@amd.com>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Error handling issues about CHECKED_RETURN
Thread-Topic: [PATCH] drm/amdgpu: Error handling issues about CHECKED_RETURN
Thread-Index: AQHUxCB7Uf9Sg9+2AEejhLZiKhxoGKXevnsw
Date:   Thu, 14 Feb 2019 05:09:45 +0000
Message-ID: <DM6PR12MB2908A5B2BD12B9139C5DAB01B4670@DM6PR12MB2908.namprd12.prod.outlook.com>
References: <20190214044628.26759-1-tsu.yubo@gmail.com>
In-Reply-To: <20190214044628.26759-1-tsu.yubo@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c302e863-1d42-4123-de21-08d6923aa2e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3228;
x-ms-traffictypediagnostic: DM6PR12MB3228:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3228;20:Aom/1McvzEZ8EYvbClg3qB09nCsY3oUGkNX6SRoJoa2n8ImPr6HeFYN5ZMyqLx1FmAe+raoWaxxdS5h264KUWGxAWxQsUwInDIcTP2sQIxgbUlOPqUxO/Z80sAiJylnT8zGYBRV7EMXMVKI7PDDzgTGqXvLM++WMYjffNtaSTqD6LTZ9CT4+k7/n6pGzHRiQ0Jk8cZU3J1BlHQBW9qukjCCyXitg7cdMiVgbgeNWJqVF6e6QBBN3H7DjlGeCP+5O
x-microsoft-antispam-prvs: <DM6PR12MB32282BB4FF1FF68D5479ACFBB4670@DM6PR12MB3228.namprd12.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(13464003)(71190400001)(71200400001)(25786009)(256004)(316002)(229853002)(7736002)(74316002)(6436002)(8936002)(55016002)(305945005)(81166006)(9686003)(81156014)(8676002)(478600001)(97736004)(76176011)(68736007)(110136005)(72206003)(14454004)(6246003)(4326008)(14444005)(7696005)(99286004)(66066001)(86362001)(2906002)(2201001)(2501003)(486006)(11346002)(26005)(3846002)(6116002)(6506007)(53546011)(102836004)(476003)(446003)(53936002)(186003)(106356001)(33656002)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3228;H:DM6PR12MB2908.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G9HT2YyIboMLRNch4/Egc28lN4deGARghiuTOTybRVJy3PYWnB6gdIE/no8JNTpdpAdL9Z7i0IxaNlETnLnoNwfChqV8xNBtazFP/v3w5tswVpUq1YspKDtnSd6G395Aw9mzCNuMT6dVwG6SMFTn6jaf4m9FtdKVRN+I5km99FsAYWQJA9+y6rwfmbZVqG/7DS0/Vq3669oGH8va1Ukwh2WPlpUteybQ4Omnh0QzhIF1/g6enxHli7VKd/eNA8F0lyHDzOETsSakYRVFsAFtrRll+UymOR8+uv+m8K/nOhpeN60FTGh6cs/rHRH4gVhdo+tV/G4dmnoUdBsWw/LKT4tDX/AHVEQuR6YMJreFOHany+tFnl1IwDwPI/MW2YQndFplHvyNTmt7Vd78R2jnMVneCxxwP01QjFYnGA5PLNg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c302e863-1d42-4123-de21-08d6923aa2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 05:09:45.7009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bo YU <tsu.yubo@gmail.com>
> Sent: Thursday, February 14, 2019 12:46 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; airlied@linux.ie; daniel@ffwll.ch; Zhu, Rex
> <Rex.Zhu@amd.com>; Grodzovsky, Andrey
> <Andrey.Grodzovsky@amd.com>; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org
> Cc: Bo Yu <tsu.yubo@gmail.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: Error handling issues about
> CHECKED_RETURN
>=20
> From: Bo Yu <tsu.yubo@gmail.com>
>=20
> Calling "amdgpu_ring_test_helper" without checking return value

We could need to continue to ring test even there is one ring test failed.

-David

>=20
> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 57cb3a51bda7..48465a61516b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4728,7 +4728,9 @@ static int gfx_v8_0_cp_test_all_rings(struct
> amdgpu_device *adev)
>=20
>  	for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>  		ring =3D &adev->gfx.compute_ring[i];
> -		amdgpu_ring_test_helper(ring);
> +		r =3D amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
>  	}
>=20
>  	return 0;
> --
> 2.11.0

