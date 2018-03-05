Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeCEHzb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:55:31 -0500
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:7616
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933184AbeCEHz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:55:27 -0500
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
Thread-Topic: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
Thread-Index: AQHTsGFsSC26PGMebEmm/OMzPYEJ7qO5evoAgAfSfxA=
Date: Mon, 5 Mar 2018 07:55:22 +0000
Message-ID: <BLUPR12MB04494D7F15FC7D557D58488484DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
 <fa9f8ade-000f-a9b5-0bc9-0dd3f10d9722@gmail.com>
In-Reply-To: <fa9f8ade-000f-a9b5-0bc9-0dd3f10d9722@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR12MB0723;7:+D5J1AQ4wZTwluB1kdXggS9VFMuHns58RGX6o0KYuNm0cX21K0yD3glEppF1z49CuAhpIPbHXaNtiTg0w0GSVZ2VKiZZ5afEa/YnSTBUmxnlsy7Q4xb2ZrfX/ndecyC7EiKReVeoisQRfGa09lsCBZAJ/B1iKQg8ahudzW1PTa4XkZK2gvwb7jMnRIWCqaec8M5BkD0IQj1aWXQC+WcUxus3A+jg8IKQ4d/gs1/BEbAZKTqPUKjRj2hifhVBJXks;20:EULfu3t2xUiDlhrPxh+IDAd/wJDq0kgYmbfxs7N7X55wMeHQSbCYNILBg/ZpW6iffvLJpur/iQ4c/3E+jmZonksdEw4p7AFtYVR/TqMMrtSadZBJCmytwnu5uXFnBgQq0nhFfGqW9C8s43nOqrsgDOC68rQSmPtRQLJ2EmpGejWIT6fNid2XfnXQy9yxaYvX9zTkUoIxC4EfCpE0+/8Ga5HJzvQigXXzZtWUci/WIxH8NyBlNEzaf9dZgrkZA4cs
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(39380400002)(13464003)(199004)(189003)(68736007)(6506007)(26005)(8936002)(5250100002)(25786009)(6116002)(2201001)(3846002)(33656002)(86362001)(74316002)(14454004)(229853002)(59450400001)(81166006)(8676002)(81156014)(102836004)(316002)(478600001)(7736002)(305945005)(2501003)(6246003)(53546011)(72206003)(110136005)(3280700002)(53936002)(7696005)(76176011)(55016002)(2950100002)(6436002)(3660700001)(2906002)(99286004)(106356001)(9686003)(105586002)(5660300001)(66066001)(2900100001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0723;H:BLUPR12MB0449.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c1f1243-ab82-4c5e-8752-08d5826e72e4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BLUPR12MB0723;
x-ms-traffictypediagnostic: BLUPR12MB0723:
x-microsoft-antispam-prvs: <BLUPR12MB07235A99545E3AEC598059E684DA0@BLUPR12MB0723.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(217544274631240)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR12MB0723;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0723;
x-forefront-prvs: 06022AA85F
x-microsoft-antispam-message-info: Bnpamznta2K/UZQCw4GD2wY+glynHnT6SGU0wOeCqPbc3CZl/FefX9PJo46IFe38hkK05SMaFVPg5MhHkD44E2YydLOmwmLJF/7K2e3JITVJ98ctLOi1LG/m8ussXOPLpAkQ+54VSsD/6kydbUs177YbQnvITBSMg076Pxct1zNLjyZ63/LVgwOUb+uA8xQv5atOWopFk8sOVrx0zPaciPaCiZExgTKr8S08CUHpY4Rv9H1giqu2OmibUVvXE2ZQ4RLEsx3iojuDy4nG0EbE6QHNQdLVoITtLwJXKne6uWwMqqp782T+2o4kAtr5KQNP1dWcCJKnZhR2mi3nWjBYzQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1f1243-ab82-4c5e-8752-08d5826e72e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 07:55:22.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0723
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w257tcg5010909

Hi Christian

You are right on that part of obj-staged is set to NULL in add_fence, 
So my following question will be why we kfree(obj->staged) in reserve_shared() if staged is always NULL in that point ?

Thanks 
/Monk

-----Original Message-----
From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com] 
Sent: 2018年2月28日 16:27
To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot available

Am 28.02.2018 um 07:44 schrieb Monk Liu:
> under below scenario the obj->fence would refer to a wild pointer:
>
> 1,call reservation_object_reserved_shared
> 2,call reservation_object_add_shared_fence
> 3,call reservation_object_reserved_shared
> 4,call reservation_object_add_shared_fence
>
> in step 1, staged is allocated,
>
> in step 2, code path will go reservation_object_add_shared_replace()
> and obj->fence would be assigned as staged (through RCU_INIT_POINTER)
>
> in step 3, obj->staged will be freed(by simple kfree), which make 
> obj->fence point to a wild pointer...


Well that explanation is still nonsense. See
reservation_object_add_shared_fence:
>         obj->staged = NULL;

Among the first things reservation_object_add_shared_fence() does is it 
sets obj->staged to NULL.

So step 3 will not free anything and we never have a wild pointer.

Regards,
Christian.

>
> in step 4, code path will go reservation_object_add_shared_inplace()
> and inside it the @fobj (which equals to @obj->staged, set by above steps)
> is already a wild pointer
>
> should remov the kfree on staged in reservation_object_reserve_shared()
>
> Change-Id: If7c01f1b4be3d3d8a81efa90216841f79ab1fc1c
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/dma-buf/reservation.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
> index 375de41..b473ccc 100644
> --- a/drivers/dma-buf/reservation.c
> +++ b/drivers/dma-buf/reservation.c
> @@ -74,12 +74,9 @@ int reservation_object_reserve_shared(struct reservation_object *obj)
>   	old = reservation_object_get_list(obj);
>   
>   	if (old && old->shared_max) {
> -		if (old->shared_count < old->shared_max) {
> -			/* perform an in-place update */
> -			kfree(obj->staged);
> -			obj->staged = NULL;
> +		if (old->shared_count < old->shared_max)
>   			return 0;
> -		} else
> +		else
>   			max = old->shared_max * 2;
>   	} else
>   		max = 4;
