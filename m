Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELvoBDb3QfsYvSN1ChBRKBHltPXBkw6ocIsKeKtO+LXI9QLvrliVrjysYuFQFbu73RG7GNgi
ARC-Seal: i=1; a=rsa-sha256; t=1521133573; cv=none;
        d=google.com; s=arc-20160816;
        b=taV5PZAQPVPW0NpLzPpUhnfUASdUnisZijCxeLKtw3AXFekGQ0oVLLycEiyn8lCIm9
         VVJcNT5F0TXCAk3jW56ZCIoUHGeirAi6FGcEX1JbVB0wO+1agAeXohzp91ILNoM6pg7D
         FaSmRCEvoJzxTRrH9hW2ZlCcyjA2vzaF8SoYPMlK1QxyZPy7agLdDgv0dxOG8ynGR6OB
         XcDizDBX9beEB/wSj0HVmo/wbQ2vSYmp1DXinFsE0IS8bjd2xyYsNrSjKHymzV9/96Qt
         QEaWaUhpaCc7JmkD1d8D3dit3A+0DjhSwS9aiKL2joEIVH7IRX+9F7xirxVWAklWzK9a
         28Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mTaQy46FhreyqBBXCr/Dboih4XSTtzwhjgr5Pm582Mw=;
        b=GaYK5OhmhuWaQCqfZT/rzSxON6ZNJmQSVw01AUgC1oRyu/i1SSbEzNb7Qdrk8eSzeI
         /tAwI/7qeu6B5g1+9S8PrxBJYBEJ/ekUpE9lTbTV6XqFgnyHED9VWrI97c+yx7Fh8nN7
         Qqo2pmQ0zq71CM+ByqorjWzlb/H34N5ya5CTs4jZs+0oXFnM2d6/BOA7DxHOVWob4A9H
         KYrrTDdeyeIRopiw+2E2GzOg1HDrPf3ntVOm676gJfzxLsBa5PMtWF6pWJmoDN2+AeKG
         QNCZSguOdunrZYoATfqyy13k8XjCJK1FmdhJuOvSLhVZUXDcmM5AoA+qWlF+GkkQ5com
         5H9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=hbowE4Ct;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.62 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=hbowE4Ct;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.62 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stuyoder@gmail.com,
	ruxandra.radulescu@nxp.com,
	razvan.stefanescu@nxp.com,
	Roy.Pledge@nxp.com,
	arnd@arndb.de,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 2/6] bus: fsl-mc: move fsl_mc_command struct in a uapi header
Date: Thu, 15 Mar 2018 12:05:32 -0500
Message-Id: <1b6473b17a61f2cea51258a7220c9a1b741c646b.1521132659.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <cover.1521132659.git.ioana.ciornei@nxp.com>
References: <cover.1521132659.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:300:ad::25) To DB6PR04MB3206.eurprd04.prod.outlook.com
 (2603:10a6:6:6::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c17b2d52-76f4-4bd3-4c69-08d58a970d61
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3206;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;3:WQk5QvIVG9JFNuEnWpXXpD3wj6RZFyX8fKw9jTCS8/Tw4Djq+9b/fVvMWBn04YeYenfgOo2jLQRPbdlCt+ZZHFVIiQHkdh8u5mYUV5FLMwRtP/+nH4R5/cUHRiOYCSTsp+PKbSf9W1qdnTI6aJlC66+D4y9M68Jthjlpvm/vsliLkg7nbQPIRoGTeShvERAVw0cRgEmi73pWkdj7aj9NLLilGQOZt+58cgDmEyS7FvFmELjNlkmzIfShO3gAWV+r;25:3D0VDUZsgl1WAFQjZ1bG+beVrWGRcdn4iFnJaK+iIAptMSk+qajUskJxPEqEF1VHkgVHPVciYjmj976bbSIvUukNkErJfyfXnbziPCkJJ/rnHBdxmyGd1QubAO4TMZwoKrD4FD6O75kR8V9F83pL8gEyHja/xULMPQHQ4dZUoV//rWT0Pg59vJ3oQAamOHjwDe0qs/Xq1Qqm8SAZ4NXPv2hknhfUXWgvicwS/s/evIhSohOEgO6L3ZAGCMi3VRN2xcQWuqBc0c0p+4EERMhvcmwYIOowAZL+8PYBLgAE0OHPyojf+SF+umCxqEFEZlQN08pawySqU5Kb02jDGlH4fg==;31:hqgicvlixx2zSi8j2/Bm/J2OETJaBiyXEfrhaOvOan3cPklSBuWiWdcpqHDjnLofF08nwLf529W8ohnJsnbXxj7ScX7+Td9+ZgL67GLffLbI3BzlToT0B3Sp6Wc78nfeSvRGVSSODmYTXiFkZCSX4LC6c8HjYY+4yT7vQgFLL+0jS4m+5P8cOzOf/LSrbuvireglzMixtpn3F6UOCZe58ctfiiHVJvc23ZoahxnCSyg=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3206:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;20:4m6+iLTQSF9YVmOMF+vmT+k1ys0MtBiE0KSLFumYo4GNGT+mRU/PBNSoMGmvSUGw9GYqvo6dWs3/iHv8qEfxMpjoRquTbgy79+FmoGZ/ZgAcEnu4Mc2l8EZLgPRSqI4iZblG9sM8S700sa2qfPvda8eMq5AdityXpvUdxHUTfFE+cpo1pK/JrKSXknFz7VakZnDHxxReswKNj5GEJVbhvEUuolc+ycDXw4pb1zA0HBB5GaqaByf6Eor1Z3NqAMpBKWiXytAc8yI31fO3kpAyAY+atmsE8tv93wTgR0SEvEUHBNqZFKrSoyCUFS170g9upZ81m9x0ZfD/gZhzC+dk9EVImcoLxclo6+83ZivcquJkg94Pzc4MrGp8s1q11IiMPCH0Bf8D6zV+gHejsJ2T0NbjSDqx2eW58xQJVJVZBS5ktR4gb5CEcIJf+6BpkYcOBmHIv+L//cvknKeRmvYhy/CVTD+EO0ha5iy4jfukYkz4IGb546h84JsZBKvfsHf3;4:TVwJUp2PurwjOZBE3TByY6QcU+XQDIIeWSawkaOkYo4Exdc5TlW8Khzqns3DyghGc9aTa1PvcwmVEa2CM9bVCz8TWuxg06URFhp1pzqFKnuDnvrmNPKHAgDgWjTEUHVSHkus607GlWQYhh8u43RPPDMofSOzXF12n7ah7a4r5U3R6XN1sXDJnl80GbhLUfrb0ynGA3aKJX2cSL/Qrh0fWybmsDh5KmhKpYlB1Bgb5zREOLEBJFJhI9yTrOpUEG5bfVMq+SWkI4CCMPsNDcqd6NBkz+N78YX2eb29ffXlmCf4Wwt0rm9KEN2nmOlgDWF7
X-Microsoft-Antispam-PRVS: <DB6PR04MB3206F322A97E94049494BC7CE0D00@DB6PR04MB3206.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3206;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3206;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(366004)(39860400002)(189003)(199004)(7736002)(105586002)(81156014)(6486002)(50466002)(68736007)(3846002)(47776003)(66066001)(50226002)(6512007)(305945005)(6116002)(36756003)(118296001)(48376002)(8676002)(53936002)(8936002)(5660300001)(478600001)(186003)(97736004)(16526019)(316002)(86362001)(25786009)(106356001)(39060400002)(81166006)(6666003)(26005)(6636002)(4326008)(52116002)(386003)(2950100002)(51416003)(6506007)(76176011)(2906002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3206;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3206;23:WnppuF1xGeUPprZsqgdXgeBvAM2uW+QgDAwZf30bI?=
 =?us-ascii?Q?cGxiEkv120hH4i+Urg9sa/VpS2KppoQGfZr/jhVly7+v4qxQEIZGdjFhWu5j?=
 =?us-ascii?Q?odCQNLFAcK7AXsn2iylPyGPbezfZJtdWUPVWyGqKXuo0RspIWLP/81wbx1MS?=
 =?us-ascii?Q?PPFbMhhKuTs9Rtiy4sLY3H7ujIMlvUstUdEW/DyTnWylepFl9JmFS8vWo3bC?=
 =?us-ascii?Q?6k8uQuHatS4Ye4kJpJu7r69KCObFvv34MVcsOh5NFrfJepCw6UMwE09oOVk3?=
 =?us-ascii?Q?F4aX8q2ekFKh0ujFvmmvsnqWaoj0+MbwUnJyurhoNS9bZUh17ur3BEEX6MLe?=
 =?us-ascii?Q?66ItaXu+Tqo5B4XDXhaLYi5H5gbvYLZ9m1viqT/EmOo1WtsWnQ5vBKqi/nIY?=
 =?us-ascii?Q?GvjGMIt8w0Lt5ihJm99M0gvKsHBPOXOV4RAl2hDLnDa5f2jvI0DR1HnsbiCm?=
 =?us-ascii?Q?33hjeWbzy0Qmy5boThgce+dbwCvHjdB2O7EZkKcJmm8ZxPYw13CiCV2ENxqO?=
 =?us-ascii?Q?3kB0PWY6xZcwFbouAGsKDnzGNMQcQguaslgJ5oG/ySLK9FY0vGz7X3BDODX/?=
 =?us-ascii?Q?y9S2avvvyIHNmjcfMSCTwbsaKF9ohoT7oE2vzWNJX3yTV+lvGngGzdlkXQIN?=
 =?us-ascii?Q?qvpdDpRHeUyFeZP9x80MGegsf+JIAAa17LHpeGXSEkOtXSNZAbEuFsgpS77g?=
 =?us-ascii?Q?1nNUyKw0WvCZFDHMOR1yqtaHi5R57kpy3vOqp8RTHXds+TNFPkPBedqjkNA6?=
 =?us-ascii?Q?GDJBAOyPgfDd9KdVf1bygYwqqVSmZ0t7z4xfoubz8YGg7bgacZR/xkklXXg7?=
 =?us-ascii?Q?AU1TIWwGo4q/CX3MKoIMbxZ72fVoAXw5VeYPEQdRR/MycC7ORI7QXMB8uZ2l?=
 =?us-ascii?Q?AGzz6T0kCx7Wn8RaozGN3J0x8i/K6tVLZJ7fTB4SQq+AgSYrM5h2Tl8HWf9l?=
 =?us-ascii?Q?EI6zSuPCw3lvyAq5t1d8/35+A7a3SMejvHVaofYV1TNLuf4GPgKStv94cWt3?=
 =?us-ascii?Q?77RMg4wjUf3MimOXkFhBK+q/rPvIduHypdgZe/7mwRIla00KKcAot4jzTe3B?=
 =?us-ascii?Q?g0FqN8JGdOdcEvC0H0GFnVzw+DLCY25dZe2t0La01YB/oja055kcu53CwHb2?=
 =?us-ascii?Q?QmRYcGZC9aMnjSr5xeQV1yc79tC6Twr?=
X-Microsoft-Antispam-Message-Info: eHFY5vik9biFm/A49AkyUUT9yuef1KurgFRvrD7jbf8yDp8RTGUAOR4OfZaYPezEqVcWdS8IgEjm+x0fbmyME9cqVLxI0my01l0f0GwE+dw1P05SNhkUh8b1TsEQsCeIDwHUWb8jNS2RcUeolEojtOREznlkKvYDKVXyfdmjIf7Ly1RxYVlUDPgfaQxDA4g9
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;6:9nbCwgeSnsq5kdgpS+FWpLc+tsvlXCdMja1zcAG9zTDGhamF6hoRxSKkvJFw/7f+IGQaAU4NDSTyOQ+GviVix5BZgzQSaJ1rl2hOQr4gmnn/zcb1Ze+OqCcwY40+cpS95YbGuZ/4RkJA5osSetl3juX8LfuHqjnJ0LEMFqXkEoIao1cIMfEJDbYBFdFsNe2R4rlbXcwjdZIeod1lhOY67aM/cZx4jIQGDCEnSJCrnBvjsI/E47FJlsrYt+NOohVwVFPslPH9xhjvgeM62QRPjhirtwuiDAOrVk0bfw+S+oN7kH4FzvPz9MrZQhnR8uEARTQdzQUrWrRN5/5eHV3gKM2xfGlUIk3bDbpUTChjQ94=;5:mWDVCLdPprlJE/zGNisi2LXCVLW6HMSnDXkFefhMKu7Nb41gBT5mTlrJTgtPsMDGLkFzd+gZcIDUWwJT/oXt/PbDXITdxFsUzaGHMpOINJwZCqmBXMzvdRWuqCvhZvXo85vpMNDgG1p3OIPeNYQNViKO4W9/Uvz6OWp7ZU8CJWU=;24:blLxWt+c8ShqdI/ciTSFXNpi5AfbuxCNp469wHcUOQSJAP8CI4qwW5bnRA6X+xmvFadKAj0XrbVr+vESth+ZYPfmijy2dsVHPlPRpsUWZXs=;7:ehzsx2XAzFoiYzNeF5g65PNMYM/UroNDqNMRp+KsTGPh4TFR0gatuzoKKu80P6IFwGKfZN5VIQ/sVX5yk5noGY5dg6wUxLDxWWdBqnCSuyJQkbPUE0GDY79mfLWOngXZtouellz5zNwW06sU83sNbsiQywaHx+uHKRPTA/I7ycjUl1gTyjAaZgfeXizdzX2IvO5E6ltC4LlkD/7Gy7Ine7wBnuGc4Yp7p4UwgiDb1LggC6wGIgMAkuMfe62p1lUl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 17:06:08.9155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17b2d52-76f4-4bd3-4c69-08d58a970d61
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024157586439994?=
X-GMAIL-MSGID: =?utf-8?q?1595024157586439994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Define "struct fsl_mc_command" as a structure that can cross the
user/kernel boundary. Also change the variable types used with
the proper ones.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - added the patch itself

 MAINTAINERS                 |  1 +
 include/linux/fsl/mc.h      |  8 +-------
 include/uapi/linux/fsl_mc.h | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/fsl_mc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 473ac00..4f54765 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11463,6 +11463,7 @@ S:	Maintained
 F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 F:	Documentation/networking/dpaa2/overview.rst
+F:	include/uapi/linux/fsl_mc.h
 
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index f27cb14..19a352b 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
+#include <uapi/linux/fsl_mc.h>
 
 #define FSL_MC_VENDOR_FREESCALE	0x1957
 
@@ -198,8 +199,6 @@ struct fsl_mc_device {
 #define to_fsl_mc_device(_dev) \
 	container_of(_dev, struct fsl_mc_device, dev)
 
-#define MC_CMD_NUM_OF_PARAMS	7
-
 struct mc_cmd_header {
 	u8 src_id;
 	u8 flags_hw;
@@ -209,11 +208,6 @@ struct mc_cmd_header {
 	__le16 cmd_id;
 };
 
-struct fsl_mc_command {
-	u64 header;
-	u64 params[MC_CMD_NUM_OF_PARAMS];
-};
-
 enum mc_cmd_status {
 	MC_CMD_STATUS_OK = 0x0, /* Completed successfully */
 	MC_CMD_STATUS_READY = 0x1, /* Ready to be processed */
diff --git a/include/uapi/linux/fsl_mc.h b/include/uapi/linux/fsl_mc.h
new file mode 100644
index 0000000..90892c4
--- /dev/null
+++ b/include/uapi/linux/fsl_mc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Management Complex (MC) userspace public interface
+ *
+ * Copyright 2018 NXP
+ *
+ */
+#ifndef _UAPI_FSL_MC_H_
+#define _UAPI_FSL_MC_H_
+
+#define MC_CMD_NUM_OF_PARAMS	7
+
+/**
+ * struct fsl_mc_command - Management Complex (MC) command structure
+ * @header: MC command header
+ * @params: MC command parameters
+ */
+struct fsl_mc_command {
+	__u64 header;
+	__u64 params[MC_CMD_NUM_OF_PARAMS];
+};
+
+#endif /* _UAPI_FSL_MC_H_ */
-- 
1.9.1
