Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEDN50 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:57:26 -0400
Received: from mail-eopbgr20091.outbound.protection.outlook.com ([40.107.2.91]:36544
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751757AbeEDNxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 19/26] drm/exynos: mic: provide an owner .odev device for the bridge
Date: Fri,  4 May 2018 15:52:05 +0200
Message-Id: <20180504135212.26977-20-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:ATN9pWPMd76MMmaxKGaMkQCgkARJtOXRLQxSxAo8tBL6lqgFce5nd3seFF5TzEdwJw7mcbN1num5kewMv+vTv8WGBNjdPIu63X5HX0+4YOOq7cKO7NVd5kf+1rIRbm+ZeefXk4Ck8Tc88UhlC7aE11N3mz/tvKgpfwyEW55viJWUO5bh893Iy5M9Ty6iY6GDOjQXNPG5lzkjgwbhr8PkUawf3KNbSHQoL7xRYuUqg2ryculyU0/m7+Qz+AavG+4N;25:zRw9Z5HPeVhZxiG6r+vSA7kMAmzyiXEmByExkOu/Ydmr2gK+omz3Sn53kfiFyYZiGnFg4NEoAUMbCYZvSQQhzNe/iiVoLekB+zdrxmOvJSWAf6RKL+BZUfXW06HKPzugPBS4kGXt05wRaqgAtJK4QDO2uqsO8lxigQZK5GQlbcoQtZG1w9ikIyyPgLNyxy5TYqUQtA3Px/q//X/8tzNNO6JTZEABQVv07kwUO5vRaMW7iKhFDNstIWqYW0kFIBfg+hLKz52ivURC5d/tITVvoc1n/BciWCw9/IZ+YbI7qCfKSk4zk5Ps4wB5t9zXTStV9jnDCEvSNLEE6cbiVG6Q+g==;31:Dnba9saoOKxw3oUsC2dXovicRUsQ1nZ29tuRhgiUbZWj71RKPjQ4+/ki9lTJOew5marMnr5k6EAs9ONe5lzPSk0P3q1/bRCYvOlP5mJvCAvvqMlV/Ns0joBcKDVF65Y39yEGhEKSWNcdndEH9D6r2m/HmluHqnQTH3a04Xabacxbwv1Vdrxh3Q9Pawtq4WUQln+YYBGc6bYRyebvIlsKczspQX/28pBFP1lB9vjqFRs=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769D28009A6F25B8CAC4A5DBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:3aMgWguG4Z6bN7fxh2P8jxXkKe6vsfgTJMxX00sfbdVWcakH8JmuvFKT+Auz1G/gW3+iCWF3Zx7mh6W2M67w4MNdgn5SV1GunPZ51Kwp1HxnsQeZGrlDEed0k7kre1IV9J7Akp7RMqWglo0Bdoo9ruOxDUtSszoMpAnFuM9MTIh5f1uIHlS/P68WqcCtTrHvcNrpoWMMDYMYSZnCs0PsbmF5etWc3BBvdwBoY7em414tnqpavncan+o3cHGx46VDwniwfjHPs5p84m3SA9vr3g==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(7416002)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:0ozywLZe+0xy8zYBSTxUr7j4pD44/4nqLO4Ckh6?=
 =?us-ascii?Q?9AY4xuo1Vblo9gqaPtPw2VXo11u2p4kgkp/hcV+/tUbkzJqErOyNLKUJVOT2?=
 =?us-ascii?Q?0JrbNlK4sKcKcMKt1F8qTZW+ATOCXgm0mMcxtVGtOLQweCumP6lsaXo7lhtk?=
 =?us-ascii?Q?oIt9ld/ikwk6UitcUnypPaDn9/uWXTu5O/iyBBrYUXdsuneO38u2aRRpLtXK?=
 =?us-ascii?Q?Yf02x548R3omLmtGw1cZHfS2PDsta8HrHdbRYiboHMq10Bs00xOIAUXX9mAh?=
 =?us-ascii?Q?LNNBzfuTEt4gmWL7O5uSb9XGtRcMtUlU4Sn4d8JU+1Ddh4jjjjEuTDZemKxy?=
 =?us-ascii?Q?1CREkACg5XLqy2OOkUkcecw8zLFd5Pin/U+23v4BWPXc7b2T2n+LZtMwnT8/?=
 =?us-ascii?Q?M38oqDPZn+bNbWZC10Sz8fHLksI2b28hHd/2Y+14p+vg8hOhDKfUsdaQLkZC?=
 =?us-ascii?Q?zM5VYVsTysIMNWIA2inxJMXKuR288tfmldkcV5/gbthy1mOSq3Rfw8KqjvAL?=
 =?us-ascii?Q?rYTmRKhmrgzmvgMDew4gjqeAwJrc1aufxArlNbjl8/ILEq/51bHAyov/SHqJ?=
 =?us-ascii?Q?jTdzSZYJl3zfC6pzgaKK8gFcdWlkNPIB/EeDzlvTgqJxNClkH+CdryteSHug?=
 =?us-ascii?Q?t1JDrSnJ/Hb+YkzZ9+U3IZSKDNyK+Aku01lLpCpA/EMiecN6TTS4kO2KYRlF?=
 =?us-ascii?Q?Hn4aQxlMqTypEUguSyngCB4Bm4pH/BzR6lww/38TaBmZcoiyx7hLEilO9eT5?=
 =?us-ascii?Q?Jq8tA2L7DnzFbfbFncp/VySpWoX7Z4kLL6QeQNXAbqUC26lcxwhRgm+U2VkD?=
 =?us-ascii?Q?Br8rDdEZMxQk9qGlhsioHf1Bf8zW/3j5WNgenWqRi9tkmpe4zOGvERcoemLK?=
 =?us-ascii?Q?HFiI/mzrppBIbfHtjKy+LC7rwywQnwL5MnjtFXbiRvlfow/MqsrctBPDwG96?=
 =?us-ascii?Q?aFH41334Ak4Jj6HNr+e4vaO92xKyBqD5zuvlTmsxX3DY9HNGATh84B/jO0RX?=
 =?us-ascii?Q?AnkhGvWwSoXEkgDlou/mD3Btzlp6WyA9uiOu//B/8FCHcBWdAVk34gGSCwzT?=
 =?us-ascii?Q?2jHUVn3D/ITgCc0uzErQ4jchjxCNf21ZUD3xN256J4toC1hL5W59ljmfmc8U?=
 =?us-ascii?Q?K3aIPYLzdTTLhY1dCkISCVZwAI/zJ1PfHG8H1TkanO7eV78prHYdxuyt0mjw?=
 =?us-ascii?Q?eUsS5FQQpQ+JLuZPX47opXcLavOcEc7uymY30jboFfwPWsESs7zWygv2xkU9?=
 =?us-ascii?Q?BzZ16MfOdLVqpu2USkp0apvvc+bh3FREwChSZpYLxRimwLbn6ktfiXnls2Y7?=
 =?us-ascii?Q?9DSet6oNssVfk4PRbbzhsri9ifnrjk/RYCuBXPDUbP8dK2p5QieUNM9SDoqZ?=
 =?us-ascii?Q?ZY4lJ8Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: e3y6Z7C+8O26Yd0o/Ag3/OcbqAYHcCp9f72Wz+KaxX13mecOdx/YU6OZ+FekVuR8ZKMiIbspBIZJVwMLW/A0jSF03MCjZsF/mWG7/Oq7SqCjAKdCS15l2nsU2Wf69DKOiHxQxT723RR9Q6nEyaaXIrE+CDgZJ8x39+LT83iDRFwTaAjarZVlY0n8I+yP4iQl
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:W0RoQSjNfwZ7QOrgys4fa6s+sCbMi/Peb0Qvp+QplX6trLeFmxKrQJyFO0VrEMJh0XExzdeMFiYBEth8WnJiG2CvGQGA1ztXJkIP8ZKn0pGhzN6nkRGIUuLt2iacW95sCveigEu8XVcd/x5WpnWz3MEhPLRySAUCMMBn54sIQlqkUvi6kWprNQnvp5PIkaxNOdZuobiD6n4K2zO+gMdFH80Lsm4ORdsAvV8jkvs6KVxPiXOP43EPZr9YmkLGRGhcioT4yTiT9TKeJrR9TxI2pidg9XaTZYte53yCC2UfZ2Iwa3VfbQDUeBd33L0jNzxTtnG926jVBssKyYJEN9fNJBkQuPWNcxZio9+LlMWKQSRkAdc1scxckWNHHSJt8TxyGUdPg6cErFSkKNhpIvgdQ1FQ6A7HCewqcEKDcngI64oayus8WGW1ZQ54e+/2mZoHOybISX/w2/px8UNb5dR72g==;5:qmg22XKXjJ1yhWe7Ymn/BQhuZOZRAI/dVJEV0TCpUYNKlJ2bEo/5RJzZCx6oQ98hH0n4Tbu2tWFKnR3Uyu6FoDwQISTA9/xR1eOcrxnQCCGWJ4zB3UkY4/4jNg3mVH3xw0DlBNil0jJGt9XKIlDnbocR8Pjvdq5f9YKgHdZo4/8=;24:Ezv81ExVu5zTzouco+nFaTD9VEgM5AJWhpmnmSjhFuiv/8trsjCiQmswRppgzsT7vxcSwdhtKBAsJdwUSQlqRaCpgJ7BdxhIBwDioegZzKw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:XTuEMORcd0v6SD2Oleg1O/iVaR6qLv+PztPCpZ6ICikz3LoM0VmWdBs0w4lrXda8/z8ieTWZxP4ThtzOMvjS8x01ot4ZCyZLaIFxKWEx1vz+lKxKqFPoQ/1t11jzkOp7uD/8qyYAEY5EIv3NMt5PtDjONc1ErHGDdGGu+ryMuecPlf78F/ymViAg33fp4sD8tGJNOcL/Q9BiuE0mV4WZRQClXNiMjlcTf787vvJuGkw8lMxmjVEGOqlnKYkwRqHG
X-MS-Office365-Filtering-Correlation-Id: 9459b135-148c-4194-f6d0-08d5b1c66abb
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:28.5589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9459b135-148c-4194-f6d0-08d5b1c66abb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 2174814273e2..f9ff8d3ec937 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -417,8 +417,8 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mic);
 
+	mic->bridge.odev = dev;
 	mic->bridge.funcs = &mic_bridge_funcs;
-	mic->bridge.of_node = dev->of_node;
 
 	drm_bridge_add(&mic->bridge);
 
-- 
2.11.0
