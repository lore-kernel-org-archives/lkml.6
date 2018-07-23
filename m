Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1BBECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C5A20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h44cSYVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C5A20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbeGWSDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:03:45 -0400
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:16672
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388236AbeGWSDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xe4bTCOnz+rR7Mysxu8fEOPpliQmrKVSBXiujyPOj8=;
 b=h44cSYVrKx2WmHzWAuya+p4sqKhvxC3eLsLUklKt7sHw5Hy9r4nJn9RnYg/IBNcIBpkIiPdLOMj9pEiFbYb/pzdOGwLwE/jyz4JVxbZz8PsBZPUYy3n1Vrhdm1bAMEXC9AIxZoLqfF7BYA//X3NycE4yBcGLeHpKeJ8XXC6UmIo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 VI1PR04MB4494.eurprd04.prod.outlook.com (2603:10a6:803:69::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 17:00:51 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 3/4] drivers/staging: Remove fsl-mc driver from staging
Date:   Mon, 23 Jul 2018 12:00:24 -0500
Message-Id: <20180723170025.2259-4-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180723170025.2259-1-roy.pledge@nxp.com>
References: <20180723170025.2259-1-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:805::34) To VI1PR04MB4494.eurprd04.prod.outlook.com
 (2603:10a6:803:69::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e02fcc9-0ed5-4af1-f574-08d5f0bdd9c6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4494;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;3:FUGf6iEGLJBlGNH0/2yDF5G+xtDA6WmUZpRpbfIFECcuME2Ec1kZ6cHffqX+a6Hq8bf/AWC+A1R4UXq+mAgDVp+c/0Q2um5svj5B/cdAezVXWYVovMpX2t4ffp+p3KHXMbEfVyjZi3hIAbm4hqUJ4Y0IohjGWxWaqh7zOGcfsDyn60Xg3Im0aeDyD7gYFOd9qLm3kDWZIXI9RLV2eghQokHRM+o3nFFPEYl0o25M8TQDItZ07vMH8joLp7kg8hPD;25:9O7Xh+U+uRtCdpzXH8wrTDF7kg3d+THNTyYGXYg2uRLl+gGsU57qAbphsNxshXy0Io4iyI6ZkhSqDXqyyIFCiGcaFNB/pp79m+/MgXUDxMzRwl+98y8byQeKzHSAZHLj64BOVCWHtuoGCk+Ch6PoEHEHwo3AusjnA8o1SaGusANqKCHnK3wDNX7ikKqEArrjNJEumJQI2YRG5Cv5WBOb75PFlEvlg6eRwrwWVEdUW/LVZAE6nIjW/ndeUgqROcZQYsT6Uh03aHD76slm9FvXUofYgv9mNkv3npJShkgJfpIh+xHU7U3sdvu0Aevmp3eddW7dHd0D2BvHEyeY+5+2VA==;31:havPb8qiWLakWnXn3LXecGhhu0c4kPQHLtERUeK0OBs/9MUlXjr6SH76hdoTlNiJiY3lyKUsi/ixK0gzrIfBT8t+H3GOJFZg3l1sMxNKw7LAqgTohattU1npV7pFKgfo99DQTzxPibD/ThbeEfx9OWcqdw9TRRpmzqorNlsFW8p6d/IHTtOGvnd5n8xmFDjC4qVZDVCIL/ZxR9/oCQDwOEgBapeIqWXAnZjdiOPEegg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4494:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;20:57MEq63nqfOKukfHEYhK2GL0aQZQCGGCZi7ha/FfNkmwK+riXg12/54Hrr2vWtRC0RdyxcT5g5QhExOqK5h/YRFvoD4H79PRTVAKP+kUcI7MGcJ2gaybfGdgEkb7kYw9ool3H+NotZb7siFq4Ug7oxk79j38OHBgoVJz2HWoEgS4dL9xv26qDjGSLeZz907uuVP52gyaoRfA8pE2JcDBk06DCjZziV1RJg7/PMphaigtOij+ZHfdZQHHxStpIiC/dLzqPoxyK5npxCRYixbtMHO03D19ZTMgco09y91DU1B6+yd9HcV8u8xVNKpeNtxfL2F/2nZOknW67SdwqxFZidvZEZIq0G4HJy8xu9S3FKt7V1WZlRIPxra2UVNdyNCGv46OCcLhV9XyB4vdfBZZcSCj+BI6tfV9XhhGoe46pJGbRrK8txkLbYHVlGLf1aYYX7lhaJ8T/G4iRLxu3eDJdp/FQh7Oi59ziVecR1RyNyT+lwVnoA+hRdQibcyG1QxC;4:gl6bdPEW+LlKL4eu4NyKjE09/O9fKuLq2wtnEHcVnVR4SHtXUV1VI0ujyX8/v8E2pL51l5Ck2c+ogQqegmc/EFE7VusqiBR5pU04lHEd7TaeurPxfCaXra7mJXoRfDDZPw9qgiCVRZ04v66VMXqj36DbIT67MxGusoINMmWX3nLHhOC5sJj8iQ0yfhn/llvGCaJOLITQg7fT/qO9Aoys+bwn0B9n0zqeaJVVAgz9y+pf6WxX9gmEEpF4Ie7PhsSCzeOX5mmt6GqS0rye8adexM2Bb9tR7qHe4OdPusGfcHpb9q6RMH/qjHLMK2hUkc6n
X-Microsoft-Antispam-PRVS: <VI1PR04MB449473E03C4C7A32EF975E8186560@VI1PR04MB4494.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4494;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4494;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(7736002)(386003)(6506007)(76176011)(105586002)(5660300001)(6666003)(186003)(2906002)(16526019)(6636002)(26005)(47776003)(8936002)(316002)(81156014)(3846002)(6116002)(50226002)(53936002)(476003)(4326008)(68736007)(106356001)(446003)(11346002)(956004)(2616005)(25786009)(14444005)(43066004)(6486002)(16586007)(48376002)(50466002)(51416003)(66066001)(52116002)(478600001)(8676002)(86362001)(3450700001)(1076002)(44832011)(81166006)(36756003)(486006)(305945005)(6512007)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4494;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4494;23:ENWOn8gdDzycdfXqRExCI2M7qb8T9GiBM8iYCc6rG?=
 =?us-ascii?Q?mivYRV9weBmVND/Das6076QXHJCQQN6YN1gcnEZknM9bZD1aB51Eq7FOQt7w?=
 =?us-ascii?Q?2dE99CSkvQ+JwSvflB/7b34BiAkHH0t8kacRlcYj0ThL0s+maJPUclwTu+Mr?=
 =?us-ascii?Q?03//JRTlL0CMKygOcZ3WWwN3f4VImmVFoQY9EjrOAFtmlSFaCM/SbpFB3vMf?=
 =?us-ascii?Q?6/6JU53QWMg141o9zJtnt9LpBfprURDc9JHQS6J7/qocO3S6A/skAoC02Rc0?=
 =?us-ascii?Q?7KfPN7KDmW1HwpOlxo1P9O7FPo80kxY3eSwsdHai7qNWSLo3pWMzKvrEx/cK?=
 =?us-ascii?Q?cTHrUb+SqOUe7J9y3xDJ4yr+CuuTAdikAmkHR9A5v9/rZT5BOpcuH4glZnl0?=
 =?us-ascii?Q?4BpFh6tO2rBbYcHKVJwvfkTLw9j7z/DpiQj5KrrSlVtyoHlci0+BzZOYhq6E?=
 =?us-ascii?Q?7EPlz/3ox/ELCydFUu9plaOPRhiddiHiyxSZjhmYBFLyPtZwzjd9I/+Fx9Ym?=
 =?us-ascii?Q?MtYYVSiH+pc573g1Yw0eLlmWwgfuSy66ZbaeMJXArG3IhxMcJoj79L4bzqIc?=
 =?us-ascii?Q?/Utdj11jvIMm+UqzrHBb2Z/L6v0ksB3Bspp9W+uvI0UbM7hQ+9/eGwjCush4?=
 =?us-ascii?Q?SJDcx99NrhmF++cKvr3k3oqfTvQRA/5fqx6QLZxUGqcdiOCyDasvtfvgqGTA?=
 =?us-ascii?Q?QEJJSEktOesenunxHilyAe+Bnc77GeitEM++Ec85eZGppY9OG6M+D6tevwmE?=
 =?us-ascii?Q?esWjwqpFr+ttJCNsj/9KX/66/4z5fHpIL9ytg+MVt8XWsorFY0cg+pnlFh8X?=
 =?us-ascii?Q?5RW9pei7l5OXBT6my/+rPaY75B/JahA8CLi/7lPboaqXfm22/nljOBGo4C2R?=
 =?us-ascii?Q?0cDG4ZTrMM+ha31T4WW7+6NToZ7cFi7DibmgNuvQkG7NNi35FwUc6d77Mmo4?=
 =?us-ascii?Q?Fh3ZY4V/EYTtLSqGMtkFNwVlyL/y9YAD+jNR61Fqt/AuraRzvzI5R1c7ZPNI?=
 =?us-ascii?Q?0OHrgpo8LxNgwKcKs/caPNxCu7ZROUy6mZ7WVf6/Yz4rOWt5JJYU9s/8VdwN?=
 =?us-ascii?Q?xKVALvTOKMR9Nv+mctl21WJRVEN1iLAic97qcsMQ5W6AEmtAUPCpEFU7fcuC?=
 =?us-ascii?Q?hpdxr7ifGCY62GBMv+OjGJR5To5Ed3kNlfZGDwJfBX1lyxMZZNrOSg1GuDAX?=
 =?us-ascii?Q?uxljv5HEH0qHXAGBK+JqFPtDAGRHlvcF4+sRDFrdq35JOtwliUqslYdkZ1ph?=
 =?us-ascii?Q?pC2GXO0MA/rUkCC1nwfbJWGkCi+GLe+3ftx589H?=
X-Microsoft-Antispam-Message-Info: 6aHTElT8uPH4tmDdT2VI5Oou1VUDphgyzWnLoYENMnRR5j91lXTTkE37EUs+gHuE7kntAS2uTfmv5XpB1QEGrrJ8y9tbtpzXTrRq3NSjQzmNHOtGLCLhj3bRv0PeF/ELCvsZ2v6npoDPGwAVyBUfZjcsrtcMYHlNW5HeG1/jqCV+P+Akozezq7EvLlDNrY6F7B5JPZOcNCRBpoiHnUe+1zOVKryA5iD1mdR97y1+XOrEFmAIr/q9Z3o3Df31rrPOWSwUbjU2aWEpedrFLMjmIGzw/l+AfE2BCwJ5sBJYBResl+Xa+DynwUBgNLzf0wZpGDkzI7DDgIixHdEcvEuPm6XBTfEzzdzkixcexhbMEd8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;6:fJvYk90Z5aHfDa9ZcL1886ouh5UXD7EmpoRf+ldAtB51n9ZCrv5Qz7IrhXK3fl61GOx2BYsrGgW95hhTPn7taUdT0Oq+ZbWXFHKzkSIq3N45SkxGpLimjeJRqwUvzf5qkjhgLexVHm3PUZXi/3CPJq9XOhA7BFFAE8nRwUmhoKdkGTijw3c4HWWnkzQkQqI+VEQxIcx77SDO7JXLlnj2yG00gfi5zkEy6FM/KmQ2WAqhBQpWt7gasPldND7jQlWSM55GlazUOy0PLQhVI7IQoj3i5I/3Ym+tio4KsscWdkSauzGsJvGv9nlVjY6cpmbFc7U47nL2T2IWPiDWZh70KPfdEbKr7qSGiPcPKp11WfnFx4BYUXbxjw6Ab0csAg3z98KUe6kVN4J463WUWLwgAqwKZqZ9dSufKzgOC516an1Phz0DPop66t/Rss+qzZaZFmNWgWQSJweqVFkdXmwKQg==;5:lFyqqz8rGYfRJl1oTabM8v2Jgl8j2d01rqAI3nqkKF9WBHoLVXlWQL0Xbd88aOW5uZhrCTrpKordcz1CNQ3WFb01Jpq+MLN9n1lYhT+IocoMl6/JuPYZZmoNXET6/UR0tOx8vehzF8HDCB+eb84Fp0JsIOWPBmWi0Hc/hoyx9vw=;7:zO5MFc3j8Go2JaJdVswHqR4e9Joj2E7R3NzoGl7AOhwUjYS1Cs2Oxuoy/BDU4gDmgDKHY68+Z6lNivAPFP5Lqcf9434pqYfEMHWWod1SMVKjhGVSxzjNJ9XadyImNw+aK6eD1hpkaf+yhQnOluQTwIizjbzEk5Fk5oiyc0DcjK3r5baxbAUHPu/Uk0zQsj72s7j/7Ha6xSGYLS2OZcTM3MzeJTuWW1TIaI01FPeVdydZ5lyyyqJKXTH2RWRSeAYu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 17:00:51.5660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e02fcc9-0ed5-4af1-f574-08d5f0bdd9c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the staging/drivers/fsl-mc directory from the staging
area now that all the components have been moved to the main
kernel areas.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/Kconfig             | 2 --
 drivers/staging/Makefile            | 1 -
 drivers/staging/fsl-mc/Kconfig      | 2 --
 drivers/staging/fsl-mc/Makefile     | 3 ---
 drivers/staging/fsl-mc/bus/Kconfig  | 7 -------
 drivers/staging/fsl-mc/bus/Makefile | 7 -------
 6 files changed, 22 deletions(-)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 75a4804..47b61c3 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -92,8 +92,6 @@ source "drivers/staging/clocking-wizard/Kconfig"
 
 source "drivers/staging/fbtft/Kconfig"
 
-source "drivers/staging/fsl-mc/Kconfig"
-
 source "drivers/staging/fsl-dpaa2/Kconfig"
 
 source "drivers/staging/wilc1000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index e84959a..bfef8f2 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_CRYPTO_SKEIN)	+= skein/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
 obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
-obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 obj-$(CONFIG_FSL_DPAA2)		+= fsl-dpaa2/
 obj-$(CONFIG_WILC1000)		+= wilc1000/
 obj-$(CONFIG_MOST)		+= most/
diff --git a/drivers/staging/fsl-mc/Kconfig b/drivers/staging/fsl-mc/Kconfig
deleted file mode 100644
index 3002229..0000000
--- a/drivers/staging/fsl-mc/Kconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-source "drivers/staging/fsl-mc/bus/Kconfig"
diff --git a/drivers/staging/fsl-mc/Makefile b/drivers/staging/fsl-mc/Makefile
deleted file mode 100644
index 1468388..0000000
--- a/drivers/staging/fsl-mc/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Freescale Management Complex (MC) bus drivers
-obj-$(CONFIG_FSL_MC_BUS)	+= bus/
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
deleted file mode 100644
index 90f234d..0000000
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# DPAA2 fsl-mc bus
-#
-# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
-#
-
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
deleted file mode 100644
index 2141e4b..0000000
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Freescale Management Complex (MC) bus drivers
-#
-# Copyright (C) 2014 Freescale Semiconductor, Inc.
-#
-
-- 
2.7.4

