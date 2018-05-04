Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeEDOAD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:00:03 -0400
Received: from mail-eopbgr20098.outbound.protection.outlook.com ([40.107.2.98]:15712
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751445AbeEDNxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 08/26] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:54 +0200
Message-Id: <20180504135212.26977-9-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:Fmd5rkzqFEcrb+FLTc+WPBq/Etpc+ZDPCPvcldYPDbfqV/7GD8Ju1GVHVXkRqtXley/aMvBBL6jM6bJ4IRWKmiL26uyZBpIgacr5CeUGma0X0avr5TcrAlRo1VP6Z3yPGY1pSy/1MnhsP9pDUxdBWDRUK0lyJYTBrtRrc++tpJ+epqV+nytPFY1Ls9qdcy/6ZBLDjEPGh8uB8j88OOGxS/VcziVmRMXXyEq1zHYbq4IQc0WDjXlXXql3nNUQJobw;25:tKNVihTo02mxEZRYPqdhLACxFufscgj+ZUMy9IcLLDYHC4BNRRtALtkM3uWRxCL/HVVYkrlaryGS5SQuZVx5AZ3nmo+g0LjQDIgKwUobArMlLs87/KUzW4kOBw/CHFF/mrclpesTI1bEOCW988EU1SHaNrCuV7w1SWKHYBLDENDN2gBMyet1zqENzzfg5jB++PFoGtvRiNwnXOiI8VVDjuB7brWXNvmTUe/AycJgC/PIgijl6n8Iaki6+/c0XMMsnYDPU/hkcaURzjnkvyZczRj6HJsKCtQS6KnquQ5KRej73Bq07qHRMremNHF7F8NaUsBDO31ipWsQgdFBnEPbNA==;31:8KyW+Bn7CMw+1YS3eVNSMh8dy8gAB0/XaOowV/MZ3T8764m3gPJV1dRbvatDhqcRDMXEjnSKu1jRNY78EuXFSEIcwARpr9+DsyqffJ3lmYj7uBEAc/3gN/7PPGUi9reF5KCzfFXnxS5CUUe/dE4RuTfGvyC5wakEPeZ5hsCnoJlBOAeLldu/gAiCCnIC+ozy8Id/K6tcj8FKIjX8IgFA1N/YHpmPkKb9deFItTLgRBI=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769D0E0844A860F62F90566BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:JJ+ru8xf4vtHaivDNDJho6Zp7rprsp3oxcHOJiARGv/80ZmGcjfxdfXHj5i1rudx5vOp2EU/E8SzsIF2kcv9pSUd11bfISbMwb0UvRBuCuXj6WpzCGa19mKRqhLk7JPfPSxA0SA7hy8Ouxt+uahoXsZK7N9WuoC3YyfpMb8CfnYuknvBKi0FF4fbx/4izYdObiRV3Vf6D5CBVPvA6jGNg382wk0FzAcgBSwi2AVlcy2nuMhGYkaWw/A9An1810up+S8Gt1eL0mtFts6Dsa1C4A==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(7416002)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:o1QTEwkr3sICWqVYRHpyK5tuwIQ6yMum4aOl6th?=
 =?us-ascii?Q?PckkhqxyeMw6Q8aYB4YvoNiGMAj5qYRc1RVEbxJ3sTf4roeV2Ug870iGw2qx?=
 =?us-ascii?Q?ScOWflWtIFmayuWh6EoPmgtKJdlaEptemAOTzOoVn2Zq+Efviwcgu5c8Q1Dl?=
 =?us-ascii?Q?f0+bOjUaGlFJDSVOcRKom03tr4KI/hGmVIEW7Ytceff8uQEgnVJhDXnFoAWh?=
 =?us-ascii?Q?C+PbOSfc5TRmvnLbUQLrvDIn61fDFRjUMFPJFu9ybT8bmiPWVGifqfMf+3JF?=
 =?us-ascii?Q?b0kEmnfp3CFkHj5YDISb6oxP554XbU9umY/9h1iymvM36xtnN09Woy0RmXXS?=
 =?us-ascii?Q?n/sBM53QfS2ndpj8ma3k53PKM5VMRiU5cKbw7xfpYoFIU/WXwRGVucaZJJkF?=
 =?us-ascii?Q?8Jotd4ZUiwgBISt3ToQo2vyogc7SfJkSrAF4Tid6KC22V5+U840A6kevWFnX?=
 =?us-ascii?Q?OuISW/5UE3qF4mOcUSaU+t6jC2EpjJ0frQP1t+XPR7HAhfpXakCMx/whSSOt?=
 =?us-ascii?Q?qPQdG7wXRIoroqDXGzvfJbz8UErB2RR3NKIsH55IGploGdHBy3Tt9XV4W8hB?=
 =?us-ascii?Q?qyajV0J72RLSGvfurVH1Ufj2YMOeiwS1tjwHXKMNoJ2xd1T6KxNQ5YwkBoSF?=
 =?us-ascii?Q?KBUpZJahGS42eaHx4pCmCvw7IP1dgwJ7lD7yS6Wf5oE7GFTxO+ca9YEWbXot?=
 =?us-ascii?Q?UcCzH6CtZTlzUxAhS+4dP/L84S68pgX4kaEWDV8Kc8KhkYkj2MmbG4mRVHjo?=
 =?us-ascii?Q?EoJGm/i4JONTDp+US+bQq4mOxXdFs8LNXHW5emnWT+sEBAW1HygbOwbdwo78?=
 =?us-ascii?Q?z/CNYA47MNqGWN9793geMCaNVLnckcFi3yiFz5yGxQu8OV7wZZnTM35YNuKQ?=
 =?us-ascii?Q?RlZ1fzo2Od1slUetjTnl5J1OflNGx5MZMOKZiKVynO51cykPlSy0AAq4821V?=
 =?us-ascii?Q?QCdUPf5GxVMT3XozXgXknCL5UQMpNR6AT1wIQCQrIFOOJFG8rgzoUY9nTK5u?=
 =?us-ascii?Q?rbN4hY81hT2TUlV4O1fY0LYpli0IEn2NPyjdAfhCf5exbit5tcpgB8mYTDqi?=
 =?us-ascii?Q?n/cTSFH9PBNru+W6y/gNaqrMb7X7jYUyK9OmaEXmbmA2FXL/7OuPRCruD0Zy?=
 =?us-ascii?Q?UQRlPyhMqwUSh8FthMPj8HfTti8VMSX3aDUJwEnStNqif39WPdhyCixBvIH5?=
 =?us-ascii?Q?/RV8O9EaoQoYX8xiXD7+NKcYLnPqYdFH2hO1VUHseyP5AEQPLDQ+Xdr+VD0b?=
 =?us-ascii?Q?V9/lOmvordFkXBdTTRmQ8Z3eqninwertzDyNFiyPMcEtFpa9KtMTwrXov4wl?=
 =?us-ascii?Q?tj57GQK2kggleCaKHZV4PAPbYKTLYn121wMdzAnjBsAuNqjiUTjfIeSi3J/A?=
 =?us-ascii?Q?t0X9rVg=3D=3D?=
X-Microsoft-Antispam-Message-Info: eTRayAIlcMn0k2+ZC0XIdG4I+Iwy0nBlEHz6vwbKDu4yIhmyckURfRWkLAsMmrSrDskp1zC1jGGRwDuRGGA4SKWfaYtZX/OXEknxxAOpTVMF3qOW5ffeDmw4I1xOt6UslVaoz7GS5CNqUOfAL4ymFrHmcyAuHRm7ZU27C+ocfrcapQoBsaR0wIhy/0Wps8Qf
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:XKZhhvS1+bFwqSc9hg7Rw2y8Hpuf1qJ6YMrWJQSij8quU7umQSVU50fjXTpiX4yNWIVbMvXdxqxnW7N6l8d1sVlM8XZjkdPPCulaArAgeunOsf5El1el97zt74KV+uFagPRyxEwVQs09GBtvIxr99kI6oxTukpIQ6YXZOZ3n+qvJg73bGqUqqc0Wogo45JDyzJJSSixWVF11RsPrb8zw9zAn2WF4ZjL0mRhlbaHlAAgz43yxWzZyvWIw5HhaV30NLXgq/1PkR/Zx9b5NPLio/TJ+R7RMHFw2pfLHe7OCQyYRxkNu4o3eHQNPFI6d1OScTyZ+1QrjfuSWvyjtjOp6pVul7R1mBBhtLhZYukqeokSrHDkty9GSXCJyAAKuvZf1RS3SmI27PbRY7AweHIO1ixUfHe95UuSHyjctVaBoULUsbLaZBjUdc94oXEgyQHXvlWO7KP060IKdPaCttjHPIg==;5:Jg3TfrDsR8qIqllvhIvA6lhjl2BN0KS6SAT8H2DJo8MrDCfbtGivQEHy1zbhZjPiOmN0E+muYBYg+/E4dQPG9Q2ZggY6L8euyxSl/r6EOFkbMk/ZhhXyUPTc6bVAMK1jHahTqmgHPhakg4nzVUuBepcCwIZeWfEwk5XxgmKJ1Rk=;24:JqxwNRqJYSuMqBMwVmHLbTJMT6vhthEGlrfIb/vK0fAuqadWpGeZFZQ8M99cYlKYNKu3vo+o6W676FN4uQ0bseN4y4dUf/zP5uyeEzuEvvk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:o5chmv2c5wOaffp6Jd43qSi0FzgnKq6t/3Xhm8CYkDf+HBbqwtX5q0T5ADIwU3mDP04nAR1L/u6sNVpxb1QpnAtsq8INtz7H0FmLbA08Xl4qlX2HFWW/ugNMZARcRHL090v4QUxRC153kGEvgzjydI88MIJ1daKbxO8CMvQY84CWF3z35AFqWjnZlS4dTZQ6+FBT/qmFF/J0urMhPLrw6ybtixMjE4c26JIfwIPMzSWZaidnGFG0ST2VyBb5XXoF
X-MS-Office365-Filtering-Correlation-Id: 4df86649-1b48-4de1-1f3e-08d5b1c6587a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:58.0445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df86649-1b48-4de1-1f3e-08d5b1c6587a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 7ccadba7c98c..29d1b5ae5fb6 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -313,8 +313,8 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c,
 	i2c_set_clientdata(stdp4028_i2c, ge_b850v3_lvds_ptr);
 
 	/* drm bridge initialization */
+	ge_b850v3_lvds_ptr->bridge.odev = dev;
 	ge_b850v3_lvds_ptr->bridge.funcs = &ge_b850v3_lvds_funcs;
-	ge_b850v3_lvds_ptr->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ge_b850v3_lvds_ptr->bridge);
 
 	/* Clear pending interrupts since power up. */
-- 
2.11.0
