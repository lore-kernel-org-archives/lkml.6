Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeB0N1C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:27:02 -0500
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:14560
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeB0N0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:26:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, George Cherian <george.cherian@cavium.com>,
        Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: [PATCH 3/3] i2c: xlp9xx: Add support for SMBAlert
Date: Tue, 27 Feb 2018 13:26:20 +0000
Message-Id: <1519737980-27997-3-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
References: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (10.174.208.154) To
 BY2PR07MB2328.namprd07.prod.outlook.com (10.166.114.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53b38eb2-40e5-4e99-deca-08d57de5bfbc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BY2PR07MB2328;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;3:dEcDCXPGbDiacPCuzsJNmlf4SyyB2pFncMXjTebqVoLQPTWW3vJc1bBOSsmZIbuHsFB2IVtDHe+zGBl6oGEdVHTONg4xt42BRELsynYjYblzHa9N9QjUlr+dQR5LZI6QuLqOAVxxDiLFn0Tx1Ij0asPs9owv35UC3pxzaVFroRX68ImiXU+DOtAhosiAMedM5ApXiKChq/SC6vcBxGCIcU/WRzepIL6/wvC6OjN3LV2FbMtIhDJ2BKKS7dIm6wkQ;25:uWoZJydOnKTV0nQzLDaqdU2Uf+pbriedCFfNarlGnXmfoHsJ07r1Yt9VnoJHCqrzWdizYnVAT6ctXjY0GnblZKio1wBa1ZwqGZBa7Jl0pdrV+9cNF6ugIPZZGF8K4KeqP44cTAOXxvZuiwmuaTejj94ADJUa3bvz2HqCgdJ2WcnB2+y5kkIFiRGZx4bAGgBo4PKw3BbTIWEOtp290RLpMHTjBWPfy1vpbA4spa+R6chTDIronlRcEjjCn1xQdQ+7w3qlQciKH/UjF7x7QbCUff1kpDPoBGKWTEqrdPJ+UHGv0kwV2VosPqypwXjs/IYsNuxmoj4bDoFVkoibbZ5OXA==;31:q0NdzSxsernVqhjdQ+6IuKBHfKXobIUgQNBrMBxUoTfgtIYj45QNHGuKpY94jpznyPJjVom2Jtci3a3PKpYiELV3AUKF+RGfeuJe4wKVFBJazrH4f+u6zt6nUajPVL9qgmjoLKqAQ+mk8XaWS2oGRuPbMrDN1jfrOkBG5zK29O2lAHKb1b4W+fwSdYczQg101pNpdmRqnzT40DidkGm6rXXdAREnHKW2UDV1fjncTa8=
X-MS-TrafficTypeDiagnostic: BY2PR07MB2328:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;20:eEJ4yM15/Q0u9pNVV1wUeLg/Csxuxq0TcmGrnFFtzXX0dXyA+7tG78HKLHi4LufG9tp5xPwLy7SFILIgk4YkDbkDFSjSSm1b1vJG8XdP8UT45RIMVjnl6Tu7MFPFvlCofwe1d1Q54DcQPx6vFYV7FF9VzpA1KJDMnsX/sw1/MM+fuKE4k4RCfTbp7bHXHOdFABOHiPlQsAdoGsqexUTtf9bfzJtOCU2yJ9r+chfvTRxcGSzv3mkg4SptPXAd7m35N2qdbyXjWbAid3U9dDN9yFHCnRLGcFjJQiEWkLxfUjyd3mrt06roi4NUlkwU04kgSyNaqzMsYs8gl+l9F3Git2g9jaRejhZfEr+Cxw5uWO/z1XD22rUCgqZF5MnxGaWgOiVFiTw+z7dgnc4cQO7eXJTrWoPHGre934/SU4TxIfRVy6cdzqBZ7k69dT6U7xBb4ERcodTBNfWaZF8yIs4cH6x1nsUm4yoBuKx4JDfVne5yRD2w79s1kf7xx5zQbI2n;4:CKIZ8eHV+/I9sNd/MjpZTinfoPMDLxxn5HQJuDiCecwmM00EBAEOvQu3Pwl0jfYt2AoM6sqIDX7Amrk1lEQryuU7l97aAwQqTgVz+1cPeW94BwcZ1IdkkVZsZKef43+ZSKVUhm8/f6vyqWJ241K7JwFi32IhCkMmjfHlJWYofCIY992wKjafPHOHQx1Cm/hnySQC4n2EN7Rw7Bglr/evzctmrgWT0DrnPKexLNIFrfWF4/kaGh5saFlyZNQhIDm24hO1+itpKAPdVj59ezt4uA==
X-Microsoft-Antispam-PRVS: <BY2PR07MB23284666DE0CC1ED48ACCF35F9C00@BY2PR07MB2328.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501198)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR07MB2328;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2328;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(199004)(189003)(97736004)(51416003)(50466002)(86362001)(54906003)(48376002)(36756003)(66066001)(305945005)(6486002)(7736002)(53416004)(26005)(386003)(68736007)(16526019)(478600001)(16586007)(6666003)(76176011)(72206003)(316002)(52116002)(4326008)(106356001)(5009440100003)(25786009)(2950100002)(107886003)(105586002)(186003)(6506007)(53936002)(6512007)(6116002)(3846002)(5660300001)(81166006)(50226002)(8676002)(2906002)(69596002)(81156014)(47776003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2328;H:ubuntu.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2328;23:ck/BepZv3zWVaGlmv3xzBRfpqM4uwKhVN28DPYzdR?=
 =?us-ascii?Q?cU+RFbgnyS3dZB/9HezXSQ6cEOQ5s3bf0tVzYm+9BoUx9Vs+PsyvTE55G31G?=
 =?us-ascii?Q?zdNnEBlIKTwSGU8ZmC4AR3prVOxtIh7vvP36dFGgN4u7Aa9AYlQwK3agoRTU?=
 =?us-ascii?Q?AsJZMvX9kFjAmxzSvba9h2gzT0MFoNA0VvWJYTA5pn5s3OFDX5FAiq2xXuZJ?=
 =?us-ascii?Q?kW+snA8LEHBz2Y96MBbtIdB0XO3POu0bp6UIxOPetT4nY/b3qxIxWhJfT9Kp?=
 =?us-ascii?Q?5PjNbYEqweTGO+JvOeUJtzIppza8w0ZhecjXxYHYwWFEV+dxBKD23EIWZi3z?=
 =?us-ascii?Q?/266Qcnq6r3c7uKYYx3w8zszr9Lgm7k22RN2qa7/NWOV4+dGODWYBkg8Z9cu?=
 =?us-ascii?Q?DURLcbUNFg8/z8U644l4SK0s2KAOF1H2uEBg+Dxbaeslk3HwrUWVmae7eDkZ?=
 =?us-ascii?Q?MLtv/v2t2FYoTvLj8WAgTVaELvW0vQl1HETLo7SdFQnAUEUCowXOmPEEZzpS?=
 =?us-ascii?Q?sls0uHaDQMr4kPG5nA9bWAjMJ0kCrptAptUUV/FBWNkGWJEzuUx+uE0J1hfT?=
 =?us-ascii?Q?V1WbacpysiM7ksvoNAep65XoaeiXbdLQ/4hq1C8YKfsn5Mbh3otft7aerhx3?=
 =?us-ascii?Q?Tr+VwocfX28+icyMRowc2FkJq0h6cYpeBLz+f1figgL7J7qqtYUPk3Kc8zzq?=
 =?us-ascii?Q?nVJdsomEH+6Sthq6G/G0ligYuu664qxs+6SRFqk7EBZJQiU8G2AHhCO4fQMM?=
 =?us-ascii?Q?5gYy1/mGNXxoxSqN07m2eN8Qkb+Ro5dmTGVaX+j44lAyDN/r3XkWUx8gYONL?=
 =?us-ascii?Q?v6BU15i6cPtiM9hVE9ndxG7iXNCzutihfcu2zLEvWN02lDLDPdAqMAt0SAKH?=
 =?us-ascii?Q?hDTZ5ozoPYOcbvJpQ/rSJ6lRJDU8e15Sq9goPbcbTGdy54w4YpTYcNhnDpFq?=
 =?us-ascii?Q?c6rwPfP+fizSKXRNhVjRiJnsLY0zJEbnAdyjns09izLzwC4UFBG/QlPLzl9E?=
 =?us-ascii?Q?MRevItMDirf2cLDv6zt572VnMZ+YIuxCGbGbYYxPTbKZyrjUrFjNWOJGlz1t?=
 =?us-ascii?Q?hlyFkF09kXFlEQ8eJEr0aLXTw6fzQcIEjyTb5Jvcb/sCv+7UlJYA9A5L7KZZ?=
 =?us-ascii?Q?0kd+LJUj7P2Zy1RAc9a8NhhrOJC95c246kc3uo8T9wEPnmpTHtaOCUSFo/Os?=
 =?us-ascii?Q?dA7F+7WJQMKDrD/suNGZPh0kkaVuJlf5KpAS9pkvPj+psOlZCAP900ZbA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;6:qQ5AgB7r/uNLwqSCDgCUodoRq8uxfbyFTxhyq0mkyroD8/ACHDrP6ZCP+cBicDQQNYhSduG7nhxEn6NQmlsxuhhG6Zm80ZYLD7jtVimPmnaWwbyvwwgYB/Z75Y8arnRrcvRUzhAjsRUtcMnbH49e3gWdDUv5hGbAqaEgfrJw3/LKPJcZqksF8zCACOSxThRea8rYyRxiydh8q2FT/0vYK1CALQZ+30GwLKhmDnQj8/L+3q3gNbbGzvNISNbr3fwKswynnTjt4jVguPFKQMND5u+4D9hvwVJ+vOZ37sZsdO+GRdNxxsk8CiC2Iwa5ADzgp8gwaS9oFlGLRSrD15j5niOND8fwuMrRsTPW04YFQV4=;5:zLCHPG5nsBi49QqAR2GWxkFVXZgfkG6xn0m022QXfkF78Bvb92Q5c5KdWp87tc42TffxbPnf23vHd6hYl662raSrVB94h9xkDtiVG4+VjCTTR2VDvZoDHtWBOocYF/RXSwbH6fFrQLDkSnIug6NgdXoK5KuKRSQdYiwDbofvqyk=;24:+uifslQqzapcGlc49sjol3ICuS8opHbkyIDQhzxQ8JhJiKUEOfNl04hJlEHhpYJ2YquVZfTHDgk2IeXvO9k2gafRwKHeQjRedNA4jVq0LpE=;7:hG6sy21MLZTlPdo10HAvckzCc/qqGfssd+fcrUJXpUwq81FcqxYh81UFQ/5D1o5ON8vcIGPr0VjiPzRBpRyTxGW8YIVWxpk6xUkf1RLN7L11JK0idKjpUzAmKlhPn2QVgONNj8ACVYY3CWJyW9f94J9VyuyWllIMyxN/sbZdRoSu3i8jBBTU+U2IrOz5/20uIjCkCtGlEW8bKYrVrVSOQlCjxx6P5B9h1fOULFcjtoxobk5Msb57bQvxz6vcExU6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 13:26:44.1382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b38eb2-40e5-4e99-deca-08d57de5bfbc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2328
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SMBus alert mechanism to i2c-xlp9xx driver.
The second interrupt is parsed to use for SMBus alert.
The first interrupt is the i2c controller main interrupt.

Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index eb8913e..9462eab 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -84,6 +85,8 @@ struct xlp9xx_i2c_dev {
 	struct device *dev;
 	struct i2c_adapter adapter;
 	struct completion msg_complete;
+	struct i2c_smbus_alert_setup alert_data;
+	struct i2c_client *ara;
 	int irq;
 	bool msg_read;
 	bool len_recv;
@@ -447,6 +450,21 @@ static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
 	return 0;
 }
 
+static int xlp9xx_i2c_smbus_setup(struct xlp9xx_i2c_dev *priv,
+				  struct platform_device *pdev)
+{
+	if (!priv->alert_data.irq)
+		return -EINVAL;
+
+	priv->alert_data.alert_edge_triggered = 0;
+
+	priv->ara = i2c_setup_smbus_alert(&priv->adapter, &priv->alert_data);
+	if (!priv->ara)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int xlp9xx_i2c_probe(struct platform_device *pdev)
 {
 	struct xlp9xx_i2c_dev *priv;
@@ -467,6 +485,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid irq!\n");
 		return priv->irq;
 	}
+	/* SMBAlert irq */
+	priv->alert_data.irq = platform_get_irq(pdev, 1);
+	if (priv->alert_data.irq <= 0)
+		priv->alert_data.irq = 0;
 
 	xlp9xx_i2c_get_frequency(pdev, priv);
 	xlp9xx_i2c_init(priv);
@@ -493,6 +515,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = xlp9xx_i2c_smbus_setup(priv, pdev);
+	if (err)
+		dev_info(&pdev->dev, "No active SMBus alert %d\n", err);
+
 	platform_set_drvdata(pdev, priv);
 	dev_dbg(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
 
-- 
2.1.4
