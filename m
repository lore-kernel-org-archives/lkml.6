Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeEDOFi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:05:38 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com ([40.107.2.108]:36727
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751001AbeEDNww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 05/26] drm/bridge: cdns-dsi: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:51 +0200
Message-Id: <20180504135212.26977-6-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:Rt8a9qGs46YpZ+CcUfke8TFkXhZbKufnN5ex8AQ0JTDVfHvr3uLGA2r2xHM2kjD4HY4QWmYkqKHRLa+OCeeg8JtCwAZDVrp34sLsQLsPx/XiFEyPqB3QKBuIULwDWY2UZ2WAgTkOgOZV8yDjJBjeTfFO8+Hp74bJxlB7BraUPm6zEmYNytrPMqrzG3hJVHgQtZjXwBUEWhftH7mfwydd9LWm354iv5rHrGVHEzpA6m6xYVhRN2prgoG+aDqyKn89;25:akd1ZERhJ5ncaltRULiFtB8cPn17xGgqcAEPzGgjqbPi4a0P3zLV1f/SRto+CFnYJm0ZbO3wy+1kDEcheyJ3ybCU+eXvPe5NJva3drkdf29eyAW8TvyVpbbIgk/CFRN/t1pdSSt62fz9gCtevE2rO4N0ZWqXFnXMqAQi1pzEjl+BnmqqgKgoPmn7aCKcmbSYVD0TKMHEE5EMtbwm6eQeUvUs0n823ElyaoHNhun3QbUZxNETX29/UmYArA0++h8j2C/R67hkAwyPy5ZlR23ZZ8+12YtKvgfwCqNAhOsL2pafRdZt3/+jeJiZvGQleKMGGDD4Xf4xh8CbS6Hdmxe+PA==;31:Nl2FVo3Rwr9kIKfZmgmlY2YRuMaQ8kJiM+q88NFRCwFTWHEbRoKgA4enLCuPCpKiD6vp9KnctaADYQNX8DN+SsWdg6xNccIvdFRkuF6gRhwPZLt4oG1athWZ+/JAlcIFeR7JPkANABIru95E3FO31BP4jg1vMREl+YuNTKRQofF3Y/6sNtu/CvjULeq2O4WytUogWwMXDsBCsyrRKXKx89yAM0VIpKeLZFllLzS6gP4=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769A6D925FB8A17E54FEA5BBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:YM8wwRgC9k2gvpW6R8g0sPx2XIzYZJrq4jZ6XVDEJ2UH+Jmls2KmsRjFhlOwo5VWTE0GNJPJ8oN9i6WYwOasDuS7Uj+cihmBIVVnCyjfjpLJmq9pRKCIic9fb2MCWc7fDpf1uF9uzZdpiqu5Lh7J/DIs4qDqgW7OoXddxZu0JiyOrl57nn2bUGVOaLut2hPWaOSx45XAq7Rx0nExgGIXUY5KtpYHbuxJBMFB6XFy8CujmTxLOONXeXss+QarI4wqz8eIl72XpFn1nLHzrLwgvg==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:sqfCEKFMxLPqEuR1oQCEQTaKWkOe+CkFs0Yr3W7?=
 =?us-ascii?Q?TcFj3fRmnIeIOGUa2vlr2+s6FrbMU1E1S3FaAmCt2ci3/8jqUyz4/PXVWhkp?=
 =?us-ascii?Q?xtjrvaBNR4JxIyIozzrquBIJCLFSAH8hMoPZ1jbaz6VOeFIIjw1WQDncX60h?=
 =?us-ascii?Q?Wi3LT7hofWIlazkcd8B97PshQyEAoJw38zJ0UvNVLoPhHmgyf/kx2d5Ph8j5?=
 =?us-ascii?Q?LFV5SDQhKSAzlUs3eusfocusv1pt4TiuMbznLfAhE80zRZW4aCUTn4777Sg4?=
 =?us-ascii?Q?FnCZpKPKWBE0MFu2iBqOCAqFzxGY1QQXxRXPWAMkXWYJrqp/JUAOHfCBZgT4?=
 =?us-ascii?Q?NlnhbbYKPiQY4xBSL93Fk/4kvjeCKkf9hzeSDnRqpsDAI9vx1gXy4v8FE1be?=
 =?us-ascii?Q?/z1O0kyXe6DMl2XUfxyNs4ac7CNKUTVnSHHJZrhzN5IMN5ehpybox7YimG/l?=
 =?us-ascii?Q?LRmKKL+vpp/wyZR33CyU3TGqdL78sGVLEhuRZZ64l+au1szshI9CUcd3o9Vj?=
 =?us-ascii?Q?GZzOTOdr6X0Hz4565gtX7Wv/L9q3689UjnM9ds0uMFOEpOxTab2OnCqy11RU?=
 =?us-ascii?Q?yvD6emsO7aktyIan2lR29oCXMH9H3NDyhHI47aG47o+UHX02iN04A7KREhp7?=
 =?us-ascii?Q?ZAkXqvfVlHidnShBzTd4JvaPm5tqaK+5ccKx9SlbpWtKKQkYADFINWysGr85?=
 =?us-ascii?Q?aSM8AhWV0NshQJMls5qAQox7lF4u9E6iuaj17f5cRQz1iLgNQKLW4yNXStFy?=
 =?us-ascii?Q?ScRoEcfxya8yl8gZzA9cDrCrJ5FHECSFQTDEgajf8Hrh4bY8NO1k8gdbVSUa?=
 =?us-ascii?Q?FtqcLRzH2bdV1SAxKYN7RpTN2RWfQvAy3wzX8Ws8wjffyuyyvWSg6cHpYxkN?=
 =?us-ascii?Q?lrpVmtsDbNMJjufujmi3UjKcYSR5klcWNH72Xa7poFHTDhK3aN8+Q1DUWAeA?=
 =?us-ascii?Q?EJo8QmHDLLusslgZ6Mn0NYq7XtfX2PYuk2cnhO5BBYLBb2vC35cD4V8EAAHr?=
 =?us-ascii?Q?VluQELRzCJsuaw1bEHP3c/XuEdTBiNgX2/rx09ZVtG83uT64q0L63EM+nPPD?=
 =?us-ascii?Q?EOVSquMvSeR/1MMah3Kwc/P9MbaRkWSICLst8naivPY5Ttn8wTN7umZGpdqE?=
 =?us-ascii?Q?uleBspxBppIVkdkOjuaZ07fAtq946bA8SLjjslA01rMZv4TEB3gG3EBFTpMS?=
 =?us-ascii?Q?xQvi2eEymwQnfVIrsvA+I9REHbJDo4uqcUVXiuLkLnXeClU8s8atknRhBwiX?=
 =?us-ascii?Q?D/uRrLmg/876mG5sj40+K2R3b+yhcCxN2BBQFKsY423I08bx+Y7jej3WLRBI?=
 =?us-ascii?Q?a1c8HZJnGbBogmWSITeBH9TDA3B5QBzAHr6LORtiGm3oUYLSSE+gyqTu8dCp?=
 =?us-ascii?Q?qUZhp8w=3D=3D?=
X-Microsoft-Antispam-Message-Info: DnocLuVFyGecCocGOS5Ddv1gY7ZgA4AmzhVupWtpFkLH+5E0C7HhJjpE6e6dcRcRbSPvNeyWV76XvV5bGd2TFaQmHylubmwfdvXvgKEUa+gxCm5bXSW/ZP8sCuB4qMDbcOO7tmoAfJuvjCNUL1ZKBjjvcaso+XgoImjYaBgV1tqBAzqubqsr9wXMaZ/pBWJj
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:fWXcg+f1yMwzFeXZQA/1ZsiViSAZ5PlrDrfngWGpptTeGO7U2Pax2EjCcv58ST5fqEZwTxVPZhX/hO+qoUx1dlJXjOb/P0l95i2U93Obu0KnY0LC5mBGjoo1f2L2H4U8lMp5cyZxXMz5MOhpQ568L9wI/T/hDyBZSnqG2h4liMh0y9lANUQfmzhpGtRyYEBYwCdQDn0isJrEK/maQB1qyPshI0N/abflOpbyxJqg40pCmZ69S7ebhVl629QcvtQmSLMVkeC4XB+aQYVlIfHR/b4rCPExyLgncZRVCmZXADJeuVD6ASCCdKsP76FgQ2wag//mFItI4Ji5VkoDTHiZ0hW0EoRNLm/PEddMQr4CXvzdiLMMHLZTH3xVFgJmlNjMgjvNPgufFWUgclIbnuKiPgJmyBdRqfZCMGwm+vg8f0Nh8fUubqBwyoXV5hSptpZ4FvPQR/+DTRMRdCTC3y9lQA==;5:cmOJNwHfWECMMuKok2jfiJ0BbYM2iHt4pcYjeJlN2anUQqEs10WCgUGc4FwfnsUey02ZT+lQSMrHrn/OMw1uGHBFMi2aUV0XgB2ELI3Hb1X2cF7VU7rdWzXJNLmRWegpnCUYgjc0tUGvPNAhjT6zWsGxHqEirkpQqJRZh9bEi3Y=;24:y3afLNuz3XLwwyeP8UEHKaFLkqGfmFqzdqNFrO+VaW5+xkZC5Nw+vy5usKGpe40DPni2ym/gmGCIa3XYd40/wEsmGhDEvgbAT9mVjJAkn00=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:4DtPlLGhLer/8sg6ck04TGFO3AVjcOrxerkSp/UMGz3OQn43M2sADfXgbW1MjxJBoG1zQ0u0XBtt37EoO3j21t9jFBzgLwHvNXdwcKw/trB0mbmEyB3IjEQM3ZdSUsWu+D7h8nKNgbzdGjOh19EeUVm2+HPw7znF+nHZMijykKyXsI/q7E5R8ULTW4C57SovG7mD37ROwd+3A7WR0osFjduxvm+LT0m0koKKpXOk5u/ikrOtNcq0/y+7PHXUp7aM
X-MS-Office365-Filtering-Correlation-Id: 77cb3402-d6f6-4d3e-cbac-08d5b1c65321
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:49.2602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cb3402-d6f6-4d3e-cbac-08d5b1c65321
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index c255fc3e1be5..e9be5c3f0284 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -1548,8 +1548,8 @@ static int cdns_dsi_drm_probe(struct platform_device *pdev)
 	 * CDNS_DPI_INPUT.
 	 */
 	input->id = CDNS_DPI_INPUT;
+	input->bridge.odev = &pdev->dev;
 	input->bridge.funcs = &cdns_dsi_bridge_funcs;
-	input->bridge.of_node = pdev->dev.of_node;
 
 	/* Mask all interrupts before registering the IRQ handler. */
 	writel(0, dsi->regs + MCTL_MAIN_STS_CTL);
-- 
2.11.0
