Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeC2NLM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:11:12 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:55061
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752221AbeC2NLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:11:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
Date: Thu, 29 Mar 2018 15:10:54 +0200
Message-Id: <20180329131054.22506-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0401CA0056.eurprd04.prod.outlook.com
 (2603:10a6:3:19::24) To VI1PR0202MB2783.eurprd02.prod.outlook.com
 (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247f64fe-ba73-4beb-53e4-08d5957687ec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:LLkjfSLhDVPSK4BI0g9eTsKBCmqITuGmDHoF41vvaS2h9wr20Y881jmFW3GEAqR+V93+J6bJR7x+M5nTiYlu7IJ4wmrg5lLgxkSJDxdaMFLt7whlMAzVihR2OmnYUJmlZgtefvjYGFbE1hdAAD9IDatOggMVkwWKk2DBKxfCUa3jJgTAnOG8z10QcDAkCqjn5vM0tb7p2gCfnpp/Q8uyyWcfbUszasm+5/psQMxGnsicJjM0/XU+6NchICeCm9V6;25:WOUYLOE8aAlTAgLWtjqC4wPO5bjMUBSyYj8Wbzy+3GpzTJCcCjWWiiBoqSOT1ALxX+TxjOYHaWhW4CzXdJ+xFDym1B/yXoIoDnVhKMARcIyAX3f7WznPxEXC0AxPHLwyBWLAWRzY/Qdp/YXsFYSfVITYMUlI7O+YXCIGzgRMJsNW+Dn8r/wtJrsIm5jasf3g6DVWIOmU1muXPvXxWrqBIfLjXDftdf04gKe5dd4sWAnHgwXJ1Fb9sltXpyh0iOjNme5a41TwXvKN5azL+cgJioboXr3qxVGYFZ6thJSsotGxipeEJt3r8qX9iRqzeVoGYei0m9pYGl64AFPDdy/2ag==;31:IM9K6vuzGnVQircMxp6Y/yYmNZ0b9C2Gtf3uQHUKOh1SLqnQxMaTABvuo9Vtwbb3JyBdD7zsx2afDyW/nU6Qyypst0CcX2wxXBJheenNyMoU6IkuD7ABaz62O3HEhsyJrE0+LUDuveddVfC4KKNKWBt6myW0aLtQTTX83m+f/rMl8rA6QG9Gy1cgWtDi+4wxV/aQn3bjzmq6QL3iugd/rewJOymSbg3FnSc+kWUPkdA=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2783FFCD01D4AF04C1F8B560BCA20@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:F0r4ChlFr5QeWl2VmjhBNthqrIO43Y1Zl01XIVp1V12902Uwd2RNgqe4X2k1zsxMa+3keVCiRylUQDtHYDmEUUXcN78dcq4xTYcHeBhx6pZboH34Uh5FAZg5PJm+kkhisYF7D/MhnjZvELhPtswoSYmheGohX5QX0Q3IP0NJvtS+emranb5DaUXhMe2jFrk0dCc3I1zg+2rltG1egqDdVmTN9Kz3JY0zg3bFhE4IryPJv5CsrnX3pA9sfQg3+bNfLhDqJvDfuy4IjEgzweq1YQ==
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(39380400002)(346002)(366004)(376002)(189003)(199004)(47776003)(105586002)(39060400002)(66066001)(305945005)(4326008)(7736002)(7416002)(5660300001)(25786009)(106356001)(48376002)(316002)(16586007)(6916009)(6116002)(52116002)(3846002)(54906003)(86362001)(2906002)(486005)(956004)(486005)(2616005)(36756003)(476003)(26005)(6506007)(51416003)(59450400001)(386003)(16526019)(186003)(1857600001)(6666003)(2361001)(6486002)(53936002)(50466002)(8676002)(81166006)(81156014)(6512007)(478600001)(68736007)(1076002)(50226002)(8936002)(2351001)(97736004)(74482002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2783;23:hAcI1z1Sb4G4nd0w+IiM9F5Y0BTlUfoHwfsN5K0?=
 =?us-ascii?Q?tyg91jOSu8JDBH4s5w+RBo9jI73jy7xslK1UwyxpvbPqvjE9LAMjBt/ycPwl?=
 =?us-ascii?Q?22hwTjajOkhxPxxTqYO8el7DRA3llcrAL1LjTI3Bn3BaKb7bO/MnCE9ftryC?=
 =?us-ascii?Q?jVTPDAncVHtCM2cI59+gvR8rDki435E3GY1LnFzbLP8KteKw1JtpXdJKK5Np?=
 =?us-ascii?Q?3GRHrgq590B1I+b0Na6QcTifC0z5shTF6i9xRzEUotb/UPB5ZbYUGY8QNZzh?=
 =?us-ascii?Q?fZNL5SqXVIQ9NWoPEm2NQ1122VQodchypTyJivUWR0sdzNNT68OXRJsPr4vq?=
 =?us-ascii?Q?MiE/DkYZ3IMPViGu6lU5cHuxuHF3EVbFxozpkr2IQzSymvAq8NVw0z/1U8OQ?=
 =?us-ascii?Q?OkiCraj+2y9uiK7T0pGIf0L7KxOaajP3nOjpZhB5w/4e22vea+g0aGC10r7N?=
 =?us-ascii?Q?cLrUMRFpOXaTST5wqhl9CFfsVKRvKTOwxcgQ0ZOyHoNZlJ3Vv+oATeCx/SHr?=
 =?us-ascii?Q?Y2QgTbjiMzJn2WFVxMXOYSKAl4tAP6TDGgmhKLIaJCkhe2ZKDvM1H2VOwR3C?=
 =?us-ascii?Q?k8XABRxWO3Xn0r4d2SnK0s8aK1K2Vy299oaoOx9lOd5l5aEJYS6rPwUO1Lwj?=
 =?us-ascii?Q?A1ecrO26vfun0Fb6c0cEIieqC+hQVM+V3H1CvWNOTmplBW76NotPaZXVsYoB?=
 =?us-ascii?Q?5ICwVM6Dn76NTQZzrIXgjzfF15ZSg7pppgKz0TpZZS8bc19RT9gLNjGko7YI?=
 =?us-ascii?Q?wk7UNehqkQGqcCqxzXBjLEGtqSFNGORBAQFYd7q9aqKV3BFF3/C/LJR3Wryj?=
 =?us-ascii?Q?ApUffbnotdjzZlTGWTl/wzyjKhNoi8d305rP4zrixDTdSX+XH6caULpZzegI?=
 =?us-ascii?Q?Kkhe833nIO4VIukMrLtINed/pchxFc2vJ/lQOx2KlWdgb7/bgK6mqT15BX64?=
 =?us-ascii?Q?VqbaZd/xQWt9FB+vM2Z/MBUI4BaMnzMhlAJUdHHnFBlpnJNRMjLNl3vhxVCG?=
 =?us-ascii?Q?8PpX+ygZqX3Rr6dBQ8Wme+3L6Sz+MFQT4Yxhv8X2r8Looot4jZZ05MZWyqwO?=
 =?us-ascii?Q?XjosAExDvp9l6cpeQA7fIlOXQdHvRuZKu3peZZxIY58CDOZgskt87o/RiTEf?=
 =?us-ascii?Q?fMYDCYqwpIQ9oH8EquHAZvWXypAgZAM422dvEm2hpRzYWYIvBokAz3OGvG9y?=
 =?us-ascii?Q?OVqBdOg6aBOIYPVVxYf1DLZACSVuSdQHui/PUbxNA5gj35c5PNHVpr9SlHBp?=
 =?us-ascii?Q?IJhsdwTzfsyM/dGgYCl39MLl1OqWDTbS27ziV4JkNneoVkMK82/apFD/b8XL?=
 =?us-ascii?Q?iVNdRNbSzwwB8RHJQs0WUa4bkIFz+Xh7hTQaaDa0ER35IKzZIWEkvpDAzL5T?=
 =?us-ascii?Q?E0xX/Fw=3D=3D?=
X-Microsoft-Antispam-Message-Info: ruNPAKmTZrLBi9q5zrn0HMEoSCn+noAMJR0/Z5Rp9j7PkN9OkDAN9ioFVPGoGpAOh/SCd4sj26OMq4k3x1muZvCm0PMnyTuUy6zvnWHunFZy6xZHOXZehRtPbCFEWAFvt3e5PNAG8v8Iw2mDT9RQu82mHezNozQqaYSxhOa38hGIKKwN2fdgf1vCaJxphrwY
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:Wy06tWBZZrcF2BliHNHsaSZxNHhxg9Txt2hJG59y65qhmdnnRXUnL2Qg0SQGNCn/EMh7/8iaj3pTdiT602q3ItcJ/B8SVG9lbxA46DijHSrzLbwrl8V6QgmPlzafU5QT3kZ59Mtx3+Oa/TCKK1KYW6iGKwlc3OpT+mbSyZLNtnA/th+yNIX44n8EvXRLAoGSfSZJkPC8nNcHaGRfAKVvYaYmDG36xsV1WByQy0SvLBB+JvylcPf7xqWNnScYGLagAHkeLWmT463TDmp8eOEZGVAH45CPFzm9ME7G3O8K5dNUJKue7Q4YH1N8DnRlpw78qwPx7hFRDp5DVQ8j570pt++PX7HJmg6Qq0MJw4z6cx/zndgAzT8JSmnc4ULtpIeZq4rXGrkgYQ53rQ7pchJR5LfZ+DuQnTkElxLfM2fSf8LoazFSLvjZPdMaIomiWox5kr0Lemh7F/MI1NvRTR0Urw==;5:w7e2Y5e3MGaB+7F8vHng4nxHrJe9sRv4Qp9nrvKSjF0gey05G61i9h/bvViZSVJxUpkoPu9LxQMdHiqw24Yebxds/DHYbz7Bqgx5QjEV9rMGgcZW3KesyZ0xYyXm5WduD4egR2KMyDPjFTgMmGOTM4doSikNQdvgQzD1tBZoP/A=;24:3D5CeyuabakNyDaZVHR2LgfpgV/PEJl0XaxES3I2vorUPWZzEtzJL4pVmJcN+l9h3nyRGxKoNnN2ECtp+NRT4pPHBLYwPwLovCV1I/qooFI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:6olb34dQymwJ2nvWjJoTaXhXwDnee7/2fF4XbCWHx9OlewRwzLRlfDTjSY0/wXSnkcez4dWwc9JKwY2XlZGo2ugd2JQu3yF9In44vOSfoKomyuJhoC3wz7do8OrGZx8CreCWLvvX0Xo0Jj5iWxU0UShTXKbyH0yoC310VAzSAYCksCp7Orrsn/uph5/7++hKdHJh6r8z5V1J3kxWQGUCGb0J01JTKI+398a6oLYJGizT1BE9Ppg1KCP0LSLZZeqW
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 13:11:05.2353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247f64fe-ba73-4beb-53e4-08d5957687ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
flash accesses have a tendency to cause display disturbances. Add a
module param to disable DMA from the NAND controller, since that fixes
the display problem for me.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index b2f00b398490..2ff7a77c7b8e 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -129,6 +129,11 @@
 #define DEFAULT_TIMEOUT_MS			1000
 #define MIN_DMA_LEN				128
 
+static bool atmel_nand_avoid_dma __read_mostly;
+
+MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
+module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
+
 enum atmel_nand_rb_type {
 	ATMEL_NAND_NO_RB,
 	ATMEL_NAND_NATIVE_RB,
@@ -1977,7 +1982,7 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 		return ret;
 	}
 
-	if (nc->caps->has_dma) {
+	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
 		dma_cap_mask_t mask;
 
 		dma_cap_zero(mask);
-- 
2.11.0
