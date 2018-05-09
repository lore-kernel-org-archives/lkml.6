Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965912AbeEITrQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:47:16 -0400
Received: from mail-eopbgr50131.outbound.protection.outlook.com ([40.107.5.131]:29696
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965181AbeEITrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:47:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
Subject: [PATCH 2/2] i2c: robotfuzz-osif: drop pointless test
Date: Wed,  9 May 2018 21:46:58 +0200
Message-Id: <20180509194658.29106-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180509194658.29106-1-peda@axentia.se>
References: <20180509194658.29106-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::30) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:MmFTN50bZNFGRBKKF9rUuqLVZjaYf7cqgcAuqI60nXBCjAkhHP8MuWVUIjAaUA6NOx/5jfUNhCFwftmaAInSn0vIhTaEjCbg/ieudGFM7Lz8Zam0lor9MZ119UtMiBpTLNB8DIbhIyRrsrezJsV/t/WK+tnVAeLf0LSvmuZiTgUdUlRF4+ArDErR4ne+ohMs3N7nhnEFVaF6S9NCN74K60WjFrQm4n58oYjTlSbUpaPO2hRk6k1IfuzsIIGOhuhg;25:4TLjngmO1eEZZqhe0AVThV8fQq+Xlr5x5WOLh2SAeMBNryc70kf12Qp2qq9OoG7FeKm0v9Fe+LXTNvLMRYfqlNIkZ9WCvj3crXtI6KiEWQ+GNW+ZKCB9zPhI/WGCGxidZLw7GHKfDPHzg1hx0GD19U9Qu7EDu96DiHw8gGzInclfkz8ySYob6CUTJvmUfxal4vHKH6Jbt8+lhE1+wdj9jMGR6d+V03IeF5dzEz1FkZ4Fb8dKj06XajGIzK+EMdGwOP6mUhpWH2mYZQ75EhBZIXkk9hvV3ElPdeH9BIvCvynkZWm7ykSgfWomt0wrf2yqyGitKBCvWuKc36uw0Fg9+g==;31:OowTjsxnQNUf1Hmyk7VrBJ07VyzRPBXskyMb+M1KM6z10Jks0+y1N1KZlVBVG2SNC6ChtmjnP53AO3npM233PnNxPLgdu6u2D3WJk3qY+S27p0V9neHc6vjXtrXAOCkFddGPgHuDFcmxoHvVPikUZLl8js7q7ZqKmfmy1dSJUTjId/KuKd95zdSpUcmR4zrTR9Wq6kqlbq45ahwNv93nBPle7hWaggehcOOhsGG05YM=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779AC9A41CC4197D0BE37D0BC990@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:1hQ8+OG2/ICq9MFydvqPpU8L44PpDnNZnEcmhdcBHQQnnGEL36emzy83wfK7OX5FE7TAGnv+LWLEQMNmeP/V5hCZ74lVY7LeUCspN9ELMgF5OZAQ2k4+SjPnB+iFZeMg1kuY+lniIyUmWetQHkK6CEg2AaCCZ20sX0nNUaO4ExBD7EtVjuJcTZNtRCeMraFZW5pD1WbHNbA8FVsnZNmzyf7PIV2xp3+jSNg+stbqAvVnXJjRQgm5ubpFzu6jhlAgZ9gCHt6hxWqR4D472IdWtQ==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39840400004)(39380400002)(346002)(189003)(199004)(6116002)(66066001)(1076002)(97736004)(446003)(6666003)(11346002)(6486002)(6916009)(50466002)(48376002)(2906002)(478600001)(3846002)(16526019)(186003)(26005)(25786009)(47776003)(2361001)(86362001)(36756003)(450100002)(74482002)(6506007)(7736002)(52116002)(105586002)(106356001)(305945005)(386003)(76176011)(476003)(316002)(81166006)(486006)(53936002)(81156014)(8936002)(956004)(50226002)(2616005)(2351001)(4326008)(5660300001)(6512007)(51416003)(16586007)(68736007)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:tmTcsVBlEtY/N2yRk9fAtBBYUee8EWJzV4tO0O5?=
 =?us-ascii?Q?80hgkPYHSiJ8L2HelLSgLWRTO3wePrahovlnNiG55iO+MGxspTWy7jAk8OHU?=
 =?us-ascii?Q?j6JXdfHl8Wi+4QE3YKKr1pN2Rp3LSmyWJ/WfREXw2tt5PsUIJHNqUp8+/ed6?=
 =?us-ascii?Q?wE77IjQZvkNOCXCLnV4FdK7GykeJ85gh54H5jrb8pBB7rPCvgh1mwrfn1MmH?=
 =?us-ascii?Q?5o6RSj9oKaCf2d4He5JjTqHe65ur/z/Osm/ITMRasFjduF2tbjIM5ay6JkD3?=
 =?us-ascii?Q?5ZqLXY947nn20HAdVC0Kvv+h6zzx+vvI+7+ZqTKTp1Dl98KnYVbMrI6GBzAx?=
 =?us-ascii?Q?e3TIKYGC8krP9ZrNzxsgXF+Et+wVsA28mzSUXkXOtJJzokz3N5N0mu2VewWu?=
 =?us-ascii?Q?PdsrLwr3RkE4azvydJcGpPj3qs+sgaiAJ9jfwUMuCOiD+qvquMY5/KRbtoQY?=
 =?us-ascii?Q?IAyNoD6RYEZgjtE3licsRuZ1sgrmubpdH/vbOKNHAcDKqMMiw5Q5x+eLhDV4?=
 =?us-ascii?Q?4U7t1QSy1xfrPLhKDuzND9253wuQMck+y5ljYRHJ3wEDc/NqyI9rLt8ZtVQl?=
 =?us-ascii?Q?06dlcDP5uPyNPxrrQvXfIJPXlJc+lhg5oY/iZZIYfz9yyAMu+QoR+bSoszd2?=
 =?us-ascii?Q?sypWXOJEbfJHFN8h0/RU8Mwps6D8McBUlaIXA6cNTdkdVUoPtfzwOhMqNELo?=
 =?us-ascii?Q?pn4MPF9AebmDfElbpodqzjOeA/qeMJGV4rKOBLn0w6jrJcc0LUb+rKw8Wmv3?=
 =?us-ascii?Q?ymkM+CSyPl2zSL4FiiWn58UzXpO/pNHvOKgBBlw0vHtA1sZL73FMVAar+cj5?=
 =?us-ascii?Q?K9kccc9NSRTIsHUtu6jh9uaXVIQNAOtpswxB5riOzI+pCLpT3GuSuFGpwa6K?=
 =?us-ascii?Q?m9YxiwMo3Xv4ApR7T9Lz0uv6JXXIA1aTBNHH062Bn4r6141Bh6laSEEeiEBZ?=
 =?us-ascii?Q?Ivpe2J+LCuYIGDyb9llfvL2feS7hn04QByQyCwqdh24KUMBKW9iJZjWgvep0?=
 =?us-ascii?Q?KkHzPES3YxzN8grrWDX9RowJ746LfTEf1L4WcD6SDgu8o7lOICIIim+3qnmX?=
 =?us-ascii?Q?imrZpLx3syzXjO6FVVyVdTRiq2dKxJTb5XB21oXNaVOgf+T9s/IIgcVWv/AL?=
 =?us-ascii?Q?rHNPeih6UJIoHJ9ZwXIKpiqQ25080gebWojNSwGl9CsYAmZKkO6/A2rETIaq?=
 =?us-ascii?Q?IT/7gFpc2WY/QYYWbQrDqNsqI2MpK4jfr/ELGW/A5ivOmUIflMITG7vlPiIE?=
 =?us-ascii?Q?xMh3TzcQMGHyrPgpdI7Lm6lrzQxxN2onmIf9Y48cvXYdIxkSyWw87+xG+Dtn?=
 =?us-ascii?Q?vZA=3D=3D?=
X-Microsoft-Antispam-Message-Info: L5f4eLzwov/OcMewk4QGzUJXebCqxhMjqkgZ3dZoHwWPc7nFisTCsSBJoj+yBi2LEagaEGkZeVVB7ph+QtgzjXHgRHaBkYhOZyC7qz5ek0a7OHog2cVXXnu9hPAIbFU9LFSfY5GfkBeTuRTmZWEk7YnmdveGsIkoiAwkcumIvjcRNNZOmhYMldnauQJ5EPTQ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:9KFeLfa/T6fCX3LB41WQ7X0wNzR29O//Biogj5Kuhozn0bduV1zaBQLQpSsDouE8hT5CgKwxMWR4yLnDQNEUVO8H1mWOcJDzJzzkLTWfli0gU5u0/5TZKBy3CmFYEFp9Z63FUW4qRl1ZH0Xwx3+PON/hc4ttCS53fAK1T0DAXf89IhGQJdwm5mRRNXFRy4KklcheA0Q5zASk8qWdd8cpPyo5jfg+n4g6BoLjUu1Sl4VlBCptDdErLtYAf9fvCQFbQEJ+kZJv/YyQaIP5f0thAMyuGQ2ZgdxNIo1+a7XUJOyDpobOgWXeoUubIJgEvU0xrR70nirIqXs9INVNXTUHoNaELQonjkkjqqet6penUw9TPqarDS97JisKgGTz4rquF1bWka5YoKXELrdTJYhB4YIjXdceeHMsrAlzv4G9OOQzxqwKgfJjyKHr1Vw1zjHSDiWsxcPNI+ExNEPaeOLnug==;5:9Yh+eOwNPWSDXkSXr1dqhWNSJFOInfSMJ/3Y73znppbWSDVlDZQ1YeXuFqNoX6lsNLldBooCQpMo4kQuZ8kvlVUEH0U+C2Xm89CYzYGdDZqQd9+cEdErYex6AbpqkyskVIhbW6ObgtzhQawMiNj2hhQfloPgbcD43w7tmWGHKa8=;24:LS/0iIz1IbsXVeZRmPzb687WWd2tFwvNHSLiYGEUrgZ4aTDRZMd31WFIWpyefyO9HeRxpmMD4uj5MSVFXZYNMBg2JuWYk84TQwl+efyQ/YU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:YLbHYg27NQB8kMYIXSr66GCFW+okqZmtphYF/QX4ovBCA9AgJGH2aYMQwbneBhogvUmvwOkGOwJ79hJIIDUrDOiUM3VIXekU76LQQV+jd8ZgtVFjZ0IyAb/g9yITppmez4sSSrCw263ZB2exeWnEA87llyn4tNfsOdFacYK7A1vZ4DTpNV4H365LdgTYHlmI1ThwLtkRB1nD/KJjBlQcAIMO+UREm/vg+18DiJQ8j+h0HfNQf0GPt/UO5MB3P61G
X-MS-Office365-Filtering-Correlation-Id: a68ecbca-302c-455c-9966-08d5b5e5a71b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:47:09.7441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a68ecbca-302c-455c-9966-08d5b5e5a71b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the for-loop test, ret will be either 0 or 1. So, the
comparison is pointless. Drop it, and drop the initializer
which is then also pointless.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 51d93b4b00f2..d848cf515234 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -62,10 +62,10 @@ static int osif_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 {
 	struct osif_priv *priv = adapter->algo_data;
 	struct i2c_msg *pmsg;
-	int ret = 0;
+	int ret;
 	int i;
 
-	for (i = 0; ret >= 0 && i < num; i++) {
+	for (i = 0; i < num; i++) {
 		pmsg = &msgs[i];
 
 		if (pmsg->flags & I2C_M_RD) {
-- 
2.11.0
