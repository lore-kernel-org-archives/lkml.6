Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43ECECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2812075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HroQYJAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2812075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeJYKAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:00:14 -0400
Received: from mail-eopbgr710045.outbound.protection.outlook.com ([40.107.71.45]:38791
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbeJYKAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88hz4dqKOYUuHMvfvYexee3LepIxn+SqBXWd6al7pDg=;
 b=HroQYJAd1ZLqwXQADRy+E5d8IvGNmIwzL4ZSLHI7oCcjGwhH7sOwNkdCtBYw+HQDBu5EV3rGu8Ceq6yvKH9Z4UPx3fOM3nVgXOuPLGJP96CC2nET6gXKEPqCdeLJXFOaa2XW3YQWDcYc0sVewD8AoMUgJycpSSNw9cOlcZqmMl8=
Received: from BY1PR12MB0502.namprd12.prod.outlook.com (10.162.147.154) by
 BY1PR12MB0405.namprd12.prod.outlook.com (10.162.146.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 01:28:57 +0000
Received: from BY1PR12MB0502.namprd12.prod.outlook.com
 ([fe80::3cb6:d79:f32:b21]) by BY1PR12MB0502.namprd12.prod.outlook.com
 ([fe80::3cb6:d79:f32:b21%3]) with mapi id 15.20.1273.014; Thu, 25 Oct 2018
 01:28:56 +0000
From:   "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?iso-8859-1?Q?Christian_K=F6nig?= 
        <easy2remember.chk@googlemail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm: fix call_kern.cocci warnings (fwd)
Thread-Topic: [PATCH] drm: fix call_kern.cocci warnings (fwd)
Thread-Index: AQHUa8ttnJBGlVewy0W5AqjcfBKZrqUvLHAQ
Date:   Thu, 25 Oct 2018 01:28:55 +0000
Message-ID: <BY1PR12MB05028BA16A21896179679800B4F70@BY1PR12MB0502.namprd12.prod.outlook.com>
References: <alpine.DEB.2.21.1810241955110.3776@hadrien>
In-Reply-To: <alpine.DEB.2.21.1810241955110.3776@hadrien>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR12MB0405;20:prSmnESrujG+pOrli6b43LTJnqmMREvwPtlMC0IFaT1x8BNpDf4eXrYjA0oZwrRk4pE0tNd1LSRqsFnFAo51Uw9LQvorPqNoMVWuVn3V/YxXemMzUUG8GoOFlZ5LVJTXU/gt19DECBuNQXSfnBgtuijkmtGOprk2U0/oZqI9U5W/gA9ca5ofmGNOAMeQ10mNPzaHbo6sMWeKb76hu9Ttj8xGUBPyB48UOnZ0YDIVD15hrhFXNXStsYydZoF/q2MN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0240f15d-b0d1-4749-fa4f-08d63a193b2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY1PR12MB0405;
x-ms-traffictypediagnostic: BY1PR12MB0405:
x-microsoft-antispam-prvs: <BY1PR12MB0405DE56A242826A6B34B508B4F70@BY1PR12MB0405.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(9452136761055)(17755550239193)(767451399110)(8415204561270)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR12MB0405;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0405;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(13464003)(199004)(189003)(9686003)(2900100001)(55016002)(316002)(2906002)(7416002)(6246003)(33656002)(305945005)(7736002)(72206003)(229853002)(53936002)(5250100002)(6436002)(14454004)(74316002)(478600001)(6916009)(66066001)(54906003)(81166006)(81156014)(8936002)(14444005)(256004)(6506007)(71200400001)(71190400001)(76176011)(53546011)(66574009)(68736007)(7696005)(105586002)(99286004)(106356001)(4326008)(86362001)(575784001)(102836004)(25786009)(97736004)(5660300001)(186003)(26005)(486006)(8676002)(476003)(446003)(6116002)(3846002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0405;H:BY1PR12MB0502.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 80coxLaU4xnuW4h85o7a1i4lce88/LuwIAwXuSXC4CV2YDZ02GJV56zhCcA9CQPlZB9TCVECj8AW01kFWV6MxHWfRT/46PvSk/JORAaj33NHaGwdV6SbEDA9YL3o2f8UF09DOhO1Bl1HWAB6ioG43H04ZN9VD0TZPEaLOUpXeOJ9rxFQfk+z+8Z78bXx7BivMJ5m2YAh+dDAIDgxY5uDKEMegWxg2SHElTtxywbJBPZLEP+6YQJgA5nfA4Qyh3bN9E49YKNmL8D+BmtxDt7a8M6bVoLAoT5G6scl0/FXlj350WutpfXaHYW1FQJX+lN3XfTt9hjdtNPOZSfnns15abEq2T7yhy9uXAvdrROUg0E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0240f15d-b0d1-4749-fa4f-08d63a193b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 01:28:55.9247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Chunming Zhou <david1.zhou@amd.com>

> -----Original Message-----
> From: Julia Lawall <julia.lawall@lip6.fr>
> Sent: Thursday, October 25, 2018 2:57 AM
> To: Zhou, David(ChunMing) <David1.Zhou@amd.com>
> Cc: kbuild-all@01.org; intel-gfx@lists.freedesktop.org; dri-
> devel@lists.freedesktop.org; Christian K=F6nig
> <easy2remember.chk@googlemail.com>; Gustavo Padovan
> <gustavo@padovan.org>; Maarten Lankhorst
> <maarten.lankhorst@linux.intel.com>; Sean Paul <sean@poorly.run>; David
> Airlie <airlied@linux.ie>; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] drm: fix call_kern.cocci warnings (fwd)
>=20
> The containing function is called with a spin_lock held, so GFP_KERNEL ca=
n't
> be used.
>=20
> julia
>=20
> ---------- Forwarded message ----------
> Date: Tue, 23 Oct 2018 17:14:25 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [PATCH] drm: fix call_kern.cocci warnings
>=20
> CC: kbuild-all@01.org
> CC: intel-gfx@lists.freedesktop.org
> CC: dri-devel@lists.freedesktop.org
> TO: Chunming Zhou <david1.zhou@amd.com>
> CC: "Christian K=F6nig" <easy2remember.chk@googlemail.com>
> CC: Gustavo Padovan <gustavo@padovan.org>
> CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> CC: Sean Paul <sean@poorly.run>
> CC: David Airlie <airlied@linux.ie>
> CC: dri-devel@lists.freedesktop.org
> CC: linux-kernel@vger.kernel.org
>=20
> From: kbuild test robot <fengguang.wu@intel.com>
>=20
> drivers/gpu/drm/drm_syncobj.c:202:4-14: ERROR: function
> drm_syncobj_find_signal_pt_for_point called on line 390 inside lock on li=
ne
> 389 but uses GFP_KERNEL
>=20
>  Find functions that refer to GFP_KERNEL but are called with locks held.
>=20
> Semantic patch information:
>  The proposed change of converting the GFP_KERNEL is not necessarily the
> correct one.  It may be desired to unlock the lock, or to not call the  f=
unction
> under the lock in the first place.
>=20
> Generated by: scripts/coccinelle/locks/call_kern.cocci
>=20
> Fixes: 48197bc564c7 ("drm: add syncobj timeline support v9")
> CC: Chunming Zhou <david1.zhou@amd.com>
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>=20
> tree:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
> head:   8d7ffd2298c607c3e1a16f94d51450d7940fd6a7
> commit: 48197bc564c7a1888c86024a1ba4f956e0ec2300 [1968/2033] drm: add
> syncobj timeline support v9
> :::::: branch date: 4 hours ago
> :::::: commit date: 5 days ago
>=20
> Please take the patch only if it's a positive warning. Thanks!
>=20
>  drm_syncobj.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -199,7 +199,7 @@ static struct dma_fence
>  	    (point <=3D syncobj->timeline)) {
>  		struct drm_syncobj_stub_fence *fence =3D
>  			kzalloc(sizeof(struct drm_syncobj_stub_fence),
> -				GFP_KERNEL);
> +				GFP_ATOMIC);
>=20
>  		if (!fence)
>  			return NULL;
