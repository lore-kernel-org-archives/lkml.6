Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeDKMmx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:42:53 -0400
Received: from mail-eopbgr50130.outbound.protection.outlook.com ([40.107.5.130]:15123
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752412AbeDKMmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:42:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: max9860: switch to using .probe_new
Date: Wed, 11 Apr 2018 14:42:37 +0200
Message-Id: <20180411124238.9385-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:45::41) To VI1PR0202MB2783.eurprd02.prod.outlook.com
 (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:jh/vfJyW/6PgWfekgf8cWmtlr/gawHlkrRC2J7GjIKlGaDDNsIUWKgE8H23gyzJ6de90YADujWs1+gSE0jL5hBbPs81NPi3JGijMZu5TgHdVeEZa6fyzIaXcOa7sZu+/Q802zgNSekEjYUmxsv7Z4TpuqQG230Lul9Ls+ZtVI3vJVM1Y8waf39TzFKaiPupGva6nDDMmZsDqUIcwnpMgdLATKgkQbqfR1/JkxKq2gi2oyzhjRbRbsyPuvVwTZ6oT;25:iFZkcKndkrCYweEmYePviMxjz880ECIQF1AsheV/JWOyBAZEZfArhw1Qc4aWf+IlZxeyu3PIQEiKDn6D6Ky6J0izqnxdQCywi6nANUwXe8vo53EW3yrKf4X5lag8cNvyftDI02jsek81PbXzHclFTHEMOdNUJoAytjdtzF+SH7s5r3z8H2MPObdWs70cSzcgngAx5zqgVYGBx05RDdbtN3EbZcdzdAx8D9M8T6h6RVtIk51gjuyR8GtB2Seennv5KTcpv2d+YPM1lI4KAcRkVC0Mtwrpi2W/4yX9IzEnbtTDA75cUqVQMQAMnIb6fJex/oXLridyEpokvdMLwcKTrw==;31:jBLqMMVX4dt+ZIFK6wKju5R1aJGbTLcmCPyJ1Spj3K3xTxC7QbE4yDxf0OPhe1sPTXAavtDWg1ncbelmUREuXIx1hUw//9e3L2zFpKaqjXlz7k9SOojbqGa9wDFcdLVjXrsmln/HDIt+OexKIZW14LgaqUQN2NZVnJmfGFljrda3c9zQ9nD2/m3gz3ivMtEiZwWY38RWQfvwnHdcEsVThRb3RoMpp0vPTzhOa9iT4Co=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27833845BEEA89FD6638C4ECBCBD0@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:oxUKdY9hQNFY9v9Kw/WAf/D7j5KAfgHuLsfMJ/+rsA+kssxKz+hAIdez7keRgUcy8s2YREMkSk6Yq+h9FFZ1jA//5xezQzSkSaYIj/cwpwHScTMVqhStpVSrkfCytMGTwCdrxIgfJ2dnlHnTBg0zRAX4O+lyTXR2Tt2Glva8c1+qaFSipoo+Wf1+nqhRqlLYvl2IZP8mitrSXLRKymAhXqgGiyjpzhPDo3ccL6HrjidvUL+w5zetA2gAtrXrHt0xYuXeHDWzMovGGTgiO/lsdA==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39830400003)(189003)(199004)(6916009)(6666003)(52116002)(54906003)(7736002)(16586007)(81166006)(6512007)(68736007)(478600001)(81156014)(105586002)(1076002)(39060400002)(66066001)(8676002)(47776003)(305945005)(59450400001)(86362001)(50226002)(486006)(316002)(53936002)(51416003)(8936002)(26005)(2616005)(6116002)(186003)(3846002)(16526019)(97736004)(48376002)(25786009)(2351001)(956004)(50466002)(476003)(4326008)(2361001)(6506007)(36756003)(2906002)(106356001)(74482002)(386003)(5660300001)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2783;23:XbUIlFo70wIEd2t2LTv5+v1kDz2neCG9bbmbQQ0?=
 =?us-ascii?Q?TaotMIPJsrAhgTkKIwySRhfjL47FMxPc4hlvmdI33CHatxV5EwVh35HIAG1y?=
 =?us-ascii?Q?g8SpDLSxixBWQuDXW2k3JxNVmi4fyFAu4uAJas20gDbGo66HZzLU61tO4F6Q?=
 =?us-ascii?Q?OOuHwUQ8bb+qUpdE9i6eQwUrNwHtuHqhbrtdcnNjCljpXKiPlscqB2s9AfbF?=
 =?us-ascii?Q?igLVYHR1bKC1CzXsUllZP5kQ/c9CMNY15lPgCqJqObqSgKbIv4q9v3GogJOH?=
 =?us-ascii?Q?zeS9gQI+HfcZBb9YTmDlX07LbKc/xP3tD9RWmq6jeBDAHUyL8HAhsefgbD0/?=
 =?us-ascii?Q?UIkSb1FIPwiQamvgLQsOAnSic6rIHLqw9Y305OaGyIX3e6tQ1pY2DBgawhaG?=
 =?us-ascii?Q?xmd1Bve4j6IV8hKtIsG02osdvVub4ebrwhHzf0DSnmGulxzka+pxmjqZVhgS?=
 =?us-ascii?Q?ql0UukMLGiCc26Wf4KeXrBGC6HZF8HDBYV4ubtsz7JhnCBTMrLpTyAXYrTQo?=
 =?us-ascii?Q?sqZNC5QP74rtEPLZ4ejMFWXrlgncg+eN5emExfBqdpWx4R0WY9lDB8Rl5Zrx?=
 =?us-ascii?Q?9mCe6dPKMusgv+0YScIIOZeHhxv53Zd46viX9d/YUYNpJ56ItFNxd7EFLK8k?=
 =?us-ascii?Q?5gWrYVvQNdwO7TZFSNkLyLlah/fryeO9SXZgTagU3j1Sq8FUhykNp996o3kv?=
 =?us-ascii?Q?GbVi+J6SkGStSN7mivOAKYDlDCrMeZLjVz4JQSXP9kTkqpzD91lz6bgPLBbq?=
 =?us-ascii?Q?KXpAMfwvMBh+CHzlZOfvhmFFiHF98662r5wlFWpNCl87sQ5pKm2b3H4nWMWY?=
 =?us-ascii?Q?DX3bfWp4bJht7s9d0m1Wj6ak8ztm81q9/43v1WapeOm22NHDfU3o/ACz7bYX?=
 =?us-ascii?Q?46v1941CTk5sYo2ACw0qD2PfmPegNb00gBjvt4VMyxw+8zuOb7YdKe3Iw+2w?=
 =?us-ascii?Q?Ux87MrNb/YnYs6/ARMHvn0/QESb55BIpkOCS2DDw8azLOImhEm33bzCl11s+?=
 =?us-ascii?Q?75D5x/iCUs+ZOpv2YbEJ20clf9DQ2uiVgYP2O2gMqo7Hz9TbJBCP5im+C6uc?=
 =?us-ascii?Q?+9aBs5TOlw6R7Y2VwgCqEk5mVQsCHB/JETJ7R1csDtLEuQFOy5XZ/H+GQU35?=
 =?us-ascii?Q?p9DCm1u3Ac9Y2i7ZMKmYQkDC5isZUMdlqsE8sNun21y9wLZ2D7n2/L1PaAI8?=
 =?us-ascii?Q?Ks3OU34xtyCqyjRiIFuX7jXtVkiJiJ0d0qRH1IaHfNT/dd5KwSZC5MrB0mDT?=
 =?us-ascii?Q?WTa3P8UizIeWSJ+aEEyKJM1s+2seaDPC+tM/5RLiFWqePiAcEEn3LOHV5GLH?=
 =?us-ascii?Q?b3K0N8Fn8SsrJRp/2IgUPWpU=3D?=
X-Microsoft-Antispam-Message-Info: /ttiBABa6S22dsV6v+zZGJH0eB7t5hfplWlwSQQ/XTMqZwrupVuOBAseZmHbOtmxKcJmJMTXNA28cec6V7LDPSGcd5Lo/lUE/f2EyzGjoNbGR6wS2BVudeLAQ83B6+F0i7LQcypQCe7AKUgfOmNGwpi9BEp0omtiN9Xekpvp0JTJQtt/IAvBWXpSiozxj3PE
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:OXmqegsAOIMGrMvVj7ECdGzVGwdYfnNn5SFQCLbvguQW/fdMgGh1IQew/HNxlPKit52c6ckPwxNMec3163HykmKIoMOrxZFjDhHN1xddpIULQcdnW4+F9hV14cn24YtBZTrAWT5ebTXLh3B8nKdSzrn0i2cHwAcYu2sah7tG/+bcMpApz0mKAO+i8KYjBK1FGHjydPRkHMitA0l2NdjLZvt/cR1Bh0ViCIf7ZZBfOaUlAN+WKWVyKDp7rf/WImWgxT6wt9e6a+4j4HmsU3sFrTtfnMPIvVxW7fL5jY+opK8aiBbT3WKC1EXxs9Ytf7abT2ckvr5FEQtgQhpdiUcAjyw8WP7KwcZzXdrz99jJwqOJWagnnQ8URtOsOGg3k2pUVhaShn9ozWkYpsR8rEaRWQAxmb2oEpZwh09XgYWKTUvdINVsWMQOZLcyZo9yZUnP7qiN5lud33ZZH7Kga74aCQ==;5:EG506qg742S4yz9fnd5BAqv6jc31Iv281frRJxt5fP/Om2pkem87vIVzEz27ThIEACIDL0vVPrJIIWpXHO/+odtkK1y5Gomoo+veVA6W8T7OC4stADclTYl8xnluAUXFJvtObhROliMqwAD8on9M5750Kl51AugCAi/BstjZt5Q=;24:30WXWl1J2LdBNQEftPHV4yiwN0mMtUbRelmwQu29THWkrQWo/cgGOOz55+u/DpFvOUrh+7bjG/DQw5ezwQC9fLQw1t2AiTW2oHsClHGAOcs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:UlZoV/A/Mh4uFxK3E+felkt4wlKsuY8G7t9gR4D8JPhWjQYZf5D0sUWzo0SEIx1EUOLrvtGn181PjDEV+LrujElQZ3diFf2AQJUsyVXyeNCO8BdRRSdF2FnoG7sJqPkps9pPoH8IuSxVmy9aimAkbYLqqFAMbA3HEV+9zU+FKfS/HTz7BfeAjtyza6pf2Gypk9VV87Irfb3Fag26ihsKyc6RecwB80gVdY5v2GLccXm51Qft8JD1bdVyY4lyqEXb
X-MS-Office365-Filtering-Correlation-Id: 29923497-529e-4ce7-79d1-08d59fa9bb32
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 12:42:47.4073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29923497-529e-4ce7-79d1-08d59fa9bb32
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index a2dc6a47f466..376bd48e4790 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -599,8 +599,7 @@ static const struct dev_pm_ops max9860_pm_ops = {
 	SET_RUNTIME_PM_OPS(max9860_suspend, max9860_resume, NULL)
 };
 
-static int max9860_probe(struct i2c_client *i2c,
-			 const struct i2c_device_id *id)
+static int max9860_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct max9860_priv *max9860;
@@ -738,7 +737,7 @@ static const struct of_device_id max9860_of_match[] = {
 MODULE_DEVICE_TABLE(of, max9860_of_match);
 
 static struct i2c_driver max9860_i2c_driver = {
-	.probe	        = max9860_probe,
+	.probe_new      = max9860_probe,
 	.remove         = max9860_remove,
 	.id_table       = max9860_i2c_id,
 	.driver         = {
-- 
2.11.0
