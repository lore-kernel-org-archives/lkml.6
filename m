Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeEPKQN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:13 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:43541
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752820AbeEPKQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 12/26] drm/bridge: sii902x: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:56 +0200
Message-Id: <20180516101510.13215-13-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:B+DGVi9oGToPOOqkmr/XK8Ytc5DTizqCJ6obi6cb8wzN2zAixGawgLcP4Pnjv14OTRuvBCMbZjH2xEnmgcweCkrFAtYhhesfmCdXJtmiBRFy34qfxSugfTovBZUdK3ZKMWGRlglieQE0591CneC9bqkNOStvnmbOe2ppN8PEskxyDwkcMt98vui5j5yiPREJofRuAtT5yay66q/o/jYhbjbdKSLBP6X7/BfCJMv1lHAu0ERvM26KUG+kMghat9dF;25:7Xc1dH02ln6MLqnIXLChSsOt/pLfsSOAffZ7903yz04vR2TQBcL6T7XGwXmm4bPqp8P5zfc0M2WCh6D4072+h0YoICU+hRtm6i617roY3bziljGka+N6k1hYhwGiUosOFH3ulqgBIhGg0XMHQ6W1omP1MP52f0TlNgWpY2x4QlM+XPIdysFRmprTNmG1woi3yze5DpgKV28CVFeelc25Z/cxpuY4JL1Bw/D39FpNqb7cRBfuHQyjMde0OoN1NLOlmAmyioVMXLBVmc02BgMs+ltUtABp44lmeFMIiYXI7D4sXCfHkclFeRWCUm0+4Mtv0qcWj5IjpH4mlywaYK+7oA==;31:dVzsAamgL6ENBR1cHaOOU72cvf5aCQdjINwArJNXFw4D6Tr5BuzOPxWcasvV8v39bZwngMqSD2eBKQlYoIGZwTZDj0QcuiWe2ZFpXKFOd0lyHD4yaUfOSdku8kjAthtAmcjfL9BBDKYd91dDcqtSvyJVcMRFgocqozd/pfhLrjQ06grTGWw9/eXpOT3X8yMvVLvsKtC+8KF8JvE1wSZVFN+IVbiTdWNLRROV+PZjHNU=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772FD953C9972F6196CE2BEBC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:NnbYIXn7ZZsGvlA3eRaQMzBPk+UVL/FmwW3XYIvxlZpIi6a7Ax6OYc5X3CN1GRWO0IR3Z+4UGZlp1X0eC3VPuc5rF/7YApTUhuT5w7u7X9xa1QiWQtvO2bZqSfLv/Fum2eAK026RUCGkh44M+F5XHdFmnf4yUWuWLL342aRMjtkd1DNXFcF7+5RkIzoOlZ5O0kzRtfh4YkBhcxtl7TL7CjmqOwwyyqHFaUnv6d6gtCeHtp1c7pGk5Sv/dSyYyIUpyoZUsmZzHTup2YRR0qguhg==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:oz0lxRIsRTy6XCgZNT6kxzQOAJvsgJUr6I6wh0P?=
 =?us-ascii?Q?hSJ6xCe4P/9F10J+vpZ7095O4vwttWwNIQpBhY63Q5YJQA4UQ9zsfz2FQbyw?=
 =?us-ascii?Q?2ws2VN1SU4JGtxMM5DViuRCUNuFHPK5/ayg0afJqoS9zC8djfua5few03bSG?=
 =?us-ascii?Q?boZHndKMeffHt+VqfRVKdCpRdiRd43wYenRWW/srSR/y4rD246KftOuV0ESr?=
 =?us-ascii?Q?Eyi7DOs8/cko3FrZ2taWzLrINNXX6mx/XgIVYmrYvTXzFygtsLSo8wcvsdIF?=
 =?us-ascii?Q?Lgj1VDN8BiMGm90nJo7oiN+anaRy5NvNwQRBrEat25SEUoHodT21ZwG1WjVB?=
 =?us-ascii?Q?JKCzkgprZMDevP/kjCLK6THv7ZfGG6JL8zYa+8QqcTr0JXoWBwe/AjXF4Z0Q?=
 =?us-ascii?Q?6vu6zgM5fJdWw4fKhS/ncVG+oQFwBz9fx6PKD4stzd6w0Fk6CpNVQD98t1oj?=
 =?us-ascii?Q?muFXp1tk3sYcND/f1iylLSerNKpbOunAq1gaeT/lYDrY0qPdkQpcZp5vWM1K?=
 =?us-ascii?Q?1Q5yyvGU02kBArAbgFHRunyWONFFZN1DnEk2KYkt2IeDPGxl28xd4yWDNfi+?=
 =?us-ascii?Q?U/U6G1xzit8H+xJEgEDcV/oVkT/llyKHbWUHHTRPZF7OnjFNOBctGt3ZM3gX?=
 =?us-ascii?Q?fg6/SnFp2f9H+tyGPUsUU+iBFpCY6k1kfRJ6n6NTKS9LVP0h2YxfGhpDAOQ5?=
 =?us-ascii?Q?hiK2ESR756GgUVODgYTyOJz7s2Nr1llgtnywvP8pZOXAJUDSZQW+ZyZDmFPf?=
 =?us-ascii?Q?ZL03gLgN5IXydavWW4mu36JWOMiulm5XTwOeAFYIOwnpDvA9q4vjCBYgARP0?=
 =?us-ascii?Q?xjMwqegQDpLwedGWIeiPdCHdq/JubD6Gj+O9grawG77D4VqB41GU8bTv3E3S?=
 =?us-ascii?Q?zY12ZsWQAweXod0NYzt/QVLkGrYixLZzlyXxjLoC9czQAIGiTVMUIMiI7YmP?=
 =?us-ascii?Q?8L4iX2gXgpCZeODeUh65rCG0UxtHGRLUgyo7AlOOTvqB+6k4wGrmsavRPCW2?=
 =?us-ascii?Q?W6vPFsEKN7+ueGFhI4XUyUpYWNQ0JY9JrfE7DsG9Joyvksl6WM2QRuKu3XnI?=
 =?us-ascii?Q?Va0vJxXBCQj6l/PaDP1mT2BI/zmY+N3zUoS4iHsgE6hKoa1h1L9+DLJgaHTY?=
 =?us-ascii?Q?I23TVTigM6AgPVXimVTzNkNqc4Eqg+Lg8h3EVjxTLhouKZwsU31NPQkGWY6m?=
 =?us-ascii?Q?rlkaYtCdtSDLzACvL57aIAc1VZI7FeMbgtqQU5FiwwGDzbGqB8ChjvlZUIcF?=
 =?us-ascii?Q?TdB7omO7VEWuVHRDZckFEkJ/zN/dgGc/hJfgQcEODtv/zFRThfTaaZrMGXte?=
 =?us-ascii?Q?HnqShTBb/87mhbC5Es3ou+qyoI97QuIKWhlqWTdK9xwDnUoLlgIqW0PMQqYB?=
 =?us-ascii?Q?jUeBdbA=3D=3D?=
X-Microsoft-Antispam-Message-Info: yJsEH2+V1Ykdk2xxcXOgpWOZ2sJ2lzdo3a763hKJ/RUa2Gip7US6OLwAQRRESBOl8c2iarZGKG4Q9gEvGDQ9OjjuX4ZDtnKKslK5iWSWgwfTW6XgCPsHRUKrWF4+xOH/iWrwC7kHUcuFmCld/WS/y91x0OPM+/lWtpUSFBZvE1+JkGYa8JqgQbhfd/Fsvy7h
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:3QMKxx7pcK5xf3/VZEjqViD0OGGe92hJmw5sx9aHnwVSynKXTi5YkvAPi+1WwF8FiaCZMDfaMYFCuTp9msCknyPa1bv1LFf8g4i459BSNw27yIX73rSQ7jOgXix6MgjAHWhP85gaezTb4WncF/yacDS+MouOz0duibGrV9TxTMlqkZtTJ17L7K62Ot9mScNN4/mgMDE/x4IC+Gp0GXG3VVEKPh3quwf3MZ04YmMg00mB1PjQCjlQwhmdKcKu4gEy/1oe6YKoCLctLrmTwumz98bjV6OWXwU6vl8pQd4NveveQcdomb/JDFJ5VQXzZymtogD3ZuIqt1r8a/mUzN9mDwN5aE13DZ+1aecX6IG2YOV431IRAw0s/rJZM47v/1DNNHE2PtuXVH8c7CsweTeri3T+l+xhgywMP0Wsgqli/2Y92UsqrW7yrOgbqUo+15tAkVGHnz3NVGXJm7U8Lf2Xhg==;5:XPq81zXA//PFSpsPEli/wqRxgFA5lYNX+h24KO0BW6XbiaCUoHC4Iv7TPMJSW7esEkUuvG6vIw19u1KPusXHdfabZeq+3M5BYOD7TOH/zRTeYF500mV7CQUFUcBKKdVl6XMGqU1QG5swCuuX6M5gq5YEmgQ+rnGmNba88sENlKE=;24:0DdoR4YkyZxWGFtMnB2ZkYJo3IEwo9Pcpbf7votKI6QIU/mHhw5SNgasmZM97jPv23i+ATBZUlnl+VhvSIOVtAwPTCkwcwGXHlIkLrfBaIw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:xdnnHbYQofJyDEfKcVwfrmtVwrWdCD3eiDqOdpEsUTABEyu91xJe5vfBX6+BhhO64vXqztuD1KqZUaOdRX6LG0TnyBB3Iv3PmtzntAvZRkeE8xw1HRhAiGTLNEl9O7uHDb34AAYjAnh0BToXupv34VKUkvI0X3FzLiDNfsKx5HkMmMMrugLXVPFn1Uuj2KlUvw6sCVhBlPCzYq6F6Q2EFEFGqzNrhp/2pCspT7+OHSKzxnpLYhza6t7RSXe0wDji
X-MS-Office365-Filtering-Correlation-Id: c1c7d50f-ae94-4401-f15c-08d5bb160928
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:05.4000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c7d50f-ae94-4401-f15c-08d5bb160928
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 60373d7eb220..894525b05985 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -427,8 +427,8 @@ static int sii902x_probe(struct i2c_client *client,
 			return ret;
 	}
 
+	sii902x->bridge.odev = dev;
 	sii902x->bridge.funcs = &sii902x_bridge_funcs;
-	sii902x->bridge.of_node = dev->of_node;
 	drm_bridge_add(&sii902x->bridge);
 
 	i2c_set_clientdata(client, sii902x);
-- 
2.11.0
