Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeBWJ3F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:29:05 -0500
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:48864
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751314AbeBWJ3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:29:03 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
        <ckoenig.leichtzumerken@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] drm/ttm: keep BOs reserved until end of eviction
Thread-Topic: [PATCH 4/4] drm/ttm: keep BOs reserved until end of eviction
Thread-Index: AQHTqkqJlBBThf0PYUadLA8UjqlcfqOxu8GA
Date: Fri, 23 Feb 2018 09:29:00 +0000
Message-ID: <MWHPR1201MB01274F458B316CF0BD44AFB7FDCC0@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220125829.27060-4-christian.koenig@amd.com>
In-Reply-To: <20180220125829.27060-4-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0143;7:85E7MFhB8sYQOMaXR4vfRC602/zCoBj4jK135Ih3VQ6jo1+cRnTjTSQu/LoyHi0iEjJbPaZAY2NSan7L1edbjIOY2B4p8RPJSyl1jBltOzyvABvKi7O9WkZkN5qiSnk/zWEOqHkFwehCF7hKNxEelgMY4LPF28d/5jx9cI3105tMQRDuhZGfIlKwHMyeaeb9JNxULcwoq/ND+C8N4PlMuqaryRTjX2BxelwjpMoKZs3ZmPDQDwTHBfp8Hhkyc850;20:JtPtATwj5EhcFnI5hX26shDIaPuFAFQUJUqTy8oPQxXrrQXReFRhm2h/H21RSPiMQuCaloOEiK7bpGI1BfG11wrPEP6lJYsKoDImxRzZqQk1NhAPeU5eOvIqWm3FucgjPZLVy/Up0NJhMqy9e22G6PqRE2+JZ2u6I7UCIlHmVG+JA+AN9fKzbAAWzm7YG+xRmBUr6y30C68HE0ayceeI4eOB6FYPUfEXqPMYNbZvH5O6JFV9UUsxtI2LJ3eJSul4
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 515350bd-e32a-4431-89d5-08d57a9fdf76
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0143;
x-ms-traffictypediagnostic: MWHPR1201MB0143:
x-microsoft-antispam-prvs: <MWHPR1201MB014305F273F0B285B4897CF8FDCC0@MWHPR1201MB0143.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231166)(944501161)(52105095)(6055026)(6041288)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR1201MB0143;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0143;
x-forefront-prvs: 0592A9FDE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(13464003)(2501003)(478600001)(7736002)(966005)(105586002)(26005)(2900100001)(106356001)(186003)(72206003)(229853002)(55016002)(77096007)(9686003)(6306002)(2201001)(305945005)(81166006)(3280700002)(5660300001)(8936002)(86362001)(110136005)(33656002)(2906002)(81156014)(66066001)(102836004)(6116002)(316002)(3660700001)(6246003)(6506007)(8676002)(3846002)(97736004)(39060400002)(59450400001)(53936002)(6346003)(68736007)(74316002)(6436002)(2950100002)(7696005)(53546011)(14454004)(76176011)(25786009)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0143;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-microsoft-antispam-message-info: cy3xvmN/uZSmUovDF/MQKEmPbGsHAUfZHp86dAr+r6pUEAdZmY8TbTEYW/rrzMwOj5+MLPbBbdfzua4gevIcXT1x48KUZoiVuI/Wkp33Zh2Pv7igmuIZQgb+G5+ROclvJ9saYm3LoDcNANKLqymstXCrkjxevhb2jyl1HaRebEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515350bd-e32a-4431-89d5-08d57a9fdf76
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2018 09:29:00.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1N9T99E032173

looks good to me.  Reviewed-by: Roger He <Hongbo.He@amd.com>

-----Original Message-----
From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On Behalf Of Christian K?nig
Sent: Tuesday, February 20, 2018 8:58 PM
To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/ttm: keep BOs reserved until end of eviction

This avoids problems when BOs are evicted but directly moved back into the domain from other threads.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c index 3a44c2ee4155..593a0216faff 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -742,7 +742,8 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,  static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 			       uint32_t mem_type,
 			       const struct ttm_place *place,
-			       struct ttm_operation_ctx *ctx)
+			       struct ttm_operation_ctx *ctx,
+			       struct list_head *evicted)
 {
 	struct ttm_bo_global *glob = bdev->glob;
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type]; @@ -792,17 +793,28 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 
 	ret = ttm_bo_evict(bo, ctx);
 	if (locked) {
-		ttm_bo_unreserve(bo);
+		list_add_tail(&bo->lru, evicted);
 	} else {
 		spin_lock(&glob->lru_lock);
 		ttm_bo_add_to_lru(bo);
 		spin_unlock(&glob->lru_lock);
+		kref_put(&bo->list_kref, ttm_bo_release_list);
 	}
 
-	kref_put(&bo->list_kref, ttm_bo_release_list);
 	return ret;
 }
 
+static void ttm_mem_evict_cleanup(struct list_head *evicted) {
+	struct ttm_buffer_object *bo, *tmp;
+
+	list_for_each_entry_safe(bo, tmp, evicted, lru) {
+		list_del_init(&bo->lru);
+		ttm_bo_unreserve(bo);
+		kref_put(&bo->list_kref, ttm_bo_release_list);
+	}
+}
+
 void ttm_bo_mem_put(struct ttm_buffer_object *bo, struct ttm_mem_reg *mem)  {
 	struct ttm_mem_type_manager *man = &bo->bdev->man[mem->mem_type]; @@ -852,20 +864,26 @@ static int ttm_bo_mem_force_space(struct ttm_buffer_object *bo,  {
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
+	struct list_head evicted;
 	int ret;
 
+	INIT_LIST_HEAD(&evicted);
 	do {
 		ret = (*man->func->get_node)(man, bo, place, mem);
 		if (unlikely(ret != 0))
 			return ret;
 		if (mem->mm_node)
 			break;
-		ret = ttm_mem_evict_first(bdev, mem_type, place, ctx);
+		ret = ttm_mem_evict_first(bdev, mem_type, place, ctx, &evicted);
 		if (unlikely(ret != 0))
-			return ret;
+			goto error;
 	} while (1);
 	mem->mem_type = mem_type;
-	return ttm_bo_add_move_fence(bo, man, mem);
+	ret = ttm_bo_add_move_fence(bo, man, mem);
+
+error:
+	ttm_mem_evict_cleanup(&evicted);
+	return ret;
 }
 
 static uint32_t ttm_bo_select_caching(struct ttm_mem_type_manager *man, @@ -1345,6 +1363,7 @@ static int ttm_bo_force_list_clean(struct ttm_bo_device *bdev,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
 	struct ttm_bo_global *glob = bdev->glob;
+	struct list_head evicted;
 	struct dma_fence *fence;
 	int ret;
 	unsigned i;
@@ -1352,18 +1371,20 @@ static int ttm_bo_force_list_clean(struct ttm_bo_device *bdev,
 	/*
 	 * Can't use standard list traversal since we're unlocking.
 	 */
-
+	INIT_LIST_HEAD(&evicted);
 	spin_lock(&glob->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
 		while (!list_empty(&man->lru[i])) {
 			spin_unlock(&glob->lru_lock);
-			ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx);
+			ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx,
+						  &evicted);
 			if (ret)
 				return ret;
 			spin_lock(&glob->lru_lock);
 		}
 	}
 	spin_unlock(&glob->lru_lock);
+	ttm_mem_evict_cleanup(&evicted);
 
 	spin_lock(&man->move_lock);
 	fence = dma_fence_get(man->move);
--
2.14.1

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel
