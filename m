Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeEPKUp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:20:45 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:43541
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752807AbeEPKQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 10/26] drm/bridge: panel: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:54 +0200
Message-Id: <20180516101510.13215-11-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:5T+QoCEEGacFTLRCwqNPWvpF2nl0ulueLYwRSiTzkuo2GsRQOckppLN0KT4V7hSf84NqZQ6HYHxqZHkidOKKBAVxudKNhUqMh7YtolTt/JQDownYepXsc2+3vDFnx6Mmgw0/4g4cpbPYAmNkTI2yZl33btWlPSAccoeBUHaKDn0Om/ildN/9DPSQ6U565l4VaSviOsrXf8b8fvxJ483MBN873+N5Rc7jNUR5TpmW2xbYNH8xVl+OOX8R4A5COudb;25:DypegXvZp66I7a6N1jj+keEhefhddCgIrhDJuhok+4TxdOL2I+McJWeTc7KzTWUDdXMRZwQFCk0nPsOJL8iSgL1bjVhR7givGulSwD3L94c4/rid4obMoL72o/43Dpye1KCDTgzvbGequjUPZw5jkxrswizRCuS52+UK+Ojv2mHVk4IkZqcnjO/wwk+oAukvTFcW9GxxE39BpJ732vij5y06qAxIH/odEeCYkdjpqn0+p8DW0plePfYl/dQYwcDiPM9cyaQWMONSszkZjWfszqUwCOpbQRGoihgqi+kYgK9yhvGqKAIg2hSc0iuRpcl+DcpLnf4TE766CgtMGMRRsQ==;31:DiXe8IxRdTb2kYvIJdUgXEM/4Krh0KrNTOePPOorfmxRmwdorUZyQmF9Vv00W+VhgsABItHXI/XbyX0eYsNZqcxpqlYVZaUjmVqN9GPvKaMdDJB7+3iwKJeyh93+BRizoCy8VrzE1CiyBLW9a4ecNoZHIc0F4mxlGMoqXNPrEhRZMxkNtZoaxj7b35zuAIHJ/89LjPBum+lgSGhJGCklWRLo9pXEPXvFrjhfr0krG6U=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27725049200551AC68957631BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:nSfGlIQvTAmxVJzK+jdPAGgNjgRUbeHgyKd6FQIJvvhHdV4dF/VqgFmV2lRtgIteoNpVcHeEda8X1swnMF1ViXDO7V7IELJR3PM7eIb1jWJXAkEuNo8JC7K1uUz2yrui59KtVXJE2MWNzRipmVayQwtQGUkgQdUqfif+oO7Q6PBO4yor9Xn8lAVo2gcYYXtlaxXJXg+CigIe3zrfCUOJDkZjx9ICwr3XXrUtV7GTzlqCVvfKoOQM57WCcyGxYxV+ymj2woERaCGnenms+cEPHg==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:hzr1XW54egOnv3ApdausNfjNmAANVEqp2j5jW9k?=
 =?us-ascii?Q?Um1a4sDromXy1NytCK+nLah92FKTYaL+dshBB+kP2pDSAOE+c3NdjUPSg9Pi?=
 =?us-ascii?Q?SUL4kpBZ3A+W5568t10XjBylfEihng+aXXPJHSc2vDZ+/vY096q04P/0SI+L?=
 =?us-ascii?Q?VmbVoz2Kne3UhELqqxy7+/IlNqdTUw9OwVdDv2BeYK+Gp4zGAj+kbCquWnbN?=
 =?us-ascii?Q?50lPU+EjyUg3kULS+FzVuNhwEXxWePnsvkQmIgDC/yFuEdKAmwILHeEryqiX?=
 =?us-ascii?Q?xQdfaoCuDUqSrRNV0y7Y9aQpsBKE+oUetODTVE3VKI015nekgydB91PvSKVC?=
 =?us-ascii?Q?U4+J0aOfujCMasOaP2kTF8mKiEmIZ6gsgCuh8l1wLaSbJdwFiyz4nmzln4/j?=
 =?us-ascii?Q?DeYBeAcGvoCBHkHvgi+CtkoNejRpwCOeNxpF6RJWF2+AT+F+yUP6Ov1MWKDf?=
 =?us-ascii?Q?0072hrKjOEXHdpSHW2Ztt1pU6WmIQd13y9GezyvleNtwktCRVG5t0Vhy+C/E?=
 =?us-ascii?Q?l8Aqek59qaIjj35fDi0XMHwNEpsKNFk5pc/RfNww1R3QhsWP2UOWldiyo5fx?=
 =?us-ascii?Q?mN1MsdAZptf2ShPW+vIZV5piV9B3/7qwGNE759yS/IG2sG1g9kE5DM1+B8U8?=
 =?us-ascii?Q?SP4RrunIRJkU7uw6Wko8rdMoIzhffXda1cjmdEHfOio6HNj/0FnCpyCCb7tJ?=
 =?us-ascii?Q?EXIcVbEjgfluBzUHvZyNUm9KbvRGfo2EYRL6E2hK1sDaFjvdGrJhKabcWlWq?=
 =?us-ascii?Q?CM69JFg925C3fmrv7QTzp2hoJlbQC5foI7enEjzrl1+BBqLtAlMrWTxUAExy?=
 =?us-ascii?Q?JgUIP+N8BIHKi0QdZ3baN0Loe11MJmxKpBV9D91kpFoLicfNohRw3TVTemJK?=
 =?us-ascii?Q?lOhCaAntvtjFId+Ynnpmyk1T97acb/LRuWu6cslv2jRIkhAb+085AlYHLrGq?=
 =?us-ascii?Q?hGP2TGV8wmYKzvKHTvgfOtli+IOQbQlbxm49y7OXVgWqCT/TWxkJcC06otiB?=
 =?us-ascii?Q?lYzA+FyWTeVS7SA7zDChXGU6tfkivZ5wKLI2bZ6vXUSSbBaZWNo6UvZQkqNN?=
 =?us-ascii?Q?kXsxfvFpAKooy8TaqfjKHv/cYWisU4hoHnhhUpm9Rsp/RZRk4k66agum5qSH?=
 =?us-ascii?Q?j+ooXWkE/KGg8mDLr3FP7rkhE4cixRhLgXlYvpeL1DlFEBES1K5kGXtdten8?=
 =?us-ascii?Q?mz4U43rCskC2bIdjsE3emKCQSCpxIFXnGP0obhQYnKr0tPi5YdAH9r7lGR53?=
 =?us-ascii?Q?A2pJqg1hI7AP63hu6IjVKRurqor14ibBeOB2vkVIkfGGK7m7+wk1fNxDwMY3?=
 =?us-ascii?Q?szQl3A0KbLDX/PI/RU2L5LDI=3D?=
X-Microsoft-Antispam-Message-Info: CATNhFLBQRXMfyLRp/OO0W7BBg1j373RwFxTSAhcGM2uLWj/Tm/ULS84poFAX8V5iGXVfs15c8RbGaFk2ltgiXGDmXVr/8NBz3HCz+eEHKln8e6ABGaSkWLf+SQNUUlgH7MOdHqCeyU8/N6WD+Rh1s6x6ydBux4jD1qBspEZAfUvC9lAUL3ytKT+kOLQpOOV
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:sk785UZKuIu5z9qNna1CqPfJGT/hvdi4vwiuDfn/k8H87zYpnP/6VfU4sAAnS2FFpOgveIuUtgBWbRvsI23m3ZT/EoV3u86HfAFY60+rePumQWl0R9SqysBqf+p/DVP7q/gVBRP+SmqUD131jqI9c3PScmvu1/MbzYhLWbvgQymZiMJF51JBWwBzOkl33cvHZ1f6ba15HtlLQnDwQWG2/5dXUe2kvXZsNmNlZDbXkVk49RNjWyeys8IHGOYimj0BedVfJEQ5ce+O39iVxHqtIuumcY7RU9yYDIJEXdOYBhPIO0ipLdzMRnYSCMY2o5jhA1GuKGDgjR97Z2ekuvhPIY9Fdlz19NSO5mIgJiKUlON7v6uTxua+yYRnOrx9qHxH9LUdBDCDpaCF+T9fQ1lSi+wZZfQfpzyut1E4P4xUMNCtK0PpTKAYnm9z4AXi5sR0wWemm//4W5ZY44dJRz3wDg==;5:esZ8FzSsNekgyvYk/FO8op6UZfcrKPUOBES1WDTtgfPc2viV/DiPiFj+f62UVC9zLOHTWz4YPImTRemEa2lEzgvoLCfhvRUJUPqHEz9QJIl72OOPMMpaJpTDPDDoMpPv3nr3r3vUjfyCa8PP9RX09z3SQ09Yz69fwot/AXbrPdU=;24:OG2rlK0a/a/mZz/IMe30yFevrGaT3xtR5j5Sn/Ij+zBdJbfC87fZ3EEm4G9jcrwsJit/2x8VQ0b4o2FLCG6zfIfmD0RhTj+0Hc8rKs3ugrU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:cJgythFYBa7LnSYNA64F5oOQTviXV27Yz60ApydtPImMOVIA6EFpECMO9JQPR8+h0RL0Anz99Ux+9t6myQeaUUTDSQklaadtlR/f8nqLMGZikmbSRf3cVDClXjKUPilpYKzTrMoQVa6lXIGmAC89T4wikyyuc6DY4/24J3mNoicjS9aMsTX4vMwkecNTiOgpU0o74DjZvBS9mRfZN+xTrOqPL7a/XyWfMme9ceqwL5XrAu3uwV4GJ0kCWk1zj1/b
X-MS-Office365-Filtering-Correlation-Id: 1fe0f0c1-be41-4d09-7460-08d5bb16059c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:59.4372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe0f0c1-be41-4d09-7460-08d5bb16059c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of an #ifdef and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/panel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 6d99d4a3beb3..f43d77b5ed20 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -169,10 +169,8 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
 	panel_bridge->connector_type = connector_type;
 	panel_bridge->panel = panel;
 
+	panel_bridge->bridge.odev = panel->dev;
 	panel_bridge->bridge.funcs = &panel_bridge_bridge_funcs;
-#ifdef CONFIG_OF
-	panel_bridge->bridge.of_node = panel->dev->of_node;
-#endif
 
 	drm_bridge_add(&panel_bridge->bridge);
 
-- 
2.11.0
