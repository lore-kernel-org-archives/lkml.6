Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeEDNw7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:52:59 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com ([40.107.2.108]:36727
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751445AbeEDNwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 06/26] drm/bridge: vga-dac: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:52 +0200
Message-Id: <20180504135212.26977-7-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:GqMITQZdA4uBdoJDXWUYXdoQtvnSSTHTAMy0+9spRfvOlGuWVn/d4sfX554SHtJvXVJP8Ftnx/OldLGLklQxkFQBpB0YRHsi5yWNu2SQ223QlE92g3s58v5P579oEUWs/KAV1juC6F2UPjdGfsuTWxeNzEQvZKyj1RDgi84snkMEsdF2kGnqKZOMg7FHRNdTgUWhutsgIxQaD+6uo4UdzDDRcCLRIdUjYIs6ztaQ6xxU0dN6gp7nNdBjA7a5ZHjt;25:0Eo/DpVs94HczF4SZ4UMr/Atr4qhdIc+l6rs/yGkK1B4/AGBfo3xdKfP+2hLZDVfvhJh4i5Ya2Jis37j7kZYbXUkuwXjtmMPuEzulPyew539cCPRV4+ypHzWR31GeTROxwOKBTALY6GP/sVVyy6Fagb0u9EcScqVHO7irBzXAKt41ClueVrp8ikp/p52K9P/M1gQZXVRxol/Y4OF/9iUeSRSxVosAOexoW4c9Z/SESAjymow8Lkp3VU9uloHfXcuB4L7eA1c9t+JWnaX+3iRBmhxCwNXbJdyoionuBAbqhGij+RMQtTn+0cOtYc0CotuEx4/jcfAIJAoUUuDzOMcKQ==;31:6iq+2FLkmVJre1JdOs4s38RCOq/e2BnrnRRpUgrvQsD5fze81RT0A8IdIPDx3eJhsv5OZk/3UuuJmEq1lUbBl1u8kaH2AYiCTvDYTIuNwFhHnqqxRubrzFp+TfbExsNteQwgX4aJDInSz25TRTNZm/05NSmFMVGh4cvMRAauMxv9hfpxWU6wXdggBlu5T33xtZ9aqL1AWzMAKMtIFcqeaYLtyUZZ+EikIxZjgTH3iZc=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769722B31E5865D52EC6941BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:NV1ReXiyQlW8tkTsLYPZkLTEmuYb/TePMYv9BvpjCNsapUp+g4WPutpnO3sc8Od8tYiO4DTJhIitaLEwQWsxurNjv2DSu3d351GLpOu6+LmH6Y/1FT1QAnNvjGh0SNHdfdCRX7nANgJLWEBcG5H6CkWheCSnLT1PxPiuS0jpy+q+48vD4+vy8S65v2dQE92o5/OH4GmXwY9JLrH/hIIjlNAa0P/GiBroX9domnzxqpJ0KEjvJugRUpZ2SLtMGmnusZN4f2GTPTwKDq+aRAYR4A==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:fiXRnoUI6PBdxhBPkY5F3Q3qnYm5iK2Mzyy4t22?=
 =?us-ascii?Q?Kkxj/fk26OTyPzfudaHloDo2lxTWHtPEEhhX64pGDFm6AXK5MxjuQUUZ03Yn?=
 =?us-ascii?Q?v2rTzd8tF0RF3jN4r7sZml/fZbgVbWBe/bXYJi6k1sNS6Ce3ojBv0Br1W3yZ?=
 =?us-ascii?Q?iy+yPtqLusBLVgVrnNkzDVMiV3wqjqKaTTfOMcnM0WUilyngl4794uIiKaTx?=
 =?us-ascii?Q?ZusBh9us+ubbs59dzqNY5PYONnCRLMfsNvcwi1Rf5PX7USq1AibfczgPYYKc?=
 =?us-ascii?Q?bfGStiPSx28jepM5neiXJi7uQLWSb+zcKRcfYm6Hc5GlJy38MS94TBEEL4xJ?=
 =?us-ascii?Q?JA62ubUuSX8xJCcoUizfrTfnOxvuHiXcBCY6YM9U3XCTDhHeAEgE5kMxzzCn?=
 =?us-ascii?Q?QP5GD2Fsy65afY9vLUIN6NykbJ5gdaaUeulbIZSZ2u2RP3tP3oJGr7Vp+7US?=
 =?us-ascii?Q?iKpj+IwCOGOmTWgUvpA2Se9h7EWHoxa3Rou0vKcKeqFnJdzVxnb7Fn3n5jKj?=
 =?us-ascii?Q?fROp2g/bUA1tamUokCCAnE6GnleTtf1W9zYBRjKebKXfPbk89Vb83ErQ6ie1?=
 =?us-ascii?Q?EH8yMD+M4C06FZV5Ptc57Idd6f3hTjjG3NbZcXguLepz5F/FU+yXNV7qfh2Y?=
 =?us-ascii?Q?sFVmDbMgi01yA8sxuIrS+GiSZ2tbBKwHzfnTShHp45TNo5nkva+chpsZ5WON?=
 =?us-ascii?Q?RgipXPK/MYwj0ZaNLFEAOgeEMMbcSwgruMlA0h7i8RePp8dfnqA+Yix5rj0/?=
 =?us-ascii?Q?p19vosLai8hevEjmQ6AM4MDNkfTkjhxq7Z7nvzDFFtG2qwHvQ1fiumcOECvF?=
 =?us-ascii?Q?TNty2/UNJAfhkI45/ck0V1NDUol6cEibXVUzNE1SBqtxzGwXUpgXoVrpsgYa?=
 =?us-ascii?Q?CqRQRcJkuUISzodHpR0TLX93J28ODlTkojWLDY9C/1a1fQdmbHPpcUvXnp3D?=
 =?us-ascii?Q?68C1uuQ8EedDcDejicDP3zBwV9sXNToH5IQUM1knff2lovXkbjMOenLK2d6E?=
 =?us-ascii?Q?fX8CxVCPTUbMj3YOkS9Kd4PAZT51x55tjnmFBZ/QD+CnYq4IrIY4xlafg3i0?=
 =?us-ascii?Q?JjCFLRyq8firUl0zosji9+cDgqb53xcX06dmvYL2Q0eRxUqJX5Dt/Bnu+r6C?=
 =?us-ascii?Q?HPe4H5iiY+jzTJ1LM19zDs522/sH9z/yDltbtJC1QB+q9E2sxAN+YHLtJN+K?=
 =?us-ascii?Q?eGbDhSs5h2MPiz97PgAIHjGurm2QnfU/A1N79tymwsItKAw8vrhcXTBkhQhy?=
 =?us-ascii?Q?Zy2u+0CEwD8Rhw9ingZpb99c6AM95F2SrhbilFGWZS5AlEPCueX22Er09G9o?=
 =?us-ascii?Q?6VchI6tFWwNV2eDX0b5LyhFo2oLMB03dplz8Ea+uHPW2C?=
X-Microsoft-Antispam-Message-Info: 3QjHFOjkysyzqdOTiKlEvAiAxV/V70oE4CHl9iBar7eb4/30uywo1QD0F91DmOt0g0/gOu9pc5kguULFL38nGn13je5c6Cp/sMddYiwmAFVyQuMXMugK1jG9Y32oFbR/C5aFEr8nO9J2ao3yArWG+izOvwKr4Ogr5GiPHLPFPD5N/I/G+tfsp3y5GgekuNC4
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:iXCoPpeiUrHXK1UZ5ha4vw0Jv4SVO+OEyjqsK1NkVSrOjntDi0aN0PGzOt0ByyOKP4Pw7ofed1ihzSGJiepXczynuEs+jEEStEI2FtBrOcm5ysBj68goLHxqkXNx1jB+91UG+YtXhJa8n1NjKzBinxdumDJ/LDv5BsU5aJfb85krm/MyPIWeZ6J6Z7ZaMSo3Or5vnjRlHxOZ32i/WMLP1yCe9tBVNG0seH8sxTc4V8dHZ/1mmxFoujNuY5zyrtZDnGc/Mrc6cIHiRsO6u18odcYY4g5I1QLJyYGw4/ZAVYJHDNCHw9+BmHjsteamjGZfUlwdu3KmH4irmCJhYkij5m0Xu9p+iQW1VU4SCZAgLUQ6NvdEZ22T+5BE75/z3nPPktmWM2t80jmZ9IDoJ/sl/SI+rTXJNT6SOigArdsfMkA3BLXrBgnTF8r3jC4DNYyti1muhZQLVhMH+m0HpVP+yg==;5:MfQ2zaodPtSPrdIKZn+jcozOMjQHijyBX8yC/VEQIA3ozccPNEoY/P4Vrk/p4rMDcOp8klKzyxAeEgjGKLyqZWI0mR79k8oMz/bUNfhTwOKwqUE9jjae2uSiwzJ57GanIeJwV9ryBbMf2eTFU4UFsQCB/asUjRKxEjMkuoSfXvY=;24:u7CbpgqQ3hetdm4HmUqCQvJYCSNvSMB/JG3vsIfoyu0hkWsRUL7rP11oI9SDVUO4yFrpE5f8yaxRteHrZW+EfKzhC9MzNeoeDKTSkdqQc8o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:+SpRUWZ9Hs2pPoMg5pe+FmqjRjDEnZlzgCQ6Me7gGOrQ3RW36Blgugc+evKeu5uuUdrNi3GuO9/qI4jMWtvn4eyOdhbp9maf+wHra5R9q+K/OfxiliRet4W1Z+u0HfaH8KGMEZiW2WSW6Id6n9TgpRWtoy+06q9R02HgQZkHti+DmrElkYLpSInmEmuXVDbqYdZS6uWRcVHUUGT741jFWihCBEMFG4CSX80xQc8iW4i9NQCo+jPkI9uiupiuQgJt
X-MS-Office365-Filtering-Correlation-Id: 856fe9c9-5dcb-4fb8-ad92-08d5b1c654c6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:52.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856fe9c9-5dcb-4fb8-ad92-08d5b1c654c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 9837c8d69e69..95cce18e8943 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -205,8 +205,8 @@ static int dumb_vga_probe(struct platform_device *pdev)
 		}
 	}
 
+	vga->bridge.odev = &pdev->dev;
 	vga->bridge.funcs = &dumb_vga_bridge_funcs;
-	vga->bridge.of_node = pdev->dev.of_node;
 	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
 
 	drm_bridge_add(&vga->bridge);
-- 
2.11.0
