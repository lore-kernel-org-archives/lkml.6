Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeCTJcu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:32:50 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:60830
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752431AbeCTJcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:32:43 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>,
        joel@jms.id.au, linux-i2c@vger.kernel.org
Subject: [PATCH 3/3] i2c: mux: pca9541: prepare for PCA9641 support
Date: Tue, 20 Mar 2018 10:32:00 +0100
Message-Id: <20180320093200.19179-4-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 18b92142-38af-4cc3-5045-08d58e4586be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:7VSC4K8X0xYOH16usYVhWLv6hobawDAyDTZtRBM2xaWGV2SyMKKrj66la6MZ2rwGqTlq/7lcl2tfcRreW1xg9cfW+mHeohakw3eWOfvl0Hn1ZXzryj81h2z5QpZaI2LCk4a3/jsOmw/brEURLS79xoPY7aobbFvaWpCeK2BlI4CAxL9OthCYW9pTHZDhcjSzb1NkLnUnhSRg6v/MrFF/82Qi0i+4g/dMNo/KLDzOl7zMCuPtdi3q4hToxUX5MqIt;25:dmbSDFbS3kt5prbPA2/lwiiBVlNpq3TpjN3D1FXgD+h4M+jI7pWx0ytIAPAdafuAKHwLxdTg8hM28/tFDnlx7sJeRIiYj0WN8MJEC1z7IM7YSy7/E+HQowZUHvAK8S0E9PyiskeYB3i15aHHbN6aLsgsioJY8yA0Vb1XUFQr2nHCRpHwC+1iiP/OGY0Lqn4Ys2imlErc8blvA60jWstaOBp1jgTqQGGz9fbvez921YDzEknMMyt9viaM9qIkf7sWMTksgD1qQD7WyKWN8+WPLJbm3PB7E8ID31PiBoOWpwG8wFXbw/6BrxhDkbjOyJPINslVuqjZAV2h91nkgvbL2w==;31:TUaUq+W6wyxZFAr2/JET/edMI78v+r8EssGDNYOg9NgiOEPn8hhn+4vvnW9YCoZ+TPBhDYqcD3pdrnRGxxjuqFIfyrm29O+e8Cz7NZX8eVJ5c1r7cbP7/WAwSTpMkd8BfLCWEdDJvBYmM8rEDX+lJzA1zImIhQAr6dvbE/cLGq1nwVYuWrII0VAEWUGDr90A2UBVca8jVoRQiylP5WC+Gl3L6w1HKSlyUWuxSypf/vI=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776173264C0A0D9871C8639BCAB0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501309)(52105095)(3002001)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:9MJJrCIi6yrCElLe6esqBI5zBqnLpYefa5Xlrph4uZ8cCmjniv86VxW5naBt3MdFXzuCw3f7gOZ4W66KbcBD0i3reDbwJDPF3Awf6ggfuI+aofdov4gnvGttJ+DA/iM3l22rLY7//1C4K8VLzjGIDkq8nTHap1gTPhQNNZg1QmIrICmAQKfN5FDGiXzN1ch4e7Go9JtTtvFxQ2V3wpHJU4B13Hip7THoDFPsGOLHz4mYWEHlpaVS9WkZgMIxIEdkVHdszbFx6hSI16kkSSMtNrE23/s9kHE2hlNSLbQkx/RTPaOnsGZt+gBh0TsnVQ5J
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39840400004)(39380400002)(346002)(396003)(199004)(189003)(8936002)(16586007)(54906003)(478600001)(81166006)(2351001)(6346003)(3846002)(2361001)(25786009)(76176011)(106356001)(8676002)(81156014)(51416003)(86362001)(6506007)(26005)(575784001)(316002)(386003)(186003)(16526019)(50226002)(53936002)(59450400001)(36756003)(68736007)(47776003)(4326008)(97736004)(5660300001)(66066001)(6486002)(6512007)(305945005)(50466002)(7736002)(2906002)(48376002)(1076002)(6116002)(2950100002)(6666003)(52116002)(6916009)(74482002)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2776;23:EyCJrXXrguiZ29uTKRXWBwbrjVTk2PnDDTXWxFm?=
 =?us-ascii?Q?OnF5Xt4q6G67wpJWL0qugMicx+Iisb8+6IgiPBAsj1m4OtLv6HrHmez3dKa5?=
 =?us-ascii?Q?k6yfQNpE/Kr/9sFd1VNN7pb1HiuaKGOgBp8tGdpSEfdpFzsckA+lYY1q7fKF?=
 =?us-ascii?Q?pyaHC7ajyd8+P2j4jMD/hjS7zhjEPySpwscSiocinRv0rGRD7HFf/dVTntcM?=
 =?us-ascii?Q?EL8y56ftiQnpyOQXxsgJAaa+TzBgM00SgWHlb94X4asPtYss/kHkO9irRiXz?=
 =?us-ascii?Q?5ICBDkl7DPcrUy6pIfdCrnGK6diIgDUN80dmrus5kd+w7JepYylTZmZX9Vv0?=
 =?us-ascii?Q?jFy91/Wx+vAmC+53Qwg9xBa3aESEp/v2mZDWOQKi50zNZMva//k+vuwJBKVW?=
 =?us-ascii?Q?HBmja80obi+dQN8gdMu8cgBZPvvpvZHitxANfuRR7b1u8ZA9MbGpvkEzCMLF?=
 =?us-ascii?Q?54xen2CM9x3Lugnx9k6Yh4RZV3cP9qphTstqdRrhh82SVUgf+FimYeIVFVUG?=
 =?us-ascii?Q?TLK35saoe/NsCDEo+1F2qJsLtz3FiL4szNE4WXiAMjODEAejrQKQdT38C/bB?=
 =?us-ascii?Q?fKnpCbquD/G/LLTaWu03PDuK4s9Gsc6iwyqizxP97R8brv/T1x6rK7a0zXjE?=
 =?us-ascii?Q?Sa577L3O2R8/5gAxOykzBQhHxDP2z/0ga9oURphnKHQYTKEJYieNqJ1TLqCB?=
 =?us-ascii?Q?S3ZUnkmN1Z53QwrWkPpcJS+lkxciU6wkczit5XMdDc8SKipN0kyReFHYoY62?=
 =?us-ascii?Q?ukOWXlVoZLirytHGypcdTnGUGJMsyjH2cv1kolJfx9rlHcryYd2bqykByZUh?=
 =?us-ascii?Q?7+kc05ebxM67um8nIU3h961Pe555byZ/eV6QrH6WieBNIqBUlaNsTv2kCkLs?=
 =?us-ascii?Q?xcoxeT6L8Lt1Nj2gigKuQXS5xG1O1sPfEvRiDcI7blqmiFygMJVyouxqN+70?=
 =?us-ascii?Q?YyAcHSi66wQ1YqwcZ8AofBERDo93Eb4ReRzruX0UkMXVR4dylXNdYYbdFozz?=
 =?us-ascii?Q?daGfatPEc2XBx6zrPfr+9C5EwKMZvL8dRAMbFvpZ3grEqSoYQRn9oIbmTbdk?=
 =?us-ascii?Q?jYYWSieKim+/8Iem0xka4FxmYDri7Kx6kaw1IVNRxTcUVsICsbviy9e64E3Z?=
 =?us-ascii?Q?bxNJctBENvr+Ek6ae/VSseyplhAfTnZU4jfdiGQGez+LshqoOXvw5Kl1QxyM?=
 =?us-ascii?Q?JLf2qeAdexOl3qIKLaGMg2oteesA5xYCyNkLsuq2RgbvIZBsYrBNAuvj3uYe?=
 =?us-ascii?Q?6cQYtYhmCLMVLcoDwKDkLPwfKoX/P4ntTXL0A72KA77utAEWVP3BkvGh50dZ?=
 =?us-ascii?Q?z0w=3D=3D?=
X-Microsoft-Antispam-Message-Info: IujXv5QWPYvq51ZHu4/tz4WFM3VYFS0StBzAeKsUr031T0NR5zn60b837h6JqZO3pdUbtXv2AHBiMPp78YAyfs/S7oi0weaCvyPdrAihbcc3IA0THvdPuKHJWkX2DxK7mdB4uSbORGsHHBdC7Sw3DIWFEIQQtY15srEW721Xofds3mrMQVuCTd+3r0cAi2Jc
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:6D4C+21VwGWgCBoOv3PuDK0bfO0HGRknR9xq5uv/YJKp/YX3YbtQ8yY3udblAFdk5e3ts27ewuX1pHcDJy27H5HzNcUt4ceTA0hxhRjFGbH1XbamHelgZGiWV+TGZR7sAYE6IFvy6uUAma270NqC3w4uKRzItx5HJ1+/lqflKawVwXC8sZFyAklN1MIm/wfcAr/422Y5Xu4q72yBgbNLe3SoVvLBzB9rbxUlGW7ObXd1H3wXh3HbF44FYcsGVrXWsN283zapwzUrApTKQDTcuPRedBYjK49Iyu/1QR542+FrmuhnqZrx/yTR1LVXRBJyAB6euMk/pywd3/Nd9SbQE5MZ+Eme/d+jVwglehmuTRg=;5:ZA2E8ormcm4tcy2vzyjDd7fRc7whpGTpn/Y3I8G1umr1D9dRdWlhoy2vYDi1RirwZNVEWW0yuWqyiQITxZPrQPNA7v3dhn4UCnXuzoU97lk69UqKu1jPb2gQbTjrnWcGztBttQAzmGpgx/l2dPTfo5/AbBiMkEFSL08ZMRO4ZFM=;24:gO7oTDAEvoh9dP2CHl3wRGF7lUzSpXbzgYRPxul41370eOkJ7RKJT8yT7K6mc2IUzhztDn4uD1oYtU7z7gp3dzwsIT4I6Dt+P/MJakRcyzw=;7:tbqVmJtIJa54TyvnpcFPGwstb+uB3mN/NAB0cxqC9eQCha2MatIh09a/V6+6wSf0osaw1JY2S4eJbAw+ZF5QbeAedLNOWqqscri3oHp3D3kr1JPgCcGaA2pgSLTOL1A6ZcGeeP2ZfKEyQQpmohNJDXi/PvKQoqyIsfbvPrbdb9utIqjMmkiW6t9VSvP05FpYMG6dZ44ighrcRquBDcak/MiMgecvdyQBULwJIsOaH/Im8zYM3eO6kYu3vbeQf7X9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 09:32:39.8706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b92142-38af-4cc3-5045-08d58e4586be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the arbitrate and release_bus implementation chip specific.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 62 +++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 47685eb4e0e9..cac629e36bf8 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -23,6 +23,7 @@
 #include <linux/i2c-mux.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_data/pca954x.h>
 #include <linux/slab.h>
 
@@ -70,26 +71,22 @@
 #define SELECT_DELAY_SHORT	50
 #define SELECT_DELAY_LONG	1000
 
-struct pca9541 {
-	struct i2c_client *client;
-	unsigned long select_timeout;
-	unsigned long arb_timeout;
+enum chip_name {
+	pca9541,
 };
 
-static const struct i2c_device_id pca9541_id[] = {
-	{"pca9541", 0},
-	{}
+struct chip_desc {
+	int (*arbitrate)(struct i2c_client *client);
+	void (*release_bus)(struct i2c_client *client);
 };
 
-MODULE_DEVICE_TABLE(i2c, pca9541_id);
+struct pca9541 {
+	const struct chip_desc *chip;
 
-#ifdef CONFIG_OF
-static const struct of_device_id pca9541_of_match[] = {
-	{ .compatible = "nxp,pca9541" },
-	{}
+	struct i2c_client *client;
+	unsigned long select_timeout;
+	unsigned long arb_timeout;
 };
-MODULE_DEVICE_TABLE(of, pca9541_of_match);
-#endif
 
 static int pca9541_mybus(int ctl)
 {
@@ -318,7 +315,7 @@ static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
 		/* force bus ownership after this time */
 
 	do {
-		ret = pca9541_arbitrate(client);
+		ret = data->chip->arbitrate(client);
 		if (ret)
 			return ret < 0 ? ret : 0;
 
@@ -336,10 +333,32 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
 	struct pca9541 *data = i2c_mux_priv(muxc);
 	struct i2c_client *client = data->client;
 
-	pca9541_release_bus(client);
+	data->chip->release_bus(client);
 	return 0;
 }
 
+static const struct chip_desc chips[] = {
+	[pca9541] = {
+		.arbitrate = pca9541_arbitrate,
+		.release_bus = pca9541_release_bus,
+	},
+};
+
+static const struct i2c_device_id pca9541_id[] = {
+	{ "pca9541", pca9541 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pca9541_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pca9541_of_match[] = {
+	{ .compatible = "nxp,pca9541", .data = &chips[pca9541] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pca9541_of_match);
+#endif
+
 /*
  * I2C init/probing/exit functions
  */
@@ -348,6 +367,8 @@ static int pca9541_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap = client->adapter;
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
+	const struct of_device_id *match;
+	const struct chip_desc *chip;
 	struct i2c_mux_core *muxc;
 	struct pca9541 *data;
 	int force;
@@ -356,12 +377,18 @@ static int pca9541_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
+	match = of_match_device(of_match_ptr(pca9541_of_match), &client->dev);
+	if (match)
+		chip = of_device_get_match_data(&client->dev);
+	else
+		chip = &chips[id->driver_data];
+
 	/*
 	 * I2C accesses are unprotected here.
 	 * We have to lock the adapter before releasing the bus.
 	 */
 	i2c_lock_adapter(adap);
-	pca9541_release_bus(client);
+	chip->release_bus(client);
 	i2c_unlock_adapter(adap);
 
 	/* Create mux adapter */
@@ -376,6 +403,7 @@ static int pca9541_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data = i2c_mux_priv(muxc);
+	data->chip = chip;
 	data->client = client;
 
 	i2c_set_clientdata(client, muxc);
-- 
2.11.0
