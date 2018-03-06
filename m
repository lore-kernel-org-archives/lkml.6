Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeCFOqy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:46:54 -0500
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com ([104.47.41.65]:61984
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932589AbeCFOqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:46:51 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, George Cherian <george.cherian@cavium.com>,
        Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: [PATCH v2] i2c: xlp9xx: Add support for SMBAlert
Date: Tue,  6 Mar 2018 06:46:34 -0800
Message-Id: <1520347594-184146-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO1PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:101:1f::13) To BL2PR07MB2323.namprd07.prod.outlook.com
 (2a01:111:e400:c753::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3416432-83ed-491a-968e-08d58371174d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:BL2PR07MB2323;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;3:kC9lMwJ+pheNaivwx4t/AyHBno08sfBTXml4gvkxX6IZTmAQ2y5bVdx9ZovxfTR7FcPI3X9OVjZA/64BLMgv8pzGqK+cqhyT/d0Pv9EiG7mZotFLyT3n+mVpKGcSUIoM0NLIUNCkgjCsAlueEosKWOCHTcPO3hXzjDCrtDgxlg/XmlVkFz+jwVMlKDMSfOJXaHecZwI/taWkRyNQXQuwRdbPIXkVPrl4iH0N+V1x8U8C+sNHFsVWJnM8+2VCcNh5;25:us5M0I0czTefuEBmOrGNVhSOCkY/iz4AVw2m8gjYeGzYREd1GVvzPpCLzFGUb28SztQul9DPFdjB925Hz7cKHcJYU+7oXFJ3E5t035vr5NPEKhlapMx67IVLgAHHoSvGsMf5tblYfWstFAoH6UIyth4ZCBOX8osRJsmQ3ycYXnI7b6TbsMkeAGI3fz6sc4bKPe4rb4qcO5589XaiQqk2g5OdIKKBEMOxahRUj7R00Se4XBpVMSGf3V9Jh+lLdYqdhDhJ/53jAm8pOJn5m9UxPrr78w43Ya9pcvbQN6jNusXJY/585Hw2s1EIxfEsb/qTHMb4EFvGAWxx42CmbkCKDw==;31:et8rWaaCy0/6bD1qm7hd4Ifxkm9T3XMPASLnWPAglDZt20iOn/538qKMqgl7VsXgbEUs+LiYASafuTK698wLHH2MsJz7FpB1cIKfCkPB0/4oYjVd2MQcor8RNrSfyoNe46FhJGcm6YAc2E937BpBqF6tsHGUOlIXOx4mMQPrH0PnU2tfyAaSREhkLy5qslZj59Anqh7aBbUsq9mYmNec/qi0i3CjAYNvAzS4gV/N2u0=
X-MS-TrafficTypeDiagnostic: BL2PR07MB2323:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;20:DiK1j/YZFYc1gWrLok84y2JBp7qUPifKcrFf+Mv0X++sPnqMomDDZdyNEpgjvVSKWdq5Y2Blg3NLD6CKj4uKtaXNGKb72o2A3vMIlIOWtV73yWdFxLyZZGCl69KWsxjcpV57JUpyOxmU1NCj80dlJnSnysHRT27ZGrehkQCQ847XROFzqJdbBA8WDhFqJQzzz6KBcGwLlmijn+VbnfZIlbsdoCYFpbx86znfVsBA5L2gILb0b6W3h5OxtU6n6/B0X3d8VtZ1mHl8jWfU6lzqAW7fjPOdmBtuhUs4TsVXawfcnXyTKqTdT1Twhf9X12Li6XiMPnp84iYKaYl34w7n6yFlJWOWXO4dPTBrZXFoRzCAj6vS4XM4gjpHmv9EAsV8ot16YKMYy7ODfTdF2/kqMuUJ9MiL3723SMGLV/l0cUQR44fzaDHbwQ4mhHDCif5vaU4LDZnXoWrlvEaJaP8D7VuD8BuKDgvx7qfty9VE4FZ3nYnK/HN6P+3fP2Ic99O2;4:CHjxgflfIJLCDvjXfFQImjg4p1v+kHrTDTWyGgNUuGVWcPye12mDIbUcJZgOmxEaF8x2bJEptAXqeYlGLTHPbzkkl3vLb279luPuMoI2wlF5/vCLT58d/GkAhGloA4DHWtFRDS31sqCWmouGzN4prqjlXG1FOrtn+/Z0lQEVzfKjq7fAulwLsVIfpIjCtf+kstg2p1j3q/1dXEpb/N6BIUW+SpkCQnwqkmesjlKbfWE1+Z6LYXsf3JKi11U4EMi1NW2SvcHhpbDDwKLSu5vS/A==
X-Microsoft-Antispam-PRVS: <BL2PR07MB23235DFC10B5E4B6442E8D53F9D90@BL2PR07MB2323.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6041288)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR07MB2323;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2323;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(189003)(199004)(4326008)(25786009)(81156014)(8676002)(81166006)(316002)(54906003)(16586007)(69596002)(66066001)(6512007)(52116002)(386003)(6506007)(51416003)(36756003)(47776003)(107886003)(53936002)(5660300001)(105586002)(50466002)(7736002)(6486002)(26005)(72206003)(97736004)(16526019)(186003)(106356001)(6116002)(3846002)(86362001)(53416004)(8936002)(48376002)(50226002)(478600001)(68736007)(2906002)(6666003)(305945005)(4720700003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2323;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR07MB2323;23:W3W/VPa1yLV0felFdKuX58nAswfoMpbsmP/81bzn8?=
 =?us-ascii?Q?DQAhVi+h10/B0RBTEtKCeEf73+Y9n6IawjhLdD9JjRvdi2zu5bv6V1uu83Yw?=
 =?us-ascii?Q?dleKuN7VtCUHuiVkDcyqcc9Dm0haUe8Yv+CRh0JJ3voPldGrKCzzkGv7gpbG?=
 =?us-ascii?Q?E02Zuc6xKqGjaHD4sKDzNEP1hurxZCs1jl88YfImSykONdNtVg7Z6dDeF6eH?=
 =?us-ascii?Q?SHoSdMVqvgnWLU3syQysdPrIpxRWHJAItJjQozC4mcFNBBJAjj1GaC/+tUFD?=
 =?us-ascii?Q?0al8G0NU36VE8oJz7B7PyCXaD48WHx0VrT3BzbQQNwzRG8KHN97XgQIpGHB3?=
 =?us-ascii?Q?1A5fgQx4lGbuTRmPEBRk6maZZABOnDtbiqdD/CLTGnlABnS9Ppe5+mlvRUZL?=
 =?us-ascii?Q?oy+nSxBaQnyN6m19YCAJHTiH1w8hxtQLe/HQ2hyXFcwXJzGeVBY/4tYzMteq?=
 =?us-ascii?Q?ayewwl2mx6qAXRJcim5/6JIYWELOuqq80M/6TUWlOaT8UZJcfkd8SNGWiTav?=
 =?us-ascii?Q?9KWDfk7UHa3MHkODo1T7g9gUsKPgH+6+V20LvSWQXobnXyjG+WrdRzZBc+GE?=
 =?us-ascii?Q?ipGohRRfVPc4zpKqj5UCfK81c8gTf2d1uUs++s6Qwtw1iz2GF3Q2dJnqaOiN?=
 =?us-ascii?Q?a7R6bc+ls1+fLIo10qGWSzA6vyVAsRTCoWjprJAcwFBUxMLvG1xTO9Qgq8Bl?=
 =?us-ascii?Q?R+wkn68y1wrEUEwE/SD6srywpP2jz08C3ZleEaDqSFDcW5pnFEO8FWzHEx7x?=
 =?us-ascii?Q?kz8m0lTF6DGSmsYquJInreduJrduwBez+LK0S0K38TX2nSfe7XLJ0xt2gbEZ?=
 =?us-ascii?Q?xSFSmmbZmTIXPPPkBnTAphDKwhyBsGXyg+OH8s3/uo+dDxqK03p0NEyWbluD?=
 =?us-ascii?Q?ieBvunEcJW5/S4GwWSAEJckjmdcgFFGDozXm5LDcHhUlbY3VWra23jjMa+lK?=
 =?us-ascii?Q?r6hh3M7qoQ/ulmbXwuLgxX2VpgxxvFyBJC7FvvqbFjz7zUmiry+mij/KX+54?=
 =?us-ascii?Q?qwkOUVw1jD7FYjzUAQjEy/JJBhO7w9UfZ/BIsvwUH4SxVspD53ufeDfNCOWo?=
 =?us-ascii?Q?f1KWh7SLyJw628hNu4+g6xj1dkf00Ial3j6rkBbe/uMuc58/lV9CvIflyEiF?=
 =?us-ascii?Q?3tkiI0BPs8iWqZRDbtq5drsEheCITqLJ+6XEn7QX1u1eubLLrpJXQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: iOl6qtkH0n7cUvIw5zy6dlWtLJVO7x/HxVymwh+go7fsC8TIk8f+E/soCD583WVHRwO676bTa0GcNQ27CQ65bWWNqKymruXGk1WcdX80xayClCFzdgqhFDLHfllm+DQ3hPRW6RrwCjFq2YpZ46UwM5vgz6fKSiP/JwBa0kPHhgaKkMEVcMgvltw8TlS2AOVe
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;6:ZG+eGLooljSVpOqKxg6imY1B6gvIrNYM/s4EvAHT55WiYeqwcntPrpaAE2omF2z6qChEd57ATylL5qq4MAfzcShxgKX6ABxo25NqLd5TJsmCEuN+X3EdGvTUEY3ZWTfurQMSPlEKG3D2Bf9exDKSxu1VhYbCbO+DmxGttqUFr12z5A7QycVYmM9wPTT6LCM4bUO3db7ktETF+2p25ScFOhIxd+/XFiWyLvajytvEHADwXOEU97jUjWaRxGozT6sPKvlRpkggPNKdQCFBGhr0li1PQDQ4ecQ7cSegZ9BiiAwHDi22R4yq140NodbKkRoZCJzWZ7WhS8FR6dDv/gpFdxm95ht/C038IMmenjWymSc=;5:xDRaMFKeo3g8wsYoeQFAZMnYxA8F+yvFSuan0TI8ua32p7U1LGdcFdBN825k8o2Qpl9/Dt8Ckmss84ydS0eTSHzWmM5aWqQ1vWg7CVsG4pHG9j3HV1QQm6PEdKt1NpaRsVWupaT+O8DNyLDd5ehXqRBq8gDwewZO3gts08Yq+BM=;24:azc4NlqDsEMkmpu877Rs7eVmdDPc3U9rUT2lvjwBfzEKdGAGeP1gcFcnoXzEkmPOQvMPkKnYsgSgbC0C6R5x5EQaxz/kLB5w3FyTy1HmqqM=;7:SijPgmwnT+cDjx/zwa7Y38GKNMmc8CCmxTd1rdVq/dmUXoLHLBZjWn1udQaUOkc4N36ewC5eL+UEisgdrWTRSPfX7NsqyXGMXwpChb1iHtuDxKdnDP2LhRbI9RvDqF71woUkeeGEdYU2rorj7jnw3DrSFJJ+2qDy1D0b9QkxTOXE8oHtYWb2pEwgs/VniKPywH0dPdLyDeIBaL3I7uVrbwX6x1NHzS+Su7KQlgBhfNZnFk/BZkb1pyCB/9CUAT9r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 14:46:48.1578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3416432-83ed-491a-968e-08d58371174d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SMBus alert mechanism to i2c-xlp9xx driver.
The second interrupt is parsed to use for SMBus alert.
The first interrupt is the i2c controller main interrupt.

Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index eb8913e..d5cadb6 100644
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
@@ -447,6 +450,19 @@ static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
 	return 0;
 }
 
+static int xlp9xx_i2c_smbus_setup(struct xlp9xx_i2c_dev *priv,
+				  struct platform_device *pdev)
+{
+	if (!priv->alert_data.irq)
+		return -EINVAL;
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
@@ -467,6 +483,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid irq!\n");
 		return priv->irq;
 	}
+	/* SMBAlert irq */
+	priv->alert_data.irq = platform_get_irq(pdev, 1);
+	if (priv->alert_data.irq <= 0)
+		priv->alert_data.irq = 0;
 
 	xlp9xx_i2c_get_frequency(pdev, priv);
 	xlp9xx_i2c_init(priv);
@@ -493,6 +513,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = xlp9xx_i2c_smbus_setup(priv, pdev);
+	if (err)
+		dev_info(&pdev->dev, "No active SMBus alert %d\n", err);
+
 	platform_set_drvdata(pdev, priv);
 	dev_dbg(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
 
-- 
1.8.3.1
