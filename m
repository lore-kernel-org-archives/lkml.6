Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965890AbeEITrL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:47:11 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com ([40.107.5.133]:26880
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965181AbeEITrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:47:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
Subject: [PATCH 1/2] i2c: robotfuzz-osif: remove pointless local variable
Date: Wed,  9 May 2018 21:46:57 +0200
Message-Id: <20180509194658.29106-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::30) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:zwNR5s9H//BObiEC2y6Sf6Va3wwoSzCaWLb8/06C3HGbs39LYWFMj3ZwkWVexewaoEFfJyYcBZU97uuUjl0HujVI2k2VFFe0JIbXID5QMwtlSSSS2fqNi0lLcw7Ii0RDVxv0v670L5ldkpxV5WjRqci6gtDYT7ixAvPibkWSKB935ZDJ3wwS1EJraO5Lhw2kh/6H+6wrS8wTJpblv2+BRMTafIAzFuSfAdSE6DMHcQFfpydelGeeY21nHbnDlQm8;25:C8TsL0A0MmuF9CUqQqjksi/R9iv6dvb/24mGj9uuXn5tcql0JrD6wjtZEo22KE7aXL5Ij/e+nnn3WVNG5EDs9uPZhMKXK1yZ5VIf/sfmIbpbtmSZy6X1g9Wzu+U2KVYPegTMohxlgujF21kyPp9GLX3wIpKtuM1s9m+mCO4k5O8UKnZCj+8zvfTjFfxWfyrnv9dvUpxNJ1ve2Ef3sbbMMsFCiIeB8t814mnfksm16xN/av2Ay3MVxo8vSa+qAyM5C6LhhSgvmFOBHVS3ztJmBJ6TAAJt5o7DWFg+iKlWzC1IsdHWORtMcqk/hWVe+RopXalr2omysUb13NhwxZCh8A==;31:5QxQ50J10e9UWKsAQyrej1GRAzArzzwOTXPGOWJLlCwKqZPxqicHrHqgpFxO0cE1ivbeXF3hY8XV949Lm0BPlwFW6Nv7Cnhr7oO0K/UPbC2/mVtpgCuAuJbD4DOPYUHvuUh9KMAM9nQtAgHjzK/lUuZgC2x5sW+fIA0GiApkfFFs2Zla9qo/Ns4/uS1XyqSx9X0GIhxTS7TGnYbE5OObnpeK3O7bqkY1KyHnll6Gwtw=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779B2923DD6982B07A802F8BC990@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:xlAeZhMTeV4KSSuONXaIsWLFCiBVdOqGfvuakOrqLBnAO1yef75wm4MciEGVpVm3Ns7iB1qB2P6ADTzdVzMvTVvRZ0pyfwE9DITvfqk5cIiLuMpDaSptEy3m5jDcHa3q8IHwubZM8AkRodP991ZY+bzYgbwmd+5ozd8odFTpCg5LWyzc4ugAmY+bQKNn42wpTDjycRT6PViU5sU84Y9cQ9wvlzKKovj18Hg1RF9iWir9Ff3nPP5BX9YYCFav8MUTiBizUUis//io9tJrz1ptZA==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39840400004)(39380400002)(346002)(189003)(199004)(6116002)(66066001)(1076002)(97736004)(6666003)(6486002)(6916009)(50466002)(48376002)(2906002)(478600001)(3846002)(16526019)(186003)(26005)(25786009)(47776003)(2361001)(86362001)(575784001)(36756003)(450100002)(74482002)(6506007)(7736002)(52116002)(59450400001)(105586002)(106356001)(305945005)(386003)(476003)(316002)(81166006)(486006)(53936002)(81156014)(8936002)(956004)(50226002)(2616005)(2351001)(4326008)(5660300001)(6512007)(51416003)(16586007)(68736007)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:2LHiafDmKkT39CKn5JVoZ9/gVprGkDRG6ClS7b/?=
 =?us-ascii?Q?uA/eRwbaQhC0JlExgAh5A1T5sqEd3LH6F9nezA0eHJCKI6l1XElP+GguLdvf?=
 =?us-ascii?Q?pz3dWt8NczH1kGHbZ3MLpmUVkDP7FeQJsBfNibS58+NMm2pTEgLewmNNdRqm?=
 =?us-ascii?Q?Ay5D0opuhaWWxULMnakxnrWsLszUAY5BTIltT5D+o1yaV3UzhSPIaKkA5tdZ?=
 =?us-ascii?Q?5QXiRuUyWQKvXQoQLCLnzAcutA+GFmjtsnkAzS50WQSXLF2JVOXogA68Hwfk?=
 =?us-ascii?Q?txRL82Q8hL1PZkVAGuFsoohK8ajY9vciN+GOG1+/wtn28VP41GH9VrvhChMp?=
 =?us-ascii?Q?elwFig7jkJF3OF8tlraI4aqxeidiGGiXeGS+3n+z0Bp9QuJuFoBT+iJAWfBu?=
 =?us-ascii?Q?pbUoXGLiXegVoqTS+YMs6QPNLGnR2v9wt2SMWl40RkDxp51N87c4I0rDFy/N?=
 =?us-ascii?Q?B7A3q9F9BPhWcl62dbehxAimyz771sczhSR4NqKApzQUD0SffKAsGPu0OUXR?=
 =?us-ascii?Q?qQ6FslRZSctLy082OptZ67DPgIvrUjAiq7XH8dAHzZ1GaUmOq7PLKJbRYN85?=
 =?us-ascii?Q?3YXltpxT/xC8fsGqg+7xKfvEQg3ow2bIxdFj41g8tbDbjO0cdjcNEq6RMQzR?=
 =?us-ascii?Q?AVq+jGnatKhsN85YXmHSakcDDkYPfr/CiK00of6HktkNbe1iLSNrAFdL0Eul?=
 =?us-ascii?Q?iWIvMausZVRkVEOZZ65NP9WIuplLFUOqcxWHK6nKJ7E2BD1oZqKCpbS6dSlL?=
 =?us-ascii?Q?iQhEJ9GE6NDUz/RqEJe6I4g7xVBhhHLHTzM10wooVJz84AmwItluYZ5kqUin?=
 =?us-ascii?Q?qEEFU/QRhbnhmFQSqKQfy5u6nCSyaERu5/tbvfI9wRiWDKZxz4w4Mb7u6JpR?=
 =?us-ascii?Q?PxE+U+wwfHNBEnVWI7vZ+ni5/VGTDm28aAEcMn4by/GHBPTbjEPWabBoE8dU?=
 =?us-ascii?Q?FYCHugjlx4IaNauvKvEgn+U8QlfARmP8kBGZpClLlRX2rR1uwUpiW/lJgXeX?=
 =?us-ascii?Q?7x1UMEvTA3ElQOEk2V04i/EX0NGz0MzkVPFYg2X4jsO6gcCfz9Khc3puLs1S?=
 =?us-ascii?Q?fy2e2m6T59Q5Uy5P4j+3yqMkCk/pK/E2DAfbLVRKrOSSXPBdEw+ooCdiw3oo?=
 =?us-ascii?Q?Pcwo6lc5CX55+lrRcihVPtIgqwsLLznKS+xK7gkoByry53ssBTBz2+vmhqIq?=
 =?us-ascii?Q?zH/p+EGTQWJeP1UXF74Wthxbgz1DDOXIM38pjCrxxq6l7OjwldbCcNAv4zEi?=
 =?us-ascii?Q?oVOPxmRZeMKG3uy9QYtVbjUcV4zGhegzdj5mKqbOufRqMZD0tAh2Yz6sHzyF?=
 =?us-ascii?Q?RbQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: bBel8xbjSCrc+F2ZxKcq2gkNCTz7DYu/t9VgX/zAqUZEPHxNnwVO176gqiR9AwY5bU6NifOhiJHFlvxxl4NJbvthnULSCUGBPApeRyMmwwePMFxq6g8e9pUEZD8a+4pQVPWYacV0cH5wqqdq5ewr1N+AFKy0scx7od5zCveHvezv0TzQgXq3PpV2knKCDjEv
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:5ktXllzKZnYT6cIwq/dwmm668+VAcOi0wqeBGqO3ru0wzvd+K/gifcVhgItxpMBvHGIPUPrl/0ATpZvNuBpKUJT7dB6hZzk+LzYGxyfGu4z5c2MLxsS+NUc2rFM33wevj/uo8SDD4LTVaWypAx1FyWKVmLhTOtjUmCXmfxc82BU7/jqG4gJDWabTK8mXzpTs2YlyZgZOEbfHI6qtlNn28++4SLmSwDXO9CdkNmioKJthRzMnGWixw4OJ+d1y/IkAL1jWf1bWy6yAwbSs51+71Fsb4gupPH9N7cVfcOruWWyWc5mJ6qAniZwE/oSiyiLfQ//JAlOHjBt2Z6mdGSCvk3oplmVZ3EC2gaiadEZ7zCLc9eya0HZNO0QVSJ5P5qX33UADWZXcX55dkocN6kyFCJWx4peBHCCI5oltyIVdoidIVwpeacYBEGPQN5L8pJVqF9aeY5xwWeWYNZcJs+kuww==;5:VgqeytG1UoEqhdo8NFbHPKp0EKI+lzIuuAcu8QA5JzVmPRDde6VupH9KIcEY7xq+zuV/ZRu7aaO335mdCvdCCKSl+vIDgeHBul3S63ohOkFAZjbb7t1C3IYajBpAeiUW7xg6mYEgDSzyxzl0ZbT5522NW6in6uDdBYOPUzY1ULk=;24:yb/zIF1kN4Z6n7lTN8GXOhK350ymTmWcx9yIS2MZ1nTGcNXjtzgx/fCWoBZQp8PsUBzYFSmmsq4nTIUMFE/+f5PAw1ENGGoj3ozScyfbX6M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:EJZ8HbLAd40eRbhRlfsifjsLZwK1DAnyxS2jfpXVA9924u+mBoX7HVmfG8EN4ONKEw3y8mpZAdU/n0uUgmgzvXRkOCqi98ZsBz9B6DJwYuFEO4JDkcbTdhCPBdXIsMqZ/NzUMTstr0UjG4oPbPacAeOnuMyJVPFtutwxXhosV5Lpe9cvlJP0Hk17vcCN+aUcYt5yOMugUHkOd7iFKmGTmTl2foDK2Vf5TJRP+J040qYwU1F8wY1D5T11pDXHfduC
X-MS-Office365-Filtering-Correlation-Id: 0ab1afce-eb3e-48f1-de64-08d5b5e5a497
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:47:05.5254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab1afce-eb3e-48f1-de64-08d5b5e5a497
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just use the value directly instead of assigning it to a
variable first. And then drop the unused variable.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 9c0f52b7ff7e..51d93b4b00f2 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -63,26 +63,23 @@ static int osif_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 	struct osif_priv *priv = adapter->algo_data;
 	struct i2c_msg *pmsg;
 	int ret = 0;
-	int i, cmd;
+	int i;
 
 	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
 		if (pmsg->flags & I2C_M_RD) {
-			cmd = OSIFI2C_READ;
-
-			ret = osif_usb_read(adapter, cmd, pmsg->flags,
-					    pmsg->addr, pmsg->buf,
-					    pmsg->len);
+			ret = osif_usb_read(adapter, OSIFI2C_READ,
+					    pmsg->flags, pmsg->addr,
+					    pmsg->buf, pmsg->len);
 			if (ret != pmsg->len) {
 				dev_err(&adapter->dev, "failure reading data\n");
 				return -EREMOTEIO;
 			}
 		} else {
-			cmd = OSIFI2C_WRITE;
-
-			ret = osif_usb_write(adapter, cmd, pmsg->flags,
-					     pmsg->addr, pmsg->buf, pmsg->len);
+			ret = osif_usb_write(adapter, OSIFI2C_WRITE,
+					     pmsg->flags, pmsg->addr,
+					     pmsg->buf, pmsg->len);
 			if (ret != pmsg->len) {
 				dev_err(&adapter->dev, "failure writing data\n");
 				return -EREMOTEIO;
-- 
2.11.0
