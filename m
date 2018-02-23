Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeBWJrE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:47:04 -0500
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:34352
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750879AbeBWJrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:47:03 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
        <ckoenig.leichtzumerken@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction
 and swapout.
Thread-Topic: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction
 and swapout.
Thread-Index: AQHTqkqJL6PPebjhZ0OJvNgAm33lDqOxvPeg
Date: Fri, 23 Feb 2018 09:46:59 +0000
Message-ID: <MWHPR1201MB0127CE75F5FD6DE84A0B93C6FDCC0@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220125829.27060-3-christian.koenig@amd.com>
In-Reply-To: <20180220125829.27060-3-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0064;7:Z5ISkjGCCGcZnyX5D05Iw0ZGkQt5KgT+MlWPZi+QW5HC2X54cYKyFXvxNZR/b1cJtP4v7010MhnEkXlLhJbDspZbFRheuzXCpoXjYzOq7U670ITPmBkrQcueN3FhHl1HmEyQkkMObSSBE6aXF714qLDJ5kMvbf2/A4pt+ka1q3++8nWc+ceoDvuA03WeHV8/VOp/t3k0cgADU1FlQ+4Okte35ehXUghjlRPPl/zHTFC+qMYk/GBXGzYq7yalHDN1;20:uQo9mGIDuAlsgyCBA8KRlpYCa/qrdvb+GkKIR+KtlOCogrzOSbrgnUDe0nMRCxRyg0xvmXZinC9sxwAO3G02CGv30DfY6CBWIpyQ0ajUDen6YRnYQ9+YGXQO/dgKQV0PUnQ+wqQGqax6+hn3uSIEtSxSc34LoO5+Hes2VVelEJeJR4fwLWH6/N7W7QoZ9TTHJZx047WR7eMZSdtdwoiWCCuD2+TmgucuZQhqwuVY1aatG5qkB3M1CzQOAsqBkl/s
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88a4de4c-b321-4e9d-7063-08d57aa26276
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0064;
x-ms-traffictypediagnostic: MWHPR1201MB0064:
x-microsoft-antispam-prvs: <MWHPR1201MB00648AB1F8F4097CBD9BCE69FDCC0@MWHPR1201MB0064.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR1201MB0064;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0064;
x-forefront-prvs: 0592A9FDE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(39380400002)(189003)(199004)(13464003)(6246003)(25786009)(39060400002)(2501003)(3846002)(6116002)(110136005)(33656002)(2900100001)(97736004)(2906002)(316002)(99286004)(2201001)(86362001)(9686003)(72206003)(77096007)(966005)(74316002)(2950100002)(26005)(7736002)(305945005)(186003)(478600001)(6506007)(59450400001)(68736007)(102836004)(53936002)(5660300001)(8676002)(81156014)(3660700001)(81166006)(6436002)(53546011)(14454004)(8936002)(55016002)(229853002)(6306002)(106356001)(3280700002)(66066001)(76176011)(105586002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0064;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Gja00zneGMdaGLEGendo/CbM6KzXYKbagaMqrybsCfUgUvOYvlrOn9g9fOYdr54R+OnuhWbRmlKWc4uZAOwj+MXaE7wBPeYXYbptFpfNNixkxi5LP+D3C3XliuCKhnxEGrFbumT9tj5xdN7HI+ch+StU14vqEuALg9ufsKfZRw0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a4de4c-b321-4e9d-7063-08d57aa26276
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2018 09:46:59.6606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0064
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1N9mepu009400



-----Original Message-----
From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On Behalf Of Christian K?nig
Sent: Tuesday, February 20, 2018 8:58 PM
To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction and swapout.

This solves the problem that when we swapout a BO from a domain we sometimes couldn't make room for it because holding the lock blocks all other BOs with this reservation object.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c index d90b1cf10b27..3a44c2ee4155 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -713,31 +713,30 @@ bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,  EXPORT_SYMBOL(ttm_bo_eviction_valuable);
 
 /**
- * Check the target bo is allowable to be evicted or swapout, including cases:
- *
- * a. if share same reservation object with ctx->resv, have assumption
- * reservation objects should already be locked, so not lock again and
- * return true directly when either the opreation allow_reserved_eviction
- * or the target bo already is in delayed free list;
- *
- * b. Otherwise, trylock it.
+ * Check if the target bo is allowed to be evicted or swapedout.
  */
 static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
-			struct ttm_operation_ctx *ctx, bool *locked)
+					   struct ttm_operation_ctx *ctx,
+					   bool *locked)
 {
-	bool ret = false;
+	/* First check if we can lock it */
+	*locked = reservation_object_trylock(bo->resv);
+	if (*locked)
+		return true;
 
-	*locked = false;
+	/* Check if it's locked because it is part of the current operation */
 	if (bo->resv == ctx->resv) {
 		reservation_object_assert_held(bo->resv);
-		if (ctx->allow_reserved_eviction || !list_empty(&bo->ddestroy))
-			ret = true;
-	} else {
-		*locked = reservation_object_trylock(bo->resv);
-		ret = *locked;
+		return ctx->allow_reserved_eviction ||
+			!list_empty(&bo->ddestroy);
 	}
 
-	return ret;
+	/* Check if it's locked because it was already evicted */
+	if (ww_mutex_is_owned_by(&bo->resv->lock, NULL))
+		return true;

For the special case: when command submission with Per-VM-BO enabled,
All BOs  a/b/c are always valid BO. After the validation of BOs a and b,  
when validation of BO c, is it possible to return true and then evict BO a and b by mistake ?
Because a/b/c share same task_struct.

Thanks
Roger(Hongbo.He)

+	/* Some other thread is using it, don't touch it */
+	return false;
 }
 
 static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
--
2.14.1

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel
