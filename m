Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbeDZWgx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:36:53 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756937AbeDZWcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:31 -0400
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
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/24] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:22 +0200
Message-Id: <20180426223139.16740-8-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:PbIATIjW45J7lMIHs+GftEe5gX1R/z+gPeCN96yze52z628oPr5Co66OT0Y0KfNJ74GT+Fu+XMIw+03TiIfcVxqIEa/BCbNQ+02xXeD8BgphF/SrjjGDifaS/sGgaq2HVpcIIpiun57EkPA5G00ngkNmacIlMXnmd5wmV7lsAUpEZOBK3uTEDo3SLrSiY5HAQA0hjDaELcF9Geod2DM/iy+G026wPIwkm255QtGMIpd0rZXtBLuAq/Io64NLJfti;25:A309RXtD3sMpcu69jC1gfrmcRM7soZMWbFYyLBBYxUhT5e9UXpiDEVS87m2o+nyzbd1VZzY3UexH4l57pzhPjIdlgC1HnXYXd3DWpFvXUEVZrzCAXJSRLiKvn9MsMTmckhNFqx+qw8OGoVyYiwg662lyDpt20GKpifyHjvvyQOIRo+6vpFmlXftxVrUU1vmPJDIdUloJ5/NvRAQbEfkqaCq+3MtObuDljM2Yd3AD36wkA9rexmAUmNFU/nEKXZkMcdI2P635+VyfP5cLDmhWRNFiPPultlwfM9/Ed5FNQsLFprX5wRlmd7rVSGkTFUS8YxbQxrWIp0SnNi5z/jAjKA==;31:6kREnFCzz6enN/ksjN23OWQMoVrZ46TCEFzJUttg/5mKLbyLZUHQBDikS5RqnmlxLdFQcaIVDiv011BxTpqh9dWRYSc+xYxOkmaMedC0LDpLR3rEz5C4JJqpFDdtgb5w35KPAWxRqTimlcVeZenrCz6tY3WZolu0YRwtpi+gytggp0MMlOg60VfZau9C4TokF2oE+wBeBuzKDeH8hYyyW5m50cRJUt2E9ItzZbGmj40=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B69234DE1380C4B0E9A1BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:vg60QA4gFOl3OobJ2qUeUlXanC1ZKYxpe/kS0c7zmAl4b6eMDLEil5ng0zyai1z9dC/K0ovYkte1zADidVN8RDLL4jwiJo3dncmVGN6RI9dD53XEBOkM4tfLWgTxGvpvwjDD1AA3F0sXUfT9UEC9wU6odX/TNwBuR29SksQK9JpseUvkXIRGPXqy0eNyIme2CXxz9yumvTZuuEaRfjQc2Pe7LxIe9NQxuJ+wu4bEQg93vvGbAE7QRU5L+Z91cRURBh98SYn1jkuhl1lX9rWiiQ==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(7416002)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:SnM3ds70kH4LA8tab+RJau0/SemXttq6XBay0MD?=
 =?us-ascii?Q?FNqQPIHH9TQerPTohrIAlCOGCRc4z1J7+PuC3q9v76FLXO9NQMpNFXRVI5A1?=
 =?us-ascii?Q?fO6OvsRQdQnboYBuXhgfIJQ3f4a88+bYSlgTPnL8/NvVPGNd4eDPkxHm2OaB?=
 =?us-ascii?Q?iMz6vNic2kO44Z4/FiOl+JR9FzS43IRjP59FT7K0Zdrse9hJwK5OotjcDR78?=
 =?us-ascii?Q?sgHyM7S2n8HyRclEJakfFfkh4vu8HMViLU2N+1FAMWOtRoNoPbwcw/WaQsod?=
 =?us-ascii?Q?R1lYGBhWxNO+Y2lLcwjWQBMQLp8D+8r4xK12xBsRcJMhRmyc26dyzc/+b9oL?=
 =?us-ascii?Q?pzvnP/ij1kp3Y7E09xcwpbtrjPsthPJfTGYkNBHintQYqXZAiJJvHOXzb+Ij?=
 =?us-ascii?Q?zZaVmCz0rrMl5EJ+XxYhAcrClY6eHST1SWJ+XP0y197Awm+6SLTlTqFhyWTu?=
 =?us-ascii?Q?THDk1zlIkKC76GQk788m+avdNcM87bWNokjQbu01dWcEDuZ5JBDCPMPT4jqY?=
 =?us-ascii?Q?FGs2Vl9IN5qIa+q1IVK3djXrBXmlM7Yv790RC7YAvzAhbZdZCUjNirxRdDuT?=
 =?us-ascii?Q?7a2dyqpgXpCEJl4zctsgi4uA6103RMJL7Bg+jU6HvrLtR1vCR2ZLZ17MD5KF?=
 =?us-ascii?Q?uAGuZM/5+24aY53qB3EPcnHc+QzgZbh1yYc5/o4LVt0oB9MORXqrQitV7Cha?=
 =?us-ascii?Q?ycPoVuq67RijmgTojo9JFenFlaM9riEVsQmLsOOibkOT8kNSigG+l1g+62u7?=
 =?us-ascii?Q?gwWRagh/payc5BXm+nvhSnuRGltFAz+xZ2g3Y97XOYgxCsmbetbM2E0PTo69?=
 =?us-ascii?Q?Z6IcGuNltlG9weT+MS8+hyyhV9sH6tGMKgLUephMz8HWgpYWDE3aP2TIDdj7?=
 =?us-ascii?Q?Ogsk6QxK2pYGDp/UZMDfaaf2P7YcXlKJiixzRoVCwz8OLsH9YgDy16Ax9omO?=
 =?us-ascii?Q?Rr1o2fh0tlH6JLE89ygh+zrZ0txnMms0xrmonNMi/NHD4DENA1u0Y0dO/xTo?=
 =?us-ascii?Q?YHBbwdxEHM9ihpwnzKtYECH9Eb23h3Tmltk0KFWWglax0sGDaQhIZG0OovCF?=
 =?us-ascii?Q?DqizpjGGXwMjPRIscMlbE6EJ8hRPhjlBlwAmQMjBqI2m8RjiOw+h7RQqPYyE?=
 =?us-ascii?Q?uS93JB01ku+/VVRgfc4eMEzxNOqZtgqvwMhdydZxntsL2wg39sHVPhZ9lKjO?=
 =?us-ascii?Q?OiL489F8dX5nHd2xqsp4muK6BQB0GagINjvpGayGjwKGxLbvh5Fdp472QmRq?=
 =?us-ascii?Q?XtvnXpbWwsJyYLnl+kjWULvWc0OJxTaTWKvTP6lTlEpLWC5ekLF6oeelPEt+?=
 =?us-ascii?Q?LVl9fTR7jncsg967Xx9Y0DAhin2uhVZwRYCfJKhwvnbOx5ndlM2G2Zf0aaQr?=
 =?us-ascii?Q?9roUGYQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: KZTkafNlByyu/MoJP4R4WoVPeT5ICu1Y7q86k0SvcVJxrYGuHc+iJNC4Tc/4/0QOGPtkNznevU0Jl4geVaAAGT366nrnH79hSo7uoT0j4Jv82FlU0uGDB7AvH5fMERmjVWWJVEfCacKkcgXZP22abGdcmFYxFaPiApLbMrDLCF6H7+I/Q3dFYefYME7pR1SP
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:ra53VznzqkrQDRBaEwr4A9SYO6zWIvGa0H/Pmkadvlnhz9uinCCZHENiROYb59i97tBQYKlRaa76J6ftfUvIEzB5N/TO3trCUZFX3KuGX7ZTarPQzUqgzZF1ToGsVCnUZxvUWClw6YtVg21CdHC4JLRzOsEAyZPibr/TLY8eacCbE9TY13m1BFF5TAkLB0KnIllMw44lZccEfts5cvEe15R6HARWXI3Lz+ZJiaKw+lqQzUu1VowqHnxGbg40iL1x0nzXHYNqE5bYC2+O93LV4aAl1uLBtlCAozkGzLXhQ4PJ5giMv96lIBypCuagEBYN720dE8+JSD/ayTzlJKAEGqeaV70WM5OsMnT+tVE4CMr3wBi28yfIMmibxnPkEH9amJ74HzYPqCsGEqFf0Ft8PgPzAjhJboEZ2u4lQRw5FBd8+gL6W5kElhURA+FWEKI+1E87zROv4SMdQI+Lgg9YaA==;5:XG1+iuyxyjA42564CZb4b3GYm9o7dKI6y8ZxqzkkjFlNhszJVnrgps8mGfmaJ4RFj3CCIGb5xzyLvP/oTxxaCOG9ZIrsiyn0yQ6/jAB/6bCFz60ffehuRcsg6If4dmcQjhhgADcnGEpj1lnIsIJZxTJAP+yV1B7Rqam2hzoj47g=;24:uWfu+w1pkVictFZGQNJROAQ0Jfyc+UuwErFy2NgcspTdd13VHXD1Fd32BsazgqRzrqpdgv18iGOwSH9U3B1sfMJVQdlMbOOfMPqwsl6vHyU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:VBuzFOIlVu55FzPxcVdKtbct2Z0W8WY98aP/FpNY91m9YmqFOSQapS3qsrUI41H3LMyPa6r0yzZcgd4jyqsi5FrllGdFAGNaztW7ulLxCir+lRnIFW8lYDwoyanpoM6IiysRumV1BXSE6WhZr31zvGfvDZ+rvkab6t4kO3wa0ARJYyZkblAbGP4UKWts7umP/FudmQ6cw+jmRFNaDDanmeTnVYTEXnGuBolbPsOzdt6ZuvXZh2xvNdVsQJGoHLFA
X-MS-Office365-Filtering-Correlation-Id: c9d51504-7730-4d1f-ce82-08d5abc59630
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:25.0418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d51504-7730-4d1f-ce82-08d5abc59630
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 7ccadba7c98c..7b7531f75d41 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -313,8 +313,8 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c,
 	i2c_set_clientdata(stdp4028_i2c, ge_b850v3_lvds_ptr);
 
 	/* drm bridge initialization */
+	ge_b850v3_lvds_ptr->bridge.owner = dev;
 	ge_b850v3_lvds_ptr->bridge.funcs = &ge_b850v3_lvds_funcs;
-	ge_b850v3_lvds_ptr->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ge_b850v3_lvds_ptr->bridge);
 
 	/* Clear pending interrupts since power up. */
-- 
2.11.0
