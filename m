Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbeEOQFW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:05:22 -0400
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:19657
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752454AbeEOQEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:04:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 4/5] drm/arm/malidp: Set the output_depth register in modeset
Date: Tue, 15 May 2018 17:04:18 +0100
Message-Id: <1526400259-7573-5-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
References: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LNXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::35) To AM6PR08MB3029.eurprd08.prod.outlook.com
 (2603:10a6:209:45::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3029;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;3:+nqbV3O1CoeHDlmn0ZB7DN/I7T/3ueDtgAiMBrVcxWu4oW+u4dizlJMSyQTzW6xWkn99v8C/htiX7Xmmb1o3bgp7U9LVApangPDaYGiFfraaR3CJz6C+828kLTRfdgN8HCJhsnCevxolDgYAqGrEX/3LR0/hTXtcIIXViBPuV7lmVppqa+Ay4mKZEu0WKHaMdSrwlkm1INjEcbJwbF/DhXuLnrnzxIKtzab+Mg8fE6KiSeYl0Gn+B/VJ0y39Xrs1;25:ytidkGZC4CuaGzhJ0ZhjuKwY80oze+8cEoH59t+kSRq3rYApV/Dzy/ybVb4DGyo1oR/khBFCJURjT/daBuXvChPm5+KpPb4Q6MUmpVLgJ+zrER0s2h+SA4KykeJRU075icD4HuCF2KNF7O4glUFx8c2nbfHe0JRr/FyGiX/d+ao98WM3xRmk4WgJkpdF4m8H/FjkY8PCqlnuKq/0H6y4HDR8CPktcfN1F3P7G1rZBfWNR9J4O7bgUdEFGH8m2XKR5GKWF72sDz5PG8y8sK3jqkmgXKqANJdJMuBKjh8ufKZ+6pa6h6IodEp19vBksSmiO0LQLN1dMPKVTJCISC/cfw==;31:abGmxLG8H5tWAND3IHuXwRL095qlWvLkbgT87HCrLiTwUvHOm77d+wferVqT0i8r93OPAiAx/7Um7P9VR+GpS8JDxLjMVbJ18kJqMJPwElg59QTai6K2YzHKVYAf2ndayPOMUT8iwOwnTcfUPppHmsvTZncKGwYV33xiBFHKGkp07k/ztBKLWf3ModMuCkh3VHbbxMPsPPncgPPokD1A5XTQkCpVnMzajPsRVA6SK38=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3029:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;20:YMeP/iOYtw1frvkPT92joQw98/7JGSWFjjiEA9U06kBks2dUhNvuGQkbDEb+j72S3/NyzB+7CZJxHnvwUgsUnP17v+4Mb86GgaMeFpHSFN8cHnAP1U2sLFBEZXKqtro50ovaN2FmLMq52Lbu8i1gCkbtsgN/bslx1Kof4a2OzTRhRY8npdeuWpxUiarv1f11Ux9mjFMDlOfOjygvmoyaAW9zuD2ULk2qGnfsbwSNWq1zf2mRZwx4K2o+NWETYsh7;4:8SVyAxA5TzdJ7UWCR8aCID6g9ptlb19LQI0Okj13GGTIsO1uXgPECLL8TDdPRRFHmCOSl1JHqhlGpUQEQGMmaiajDMR3mV2p1oArhfVsyk6k54B+jovhz0yE0ZpWR3gVAy7QdXiTsdHPlyHChfEbzoIgyIDt8fSlNjcdDQzzQx7eygX5vppMjXBKYXai5PxRV+SajxNClNDXYta9aQKrM5t+4b7O6ERAJAJCoJMiSuGLU6uJwyuhpHNo+bFyNX3R8qSiJex7zbNB92Q5PO6dy35bTcfZZ5GGU+mjkT1QRYbP8ZHZ34f2ToNSTve08KSX
X-Microsoft-Antispam-PRVS: <AM6PR08MB3029DA435AFFCCBE2B1564C0E4930@AM6PR08MB3029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3029;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3029;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(3846002)(16526019)(68736007)(53936002)(5660300001)(8936002)(2906002)(50226002)(59450400001)(86362001)(76176011)(52116002)(26005)(7696005)(51416003)(6116002)(386003)(446003)(2616005)(316002)(476003)(16586007)(81156014)(106356001)(105586002)(97736004)(81166006)(6666003)(11346002)(956004)(486006)(478600001)(50466002)(6486002)(305945005)(48376002)(4326008)(7736002)(25786009)(47776003)(66066001)(36756003)(72206003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3029;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3029;23:LF1asE5bqqgOsJLA/w5u4wOR6yZ/MyHWKIOptalk6?=
 =?us-ascii?Q?SdLPPNtpdTSGIEDbiwyaZAsxoF89HL24ADtRKJR74e8PPQx1s3qCIiKtO5cQ?=
 =?us-ascii?Q?l9+iiyphuooRxkhKILoup3Sfczfyrl0VciEkS5KwmZ8HFrm+9vkCJgecs5+l?=
 =?us-ascii?Q?ooWD8Vtc+wpvyQIkbHfjKJja20TAHRhn+XwRmtQoXMNCuNFJfBoITvYB7dkK?=
 =?us-ascii?Q?JvGsd3aHBbMgbKcN+GvV09mxeva/iWVcb1GFWf0FTgLU+M3KqGjZ1IdmCxJc?=
 =?us-ascii?Q?WSBXd7Qm+xnAVN00iTzu1/NSFK3BcpBIL78V8pJjZnYYM8HUeRveW0uL3UZW?=
 =?us-ascii?Q?wNAvhooz9b+KCPBR7rp3EP1BeBlJqc33tDDireKWvudI8PHb65PCmt7dJOHG?=
 =?us-ascii?Q?LccA9VjA38/fUDNmTd3G7Rc8XmTJLzuMhLTm3d4NDOpqx/pgDZ4grrlI3vbN?=
 =?us-ascii?Q?eB5rh6WbRx/MC+qGtH0ALTgGwpyQKrka9hR+6yYjFp0e+MxKC/0daDgZHYgG?=
 =?us-ascii?Q?u575yfF/khDZOXcKgOuT7LLrhoQWdJ+IllfCB6VuV1xA+TAGCMiN8C40Ckg0?=
 =?us-ascii?Q?w00wNyOUDrVorN8yvEyAz5sBO0FsqPSeVCGWqpPW5Fq0bvVqHcb/9NkcYHs3?=
 =?us-ascii?Q?ayZr+1yTmd9QJTAx/pV9UFdjOr7ZSaKZUa6K3Gnio78uTAFZCCDxcRXSWpTV?=
 =?us-ascii?Q?XfVlKsDk1zXwVeDvTtPP3/pIBzzAOE+L43aACElOEEh51iyIKZ2jOvHeAp8S?=
 =?us-ascii?Q?sMhlvHZ7s6rKvqIbBRr9c8E0cMpcW8qvRbyGxEfx0zUa2Wr+xLULoVYKEnz8?=
 =?us-ascii?Q?ZX5Jay52rQvsUiCUMF41tTs/8csvGKafyJPewiIRTU/+DtykfCDqCBTAqNqQ?=
 =?us-ascii?Q?B/n+lRUmh5FmLJ+Dj9ee8h5AlQotsbp8ml7r89THC1RPpfNzpmFpAw/1DuAO?=
 =?us-ascii?Q?m3t7NPkZVLgBt3mDnytLEHh7oPcA4iF8gh8bXdHz5Czo5VndLTsuseJaEeFw?=
 =?us-ascii?Q?7ZX7LzjZGKll5wCr0KkIJvsTSX8vJekf7aLUpcQsIND2YWk8GZxNjHlTHV66?=
 =?us-ascii?Q?Azn/xyKoopdBwWtMXGEuXa51Yu5dpWt7uMM5CQ7iL8CV6ROrvu+pH5kpRLym?=
 =?us-ascii?Q?xk34ykqriMKYnXsEULeJ4Ufmtp2+F1tlQD4gE8sDWXOEwYes1I01g=3D=3D?=
X-Microsoft-Antispam-Message-Info: nXYUJHfaGwu3SCVAQ5MvbszKkyqUxfJiHOVJy+eWrfJYPOfkqFcR2ZNGZG/8fCcFNDdLrBoFr9Lal6bjRjevyiY+gzQrAF1SklBpyAiFQHui3/RIz/GwsemjOSSim7PQ7dcZAHyZcptdg85Dr7fc+v/eclst4fJOos+yj8TCNib3pP4LvaMiij0Cd/qSbulo
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;6:H+iVnaATNi1XGtdfFTUgedf/z4rDNP9ffNXyNtyVIFOqX7c8lMKhPChNt15udmu9LHNhGal8VaRJ+jRPbdssDTrAUCCJMFdLTjy50Leg13aDbyqvZ8ILHKWmku+h1sWTE1aycizIBZzXzcohJ5aTLM4e/Ha18MlINGnAAI/6KDSBa5F43cw8RDFMdImhD6zFX7CoX0SIevT2mMzXW4IbL3HvPnLWCq8LV/YlkvZGQ0kFqgVb3OJepbgRlTGl76SglxJMLanrPXfcpX/Pf0+vD870t5wlzLkFlyk5QWij/8fteTsmyC1iqx2I62neV6BU6rtDp7shxIVSESQG+QV7a3dgZvup5XFXYDQWA08mnJXMcnlgdqOAQrxSYrxnH/EuKL9CaDwXVNK5ZumZx2ufJv9MqjN330yWPEZmXQhvW3kumJkni5zjcjDICSRByS2lEr9EkaByKrRPQhR0K8je/w==;5:oXC+OarDh1Hl7bIs+PSaXWv9xNFMEDbXTGgiHxXU2Ol9z/ED7o4rTYxoanf45l71IRge/bkkuxQYh+dxb/4dxGQQfWQGGEMS85/OtGqJIFhM/38iQj87a5dTWqcsiiMMiO+6wMvewx5xyvtnhxqsGb9o1fCMUJpyuUUTNQF55jo=;24:6XiSeZUgDqTkmLeu17FikztBX0c4FPchmyDKef/goBzPdC0OAlcI6NAzt1yaz5Qgap9vk75dMVaeuAzfrE06KpgXMvadTG9v6I9BcfytYAc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;7:DOA1f+kspBEASlbZjuFu9wrPJpnoWQ13BdopFNDmswSjLjOWpb4CKRMvND2qVsSra9cs10itzV0FtehU8p4HGn+NLaKPl3xI/yss+hWVXFCati6BY1fDcl8Og0FDBPrqvh/w4Hy28i4xvYY2I2ifkpHFOq90D1+Y3Fw15Cf/Tiur6zsRSdfcJbg4oU7fxMs77w5A8HsxAB4nZmLxphfGcMe4f/bIEQLA++b9BIx7mBV1iBDiGDkAx07OossjC06O
X-MS-Office365-Filtering-Correlation-Id: eef7e9c5-eaea-4bc0-3c5b-08d5ba7d8d58
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 16:04:34.5810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef7e9c5-eaea-4bc0-3c5b-08d5ba7d8d58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One needs to store the value of the OUTPUT_DEPTH that one has parsed from
device tree, so that it can be restored on system resume. This value is
set in the modeset function as this gets reset when the system suspends.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v3:-
- Rebased the patch on top of the earlier v3 patches.

Changes in v2:-
- Removed the change id
---
 drivers/gpu/drm/arm/malidp_drv.c | 1 +
 drivers/gpu/drm/arm/malidp_hw.c  | 4 ++++
 drivers/gpu/drm/arm/malidp_hw.h  | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 983b854..82221ea 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -603,6 +603,7 @@ static int malidp_bind(struct device *dev)
 	for (i = 0; i < MAX_OUTPUT_CHANNELS; i++)
 		out_depth = (out_depth << 8) | (output_width[i] & 0xf);
 	malidp_hw_write(hwdev, out_depth, hwdev->hw->map.out_depth_base);
+	hwdev->output_color_depth = out_depth;
 
 	atomic_set(&malidp->config_valid, 0);
 	init_waitqueue_head(&malidp->wq);
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 3f53f7e8..52c7031 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -233,6 +233,8 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 {
 	u32 val = 0;
 
+	malidp_hw_write(hwdev, hwdev->output_color_depth,
+		hwdev->hw->map.out_depth_base);
 	malidp_hw_clearbits(hwdev, MALIDP500_DC_CLEAR_MASK, MALIDP500_DC_CONTROL);
 	if (mode->flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		val |= MALIDP500_HSYNCPOL;
@@ -457,6 +459,8 @@ static void malidp550_modeset(struct malidp_hw_device *hwdev, struct videomode *
 {
 	u32 val = MALIDP_DE_DEFAULT_PREFETCH_START;
 
+	malidp_hw_write(hwdev, hwdev->output_color_depth,
+		hwdev->hw->map.out_depth_base);
 	malidp_hw_write(hwdev, val, MALIDP550_DE_CONTROL);
 	/*
 	 * Mali-DP550 and Mali-DP650 encode the background color like this:
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 864fe92..6e3db57 100644
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
