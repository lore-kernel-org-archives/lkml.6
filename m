Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeEPKQ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:26 -0400
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:1443
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752820AbeEPKQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 16/26] drm/bridge: tc358767: provide an owner .odev device
Date: Wed, 16 May 2018 12:15:00 +0200
Message-Id: <20180516101510.13215-17-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:BWpJobfHmtcD0roeD13+YTTewCR72Yf5tQJ8jiXf5l53xCX+GDsRaN/Jn8CqZgnEDFkg2A5HWx+aJfD051IN4g48NpgDiBbCV1qaENfDnWkxhSs90NG0baekmXdiyG94Z9iZP3qJnQIMSM8X7D5PJlTnGhyPbzH6hDFJjowNM8GtaQGrhIZNnmu5ZaMCLN6a1FjEZZDOYkEj6r1dpu2COMMTR7E+fETKilxYosPWd2qGy6JLkcOg2FKwmuNxqID8;25:Vb+ZS9zb/NicUR+s4x2WWqKn5sbzlCURCcXojkMa4duS1u8iGxpliTX41gsTz5oPqXxfMrS/+BBSJyrMaKphjNOF0WwzEDqB4Gmf9n6zivpI9Tz7bj8Rv/AZX4Z3xFqW05IoVp1xynjA9bdm3KOFW1oKAHaJhA6cm+3kD7BTU3GfwYCaySxcV7YUcdpb7wXQ1u/rO36WOjo5gMDJA5OjR1Qt4cevK7mhnXJour5Wstp3fKZBaNEJRzmL/llMhnNIH2YTOxwpxC/ccMtwXptWX2QtWOOGVxYHLUmefiRm0EqvJN9bD8VW57zA+x5LGqfRjyKzebsFr/Per1bOaAu1SA==;31:2ecbAW86G5zn/4323lzeYVKtsdNOTT/laS7Ykd8XYCfY3RCLFn69j1bdPb063Wcgd4rDrD1Y2ICFgt1TBtUdDIA1M/dg6E60vX9diOASFZjeD33dpxK+s6TThxqjOVf9wD7HWGGc5cC7Nfe7Pgvd5icUq/asX9vp3HlnpJX7yJUSweh+/0EIhrMPX9N10vklsEl4yuJZ4H5jmV+pWdzW/wsMOTzPQln2IYnnJVweLTU=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277298E693C960CE309BCEA8BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:/6WpURLZVc4BJQatlQ6hhoN/Tx0ZYeGSpfITMgXfA9bilcHMHjGcH7SwQpMUjMBf25qfBQLtfDYqxp8bEp0Tr+VlPkE08tWhd0isg+4GbuSUEXdpBN8PQB2GAq3pH5+vSkXpsqor6cpr9VeWyPOGc0xxDIbzRwdFsNW4n/IrhjMCxp2hGKSYDTeVK4m1evn/SMKCiOx9HeuRfsfg/IJ8efQ/G/lxYmYreFITwmLUD9D3/MGy3aPMorEDGGdRLZlPXx5rat4+jk+muD4Gllro7w==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(575784001)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:tKO5P+OBfPaKXlsep35t53FlyxW96Bq/3QytYiv?=
 =?us-ascii?Q?LEQHzsKEotC3Gwn+21J5s4P8KXVFt+DguKcYZZfqjOLnEAPJKzr5tXl40xEq?=
 =?us-ascii?Q?6cYuX2EdRxKL4CcEk4zioyuwK7pB/Vh4FdTt6dou1rsPhC4hDXUETECEW+dn?=
 =?us-ascii?Q?pft7ufgdOLmLe2wMehf32S+YHBKpk2mRGP24xp1op6h6jVCPqt3Kg4R3ir/p?=
 =?us-ascii?Q?AnmjrXWu1fSCl2LNi12TecG8BMPI/M6i2bAHHi/0svEEb0mQ3OF2qLtKczJl?=
 =?us-ascii?Q?qkDJw3aVBpKl2RX/gO8/dCVtj6IYrKJrgglywEfhlzaehqk4tJxefHRIHBhb?=
 =?us-ascii?Q?FaotuC+o7DOYJWEOjXYIKqgAXVt5oCc+CKUS2uwxVLiwsDJruYQdQ4cm8kQT?=
 =?us-ascii?Q?ymXPNb54yT8y2Svw1hOeUb2+tu3lJwQ0FSAPxY9yhUuRwECazLqlNS1MmAKm?=
 =?us-ascii?Q?Z3SF7c6foUNhAzE0kl0oqwjNVLw9K1ma0KLSzEfBj3mULJO5oU7itB/0PPm5?=
 =?us-ascii?Q?Cwn5Xgaxkk72bsSvFaNkA1aia6mwp6BCBhk7eQXqTzL3qF0C1UFTGx3mCgH3?=
 =?us-ascii?Q?wdTUlF16VrgdKW0qb0YvDCe1ResTJxxWi/t695lN/2D4SGYaWYtKI7bIfGXT?=
 =?us-ascii?Q?Og6H7BXL4OIJ/b8+BEqZmAqH4xaOyMKbu0RO/fa3WbvU8WRTs7bjF0IZYqgJ?=
 =?us-ascii?Q?SIrU96l2MvvdfuKnq/orQiDjF2z74vlfseR/ku1BRjpssMDuStXWygzIGv3H?=
 =?us-ascii?Q?Z0nXnH1r7nwTzm7Gz7piyoHzUHuxYbB/W223UtthEb3wO9iAvcvHVVmWirEE?=
 =?us-ascii?Q?swckq7vQaa0nzCzztONawZjkaRnk/rQqevPjyFFH+w9v/rMP53JPcavCRgtG?=
 =?us-ascii?Q?tGprD5vSlmUvvhZB5ehBps2tcb63voS/7fd3xgmvQXJiASbSx5KTtJjniVbM?=
 =?us-ascii?Q?v0p+rNe77FL7FI4AsdeEQ6cJbWE3SkTg1JtBY5PHJ5ZWNENnf3zRdZnRb3fu?=
 =?us-ascii?Q?Bam5cYIHTheJt67bbi0C2LUjNNAMnhOfJEs+xmg0qKDpVNS9QjvXxGaxSxaa?=
 =?us-ascii?Q?5v3oZnUcLJ5IjOIIkPmb3wBxnK+TGycU8UZdriyIuJ/HOq+HDYO1qRpr4pSt?=
 =?us-ascii?Q?uncxJ/RjEz+J/TqZ9WEG9gaBUAJjg78Aba4cKyXOsGZZKum+ijgqJg7VZw+k?=
 =?us-ascii?Q?Mz3/OOXWvaqd5GA5WMcBLTY3opytUPv9WWRfD0ebJtQZ/8xJAmhumyoZMRKr?=
 =?us-ascii?Q?BW/3QWlqH3UenG5rzoKvANLBuiig0JOqApClmM8MsepKOPLqHyonAw5ClJat?=
 =?us-ascii?Q?ZPb0qg708B/n9R4nNS9g5DrACCFrOx35AjzWnxbHUHgFdtzyLysvxkcxgd/K?=
 =?us-ascii?Q?cFCpFEMlcJDKZo6e6yemzvri7Mc8=3D?=
X-Microsoft-Antispam-Message-Info: zroaOKy/QMSPDD/4zNXCvIaCyk/oYDD452kAfPGQXRR220QCEB6qzi81EjM/i170LeS9FmFpQc7BdsrxsbicGjNG4YX2881HH8DNFc6zMFgRjrBOMUa/iqXhzUetdqy2WTilNa7w7t4GPrGgn8UXXFTGAzVOMNUkAAezIvmqnLhqtE4YIqBUcXEsn7hNCpOF
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:V7N/et+vKXu87b/t/36FDDzJB0CDYQ848GfQ6kBC9+mwkRBK0wiBxc9HCtM5M6yb1VBC/nNvw49J86aMCctzhmg4jd8cvwXmEY8vP36GCOwOZaXzidHqlS6vf1oGoivVHuOLZE3aGXBWAz7NPAiTxuVKhk9AOPTDXThfReD9RMQpPfr8x1hc4lKzA82ZnsF6KAKRljDYbLNSCOCoa6JdUxXh8pn4L6zHSikp8scym9wljtC6vxBHAxE/KcCi2izTDmahI6VTN+IpgyZKAt2stMrNC7QLGE47CaStIkL0IennnhJDmOuewKPvloBbV+beag3L8HlUZ6pLOqZiLOxpv7WvnpSijniEnYJFTjWBDreV1Je3+u/bG3gmq/pRPCFsSVZEXRNRFdigvNJupix81TZNEQVdI9sUT0cHnPbDSMQQHazaNHHgJYogUv10tmoCz4cFng4UyiuvXuMikUT4vw==;5:TMOXvVzCK7X12Qywlu9cMPPQGWEdtoCa11zcJUXL7nm3cbLpE1BF6Rk3SQ3sc8qK8jZ+PdugvIX/VTxc+IORUvDFW355jf1Ck09PSCp7bOnP65i3QH4vaedgEaPa+M7Yfmqm1m3IUiUTmCNPxn1dfKebhYBPsDgl4qrkcOo8qmk=;24:Pw0o5y9PDEAySREsqqYfmlxM7JZZtZE4SIdZYYX811KzGJTq8WiQ0DhtZy/WXS4YK6RWHFb45PkqqZuozObbzo23r4H3hjRX89iV8+34sA0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:sGUFmWBhD4lGDsEFWFKF+GxmzWpRxIgXZxvflLfqERP0oh0YFmMSAqAXeJgXskhyw/F6TIYuG07Do3df6rXAmeBKm8x+FNPPl3SBGTLpgazNzsnKHCNYEiE6eGFLw9ddxLMIL0KI5OQZy4+B1+yZkYwcKNhL856AdXBh8ygUCbrDJoQbH53l/vAqkIDrw+B/eKPqoLrqQDkiZ7NpiSAJYsXUWwWvrestqZliiJ7e6vaOtsL0opFTAaDr6UEXbRp7
X-MS-Office365-Filtering-Correlation-Id: 3468618f-cf3e-450e-82a6-08d5bb161114
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:18.6869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3468618f-cf3e-450e-82a6-08d5bb161114
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 0fd9cf27542c..75f93e1d0bf5 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1331,8 +1331,8 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	tc_connector_set_polling(tc, &tc->connector);
 
+	tc->bridge.odev = dev;
 	tc->bridge.funcs = &tc_bridge_funcs;
-	tc->bridge.of_node = dev->of_node;
 	drm_bridge_add(&tc->bridge);
 
 	i2c_set_clientdata(client, tc);
-- 
2.11.0
