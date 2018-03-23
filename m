Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELscX1wolYtGbhc6LGPgkzjDBFStVTs4GzgwE7yQfluGBJ7M7AG8GZcq0E7FY3ulY3iaUmtz
ARC-Seal: i=1; a=rsa-sha256; t=1521819585; cv=none;
        d=google.com; s=arc-20160816;
        b=WslpRpXaTPo1BGzF3NHA/bUyhmvBl56dPqvZI0Lv/dxSyQoJiiHikCVPsmp0I5qtvV
         BHmGL094MpIAND5JHuomTdCqWLWtDqE1PDzTeJbmC+91fmRKuffgGI+gHwVSrTZIB+hE
         As7Kdr5ZXgapR3gBCo0MH9EogkHPOLUCdHvtaZDS8SUnhCROciR1Q89hBzgPk88lg31a
         DnjWnUQmwwi9FDV2ueV4p/CQ9ur0Uq0SOWyigOHddzxCyk5S5bV2Umh8v8Hd43Mq1fpp
         4dvwbnna3Fh6i5b3Dl/8K0d/1myqWSgHr4yy49IcIbfHbOYW/2Wlb91VObwLHH8v4+am
         mmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=nee0l3z3IgOvDb+psxBAvE0vij0aondNtsOO1Gr0UJE=;
        b=bGgz1I3DDRoQmnFDY08DNtWIFu3BsYT7uWVpKmuHaDTDJLebYXLrN30PqOGNhqi3Dc
         NAbKPPnFRJncn5PQVQetp67QIC9FP9f7SW/bFkq/tb2/7W9B42WnCLNrFxSR3CEZLLlP
         1WNBsnGLbD7EfMK2X5Op40m/NHApF+skLi2Px8scwPDVcVTxT+2DMnJG8Fup/EDouXB9
         Vn+BJceBChDpenr8qTiOUVLIgkoAx4DHuLBQ51r20Ild5xr/c6WeS7Fzo3+TIUJ8iMoe
         fUQijE3B6lC6bHEC8YC6B445aFghQE64oXx38qWTYOp8kwCW2nYsT0NRnzc9KbkRrDjY
         2LOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=VLigHYvK;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.72 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=VLigHYvK;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.72 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stuyoder@gmail.com,
	ruxandra.radulescu@nxp.com,
	arnd@arndb.de,
	razvan.stefanescu@nxp.com,
	Roy.Pledge@nxp.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 1/4] bus: fsl-mc: move fsl_mc_command struct in a uapi header
Date: Fri, 23 Mar 2018 10:38:55 -0500
Message-Id: <cffec87467e11ce5a8a581386d20497b6f695b71.1521818402.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <cover.1521818402.git.ioana.ciornei@nxp.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:300:ad::23) To VI1PR04MB3216.eurprd04.prod.outlook.com
 (2603:10a6:802:6::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab7ab076-4759-43ba-5263-08d590d44c1c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3216;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;3:A6vTtJYE2WywzTQzqkDBWY07HNHPzqdFCYVSMIuRjkwlDewhdrG0oHahB1lqWp9+gzOVjVxoaXjPvY9ekehedRJHGT+zK2CQI6OKkOMzCmDe8plGP9csFNm6Ik/Obdh0mXca8PcNea4neiswsKIovA9A7dKOwh24ndg5JzmgtDekRgq0r0qk8bc7iDVdRKPm3VL9ks981sLigNM5iwZA2LVQVnSisQi1EJpiepjcU3ow5x3bTZChxrcjzLcOMGOf;25:oRBYtILgeQ0I4lq8xISlih2o41gG2+6ydKg2LWOnklsDbTBBJMqAIlrtT6vbaElqDM0CxEcw1xwFt0rS3y5hzoY78TQ7i/OmR1Lg3bKFtiwunPUnnij06dO21fvgkyqWg03jd152BE/lA7W8fG+mnCejoNi7nRRR2IqH2g85c7jxA7EArmG1eP+hO5dn4d/OCtiLQZ5yLJpBmfs8uDLY4frigAEbmfSKpvx3F7SBhJxKyzUAUEvnA4o+Larq9ILqpiIShDZU/aXd7NYEbrG+KJKIZBgjoeAwsS7R8CYdM/qceZ8ic/NnzaNCYrQUCRbqgwWivQPjtANaRRSzMDzkjA==;31:V1kgNnG3yJWR6bWR5ODi209fe6wXyhpN1dX57u8UHi5DGAXpssg25r9WcMJ87uAk00VjuXVkDCc+LPpkqGRpwfAwzJqkX97l9ply7r3jLK5lKoC7B3IbNT75ZqqdWkm801DD9VK45ddSp8Hrxsf4tNhUoTXv/THfpvUlTxnVP+b4prya573M5qvj9dLPncP7+OGCkYINH34wTOocQDDZoBFgh45BRdteQbHoS2fFi3k=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3216:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;20:70TDqccpkU5jZYP2FjMkNoB2LCSSU1qHtRy1az/BAW9E2bYfF1hc16ddd5dKvLaYo0CuqvQz33yOrSlyj4yGME+Vz/HTTQzA/e3zAJ0eFi/vdmmpvR6xreEbiivT1hHoBfEBiczAl52YLnkaVB2sZc4HeV5D8ecZAquMwqsQkiLjbfzzuQEqaZC63Ls0Z/YUg8tCxlKkdsf4/5xqiIAJ+RyqtD7DScHknr9ZL6kulkhHbhzxvn9fM3vD4q/Zi6UBmH4U2ft66m1G0+GNfkh/Py/M7qXU1bHYSnPvuAkXLgiBtjmYTYDG0PYxzMcWBLoEzHnZMmiKq8nPXriyMlihP640DJ+DJ91mlfBRXjW48f3cCd0T/2QAcHvl3hGSrFZefWNC2rqh6Yx8wueAsGZr/q8zJkwG6pDcJZyn10VGAfOLbPekOIenMGuMNCJwEuD1jiT+P47+xwafBALhz0g2j+JWZAER4gmkzHiqnUTFfIfLeeDaXW87ZdcDxKy42w5/;4:G21MNltl0jqqVCD+jWKhnqnSbvZnduZta3983IzIH9M/tFO83rTIfFZycWrwWEFig/p3SMDIG7PY9pKas4pauhwFMq9lTJEDsoesOfjFIhA3hyrWKjMRCwWLVhc3YBRc3hI+44qulKr6zzfLMjX6n9AAydxtyxfDaJCzSU6qJQCk3ebW1CgmbGi5BARtMkYbw1lBQJtlyecqmxPk04e/FBuhv1bdxbh3p5t5AItYub/HnaFrri0Q9ly3pb5tNXWwweLYtqXv/QBdXGJPQsWe6qnIbPFnoC6ieFge2DiFCSe/JYU7u3/6KIo6ak6wH7sw
X-Microsoft-Antispam-PRVS: <VI1PR04MB321683C35E6ED705CDAFFF0FE0A80@VI1PR04MB3216.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB3216;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3216;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(366004)(199004)(189003)(316002)(446003)(47776003)(66066001)(105586002)(5660300001)(16586007)(53936002)(6506007)(386003)(97736004)(86362001)(76176011)(305945005)(7736002)(6512007)(6486002)(3846002)(50226002)(81166006)(6116002)(16526019)(8936002)(50466002)(81156014)(478600001)(8676002)(6666003)(6636002)(118296001)(106356001)(39060400002)(48376002)(26005)(36756003)(25786009)(51416003)(68736007)(4326008)(52116002)(2906002)(11346002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3216;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3216;23:4tobq3FHpHId2mz/rCqK/lSDnQPLog6Domt38Vuvo?=
 =?us-ascii?Q?qX5H3QpRVifM+5fxGdMvTNVioKX0eYdNEAp5JbFvI3JKIvU6n8DS2K61zAJa?=
 =?us-ascii?Q?lGyPPTy+dO1RxV9HY5iG+59U2zsd4aXSzm/O+d81hcUGRLQpsyK8fXTC+9Jx?=
 =?us-ascii?Q?UButH2wjeug7S8XP8vWpy3lPu4nwDdWIjcjXY6pMgDKOxUn4Rh0FWK86M4f7?=
 =?us-ascii?Q?sY2ekFGyQ5Qm50qMfXz4nzVOU6ofvVPYViwo7CwN0sgR3QD1UmM9OEDrI7bG?=
 =?us-ascii?Q?Sw/kWH48TGwFnI1tvj7Igb8NDaqeDEG7fQb1nA0qdP0WmNAbotJLCKhlfIxv?=
 =?us-ascii?Q?6pQ26CrJZDecDNdr6uOwircr6nMKRGCJ9RqCvNtSYKzUFg9nzGUhrS472GlV?=
 =?us-ascii?Q?cHPrQN5kuF8ySfKq4oV86q8EUu6WyDufH6auGxZMVY99mebOHutJkrJ8DTZ6?=
 =?us-ascii?Q?D03AuxO9Z7mmQz1OETUOUrDJSiSQR+p1OViYtkbMU4mHOnKoHvVJpr/U4bYA?=
 =?us-ascii?Q?SE0tnP/0QsYJeHzmVPn0FdfnOQ4CBXPyJoYwaIogg0CybE5aq8moAY4Pcdg8?=
 =?us-ascii?Q?AcBAYLgqz9A+ufZSxP0d+ZyzobLt0nqOqJMKuG9uREmQGHbQ0rBYj5bsj9bi?=
 =?us-ascii?Q?s7fRfpKZjxCtj7DIHylYCBUrintILpfH7ftQHX0PVBUQuA/PuQgHXqJbZ2UE?=
 =?us-ascii?Q?thD2LPtmez//wUe/D/cm/nEti956qC7aCVrdVQWWnjSmabOe6ICkgnjUbecC?=
 =?us-ascii?Q?Ik43K194OwFzS7+USWxZSH4fIP/qWqOMcrNeenk4foznG32uR487ejfmlyRe?=
 =?us-ascii?Q?baoUmOOarHtVbCl0ICzl3YWDPGoxIFWkr0Um5hZPgXuciGCm4rKn/2B5KoI7?=
 =?us-ascii?Q?YBf4K3qj6YrpfN+NPmv1D/LK/dD8DDAVZt4Nmxv4qkL6HmIrhA0sREzd/J4T?=
 =?us-ascii?Q?fHqMc8ODgN0S51oN3uSTLD6CYpOOG4CqBeLt3sNYWwPyDkX7lSyeYO3lz2c5?=
 =?us-ascii?Q?GrlJoKolgpc9rn9id6tAzLAuiYL7RFF795Ik4ZrdwAXLD0ZJORTjownue9xI?=
 =?us-ascii?Q?2aIMdYsN2ua+ljyppzb3nmrtrzdfz/NzCENDCjNUi4qiulBBwTqt+vSS1lXi?=
 =?us-ascii?Q?jpbqWr+9Lwjfp5OnBV3b+c2c33dR2jaLlYon+o6Sk/tzKaOkqe59g=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6i54Nm3bE/t9xJraTcWb4s/Oduuoi14u2cYLfsvvlpm5PY4JLexU/Xu/jgNQt/gG1y+wEc+6wmnFZxjgqNvHafDdAgbTUmYUhWN1NCLYvn5OBhn9pW2HdjITBOE4GBKVcipRNR4tWKfx4C9AsN0e8/TSq6cIcbg2CZTR9SJx8k/TLoLlzvLI9bl2yHKZ26/H
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;6:lbmf6PsQSr1UQnWBZXcPC7WMtNCoY45s9uAe45AZQO8muV21Jwh7muHe7YhYPd0a+CE80bIU79+/a7j1x8fYO21iB69J42Rw7g/FIMa1jmuiSJMZXQAN/7DiJ0qr0LYQwiAj2OFZwpFeGuUehxy5b07XvlE5zeKoMFihkdxLhGhfyWAmI1GOk7/rcY18B+Mz8XOPxpjiKhssuQWFLjdVzwmkwPhck/LMN5/1LOdtABN6jhBCyJrroA8V5bxfzup0tTlbP85izKofMpJpZVFDPSAuNxLS/nfRi/vTm49lb6T7VgxHgCVaFSF6gOApUoxf17QqA01AP+wno+BQXMWRe2hK0FDvCwntiw3dLfi2tZU=;5:aWBLJqq50DRw0Evhv5XyD0uVGhNUHKrqL8jLzEALjJog3YLi9WZ9kHpwH3TvDlOC3iAcDJHLcH0jvM6DBRVs3iS22uX9Iy3bFeSp53khELamcamrw+Vz/jq/Hixs9Ymtq7Ca2mKsN9B9gNt46EyNTl4tkpxOeAouIjS+kvFnUag=;24:iHPSonFdTDUJtB08DRUbNfMIvkXo8LunBGt6PUHg5ofLoqSgK2HSTAE2L/mfskadT8yjEr/9cFDOJi7eZtcWvbrMYlAvs9bS08jneml3hh0=;7:aar+oCMNrBD3TKipOls82OChZzTeAWNkz0Gy/TiP6Uzp44ZETy7ICjCqA7FRtnQIcHUpupE9YW714E/raEF5qHS71n1iRki/F5mlaQMaY7/BW4g1zxoI7OoJBEYnERp2El2+gNAt0D5e1gd1jmU8U4EL6rXJVH34xjlUCi+V5DfjyJtu8cXm6zJp6umQOzYhlZdvam3erCvjeu+HWzVyV7XiQKDOIH1oPMg8BkkuBr2Fk1+gYADQhK0aJ2Z3w9Fv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:39:40.1871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7ab076-4759-43ba-5263-08d590d44c1c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3216
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743493974291957?=
X-GMAIL-MSGID: =?utf-8?q?1595743493974291957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Define "struct fsl_mc_command" as a structure that can cross the
user/kernel boundary. Also change the variable types used with
the proper ones.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - added the patch itself
Changes in v3:
  - added the correct license for UAPI files

 MAINTAINERS                 |  1 +
 include/linux/fsl/mc.h      |  8 +-------
 include/uapi/linux/fsl_mc.h | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/fsl_mc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 61fd418..861cf1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11485,6 +11485,7 @@ S:	Maintained
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
index 0000000..54590a2
--- /dev/null
+++ b/include/uapi/linux/fsl_mc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
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
