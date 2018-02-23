Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeBWJsh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:48:37 -0500
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:45283
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750879AbeBWJsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:48:35 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
        <ckoenig.leichtzumerken@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: use new ww_mutex_is_owned_by function
Thread-Topic: [PATCH 2/4] drm/amdgpu: use new ww_mutex_is_owned_by function
Thread-Index: AQHTqkqIvom5e7gHz065IIcIszu5faOxwkmg
Date: Fri, 23 Feb 2018 09:48:33 +0000
Message-ID: <MWHPR1201MB012793ED40432A2B0353C583FDCC0@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220125829.27060-2-christian.koenig@amd.com>
In-Reply-To: <20180220125829.27060-2-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0064;7:fLkoVpVu33rgHYAcY6ZBHxbkse6tJZpCKzxCTrD62+15dAq5JrgLyQ1d+gsF8ogBG860KklRqG5QZnzJRk2wR0+r+bK8AAbq/buCK/13t7PoxFRowU0V6DH2AkIoGbxE8KKFTJV+CuxZgFoCM8O6nyAcszLD11Ga/SJ/ip/dTSl3p3luRXghprrlWHKzHHxjVnbbyssUD3Clq9CSYB8Ofd54k9OqjEgbGCdhmT91qaGt0k38kA60Y5o0WQ8ctKYF;20:5qzaCtvlOQq5G7Z/nRDqEFXSKxAl+PCmS7Vp2rLchLpQAPV4yGy07rZvAQE3/Oj/tJvPik9jl2RNCEcWiFUyY0XcJTuL27S1p5gkqDSteKtr76SlclGuoeaUDm11m/hI98VJ7FulzjQT0ThhmSisXfiy7duMvdak9Rmxc19YT/5GXiA3Wm7TEmYs/eWMpKPJ+sFrxgUqC0Zo79woT/LwTZmP22yObmD6uijY/iFNEz91bTFOCIVDRoDOXua/O9pW
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e6e6c08-3022-44c7-1102-08d57aa29a93
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0064;
x-ms-traffictypediagnostic: MWHPR1201MB0064:
x-microsoft-antispam-prvs: <MWHPR1201MB0064413E963A47A40DC6F4F8FDCC0@MWHPR1201MB0064.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR1201MB0064;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0064;
x-forefront-prvs: 0592A9FDE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(39380400002)(189003)(199004)(13464003)(6246003)(25786009)(39060400002)(2501003)(3846002)(6116002)(110136005)(33656002)(2900100001)(97736004)(2906002)(575784001)(316002)(99286004)(2201001)(86362001)(9686003)(72206003)(77096007)(966005)(74316002)(2950100002)(26005)(7736002)(305945005)(186003)(478600001)(6506007)(59450400001)(68736007)(102836004)(53936002)(5660300001)(8676002)(81156014)(3660700001)(81166006)(6436002)(53546011)(14454004)(8936002)(55016002)(229853002)(6306002)(106356001)(3280700002)(66066001)(76176011)(105586002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0064;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 62zM0AqHowvpPAkiu1y3bc8ngl2X1SCmn8qFNvlmId4G36V4JuuQbRHr+9MkrQ2QApmYRkQYZwOKery1fjUKymk+6I4C2ya5Sw3LgOX1aJJArYVIEPZcHujujgeUxBluKM5OwhdD1bQnZKce7fwzeZYGRebhOIZTKShqfoyQkpA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6e6c08-3022-44c7-1102-08d57aa29a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2018 09:48:33.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0064
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1N9mefp009405


Reviewed-by: Roger He <Hongbo.He@amd.com>

-----Original Message-----
From: amd-gfx [mailto:amd-gfx-bounces@lists.freedesktop.org] On Behalf Of Christian K?nig
Sent: Tuesday, February 20, 2018 8:58 PM
To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/amdgpu: use new ww_mutex_is_owned_by function

Instead of accessing ww_mutex internals directly use the provided function to check if the ww_mutex was indeed locked by the current command submission.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index eaa3cb0c3ad1..6db26a3144dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1594,7 +1594,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	*map = mapping;
 
 	/* Double check that the BO is reserved by this CS */
-	if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket)
+	if (!ww_mutex_is_owned_by(&(*bo)->tbo.resv->lock, &parser->ticket))
 		return -EINVAL;
 
 	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
