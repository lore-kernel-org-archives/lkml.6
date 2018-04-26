Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756930AbeDZWca (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:32:30 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753393AbeDZWcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/24] drm/bridge: vga-dac: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:20 +0200
Message-Id: <20180426223139.16740-6-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:m8zgAMbyz+uC0cXTrZeHT7uHJA1pTg81ZFrnzV9BeOHoZm2o3Tyv8S5c3wZA6CuKzXsb4BOondlhifWQf9vQmFJrxkPyXNjFSqrXKgq0jMufoUtKd64nbLhUlcCubCBRaD+7sPnZ9UtlRb/wbz03qCJXi1djbaPnJWR1qqdNTTh3u/o5utRmu3t+XwyPkKUOVR7fxj+BgpzNtbEFdx6B0rp6jV6NS9vwCQkJsLBPtk7HoBNZKvSc6wjX07/lfeWZ;25:6JUpGPnYBbaXZ//K/EcPA3T9o8SJ2mZQio1VFegBxV68i6ZxuLFArjv97F/ZIWGYj0ItIw1hbnL23h+GtgptdxDoa3wGXcCnxC7V8/+yTIgSeA9q3ejtZW/jg70E8hHiH8nTtbpfDTNHbsuhl2VuwxbtfgFAnvcRMm0MUTiSbBlptj8rPk9KzA96vB8qpkWT94sAA+BwPwfgy6u+UH95s+B1o7v1BMlRRSzPopfaxQ3R5UomxZOxPtx0AZM+jICwOdDoCnFa2o0JinnlllxgWFIhTbQfEHwE025turlTC0diuVEzvigZUMH5/kd9jii79pVUqT8xSZmy6moLDCWIgw==;31:o10Tl+qFQtOYPgfGznDdO5RK3IUGkA/yXWfjHE2IUMA+PcMKeKFos4IKVNgKaY4PZ0GKt1aF5eICRWdKtbOaob/fZiRenGuvGgHUVAbKCKv6S4yRwZMeZFTEc1gP3vkdnmMwT7y3Sy+VvCR/wJa9ybE9Vgcv4CyEWaqPIR8iMTGWFqdyOKVTqYDMc8GQLFYfUy7hzG9P+2IPL/ykdiLFlWcQ3Ap5sks7LFrghmH+Cd4=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27828E8738A4A02E6A593809BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:TfsGDBx+ZndF2RG5zuKRD5WvBClUn1a0ar20bQ28nzIo4T/8+1A+Bcw3MxVFYQZCyjCEAyJnJThRzeRTzjfbxjUpK+P34iAeK5R13TxVm9sCsyAilUcDXBZI45CDpmgpyj7mH7ndZ27rodhdiAbDtTaeshMl1d+gitD2mooa2S7K5sJC1GGGbYaVVOxCdYaz4PL0pEX8u9K2JdswVHAs5wMBOdYorNWJCpBMLTDFtI1w7+IwuvwUOKiZbrIz4OUj1d5PjbHru0+sqq24CzEdpA==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:spVvhaf3Tj3xUDMRec/8wvfvnl80/T/jAs9+DvA?=
 =?us-ascii?Q?m/QN1xyLveXGIxoNPHtWczpd9iyyW1FxMCbR2OMcLDAqxXA37qWFSPIcFb6u?=
 =?us-ascii?Q?1Ny+j6rq035ix3eF3xHfCdKxRzBYTdlHh3sMXn8LS2bd+9TBkHFvOkeCU0a9?=
 =?us-ascii?Q?leTc0dhZEBrZwgi+NNO6HUGm8H6xU0AqK5p6H2cAgpyxGOZBbyCBzkaQ4IeS?=
 =?us-ascii?Q?zw1ksoDXfooUjfN8MpMwWJIW7zDozsWQpPTWbPodUVdUKtLXkvdR5ckKG5jf?=
 =?us-ascii?Q?oLVCP1d3y/XxI4mUAR13NLyilUAiH8URV7hnDcSBLhk8QvXd81rlITdMroLP?=
 =?us-ascii?Q?ko4eGrpuigevnQhSadwuqrRSIAJmQhCN4PlhDryievPt2PP+P76/XE9rrHrk?=
 =?us-ascii?Q?PESBbHE7FIrz1HmAmxI9qzjJcfstD55bQijgbpg31itqcI0sjqhAubKakqQM?=
 =?us-ascii?Q?VfTWvMmmT4yS5qzEvLYsJe2qBJiyDgHLtUpDlChlxCEZeFY9k6yA1lyGYPsm?=
 =?us-ascii?Q?d56k2Tm2BFCQRRi/8xROqNp6lk3wYp1PPjyIkFkb36mlJXifT8QmsjZ+iT3a?=
 =?us-ascii?Q?WZJMMdgkPuM+QloPrTjmsYSyU4dO/Zw0kjiOX8lugKbMtbek1Qbxar+PHvxg?=
 =?us-ascii?Q?QFnYAcnTSqk8upXS8oaeZwvdsRcjdQ94xaXAia1dGjeUANlvAJj9CTFDEnIn?=
 =?us-ascii?Q?R7mn9l5shWgjMND+nshM83MNBawa+uXuwH64sTvxYSniTrEEHbddZzfN6UhC?=
 =?us-ascii?Q?F+d6aYKz5IIDseUc7jcGo00vfy2MIcgS07xUdlYay0zxF4Ln/iAsEqXBw8Gg?=
 =?us-ascii?Q?89Q6nbcS5KKGj+4KO6dZsLpQ9Im0g3F7oZzZIiZaoaT4ihBBgcg+1uB5pJLt?=
 =?us-ascii?Q?1uDk0IX1bjPEhjBBa+a27YCFGaWfAivn3aG4MA8cI4mT1od8z4chfncLr0IK?=
 =?us-ascii?Q?/FdLjUuJrjgPVsEwy2vVBXMB5dsnNpPi0Xt+Tmy5s5HHJbCcuZz9R7v8UAk2?=
 =?us-ascii?Q?SkfMDiKJzVftE4vykWqiqBGg7xmRfLxfqeSwaSxzrlPGk4TNvb8/wiMIbS4q?=
 =?us-ascii?Q?j2C5hAYsc+5ku+tJ3izX3l3yN7R74HRDYL2FSbmEKzDGDZXGZO2L1o2RSDL1?=
 =?us-ascii?Q?ySIWzCImVb2Fqr1z6eyz1WhA3nznVFpyFWAm8Xyo+3lkRdEslKR+6PKb8swQ?=
 =?us-ascii?Q?NyzQYuEPnCsEk781uO72pdRd7drstxFq2uFLb2CmPOvXqHVQ7ybko5VnMal8?=
 =?us-ascii?Q?fpM1YUhbEPaBF3eQ+35Dhh/euGIQRAlkuBEh15/3/MeJCPTCoab0KUvK6xhh?=
 =?us-ascii?Q?oT5JotckhBeqkj7pAfDYH00FYJtlnZVdhTwaM7ZRwEv5/?=
X-Microsoft-Antispam-Message-Info: z+n76np+JzVoRe6QwPnKjpFDrtz07nI0e1hQP35eUEFh1S+s6IBKlgU6kdPByy0L7H1oeP3MT+aU+e9CUX/qIyCxZNl/K6Tu/JVvi3mQ5A+RCpLzztLj+E6WdHO0erszlDDi8vNzjOgw3fxFUNaU0ivEC/KNWSBBLN/FkKufZRWSx5EALiFxt0sVJHMK4XPG
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:KIcfZ87U4rcAA485UY/ZrsSuG5brDECQdS3NrsFhnt+nFx4g2mM0W8DfOQEdSn9DFsrrclRkipVYRtxyX7K17zHqsAERv79MEcCmpYuEQEx2yCrxMy8aIhS8PanmJJvI0fyQtKSU/3R8Bk2RgHXHLqjTwWwzc9scH65Uj8GXPh8fxbALDG6XAKnS4OG23V7rnXM76CpH/i+ObCwbVfJUGEYMCDlzhopSIP/wbgBT0eq7h9FMx7rpcHjuQiTLj0kBueT7Aj+02AEGjOo4YgitSikT/Gz+iNmVhvuKnfj7I/OL+XTW2M2gzFxfCoz4LqEsGIiQ3D6CKOSTuadDvM62dbjfAvorLNqDAAEuO1R6RObmZJJl8CKcc1+CZwl8oeKC+6AaVChfvbDBrdbRcwRAJlely+msXSJKnpoIonhSEw1hgBR4YiDOPOSyoxuCBdFNqQ5EesdBicfD3IzRXgsSpg==;5:k9llbCkaxST7HtEY53kd3+fsD0Fj2MCMQUBTifYTS6cx3IacKXA+woC1/gCeToZcRRQ/DKAIO5eFumnevI76Zpe/Jl9O/XfRV0IEiEt25pq0V4ArDsPThGto034x0UJE1PNTqqOrYzDo+uXnj1oupteERKCZp5Rnl6QaUoWIIV0=;24:OrHlQbf+ecGvfh7dEXu58gyrZHMtXRigG3P9GkOPV2nlR8t7ieObFelmp2XO1956yt5/kv5N0g1nfod4KjxWXK0L0/VBZ8lKCVuNBIgxty8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:afzxYhwxfpi0X1N1KNIgeHoEKIOJZ4txmULmYk7Q5XcJ9ACuafnAxDvt4ZZZQ23EYNrvOqlpIyH6RJN0Fnma0HA0IOL207mgVcDCiLVN4lIdR/NgmliiXk9K35VRZklCspebu4RXYqulUFrFHEUQ+6sbecGhwYGys1MvgcDEIYAnpvgUt7pHBOFl9CpWyF4jkfCJRutW/SuKmnT5djvhadJ8gKH7wLFz/iTnGxft4XY9fydPTlF3ehIYRSOEAAT+
X-MS-Office365-Filtering-Correlation-Id: 82f0e141-bdcd-4e6a-63a4-08d5abc5933f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:20.3230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f0e141-bdcd-4e6a-63a4-08d5abc5933f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 498d5948d1a8..244f6bfb8967 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -203,8 +203,8 @@ static int dumb_vga_probe(struct platform_device *pdev)
 		}
 	}
 
+	vga->bridge.owner = &pdev->dev;
 	vga->bridge.funcs = &dumb_vga_bridge_funcs;
-	vga->bridge.of_node = pdev->dev.of_node;
 	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
 
 	drm_bridge_add(&vga->bridge);
-- 
2.11.0
