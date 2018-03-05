Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeCEU7D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:59:03 -0500
Received: from mail-eopbgr20139.outbound.protection.outlook.com ([40.107.2.139]:59010
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751275AbeCEU6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:58:49 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org
Subject: [PATCH v2 2/2] i2c: mux: pca954x: verify the device id of the pca984x chips
Date: Mon,  5 Mar 2018 21:58:22 +0100
Message-Id: <20180305205822.951-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180305205822.951-1-peda@axentia.se>
References: <20180305205822.951-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:7:66::12) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6ad6f43-e3d6-4e7c-56b2-08d582dbe335
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:8uq7CNPFa+cUO5kwSk/jk50WtoV8fAQ2uwdlq02HoGMbDRvz8bsZTStBcKInCd4VEVkPc0fA4EI/7e8eUCfE3PpblTU4kwBQmJGoTNG8TI4QQZmbOKfnu+YYaGp9g4DwEet9UTyRTFlFXX2rSGO/J+n3sLmjhpp0tvqytLbfFDYNvwEheFKZJSIlE1jQGCD6prGbkp00lFcLq6oOx+4Wk9Aj3Df56a+Z3BUDtGOyhMAr6FI81O7sPC7jaDEqcxDz;25:a5K+G/M8codNEpsPa6vEbk2a27TJmJvcOx/qMXmecbcicbhiM4jZfKNVmN3Imnp3LKZXY116mZK4UvUpyU2zzFMGe/WkJ1tm1E+2k7KSCrdkEVfpm95bloxmMpz/mRxyxltWIktSQwFLdWA0FsOZUj02arGhEd3chNZakIyFc+fjq5xuvN0KW019pjVxPlRizXiMAOrHgKfRbqdE0vHoGil6XHV7QkBA8mSujiZB7VKBZlVRZKU/FV+dQ3qVBD+xlGNSNMdNEGxEY0ogniDri447jcmAUgvqQqkY/g7lacQ19J7x3DPnZNsqFlGbsor/KCqlYdjGOQKkxYqLuKRptg==;31:N4MQqlGoXBA8Ufk5RZnwD07nFa1UU/ErL3tBiZHyhEUQPOmjb13MyqSt/raExIpcPsRStOf+Ko34hQoYDL4m/HE9LplnhybTPIDk3J4uOgJeyuOfzOmXjIx8pUsZ2WDBr9g2Qgz+YDHbg/pTsaCFv9VzPfY7+tAV8EK2Zwp4a85lIX63kFNDhChnzDvOXgnxbpkEfsyyd/U3hV6iLIG0b5Cos69zpk1rmYbH8RIAkx8=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;20:PpVlq8EM7awnDQC3Go/NL1wSFQeASSQJ7nYX1bH5wYb3HzpmwSWrDenzb39LdYyI1AQHqaYw5INIeGupLm/J6mgrDK+yYYs0jffn9VFk4seGwgb/tI2O9/NpXvcAfIwppXALBk0Ro0D2EHXqweBm+Bbf6HS9kHgvr3byG3/Exf4=;4:LuRLLk68Kf27Q9wwXdzck9TpHORZ2ru3ti6ON5V12GMYsoBcIpx9l1sdjXGZ7QPnOD+GFo1ZRRXuJFdMewYelQN/ppkVcWV6PT7NMwvswKdSGxK2vBR8tAy1nkAbwioASfO/MDkD1cuUZ7En5RKfUtc2ikfu5h88jrFxFsLLqd4cBBh68pCn/oRzTyKUSST63MjqjXFBERbANwcBO9QFtTEzU9APIn5J1B4MyIhFY251uRjpLthcJfWIYUQesR/ZF6c9Tq+hZy+Q7V9Tgw87IQ==
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27778707E6F0D21EA0549BFEBCDA0@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(39380400002)(376002)(346002)(366004)(396003)(199004)(189003)(59450400001)(2950100002)(106356001)(86362001)(66066001)(6506007)(316002)(47776003)(386003)(68736007)(15650500001)(478600001)(4326008)(5660300001)(8676002)(2351001)(7736002)(186003)(16526019)(305945005)(6666003)(25786009)(50226002)(26005)(6916009)(8936002)(2361001)(81156014)(97736004)(105586002)(6116002)(3846002)(74482002)(1076002)(2906002)(6486002)(36756003)(53936002)(48376002)(54906003)(76176011)(51416003)(6512007)(16586007)(81166006)(50466002)(52116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2777;23:N8W1KexuNyRVdSkkSOjc+xD8S66kj/FAgp21wOo?=
 =?us-ascii?Q?jlcQG2E1DVC/KFrwst1jJgEm501pJ60+ulD/zBI5vzbxyUlN3M12Zm0AgDI/?=
 =?us-ascii?Q?p8+mcv8HgjlCzyov3XrBc6V8ZxtB/lRbXmQbdAML5KFeoeoeRjGeEZAAqa0O?=
 =?us-ascii?Q?uTo9pQ4J9lpc+ZqB4gwuA2PROw5tLItC1dAA0jM7wvPHNhLoXyPIjUypgcxb?=
 =?us-ascii?Q?8Rt6DxHL0fymZmBpSneqrh1Dr2j8S2IxHjr56AKNQRNy5vNFEOPR0L+1SEmD?=
 =?us-ascii?Q?7u3T+xCOWDbOcvjDD4SoG9Z6ULZRMbTSvBv+ocYsQI4dkct8L6bDaATviMZE?=
 =?us-ascii?Q?s+TpCeuwn2K93X6kM8NdopGHc973cfH7if6tMAJzzKDw0LluxjnQtq6rVSRA?=
 =?us-ascii?Q?dUyU8rLbsanohbbA23M+00H48Ou9GJHPmfyi07Q/wD9QYCAqdqgnYXNfS93/?=
 =?us-ascii?Q?7zaU80dNnGllm4fuMCrA6xprl438Vhu1M9tB3DQ4yhXd4s2UuQciCy2CYi6t?=
 =?us-ascii?Q?nTfs3Yh/vYnNCi+GhLfkTnjPjTsA+aYFKjC+eYJpxWPxTyFfSOxgI7pdzcBX?=
 =?us-ascii?Q?zy0cQDRTDYVdyJVXNO/RY9UhydOuXPfQZ7vOc9acv62fx11Mhk1lL6saFEYo?=
 =?us-ascii?Q?u2pS15vJc94p91Y+/KLzWlWcQwzt+xyjg+NuZJ7Wo7a1rg75RywYN51DX0NQ?=
 =?us-ascii?Q?dYJJbZj+syWa7GnLS8yFMbFe5jjIoDRTqSqbGEWggDDOvpa0ffKhl1nFD8Tn?=
 =?us-ascii?Q?jH+/OUuEOmQOuN7ptB2W3Y/NnjS9ZSphuPJVadWvhg/Nj57fWvyC2eFbE4Hz?=
 =?us-ascii?Q?nXd6+IxMBg2506khpLR2Sxf8v3Yyd5ngMojKYRvfOxTMS/VzUeh7ZYzx5VFO?=
 =?us-ascii?Q?R8Fi62XxMfdh4r7AVD7fHYLZC8m9jVhqauazdGDPXpVn6R7r1t1yreqIkP3R?=
 =?us-ascii?Q?10HYPTXn4A2ntKNSHItBhMPKu0z2Uo0YqaUf2aRQPTIhKSpUNt7J6Uqd7zMu?=
 =?us-ascii?Q?w1QPKIdPXU21e1VWq4wBzDsfktkLrUPprcWIm/Eh2959ahJ676QED10OEb/g?=
 =?us-ascii?Q?gWpUM+u7a3QdaO+W8Jw+RigYB4Wq688dZTqXx95pJn1TSY+oo0EvikjXEmWT?=
 =?us-ascii?Q?W/qown1QVSuu2T5c7wwKvCCqIoM80PQQuhyX57tQVK7CVmRd2mT5aLE4ohsJ?=
 =?us-ascii?Q?E2VHWhv9GiFEpTvgLWn3uxOcgI/GxleX+B2vLzchRT/OHgETgk4LhQU2uzWF?=
 =?us-ascii?Q?X76ep6tZQIbrrTXGG0PRSlcEghiRGkRqcqgqADmkO?=
X-Microsoft-Antispam-Message-Info: MD3x58MNU+Kq91uOPWD9zsGfsnw81KlQzJ8ZrqQZGPJqMcJRt+6++e67MBBclouI55PgGScIByQL1J2pHzi54hLGKaaibseZEFRRzHbhiBKNOxhJ1l25bXPYj2JnKITb17OlTwFLfNsii6DdIYJbvaXqOU435wrMNZdLIR5dMg+bNjuMMLWQ9otVYX3C2C4B
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:Y2s656B0mLAGDox+V8T/hdVJzM/qCIV2s2sBSIMGRumrBjF05KevRevG6cNFx0zAgSSBMURr1oafFYIIWCfQG2r0dfcFMjmicwAUH37T4ywegtYzHQDMvt09jNVVHkFPOo0uQ6vi6eKHBeNVc8TAUHqsKLU5e/CEId1lhLt5w62foCIvjT69EUHzqcgsZaV3Vi+ftFBqmrVbbspXiIR4CY9QxtsaWqCin1mXn8REzgGVRYiOKEBv6CZ3oyuJLz3/+egFe7gjH9VcDY3n3GtLv9unJFPXSqGy/kdYTLrpENq8AU+le9S4l9SfY5TqYJ9b1F10Fg2SqBj0Lhce9l+jJH9ScmAN8c3liMRhha+Xkj8=;5:OZnLYP+C/Tce5gCLyv1Jb3iBHmoK8AkyWdk/Y+qLG9s/tEMvbNJQx1/jAhtL0ru++iy2PELLIZs5LMX//kL5jSZBanZ/VsxLda2oPWY9EltsbCoth2M4/H1UXIMqPqOVUebpeN+2Hs+OnPq3tLL50gO7bv+RJOd/VeqLofgfXlI=;24:IzuFeB+Ez3OSvOkMPS3y4WpBgGhuj1Ump3bC4Rb9q3qED0Jorum5kH6NIYMzL26rQhrcEmaObOG5mKsoADkg88WFqFGJ2eCvVPO4zKl0yPc=;7:PBlZqatxT9R8aKgsJZ5C+pMT/OelvyzArezg0IApWWeySvVo+QjtW3ORjr4Q1rQ27C8jdzYD585/+5xU8b0j6Z5LxSQf261dFnv3k+Lw/5Z8iCaoCGWnBM7Vmb9EvAT2nbvpCYRnWk76rF8OdlwMJCk5y9F742Mr4+YDvHk3y4XJscXTcdTZ3mRzdhq/BmQVrjxOR/I1q0LPWDAfu2OnSMJstXCEy//kmpH/yn7EjfPNTKmQMjUMzpqSSpFu16QY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 20:58:46.2759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ad6f43-e3d6-4e7c-56b2-08d582dbe335
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to not disallow the chips on adapters that are not capable
of reading the device id, but also make sure to check the device id
before writing to the chip.

Tested-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 55 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index fbb84c7ef282..09bafd3e68fa 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -77,6 +77,7 @@ struct chip_desc {
 		pca954x_ismux = 0,
 		pca954x_isswi
 	} muxtype;
+	struct i2c_device_identity id;
 };
 
 struct pca954x {
@@ -97,59 +98,83 @@ static const struct chip_desc chips[] = {
 		.nchans = 2,
 		.enable = 0x4,
 		.muxtype = pca954x_ismux,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9542] = {
 		.nchans = 2,
 		.enable = 0x4,
 		.has_irq = 1,
 		.muxtype = pca954x_ismux,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9543] = {
 		.nchans = 2,
 		.has_irq = 1,
 		.muxtype = pca954x_isswi,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9544] = {
 		.nchans = 4,
 		.enable = 0x4,
 		.has_irq = 1,
 		.muxtype = pca954x_ismux,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9545] = {
 		.nchans = 4,
 		.has_irq = 1,
 		.muxtype = pca954x_isswi,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9546] = {
 		.nchans = 4,
 		.muxtype = pca954x_isswi,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9547] = {
 		.nchans = 8,
 		.enable = 0x8,
 		.muxtype = pca954x_ismux,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9548] = {
 		.nchans = 8,
 		.muxtype = pca954x_isswi,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9846] = {
 		.nchans = 4,
 		.muxtype = pca954x_isswi,
+		.id = {
+			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
+			.part_id = 0x10b,
+		},
 	},
 	[pca_9847] = {
 		.nchans = 8,
 		.enable = 0x8,
 		.muxtype = pca954x_ismux,
+		.id = {
+			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
+			.part_id = 0x108,
+		},
 	},
 	[pca_9848] = {
 		.nchans = 8,
 		.muxtype = pca954x_isswi,
+		.id = {
+			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
+			.part_id = 0x10a,
+		},
 	},
 	[pca_9849] = {
 		.nchans = 4,
 		.enable = 0x4,
 		.muxtype = pca954x_ismux,
+		.id = {
+			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
+			.part_id = 0x109,
+		},
 	},
 };
 
@@ -369,6 +394,30 @@ static int pca954x_probe(struct i2c_client *client,
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
+	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
+	if (match)
+		data->chip = of_device_get_match_data(&client->dev);
+	else
+		data->chip = &chips[id->driver_data];
+
+	if (data->chip->id.manufacturer_id != I2C_DEVICE_ID_NONE) {
+		struct i2c_device_identity id;
+
+		ret = i2c_get_device_id(client, &id);
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
+
+		if (!ret &&
+		    (id.manufacturer_id != data->chip->id.manufacturer_id ||
+		     id.part_id != data->chip->id.part_id)) {
+			dev_warn(&client->dev,
+				 "unexpected device id %03x-%03x-%x\n",
+				 id.manufacturer_id, id.part_id,
+				 id.die_revision);
+			return -ENODEV;
+		}
+	}
+
 	/* Write the mux register at addr to verify
 	 * that the mux is in fact present. This also
 	 * initializes the mux to disconnected state.
@@ -378,12 +427,6 @@ static int pca954x_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
-	if (match)
-		data->chip = of_device_get_match_data(&client->dev);
-	else
-		data->chip = &chips[id->driver_data];
-
 	data->last_chan = 0;		   /* force the first selection */
 
 	idle_disconnect_dt = of_node &&
-- 
2.11.0
