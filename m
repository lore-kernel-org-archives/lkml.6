Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeBXDhA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 22:37:00 -0500
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:53376
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752445AbeBXDg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 22:36:59 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction
 and swapout.
Thread-Topic: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction
 and swapout.
Thread-Index: AQHTqkqJL6PPebjhZ0OJvNgAm33lDqOxvPeggAArsYCAAP95YA==
Date: Sat, 24 Feb 2018 03:36:43 +0000
Message-ID: <MWHPR1201MB01278E573419210283D68640FDC30@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220125829.27060-3-christian.koenig@amd.com>
 <MWHPR1201MB0127CE75F5FD6DE84A0B93C6FDCC0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <6eadbbea-8eca-a1ab-93bb-d37ae6e5f29d@gmail.com>
In-Reply-To: <6eadbbea-8eca-a1ab-93bb-d37ae6e5f29d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0253;7:ghy0UqeRdLX4uYSeAdC3koqFXqtvL29oLKRVWuKo4t87ShJONvDDPty0DF8AQ/4NpOBiJUwuGkDXdqSIudWJ/GKWtnO3xr4AMczkut2L5kbszx7OF1plboL+ip/+Gmzg7keCi94Ao02usyHoPEtlxqiQWnGd2zdqh+goRQqwrJOJe2mlTujb+HeSjtIubt0GFosfUqQ0Oa4KDNPoZNMi82X77BaW1D9YScowbsPEa5B/9yCGHwu/xncIJRJEFMvA;20:7DEXhn8Yf/UOCNZ3TFhWInxx6BNguQTMKnncy0S8gjdRnnyOdY4ht2bOPmOSzWtfEpnLe1R1v8Jdbkz7kN7ApCQXTNBx4JUFekjn2cousz8bf8eCgzjpO2WIIZ9ECQA510DyKP+mwquATNLC2o5IASMvwQvTtICTcHnM0BQNvmZPPGLlLlEnkda+IGvO30SxcJlJHoN/bp0YagcEwAMsKKPKjvpelYFFwQEIR8TwHnBldoirViE72AALe9HygG8G
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(346002)(396003)(366004)(13464003)(189003)(199004)(74316002)(76176011)(2900100001)(5660300001)(53936002)(478600001)(110136005)(25786009)(2501003)(7736002)(99286004)(77096007)(26005)(6116002)(305945005)(3846002)(2201001)(66066001)(86362001)(2906002)(55016002)(6506007)(6436002)(8936002)(6246003)(53546011)(102836004)(97736004)(68736007)(966005)(105586002)(93886005)(3660700001)(3280700002)(106356001)(72206003)(9686003)(6306002)(14454004)(316002)(8676002)(59450400001)(81156014)(33656002)(229853002)(81166006)(7696005)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0253;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 787f9257-cc00-4a69-d941-08d57b37d354
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0253;
x-ms-traffictypediagnostic: MWHPR1201MB0253:
x-microsoft-antispam-prvs: <MWHPR1201MB0253769C217A7539ACE13071FDC30@MWHPR1201MB0253.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231209)(944501161)(52105095)(6055026)(6041288)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR1201MB0253;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0253;
x-forefront-prvs: 0593E261C4
x-microsoft-antispam-message-info: Brjbk0c+cpxRiGTSBnOrum43ESnwG79db5SuwOcpChMBvt3t8C79WPNkSdp2PVC1UvyOGrciPEUwYrT99i7sjbvzLIlFGBGjKS1GdeiMU3A1Pjg/YR7uGOS2esv4KS7ChUDfhZe2hyoiifI/kkAtvcizxKsTsnKHBgJe3NkifM8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787f9257-cc00-4a69-d941-08d57b37d354
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2018 03:36:44.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1O3b5p4032487



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

	No, that's why I check the context as well. BOs explicitly reserved have a non NULL context while BOs trylocked for swapout have a NULL context.

When BOs have a non NULL context only when command submission and reserved by ttm_eu_re6serve_buffers  .
But for Per-VM-BO a/b/c they always are not in BO list, so they will be not reserved and have always NULL context.
So above case also can happen. Anything missing here?  

Thanks
Roger(Hongbo.He)
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
