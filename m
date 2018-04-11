Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeDKMm5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:42:57 -0400
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:46080
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752412AbeDKMmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:42:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: tfa9879: switch to using .probe_new
Date: Wed, 11 Apr 2018 14:42:38 +0200
Message-Id: <20180411124238.9385-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180411124238.9385-1-peda@axentia.se>
References: <20180411124238.9385-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:45::41) To VI1PR0202MB2783.eurprd02.prod.outlook.com
 (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:MTV5Catx38PBPEoR1seiSwKOsgR2b2mGV32s8lWevgPMJJ4ZUR0Yx9GIoaEBmVkZUxWUqfZD8OnP7s5pf7qeDCxRENqPW5jffFouONgfikrS32mKg+YFWoxOLZfNaunBZAKQRsIuimqA2nrV4RHqZ4u9M7nKj7w9RkT2YDt/GBccu8HpBze+P4YeKf82BQmIcl8xpQcCwr1ZoRICkbYwGu+CE7No6NrdDw2hfQtq45pSlECR8TBvflbjJSzd6p4l;25:PhFlErJlaOyRAKPwCedrR+Z1xIHfKbPH6qv7z8h6tBb8UFZaqOfJkCaGGQI+NginyvxZXFnbYHuw/AAGU6sOX49RxToDGTFUxA9UX2/ge34885Bzn97U454lWh+wmXTJyCJsVlbAWBPlqZmLuxcGOCZuBneJRnK+VgVggF97ywWT2vKzS3q4obvGfVGs7/fM+gEqPldP+hVswmQ+CsK7UbNYPff12ehIAZzpqkNoEyIMGAPoNLDHahagK52x7WbjmrlThS1trlWSr0vPItXtmUxQYD4WlDxoRLo6uTXcyjmlsnKQTD4GIqCrPXPTkbR2DOspeM36RAElLNgUxRzMYA==;31:QLcSL+xAq++MLywoIrq44KbJvWQij2YCJgtByl2/c9aFDj4GoSZ7E6yBA9Z+e4hDes5G0Yot9WPEq8nEzG6yvquWEnbItqeWsC8bqRQVW6FNlIehlUQ4KyAv11oNcET9asuOafVRUHjbfvd6qKrKbgE6wY/qtXihh/98pbB1JzIW6Itk4ObWKmy1dt9yiMu1d4pNPD0IjZhxK94nXsZy7uQlbb8fO2eBu1D0BSInvqk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27834F420A53585166A469EFBCBD0@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:hJOFlbsBuT8Qs7Cj01+gRpZVdSLvUYWCgUqzJhCv+qBJ7u7BJywWPiv1A8eL6capZGlZMw+AuUO7KPfP6FO7xWcvdqwNomRAlvO/+ofHP0NY2I3vrf+0tVhEVdOQSk7Do/i1Hw8TrqAkXq+ggTiy5xEVfejPtt5ma94un67mHd035UdZJrtHSY0PLTguDm1z7CPDOBYrbaLna3xJ1LRtXivE3r6FCIH94WlXQ8eBVS18d0TyT9K0491ymCE7pWFr75cw3yeen/PpjU+r8vjOuw==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39830400003)(189003)(199004)(6916009)(6666003)(52116002)(54906003)(7736002)(16586007)(81166006)(6512007)(68736007)(478600001)(81156014)(105586002)(1076002)(39060400002)(66066001)(8676002)(47776003)(305945005)(86362001)(50226002)(486006)(76176011)(316002)(53936002)(446003)(51416003)(8936002)(26005)(11346002)(2616005)(6116002)(186003)(3846002)(16526019)(97736004)(48376002)(25786009)(2351001)(956004)(50466002)(476003)(4326008)(2361001)(6506007)(36756003)(2906002)(106356001)(74482002)(386003)(5660300001)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2783;23:S8WzTBZQhn2wR3WONZbVg2zBdNn2izini4ijOyx?=
 =?us-ascii?Q?E8VaPmIFdKt0ZavvAL9AH72VhmRNQus2iS79BuXb6BUrAzW3SeFu05Bhgs/Y?=
 =?us-ascii?Q?VV1eh+By5lRiXKVJ5dBCRRb7/uI5itxSH1qEYuC7hmwDGp27zMI/ZS17YRYP?=
 =?us-ascii?Q?yOmkfyNVcAp5iaLV8c0bzZKvRmk/eJ0hHtKdTouwZTSMNyRMPJJ3CzNjrbH/?=
 =?us-ascii?Q?tKpKdiYt2WJWz1T5CjGOyvioAjd0O06ZUQDIZFtxK2Vjl9z+ZwGEBhdZmanT?=
 =?us-ascii?Q?IxJ2+92UNV3lGZK6GjoGrDkKMRONY/dnzTaOW9XHh15X4Hc6nuFwz7tjp6C/?=
 =?us-ascii?Q?n5pGC0rNr3WHl7p6NuiyzGlzBFRcei8KzjJq1gSN80gNE90zYjoGyID2Z2qj?=
 =?us-ascii?Q?T+v+pTto2vIlW5IImse+XubB6igBUghLcX11fvR5iIbcbTwEDwXZbUB1ja8p?=
 =?us-ascii?Q?67jC/D3AIr5/JzdcZO6EPyH8GEEPxoySqbbFso+rZoAcrHjLkFVpqTX1KE+D?=
 =?us-ascii?Q?7pXiesvair2k7YiXtmdJL4EoPWRlBBvnT/cyi9JtE4dDNS3R1vQ3Wrz6L6hH?=
 =?us-ascii?Q?NXAHnzFV2zlOqWYnE1pWVI0UXuD6AmQn6tHPGWmrZ4BlJXC3Kn2T8DmsFaJr?=
 =?us-ascii?Q?gz8c25vccAr/pqkKEv7VJG112hRGvLXq2nERZqv/rWAHMN2tZFOuEMGjFE9h?=
 =?us-ascii?Q?AhEd/jNa+LVSqqbMzDZyNhlcuNw/XHzLrHqu0xu/Y+XlrKoXAr7izAFSjKn4?=
 =?us-ascii?Q?sbtH1aR5uu80VGXCNIpuxMAjgLfMaQrB8qa5LHrcax5olSitgb6B+zPj9sK4?=
 =?us-ascii?Q?H1Vy7tMG6zGuTJRGUKrBOkhKX4uTbkwQmIljANC54XHPBgpcfjTVvDRhaV3T?=
 =?us-ascii?Q?zg2JLP9bWK1lQdDhzhLGwOv8ZWTmxAuSHxtTA7k11r6cfoyFSv8OvEY90PVR?=
 =?us-ascii?Q?irZtlabWq/fzxYLHaYfEnfv6TmFj5H+UW3s//BHl9JJJvmCqb2vFQ3hGyyHZ?=
 =?us-ascii?Q?MJhWeKamogRwA4m3+TyHauWO+/0nS47smvZMkDVcMalVwE8l8EQcuq/Z0NTS?=
 =?us-ascii?Q?d3b0BQF5hPwgST4drmF7vjdY30krZBvfW6/Q/zs9/tlpavTjyEtJK/w618PF?=
 =?us-ascii?Q?ZTxW8FkzGdwyfXY+Lx4ndXlxmGpPzffbeHH9UuiD1vv3UoCyy58VDvDILW+w?=
 =?us-ascii?Q?eTwn3gY4gLKNJQvmBYZTcBNDOMH7kNWROSA3QjOSLnT2XGci/JfrJPl3ahoX?=
 =?us-ascii?Q?gtmLJVMOGJpxbFqDK9CAOpUj+baQrB/dZc5opSsNE8kGrQ2Q5UxAJ6sVP8oz?=
 =?us-ascii?Q?w3tQ26+4MEznF9yeuhV5ZUA2U1EBXuMX+vUk4glThA4qpl9ghuh3g+QAA+wF?=
 =?us-ascii?Q?JKNV2xw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 36WuNhb3zpceRt9uSAvD4vyjYsXr0HUIsufI+nK1Upm4gjCePmPlOatgNvNPIHE9au1yrEFZy7o34UP6DEiiQ6dJ048Y6TFZdPUq6Q9fX5WZ+tKpVEByai1r7S7WhMIgZHzOqzOWnFX/wLOkMpPD356V0uUacJGsFbAsdQC3quFDn/iTKAegPmzLfEPfmUcJ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:U4KrDPlx9k9tGtC5HAdBCdtqJSQ6Mp0sLBM2iExK/FzXWjtluZwNLZAQ8Rz4mP5AoS3xrRAmsT4PeUxRxlY1Zqsl6KAVPxktU/G/23jjeJxywZUgJ7len/doEhbhP9wImNpcXc2qzX9VLISGxoy3FYzctaL1Ghrgz30sLO8fYCz1mwj6Ad/khjrnoAPTODr7mNNx/ld8/TZxWtrodhNIUwTJhxqDMtuD7Mlb88SDFSSQqzZamqVz+DYsnParySLCW2rD0hokB5Zc6d85JVF6qDgipP3Ux3/f7e1AqGElxix7Ruq8KvWF2AtUWEOMdwY/6EGUxjWHANN/tswUMwxgzIlRDbdV34UKcDKF1U4NwHGXnRj15oH2ltWvHOzojIhgaXCFUT6DsmlBo7MpEh1Oj/7o00XgEUyVKYalY9ylci62o8gJygcpi6du6uS4QP+K9Sz/gGWB1O1+UEaPOHRh9g==;5:USgsyHXNEAy/doawQfYvclMV3qz3Y6bXFrmjYB91EnsieNhy5Gck0nEg3HdEJf6wXf7ndO6zke9tRtKHZB/jwY+9BZVnTsthnhePNqSw8ToK78UcTpNvIQWg0IFCcAKSXuYX5oCgRUOQK1E0YX2Mt+GQZqWhpY3Zi8Sm+lRYXzU=;24:51Oz4lUk+aaCtRaN9CbZZlazSpXI7hHyqSMt63h8O8YD1Rgr4wfKsw8YPRDQ/FNRBcLOMrxc4LQwsMGqoQdCyUoZdo8hdGcXKGOOPW37DC4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:3Xw6VOh0vwkvwHzRk+tVV1BSUva+wGHNpmg0hVzEzEclUabDyHT7rNF3c0O+1oxrO+Jkwd+O1PIkl16UQUFu50p8+48ZTJc1rqKtDTqiOCQjIF9hUCM4lel0VTEj8Dq/gdfVgp7jSzy1BVrMfNhq8MVfesL9di98jGSajmRtcjQzjX0IKmBirSEU2PlVaxJpzfBpf64OU2k44JrpWl8uEa3kE7idmtYoyo0CROPx9W6PdxmzP056iFlQDn279uPf
X-MS-Office365-Filtering-Correlation-Id: 4781b84f-e52e-48a3-39f7-08d59fa9bd59
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 12:42:51.0167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4781b84f-e52e-48a3-39f7-08d59fa9bd59
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index e7ca764b5729..15c769528d6d 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -274,8 +274,7 @@ static struct snd_soc_dai_driver tfa9879_dai = {
 	.ops = &tfa9879_dai_ops,
 };
 
-static int tfa9879_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int tfa9879_i2c_probe(struct i2c_client *i2c)
 {
 	struct tfa9879_priv *tfa9879;
 	int i;
@@ -323,7 +322,7 @@ static struct i2c_driver tfa9879_i2c_driver = {
 		.name = "tfa9879",
 		.of_match_table = tfa9879_of_match,
 	},
-	.probe = tfa9879_i2c_probe,
+	.probe_new = tfa9879_i2c_probe,
 	.remove = tfa9879_i2c_remove,
 	.id_table = tfa9879_i2c_id,
 };
-- 
2.11.0
