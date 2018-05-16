Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeEPKVB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:21:01 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:43541
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752101AbeEPKP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 08/26] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:52 +0200
Message-Id: <20180516101510.13215-9-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:ff9dVcndE9j80yhF7bMo1DoXSEoWCse/Zs1k/dEenD8GtM4b98bOAwRgHvjQWLf5Ve4ebMBS9TLlf8htLM4dm7x8BvAYNBUjxkwaYGiwuWNWWLb42d6yim28kPQHbdLGjJwkHKAgIHK7+r0oRiAiZ5gcGsSghGt1eLzp71dv1mlasbbHsQ2lhcanNr3ss119xu74yRYLpSZ+XDAIK0+IPuRtmBEE2yCVZm7YfQvjuwqPAXmDgosvwCc9g6l1atrb;25:7SkPfLo/rV8aXNJgy3OrKghoMd1Q8NFoh6wDfA6fOzugotZ58LaRue45M9RAN9Be13Ikm2kFwFMTSTffiD7WRiXesmbqajPyDohTC40ewUZomWPj62mx3l1znXWZpJGAbtmp8u0heKunb/g2jA/x0kK7cDMqUKV2gO2oXFapSDv4AbifwGc2QLsVaq7kpx8RpWXm4B9gO+6NPn7XLgvWj1xmD/B0/heqdQFpQwl7qz5+AmO30tVuLLJsVC01cVFQa/PTeS5NAf5Aupj18GbJshSA6T+Nl4NzriQyGIAEZVIIqal3wHdFdqaT3D/QHxzfg2n18xsNJJJRYTj46ZO71A==;31:cgIxx0cuebrScdddVMitwDlWYK/JQtZ8zWx+z4SmUact3YFM8eOtGhervt+YlAqNYjvHzDB4EoBp/hKfmNYdyMX0I29/ZrK/P6AENPt6IWioPSmxfoMONORSeVIo7DgzQ5luMgx2SkuafdmParT7FdeOnFFcNxEZw6+I/duHYKfsSGrqk7Adt3JORQ36prMaPci3URMlLWk2Qh3XrL/NcGb1CkUzCHI3RlQ24xjwy18=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772E903ECBD5F2209B28CE1BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:e2XHeRkCiA4FbGjjtu0PMfaEnJDEfHrqXPVNT0LYziICtviHkpsCXlGOxISVCfBBPfwyFOf1pyqWW8CwRV/80P7BlXNgbDJvVfbt5dNe/JwLeddGkF2CfbvGY8apyIrMYbwY6lh1EKfAYodUaFfJrmx+GGo2b9+wof3UDRoOEuXS1ip4bPHkVl+oZGpC93CUw4e9ZScIccdpVe8T+otlKjK1uJ98968MFyU6C9qADYX5SryrEDRbpelIby+s7PNsruPlPNQzM9IHMWdOWtnkDQ==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(7416002)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:lRRxX0XfqLXICUabhEvDY6MNfdE4k6wE9PoqwoV?=
 =?us-ascii?Q?9UJplZDu7PHrD3UZYsVRDbo6ObQQZg7fetC414DLRrzjozAKLRy5NBD+t/FL?=
 =?us-ascii?Q?BKT3JGTisnq62pR0GGJ7R8IEq0NfFBsWa2Nba65Gmv7m33pE5d/tGHz23wX6?=
 =?us-ascii?Q?gYXvxotymX483vYgNBPOqhqawv0Dx3vYLJ3Zpg/ugU4DhSiarIa66bKkMerq?=
 =?us-ascii?Q?9Rzi14U9gBjw+g41N78PiC/ApAhdqJOHWG3nBOBM7Qkj1xjSQE/7hkYR4aBf?=
 =?us-ascii?Q?lWCQ06lM8QaIGvZWz9feXlfsm7v7+Q2krOL6sgS5ezwMeUcqDetzcjtsdVXp?=
 =?us-ascii?Q?QxXBjRl18d6/9rMZOrgSYWqfqTyvpn/2/3j/HpHm7qvie7UUimAf3cTGRMU8?=
 =?us-ascii?Q?xBM4a54GSMrPbqs3HfTpdX4vQXGiMHCl0ja23JfohqgFRDsq5w9i5YEUMZeM?=
 =?us-ascii?Q?o0ryZGFNUdrSCY3QAM8GpeBYi3yRSSvDzgXw4lg7hdck8vNkzbKNm4lVC5CX?=
 =?us-ascii?Q?ZyTmBMHqtkow0jbnnSgR1TlBWRndfoRfpW8OEXUz0i2Tf6OnQJk2DsFXiNY3?=
 =?us-ascii?Q?l0KdLHB0oUfoYSooF4MSUeStxzETDgcXxX3RV5ftcLDQEpAsSHFg9M7jeupS?=
 =?us-ascii?Q?OKIoUw9YCOQcjiB59QodpVrlqjdBUvHoNdZj5Lef4W7OD4SIypP0F+G9bzMU?=
 =?us-ascii?Q?oRZgSH6EOsO3vghrl/HkBGrBw1RTyIKqf+FjPPkX+rxQyz5bV81FruGlcZtb?=
 =?us-ascii?Q?Og8MrZAmzsPpERqDUicUQP4TnG5X8KWWG0GAC0RqnHpHNA82MGEmJOpTDELj?=
 =?us-ascii?Q?CdB05J6EGrzcJG0rFpPTi+908hiuK7czaSDIPqXPPj0f6Xfdxxz1M4I3mLh+?=
 =?us-ascii?Q?MYrQM7sDVQRgkiMj4uhTbbkvTfI2uFR+qbSjCaneTFO8esoh28NvUQTiC8GR?=
 =?us-ascii?Q?cxXmukNV2U8LGRL0xp9wTu4wSXibQzTYEz3jzINtlRsYb3m70QzLRHCI822H?=
 =?us-ascii?Q?gyYoftyoMQqu7UyCKxTbJmR0p82gQHKGmOPaXXZpd/FE0CFoQ7wxjMgEwdI3?=
 =?us-ascii?Q?ckETx7brRcfsjRrnBhAuWn4uvxD9yWqTtdG8cbqVwP2S5Xd0JW59toSe6E5G?=
 =?us-ascii?Q?It272Y04IgKXTDuIrZo8tZHvjRb3+0k0U8fKBvN5lcQVaoeFhI+nvb4rjQUR?=
 =?us-ascii?Q?FstJQW3BZp333T2EDXPbmYQTSrOnv176xdi2GDCNEmhFSoEs3KkyQWf99THJ?=
 =?us-ascii?Q?vK78IIV+/J8oedZo/cvHqRMn+rvzohCFECihIprer3PV8k//PxvHYy9MJPez?=
 =?us-ascii?Q?1vHYBnMduoGRbu70s1dWj9nWcDsXlVqwf/gSdfTnyUzk99jKzqrEXN6Kl6kU?=
 =?us-ascii?Q?RiDZtgw=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZOok82ewQjl2kJsOUuB1RTK6SGuZk5/EYEFbVz8AN8ins18r+QWt0pnfMS+Q84UuifXopbf0JCftWGx+B4SQl0Q6SZZcfMqOEs3uPmdOr2hL6NPZ8iSpFEBeXhfD2rtEMd985y7FtRm0VsyRkhUSjHSUqVxOyAq+0nfMcg/qBtOlrdutdZCyeXKP/D3IbqNp
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:bUB/yhTtC0pxfPCxkvzb/PL3SdZmvnfn3KjG9VadlQTx+3Bngfwum8PJxdMISe9nERKoQc39OBkEZTr5F313jR2OH4iv/xqxVwIdiJIdP8LsXyPKLoYmPVLIlAub4isaHcBqNyt0rIygH5UNOkeH8w/ORi6AE4laWMItRgNe3O3JxYDsyZSk8I+0jBXHRUw0L8OP6ZMiRBtwQzv/Sj2zSAomimJrYr8l23U3sh5okCvFB7sFnELtIynI78k2fjThrugH70sj0RbI7NBAZI+srWa50UICz0P13+qqv9blZ5f+NbWYd5WerJokb/TYvTiQmbzjG1IPiRTwwaYdn3AbC6x7F/FlGWt04oj+Lx6HC0B/VbagXoWhiTgt7By+YCflo+vzwXQSb6Azj9d6yPXJlKcqJ1XtTDccddXG8i1csLqxB1c362/CHb498PD0/OxMWsLhdIqLCur5hWW8RyBv5A==;5:w6FRPMurvRlhfG7I3RaV82k/3nkIKqokGAdSbGDqR62pphR1lM05y7jPjeX6m+bx2e0G1yfp6oxHvtmnmdjq9TziI8PosvJpL66kJ8KXJHGQ9QSVsffM9iUjxafGZuzitJp7SJxzeyY5ucYP7lJAkLw7GuWiC9M6mecfG3lXxRU=;24:DyrfsbX2w+IQOjdM907MhipW4jMylTZTp3wC1vOuVV5w4gXRzzUKu4aYlKpJTDmTYsNAc5z4mmFmYFBBoXyropgE0LR0es4EaFY0/sQxRVU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:lTBpVcRMnpZXy/SD1FVW4mlw15pbeLCeGOr2gKz2S40WPQXxK9EXRETJGVzsbRlnWDd+25f/yEWnpo3aOtTxeEXTRjEmCREuJ1uU1z3it5AQMEl6eICOldhaTZURnlwEQ2zMqn6ipi/GdDpsDvuLbWY/gn7x/zrD8oFEpzErInHPq/kDIMkLfVc6EbLBJsJUC9elLoymDqpxfTiFyfZLcsMk9eKflIW8/6J95Nd09vAhlmMkuCy55AhISrjuiE4b
X-MS-Office365-Filtering-Correlation-Id: d4eef091-6219-4c65-5eea-08d5bb16022c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:53.5664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eef091-6219-4c65-5eea-08d5bb16022c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 7ccadba7c98c..29d1b5ae5fb6 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -313,8 +313,8 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c,
 	i2c_set_clientdata(stdp4028_i2c, ge_b850v3_lvds_ptr);
 
 	/* drm bridge initialization */
+	ge_b850v3_lvds_ptr->bridge.odev = dev;
 	ge_b850v3_lvds_ptr->bridge.funcs = &ge_b850v3_lvds_funcs;
-	ge_b850v3_lvds_ptr->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ge_b850v3_lvds_ptr->bridge);
 
 	/* Clear pending interrupts since power up. */
-- 
2.11.0
