Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeEDNwy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:52:54 -0400
Received: from mail-eopbgr20127.outbound.protection.outlook.com ([40.107.2.127]:53376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751302AbeEDNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 02/26] drm/bridge: adv7511: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:48 +0200
Message-Id: <20180504135212.26977-3-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:CNSRDb34ANK/ECMLHJrcBtDHVTaK4UipsNyVT+jwgrxLmHYqTGyvXR7PeTnIVKL1O+fz0P8+OjklfpaVGQMS/EFRFBDrHM0L5a1y3HNOo32ZA6+OXdYyh+hIqXbSz0EA0zWywWLhpP8eUtjnctt9k9+wokfXE1G9S/0+S2OKq74NwHue307gWT0ZCo061gkDlZTgQdU+RlmQDCvpTy2loqCB2DF4LxFliaPWeHwlXqP6I6igrTDQsURgYRn7kvQT;25:sDLvskub50ybwL1AiN5PYXG9b5FPrsoZDtjA7SaFLhYwnCpoj+0u5oZLlOWKVZOH85OulG7FQGWObp51p5tDphUihpuobO7DisaCCT6rgjLDDG/Hu3TvNx2wGnN33BgItyMoxMZBRn80Gg5g4Bn+acV2Km8pp7B47vYD1cp2BtHRWBD/RM5+KSxAv0xUWQikKvK0glJKFOFiGBwiIAB5ofbG39FtELhlcYak/mqtiAs9hyD11SoU3iRJYmBqMK2MWZQjK4Q352r/JNqr7tqv1wS/RCEEVn9ukpOLowWpDPRbJGhRyv8ILiyhfdjr859vFPUQRcsgJzP+QdAkF0F6qQ==;31:IvIcKaKxGrlbz2cq04kfF8SPd2FaNhZpXwuh1jUGl96MSy78Sdqf5ecqwEWLt3czbsuuuF+kgyQahHiB3h0LyCoXR1EMWX87eD9MZ04ZGHjrfQkp3gvHDbtvD7TPpaZ+2RZTBFkPcuGB63mAogiufEQS4FTow3WWg7NUe1EJ/P0xJ6Vf2RHlaD/iIQ7+0JAhIRjgTNyZ2dvPbSj0UBtheVPEZclRdAv35jntSxjNbB4=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276988A3C6386BA40ECDFBFFBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:VtyRvOOWpzAf3YO2tBQI+1NtJTqlraNcw3WAJ5a+rz/5Dzeh2ItBlD5vvqcYqz/6KHzPB3cehQt9f1uN966192VxstqDyNGPQI8f8b9rijyK9nl1Sdw5BMueaxWOZhWrYEi0GRILdKqUysMTvhAJ6+wJ30IEq0wUOJyOQdTMJ7BD9nug46LB6ZAcE/em4NC7tkFfkxn4Lmdea5QNcpNls0piUUvMhhfhnSJqgKqk6t0LJviUPyss0ip0Vvy/fnDI04HzMcWyBvAuCju2K8q3ZQ==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(575784001)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:jdRRDNv3HFVwP++RNGqjcTqI46gHVeNtaMbZMif?=
 =?us-ascii?Q?1E661mJg1dNEHvB0Q5vh/gb3pQ+vCF0GLkCe2x1v+JSYlwletmrPKUxYV9eS?=
 =?us-ascii?Q?GJ9dpcMUrJV71aqYUvfMiLDSHAS04uxEQ8fUw9FC9RU37FWj6ZmNmOcP8Ks4?=
 =?us-ascii?Q?d4dPzcLcGvFQciCvt9s1BEZf5bdfcrxKmjHXhXqen+CyB2maW7m8P/GCMUyo?=
 =?us-ascii?Q?PfhNpK9FOPpBeqcHj80rFQh8XzsLZSe2DYiiIiUJz3uGgefdrMfSswxNt/0w?=
 =?us-ascii?Q?hXMb+61xdPGEKg6PqLYjBV8Ecc3Volxrf8fo2DRPmIaZKT1XNqL6sAq+mof5?=
 =?us-ascii?Q?Q74jaKcrKmtuTwGmOLAYm6JogW5hITPV8VVtR5AZHP6HdFlFDcAEftr9PuQP?=
 =?us-ascii?Q?BILVQiVIv03wj7LGBM8uxkJlIRHdK933wg4/dJabObiQ7+6AXPPeqgb5tTHZ?=
 =?us-ascii?Q?HuERyWHQgJeW5rl/PoWfazo6WV7Uppc/pG+frD9iEuORisFIABcRgzemExmO?=
 =?us-ascii?Q?8VkvGKWqmUQljkzScDFZ49r1+ep6rEtNqYSWQ6ta8MTxtv8ie7WpfbXZjfFX?=
 =?us-ascii?Q?U8ZIRSZ5JhtewKuJQeVW8/6Wkp4yZ9aR6tijH+1fEkL+ed8Zx/qZNy9pku0X?=
 =?us-ascii?Q?5/errladxPUI7tRj9y6rPJ1dalPSegJCs3FXZPypCaYBid2RpzrOReV1IdmJ?=
 =?us-ascii?Q?TljOvLBS99445oRuytiSFbZmoO7YyTu76ITCjd13ueMugkTGPihVdq7C78vA?=
 =?us-ascii?Q?AkPtARtlAN29htGtJpq/zBkIhqxDpBiUv0TKzI25iYMqvz7kldWteUnamWYq?=
 =?us-ascii?Q?+dqtZ30AEjN/QDEi+4LI71Zh9uMPoxv0lY77xKpgxCYBo958k4C7tv6gWKZa?=
 =?us-ascii?Q?4vIOCSmervRy8wLtrNHJlO03x7LcPA/v1xlMUnliPgWCydpisQJpenIC1THX?=
 =?us-ascii?Q?VZ1RknqR7f+KYzBEy+eSQT/kSsPNgngG5AbPJ4vaA0aLOUGCjFuYG6txo5Uj?=
 =?us-ascii?Q?aGQVFhAAamKMXgEDF2PtVWj2hmFuZn7TgFMas1XWhbCThylr2mYfwXIgUK57?=
 =?us-ascii?Q?DehVG3fOew+amsEksfm4BN1Owrn6YKIp13boqZ/4UgdanQzbva+eL2+7aXsU?=
 =?us-ascii?Q?UN8ckQ/7oxHAxsOWGhImjGWxvVxfxhQ7/U9i4//kqzTr7xyYunJYB7BJes+N?=
 =?us-ascii?Q?FBmD2b5i8jVrVt/8V0MZkwnmvmDpruBlGP48mn5STvFBZsOhQD3p1fnvJsnT?=
 =?us-ascii?Q?cVeD0/QaPNJJDmZ0SbPCCGVgkwlVWPqi4J8n5vyEpYdCj/q63dI6pMB2VgT2?=
 =?us-ascii?Q?Yq2pD1qZnX6ir68kmlza0mS3wmcTDAncyQSknhXFziCTT+RgOZh8f9iyiA98?=
 =?us-ascii?Q?ljAaWPA=3D=3D?=
X-Microsoft-Antispam-Message-Info: /7YDm9JoU+MkU/xLc6eR9i/ZmnhvPIg04FbqWdpe1tIM1QaTD3d8GE6NRJ4LiWa4t3AItA82JwuJolosLULi/Hu+N3wchTM42PCq3bIxM9n8KSOidHfAEy7iAfFPzi0IrBeqiae/Gq7Oppv+rm9yZyLvtGA5/JTd/AEZ3AUSCd6ZI3xHVTMHqQa0QVpCji6N
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:9qX9Jd6CoA1mNsCDMugELF6LtS8nqMbgpQWjiXN2u0h0+MgkXqKY8JxIrrnKE2APlIIkwAxSRemk/y5z89lF4LCx+tmg7fKc5Ne+Sa4JJ0kQ84B4FFOk1D7FyadHj8vRtmpW1M/GN7F/TjPsx02mHFPkZNLpcyHzh7KB6l/ZuIY8DSNR204uwoUjRNeYgGgIFtxkQf6t+yUw6bJpHj7i4swFZ1o98EPfFhAqIIEgCphB1YYRDUr6jE83D3BjPXpyh2IpjGzF9IMZzcyGBPm2NbtShw8MyGr1wa269N3frUrogFLNwT9nDarvQsiAMUZvNyS36XHCPnR/LPug2M4sYOvPrjC+gc3xOtqVKTzj7/eqHA+yix8fLSAbGUEe9mxjUgI9larMvTOBRvqikzcnAQFqKsdLSiNIWEry+xPxe9XzN8vHVtXanaxDm4Q4GSmcP4K0ml2zFqWZ/OAn2567jw==;5:/fxLEVHIxt/njtFJOf7ZhqYnGBilaQUOFg6U1bWsZMe4WXyIwXSrZN144roaACCG2JHFJraLoKrQzER7CmXA+OhipM/lcCbeLdgXzj2MInpgfUBVgn9Rda6WlF8yrYYjlPf2UtrFgNUBoHVTGAlKjg+xpQ2ZtAezQkBYYIpIg9I=;24:E+ndgoFUjeZi2WlpiY1DCmdY2dZfgujJybjAZI5RQTnhPwWctaU3mHA37eYzE0qQi8LEpWUBak9l9l5tsOnd+QjgykIEiFL8bOzB5VSSTSI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:fqpHL/qJvgtnWfGVxaoIqVwkmfzBE1NmiHHl9ZUwvBtWbGIFiguTutqxRnwjh5kHj4eX6DyeKcYwt+qiVEikcO4ezjvUZbH5wAwmZbLVV7NrsIpsGBjMhag5PoMrALWp9uAIims3EUR/0lMd3lSrB/tx4jrcGY+Ed69eC0ZtO3IqxtG9fp0VhDpJpWuanBXBN6NuNVlDDVgjWTeg7gxTJpij66a3+Mbrup5EcPTBReW8fgQs3r15UtN7Xx57RDZ9
X-MS-Office365-Filtering-Correlation-Id: 94a0a1cc-3f37-42b5-f2b2-08d5b1c64ddb
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:40.4138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a0a1cc-3f37-42b5-f2b2-08d5b1c64ddb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 2614cea538e2..fd2eef916b0b 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1204,8 +1204,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	if (ret)
 		goto err_unregister_cec;
 
+	adv7511->bridge.odev = dev;
 	adv7511->bridge.funcs = &adv7511_bridge_funcs;
-	adv7511->bridge.of_node = dev->of_node;
 
 	drm_bridge_add(&adv7511->bridge);
 
-- 
2.11.0
