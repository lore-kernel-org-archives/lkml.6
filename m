Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757289AbeDZWgK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:36:10 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757151AbeDZWcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/24] drm/bridge: sii902x: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:26 +0200
Message-Id: <20180426223139.16740-12-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:I2R9yCB3/C+lt9Z1w/CNgzTFORU445JhDOs85jvUn04E31WvHb6x7Lb4pm/rSlISl1Z3dSC8xAH0ew9y66KlLjvhic+EjoOaBYYj17kCxGvtPmkKn9GVPhyltCem6gkT93Kd4NW5RQOfctXmZcUmEBEAG7wsAZ/MFHlvsMFpukJXdII+e6XrRR9tp/5LuX2QUD+BthLIQNrV0FCRw6twFBd4gFiiaSh/ThvdKnu0vErqEI4M1cv8nvUQlYqubXpk;25:fs0KcvwiE5JutXIFtZ/FSxkKBOnr2kcncXa5e2GEfuivSDWqFcVGeWayW14R6b+9JBuDp4Ed0geZY7Ss8EcTZYirntkmQYOQwyKek4S89y4tfteOfEaY1NCu5R33eIPn60L2M4OtGYfqU9LF8YtMK3c/gdv9GIleDTB3gHFiqXjBcLs6nlfjxnuAdRJDaETh4ePi/JeDJsNUi/yCrNyQt92PUo0l5yAcWMhG6WuvE6nstSRfW+NBRUMwJ0vwRdm/mKfECBJH8t8okiJZr3ifJA+LVXyHEYG1A4AOIgOmWtdnA3Gw6movGrzP8QaAVZWc7rJ0I7hj6Zwf4sRKjn6NTA==;31:Uk+3iGjIc82tFrCuHP8oZL+xVsAtVuPhnF2bniHxJRzZy/8PfVXE+xiK16Y3oiUSD5Q9aaBdj8WvoZuEKp5q/M3AHtxEy2jTfU87ZVwQCibe14vWk/AxdnSdFLf8xFV94dJrEHMPlj/vz1sUaI08bbYEYqP8bxPTBlC52Sh8Y8CfT/5vsAchHvzGVusuJKOXQESfR24DBRv3RMd3MDuObLxfqhEAjCLIybdxAdfy8P0=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782DD023D5BC8571B1AAE23BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:ascDz/5d2bnLvj6u2bDLELktsR44eGawItXat2OZZNZu8+8BzaBvl9cK0wi0B8qrPmbg+yA9NB7THSlTBEx7WsWTkwD48TPV31lZ1ukbg5hthwSulkFvRRtPhBdCt6icgZ3GITo0vNY3BKjQu0uNIXVOQLtfgERNIfrS3Q51T4x4koLsx+LuJR5YhBlATC7wYa+XEniv+kr2ElR+oIHA0a2QJFI2Jm0Ymit+rP+GxMhprE3TsKPY+M0550b2Rm1Hvw+Xvvi+zH66ETtOdHjedA==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:El7gCCmVym5kqmFhCSNEccDy3uUx4peudUymqXP?=
 =?us-ascii?Q?xUgj8941XmYb0b34c5AW43f4imsDffc8NACz45jsLJc/W0CAKTD5pLcKkY+f?=
 =?us-ascii?Q?DoKvXZabD7bqovlXL4l2fRw76IWdBlpnvhp4zc/Ykuc6ivE6fYPGHIQRAbIV?=
 =?us-ascii?Q?uGOIS9/BmBOokFaVyx9IbUZilLFvwJaWI6kKvOXvX7uK8uGdjcauVBhUUgnO?=
 =?us-ascii?Q?WkOIKRZGMusyB3/G+lWGypvJDoTgjtz84sgjkE4tK+a5wsDq11cpnG5wACgN?=
 =?us-ascii?Q?hQfW5u85MkZfNV7R4XHcJN80P1ySdqKzMBOxBt9etGdQbtKc50P1/FDSzIyJ?=
 =?us-ascii?Q?iHywQdcLKwNzoWObKf37dyNIeudtOP9A7IafF1dpMbiq5qmARmozoK+J0faU?=
 =?us-ascii?Q?DgB+VqHkiEJlgMz1Q/f1vM930CCRRUfRcv7OIbGzv+lX34zXoGqWHWhKGpJp?=
 =?us-ascii?Q?gZiL+wrFTIb2k6B9Ed1ryMOH97wSYousbPfNNVYjpG7IczyBUYxw69VBk2BB?=
 =?us-ascii?Q?ELnFkSXNhaD7vvQDHQ3CB0h5/9iXbMEt5gUcD4icGcnRNphAGq/B0ucJbU9G?=
 =?us-ascii?Q?1IBZJKCIsdJ3gTbghO8q8nWOXlJ+XoMFlsRPnvfJG1Yz8jw/FIGEmU8bLcjM?=
 =?us-ascii?Q?6ifE0tR0awipUE52flLGycwvcZ998baCB8+J1qmNDZYl/GMsDBijOZriVkiB?=
 =?us-ascii?Q?tchOKopMCWkAOZ9vVJrPJwz2DF2p9VL8jYhmxsANrKvcUYyNHHsZLQmJJA3p?=
 =?us-ascii?Q?Zk7h20rpb5QsXUi7LL6eaG6pzpZkibk3apHAZqkdgp0OWJoCYg8T4XG56E9g?=
 =?us-ascii?Q?8cndIjXl0uW5RZ1bWTprbHjwroBtEmTIMWBlFHjmhOeUTmc9eaBxjXOee+vC?=
 =?us-ascii?Q?EzGwvtp0iAJ1izHaiONT7Ob5kF/6cFSGhaZNpa+imTZw3K1emR6DIM4+wlHT?=
 =?us-ascii?Q?IQkccTMeFUzE54rSDk6oGmWxRrs0atWFoY6KnNoFSWzKLIQsXavdh9qKGozc?=
 =?us-ascii?Q?tVYo7DLuFxDHlyAQVY5GIevDE84zUmaUoCcJ+ealClOFslDxxjLId4udCyDw?=
 =?us-ascii?Q?jCYeCM8adsahiyCVRTs9o5jM3kQu6e5mWvOIzCqpAav7KgLo5I5d5moEN9Rk?=
 =?us-ascii?Q?Gu5si0AbEjd8fiiWl1U0gW/wbhTV75QxBd6FV7KHVAhCQhScNyXq5NEbD1Bp?=
 =?us-ascii?Q?GwTj/NpWc/8fx/LHad4fNAv93d3pbedBR01UFSgTXp8LOz661nKoxXNM7vE6?=
 =?us-ascii?Q?RXygNs9uGkFYUiryEDplU7aC2QDOBsXzsjbVqqE+sj7nA0DHgD+7NmGmQHvG?=
 =?us-ascii?Q?WysFz7Ws6KFfltRcksWdGpCwVmmLmwGiR7fdiUcsw3Z9Op0lUcMYsTJakKN8?=
 =?us-ascii?Q?F7MKtsg=3D=3D?=
X-Microsoft-Antispam-Message-Info: zJ06bkhO7yMxKllUpaefXiscVHcbK44hPueQa5skQkUeHw6U7BeVppBAj075LC93gtCjPxTnECBNohI/b31SxjaZdbbsiIOwHsEZgeECY80kSiLWHZtT8Bh/IIz+bFIagPhwP7CWyA2/lUg5Qg9cR9o/C3dw4nw1Komqj7ct2lhQCM1w/dw0O7EJ4u5hONEs
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:upM5qYGg4zAOMN3MpgnarqbOt64X4sTdtJ9FQI290yra8J6Q8+wX4BPpHfecDjyjF/JFkCw7l2xmes89iB7zm/8OLVOHuOYp2sHmwz2cqBZJyh5xMTiqDxTovkX+8Y/InF5WmaONl7aI/QFlQcXG05i2BN73ufb+LlOwnctT89NsF8biiPtsNNdO9vhyquTfmpGdbFWWGBKaw2mz3JLk9c+LfFU+q1Twc52HEetzv/DOxm7caolXmrRsoY1CSLiasnyASMX7MiVdhLC6OtWIGKLW48PIjcigDuuPheFCt/IGdLXCwmjsJxl6DyOMz6kuRrMJLchxhwW+wtGqbp9/A0qBBGc1y5x0h6EBe7m1nzxPXPSf0LDQZV8gurlcx9CksAK2sdn+IsfzZljr2zUUgTaU+dhOoqVaIMCNE/NlX2pCN6pU9HybgfOC7mGmrU0DBvjrogX7vLbV8CEereQEeA==;5:0JcZeEkrb1pVUpf6hj73oJ/N/gmT3eAQyApdl61TgZf8nbdzbbQ5XzBFEP5CL/UO/1ohLXA27v/5EZqIYBsj8Jc9tRMFqu0KyzlQ9FMC+aU6AA5Mz2xHWTQ75wfckdU4FvFvOXSkgbLr/FDd52KX7gbj718aU+J/4k1pf0uXeZA=;24:EZk/rXywhgnjQbmR0G/+jsXHOtvsw+u50vPuEcflME8hbjOsTTRtEMthyC0o5QQzX1teidjBn4NdKoDiTizs2PHLPLhM5KmD67oXDLYvjuc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:kcbxLFo0OOlm9n7KB5c8CEiWvLEd68hZ278OLrFiQn+CY3KNMWE7b+fv9snxPIRgFWJqHDhfgCML3cBNcan4k6X/Nk0Y+4svAqRzQ3WaU0LylEXfxLdH4RcHco/9T/SPNI7vaAdHl0SVyEEbbpATF9SGD7GPW5iWg9xFBXFft4EqK6AtdH1b1WMcpl0inK67HR3bn4+vRvdz1pdU+yEqic0agk2Gzl2+uSXNm/IgxGcFBIAwEGQ/hxBjKrNLCQGx
X-MS-Office365-Filtering-Correlation-Id: 6046b02c-76ba-4c1a-bed8-08d5abc59b6c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:34.0420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6046b02c-76ba-4c1a-bed8-08d5abc59b6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 60373d7eb220..0127090f38b3 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -427,8 +427,8 @@ static int sii902x_probe(struct i2c_client *client,
 			return ret;
 	}
 
+	sii902x->bridge.owner = dev;
 	sii902x->bridge.funcs = &sii902x_bridge_funcs;
-	sii902x->bridge.of_node = dev->of_node;
 	drm_bridge_add(&sii902x->bridge);
 
 	i2c_set_clientdata(client, sii902x);
-- 
2.11.0
