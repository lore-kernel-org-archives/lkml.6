Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDXSN2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:13:28 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:51605
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752582AbeDXSNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:13:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 4/5] drm/arm/malidp: Set the output_depth register in modeset
Date: Tue, 24 Apr 2018 19:12:46 +0100
Message-Id: <1524593567-5559-5-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
References: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR07CA0189.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::13) To VI1PR08MB3037.eurprd08.prod.outlook.com
 (2603:10a6:803:45::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3037;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;3:obX/kBOz5m3u2uVpb9Xplb/29STNCnBMDB9fjVi3mW80Srt7q5ienf0FPhpncTlKP3ydfleZJfnVtxx5i+7Iz7Ksp0184bksF4K97mAy7uBKeG6+rSeMGhA0fqsddoGWdPjtFYmggSiGwSlFID/AJ13ljmNpz2EyjCRDmdzAQHc4pahvCkWKAMmF+buzqWSaK1OggB0vXT4U2gBa5ZwZi9ZN/tKvkLvYcpZQE9nMnqRyQaWlJ63uAB1OQrlM+CFU;25:bc5I8ST8ZcF5YIEO3eszK5mToUweQt++n9Mr5HqQdjyvxURWwL4asIAAmQHlt6mT06GsjH/lN/DeWLeyXRRp9UTq+N2R4lmM6mOo5zwFcd1cDgha9jt166be21GP8GLpizj+y/fejbtylRIc3QGyrAKDZaUMAlFSuLn34S+dwsw9co4aMdRyFXp43HcNW3VOFx41U1ZXXNEqpawYEl+McfhhGKR3nEwGIkH8YKrjX1DmxMinKR6Xvyr+9BizxAo7pDQfgfgnLj2/RAEWwf/4ZPuZZi1fXGmEknLnoXURrj96ldu927gvBGOGo9uVnZe+vgXDBGr0XIRJh3PxN7dEtQ==;31:cfe+1AEr9LlRpef9UPhswjsT121oU42RTq3/usS1qyTqLmVjrDy2jj3+APOuulX7PLxXxc1AMQ93/ILU2x9yT09QUI5OkV828ayMDQMmz7tHoJhUlugCtYdIPZ0kPm50DjLG1+e2WZcH9hevxwhj2c3/xNmw/gv0ZWwPiys2tqao785Qu7Ebdg7pYnfzPyoLdKx4qWGhUD5UI8jaQJWwZmYJd+3ogAzK88X8MTrOc9Y=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3037:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;20:+JdtFG28N/TCgFZ13aTiWT7ASNh68akXtziT9uqxKbzMxw4AKTHCWMErK97h4k/oWd4GAWo7V6+nZyKYX10DEfqnm/TitloMztgvf59jQBYMsrpFlEK4DsoYJt/P2xbxzVbgdlJPwxqSbK5GA8oCtQxh6Z9vPLB2LEumHlEAhLUT21rCbytBt7+xB1ySzuvJeqoFSxRJ5GSl13hL+U8eDwdq2wPazIt+GGB+pj+Kc1NiVcNiMi2pJuz7vm/02UAy;4:5awV4EgtsuJ+kzpUkDcZzV+3CR2uDgBrySzuLt/7pAbRwI0Ifk5z5pvX1MBaK7pIrMylN1qdWugi3XgDucUGJKloIEqNLZA7X1vF4sE5pb2B5QOMbSyP5hAL3kudrum5o05NQPZMoXa8Lo5q1rkLlPdIOEVfFirYxiKOJKQEZuy69/T65pRqIfd3gxPPZWV8x52b4rMRqUihKvxT9EVC3dTGzSpsw0fpfc/uShaawnUPePrMIQ2TVGghBSzgDECXEu44tsE1ABOBvgM30NIuz4o/kZXYT2uAIw7YSeQe1hEF3INHZZnOgTZXXgD+Cn1V
X-Microsoft-Antispam-PRVS: <VI1PR08MB30373B2AA6B2F9E00C0C3FA6E4880@VI1PR08MB3037.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3037;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3037;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(189003)(199004)(316002)(6666003)(51416003)(6116002)(53936002)(3846002)(97736004)(6486002)(486006)(66066001)(2906002)(76176011)(36756003)(25786009)(86362001)(72206003)(478600001)(105586002)(8936002)(26005)(8676002)(956004)(476003)(47776003)(48376002)(7736002)(305945005)(81156014)(7696005)(68736007)(81166006)(386003)(52116002)(106356001)(50226002)(446003)(16586007)(50466002)(16526019)(4326008)(11346002)(2616005)(59450400001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3037;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3037;23:o0oW3wpAMZZTTTsihVhiHo/8+70+6GWHWgb3Agf4N?=
 =?us-ascii?Q?lecz8uxpDi3OaEqL/ojVNtXWwk+xM42iKbp35fq7w3T8GRHgYnG9zOyWzbA6?=
 =?us-ascii?Q?Qgilu6l3v99kv8CpRON9k9hGWbxAIoZsTzdYBbURIldfzjfBsKkxqI0XIQAR?=
 =?us-ascii?Q?Io0XD1tHnN5rRo/SEASC3lfQIPryMdUwiksyiXtfCHeFL+W83JTmJW9KxgIz?=
 =?us-ascii?Q?O1ZSMC6730CrGyWBaQsUoBxk3Kh7JKaHD+CWhjpWono7qyKSVEeAB2Vyrg+6?=
 =?us-ascii?Q?p9qiS/1nixBSJ+qJOGZNEU3IIOKKtSzb7h4qhBM0TLEDfpaL+pEH8MYSrYWs?=
 =?us-ascii?Q?lyfh/U/d5+U9eSpSDHdinHw2sFtUrvRUl0jdjGyIOVvcKyMLo5RSqlMwwkvF?=
 =?us-ascii?Q?VEn3XxHUXjWdBfdl055pXwJIc3h/QI8hzPTBwZL8s1/aPiK7qhMpVNPzrXLG?=
 =?us-ascii?Q?A/LFz+Dh6VGGKdtRm5wOFDjkgq8fcYuLKYMjRZcYT9l9Gsjcs3WumB9B5rR4?=
 =?us-ascii?Q?4wvjXNc2tEUAMTjKlotSAt8TyhXKvWwuXjBN8iLPcV3soOdGAAro7tzBGAHR?=
 =?us-ascii?Q?HlgbunekBqTU22NSykkwQWGRP6kbFgQNJkqZpWzIFSlh8iAoQNxphoq5ZkWI?=
 =?us-ascii?Q?cJEnyj0g6hC7JMt56wobwIRHlx6Blc1Vs6gMHQT0gsRhBaUIcpzKeP2W0aLi?=
 =?us-ascii?Q?FvfIehmAOEs0FvbrYhH9PXbEzt8Nz2RfmeRiZV4oElJJj0PBRv0bBJtZ3jPd?=
 =?us-ascii?Q?/bMJAQMYghzf6edIAv96gSbXqfneZVQOe+Br02NZ92SQR7t5xSkPFkjK0eEc?=
 =?us-ascii?Q?VJGOteYGZMj2jy6zRaK6FnjIJkBkNPoCB+BRnbEpCgWSTYvrb4oiXNBiG7R4?=
 =?us-ascii?Q?ArSIS+w9hyoCTPyoA+DI7QyY1Teu138FSHUpXWfk87iH1kzdkzWVJ/q+7L+Y?=
 =?us-ascii?Q?8RNhb7yZ93vPceyH9G24ZcyB1zDYpR2y1YtBttYUYlGG5SfKteuDPxQy0A9D?=
 =?us-ascii?Q?ejiGulF5Ycx7WlXkHT0n+QknjA99JZdWRCnll1K4c5IK2vqDD3G0lDrSxgSG?=
 =?us-ascii?Q?6pSweEft+aQvMo1M59yB4TDMK6qu3gtucMPkagyLU75Am9qooTx0ItaHjJye?=
 =?us-ascii?Q?0fL5lgPQTGcpBxhAHSqpRqPD2T8dvvMzZebebWOzMBno1H1qVx0ng=3D=3D?=
X-Microsoft-Antispam-Message-Info: epeRpogGWiPqreRO1AVi+AxhbyHidtD59RWPr9Gsk9JPeBtRF9Hsgfq6XbPaX8OmNOGar9ldiVg49MkXEjLSKnMRaO4fYkY2s8FgpYvAB4nwWMR4eUgpp0EFtgX2DS7qyYG9/qLmeqOtc+Ef1g3MAElOXzZYuC7NsDFL5B7ld8aXnSzdAQPoGmCaXafB6lAH
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;6:38+KR5B7PnJahnJNBVz/VWOMnRL++Mt/JxDHvd7oDVqtVPNWjJ4oVGpu0A1gf/mfXfo8xgy6wjhNoOnu7UF9lJA3hh8iTLxKi9ovyQGkLwS9y3rxho3HgHxuI5ppCfdTj/MfM0Au38OSI3ixvhp+9+pRAH2RoqvUeNrpzAi4grsJF8UfXpmHTOL/3t+JkhWx8hmDfV44vSR8ZCm41HWappYNc2H8DRjQMlD4vdHcTnXkmb1fVqc+moZXXU0Ol9dfTWAel9mhcP5L0cneDHtyHTI7l8Oyvc5ZwF7JvZ3fie+VJh/fvq53MaBcTJO+bTP3KzVNM+TDDROsFE+yHbhTmhKFUS9Ty0LaSvI4n7zhJzkjWA2bTq8oXNTMlRwF+Bf0g06H8nniSD2RAsNY3hGKsdFfW5YJE1xKYr/WnSXADNpzBAIlv4kaSvWLAMZcGkyg4bnlsIB9BG5LOVpNa5WIBg==;5:QBw/UTzHp+nVZ8qXEqsqvuKnDp5ebbwnoOgOM5Z1zItJ0vdEfmqq7d11LO58TaY2eOOIB4isUSGxGFddxTQbi5LASTfk0dve7yyRmUmr/ybz04XNmz1fVHZ6nKfbDkcnwgguWqeT+tCh66WwPKm2qJxgdsMdUpgkNpbyssBSg5o=;24:YN82l64AQcXok4NqeY3l6SeFR+4vQZB5EOkt5iilHMMiZxeq0jz6EQuWIVP4yacWMmi2eutGy3Zx6RS7h2+tFeGBrvTRCmArHUBCcoTY90U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;7:y21ktkFonWcZMDRgCh7tlEc+o+/9s3Hj7N7LlGptuY4zquYNhEXkClITeLxkYkANOKZgbd2wn25BiyQqAg/Yx5gPc/87vyKbeUYdLp1Cu70RV0RbyAUlG7KhqvniHVYRJEFsbqFSvPvQ4k9Wvy9TF/QxXsn73qWb5/o3qPhfOUgQ+m3spSvgFMuVB8Zb9r7vdmNnfWQ76uszj8fXExt1/xA5Cx2Xr0e1LORBjFy9eIVk8nIXTIsnU1wWttSHeywe
X-MS-Office365-Filtering-Correlation-Id: bf109de0-9163-4917-3f81-08d5aa0f09aa
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 18:13:10.2895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf109de0-9163-4917-3f81-08d5aa0f09aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3037
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
