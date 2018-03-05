Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeCEU6v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:58:51 -0500
Received: from mail-eopbgr20124.outbound.protection.outlook.com ([40.107.2.124]:49554
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932106AbeCEU6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:58:43 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org
Subject: [PATCH v2 1/2] i2c: add i2c_get_device_id() to get the standard i2c device id
Date: Mon,  5 Mar 2018 21:58:21 +0100
Message-Id: <20180305205822.951-2-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: fccae403-1371-42bb-d218-08d582dbdf44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:EtIcJMzfKBE0ixQI7P79CozLDhIYG7YvVROqBuhYvbte4zhaqIeO7Rdiy2mMwYxKBE/nstHNfgiRi2BLCbQJi3wiQ61AFkZxdRbNsuDVP9VVjFZgw4r3mC1jA4vC2M/c/TF+CBbbSwiRYjzjqICmcBhOvy0GBbQFoS8g+Iq+VvCAISK1zAFmn4fOHCl9YGacnJM8YdtLnbfLmO7KvHR/ATiwdyIIB9JUtcd2jgEWA7DwHkchvBEIY59Oz/nL4v9o;25:g1cuXbpGZsuaewplUr7pPWuANLrFEPOIQJRvxpfMFGizjPIYzm3tKpKCX68eReD9bLhxE634HnAnizTiAa1Ev5aR6K8St2hVhqwu59FjphPptM9v79L7BjPSDyw16y45edmsj0udBIOpeYMRJF6fuHx88piOzQMhS7f2AgyeRQd9IBO+GuBqWyadN8pZUxIsADz0bUR6W2f7fXB7Vzw6WtH+4F/XE3wHqV6XR8BLqTDm8xgt9au/VTzuoKqZStfhrGdALcynRP/uo6OW0nmXN7rD4HQDNozy+/krQHdA8o+aGjsxW7ljmoSrfxH7u5DWaNcOErC9uuE1h5CNF3jQXA==;31:z7UzpVXMsC2kpn6q+dmvQv9XS4Hte2nlArD6+D3V290J3YHB6zglHz5ZJNX7fsA/+WRo0f7SOaqfzwgw0AwJjeqcpx3DuTZPvHk5meTp+BhskonIO2xzFtUcDWN6vv6N21ALwK9miQlX4WaON77MZFkrJJRm9EaF0c/6fnM/GhFWq7Fclluyvsqc/DVnwdr7B8vTGft1y9GMVmKrtjRnaeWiODNT14ois+yTF/0ZaZ8=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;20:kqd58egRCNBTHwwqLn2DwketEwPhBMYe4VrNH/r9lc8h7LEvb2AgxpnJJNxQn1lXKtF28tnNNlXkM8jEi0XvNLhhVnjZHlXFmi7I77U6b0WW3h6W9orUSjag3asDXvE8excuSK6Qniua2VTSEegS+ml5TEcQ3Zzni1hzlMLoPMg=;4:IQeaYLax3uUBKewExBS3s/eDSE0dN+4DdoR1EOqEumE6+u9x55zLGXz668ZBX+NJ19i6XRh6HGVu1OAs7JILmVITVDfE1gTp3Kh6liZUjjTdV7ynp6hkvReKXw5gy7K3aEag+H8Wxd76zckEhgISV3UgBVth7ieALGkAYydVnQklnqQ+epXpg0FBmdz2fBv5nFq3HCUMeFfnxb7zI7V1ALOLkeLx1xjOVTL9Kfq51h4g0Vjtqbu4OaZJG6wLNMT1Ztdp/L6pHwH9kqP7zUDfxg==
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27778176F25D8450D7D95869BCDA0@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(39380400002)(376002)(346002)(366004)(396003)(199004)(189003)(59450400001)(2950100002)(106356001)(86362001)(66066001)(6506007)(316002)(47776003)(386003)(68736007)(478600001)(4326008)(5660300001)(8676002)(2351001)(7736002)(186003)(16526019)(305945005)(6666003)(25786009)(50226002)(26005)(6916009)(8936002)(2361001)(81156014)(97736004)(105586002)(6116002)(3846002)(74482002)(1076002)(5890100001)(2906002)(6486002)(36756003)(15760500003)(53936002)(48376002)(54906003)(76176011)(51416003)(6512007)(16586007)(81166006)(50466002)(52116002)(15583001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2777;23:vMn4v03duSEHf2xEXP9G7Glv7j8rpClBztR8M61?=
 =?us-ascii?Q?vxULvgMMfsmGo7e7FY4jyptN9fNupOo2vaQ7DbtHSJANQvGaHF38HMBqtSIg?=
 =?us-ascii?Q?QRW3LszdRmypxT2e7kCSm4/5lYGGASrpy0mC+R96z+i6xHC9QFyZi96wkbmG?=
 =?us-ascii?Q?klog5EZlIEycbaq24Ey+N3qgoK5XfCPD2MtxOOG87DcuLAqig/ddWj/rWUg6?=
 =?us-ascii?Q?Qh/7DGM8RO6hCuYVPqSZLf1hSOT96BN4PjeXqY0UhkHiDqG1dOn8jiXfFicq?=
 =?us-ascii?Q?+1eCOGACij+gJw3MdXF4CvayjgWL4YtC+vNHsX/NZO7QAy3ZIjZrAy3W3XXD?=
 =?us-ascii?Q?7JkCMPq1iqxH4PPNkgkoDMSM02pLToDgIIwKEXTSwgGl6qwOuvLVb5fWu7Zo?=
 =?us-ascii?Q?AlYIn9S0OFKyQBzrg2DGFfBmhwkdICVtf+KekCnzaA/5ZKSOoEvdGi09rYKs?=
 =?us-ascii?Q?/5uiUo6rP8TOantw75IMoYGIxinltAQaKebwKMon6sLxxBXMRq6he5Bthm50?=
 =?us-ascii?Q?g2+97tOIDxCY3FaFEHNozoWK26ayAtiF6k42defHQyPbakSD9qxpwkxJPeMw?=
 =?us-ascii?Q?wx98zwY8kAuNUYCDYOm9sFq9ZFJ1foj9sJHoLKj7PVIllVL12siyKIhUomTa?=
 =?us-ascii?Q?Xd0oU7BP7qZHXCJxE6LeylW/r4I5ZnOHpz6fEY3gUOyVK2Rb6cvFlv1doI79?=
 =?us-ascii?Q?QbOQTlurwp6yg9YHKQn+f7dj2Tikmo2RnppRU3H5ipJ+euOdQwxrMqVTMqNa?=
 =?us-ascii?Q?OQNJm96UmDXqSOl/b+6QlD+T3wS58g/RIAimSwwf6zyYhFbWA/xMbVLLEdya?=
 =?us-ascii?Q?OkzDQL6Iu1J/1JfhQtULmO3U1aSX5stjNDnCnFr5x0jiBwbpGCUyzsRym2YA?=
 =?us-ascii?Q?mOyWn+odI76kh3SxEs2nW1ypeSnblhczS0BK4X0bMrQUNBnN8lDM08yxT0QS?=
 =?us-ascii?Q?M6oiAMfP7iBbFAgtHum2QDfTo2DfLKe64S8RHtNRsuTU4GJkvfGeJBZHD+g4?=
 =?us-ascii?Q?qUFHvmXHbeacdEm6IcWAeYOTCwWEtsHlA8RHa8e0uCFSrWbgOBk4CATgO+Rz?=
 =?us-ascii?Q?3+2/psXH9IFk7ZVcBIngsOjx/52sw7aTSotyY7ulT2S4ZzdXU3izqT/efsQg?=
 =?us-ascii?Q?mN0YYNAc/+Fqr8/dssk7khjlCKvjvpp3b8m8ZxO6wbHOxOkO68ZdFHDb3P4J?=
 =?us-ascii?Q?ZYGaditT63C2fi6XLXpHAIlS0W1/LBErUu4acFeaaOALN98/ls/RVd7RIht5?=
 =?us-ascii?Q?9QB9V1gxeR6bU1VMtSmnGYCc9IE/LUALiv6hTJc1RYMRw+LTeDZQ3XyRXH2D?=
 =?us-ascii?Q?C7XwGo5VxPIXJWs3fQuVXqWU=3D?=
X-Microsoft-Antispam-Message-Info: 9MWS6YbUIk0KnZwMAsVdwCR08L5EBWcCdEosjoDwNLYAq7WRJY9JcMLM7FViGf+VDha/TwAlbrR0rrx9pDaO17sM79UJRdadHd/05QX0Br5hhmJvJpxTzAarChXY89EwnR410Iy+6Nc6VizRdFeHw1lL11LMiu1uQaNiBGBtIma/YVGjyjil1oTbT/8+KVhi
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:ot5H8bGJpmWwlQLrokJPvKuC5YGHNYz+HWbHHgh+ca/89emU6jZqs++Ap64dt6YjznCVaNAAdGRodTFLxMjCdDHTvz0GMImvxG81PvG5wTQkGFdeUPov14e29kRBMjbnDsQ6ufUb7dteiwcHKNs/4h7Vg7flm+mzFGC+crp58qfFV7gzWpUaSCMDte0DWwGt61sbPkz3DFYlFnJu6cbRCDG0PKOPvztYAM/ag/k7TnFJJI67V9zJ0nZfLTKYaoqQNRVf/YQgpthC9coNVI8kcmMX7R5/i+gOCf1oMS7WfzkcURnUgNcF1zXYEuqrHqkofaKpH022/NqnFqLfRhibUj8JgE2jprH68xQT5BzuLVg=;5:NeFgr1dzm8bNyvgMN6EXDEdT+vwu8biaA6N5P44zbgeFSVlYcFoh+QWfx1jan2pyKdCLKF6l4C94JKdtjatvJSRt4qgjaYKZeV4zS86MW9AOLn6e6vz6oN4DDhgptZF46oN0FZeJICpMzORB8vc5JZD650NlCnMJ/k5q4WNuXgM=;24:1ejIC+uK0BAXunp2SJAP2PImi0FbE+GAB7uOV/aQdpkOwtLInAOJromMk8sHUayHOrlZBeI5xChb18zCE1ofyWoLz/nhEO72lM3/LoFBrAc=;7:GpTfxNFmCqi4LsSBkRxELX42HFN8Y+xyrZdJ2oejwTybZwtwwLIvQRCwev/hsc0nwX4oTrA6NQYWD5BFQ+2rxnYsnbo8QKHf/CBVBwzhWsgxmUeJqtJI1VCBJ0tlVR+hYd3gjDKxPQmz5TgPNUv9fPZ26E/O1RUBOUYrEiJyNDbAoXXjMPPiHZE3KbqSJXdbpxFZ/laNbLeCeU5UAQ1rg5+RTu4pfNnwHcXxfgBdqKqx8MzUDd2fB6TALFImkEsz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 20:58:39.6508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fccae403-1371-42bb-d218-08d582dbdf44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can be used during probe to double check that the probed device is
what is expected.

Loosely based on code from Adrian Fiergolski <adrian.fiergolski@cern.ch>.

Tested-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core-base.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/i2c.h         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5a00bf443d06..aa03eeb43814 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -58,6 +58,8 @@
 #define I2C_ADDR_7BITS_MAX	0x77
 #define I2C_ADDR_7BITS_COUNT	(I2C_ADDR_7BITS_MAX + 1)
 
+#define I2C_ADDR_DEVICE_ID	0x7c
+
 /*
  * core_lock protects i2c_adapter_idr, and guarantees that device detection,
  * deletion of detected devices, and attach_adapter calls are serialized
@@ -1968,6 +1970,37 @@ int i2c_transfer_buffer_flags(const struct i2c_client *client, char *buf,
 }
 EXPORT_SYMBOL(i2c_transfer_buffer_flags);
 
+/**
+ * i2c_get_device_id - get manufacturer, part id and die revision of a device
+ * @client: The device to query
+ * @id: The queried information
+ *
+ * Returns negative errno on error, zero on success.
+ */
+int i2c_get_device_id(const struct i2c_client *client,
+		      struct i2c_device_identity *id)
+{
+	struct i2c_adapter *adap = client->adapter;
+	union i2c_smbus_data raw_id;
+	int ret;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		return -EOPNOTSUPP;
+
+	raw_id.block[0] = 3;
+	ret = i2c_smbus_xfer(adap, I2C_ADDR_DEVICE_ID, 0,
+			     I2C_SMBUS_READ, client->addr << 1,
+			     I2C_SMBUS_I2C_BLOCK_DATA, &raw_id);
+	if (ret)
+		return ret;
+
+	id->manufacturer_id = (raw_id.block[1] << 4) | (raw_id.block[2] >> 4);
+	id->part_id = ((raw_id.block[2] & 0xf) << 5) | (raw_id.block[3] >> 3);
+	id->die_revision = raw_id.block[3] & 0x7;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_get_device_id);
+
 /* ----------------------------------------------------
  * the i2c address scanning function
  * Will not work for 10-bit addresses!
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 419a38e7c315..44ad14e016b5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -47,6 +47,7 @@ struct i2c_algorithm;
 struct i2c_adapter;
 struct i2c_client;
 struct i2c_driver;
+struct i2c_device_identity;
 union i2c_smbus_data;
 struct i2c_board_info;
 enum i2c_slave_event;
@@ -186,8 +187,37 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 extern s32
 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 					  u8 command, u8 length, u8 *values);
+int i2c_get_device_id(const struct i2c_client *client,
+		      struct i2c_device_identity *id);
 #endif /* I2C */
 
+/**
+ * struct i2c_device_identity - i2c client device identification
+ * @manufacturer_id: 0 - 4095, database maintained by NXP
+ * @part_id: 0 - 511, according to manufacturer
+ * @die_revision: 0 - 7, according to manufacturer
+ */
+struct i2c_device_identity {
+	u16 manufacturer_id;
+#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS                0
+#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_1              1
+#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_2              2
+#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_3              3
+#define I2C_DEVICE_ID_RAMTRON_INTERNATIONAL             4
+#define I2C_DEVICE_ID_ANALOG_DEVICES                    5
+#define I2C_DEVICE_ID_STMICROELECTRONICS                6
+#define I2C_DEVICE_ID_ON_SEMICONDUCTOR                  7
+#define I2C_DEVICE_ID_SPRINTEK_CORPORATION              8
+#define I2C_DEVICE_ID_ESPROS_PHOTONICS_AG               9
+#define I2C_DEVICE_ID_FUJITSU_SEMICONDUCTOR            10
+#define I2C_DEVICE_ID_FLIR                             11
+#define I2C_DEVICE_ID_O2MICRO                          12
+#define I2C_DEVICE_ID_ATMEL                            13
+#define I2C_DEVICE_ID_NONE                         0xffff
+	u16 part_id;
+	u8 die_revision;
+};
+
 enum i2c_alert_protocol {
 	I2C_PROTOCOL_SMBUS_ALERT,
 	I2C_PROTOCOL_SMBUS_HOST_NOTIFY,
-- 
2.11.0
