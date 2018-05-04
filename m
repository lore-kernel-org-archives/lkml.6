Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeEDOGF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:06:05 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com ([40.107.2.93]:8057
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750820AbeEDNwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 04/26] drm/bridge: analogix-anx78xx: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:50 +0200
Message-Id: <20180504135212.26977-5-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:R+HJ5hVomdaDNU4WgooCjPZ7wVparFsF2Y2RuxLFaOWTXBNYA5kWVfkTsJn0lNXNEbki0WPRejHAmWw7Bqs6kVxNnhNHW1OIJfeT/YVE/AA3xB4SlhmWRa+yaf7t/0WmjkpkzO4J/atyf0EClg/tvW9hSXjCHs4a6+zBzbzPVW7+UJt3lMVaCNQ1oGghOf5gtJptFBn0N2d9foSa4cTwhiaLc8+fG+HCsaUtYt8aSqThOZXCk3Y8sOzSemzpYuoz;25:wM2mzY7a3P/eps8Wtb3318d4hjaI+YmqOse/QS+YuZHJ7lP6YH5OGZw2/Nwpduzu/B3Le+1b9v701qMH3P99lQIyDWh2ipzIyffV29hfd9J+fs9gJSfSqIZ1aM5ItIPTeKDS9lCUrX6sxEL7dFGh6wM2hfZ6mbHPgL7XOg3jOYVb+Jpi/4qJeQyRz6EPsM0nHz0/xTuIYpbT9oQk7KoxiBsSKAqZB5N6HEsojA/xDr/z6P5aveED49uKTREO1tSfxjSUmgNAWEafBd0ztLX9r8Mya96meHkQrbKCfbh2lfVYarE8cs4RYHOerjJohUlTiV7WShOGfIQWLxdPOBqdFw==;31:TfKSqdP9tAFK0f/sjbcw/Bg/+Hme8eVZGWLgL3EPv0A3GN0yj+BiHWToKyKtJJPpdf7/UQaP9uVj+GBDcmPPxwlu/iDS7xtaqD/ZVGZdklQ7J7VqvQQbffBhDTI3VcgFm7AlU18jyDisKTXQgqH/BsAioO6aS9yKoV5NS8g+XU5kxKDZmMNuszSh8Ojf9NM9o/kqM+GXXSaUC5LRP2SP+4B2IAchtpurvHEJA/qr5EU=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276945A5AFBC07F6E4A1D95ABC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:QkFfbgzM2N8j8Dy8xkbufEtWCZvkEqtyVE6JRaOupy4w9GNZUgDrzjdoMGa8sooDEj7ZMEZE5RK8QDdN2LAcVp0Ihkq93ls3v5CcDN6XSiQB26mOQm4ZoUmrWwS++o/Hc4ylhMEygAo9F2fnTUXEKaqW/pL7SZ3+WXRmi+z3Da31NXNCvho6e5R4mtv+Fd0H/+02n3ov8dZL91BDhUgd2TT0zrqqsjNFG6DKmgRaVJQWVg5T0l3Uk2epi36gLlhOWnw92AVf3WCI6kzmMY6Q0A==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:k2nQ1AHZgHwKwZs8Jfup8s+0ZVNkjirjKYAhdJE?=
 =?us-ascii?Q?3vi45GjXn/OIDMtF68sixS6t8eo3Sru4m03/catnuJy0DVuLjAVmN6x3DzKM?=
 =?us-ascii?Q?jn7N3frcZuzzPkSp3KoxIKFtCUgB6tHfYxQfVz6ItZKsdD1iT2xGtsIMtYgB?=
 =?us-ascii?Q?KXsTEsjuEcYlitubSdY9Cx55gPXz6g2O+gL/vfdM8FqDmDm01wcIQh7TaW/f?=
 =?us-ascii?Q?GP5sFxl+3/KNsnsZgrs7Wo9MF0TaymGAzZyz0sU+izWEJ9lkjVHGDJXnh/4T?=
 =?us-ascii?Q?qrDtPUA4Ubtgb7HyzHe4w0fm5Zsvut2Gluj2Sf/ozgzsDnDG4R6Omt+jJnB7?=
 =?us-ascii?Q?lRjXyGAcQgv4FPaa6fIZ7er5QbhPxVBLJx5NXWs0G1hEm2Uwj11uTwg6yezn?=
 =?us-ascii?Q?8Us7z480XS3lzfYNdbjq+GrEo5gpDV14qDpv5CVTe0ThjRExDb9SHiKCiwON?=
 =?us-ascii?Q?3ecNAwJ+NyaoZCz4L5vofudVHipq5IJJIDwxYXULaEQVrlwixfvZAJl9ot54?=
 =?us-ascii?Q?KRKPaprqlkLmyBoX3h4prveUliu1sFpO0BJ/Tr66WW9pvbOcfEg5WCEGh3mO?=
 =?us-ascii?Q?LClUud9cRDd44VVm1TYXFOz9B1/FGoe9hKKJ+bztu1TJqC1EDJR6ssNnKkuF?=
 =?us-ascii?Q?776KS9HAx9WZgW3EN9zjMPTMYOk9GafHLie3f4FtyHJfKsNm4D6+MmVBOaJV?=
 =?us-ascii?Q?h0RDUUUzTDkpURbE2aaj7TM5JP/jPpcG31KgqVabVAKCUtfN961bqemhwj2l?=
 =?us-ascii?Q?1hYkEdUK7RXcx+HEdOTZZj24sGp8TtCI/zRuTF6jjmAqV0lnLbZluGnGwJb1?=
 =?us-ascii?Q?JAOUx2VhTHfiQ2Wx/UbdQdSyBE8R0JLwnCQEl/wTY9u/vT6vyRZSOBQtU3+q?=
 =?us-ascii?Q?lq1RLcOa5SKRteTICo7sGkqzBMDCgtQSJkV0mz6MKLmfCpCzr1V23gJOfJzF?=
 =?us-ascii?Q?wQ28FlIhb/W1UINQwKgrkUKstd/RVLOhxdtQy4LNbvv184piMwCqffmB3irO?=
 =?us-ascii?Q?yy5n2jpN41alFLI1aXJg7BitMAZNw7mUIo20PeYOArdQWHbSPhTcIXIYm2ym?=
 =?us-ascii?Q?DXK700Ii9mCyh7v6AbSxG/afuH/sXDEItP1n0p3C+YKYPjNmEB11Gf7Py/dj?=
 =?us-ascii?Q?jAwO1fpABoeagJxLn940+lhxExrDGNVbNZZRHYxSwEdCSnR7WJsqqbglr73D?=
 =?us-ascii?Q?E1aWW2IgxIrZJ8Twlh762B3bx1prP38vlVnFXJloI0q8fglZGoGoPIxxlTE6?=
 =?us-ascii?Q?f7TP04h+XPoywzCaCBCHDPPLHNW1RSEOOF8uyvKc1/sYlSCNiOJFCImtKwdS?=
 =?us-ascii?Q?1D7lp5t0wAglCv+Hk1sSuddZTHJWN2Iwi9ge1B8tNSgvyzFCqopUIBs6PyFn?=
 =?us-ascii?Q?zEHuiWA=3D=3D?=
X-Microsoft-Antispam-Message-Info: z076TYNMloBms3LGUyHkLnd8VNqHCjqCL+GqkRzk8Qn5wgs35tPnSOUVUps8fdjRf9SFs+yV8BQixx31qIDcG7EFkEYJ4mwGYmlrw6gAYPrWmi8r1oRhVoHbx0eY9vXKQWQFRoiz4DwT6NbxPjUwitq8NoDfZ3+tIzDv6TmmCuXIn0/Un3LgR8l82XBpUX5X
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:XruOVeRBmI55qzvBiG076KScqJ5lXmln/dN6DeFQV5PNBSMNO5ahM/QrmFASWM9kSkkGLihmU0RUHSAx6btUDKomKQDqY9XpmP3agMuP+EURrA72Y2I8LaL/KIScbFxupSmGlthMdtgXs4W46sVe0G71T+nn1YWNbyloi77eLy2W35+nPHWRsWJEqTNIVip9dGrRCgNtGQg/FYe2LWg0GXwHageDc/05j/roz2tS6KZQXDfLUY1KPXnSJBf4jSY/SKKOLPlZRMzK+dOOnUltQsA6xNpPQ+Z2ZGd1dc7yVx5Bx+kQ4Nn2jB9hvhxdWviJxBY52SfIMF3L3akDHV7OhlQWz/qndA1QEBTMOX2UAu9FlrdHRkeqmdIs0y18zzRzIikx3CbRe2K0ksJAjyvfL2iDWyfu/zhnNg0SqB/FmKTwkitjwu3cYhL6II+LCPlx1gM5qNZeCHLG4CNBHIwxPg==;5:l57eWXgO9Oz/UaK/Y1mwtTfrgkRTLIykwnGXU9PuVP/9WzSeVfWj0rKrq76acVW6hAJCvkiz9a2gRgtPbFFitg6rm/DdcUtb+7fGABa9MeOyJ8+gIIcpT6K+QR3OgfgpvBSRzW5/zPkqo7Y+Anotot6BxABlCzD8iA8NbzcaNtY=;24:aJTYVqBzWd/UrvH7lXtiFSnS9uO5FxIsU8hVvzusTmCF0GEZUxdlIpo3mJ/J6J+mCOjIM5upCN/RX+JAJPKdm3OOBMd9mZ+0qxzyQhUk3WI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:fqPm8sDOPs+Eae9a8ICBSzEI2zPs8bOqvsrc8di75hO8scE64kfisdHytqohozkmhEWfpjBXrg6BRF87sbj+5Uekt/r+H4kwADgb9SlI9uCAq57jbzfTzNVtOe4+42NjdGg/JqVj9uvSxmGt9TEpqbfBwzANX9DPPKp+/bmZu6i68ype8BHsaWUnmmZZoYxpqEIXu9QSvLOOhT+lwjYSopCk3KzUc5dPyLcNHalPHqjTUo5F9lMSEVarqhcSrNqb
X-MS-Office365-Filtering-Correlation-Id: ab3a20ab-302e-4924-c62c-08d5b1c6515b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:46.2837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3a20ab-302e-4924-c62c-08d5b1c6515b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of an #if and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index b49043866be6..1d6620aedbdb 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -1332,10 +1332,6 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 
 	mutex_init(&anx78xx->lock);
 
-#if IS_ENABLED(CONFIG_OF)
-	anx78xx->bridge.of_node = client->dev.of_node;
-#endif
-
 	anx78xx->client = client;
 	i2c_set_clientdata(client, anx78xx);
 
@@ -1433,6 +1429,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 		goto err_poweroff;
 	}
 
+	anx78xx->bridge.odev = &client->dev;
 	anx78xx->bridge.funcs = &anx78xx_bridge_funcs;
 
 	drm_bridge_add(&anx78xx->bridge);
-- 
2.11.0
