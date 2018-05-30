Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeE3L1K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:27:10 -0400
Received: from mail-ve1eur01on0081.outbound.protection.outlook.com ([104.47.1.81]:12793
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753218AbeE3LY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com;
From: Lowry Li <lowry.li@arm.com>
To: liviu.dudau@arm.com
Cc: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        brian.starkey@arm.com, malidp@foss.arm.com, nd@arm.com
Subject: [PATCH v2 0/2] drm/blend: Add per-plane pixel blend mode property
Date: Wed, 30 May 2018 19:23:52 +0800
Message-Id: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:3:1::15) To DB6PR0801MB1975.eurprd08.prod.outlook.com
 (2603:10a6:4:75::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1975;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;3:V0It1sMuJPp3OKVGxtQJRKasTxhSycBgD3fHq0kbLHV+aT1Xb/+ZpHsEl1KadZ5I7/bO5KVt1NvXOSsbvEP7JnSZoYlkJWPMTOntnpzqsQ2FRNHEgPGBOicp15ayP9CX/DFjKdU2kKv2pvw/tgsQFuTr7P4YYHXA2H+2lws+CEoGsN70A+yFdjNawe9Lh1WVaUKblLIrQ7MGVLxXQ+CppBXqQu7fTOulyD7A47cc4FLIml25CV/Bf1JWW4iFVbFe;25:/W0qWYEx6TwMIrot85txXqo7S6mFMgBwdKNF7uoUStyaR8QGVGLiQ8F9jPagfUZu/+CKmIPQ+HZTOlgFtXllwv8SUI+7al76MGbUEyitS7NkF+WTROkEr3K9UIfQYyTyBICEXjJQZDCW7UKhchkfJOtPkZUmo9ViVa29B+/bD6+xXdPcLYd2xyj0BYPB3EeH9hnRiQv9Rz6axLortC6XIURQllOL2LrOUVZjRgxA9MxrzpLPR2PeRfwUvdBCIyE060vNcjoBR9FdO1mxcd3FavVbYxG3lGRowgTxuKAujZg/l8mwYbKXZNc0qmNTaf3QYSZYRzZ6dc2htzhQ7i6Bzg==;31:e9VJ7mwLA6hS3DJOXRrqlz9puYpj1YOiyaFvIo4nWEeAKOISuGD/zw4mIvUVhWqAP34cnDQy7oykECCTY+2sNEFlFZLzlTQGQ/tsIlo9/ucr9+6TwW2t0oTQ93hozYM1G5jI6k/LUWm73NB3YI8NYYqMJe14tTn04Al4WyrmA0xhW+4r0DW1x+o1xx7pPM9ANLbzpG8f8gt2IPZMQ5FSIfThmbg/eNcj7cKiGyf5D3s=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1975:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;20:r4xrvQAWuPkDPxNGPYLw4P9t2t3IH/VzoVPazad7XAK72BKtqGqGKEs4nVju47xlCSfd0ETLg19v4jWQOAG4ABHKsWA93phb6EbMKVW9n8wgj4bpKwSfG6T+Xu8gBK4iFTz26ArcD6m+IvX1WxpNSbt4M1R0sQ0psJvXTvi/SVUk1/cHe/VHKENfTWURtw9SYDvO69tBB9bL+ws7h4bMlJZc3wUSVcsU/g0fcdBgUEfujosad0MtRMYPO26o8CLa;4:TUj/9HOEgdcAZVIOGhZYynHfhtKNq5U6qdCP6qCzEkSpurKRsD635njsawpY66jQrDO/sLX2LhULaO14M9rTdbZtwsdttj4gh31HcQfMT34YP0Fgm2K/vPM/UhNyyr4JbaKAcExU2wOPELlSMIrS2HWvpNT5quH/vY/PAy1UN6dWBwSNgE1VYzPc5w++KRv3357Hf+uDd1qag4J7U/EehblS5FxSfjn0d99bIMW6N+pJomkff2KHrBHMDc/4OgbV7S5iug60DPMJqpCzoBYmvg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB197589EDFF331A64CE2566439F6C0@DB6PR0801MB1975.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1975;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1975;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(6636002)(6666003)(48376002)(8936002)(8676002)(105586002)(50466002)(68736007)(2361001)(97736004)(2351001)(106356001)(50226002)(81166006)(5660300001)(6116002)(3846002)(25786009)(305945005)(81156014)(86362001)(7736002)(36756003)(47776003)(51416003)(7696005)(4326008)(16586007)(478600001)(476003)(2616005)(956004)(44832011)(486006)(37006003)(386003)(16526019)(59450400001)(316002)(26005)(2906002)(53936002)(66066001)(72206003)(34206002)(52116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1975;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1975;23:tAZQEpe810raosZwr8/hNXLVD/NT5Uba0Uk1KCX?=
 =?us-ascii?Q?21Ckgmjr2MWM0egXdQXIDo0gCBienyu+4vok1fqCoQn4SSPqTsZxVdLQjqhH?=
 =?us-ascii?Q?PqJcwNP6j8b+DZ+uxvi1sdndH9f8SJFWn2YSp/1FxlvTkfNXh4+DnPEVaG3r?=
 =?us-ascii?Q?4cGshYv4GnZBF+O1n79KOtV8yby/36KG6WBknKZW9SJ8pC0RRq+9yl+ewDJQ?=
 =?us-ascii?Q?wBsMwwUzgxgPkbVabmgTO2RgmOr11k6EFF0xF6r3YxY4TQFY928IIidUrNgj?=
 =?us-ascii?Q?dCiAxM3WzeiQPR1Aqjctw0AXbtxCE/2FcOGRvnwaJsjfPEaz3nusL4HZStDx?=
 =?us-ascii?Q?szFwV0KCcxfVfWT55rl1m1cqM3DdGoBpPtPepD2790kbGCswvw7P8Njg6LNx?=
 =?us-ascii?Q?gICgHppHdlvTTfjpkYlQ2Lq0WOYfy9oN4VqwcmqH2kEXomBsWrk5RwnLTiQf?=
 =?us-ascii?Q?3+ZFI2LI/lBx3StKhLH6VIp3m1dQ+b3C030/tk4mcoKd3aH7Gkzf/YiPSgL4?=
 =?us-ascii?Q?Fut65PQJ+ODOvPHoTq5rIH+oDjJRO802dg5AKcbqmfbgOygjw8N20iLqDAlJ?=
 =?us-ascii?Q?QHCsMoxKoXTQ3SLNazCBNWT2ocQIJ/Csw/hgiVU7k8vKo6LgZbmm9WcVkTBt?=
 =?us-ascii?Q?IsQazb9XpDTPC1rUC7yOra9rPsdx0qxJ5i6q0h+aP9ClYEhLMMrGc2UgCJ5R?=
 =?us-ascii?Q?fX5SPqMXIhuYGourx+wNnXonNeXh59kTTP1/DLhI6MB02k5n3R/pMBMEh5yM?=
 =?us-ascii?Q?81poCgDrPb7QVs75lFumSMn7LUGRDH2bAAIHe4RByvlGEPq52VO6KWAfJ2ao?=
 =?us-ascii?Q?t64bfIar/gVWX0TJFZZ5OkCVk/ovuKTS5PymhWR+JUPqR1pztHproT64Umsl?=
 =?us-ascii?Q?ztdHGWkoTcWIlVBwLOlHTkKIW13ltzgFnKOy5p7XJs2AWBYkHAqRsczy9g26?=
 =?us-ascii?Q?9CmUYWHjiB4efMObnfQXogHa1e+mm6TooDhaB+mxXUmg484tSs8YyKt2k/UX?=
 =?us-ascii?Q?YO2GJginexwkhKyXLP8zNsG22S/UO0m+B4RW/2Cv2TkUfOAoU7Zyby7haQxx?=
 =?us-ascii?Q?C9SFP/unL6EeHsClACjK4kuhUwiqhSoOWxVcrdoWUzxgY5zHHk7XtJuzUFul?=
 =?us-ascii?Q?hT1kZEOnOfVubyb4ObJBoT82YV9yUJdKhXLtYPs8J74XCRu1avaXfiXPFhXw?=
 =?us-ascii?Q?XIvXTze4EaA7q250RpOtZHmVuWQskxWtMP+bdJRabwoQAbGPj2Q87U8XI9Q?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: iWVfpQ5xaV458rw50WbbrUA1dPn9TmoQt1Qh/d1L2W4mZgUycKVCDhnI/p9KDaxc9qkDkVqjcPUoMRdTFWGXTUIzFmCaNgtb+EX/TCwTx8JV2OH58PUDsi6bOQYAJJxDyXgGBxu4hE1fhyifWTdwhyUkK1ZJByl/3xmNigC4WBDTdi8XURlGPnqNV0GCFeKG
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;6:4AHQJ8fNT0WZnR4MZG0Kp77z/ssbHdjNHvu0es+TrakgVQtH12lTKqzJG9ypMHgBsJr7KF+6ZEI6pWczdGXvGlJQeM2LXb4eNQK/zWzZ1Zx5fp40d07Y/YhsuXxWlTMiJ38TOpc6vOusoH3Oe+WYPJFaAsQtPm2Pl+m4iU2BnvWOzTuLOEiUxB8nhff+k3mhVV8plOQ9Jr42heIMgT+7qxd2DRxFrRHdnHdBdC2+jyRL4kjHyEfis2LFSKkVWYQQ9fS3LB8ku8yUxGnbwu51Zo56CrTyT4eMYKJ85v0fSu2o9AdOSZvZHxFvBay8wwd+r5XSCcjNeDq2o5HbVJp/dvR5j5vdO30CAVvbQ3DPDnhw3uXGkCv/zODo1kdMEiMSM9QzCpHB55snPQz0Qfr0GRb7e427z2Movm8AmgL5rr0g+kEj5b6Dn94wg3sANr0vDU8i9df8q0jTRnAtWEqAFA==;5:sOEeLSb/+lEm1wtLvRmbxMqE3dlUj+jtQw7J9tJfRA4GmLxz8aANgPnv90Jp6BArFP1+PAgbCdj2tyDmQvKC8UQGMAyXGhms/yoZNZY4QBmlnLJUG0Rm8G2ZMIOOgDrc2NiDIs2WJj8EEb/e2Qm1i+lSR2Yk6HrlttO21K1fF74=;24:SUThwUo+2XDp08HTFXGs8fSgThSZR9Pd+KL/KNLxUeAX6NwQUpbYUiG8C63nwUdMbU+FyDDn3agomA7Pi3Zma3P/Ra21eeWzkQGKkUNKU9U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;7:9KBha0XHwGVBhQBFjVrqQ2IlfqLZTg6Qof/0AFfw2A9393YA9NKzSCXelgeJzOzGf+6zoO9BF2VMh4ONlsJ1s3RRJJFrIWV0FCZr1RpQIVsD+G6bShKH0eC5cyhDnY4pwMakJRP/4FhHSH2KLR6WqtSSM31w9/s6KbOAM2md8erlXV5X+cgaTisA/POx8aHsTxbT6ZBCjPxcN5KGqvVLR13pWN9/4yG/btwDqKc6xAJN807slZd9w0JbtOZJQnm2
X-MS-Office365-Filtering-Correlation-Id: 8b94229f-350f-4d96-5a06-08d5c61fe77e
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 11:24:22.8909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b94229f-350f-4d96-5a06-08d5c61fe77e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1975
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serie aims at adding the support for pixel blend modes represent the
alpha blending equation selection in the driver. It also introduces to use
it in the malidp driver.

Let me know what you think,
Lowry

Changes for v2:
 - Moves the blending equation into the DOC comment
 - Refines the comments of drm_plane_create_blend_mode_property to not
   enumerate the #defines, but instead the string values
 - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
 - Introduces to use it in the malidp driver, which depends on the plane
   alpha patch

Changes from v1:
 - v1 is just the core changes to request for commments
 - Adds a pixel_blend_mode to drm_plane_state and a blend_mode_property to
   drm_plane, and related support functions
 - Defines three blend modes in drm_blend.h
 - Rebased on current drm-next

Lowry Li (2):
  drm/blend: Add per-plane pixel blend mode property
  drm/mali-dp: Implement plane alpha and pixel blend on malidp

 drivers/gpu/drm/arm/malidp_planes.c |  76 ++++++++++++++-----------
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 110 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   6 ++
 6 files changed, 171 insertions(+), 32 deletions(-)

-- 
1.9.1
