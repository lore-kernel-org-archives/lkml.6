Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeCZREJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:04:09 -0400
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:26496
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752689AbeCZRD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 8/8] drm/arm/malidp: Added the late system pm functions
Date: Mon, 26 Mar 2018 18:03:20 +0100
Message-Id: <1522083800-30100-9-git-send-email-ayan.halder@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 052fd72b-dcb6-448a-1ce2-08d5933b8cd3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:dpyETShNCC8pFlqlfHCcBYBLDq2HB3/hKSisp6MT0M0ZKw0/+mD0Ku4/N7jVS88aZv+A/AZ6x2O7jUGtSKfUOqU7kfWxVP7rZqRq1CMfhI5tS8RU/bIPeIRVXQx7nQFoYpo/kbaSEz2iG3TbpNGfgp4BBR4fJuLALy9Rohepjv5nJeM6L0DAJKxFUbVj5sCWcsMqjfDpB9P0l7GZUWBujoFETXaRc3T09vTfng9jaqrc/AqWv/rIWnWM8rLdY0e9;25:szI2E+MbrDU/7raliuHhuDFX2Ymaw68gwIsyK84kxbEoTQW/jPJ6EtAtbEDNdF0TE3OeTjn96CeUBjLnFcwNJwf9Xon7i+xwtWBZCikXVce3KOC+DjJctgFSY+1NtzhLOliAFgNrtBVy2Cmn7aeqOFAem5pvNIXXyqpDnZc2wiCk6TGfzYeSJ2g44TlhL0hXuPbJ5BfKlbdK80egC1dodzb9r+XOcImEad3ywRm5DxmBgPhDesR+HaVUFms03pMcFTonWIdBH/m6/KNK2gxdfmIvCbYn7Jv4xtzvuzSHCUgBnKtvsGi2ciXwUHC7OoUvYoTQFnWvOuGIRqr+H5RmOA==;31:Cbhyh77rJeMIQhH6wCzkx7oJrzvHjPj9JdcvQOFU+MRlqUp4rt1aB3/SZjaxQ3L7J9Rf/vHzu4ekzLVl6FrfyO9wVFtXWZlkf79Y932fUi2oTbQqBR+NXnlh8IysLkKeI/e10wyntrV/ilbJK/h50g8841P4H3+Oq3cl2DV4kcYYah6y41dJ4qedriKSwOdQsColkGtx/H3fhzJvz6USymm7QxxVMcsx/6X5XAqvmNA=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:51yb95FWxFoFMGQDwcFpQsfnZ18ADD3kmKeUxhzFjUH4L62PrpFI9J1k70txxNDoxgvFdHcYYpRzxjajdyEEwBrSx09Q04JNYdsfUQmgQYM8dv6obE08gKPL+3nr6ZxbMcJPmsehpXfG0O8XRTHPn7zfktU1vT4h+vOL/+3iIqc=;4:NTVpsR8ffdNGVVj0UGT3mF43SH0jZqoP7K66VzXqZAjEusVoTImq1dg5RaCh1evIXzmyrPXxuFGM97OWxNUhoM0KBRHiQ56BdNj9+RZO2iPdbJn5Zqc5dadgOnwOaDPQXVETe2h2C5aL2NqxwHqsPol1p/HjvwgfXi56cY7D7MRTuFHuLvn51H+9A3k0pYVZ8mlQBXquPLYp69wih6qzKDbWe8GRujLVE+6YCCcHItAtVmwtq+ldG4Vy9YpNcna/+lspFsQ7tHBcl3GLOAi6q3kz3Ts5s99GyGoe9GXYPnlA32SSbliMjkFzcrEyF+y4
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032A3BC7A0CF26EB32F7E3FE4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(76176011)(305945005)(26005)(8936002)(446003)(86362001)(478600001)(11346002)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(59450400001)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:/Qv3Z+X5c0rqD3dVNxxK2WZ7Rkg+0OSVT9oDS+hsw?=
 =?us-ascii?Q?KYihV5qU2/RKEE9TaxchNxNuvFJWGRsVcuPLhYxRKHl+3XGkiAatWR/6o49c?=
 =?us-ascii?Q?JmzcwFtKqx5acjjgeVWU2EN6NwLbHLjZ2Ky5zHATFnAz/hNfVrNDP/aIWpYR?=
 =?us-ascii?Q?uWaFRBFM34ByDHa4Ie9j13+Jnu9OR5LB+O0JtNMrm/lasU03tB6228IqDL8z?=
 =?us-ascii?Q?7ZosCiZgLUPoUmhWqsjMbkO+38qvSs8AN8Vpze6jpnXFTCRmuGpc1zf051kQ?=
 =?us-ascii?Q?e7kyNrFL81pngFMNq3udw4S/CoUGat8QX/QfMoZoX4KULOTmb5ObmFVDOO7q?=
 =?us-ascii?Q?D2GH7tv4kHqqoLPC8DWGr9IdXV9woSPhJVtXVMexGxzvcYMPtxjDabxMIlG1?=
 =?us-ascii?Q?5hqPZ6SQraPTd/tmDrclUdbTHMU2u1nih3etKAx9bx6HtMi8SwYWrSA5swT0?=
 =?us-ascii?Q?yFwGumwDIti1s2r+s4SKLWozXR+mDPmXobadU+1XfkfGE5eisjTMtOVuqudA?=
 =?us-ascii?Q?QjqAhupVI0eZiEbkHGik+kLn/rJWby/fRwkOwQv0wdnyMF9coUBNH8egXJ2S?=
 =?us-ascii?Q?XWKdbhD7RVRztgl6ccKyuzqQli7QmrPQHFxFm0vfWe9fCChRcNYaS4pguKZ6?=
 =?us-ascii?Q?4TetSlGrl/hBkopjzY1wUiZeTXHC3n7SilSK+npNVrZqlRoPhnIYnHsTVupB?=
 =?us-ascii?Q?+U3OKqUnIkEhzPktni4aP/ywE6r4bwN7DPgfIo9R/+eFvFEgtz2muVZWFPIQ?=
 =?us-ascii?Q?pezzhLYjg3BE6+mQ7vu0XkSf+eRmJVTREndQhPhR4n8e5UqQpRWT56DB/Bc5?=
 =?us-ascii?Q?MPQ976q/OszngOGq8sAxWQcipD8XjABDS3aX0Cu04WNm4PTPgbtagfSPhi7i?=
 =?us-ascii?Q?h5vRbRAV9vVYnmd6CSJZdYTMzwyNm+1Ui/HACaTvc7IT45cws9mDWKdN63Sh?=
 =?us-ascii?Q?r3cBY2Sx+7NyVF/iLa+2Vd0mlziOclbk6uC6juxfDiJXOO0cVc/H+0SxqnIF?=
 =?us-ascii?Q?2jnCnKItn9vEPn7smyBLs2yjekaKyY23LXEXl6BqRRrjEK8olW2SWNcYpZgf?=
 =?us-ascii?Q?vK3WOwzKQiGWjTsh5vXuUUkXLVJOUtur1uDxPTRP9NEpKdChw7OV0kW7Mton?=
 =?us-ascii?Q?5dG9ZPxSS8Dy0/OpSPbApuWWqu5P76gXvm4f9XazPL426/DGfs+q2QoNkjwC?=
 =?us-ascii?Q?g9spND0UlEQ/V0=3D?=
X-Microsoft-Antispam-Message-Info: KPm30n3TkQgHLvUnc2h6cxp7T/4P0RKXZM7NYE1l5auS2XsFkZG1Eas2wruqC0r//eDzPRDAY7ECY0Oro2wh3qmmxDUsALN80tcRx/bbLATimVXhhwrW15GZuFBS6Lmf0AAQ5Y089LeHoiWKCgSfb/rAVpTP+LeUuKjUjo2mRTafHAby/EIy/DVoO3aWAP3S
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:qafN0hE2SIMnSWAETj6y26kmeKohT/vv1zjDGaklcVSOXT0i8ah54kEF5Ll7mviI3B1YBKznUeZw3QqEwX4JhSf7sgcnAlpw/S/j/6J+DvH4P5djSst/bqv0ik3EEKIjKippdAYlRSpWvdk6s5hdMoqsqyUDHQCfswQw/qvnlhhIZZfeSho6lULriQL6Lq8NNBeUqS4jOoLv4276nvutzGgrwxg7M9Z76elWs64z2zAOEqXoLoqSchXZtY7l/GctTZY0ss8YyEb+HEgFCdwbyLRWTa3+Aw5gI8lbMYvbDVQ6MibQn9GRlNu9mcX8d1lt4p/OgGhqXuQvSytSm4mA31BFKa8NkOpR3cgVxoJs4mSLcG10GjhW59TbmzfnJ6dZHygZU3YHE9gGHnKhG/P1Bud6L+Oo8cNqvumnR+zgGsaHJgueYTcrV7FUQFen6Fxz7Xz7MnUgwQPeTWHC0RwPHA==;5:4yjsNID8LlLmTpnWMncKSOuNbsFyAI+USvQS22o+7BWI9k5kxYWEChKaaHvi4BWML1o3nP0nMG3rd1Wc4WgKhMXg7F17xbA1pC/2/dF3/LHJu2cyf7ArqgozU7aYaKOYMaUwuOu1rdDrbHnFvd3Zf5u2u+CVPDfrB1TFyoEJ9b0=;24:dAneqjObJsPoheamPukh0PKp50OB3uiUgJPPitWtdyaWVRob5IrZvZP0aJf6KZ3h5UFa9/2+iwV0hR1YSw/YPkcm5vGh1kwM8bCbuguAU5s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:tnz+oK2Z2Ip5mi9Nm0JqvQZmfQ0xGh1+QoX9XwHC0bLzBYhU1QMXv9hu0ZaHUOE1NLLb6B/V0xag7eKBLZ9OYviout+olgSh1DRu007xbB8iWcoujQA6CC5VeK206D620WHhUP6cUTKEgwA0v/TzXrBFPPiS2v7qMTC7EbfYrSpe3AjCuYCJwCL6apNnCtecMRldihsQy6S/kzRGoINSi/gDqAqDsGcTWrP3o5WNmstzoUw5BQ9yci9pC5z+nb4v
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:51.1073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 052fd72b-dcb6-448a-1ce2-08d5933b8cd3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

malidp_pm_suspend_late checks if the runtime status is not suspended
and if so, invokes malidp_runtime_pm_suspend which disables the
display engine/core interrupts and the clocks. It sets the runtime status
as suspended. Subsequently, malidp_pm_resume_early will invoke
malidp_runtime_pm_resume which enables the clocks and the interrupts
(previously disabled) and sets the runtime status as active.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Change-Id: I5f8c3d28f076314a1c9da2a46760a9c37039ccda
---
 drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index bd44a6d..f6124d8 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -766,8 +766,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
+{
+	if (!pm_runtime_status_suspended(dev)) {
+		malidp_runtime_pm_suspend(dev);
+		pm_runtime_set_suspended(dev);
+	}
+	return 0;
+}
+
+static int __maybe_unused malidp_pm_resume_early(struct device *dev)
+{
+	malidp_runtime_pm_resume(dev);
+	pm_runtime_set_active(dev);
+	return 0;
+}
+
 static const struct dev_pm_ops malidp_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
 	SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
 };
 
-- 
2.7.4
