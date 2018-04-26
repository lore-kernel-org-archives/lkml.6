Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757219AbeDZWdF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:33:05 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757127AbeDZWc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 17/24] drm/exynos: mic: provide an .owner device for the bridge
Date: Fri, 27 Apr 2018 00:31:32 +0200
Message-Id: <20180426223139.16740-18-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:JyKXezbiXd3BbMCHg1vNncBMIb2PYEbV4HPL9oZLxM+sxU1Sf17Zpatb0FrYkMJy/EgeehWhhUo0ZASf3wXkCLy6FDiym+7yCW9ULeeDUbhc6+IYGgAzz/Cw2i3chPgpUtSy7q0qWP17fm6Clswc3ZO2yCcA5OcmsVgxn5gSxAIKPHIOsE7vK+gjX+BJuLgA/lzbjfOvQWah2hgOlo6BnAw/gd4IrxriRO8qAwuW23/+4XyiXIewyXMMbYuJ74wG;25:8lEvf0pdqjlJ2unPTYhJFWdVYdAmTw672+Hy0CxGNdtSOGd3XTXi5NFO+ZzvJoP08OLRfXPZx9Xu+I1gXB86hf5aeOrPYrS703GI6IQwLHXy81a3k/rtnJa/nG/pJDHVvim1hogSmGFGTcLGQtjLgBoGdAw9WAj72Fwj2PrDq6WPgWk8QTg0OGzZN/MiipnqIXbASGLWQP0XTLB3K3GRvbfPZ4CYZkBnGwSDKQYP39aS13rnrmQ5rLXbUF0KiPVtSUFadxDonQ3UzQD9CNBNQyxAJTgYFD79giU08TOGhCq3WNHW4LGAAxC/i02pRmoNOQFW4PrxikW2FQvsIkDdKw==;31:hOKHEZfjiVXqM6oOqAPYASlNjIjkYhL7EHj+joQHpAiGKxU470CCoxbaxINN0i4/0MBhfrkan0heHxDrpGtpgqxS1PKj+SUYt9xZipVd1jwmbXr4Ud6YmBThYRU7IexsXNc5nXtZVW5tlsXd/HpNXw7+hAMqaTl2LJQ57pPknD7CFPD4kZf6+tlZOXtNu12YnE2Nn/D50wqmPmhhvDPW42v2jPd61xana6L/CdrTaBk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27824517EF1651F8507F5AE5BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:UHo0QWYFFbj/iTrS7uukArPWxgxcp0+T2B5oxBYaPyJikRd4zjdNxK4woQlMmA9qnOQafJ0RF/4W3dMhksxe918ka+FwMZA5lAqSfX2mJN7yItyf9jdpM9XP6G/yzsYr4ykLB2D3OUsWdZY6xucD8BGozBHlKNjou51FLOQvy9FAoY6d8ttPO9yXL4mwRjuevDZcit70ww5sI6+S4/q/7Rjyrbj7NYWy8y6l1tx3UENHZpCxXcD9QgKE8XKKvtOitgEJbNs2lsT1GuzpccztsA==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(50466002)(4326008)(476003)(59450400001)(2616005)(86362001)(956004)(8676002)(76176011)(26005)(6512007)(486006)(6506007)(7416002)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:qpuxmqfHmc6kbXY4eR+Ygd51PkVus3yXHDuBW7D?=
 =?us-ascii?Q?SXOYn4VphGRH4rHVtnrU6MCGdU7BxJw+h1PoWtxpvz6KyL0HOCvOQot69xEN?=
 =?us-ascii?Q?yDj+/EBHN3GKlalNdc/P1PMUZKthpTKYW/CqPnqhudpDWoUVhzlrCNTrdzxq?=
 =?us-ascii?Q?AnGla1TA0PFHuPi5geJf2QNIisCVUDP3uYLiLY3aAaSr4vF8M7evl02mtscV?=
 =?us-ascii?Q?1BoFeLXzx70ltUB3qBcILc/HZpwr4cCQvkdubMpTOfGyGbxa1BhTQQyXiqfX?=
 =?us-ascii?Q?tmFpIr/M9tXhyMfdtrIqbbI9keHlUIQd+3kLmz3Jgivasc5cTSuQWXfuOzPD?=
 =?us-ascii?Q?7c3KURDIstiIo70zK/qc602zger5hXqTKjtZp/bUNqo3GfvWdGx84UgkL68M?=
 =?us-ascii?Q?Rzmi+NawidrCYm8kdQrgHdjJQubC1uFfCgaLEhG1uM+8tJRcz+ZBTmyiiF85?=
 =?us-ascii?Q?HJk4CxjemMR8JS75mpsW8Z7CJQm2BLoKkLppYDt+rjm73lmbpkZKrUzz8KG9?=
 =?us-ascii?Q?KfAdwlJ4M2gJ6KvoJ6/mnfG/dndOY2H543HYjDp1GOdasn5Z5mKvgLmdGQN9?=
 =?us-ascii?Q?EOloL2W0IkMDFkon+kC6Ux48e+1tr+uzjtSVhrITrfbftIM5FTM35vWwceEP?=
 =?us-ascii?Q?Bu5TWu0BhbnRWI5G0YeogoFSkq/g/EclKmP4wodvJHz8/XHLRNtg3eFPMDYQ?=
 =?us-ascii?Q?tXayLDS5bHpF9+Mn09Zk8Qo6UPtlpPQ5ze8dRAuK6tEyLAt3muVQrRDhNVzZ?=
 =?us-ascii?Q?p70Qv8iG7Q1wDcgBR3wExpVu1caMyvX7F+lh7Wabdz50gZXmxTtsnWc1lsm/?=
 =?us-ascii?Q?cJbrr1zF+ksdEir1lHKpa5qrvXaHITLl3zlkrwTGbco9fBxtLz5qshOntjOi?=
 =?us-ascii?Q?J9kUWDCoifdGnGQIY9rgDB69x0wkZ/CKUu5WazFKgwZVEGbxnQGfA2shX5/d?=
 =?us-ascii?Q?c4Sa/1YiYzMsHlIV7lvXcn7spl2M3YShPAaDicaE9kZS4jfuShP4urzDfswx?=
 =?us-ascii?Q?asg1xyyHa7IKXbMhBzjOImU2ahj/LgzrL21KGzApta2cAtQqIxxt55hkjIK1?=
 =?us-ascii?Q?VI8ul8VT6lB10qDT41aiwPr2LI85E0VD95G38E475/GwPiJmjPH5TJy9pM4Y?=
 =?us-ascii?Q?91m6jQ7UBnIUELNjvrxFFcNND51Kx63WQEUOkQZG8MzET2XniW8Jl8r/WSTe?=
 =?us-ascii?Q?dzb5vcrLDJNqdgLnFVKCJT9m2EPN5Bkpu3WUfjr+HpGQz4GkZfKv7z4j3jIt?=
 =?us-ascii?Q?9AANH9190hSv1Rc5Ipkf+4Q8sDHrbLB9gqv9eSrOMTuwOXGSFLZ4g3GF4NcZ?=
 =?us-ascii?Q?9NfeR7ZHzODk1mnYmDWnRiHQPfFSvH2lYqefvcsx//XP9025avZpNwlYUbtZ?=
 =?us-ascii?Q?+0x6J3A=3D=3D?=
X-Microsoft-Antispam-Message-Info: H3bZIrVnZ2uCSv/OTWVk+8WFCMZle16BNgyIiUKspMIhGUwz4J7VOyoF6pCQUYQyQ6wz/+PIZ/J0Gy63fE5lyv4YNLqSGo2FreluQnkkpuwA59vpae7J5BrBPMb4IhPjyREgoM/hRxfrRrqAeAUzTEgj0P+VNFhp3XuQ2sNUS/c14nY2qsoDedPBa0RTr8Nw
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:rrLjfCdbE7vkVKjqvieaVvf6sWTZpuQbdVdsFyPGu0eJaPlSbV3bz3/CZEScPJHiqZgUzQCBaJXNXAZ+YO7ICmOwJ46UFdh39evn/fJRi20Xs4BmQ6NdKfJbgVBGR/l04MYMmFE3wVH2FvBBECSIXG5JIslFaET7EobKwD36hFMU9C30SlRlXrxMwkByQPwlOlzqC8kjymDwL/Y3OsC60jXH9sXzTcptYpNRIsxEGkF6Bu7MyCuMmbxBcwlSiavHoUAXCkr3SyW6kP5gTQpk8VkEpu+prTz31k5uWlbTVZZQf4zKjzWUAv9ruYmHmGtulS6TXkwx9KI52+FJi/zWPtPqKsBxje9Iig8Xo2XmfxiVl8Kx9EQcxAOVzMiHFXyQuOreK6JaeoODww0YndGcpAN01o033GYLLcd/Sy7Y6Tb9ZVBEqycJPE+bduPGYhK0eacMiXMlHeqidFQNro9FgQ==;5:tP9ponlqo4d1c/zV2sLYvDczm+2W/t1y1qNadjm5QojC2DVnqwuSjoslh8O8f2eNHrlcnOu7OpZNBjZgz6KeVZATwemb1TwTNz2h9dWym+LuDtcmy6YHUkL3YGU9DWT1oj6WQ5dtFgH1SG5BADybt1DRumIMxsL9feAILgeywo4=;24:j3ddzgWZUSOKXj38zscPDZXzlXha+Znbl/YoCK/jX8T33HSfaOkHF5YscRDHmlhmNA0i5FFpFQmjS9/MG7MzdLv8dXUYzUHbMa9wQniA7yY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:RZja8C2sU/9n5zncGowgSd/sAkwIOMYE3HDUW7e/G7Q/qoET051f9/T3iRPgzoj/VIxzST3l7vx/f/SE7ApHTt9moNSpihyqRxaulo69XlBwt4N2vKH2wwP0lDPh4mTgQ0kpkYeIx942Pu+l1QywU26M3TvwTh5fOvfGzumaGb4UOWjnlYv9MsHoB+akC2pW4cnOGp5cQySIRfpSSJt1btZ6YdvXQ7LoXA9XzASgXJt9TGaxCMGWhJclPSS06vaL
X-MS-Office365-Filtering-Correlation-Id: e4b94dce-e2cf-4f50-66ef-08d5abc5a3c7
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:47.7141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b94dce-e2cf-4f50-66ef-08d5abc5a3c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 2174814273e2..453716cb4d3d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -417,8 +417,8 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mic);
 
+	mic->bridge.owner = dev;
 	mic->bridge.funcs = &mic_bridge_funcs;
-	mic->bridge.of_node = dev->of_node;
 
 	drm_bridge_add(&mic->bridge);
 
-- 
2.11.0
