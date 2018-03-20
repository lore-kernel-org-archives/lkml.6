Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752476AbeCTJcn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:32:43 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com ([40.107.0.100]:45367
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752415AbeCTJch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:32:37 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>,
        joel@jms.id.au, linux-i2c@vger.kernel.org
Subject: [PATCH 2/3] i2c: mux: pca9541: namespace cleanup
Date: Tue, 20 Mar 2018 10:31:59 +0100
Message-Id: <20180320093200.19179-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320093200.19179-1-peda@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0502CA0029.eurprd05.prod.outlook.com
 (2603:10a6:803:1::42) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d151e15-7917-4c1b-4d0d-08d58e458391
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:5CNW8tl2Pm38EtHK60bl0YUThjxg5jNg0pki/tmIPY73j4/j2gHrGpxnC/ekkn/a5+xYXRzC9YwGjCuCBppCRFpoWtydthZHveNQzNTEfIBVQ940cu+8tc447FCX5IUofg+01MIRZPemjS2IGJPFYpxY2PmL27dM+HogCL10uHp60bjnlZ1mH2HQmbEDaPIB+Y+eIg/uFFupX1GFeDHGeNkg96V6wUW2qf1+Remep4bjHoqQN49G9r44eu6echy9;25:uVmkIBJa0Wf+R0MCzmzKev5ISNzOIMdzsvW7AjTo1g51PFh3IBzGQrJy4sD50hi/bWlGlKArjxpEtSnsH4d3Nf2byOnuDhtFQnq5785s1DAdczaPY2wdNhtdl2KxJhFFo0daGWIdplSgYHl3D+R81oprYfNAt5RoRqxmg3coiFq3153x2U3n8gkHsHl4pMpgTRkjZv2yi+HdoTKko1QXeJlgJ7qMIQXfoaJPSssLdJuwUlU5FoVRUBX1oFwarD7cBCHT897Kdk9oILGpIAC3Qx8Or+C/Xcruzz9uNoNGbAXiMBFGLyslEOw5dE2MMrJ6hngU3NNH00bM450A6G7ILg==;31:M3vLpbv6kgNnH++44Wlv9uWeXkT3gUQnmRWACtazMmUZyRBN9G8ksP6SK7N9lOYRo21rWj7rcP0wzYGUfFVKPHl4eYk1/NWPK9rwU21hOL6AcEGqrorVsjodBlFBN43CHJY1gNp2aV0enExwdjwyUkfdlsNHy8ZGOKqpQuAr+DtfJmCGfmqyyIqImpc2K0MnsyySnsoehtV0xk0y1RQxPYnhgz9y+smF+HetOxLgEfI=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776CF82218331E46BE1B668BCAB0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501309)(52105095)(3002001)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:fWqGXXt9TR2sY/ASzF4MbrG374tDkh0cZ6eOqF3ztBGeQMDRi8nGfszo8Q/r1RslgEpetT4MyMascIguu3FjURQ42nPUefVLDNwdxzqd/BZ81n75npCuCxvT0cuL6twC0IOT72sTMbZCLlvMRk+IahNqoquYF/KKwyuU2FR6THGyoPEPwdZ7s6Y+wckNpXlR+0OZl5tpyY1W0i8zJ8zk3tjsA4Wp8cOUx4PwGhICgW2lFNfMGoPNRa6TV7RWroTr9dNbzGGpYhMIMyU7PzWGLGkCwk5b21/sZJfANTOLVzX975BLUtZuKMiOlfyqflWp
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39840400004)(39380400002)(346002)(396003)(199004)(189003)(8936002)(16586007)(54906003)(478600001)(81166006)(2351001)(6346003)(3846002)(2361001)(25786009)(76176011)(106356001)(8676002)(81156014)(51416003)(86362001)(6506007)(26005)(575784001)(316002)(386003)(186003)(16526019)(50226002)(53936002)(59450400001)(36756003)(68736007)(47776003)(4326008)(97736004)(5660300001)(66066001)(6486002)(6512007)(305945005)(50466002)(7736002)(2906002)(48376002)(1076002)(6116002)(2950100002)(6666003)(52116002)(6916009)(74482002)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2776;23:uZh3uGqI2WKUoWGO8igxIEWwyjSM/bpJkaYrOZV?=
 =?us-ascii?Q?YjmRy5bi7kdie2OQXDwRaoVreLjSYHWMrHxGNNdUnCuUQpXEZyowMQr6XV3q?=
 =?us-ascii?Q?ITKjlp879KIxXHZ+cNE8AIM72WR9IyuLLdAyOp/1EUm1qcs10YcalLu69NBs?=
 =?us-ascii?Q?gjw07Zgurrk8PUxOLh6+jRUofnmEOPGxc0tVbyRLJwJSE1aOf+bJMvUXmFEC?=
 =?us-ascii?Q?Zvw/YlQvyYZSidJwgbE96lsK3iiCX2o4e23SKDC5rEnK1t9QOEyGTytWQe1A?=
 =?us-ascii?Q?P1koIYpTP1GDSy6BrmwsCjbRsyusSDSbw+K8LD0PAv768XKQOZd2OmvJgqgS?=
 =?us-ascii?Q?ErzGthiZX6tprl6UorUMi9nrg/HvWkeiB0/32qovKqdJtZI2rxYM6dNOH2hc?=
 =?us-ascii?Q?HNbG0YDFSpz3Hb9eKZVnGbMOuR5v3ASIXpFcGIYNiCxqtw5t+sMSWe8UUoiz?=
 =?us-ascii?Q?FmXBNI+phEsGq1MvJuqpALDy/8WDtIri88iDnET1WrCQVNPNsHGNShCP+Lix?=
 =?us-ascii?Q?2xG5C6EqYn54BTfYwmBSrrtL1bmmK3fDCZW/Cx+7qCchl799stWl+tRww62Q?=
 =?us-ascii?Q?s7g+rUF4rFaID1EZ8luV1sWmX6UExTpPHli2/h3wARclWue329DbOLzr9qp4?=
 =?us-ascii?Q?Ki6k209sE0QPsNB/eC7JiE4gn0Fi91nQRZg3iUk8XyO2dlkLKoZ5uuak1QNK?=
 =?us-ascii?Q?/GwRxYyGDa6OzSd9u6t215lSbtruyMM3FnBrSfkcCeZOWQbQQ3WIedkvRSIe?=
 =?us-ascii?Q?tD6HiOgF111uEq3mazGl5X6Cd4mN9NJAeaDqIdhxdWLFqK+aZxLGrerqdy3Z?=
 =?us-ascii?Q?JqTd1slFa5rTTUgTSMZjoW0fFrkGan5FAt8NXUclrMRsVrLd8H9zEXbX0rFI?=
 =?us-ascii?Q?LzK7s3gF2IEOu+VDjOAjBYZZUQ7loap5jAC6HDdihJgh6GSRPGXA8rBG2/0s?=
 =?us-ascii?Q?6HZOE+6FnV4EDbEe5BXqOlo5QC1phqh/g4W095rn+pAgtWsMGRbmdX/S5aIn?=
 =?us-ascii?Q?Fsm993ygd8iR4QoZi4OhCgtx69rYNfBLj9V170NHJcxphgtQoY5PYT8n5HHv?=
 =?us-ascii?Q?gl94s60px5hgQCX3fdTNTaR+LalbPFtisqa+K9+R1GTbiVj0BZudJMODKX27?=
 =?us-ascii?Q?t+Fy9zueHNKnP4n+miqwE6b3HzxA3dIe+o2pi/73T8EESc7qtu4scGjoDKTx?=
 =?us-ascii?Q?Cv199tOwR9c89eXykiEhri47LQCEEnYjoFmQ/Woe2Ot/CuzPAv2+iMTJ4tva?=
 =?us-ascii?Q?LlyQAo+2JHS26EdgUsq28RttV5P6IgcfOBWvDyLWP8I8+5l3J4wNIzoAD55k?=
 =?us-ascii?Q?QaQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: gWQdZcMkxwtINHdWOMdMABY3mD433MXN9IBiT0Ok4y1TmgvtKZ8RfxeC+4hkIvSMqXGWdFo9KggAIfGmfCVyY/gNW1vv4N3W7Xy+UdgqYGU62sBpsUzBBWL2HBo1iM/RVjiPdvo1W6S5LGliiBf5jAj5I/kj+oT8Pw5NO0LUT9X6QOWUivXr4/cZNBOvW8Sj
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:I9k5v1PVV5IZ4Pwds1Bi0/MZy6z8VJXz8OE8ax0rD1mDo8hgbPnS2RXxVGJbgr0x7V7uZO1xXiUQhC0MvpLupEdMAChF/7gCcFn8xCRDwugxZXR+HoEf4mcZyVN6CnKnPU0ofskHX4Dixhbnm5K4zMHppmeHU9XKAqH7gR4cbydnaVnmtLrjmIWcp4yrfFp8pRttJtpSFSfr0r0iTjHpPLdMZEqAl+4hfYt/3tHVvyRI7dasw7s/E25GWvnH/n8tsX8OSOTJP976gaL6z7FXdnh8KdiJEz/To2VTixUta3nrcfY/658oMeojEBnTIId+05bvENBbpeAXi8eDLmr0D19CF2cAG0JN2594Xe53Knk=;5:j/a956EuyyqjjOCPwt2GRzixlX1j/0osraIpeY2Cg6d8omtZov5HuPVPRgjtrLG2Eh4mfOZY8dOgTGivFEshEEEtA72NfXQmySM1neKy1t/wsgwuiw0wcetjZh2BH3FeAzLMm0ZKUA/jFVXK/R9MMn+tr8GkFgzh1NZDBMNic14=;24:6utbib01DN41GKn8PdSt9TCvII9IJY5bXavXgMrbm5X0iMKaDWDcQJZQ6Nu6sarWMxqkw7wIytNOxM/LIpODLoMWu7Xusrba0gHRSyCbmYo=;7:BQddYGipKyaupfru6YdTEiHFTFTFMmJGJDzmfhQ7i8V+Z8SFKjIjN1Af/Jl0axZJD1LA6suJDxzLhHFgJPRdwWjeFCpHrxQrIxe1vEL09jB9aWVBXKBruir8M6idaAi5+8K7Jk8zjMpnSE/Zk7+DChtSWGdUfo6cBGvJ8Je1/6g7peHl1S3uvrnL0AtvQqQXhUS8FgjoudqYZqTrjGsMjdS9Rclzq71pVQP8R179D1BjAyBnNPcBhfcBXfiMvMru
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 09:32:34.1674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d151e15-7917-4c1b-4d0d-08d58e458391
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for PCA9641 support, convert the mybus and busoff macros
to functions, and in the process prefix them with pca9541_. Also prefix
remaining chip specific macros with PCA9541_.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index ad168125d23d..47685eb4e0e9 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -59,10 +59,8 @@
 #define PCA9541_ISTAT_MYTEST	BIT(6)
 #define PCA9541_ISTAT_NMYTEST	BIT(7)
 
-#define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
-#define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
-#define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
-#define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
+#define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
+#define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
 
 /* arbitration timeouts, in jiffies */
 #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
@@ -93,6 +91,20 @@ static const struct of_device_id pca9541_of_match[] = {
 MODULE_DEVICE_TABLE(of, pca9541_of_match);
 #endif
 
+static int pca9541_mybus(int ctl)
+{
+	if (!(ctl & PCA9541_MYBUS))
+		return 1;
+	return (ctl & PCA9541_MYBUS) == PCA9541_MYBUS;
+}
+
+static int pca9541_busoff(int ctl)
+{
+	if (!(ctl & PCA9541_BUSON))
+		return 1;
+	return (ctl & PCA9541_BUSON) == PCA9541_BUSON;
+}
+
 /*
  * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
  * as they will try to lock the adapter a second time.
@@ -181,7 +193,7 @@ static void pca9541_release_bus(struct i2c_client *client)
 	int reg;
 
 	reg = pca9541_reg_read(client, PCA9541_CONTROL);
-	if (reg >= 0 && !busoff(reg) && mybus(reg))
+	if (reg >= 0 && !pca9541_busoff(reg) && pca9541_mybus(reg))
 		pca9541_reg_write(client, PCA9541_CONTROL,
 				  (reg & PCA9541_CTL_NBUSON) >> 1);
 }
@@ -233,7 +245,7 @@ static int pca9541_arbitrate(struct i2c_client *client)
 	if (reg < 0)
 		return reg;
 
-	if (busoff(reg)) {
+	if (pca9541_busoff(reg)) {
 		int istat;
 		/*
 		 * Bus is off. Request ownership or turn it on unless
@@ -258,7 +270,7 @@ static int pca9541_arbitrate(struct i2c_client *client)
 			 */
 			data->select_timeout = SELECT_DELAY_LONG * 2;
 		}
-	} else if (mybus(reg)) {
+	} else if (pca9541_mybus(reg)) {
 		/*
 		 * Bus is on, and we own it. We are done with acquisition.
 		 * Reset NTESTON and BUSINIT, then return success.
-- 
2.11.0
