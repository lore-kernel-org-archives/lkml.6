Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeEDNxD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:03 -0400
Received: from mail-eopbgr20098.outbound.protection.outlook.com ([40.107.2.98]:15712
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751461AbeEDNw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 07/26] drm/bridge: lvds-encoder: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:53 +0200
Message-Id: <20180504135212.26977-8-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:F31WF90zHIXxz9FXlsxnb2LFV4WWXTq4qclMzeaR3sijFGhhWUsTwXeYjY3lKevoAmD2cmQX9/Ws5PhIvXPQB4pUEJqUsiQ0kucBEcFZW6LwoCBIKjJ5pddSI4/eDN8ARDFNvLwj0l6KmrZ8xnA/Zz58SqHWdRWU3no7X+ZMxilb6IkL2TRSxGitKSRF5SKY33rgGk2BiscAV4YsNtji6sNw25fqrrk4TRVsGCQC45fAFDUSihMEpecdbNGx93dL;25:gHOkzS7Ud+bonL0D8GzEY3TATy8ElXiTKXKPEjKgk8GCUzmvJWiq2tgll5/cCOUR6zpZYTJhr350PprFrumoZInkunIZUtF7wDZKiB8sYYhm6A3H/V5HPAwe+CdcpcKUR+up+kf4HjFL6r7kojVqjmZAHZDRNmZNXtM04sKomYhPJstp0M9NR6DEsSC6K5XxCmsak9Je5UT8/ducBSt2OvziwiGuVYefhizYUGkjQoJtqX4+re9ndC/cHKY273LT6P4BEZsCcqBCqmj5Ms54TsMNvqQNsmHRrIRiyU9LOvDi0wg6WGE3B2Jj8kkXoBo7Ph0M7l62JJqve40cc61GiQ==;31:rl2lxRA5YZUY0ldic1oTzyTl1JKH71Kdsu3EPe/AF21f5RGeL9mxYUS5uvi9KB5AzwKknIj+lKbvf0koAzzflftEwwi0djFgFiFjau9CQruYu29akW82RVAxAqP5pwDp2mZETBRVe5v7wZJA8s4usl5jJyYcbsFBC1bfBH5RTfh6xpU58zDEAnDUvaj9Q3+5eeubkuTTfFmJQ8evy1Lt6E/unKCjtvBumP8wOAb5rhA=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769FE8905B36FD17C17F603BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:LZ8ZB2eaUuUomo956FoAFiqidNa66GN+UY1n+zDT0N+J2OupcTxoyQeevx0DMVMYd4VWK4M9412tDlnmdk/qajewlULhr4rxtMaDN6CiMJXVaYN0h/KeWkICBHqIoNxdQklJe+ftVbaI8IimHnVEtGynBOxP/e5bAhzBafXqnPjRtsWDNE5HUgN7kULCGKfyFDdZYKEv4QfaKkmDDMBNRhL9+htnGoU2oX/eqL6OokkuBxU5kXETGacIwJXQpVBHFOLLcFN9bgB66+uvh569uQ==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(5890100001)(106356001)(478600001)(11346002)(575784001)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:lDju2fNHRDxULcJXed+e389Mu1sUjsOB8zZbX3k?=
 =?us-ascii?Q?0hELjIILy/VBx+jqsSThuixJ97XQpjhDOrzbsbr73WEWy6z+/PAJUpW1A3ne?=
 =?us-ascii?Q?9dz4H7Xrr5mBvswl0larx7aqKRQLxe8Gv6TvWrI1aPiLylJDufcslb5qGwyB?=
 =?us-ascii?Q?RnZANCvcyYsO4rzxXbU+7rKenNX8W8zwu7/75G9jotB9u56EUfCAXpgvTrxZ?=
 =?us-ascii?Q?52nVqhwTuhG4lSUbV8K0LvZaO5Sdw7wTJB+SKmW6lKmxD9G4948uEZsy7e+U?=
 =?us-ascii?Q?FQrCi+kkgC37pmZQ0fIfV/mXSGbfQOEt/AIeE9BtIjronc5E1g5ek72jOE7J?=
 =?us-ascii?Q?1Gke8tP1ZCzZIcOelxrff+/8mgVDKoqfDO6HqcN1aLpDafRBrrMcGGnKmDCl?=
 =?us-ascii?Q?JiQ82LVevSnIt4Qu9UinF/eiXLr66JdN7UHCcF9jtifLYdQORvTpByr40Vqm?=
 =?us-ascii?Q?rdF4iQaXki6HsqrNVg834M76LEbtur0ibSaM61fsuW89/52R8t2+enS9JX8M?=
 =?us-ascii?Q?vSFMAOQ56orWmtixQIb21j6f+V3SLUCwxtRZf72Xv3I8Y18+/8QjWoZzJ1Rh?=
 =?us-ascii?Q?XYPvEdM4l2ITwxAZ1CRVXg94dJHJ9clU3zXIWCb8zeOH7QBC9vaPctV7bGrC?=
 =?us-ascii?Q?1tsFm109ob+9ldZPytxwkQJ6jsg8QtsESoRv2p7MCzMgzDFh5iUiwKza5rV0?=
 =?us-ascii?Q?C4OxnrZ4AJsulNVpirzGaIT0yWYxUrOyqzZjFflOHBUsP8/XL4UFzbc3S9Oz?=
 =?us-ascii?Q?F7wuXYX4s00xwHwK6YnYgmrRuwZM0n5BGPwsb3G59Ykgtk1H87ihD1YWxnxd?=
 =?us-ascii?Q?WKxfVNLhXIOiQVMQSCFYiOmfcXLS67ZrejcW7GbuqxzEW8aaIV1QdEISoAcC?=
 =?us-ascii?Q?Hh6bTBeSDjYHmRmSXk1eYSyOGesFKDQX94+wLwZHxQpvsR80GkFYjlasjTvV?=
 =?us-ascii?Q?N9p1CZFlIDgTEEb3OqxiwzVcLJNKxovh+ZPRC4Ko4KS/UJFCD3UpTHe3o1Xy?=
 =?us-ascii?Q?u0bDVErXTrsxxk3cxoFhcO4rZG5MNnR+KXK2YaZ8XgQ/uFxV2wzodzbsSvUn?=
 =?us-ascii?Q?LzBa4vHIjj7HAq0mR6r5FnUHeleU+mCr+srUok6mb6NNWQBDpYKUXk+UK44C?=
 =?us-ascii?Q?xGLGpGAnk6vnzvMO4/x6ihcseS9tonnywScV5eeQr9kmiNmR5DBpfNUlbXzS?=
 =?us-ascii?Q?LP2zmd89VD8PIVwAYy3TWCcwWbD2IE7Ae50VsipgadjrxPs3+RVLWNOltDu5?=
 =?us-ascii?Q?3E0sEzv8c+I3JgkrRRbvtgWolYMk2LarErJot9qrCcf9cfHvBPSqzi3bq73G?=
 =?us-ascii?Q?8abKvgczkuy5tW/k28ChvsfjhdGqD3XDiP9ga0lYR2qLw5NBP3vE4PAPob3r?=
 =?us-ascii?Q?gVXbuyQ39jO65Vyt3BfVtN4MB+r0=3D?=
X-Microsoft-Antispam-Message-Info: njM7tq+rvd9FscHBax8PxZbQVKa5MAvd6sHaq6RMnk8bsw4GGoARYCEE9HSxwbrVGuOkyctKqkqXtjqEP/n3ObfuO6mxnfOW0/hklHKhd9/btOU1wNN/y57yq0g0NzuZbGW498OcI58Psnn+j52jRVDybN4D9E1ISVl5PAvaifwTNq0bKDXBP3EfDcgSMYUz
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:UCIe4BqT2yi2A7++W/Cg7hIgUkYVvbbdI3dHizN042gaBKdUQrGDUQDPa+MZXbbTLf+5GaNyXWdDN8vwX4zBAe/f277bdKcf50ZWBriIRvmUv9nVh5m2SotfjbkVVTYBZn4MpegSSNlX5w1Q8b18Pm2FO+d5IYu+DYkwFtaAqps+QC8b7QdLkCq979tPfNN1uBp1hhoVZt0Dp//l3pvoCwLflQKZc7Urot2bzwbc5/OLP675084bZBcBA/6Hxzzf0vgCmd9gRhFcYumU3PyIb7huB4f+swNsRoura1l4+ti/DSYT8ECJrEoH3RwWgwQqvuxdaycAslf4VGhcYZcGps0NYbcsXilX+dNbsRULrfPA2cVDw4c5YQVf2iMsfsS7n6uLRJ9oS6QS09t3m3AWYdGwmZaTJum1GpM0nfJfnuouyCQExsAqTTrw2wy7ycvku5vUxKA6u7/v6Q+f2oX1VQ==;5:O2mZ9sIxjXLhANvF3wmCUk/amCB/giZCWXvzo/AgB0qmogt30EIPkcpDwegK0StdRhcrPJnfkfPdt9n/8uRpGDVHlrA4KScKF2VJ98p91IWIoGf+xpvPavZ4DCbyBkOSCejOVBGRCM+X1ULW1nIkx95GRScY27mpzENjJVs6q7E=;24:VOHRqyi0jLD3OW/IEVpwO2/FOUXUY+N66kevaHKmcBPo92+oBK50M5ag0zXYvO7m9szW/bDU2knQ4YW13wnU2ezbX42Uqc7tdlK91Xa9uRI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:Rc0ubf+rXS1ZE+0l+/1zxlUiUvSibR5QGMIOMubasg4xXKKR/wYxctLTDS8KqqZsPN/mFSZzIBECk2taa0dbT5vMdYPhErQj+eE5/N1S7Wd+0YW0np+Wir54hRPEHOZAlKtL5TkYvjCfZFZuHfgS7eXuFhv30CZxZbMrnvGp+8oeRb/TH64wgoRGJYtrFRCnk/PJF6RLsa2tg86S0IhlZVKKevh6z5toyoXL+uHj9Co1QPS74FXO6tG5iGu9fDBu
X-MS-Office365-Filtering-Correlation-Id: a74bef3a-ec28-476e-5d90-08d5b1c65690
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:55.0140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74bef3a-ec28-476e-5d90-08d5b1c65690
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
index 75b0d3f6e4de..a80eec17b13b 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -83,7 +83,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	 * but we need a bridge attached to our of_node for our user
 	 * to look up.
 	 */
-	lvds_encoder->bridge.of_node = pdev->dev.of_node;
+	lvds_encoder->bridge.odev = &pdev->dev;
 	lvds_encoder->bridge.funcs = &funcs;
 	drm_bridge_add(&lvds_encoder->bridge);
 
-- 
2.11.0
