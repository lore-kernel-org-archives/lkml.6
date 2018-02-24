Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeBXDqJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 22:46:09 -0500
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:31245
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752487AbeBXDqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 22:46:07 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: "He, Roger" <Hongbo.He@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction
 and swapout.
Thread-Topic: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction
 and swapout.
Thread-Index: AQHTqkqJL6PPebjhZ0OJvNgAm33lDqOxvPeggAArsYCAAP95YIAABYXQ
Date: Sat, 24 Feb 2018 03:46:03 +0000
Message-ID: <MWHPR1201MB0127B30637C83130A8167C12FDC30@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220125829.27060-3-christian.koenig@amd.com>
 <MWHPR1201MB0127CE75F5FD6DE84A0B93C6FDCC0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <6eadbbea-8eca-a1ab-93bb-d37ae6e5f29d@gmail.com>
 <MWHPR1201MB01278E573419210283D68640FDC30@MWHPR1201MB0127.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB01278E573419210283D68640FDC30@MWHPR1201MB0127.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0063;7:x24np1CxKoLooPp9oyCygCTGlP/cOd9w7sOrjb5tWzuWNOqCzzz+i4UinrSqLu4XXT+qtegEbKKfAgRKo65g3JIHOU+l2asFV+UuEtEiAGCh/ZxDmOCyS1iwmlmb9ZsUu4r66KxF7ZXAiqZ7gQQpOkYbY+5cVabNKLmfLT+ZN8myPrWb5p0szh4BrXUthDiaRPVigrI0+Ot2foc2T9GpVjuVc9aZpQAih3F3pqbZudG699wEpSiUK8tE+S1xAzsK;20:jWVlz1Bq20IATJq8FRL/qIBJcbAeOiOiTX+jyWepg0vYuA35YOgWsrq0zwZXTlR0bvh8pDdXakL8wu9zK42/4xNSgzMypJS2AA/RaH4BqP55y4SlCFsy7zXnfCpXSaWHMgg4ZMfTNsBNj7QOnP6NP6ggRTNkaEP+VltMyUC6ulPEwXE7YJHGlZ8YGnPWxPGhMN72SduAicuDq7etlnDrHhDC8lETJlFmjgnH8IE6UoGm+bK80jaRQgpzjoBZiIEH
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(13464003)(189003)(199004)(2950100002)(68736007)(105586002)(8676002)(6116002)(229853002)(3846002)(97736004)(81166006)(5660300001)(81156014)(8936002)(33656002)(3660700001)(2906002)(74316002)(77096007)(305945005)(2940100002)(7736002)(53546011)(6436002)(6506007)(106356001)(102836004)(59450400001)(93886005)(99286004)(2201001)(25786009)(3280700002)(2501003)(26005)(66066001)(76176011)(14454004)(7696005)(2900100001)(72206003)(966005)(478600001)(53936002)(110136005)(6246003)(316002)(55016002)(6306002)(9686003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0063;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9559ccd0-3c63-4a5d-c35c-08d57b3920da
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0063;
x-ms-traffictypediagnostic: MWHPR1201MB0063:
x-microsoft-antispam-prvs: <MWHPR1201MB006359C6AC52151830602DF8FDC30@MWHPR1201MB0063.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231209)(944501161)(52105095)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR1201MB0063;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0063;
x-forefront-prvs: 0593E261C4
x-microsoft-antispam-message-info: KyDFPdgtsbufCeRIcQ613ruCXdQOM54h+TFCbwaRCX2y28olM3A2lkg8LoEEuW3gLaMRlZDrAx7Wx5XoD93O0bb9tAeGqTbynaveViJ4LRpteLTEGyXlwxcplBcE0mvcn9u9lF/ly1lgAJCZV7wnaoc98CK+Kl7oh4S4iW9bJVM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9559ccd0-3c63-4a5d-c35c-08d57b3920da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2018 03:46:03.5790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1O3kEA7002472

I missed the Per-VM-BO share the reservation object with root bo. So context is not NULL here.
So,  this patch is:

Reviewed-by: Roger He <Hongbo.He@amd.com>

Thanks
Roger(Hongbo.He)
-----Original Message-----
From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
Sent: Friday, February 23, 2018 8:06 PM
To: He, Roger <Hongbo.He@amd.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction and swapout.

Am 23.02.2018 um 10:46 schrieb He, Roger:
>
> -----Original Message-----
> From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On 
> Behalf Of Christian K?nig
> Sent: Tuesday, February 20, 2018 8:58 PM
> To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; 
> linux-kernel@vger.kernel.org
> Subject: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction and swapout.
>
> This solves the problem that when we swapout a BO from a domain we sometimes couldn't make room for it because holding the lock blocks all other BOs with this reservation object.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c 
> b/drivers/gpu/drm/ttm/ttm_bo.c index d90b1cf10b27..3a44c2ee4155 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -713,31 +713,30 @@ bool ttm_bo_eviction_valuable(struct 
> ttm_buffer_object *bo,  EXPORT_SYMBOL(ttm_bo_eviction_valuable);
>   
>   /**
> - * Check the target bo is allowable to be evicted or swapout, including cases:
> - *
> - * a. if share same reservation object with ctx->resv, have 
> assumption
> - * reservation objects should already be locked, so not lock again 
> and
> - * return true directly when either the opreation 
> allow_reserved_eviction
> - * or the target bo already is in delayed free list;
> - *
> - * b. Otherwise, trylock it.
> + * Check if the target bo is allowed to be evicted or swapedout.
>    */
>   static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
> -			struct ttm_operation_ctx *ctx, bool *locked)
> +					   struct ttm_operation_ctx *ctx,
> +					   bool *locked)
>   {
> -	bool ret = false;
> +	/* First check if we can lock it */
> +	*locked = reservation_object_trylock(bo->resv);
> +	if (*locked)
> +		return true;
>   
> -	*locked = false;
> +	/* Check if it's locked because it is part of the current operation 
> +*/
>   	if (bo->resv == ctx->resv) {
>   		reservation_object_assert_held(bo->resv);
> -		if (ctx->allow_reserved_eviction || !list_empty(&bo->ddestroy))
> -			ret = true;
> -	} else {
> -		*locked = reservation_object_trylock(bo->resv);
> -		ret = *locked;
> +		return ctx->allow_reserved_eviction ||
> +			!list_empty(&bo->ddestroy);
>   	}
>   
> -	return ret;
> +	/* Check if it's locked because it was already evicted */
> +	if (ww_mutex_is_owned_by(&bo->resv->lock, NULL))
> +		return true;
>
> For the special case: when command submission with Per-VM-BO enabled, 
> All BOs  a/b/c are always valid BO. After the validation of BOs a and 
> b, when validation of BO c, is it possible to return true and then evict BO a and b by mistake ?
> Because a/b/c share same task_struct.

	No, that's why I check the context as well. BOs explicitly reserved have a non NULL context while BOs trylocked for swapout have 	a NULL context.

	BOs have a non NULL context only when command submission and reserved by ttm_eu_re6serve_buffers  .
	But for Per-VM-BO a/b/c they always are not in BO list, so they will be not reserved and have always NULL context.
	So above case also can happen. Anything missing here?  

>
> +	/* Some other thread is using it, don't touch it */
> +	return false;
>   }
>   
>   static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
> --
> 2.14.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel
