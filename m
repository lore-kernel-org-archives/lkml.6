Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757082AbeDZWcd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:32:33 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755175AbeDZWcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/24] drm/bridge: analogix-anx78xx: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:19 +0200
Message-Id: <20180426223139.16740-5-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:huGsr8MYoUqFDmMTKxwZ4bGdhACH/sNHY1C0N0J8RwhS/JKrAr5ffMaD+1GaekA1Au1hPAK8pNdXc1Jv29MQO6uzaOiaEx/CKuIwWwYxApPB6/nkcPI2q5OLCQDS5Y5+pseEMpTGvfB4RCOVGTiWIE7I9VB0GC10WRXfxRUssnRL/ywvyS/8F4Ir1fFyA0Y6lfUOYw759VfjhaCxub+9VojzcvAT4ZfsQVbUOF5hyYJM/bupTZvu1iepXLWyY7nV;25:ur6JAORC4KPG+DkCL1WvDNJ4vyBqA7Fz8Hrzve9rsd+jvSRYlOnBx5qaSTGw/92m2JXY9OwOYsRRkTmtYYQeoIB0ft7H1tJi0rL95lUh27TTWy8wdfNvbsLo5PhrZRF9M+blqLeFXYJ/L0EO7VdkQ+BitSnOFfGxnCvCvGQ7vaHa670G1QipqtRCsWc5YWpRj1MgYyYujsITKXv3R2uI5K4ZqAvyRymNkoFvO1sQX8pxI7WCyt1tK9P7rafJBUuw07Gk4K5qNxcaUTt3IzEc1+ANz2cqWVf8b+PVgrlVA6bw9hXufLElR8b7WJZPJoLE/l6LRnyAV4o9yQ/76MU8Cw==;31:6j9IqyF0q6QBX6Zgv9RtJrM9ysh4yd/MMNEahg1bfYMpT0Mu7g2s17cLDP7HaLi7dsNgr3BR/UAEtYwWsZueBZg+HMr1YTjxhJ7h3YLKx3yn/SpX1KTiDfUdvheJBQ2GWVmF85cr7yuvzz21Gd1NpXe1aBYSKm3pLWpZPCsioNJ6uJ+XcbRa5fAoArvEawpjaUMDDgb98GGBNyGTQhc1MHcn8y78JAi7hjiJF6BaKUg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27825F3E308535E11E787211BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:Np/vKkM33N+D4vDou0kxGZIbvFsb44EHP1MEjr6OtpQfoOZvdf4fK5c4OuLmBN4Lv0Yl53SkdleBr6bjyTwuYLFRK+bSK3azl4qh3N23+lormJjWlshVQ0FSK+XZbSVVljL8oguvvtoRgoqcAQacRlZcDFrw3nMhQuBxklPzJUXFIIRIjno3VZFyQl9b8KqWK0lgSvMJ3tLLFmr7yboFPqsw78CAWPZXnD2lfxxtSHGGpeN+7jK7CnLpCihpqV1RiXIltsGSWBcEQ3OGYQk98A==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:Dnj4JOtBdZ/+0HAW6cfRxpjBnZNLWzNjCvt1uba?=
 =?us-ascii?Q?qYqs2ofnKFhrwKnUw/3AAjPRxJKNvseKiz5RnuTgM45cMD2DCfyYSKzNXLpl?=
 =?us-ascii?Q?DXIQTiBROEx3m+HYo3oJFtPzAZCcRkXGdF6YKfpP8jhiE+FtYfenbmbs6ifJ?=
 =?us-ascii?Q?TJfStZyalQk0unxBjK3/g8geRAAFijpTSBoQG5Qck04ElxyIfXOcaiv43VOo?=
 =?us-ascii?Q?h4jzyKyiIe6mYgm51VtwEtKG8wxz8ns3bZAJKfYv5uXRkTOQt+UVW5ygIeJJ?=
 =?us-ascii?Q?ANmZ/SmGi7qzXpFjrSxzfTk3k+0B/yJtY5dyAc3oYANkIddd83B/UYcX2RsW?=
 =?us-ascii?Q?wybXyvNKeNg3RQ1M1M0WvrTYUdt934h43cg8Bd1R7qo4dhgbr0IVfK3E8Ljc?=
 =?us-ascii?Q?6qu/6lavHqE3kzqBOHpc5yDlq/MyJfiRGc8Xgukw7/5eV8lGCbSwLQRtqOUx?=
 =?us-ascii?Q?E8y8TwHvb7/kqnetrYVS74QFa9IAv9P4q/kioj0JHZv5nus3QAmhO/XnqJKV?=
 =?us-ascii?Q?e+nvEgjhRZlP0p6azU2GCrpFSlIMvOpwYjVw4ZUARtU1yIdsM/7i8cfWcsTT?=
 =?us-ascii?Q?5JoUvc1oW84XWRsB/HWbAKu61JILWizXIdTMgQ8RlrMNaVw3vUpewku1Gr88?=
 =?us-ascii?Q?HARCuWFUP2Sq22XBcWiVb+VMhVv206hXXdRg+GNaZSO5KdVSEGcJvvAu50Pu?=
 =?us-ascii?Q?j5ztfXbuakmSWwfFJLnKNZgkEvdBYvhFlP0fy8kJYcE7Yuvy2Da+1j5euxQx?=
 =?us-ascii?Q?KDMN1OaYExV7l8+y1HmRcEW5hymrhSrbGWJNbZj6m4spK00lkdidUk2Zqc2G?=
 =?us-ascii?Q?JTqER/xRLFkbQVPotkxa3mkfYvHeCL4K8ZQU+5A1R7rTIPS8pgaXgGPju/BK?=
 =?us-ascii?Q?R+TRSInPaTh5ZmWQ59181k6+Rth5ZVqLKO6/hy2YCjUvRtNYPOX5LbDOAWL+?=
 =?us-ascii?Q?HPtSq0qDlfLW/KSpZTlnQw13PNn0irjpUW+badtQ5nLsvZukI5B8vcCaYhKd?=
 =?us-ascii?Q?+2P4imrGxtgzJLC5utUw8OPdLCz2WC+2EAk6VxNqrNf59N9+kgdHogjmvsQo?=
 =?us-ascii?Q?CWNkAtm/gNUE+qEcGwnnvkiBnqNdGDHgnk2INMjb/aFyGNL6U8l1claiu3EZ?=
 =?us-ascii?Q?L9BDpxH+evFtVsKz6EaJ26i8pAJd1/1dhme+Yjb+gfB++BffkpPQNffnWHnP?=
 =?us-ascii?Q?7ssnEDRUFgVzmVru3ETG7a83s1Xft/QPRU+CQnoCOcZcGkAzSQAtzsb5srbx?=
 =?us-ascii?Q?C7xLKIoKwRpdKyJpI85Kfw4GnjaEER9cknfOxlfC0C67xWz1EhHD5pEbRw4e?=
 =?us-ascii?Q?e98MMgMb5LItAfGTejReLJIVpcZzByv7d3dkcsCa5yk5H?=
X-Microsoft-Antispam-Message-Info: Qt4zbiEUBlSpp3MkBewzZvt4tJ4rjZG4oYGrHHX1wyc4ZmrMIfV+SAZyMdoeZj+c9mUCUa+dprjWfbCIkx770IUaj4jtfAXsJniUScxSZPYjyAhII6pd81kmXdZJvNusz2ZZOxUrHqCpJn4C438FPhtfGmsWQ8ew1AWq7nUj0vSCd1O0QnH7s0ajWua3cFrM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:ZB3G6m2dXNpnHNDt+15wwJ8Iq/3RPznHx11t4qLhKe8TsCqP0L6oyglGz6Joxe+I+t3S7cYb/qFj/KeKHUuycRPJ6BK/Hl+gIQa6i2DfipOP5AgwyO/D+ibSiC5UIFOrv0pitcLfSVTpUg6VmmnQ5feGyPJmoGEahy7Rf1STXUmYB2P2Y58ptghDbAQ4T9O7MULYTngyQpIGFPTf+D7qzKRyHyuEdxzcRERPxBi7UhOD0ggl1K2c/EEclPChgMloNMGf0Mpai2JBgsKxxXSZFfv9sgUNFlPh0kcgNlDqT0xdCeLHo7zSJiHqW5iwSGImHeFALVKp9WnBQiD7b28OcjtuoTKNjE27pl5satkSj5qdJYOwX58XCjTDfJfEpNKFBeKxQEsV+1Nhi2TqWXMy+OwNRwvf1JPuSfbnQho9n9QG4JiTIR2w7ywd6mz09JswN1s48A29OojTWuSUSTmdRQ==;5:f3VfTzutyfja0Pmi8yJs94tFAabE6+Bd5TzxV2HCmR5v8DMWc/DuITXngLYDje9aSm7aYNU4cEagLViBh68oYP0AtNKwhPADiwosRm0KAVpm8s2QShnhohlG/5dN95OwbYoQeq8my5epHQOjXmbviMwZ6rFTNFka8g3Yxc2Gsng=;24:0s5S4j4W9jyAYHvr5+sKlgnQrJik9TjrKKquXXVAe37siH0gbPblM1H6w23oYfKX2jdOLB5BgzTnrPGMAjvhJaNxwqnRIqzH7VweDUcDGOE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:M3aRiFzoFj18pw7Y6VwzJoQkNHFeXIV3C3vSodyaXY2qy5Ss2ICdYU78fKbboVBUvrrf7M8munXe7tmloGSquS74+Aoe2dtnTQPCuZsZqHF3O7az+ycKY9XIFCxy6wZ2rrzmlQGsKyXp5uPl9xnl8oHoQ+m+YmGNH01M+qPyZhG0ec/5IH/YHbHABCN+9rc2cgyh+B8Ge0nB7JeavTe9/vBJR5bzGqkg3rnirToytQPppf//ORXKmi9u/OMQiEye
X-MS-Office365-Filtering-Correlation-Id: e2910fcf-afc9-436b-37a7-08d5abc591d0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:17.9167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2910fcf-afc9-436b-37a7-08d5abc591d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of an #if and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index b49043866be6..4b2eccdf88a3 100644
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
 
+	anx78xx->bridge.owner = &client->dev;
 	anx78xx->bridge.funcs = &anx78xx_bridge_funcs;
 
 	drm_bridge_add(&anx78xx->bridge);
-- 
2.11.0
