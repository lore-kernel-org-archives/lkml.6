Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeEDNxe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:34 -0400
Received: from mail-eopbgr20113.outbound.protection.outlook.com ([40.107.2.113]:46048
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751713AbeEDNx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 18/26] drm/bridge: ti-tfp410: provide an owner .odev device
Date: Fri,  4 May 2018 15:52:04 +0200
Message-Id: <20180504135212.26977-19-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:vI2pVq5FREskCGVt1LQhG2t9P9HeKvt5CSezMgT+jc1IrekqybhNkBvkdqNh8ARq6+z7OXIWoVTCFG6mkqvzofbpL3xCNDWjbsBeCxBZsBl9wS8nqCt3DYf/RQZARF5lGcnxoX/H9O76AteuE+RRGVs98tP3oIfrAgngvr9zfUVSqYMVjVMgajJiFcsvG3ebU0ktZx3y0gWVgG5K5V8ntVpUgFnmaUtNw581aEpdC+zU9mmEHpXmIN366U1zPCR5;25:ruWOBkgil4AGuvU0+BGf9BlVWjNrZEnNchcc1hL+K8ilP3MhXGV+N+qK2XhzcdNk49EPV99fz9cAElEgB9TbpoVnSNu08bQ8e2L0mwstEckoyb0j3ETQh8VTdINuO5fnIvDyu4EiwsuBeAowqlHH5dp/0b2WVxAYcJkvk0LK1+Y6fCGY53wHlr6O/8CK9AKhZnRTBn4k1zhZa7zK/nIdDREEFA+jM151/6kxzVE5U93RZWpCeTYRRzvba2A1bnBNKxqZYkYDDNn2SqF3oH5qKzqQBj/3ohUpWNVnQ2BzHvjcBidfrSsRC8ieJF7uGAIoQiV7YZUWCBwZ/zaZbcrrBw==;31:u4qonp470VkgSsHZ9pCD86xevimvMAvPKLeliswvM8u5VF8s4uXcGtgzrw2j86yzX7nIpsqhhcid/5q7gRDYOXMr+m+ske+xqotYLyQMu3W0iU2Ws9E8kZdF2mGpbmio71PJI/CyzNhfCT7V+HS0xo4V33BGjlEXc5c0GXj6Pmz7nsubqJ+e/TQQ0qbSkmdKGYwXKSP1K3IDxK1/uefb4R13QJlD/oUNBYeJoe3UR28=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276998AB2D34F6745B31E36DBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:pY75bKTSI44MJQqDdMLl0b9PPMIz6WZi4hv+wsPfcWcOUHFA8bv7UzpSmGPMR/HybQDJ339Z58nwRJUC6Mb1l0v6AP5ZeL8SMwJUQ1+etVl2hkI1GNrgJc8c3OWH4nISGewn4Cj0Re/2kFzlSvsmQCpkawwaEUlWxrLx4lkItMHllusHMYQu4mdYvZy0lt4NGoYUkkGyxuVCicFc/a8EWEUcgNxjL5xdvh4gxpe+/VS6yAd13wkUE6r3pKqSPd7QlzKZxGadix3gEmnPih+yJQ==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(575784001)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:H6SvsdUgCJDIasozEGe3ZenWw6UJsTweSgg46+Y?=
 =?us-ascii?Q?jkZOTZeHir5M4CPIGCI/GKAl24WfQ3mcF6p4CMve5OO1yuK1DFpsaVL6Joxo?=
 =?us-ascii?Q?MfjC8hTv4QlGRs2Rff5qI5ogMEJchtzAaHriBwbm8pd+NZDsm1hs4m/Hq8NW?=
 =?us-ascii?Q?mFTKZm9YLCSRR4uMIGG0//Td3aAMxsMoskHxvRoVekme90FFbSJq5At+sJAW?=
 =?us-ascii?Q?h9NZtOOy6pNpEbtzHJSrPLhNTGhnTVkrD/40SRZDQARZym1IHXSVOkDfwt1J?=
 =?us-ascii?Q?gnyMzLaT+gEP39seU5sp0dqRdUe+9NYKX2NuK2SsTFDpkX3NwgdGx9oCQMA5?=
 =?us-ascii?Q?I1+/Q/9eB7AuwtgHNqnVfgk7mLPhPt97XXuSHq3GJ7T+ausB1tAKRAETvNA/?=
 =?us-ascii?Q?OTvEAwRth91A9czdUyBJxvGsfdF+EUHa2bx9VUAFPdgrZlGhmxrkGurissdY?=
 =?us-ascii?Q?3COVENIa2l1wl+TXhe1b7HRfSHmKxOsdNas+O6pkUpSEKcPLUNYcb9obVlUS?=
 =?us-ascii?Q?myeTf8c03ZhIMGGaC8THyW2H318BNg8h68Fd2/kHk6QUDuZ1GMOyMy5GNoF/?=
 =?us-ascii?Q?RouP/PwJByWIlXlCZGFFpf3k8J+bsadecE8K7uiBSjvS5zcqrqWNiMGZqV/L?=
 =?us-ascii?Q?5Gwed2L0tkfN5lN8mCSAuK620LEyLrISuXQf8jw95v9ZZm/7m3kuDAgEIFKR?=
 =?us-ascii?Q?Jyu6g12hR3Q6XYSlbyDGDeBLGdN7iqK6QBV4+CvA+SgDLpXXuxuB8e5mMP0M?=
 =?us-ascii?Q?0BMasjF6INtvZKiLMpPUx+LTUzN525tPcnzSUNM/ZOMH5OYti2M3H0G6Knqw?=
 =?us-ascii?Q?inFKGbxtM3pL+ueKWajP6vpYoo3MBaEJKwoZ1J55YHFSSbj2pzV87S+axMGH?=
 =?us-ascii?Q?Rnn2eJgieZ5xqfn8oyS7bAUIrPCoI5Oji8uGUuF7+0ZxFs2ymY06H/01m48B?=
 =?us-ascii?Q?EjMtnNZcJR46Mv2QyOdKENY8FZevs+m87WXnPLv1LePotgGhsidLxc7WtUwC?=
 =?us-ascii?Q?tScQpx9oiB16pRpKv7J1wg5tMwi/z8rvApMO8yTZuTYWYSefq6SrYn7hxPiW?=
 =?us-ascii?Q?6V6onBQS49WgJrCXRbw5BYDUdWZTUrlWKSia4EbYeJ0/xaxXYHy9kwhGSytE?=
 =?us-ascii?Q?Z7uaxNzE/kEQmxkdixrDDsBh/ocx6rJol6plxCjntOxkxBPKUl2kL+Mw2Du/?=
 =?us-ascii?Q?Gc8FlCJAgOIruREgtZsmmhp2PuNUUok6weYQj+KZ4OaSN8ARWgAdEPe/TmtC?=
 =?us-ascii?Q?RvQgJrztoltq1qRhi1rBkOfi0PTGW3OtFmc2cLQOTn8gezU/9VgF5uME8X4r?=
 =?us-ascii?Q?NeIpTdPZFYlx+2M657DGiplIhE1zHCM1hqMUf9hoIV983eGKp2T0Z/D1h052?=
 =?us-ascii?Q?is9litWVCDVXyLlMGhgVZ3RlFGc4=3D?=
X-Microsoft-Antispam-Message-Info: YOLvcPTcMNXgKpCJKh5N/xw8ZJMDQ41QaiaaeR6f8JtILIP47FEUY9fngu7kmtsqg8CFaaGCcUOTK9s3r31MCfH0UPmfT2QiRYDj9mP9p0e43+aa1gSAhdfmRvnvZxsOWbQivtEpf7quP6MoZ/RSzRG+KH31h0q3Re3uWoa0wxNYBDXEymc1BsPJINaNiJ9p
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:tmoZ6KSSKpXppjS7qtYe/Po15El2pGW/cOJfdJHxkO5fBzh7QLpQOR4pMAV9tu8pzMyCrNBE1Jopm2/M5ryYiSQez7plSfsXTcwucTRFoCKmX/YOAcziIxbtCRRuDFaduCRj3bhP/PkJEVTqTYLN+XSr5KbUv//oq0BdRxqn1Dw5KmCi+T71+saMg6N5T0FrhnshkqEEYRfoinzaFFAKq3Qfj/uTQS+/1vko6Wv7CQmhY6qpf574g/xY+PjZAMSV8egYYFfynerL1nOaPzMdUJfjFMQ0Xxpl3MmGqwW0vg7AKYcqUPNOr77k6CWBQNKt4ztIrEVgiPdmzZQNplvPfzeED5esHu8ecy8EtKz+7jwsovbJHbOuTQmV/+sRtzhDUYSj1oS2wdao0QiyQoI81udwWJED1nVuaw+viTG3VCBMJvNydweK/EMlIu8oPSEId/5RSInjchfla5woWomaLg==;5:LVGYdyta3DXGtxai5WfUtRCvWFyMV0rp9r0W10JI4CyPkuf0UU4IfjwrgZgQrANDPNoshykc0FDPuLnGVhgyEdaXyNHcKjEn1jJwd2tiQ6Fp36EG0xlFKprgwEEmxTd+XsDnnwE3MQZZ/nzNNUXiyMxOcvySC0eWFhGVNQAXURk=;24:wsyBNzCbDtE+wt6+lpYNiL4YeX3kyH/qBrHnQHALX4cJrya+r/RJmn1gfl2w8/6s8+f3cT60JF3PB8gt0sY0ZSD2paTCSLl3jD1TwUyToug=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:JY1L6MlFKETYTLtZxAMUL8CqF3b8atUCy3H86wEeC13KsBPmlSiKpUcxg36Ps8H8wwvIQ54omcqnplOsXvlsA1ckEHVF8KUDW4R9Z3HHxp+gvCL1lHdAoQi8dO+v8uoheDpglpTmKZqwn5oK9tL3zePlkMd2NuKuS7FGwQ/YCIhApuq4rT+wGVzwCFDpLj45s6n21ZAtQrXDr/SmK4Vu+oJ9GQTAkjPEL9DlrLCtLDMl+rlgr9lpP37F7+5sZMk1
X-MS-Office365-Filtering-Correlation-Id: 5a03d757-de5e-489f-a5d4-08d5b1c6691d
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:26.1429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a03d757-de5e-489f-a5d4-08d5b1c6691d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index acb857030951..4745838fdf0e 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -215,8 +215,8 @@ static int tfp410_init(struct device *dev)
 		return -ENOMEM;
 	dev_set_drvdata(dev, dvi);
 
+	dvi->bridge.odev = dev;
 	dvi->bridge.funcs = &tfp410_bridge_funcs;
-	dvi->bridge.of_node = dev->of_node;
 	dvi->dev = dev;
 
 	ret = tfp410_get_connector_properties(dvi);
-- 
2.11.0
