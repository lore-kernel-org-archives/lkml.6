Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeEPKPo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:15:44 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:21089
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753036AbeEPKPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 03/26] drm/bridge/analogix: core: specify the owner .odev of the bridge
Date: Wed, 16 May 2018 12:14:47 +0200
Message-Id: <20180516101510.13215-4-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:/406CJdAxT35ZhiBzsheVukxTiQWi9ddand5qOANjMe4OsOKPTnbHCOI/EdJg7ZC7ujpfoeosdVFPT4EmiI3Hc5e3g+gXtW7ZFC8cB+cjTlgd86oqH35wKWWwoRPB2hA+9R5ZXSSSyks2y7lMqu0wJBne2y80qH8/g8VK/wTIZocExedYkzH2sXJUDig4RN1YAC134xBipw36DhvaNY6RLmaRL0N8MZSKrNK9fTLiQvOMWGc3pAN1fQAdqS7bjbf;25:8kgnGmUihNJtJ4IIHc48gZmA1Sda959rz2ScNPps5HXe9+07F4Am1456izNHpvxVYH4aFUrW/f53uH8tfuCNVKcB2jBHbYdr01NcmvE7tr9NzSlOrTqphQIYvLU0narBJDYRNjOJJRS5JTPdsew3m8zX2V5fPFa62fFN0Oz632yJ9u/UqDqy4EaOrGsbTnIUkYMEUlEVUXbllFnKvlWPDgdkSlcQWcEhQxk69enYhCkkiicuuPgHFWIWg8CW+MSV5SFFCoEUEs1+AXE0c7JY2VfP0fhlgANzRvC2kCOi6EK7mLy/Q/q0KIeP/mxiHrj/2MZkk248LBunPqfIaV720g==;31:2CTsFbJHSU3OSXrHAh9WZuYiTj4hpgkrQQmizotuuSRrMt8ZcNap/+XJWJwisIuCJ5bY/dL5fOwBI5hfmrsnnocdNIyRm5ebP7O84F3GkkgigwyZFSE0OjUoJcmuse7oDHxD2X1KaOPH/JIFh4tZ7ESpYRIIQNbgXtFOJSO2W6dn6ZP1tEsp5FZvo6ogBrCMCEnYva+bNT/qdEoxh4Psz1T+513gFObQnjNTxTW9Lo4=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772F5CCC1C4BA419E0B1082BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:ava0NUuI3+6unioIAvBubctCS+lHH76ZhHTuyxHsRMCkNBJ9+zdxaY2aX9a8drG3KdMLuTP4e/EV39yCSwvdxjrPq0vAVC5ELSA6rkwWKnUEVMwgdecobk2WiOUEFN1y8NLHfrDAN98HViVvsGCUXLjgR1913wJS5EPh7lFQqj15pO1R22Z0KMFAazp3/tkw9u/HiqExc4OUdTd9uDK04X2oBBQfvacrVFxzbA6F+ghfm3UB9Z0Hr0L67pok8FDAAabnbwqVSWrsh4orcOxCAw==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39830400003)(396003)(346002)(376002)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:oU577MIStHBDp+bT1voZeEnWhyskGg0IVD+KKQy?=
 =?us-ascii?Q?avchdZLGoC8KhFfvsBLOd5/cC4VHMgiqiKUqAgpFsLkv+mV7/GNyfL0Abj/0?=
 =?us-ascii?Q?e+ZS5FXvG4uT3L+TLayoiKi8JCnJj5FEkEQjXINzPI2y8rYtnAN0Is/MhVhG?=
 =?us-ascii?Q?f4SZQA6O1MbCNuzg4XUqW1XByW/+mWcugU7TgWSwinFRuHFS1fS8aJ3pL8nC?=
 =?us-ascii?Q?I2RYlKgxCW2Pb/OiyfPt6mQ/Wd3QTxgUNqoGuOSonjgS9IvVvFsyhr/fJjI+?=
 =?us-ascii?Q?/61CrWsXb9FI/V0j74NNyUJ8llq0aiyO3t0m48Tj4wIL6787Cr3oRzqoSAqA?=
 =?us-ascii?Q?WcgJKyHia+FR8t4pnSXwZK40KO7fDoN0t2SgFN4xh+gDTRqCicICz3ZNM7Dv?=
 =?us-ascii?Q?FoJIt8EsTeA2NV26z3LOosjX2HbryKm0DKuzo/ofJZMbgRVvxTG2VS4gU/R3?=
 =?us-ascii?Q?wbbK23RYwvBh8VNO+TQ2JR1YYkbaT6Y8uqGDTqDWFosjW5EaY/M6MD+iWpSv?=
 =?us-ascii?Q?7A7z76sYKPksG4mukBNMPEw1Tr/+af805QcldXDMTV0++OgyhpbLDEm2SmEj?=
 =?us-ascii?Q?4sXx/ikOyyTNvdtlk2JRuVlPQtP36XoM44VWBw0zJcyijI4uQoI3DR4r3McM?=
 =?us-ascii?Q?r4YtCCat8AVvnxRKYlqO/QmtrzdkPr6uMSsP6H1/2GS5XQwiD5b6L0m/qvwR?=
 =?us-ascii?Q?ZzSq5QICeP4qjtmZEB4r8OceBBtFFdR9KTLqUeo4UDYbwllixom4C6EHpLtC?=
 =?us-ascii?Q?tYrm7PltiriWC/U1YhYejsSbwJqow8rQYCWdjW/AFti5RNPPe4QLnM1JOOco?=
 =?us-ascii?Q?Dm2VVwgJW7VEcDDvvS+9b2P5qpS6Gx5hd35+x6UfM5SFh/0ul9qWW4yXROyo?=
 =?us-ascii?Q?oOvByWo5lwurGirIV5gLBl9CijridExiWyICT5l1alTKf11jZca7roTnqWgr?=
 =?us-ascii?Q?QTAQfJLBoJaozRcL65RlTAppmCPY2KKS3KCds8Fvr62kdBKqYJqru9AJfM8+?=
 =?us-ascii?Q?HvB2OkeStvImSVbdrKuxaSqRYbvaJSkqa8huP51CXgnr1Q5BAcjF51LnPJ7O?=
 =?us-ascii?Q?nSDtBy9VM82tWfnarLYG7A6QNGo7JWg2MT0sP5ARlethKlVda7lZ/VAgm/b6?=
 =?us-ascii?Q?gUGq+rjBBCFoijYRJH3wzEFGtNqP8/5Y+dJvvRW8LS44Lq8W3afApnckD8uz?=
 =?us-ascii?Q?6IAE7qOjyXWVMPtSkcVHsenZsklFR1/X2xaSgapEFcThN1eSqSMtliYWt4lz?=
 =?us-ascii?Q?bhb3EwJmw4DASZ7+1jgkZ1T29B1nWaT2U0a7uOS+A1sqIEcVjls73ZjKqPhh?=
 =?us-ascii?Q?fMEzLpdiHyjTDslYCd83ESDY=3D?=
X-Microsoft-Antispam-Message-Info: teaGso5EZVC57DzLdQUcUID0wmRJpHSnpY4t+OpZR7DwR56xH54fuU9qd7v+Vmqbgm+fp7UpYfCWjwB8HIJFUE3cv6cjZtBMDI6iOtUMbARPHB22Kc0w/jj+BY8DmUQk9oP2JmnucKjnpDqa6AbRk8ZL+IbCxG+LuP8fEVLjJNuolB2PnWacZBQhUnoPTCNL
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:WW/dxrgqQu6czygEZPVvR3OTCkhtWqTgTAh1XYAkLHqM6B/zgzgL+v9/cvImT2pgHJQlWlURhOPvyd1ybjmRaVz34CJSURgD6QLv7lMgjRHGX0XrKGqxKV169IK059ZuW9eZ/lyEoRoFDzAr+haZYXoxMlFhCyzSjk4bQ85RlZlxWGL1OK2J71+z8xGWQFLJRec6SVzwLQcQOGR383LyT65F2Kz1oquvGPurpfcTB528l5XiIOvS2UqNPd0gwOC9Ezrdv7tnCRw4SS4Eqmva8CfA+ZtTcrdK6QjqPKNPushD2+8R2xjtPw22fRRVX6zozn4FjbqiL5h+bjBOees2wGfMPih26ZRIegLHXmLyn+3N9av9ES9YE81O9ET5Twu1CBin828GPhkpMA4hfUfR1Oz+yhqjAPA+sAa97jI18ST0i82lUcvX/GzNvIYEq3Ivf+tRnjqmpqpSKAeOGtE8tA==;5:5DpkMrcxvQcX24JkOHPPqmvd/n2kn8WxRCoaj5vSekzHcMmdrfGnm3g0CtyDYXFbHuA5j1OhXvqBXOPK5iWXu7GcVgNDB8EPqDpciDCm4wliD7K5NmggdaVXJW3DcM9EZpgUPq0IycSyL5PyjI8xDw2+bBUMzqBEfq3ugh1Ar0Q=;24:tQJtb5injwzJJsvPNg/62ckVm1ckcU4zRf6zFQ5kLbY3LDzqTPxpvHu0NsNHB5pAH6L6B+keErWev30rhEmCkClONVorUkZh43wfQRsDQuA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:OUPX/Q/ZS2d4jsYIcZEaDNlZ57lk10V9VJhu+YcKzu5OJDje4UTQ7l4rk8o6IpLnT/a2HV1EcuMVCm3O7fMLMPi/nlBTRrGjYN2pTTnpdyzSaeP8xmWCCgWIGqk58elNVmG3OiXZwMjFfa0+x51I8T1EVV8JsauilOJSUY26wmL4t3Pgc+rg0IxNfF3r+P+EVpS2ZkBxZir5z/Dt/9b5h40Ajg2wnekZILoZG2Ly6hGHi5czCyBDHiHh5cMAs4kz
X-MS-Office365-Filtering-Correlation-Id: efd72749-4f75-4457-b13e-08d5bb15f815
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:36.7506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd72749-4f75-4457-b13e-08d5bb15f815
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will become mandatory.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 2bcbfadb6ac5..c60f29216213 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1467,6 +1467,7 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
 
 	dp->bridge = bridge;
 
+	bridge->odev = dp->dev;
 	bridge->driver_private = dp;
 	bridge->funcs = &analogix_dp_bridge_funcs;
 
-- 
2.11.0
