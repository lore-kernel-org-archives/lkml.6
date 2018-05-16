Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeEPKQT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:19 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com ([104.47.0.96]:44032
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752820AbeEPKQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 14/26] drm/bridge: sii8620: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:58 +0200
Message-Id: <20180516101510.13215-15-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:7cjq9M31AQ4W3fY99ZjMzpIM6JQ9JUGXZCV4UZjdHW1rgYCeWJD1xQ0N2/VcANNxC9WULCE+9xORJqA7lXUHpM+kS5RLWndis7KsB6Pp9e2XdsGbl8zEY+1DgLhpy6zNEyF8ulaW5DHNVKxUNZIB3+LLBEIlTCiCYyFbQjNA1lcHddnNN8yhFBXzVn+4EqMqNlQGwoOVYZ6uRNdaxlaUW+9eXGUuubQ/zLxs4ZjcOT6+q+OhnzfvZbfqkQ6Lj4Ka;25:MQFGM4cPnsXfLzccFZmsS4dzqyGC78WTacmNk38O0AKAUPokvBDWe7/FybOU9Z7b/UF6Zt6jmvUCmYdwgpfw11LlAs9gkSp6sh8z9jByOdM5bCZNpc14UoegbzRkG2yKvTv5xSkMliZdIxgB6T3aM1irTBTrCkQ/Lf4TzT5LnF/r10cOZJYVFgsRvzGAKFkVD6z804ms7GxcQ+MDpmNVVuh75151wvJ5LAXrS4Xx0AQad20T1gLRDKww9LYo7mP3VSb+YOuEbuStQRS8geP+CcTUMZElv0R7adi3jdqAC8fjGsqQFNO5Z/YcO26aJW+ASykUUjT4gPAix5lwh+aD8g==;31:y065uH9yi6LaMrO8SMMB0AP86QLajR9QcotPjigmCjlgYV+zpbMNn5POKSBF/F9CU36gk+cRn3px+cBo2deP0p2pJqUU4y3b7yKgsioFVEU37mYTK33lbzO3g0jpN9y/RzO/CwBqnYvt+HWINf1Q/UotoLppV1JPQAG5e5n8k6pqQqLRgUhZXSclroJfnY8FsiIujuW6KRB1pYN5tJjC0wyoamKytIEFfbcAJS7xqjM=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772968F9C5E39DF862CBF65BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:JwceP/eb9TyE5vyoyBCWE2R4vP+qUo+vciqag5iSqPFyiXCFOh6YvmffYw7djAwhkN7Sj4kRCWr+O3eZTtqKW9g7Xtf20yxAZU+JtYbxtn+M1CQCpfa5TsiQyLPAFtqIv6EeHU5roPcVu1BiqVxTwErH+8y0yZihtJl/M0+nHAijje9fVPKyj/9oWf2UaUpSyhq9+aSWSBAdUL1KprzRNwoh4hoCh0mko0eF5ROiQc0WQFin/95ExKkjutqRiMr769euVGksAezqsyrD+T1deQ==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:9dTX6RYcvukd0poMuC2d7WV0Oggp77yZeXE6gGG?=
 =?us-ascii?Q?E4Ssq2Pl9NtzIlXZVnGbiEgxUH8EA9oJn00cpgV5JDv8DjOM09nNoS1RIYEC?=
 =?us-ascii?Q?7ylV/vWiJiOIf6QqcpsMm75t9TlrXKkCjOQr1dTVPCo3CEjpIaP0BDYMjVIr?=
 =?us-ascii?Q?899ehK62gE8fcMF7u9DE6ca1tg2y59nk41oriiC7i+mxK14OnUQtlaTUjXY3?=
 =?us-ascii?Q?U2gXM7T+QVP0MGsPWcrXOxWe1fLsP7POX98Sz1FKeqkdt0sPa0bpm1ouOoLD?=
 =?us-ascii?Q?zX/mRiruagWfNDcvqW1Cy83g78qdlY1czBRIN46VpSdwpYuhJCNGbt8/8oHm?=
 =?us-ascii?Q?FN7M+L0et3ftaSSGMUXGvjOA0Y2PvPH2FQX7Vw6RjgWohjmPle9FDh8GpF4h?=
 =?us-ascii?Q?f80ZTrkYutTfwQAFEnd8aCag+xP7dO5Q5rPAIIiy9t8FOW6O2pcdCJ6/phib?=
 =?us-ascii?Q?ZDUMAjpD/leEJhRNMgr0e0iX250JNQJvcB4kxnhbsRHlRUzQTleKCkEc0ITf?=
 =?us-ascii?Q?1q3dq+F+yQ5W1R/mnwkoskmXzFFesv6PEBw3POeOC5fdWjkOWiNDAxA3GTr+?=
 =?us-ascii?Q?x1H+u/yfNSa3sAbcYL+UzdTNQSTu10RvRN7BNhzCblhhf9p6bL5dhaZKW4vw?=
 =?us-ascii?Q?oGK2jXET4lJ2voT6QwRDDi0wjHIhx07z+Y6hF9e+sBUHScnHH63Pfyszn7F9?=
 =?us-ascii?Q?KXZ2IwP8I4yG5rOaE1X1PoJPJU0gkiUg3lGMp77zfrM2dBQHeXUnJZ7gYAjo?=
 =?us-ascii?Q?9Wl1DNNwXwALvzwYKR5u6hUS85k/nGlTII1f6gbSO5oGNVZwY+OE0uwkU2jF?=
 =?us-ascii?Q?u+eQp5K5y4Z/Pw3nod+EVGl+8F7Qcu24SNUWEIwhnFxT8mF7y2ljSuut+a1h?=
 =?us-ascii?Q?0FCxPZYDzBiwfPXBmrSyXJHtvMDh/9usuZGbGA00qS51C+G//PMNJig+vGKl?=
 =?us-ascii?Q?/iC7GCBdnZ1vc1wDXoWiKOqrXjMH1kxKgorBcMuP8scz00klFTc26MAnUn+M?=
 =?us-ascii?Q?WVeufpHvW5qkZ95mrCR9eXs8ZYtmZ7WtOpVynBPrqezO0Rj/Vjclm9BtoN9E?=
 =?us-ascii?Q?TIkFy34UNyIbwNwZwwYcOa+JC25xRRLZn2Wqb6J8as51hfqxuR7ipE/hxgsp?=
 =?us-ascii?Q?pilwY6uN7u8ag2zrGAQQlEqGOms2M2LD5n/2UE8Siisw3cT0Oik26RdgB4SC?=
 =?us-ascii?Q?utEJOYY8IFMADSC0vIYf38OwOTeEYrgSVukAOil1EOT/fe4sG3I7SZP/TMlM?=
 =?us-ascii?Q?IwUgvUejhJgueKP4xGiCxKtd8igx5gWgdeA2T4g/FEXA+3CsZ0j0bEkme0vQ?=
 =?us-ascii?Q?F0h+PhrwL1B8XzKIzHm+DfbbBWIAOKBXgDLWch10TPz4wlnb2Qn4GJWywhKF?=
 =?us-ascii?Q?xDVblRQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: OSt+J0z6du7YN+VOSVPzRb4uruWtIcEvau1a9Ri3ZZ2eMAVSvgisKDbBgKQoDZDACiihoHCzvYLep5s/DhWwyBhfbFly2Yf9tKqCO+ez/u4ceeAr0xVuMpzCAKrSO3WBsUSEOzQMQ4FqYogaUXQV9TuVYY66ik01A5ECYQQJr32ZS71SEu14SZwRvkXkOKeP
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:uCACO3KlRJoN6hwDcpHQmuxTuTlqpiUeutwMcLvdmg7SwmLJFMTu8PPxgfh7/2nisqGntXTRPhvhjp8VsJQ0a7US1wJg+kEdvu4sXf89gqDEdnvdeQ6ZfCO+YwbQzyaa3twfP0heP6s4qcEsYRHW/pSoBad2oW1W4BPhz9taOFVaAELzqxcrFFke0pmWjoK06Y7cg3SbR92i9iquCRQAgLhX5TEOg9JKvSb4QF4xN/78jrm5/8qruKnT+UzPJ3FtTDajvH6AeUA1bEX2a90DmcR3IArzUl5waU4Cu1VtbNDtWJwBZtXNy/O1eRVsbt5PQ+WdDiVZpL4P4aB+Pol1DNbfWUKBP6mSp8Jyw+qrK2MnWdi88KiVa0acUwALg6LrssWsQWf3AQjin80sJtw9JmM7+/QgxO4QAdBlfnzZ+E+LK+JcOuVGIAEl7JXL+sTH1YdonYYtRdsbNKbknqKm9g==;5:SwDco/H0F0XhWvNj043hTFaQtb4OG/nwMiGICXgdBCOCWOlG8RCuKr+bOUSECOFmhPj+WTS9seVcpM65AQigjG6blvPS50GzglQ3Tyw5MH6h45EET0hgzfz1STwiCe36RerdWoRM6WFFJUfgTyZUmn0buxMw1ikkA9UfIr4l1gk=;24:NfaAjHFO+iKJixxVBKlPsz2hm9BhhkLwN0XH+79cZy98wemRVlU/A/rn2wxWLvx1rLQxOlQdcJXNUUat3b7YcHb9LZwaGOlw68x6Ncpgps4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:3pfrwQ9Zesv9qqA29lN/WC16byKMk92zRteuTigex6ogJuQcmXOMHkZS1SsEJVOPZr2Sj+5uZAnog7AMzEw2oqcoFm0icDCVE7D5xJwfE0dDNqmdJm2cF24NF0sxP5/TxiW7cE0c5NNnyI6Cfv3MHxMq9pXITiJe+EzwaCWV9ey+dYYLcAjsFjXL+ZAuZgNhMwXITjulWm1TgjPXS1xcS6GKdMy3TAOWqmIfWM551qNJ8vGEg9ehdfw4SUJJcP9T
X-MS-Office365-Filtering-Correlation-Id: 9d59578c-a1a9-4a5a-fb00-08d5bb160d25
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:12.0885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d59578c-a1a9-4a5a-fb00-08d5bb160d25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 7ab36042a822..8e35578b0488 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2387,8 +2387,8 @@ static int sii8620_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ctx);
 
+	ctx->bridge.odev = dev;
 	ctx->bridge.funcs = &sii8620_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
 	if (!ctx->extcon)
-- 
2.11.0
