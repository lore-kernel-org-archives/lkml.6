Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeCZREZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:04:25 -0400
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:26496
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752687AbeCZRD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 7/8] drm/arm/malidp: Set the output_depth register in modeset
Date: Mon, 26 Mar 2018 18:03:19 +0100
Message-Id: <1522083800-30100-8-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:803:1::31) To AM6PR08MB3032.eurprd08.prod.outlook.com
 (2603:10a6:209:45::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bef17894-bc62-4290-e082-08d5933b8b31
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:bRPddDL0/0iLzlFxTwtmF1nNTdMTq9OR1uRq/8tGwMCCESeMxnLVpZayX2o4pC0YRaGHheO0mKXs7kO5cxA/o2R9GEV/m4XXQZflhy9HWa0blkp7hqXPUJrvOIgcfU49qjsYFC79Gff5ZWll7cg2Ef4vY2k7BpXrLtcZv3TS0FXes7oyul+HmTQmitnvToR/Kio2ho/wTR+g2dXMlcjntEYEnBzr1xI5jU0qeQmbdRSddcNSc98Ka/TRYg0MZ2Uf;25:kbfdtgYyXbIJCu0F44WDr4CO70NLLR40rwMpqrlE0TEFRgJ9Dl4xgFr7lA2RAggFvqg5npglNRIXfjq796iD+v7MdmAn9WPXyhN3KmaUfFqFJYU81UTJdcJVwzLXL4f4FAXfhgGtP6d1+piipHNTRykdUWK7tOXoRckqf/gYlPF5pEaw+h9KvWdwaj00zBQUh4Vd1BSuJfrmZiC8VuP2vALRmOjo3gOTzdna2yt/SdrWbbLYXHh7z02e2TjFusIVJARS1nAFJlwDbRSCcLEXbhRAuj2oeQyJUOQavJef/S6EitJnaH7jL9eVzGXc54EkX4qmpPYMrbF5OfEcFNKQIw==;31:nZKsHJPBSxJM/M+5PKbv05L8jKQ8sg1mH1xzmmvJ6QmcgAFo3ePkKSVoRsuwXz9Rr+GKToWjvEXzNOPo1kxo/1Ky4f9Hturu/wSJjj2DM7wi8Sre4xUKOw6vzB7Whti5fcIebmFtdQ+w6n9pGyrfVPw5kmnPzCtKrl4LWf22FbiBRG8RDIolSuXbDDIK9A89Kn2enUJK0VtJuL9yqOfYEUO8BTSQopXGsosLTZaKNts=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:+Oh8TnSovB0z+mxzKIwKGiXUIuveV2r9qjcJ+/8twXjDbILU0oNDld8K1Ur+/2Y8/Hi3EHxbueEi6hqfJLsCYNtEDqx70fZV0S7vya+FiD4xcF0PG3861lA1jLSzViTKgecFABryF7eMj1lMQdqcckW69fkZr9VrKt9TtNVXpMI=;4:dQM0FbwDo1RC+Iy0vsN7r0zu5JDSDJeyDM6ScNCcPxo4wpY3CRWQzYLVmeD6LeTPZUmB29tfawd35sf5qmswXHdhsv52WXA13j9UEAyohTfOlLdI/rm897QUBIDKzPtqcsiKg/kv92QLeS2+XUlutqHJjmfqf6hgKpqTQ+YAcFKOW2S9d0MmTF+1r2h782NcNPf+lXrr0N/+2RiRbjTzoGtcloHdOdNywEtbuMj480J49VJJBdNjdelXoaPz4/2h+kz18HGtCRErxUnXQ9xKDOIsys4NyA8IQy9zxJeuVfHNqd2oAPHUK9N39JLRx3T+
X-Microsoft-Antispam-PRVS: <AM6PR08MB30323F061AE5C36B05D12D07E4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(76176011)(305945005)(26005)(8936002)(446003)(86362001)(478600001)(11346002)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(59450400001)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:pPSlPfMuQM+0wshlEKSXWVeePSz/Q7nAa/C7HbGlw?=
 =?us-ascii?Q?pOOtUTduMVV7Bc2EhJfSLNdXO+TQBg/uA0Wu6ZaSd/ussGxHMwrNDxWq9jot?=
 =?us-ascii?Q?owfSzusxVVexO0NP/zPAmYI7LnY31dUeb1YjmHY8Cf8SoRr9Ar2pDvweUApd?=
 =?us-ascii?Q?vysfIs2SBMK4q7sMNr26NMWQiH9FTj9Cxi9xAzCU+7Cjr1aXZKhRYaG4Alyh?=
 =?us-ascii?Q?pReA2rEuzqt4cpP7TzQO8thHhsOnubwGhaWoE2v8PWWejuOADreINcfnsIRI?=
 =?us-ascii?Q?zxQ9O392beaRoPGlLxn2ROANIPD8htS5RjRnzpKCVCD+A19AY1YH49zBFGfz?=
 =?us-ascii?Q?0NltQ4yqAXXUwx05ximX9deSGVAoIQXGRkTbCmDO+wLsGcuo4EG+GE4t8Q+p?=
 =?us-ascii?Q?erDQFXcyOhR1w78MV0WbOM7ugY/LVrejLZHhiyMuPZv7QI0NL2hqwBzeP2p9?=
 =?us-ascii?Q?wz6/R7TF+/HFCnl5eWt4TF7iEmCG86Y1tsl1wFj8+xmSX3YG2dj7uIX/wSo6?=
 =?us-ascii?Q?7o3BWbKwYGaG902JUEPQsmquX0OqNrCB1YAcv8kvbWuK3rC6aEsINQNqIcR5?=
 =?us-ascii?Q?REiKjWBV5AhtWx1tEQd4mu43khcoHZHejcVf3vx5QWnjaaiaH9vCC3X59Bc2?=
 =?us-ascii?Q?l4sHrqPj38Ppt1JE9oFkL92LvhZqYW8jR/WH0rUGv5H+dHZAU3p9v/PyIxpP?=
 =?us-ascii?Q?fDLNxXQSSokfWtzsQ8t1qPNGjkY6F+fOfpFwa7jDp13zQG6JsorefE52/1Cg?=
 =?us-ascii?Q?VGckz3PmKVcCJQQuNn7AbapXfAs8L8a5xkQxCjUNz2MCGpGfwTsag1eo3MRB?=
 =?us-ascii?Q?byNBp36C//ZfwIXw3nW81eM3ze9pqgpGvKHP7I+16h53X+yeKtahKG2/eqlw?=
 =?us-ascii?Q?QCP/f5JvtGXIZmfEncDQEoovBBfqnbmSjgGDIcKKSSg9bTsrDH4pe/oWUSxq?=
 =?us-ascii?Q?U3vQrDBmu55bZLzchMq0vzeCXl0HToGtINvkVGVJoNNGcB+VRs0gUfOQ7y0G?=
 =?us-ascii?Q?21Tqlxct3ET9GiYZWmKbIRq91uCpzfNnXmIQt4u65Gt1lWjMIhLcq0raq4uv?=
 =?us-ascii?Q?Ft83PxQgQ4r2DdMoRA0qpF526rt+reXqQl9bGC8k6bGJYukGB8JH8kiLs3z9?=
 =?us-ascii?Q?iX03aHybVYAq6Mpbrvf6PBG7aLVNqDv8BqinLafRawCNGxAkelkW0I2Q2Tul?=
 =?us-ascii?Q?RD+ztF9o2szY98=3D?=
X-Microsoft-Antispam-Message-Info: YTKalsGwGitFpgCyOdOnIK6lkuJIoMkwYkEss81eKi3CGKD6ZrjeHmf3c8nG+twjkLKoB+5BxsII+smeAM9TDQVTBXr50uRvp1mIyZUjs/cxXof8uKdZw3fg7XEGBeYfpYbp1Jy+rqz3FO3oSwIWdyFjwPAzUy8a2WQmPeZpgK3QyE139U5JykGsgHAgOFEq
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:Ra+iLrAPiqsKuuVk2PLrgU+AJQg7yY8HvNiJboaSFNVWKfefVEjJ8JI7wEDFOh3iFEiP9lOrdVCHjVmxPhsU6jfj2aY4OuhVlgUUqxqkx17Dco+WL1hH2AAF/uhHV+aCmbaE0rbsssf5utKGNcGHjs/bNelRUCocHCwZr3F8hCt+5XgbTc3xMCROPNJ7YCA+rX6oxRyI1Oqi27Dpa6sdWNG9+QAqT+zHVZ5gg3jrFMbNvP2/JFfM59HI2AIqEmHmFWNcY0bxnPaPJVSY+x4Ms05Asxiha9TopFttQcCyTeiDEHQI2KasJO3eytrE/I+hUVtx9MyuxmD8z/EU2ayMWwsVh2ZoUjso9UTtrreL7/ds7S1K+MCkq7zn6/ac2d0g6gekL1RJXPQ1096vvl7EOyJQZEI9wvZJipsvCdF0IaZ4Re015UdQll207xVh/VQ//N4jgGcFR8e/0aVPThB0Dw==;5:fsWx7k3XoJ8HMLduW3ni/aFCJA/zTalzD9Zy389hnlgjtwbLrWCSF4VMr8LuIKUYoyxfrpBJ52iBQJjnDvEojLwKLnSfHHHPMjh6YgKb+KOcXI1jZC1QSIEcyky4SKJjrvPmPdXYlXtHl4utJms2G2mulC+W3/ClbRgagjLR+nE=;24:OQbn2n0PWi2jTyLs5YMjWyCUY91tHqodW+CxrvBIn6QI4G9aMndGwL1mFN4Hq3hLWJjgoSF5v5yG2WBCd/kB/VGga5AbHEmx2Y/H9yxLhLA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:YmQsbB5irfRgPDDt1HZ2cwO3we8Oiqq0PLtuFuOKbZw7LLD32gl0p20hpBtm3J9YO0DbXe/4kzhiiboycFppe5bEP7DrPJVdEQuhsznLmfgZlhFRX57HuccwT1ymYJodZS0DTEDTkMB6Kde9dJ7oNOAFN5gEQP5hlvbZ3tsbXMWU4VC0Hjd8lamn8IQ0NybtLFFXb+A9+s8Hu0DyZpiLmVZKCicuuRq8s5EXUeoxvDaykmyLUDOpCXkRmFB/lzG5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:48.3885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef17894-bc62-4290-e082-08d5933b8b31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One needs to store the value of the OUTPUT_DEPTH that one has parsed from
device tree, so that it can be restored on system resume. This value is
set in the modeset function as this gets reset when the system suspends.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Change-Id: I361b1214cd4e5005d21eef3ca6bf39ca90be2506
---
 drivers/gpu/drm/arm/malidp_drv.c | 1 +
 drivers/gpu/drm/arm/malidp_hw.c  | 4 ++++
 drivers/gpu/drm/arm/malidp_hw.h  | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index e5a1fa0..bd44a6d 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -601,6 +601,7 @@ static int malidp_bind(struct device *dev)
 	for (i = 0; i < MAX_OUTPUT_CHANNELS; i++)
 		out_depth = (out_depth << 8) | (output_width[i] & 0xf);
 	malidp_hw_write(hwdev, out_depth, hwdev->hw->map.out_depth_base);
+	hwdev->output_color_depth = out_depth;
 
 	atomic_set(&malidp->config_valid, 0);
 	init_waitqueue_head(&malidp->wq);
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 90d76e4..1bf10fb 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -234,6 +234,8 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 {
 	u32 val = 0;
 
+	malidp_hw_write(hwdev, hwdev->output_color_depth,
+		hwdev->hw->map.out_depth_base);
 	malidp_hw_clearbits(hwdev, MALIDP500_DC_CLEAR_MASK, MALIDP500_DC_CONTROL);
 	if (mode->flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		val |= MALIDP500_HSYNCPOL;
@@ -458,6 +460,8 @@ static void malidp550_modeset(struct malidp_hw_device *hwdev, struct videomode *
 {
 	u32 val = MALIDP_DE_DEFAULT_PREFETCH_START;
 
+	malidp_hw_write(hwdev, hwdev->output_color_depth,
+		hwdev->hw->map.out_depth_base);
 	malidp_hw_write(hwdev, val, MALIDP550_DE_CONTROL);
 	/*
 	 * Mali-DP550 and Mali-DP650 encode the background color like this:
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 3b049d0..844732d 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -228,6 +228,7 @@ struct malidp_hw_device {
 
 	u8 min_line_size;
 	u16 max_line_size;
+	u32 output_color_depth;
 
 	/* track the device PM state */
 	bool pm_suspended;
-- 
2.7.4
