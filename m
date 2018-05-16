Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeEPHR1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:17:27 -0400
Received: from mail-eopbgr10090.outbound.protection.outlook.com ([40.107.1.90]:45463
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752060AbeEPHRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:17:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v2 1/2] i2c: algos: make use of i2c_8bit_addr_from_msg
Date: Wed, 16 May 2018 09:16:46 +0200
Message-Id: <20180516071647.29277-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516071647.29277-1-peda@axentia.se>
References: <20180516071647.29277-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::41) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:UxRDSy+ig9Phn5pqkNtrm4geIhdSJhKofNnzXEG2tkUwVWJTBdiuZ62eCxPzEOHXYsr+7t3ZkdmXnK5WnrTGarsj352a03lwNn825cshqyIO8AnlY1GCda5dIWnoAT0iQPMXept+6n227J9ZM9pk+/eJ9SAYDXfbHa72w8EvOdkCGxWPzSVbbpRMmKrg9LbCZk/X6Ycy85JfSrJl3n+Ge5RfiNbzPCBjFcRZQ/xFzJx/kYygMX3lv5hBCxsvT6qB;25:a9+/u9EeKlHn/oq/rNbIxgQanG4AAL1KWIRcCjWf0ty16fu6Ye+kVo+STUr5TejXb8Xo+tMjTOR4CHhos/X4BUbY8vkOlNI8EJojYLv0SpGykPY48wFVuRnUiZEQp4JiPM4ohAaA82WyoMi5fmX03jabZ/qoONmFOeMqSxTxOL5vjR+WHHYRMOucDv/r+ua6t4T/AosBORp3/cs9WvejF3miaKBujxO9NwvNKpHi2ywuqLJaLgsAzPgVZBcIg5QtejpGLo4uTghAQ/blsfkeceFfNZOUGO+nhzyBpqR7jGXIOHvq4cr90aPHferMGXLOYrdwwP98ucc/V/82j+H8lw==;31:rU3mXqz8rugoQkiXVVHhFuvI5SgKc7LgP2LEINOM+SJ6+vj5xGvVc7JunIdgXgdFgNIQzZ8NByWrKQKZqmL++cA2lflgzh/F2yTBq4nHrWC/mfTRfDr2tjs78ku3/MfUM7NznVNvwGB9di5BRCuvrRhNBFWlYx/JdrU76LS8A+sutqpJldvHPOAPWWHDj1+eM8tWqOBCra631ywWkMWPqQzOGQq4HmVmkSUgy9WOoDY=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB278072FB5AF31CA3DBA29B84BC920@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:6chxjFDa91/t5Hh+5uWvMoGI3jGUuF75r46DGxbTNXIfgwreGY4RgSKxnrxwgzX1ozDQ+o25wICOmM5QPvKALTYJ0+Mgqw7f6+2pYwHhpz0lDHWw/l7TOkRiCqqwt/m1vg2ar4uG/4IHJREzIPwPXY1afzxGX6kqaOV1RmgRnLnsLfgnEbBIGCHf6tRQacCgtF3XAu0bTlFtouRetbBxHJE/7ddD8Aw2S6H3kHOU9J2K5BDenvmPkiMlOb7q4+DOyZ3K3jEhBuk8saB80HBspA==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39830400003)(39380400002)(396003)(346002)(189003)(199004)(54906003)(76176011)(15760500003)(16586007)(316002)(68736007)(52116002)(6666003)(51416003)(6916009)(66066001)(47776003)(386003)(6506007)(81156014)(81166006)(305945005)(7416002)(5660300001)(7736002)(97736004)(50226002)(8676002)(25786009)(2351001)(2361001)(8936002)(36756003)(2906002)(53936002)(478600001)(6512007)(575784001)(16526019)(86362001)(106356001)(4326008)(186003)(26005)(11346002)(476003)(1076002)(486006)(6486002)(956004)(2616005)(50466002)(446003)(48376002)(6116002)(3846002)(74482002)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2780;23:X056sjrjIIZWYaDZLUa8Q+z2K9kt2uw29tSAMYg?=
 =?us-ascii?Q?6qxIAS1S5BX2yQnDkvZVTJlZkKS0FK3H2p9spSz94ftzJQU0blWkGl3wK7f9?=
 =?us-ascii?Q?vDCtaLko4/pMOZ3mTxM2DYYQ9iEgAJQpZmVCWnWZpFFjmv8xJ0t2mmR5mP+y?=
 =?us-ascii?Q?ZP/dafwaNdACae7hw8mnkPI0fLPOQ1m+6MxFBqcRjlhUKyTw4qXfPsxz0jbI?=
 =?us-ascii?Q?q9u+MJoNH956OvLngGuEJBH3kC82yee+QMnlmQpw2Are3t79MwOzV2AUjM0j?=
 =?us-ascii?Q?1Tu4mITEWKU9Czg68tsY9FopBMWyi+VuWjij7dlB2lV97hEpe92NRUZ4JEt+?=
 =?us-ascii?Q?ySYjlvfYvAqE0oGJud68eEuJ7940ZrLC5ufFbQe89Nov1kjunXjYZyP36toL?=
 =?us-ascii?Q?UE29Ck7yffXwDMhIgYIV2L7bVTummifUIj5uH6oZkPnVI7Oikkfnxm9Xlzdy?=
 =?us-ascii?Q?+0XvwWhGpe6W60GCgWyNTiFZ62wQWj4vB3E6WQxDW/RoQXP/+V6ZKMCWFCRk?=
 =?us-ascii?Q?4Qs6zDKNEwaRoKrdiFFTsRiU+ZP/wAHc8NS9XzmzbBjj2z10QGyQMFOd1dxm?=
 =?us-ascii?Q?fM4gcIco1EfMkebDz/uwFkDzCKCgQ6yNiKAJ8CMIBEfQSuLX4ZpJssbbR5ob?=
 =?us-ascii?Q?o0AKwtNFYIHss5n8l/fsenzgKlCXRkpAT0eOU8cZK4YvhPoiSphyxjl9ifdQ?=
 =?us-ascii?Q?jHxEh5S8juCa+yiHQm8oJ7Bub0/LoV4Ud+zZe19qzHWZamEgfNQqti/Bnrx3?=
 =?us-ascii?Q?zB5aiZ1EQsU/BDC/zduOGv/KcgYBEh2SnAEW44GIB4mAU4W9SLjHJa5yq1BO?=
 =?us-ascii?Q?xjdIrISYbHlwZAekH4qIUhJSRIdiC6T6Vne2YkJ31PqJnI0RuzKsL7kn+99T?=
 =?us-ascii?Q?bBVo87KgtDmvoaqTdz10R9VynapzbTaa6v5bvFaLoQ6W2R4tTElcQvOf2VBa?=
 =?us-ascii?Q?dA0F+Bg4z8sXm49pPukvGNWzFCLAh54hBZzc+BQeL8+cCQN3FnQuR4K4wavO?=
 =?us-ascii?Q?X4vjVhgGGBRCdySnsYj0d9V77RKjvSglHQnyINx9qyziEEMCzcPAKKTRxI/+?=
 =?us-ascii?Q?tg2oM3MNNx+Mwu+Yhjso8vKNqOM298ZC8iUTs2uWOOYk+Bb663dHhFqhF+jg?=
 =?us-ascii?Q?N8KFFL1LTioPttIOltWmlROJIPHjRwaA/qJTzf2VUq/wVy6Hbe2TdVRa36eS?=
 =?us-ascii?Q?/vgoPsjNze5wsWsB2JVZBXPcoc1q20AQ0ZEHJC9TaHC1S/vcSaC/kYmEo15R?=
 =?us-ascii?Q?25WSQkTIhqjI6fI4WrHDvspUOpOjECR/N3DDVbhx7ca2BSW2xiYlV3y+voVb?=
 =?us-ascii?Q?+WkV/h2zAJH+TkvHzTQsbjYnBjL0hpEZeiy3q7P5fhI1PNv3krn/Xn4O32KI?=
 =?us-ascii?Q?oyO5vjb0kvP9a+4FzFG6ejFMhK94=3D?=
X-Microsoft-Antispam-Message-Info: tnrlPy2GvYQyN8yzj7A2J5RPHfr8K76zf3NayMjsW7nYiQb+gNraPeePWMJwoEsBzDeTfy6/TA9caFjMl9eg+I+VJWz2SN7Rpyj2OylTeGVvi57fjvX0xXk1BFza5ymRW6tdXW3kGuijW4k59HKlHnlE/kJA0IXC05SK+aqeo4K9zME04TpEPXpzhd3PVVdh
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:T1A0Siue9BvDTDIpE6eJ3q4iGLze+vxzdm9ClWXXKBVeuaFNxlnCzG0pLuJo8agl0ZMK4FKqkO7s+5A5euLYs9Hvjku5IN17kwj559PDvzrayVGxyGvNfHgsIDWsIqRTqRF3VUlYWFGXBP7RT2lqqJ0Pbw3cuyw04m5CVFrMG9QYLZB9Pb6L7lcaLhQjB/zfsrDnGVlCf2FmpVcBsTF8Xqrq+42q9Q8/F7Nr197KzKmU0SLHiJc5gJfck3jKZxv7TmqG38Ryf3VvBUjFpj+l2NEBb3+52NAEAHv9rbVkQlbmMVYSjO/49XdpsRSg3KRXnUT1rBXMXxH2D4V/4IjRLkTjkTZ1lCM8ocOICdFOvsMrLdivGGgUBCj78XvpbPoVL0/xZXrtXTsTG9NEBLoMpIHLJlcH0C1jkE5RDD0xW3k0pCpzSNVUtzx0WKb9kE/c+iwJ48TcHOTL+07OBrbf6w==;5:oF9lxuZTyXMDvSktSuMn1Us/pLoA/ORp+z/TOnUBPeWfwSduYuAm7vqvnB4bEeprgxriPuaW40PLsx9/kt5hd5a+Z6qXHediqyFcp/sciwQQgwrPFjf58525ikRPVAcYN72isgekgJYYOzKQ+S4tpuXZUNxWr88c6n6feh9oZno=;24:FZ+eOxiYUMHDx5YYUnok2+KtL6C3S6nJ6GV8CRPdBGHKprlc2qPBFyoCISFDTJNKzOGRwJZ8XSwReA9+Z4DFvqbkKtKcqKzDzz51IQ2Jgjw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;7:hakthizG7BuJJigzvcRY8CEzZtZr+yVmAVDwzHmNfot0ahUTi9HpW29ItijCDnM6v/Q6fF7TJd/Zusx5p9YxSuZX1Y6sc8IS07xKGwPMzgqL1sL8Klz/RQtzlpDIuCcnOYScivMyo4GN3ffRxhGxgySIltHMS7vstMWdcQ/pesKtwia7fxS1Yk+ZsCcTR/K/RvyQZYmKTH7quIx2GSy8oxuQTLKaNbYW4bFbsTM+jCUBZ/IFxdbTYdyh2NDlluOr
X-MS-Office365-Filtering-Correlation-Id: db99ebe0-a8a4-4b11-07e5-08d5bafd0fca
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:17:19.2184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db99ebe0-a8a4-4b11-07e5-08d5bafd0fca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/algos/i2c-algo-bit.c | 4 +---
 drivers/i2c/algos/i2c-algo-pca.c | 5 +----
 drivers/i2c/algos/i2c-algo-pcf.c | 8 ++------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 3df0efd69ae3..4a34f311e1ff 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -519,9 +519,7 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
 			}
 		}
 	} else {		/* normal 7bit address	*/
-		addr = msg->addr << 1;
-		if (flags & I2C_M_RD)
-			addr |= 1;
+		addr = i2c_8bit_addr_from_msg(msg);
 		if (flags & I2C_M_REV_DIR_ADDR)
 			addr ^= 1;
 		ret = try_address(i2c_adap, addr, retries);
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index e370804ec8bc..883a290f6a4d 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -112,11 +112,8 @@ static int pca_address(struct i2c_algo_pca_data *adap,
 		       struct i2c_msg *msg)
 {
 	int sta = pca_get_con(adap);
-	int addr;
+	int addr = i2c_8bit_addr_from_msg(msg);
 
-	addr = ((0x7f & msg->addr) << 1);
-	if (msg->flags & I2C_M_RD)
-		addr |= 1;
 	DEB2("=== SLAVE ADDRESS %#04x+%c=%#04x\n",
 	     msg->addr, msg->flags & I2C_M_RD ? 'R' : 'W', addr);
 
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 270d84bfc2c6..5c29a4d397cf 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -291,13 +291,9 @@ static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
 static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
 			 struct i2c_msg *msg)
 {
-	unsigned short flags = msg->flags;
-	unsigned char addr;
+	unsigned char addr = i2c_8bit_addr_from_msg(msg);
 
-	addr = msg->addr << 1;
-	if (flags & I2C_M_RD)
-		addr |= 1;
-	if (flags & I2C_M_REV_DIR_ADDR)
+	if (msg->flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 	i2c_outb(adap, addr);
 
-- 
2.11.0
