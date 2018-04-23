Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755504AbeDWOwE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:52:04 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755666AbeDWOvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:25 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 7/8] drm/arm/malidp: Set the output_depth register in modeset
Date: Mon, 23 Apr 2018 15:50:50 +0100
Message-Id: <1524495051-3891-8-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
References: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::17) To VI1PR08MB3039.eurprd08.prod.outlook.com
 (2603:10a6:803:45::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3039;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:UUpRHLJSGHjVNw7QQIlTuVos+/wfoa+/pqT8mMHxSx8BjYFDm06ZAUfGCY98awQuxAlkK1brJuE/QaI8KxmqTwdHGplQ94yQlrPJf7umY5Pi1NlMs8ybpXR/pl96Jn4CdoV+mW0XYXPjpSSp7pHC02np5LZzosMKsNZYtcIkm5QjWiiMpvMk43mtRNiwjaT1Hsk8/qWUsvPleLLVhvC497TbPiVvQKZt/jrvbIZ068Bo9A9Fi02IWutJ3cOSQGzB;25:L/c21wXzoTFiqSiYfitL/ZfnbKiBBI5odLU4OjO48T0glE2ot/zNKWC5l65ynCz+grsMidQalOoNnd8Jkre7c2SjdnyGanYuJb9AuRFoUx1p/LMPTu9xB4nGoaNjSu9IqSFeoHWCwf6jMaKw5l1IxP7mazTZTr5GbVu1s3PQRmoP631/ya6h7oq5gxjNLH6CVA/75dPDcBUBvRX3pIGz+CI/R1xQTAyI5Lw55vD/CtVFGWFI0YTrKXyUW+lVTazzx+wTmaLhRRijxiriqSceQ0HsXZ8jOXtDPTvyp5jPENsS2mSnejlZ49uOT/Vcxkwc4fce0rcdEHnITQcAzSmi+Q==;31:g/cnwaDP+e9t9NujYAyCqig8NVqZRS49uSn79NAd1Uyskhw4Go3PREcV/SJr88FkSoUw6ARLQn9ukIRqScV6cr79pOG//jNHdu7zt72SVQGX7tpvlSTwI6OFEd+UmJ2a6rBzrGuQXO8oRXOcVxtaNPsDI1YxSsw7X2fBoG4vq/WFduAS8DIcWFbpyKVEVJ4FoF3EdOOoFptYrRBCsh5YZOdhm9KBahJKiNU/Atfuesg=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:8GlPseiLEiUk6PLB4tcDXetvwqqUt/k6zYHFA+PgzhtYeE/mqYzk1Zo/jOftWnkNwG41oX98AliF26637LaYjbfH8VB0sNHabZB/a/Pjknm1ewNtGOzS7bJQBh2NkuG0KXxw3H1i1i8h4j9uxfyeU3IMLE7QFbCLrSeHvln+QEkY//HkKjpWAjutGVB7HDOMOoELGTrpzY0TH2LNAQOormaDUlLBmYEr3Vj/0IlQ9BVrt7DSYuk7sApeem9eRv7k;4:tszi4HGcYLJv9YdmYceWVgZaOPbby8kWO4dGxrGvglTaUOACK6PRjUYLqGQAQzh7JEBg6k7FYuGeqVrHSkapHZOUdXlzXbsTIr9ij/vduM9KchhlDv5mvwE99kA+MW6X7aolzYcAT8vWOPmzodPUaHgrl4wa+9mMHPHVPFU8c8UAgjFEu/Tt6Ze4lLnQSpZMuqTf1cC7qojLKQ3m9BAwKdCCcLehQ2vZBbmSfyl4hZB0d2dwyfUKOEz90uqL4ROE52Q9Gdpl8pyFI7U0m3gj1NeXtmf07yPeqCYTM7bJ4r/JScv5RorOvd4F5x/kXsOe
X-Microsoft-Antispam-PRVS: <VI1PR08MB3039675F77139A5AE46946C2E4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(446003)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(76176011)(59450400001)(316002)(4326008)(386003)(25786009)(72206003)(86362001)(6666003)(7696005)(11346002)(6486002)(2906002)(8936002)(50226002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3039;23:lwADA757kF0w+q++bMrAWREL+J7DihMbwyfAdsZKb?=
 =?us-ascii?Q?/AMjeeo4z6gtAD3Vp789mllOS03VveFMkn96WrUyV4BAMJQQbluxLosF9iK0?=
 =?us-ascii?Q?fPV1VhWWDIG/VWWx322POhHR6X7UGPOpjwNj8SnvBYMfxHa14KEzSHd65ElR?=
 =?us-ascii?Q?hIkWylzwt5kPs+UGuqtfSNNY/ozV5lGOaMBeN3Gx9TFAxm+hVD/fBIedZ56o?=
 =?us-ascii?Q?ngQAYEvKFtZ40W+xEdGTxNRl8L00T1ovGgp9lrgSu+McUC5oNBp83g7xWZlZ?=
 =?us-ascii?Q?xd/spTQ/L0/bvly+Oe9nqw0djYIEtxG5YeSMY0+Fbe/hJACwwoQpSTZRt5y+?=
 =?us-ascii?Q?A5qvD8L5ckxcW26lBb1Qpg/fRaf8vXBqJlOClJuwrNqDl7g2VUIUeAC27rLP?=
 =?us-ascii?Q?zQVf6mXNDE6vkqDqVtqOHJBByrMbw08OYRV3WWtOaOXVcuFxISQamJ0DzPkv?=
 =?us-ascii?Q?DFRSdmOiuK0j50rHBlwCWHlDG+jxvcnA4/kh3tb0JAjdK5WPTsD4Zd6vCeA+?=
 =?us-ascii?Q?UEnU2C6pm34ukCUqtHCXdGzP+oiogrdIRFJGotbPgETgtwwhllknUU5Sz0Mz?=
 =?us-ascii?Q?cGgATya4ybpzXptKroTdcu3OkCbjjnk5JWZFtSPetk/KOwONuCOdzC9Pr54d?=
 =?us-ascii?Q?re4tTX9PDFUcJZDc1K+mf3sImkKjpjn7W9hvVeYjmVtff09xvxGkJhhYPVo7?=
 =?us-ascii?Q?yHPg4dAJjGADZOjX0H/qR0cgxAu+Nwg9bhU4bXAJEiMzwZ1ePJ7pK/LAnsNg?=
 =?us-ascii?Q?2AL+zkxPZRTZak8ExFYaBtEa2bFmdsjgVciPjPfyME8jbEhpenj+pb2LBLju?=
 =?us-ascii?Q?1C6iAsIBj6XLzk8UPQOVNYRWABHcD6uqHheMRUURQj+pZPzqhG+pRlNWE3Ga?=
 =?us-ascii?Q?+CMV5vKXlFTg2sST5iDzQB0457lv+TWizyj5kPvr6GGBX6p5qFFqHzMhU0+3?=
 =?us-ascii?Q?PZwEXNb6p457q6KxqKBKZUQiYKPvNJhl+hbQSBC6YTaghBKlRqyIWAsIfMGU?=
 =?us-ascii?Q?00=3D?=
X-Microsoft-Antispam-Message-Info: 1mt1W5zw3qjRwIGkR45QqGnJIKtv9E6b3gAJWUvVrg/kddaB72aAliNDgpIWmPnbPHc52jtdrQE0tO+RTKvgIoQkUYK7rfJDQpHuFm3teVu+wEmpB+RIlYdjBCjGPBxC21ruxbi9BlMFOqfZaNwGcztd3vRJtzmrjWYG1OjyA2LbGlhzNQNmEPwatnWJ4dRx
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:4svnpW7xZOKqheskWHA7UaiqEmAxtP7d/Ynl35R9QvKFcR6hlVrphRdNvitcaDyKwYC2Pefcfs9LPm2t7afCzk+dIO8QsOKOJk2r/8a9y/T8yRpJp2iaa9amVGzJhyxY0DtxDqFroYbqBC2RMHFePgVNAW2tteZrH2/4jQi6ucXGu0kBaEzVpr08v834BiVzzSLW4dQH6SgNTGjkO16XMpFA79CoFZaZZS0ZXq8+NMQOUKI6Kqlb8HRImmK79XN/ByvHocehzCWL6Lv0iuE/hFdR64oYNHWnO9NnQF/krWAdwY8/rLAF87ORCxqHqEEdv/7jd5yd2YzaxZEWW7pGlPz1f53n1JdHFDbsmbz0utta6GTw5DOPw0d0TOP8SN34BYz11u67MLfhPeSS+KJ5VXiWERgv+ypQNb7imTpKiuejIqur9wh+h0G3KjgYlYRMpxnPIct9qwf4Ddpq5hGvOw==;5:Mj7iW6RUmNbfWAnFAaO64WDIiWqSkn6QdFYluGsADCxZGEx1fabG2qW8cAxDKqg/unlKqg8iPyzDCu2Mdrwe2V7CjqBmSgcyFQHBBqbtv4rAXAcIyeBq+sui4d5jISy1DiVrIfMtK811LbHUU51zuY4SaCOopdMuCW6Ur5ixeeI=;24:gvdyxGCxeQ6amPb5oEkURivGngFdRcgmIyELSGM+VCRAqmXwk0o3EQQItnnj581D4bPHySdcTTKXswcvG16jGdOnbx2euV+UNHQuew24vlE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:dm0LdwGVvWoW0tNIZr45lxqFfkxIwGiMjmBxOIxJqZc54aBgcRIEEP06RjJIYbTO1HsdD98aj4vT0iwH73lJCtlCiy2bT3y55Tjsvx2/6ejcD6uj6kMKo3oHQbIdOmu64ZhmQdveCjc2c0R444yskp5C/UH0pxf5KDHvIsBoMVC2jElvzTS0sVrHK7Uv7g0JeYSj8HOQ+tyzDntVlnxJ3jXScA2QUgkvs2BiFfjv/3PHeHAd1DjuEEUjYxQQ4FtM
X-MS-Office365-Filtering-Correlation-Id: 55c6f3c8-2d79-4729-4b41-08d5a929a762
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:51:10.6345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c6f3c8-2d79-4729-4b41-08d5a929a762
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One needs to store the value of the OUTPUT_DEPTH that one has parsed from
device tree, so that it can be restored on system resume. This value is
set in the modeset function as this gets reset when the system suspends.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v2:-
- Removed the change id
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
