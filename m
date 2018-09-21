Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA3EECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9246E21479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="o0k8PCIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9246E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbeIUR2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:28:22 -0400
Received: from mail-co1nam03on0077.outbound.protection.outlook.com ([104.47.40.77]:40394
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389680AbeIUR2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snXN4FB/ki8tdSk8dQlBGlF6YjO+i0PGiUXO9jARm8s=;
 b=o0k8PCIvFl9UB7+jCPMkPMfEfX1aAyPY0ociMfOUC5S459TVEU74aSPdfHkE+Dt9+ZZ58Ml9w9dxALV4Nbms+TkIWvOu+xnos8w9Ap2VrulzwFMTjwIWSv8QqLOCoXks6b+ymm/CnqXbPKuRl3mCTonWayrWd8uFHZENOC4e46w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1621.caveonetworks.com (115.113.156.2) by
 SN6PR07MB4622.namprd07.prod.outlook.com (2603:10b6:805:3a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 11:39:12 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH cryptodev-2.6 3/3] crypto: cavium/nitrox - updated debugfs information.
Date:   Fri, 21 Sep 2018 17:08:02 +0530
Message-Id: <20180921113802.26475-3-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921113802.26475-1-Jampala.Srikanth@cavium.com>
References: <20180921113802.26475-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: MA1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::16) To SN6PR07MB4622.namprd07.prod.outlook.com
 (2603:10b6:805:3a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6262cb-65ec-4ee5-1cc5-08d61fb6db5e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4622;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;3:9d0Tj4PijAfrG+EBC+wjfSOgGhC/mrqAZ5T0WzhOB9VCSorKJpmyaDDm2opKnkcSd6YIxUFRWnj4xVnhfwt18Qa9rrPrWoYuvaz2RVzPztbQxanoHgeQMCVcEbEipskyvvy2HUrSvS+VLCwMvMU7dAoOy5CpE1wI4zfhvjYcB9R2T8YGzXLmbztz7Qy0y9uibbOLYZRPVnHoHqaA1o4tyNWFVZuWX9EeylQ+wPySLL1Pkig158vzPyecC9D+8Gyc;25:F/S7hS39oCD3Vz4ujbjZgGdrOYWT1cfatJHqy6wybfyYHeP8G/5E9R66ITfAZG02HWdYKMGJfT2PPiHjlQ7ViGx8Q1cFrvDI1hD0C4TKmgTiBwn6uv4yPy6aqK3RIuMO16OIYtxUOgI8oH/rIR11nkWzcUiPb3H2qwOJRdcoe23gNpyj3e9ue9QH06ogUSUhzqSHo84TCm7okO1+IvkCXkxr543gjg6q0pnAZLyTtFPG7/mJY1cwKige8tj7+sChjiHfLgppnfwQIKuz5JOS+RSukPQs/PfslI6TrcP6rF5p0Aqoso3KOI5Fac+gwEWE5AiPrJaeh/h6cDl/Ugmbaw==;31:P7v4KiM5nIoI/4IZMz4ASDvL6Jkb22WTLr8rscvsNBMlpyM0t6JVTxsbraq4y7ZYE6R7mQ4vLCIfhYITV6Hrnu0pknGymQlWGmahCdfXWxoikcc/GhXBTmI2piwOd7pui6sPVmzgJ5J6z6RVB8EZ8WQsibKTQjTloB3gN9rFuaTqOGWstztEbGF6jG2EPsVp3yW70Yy+x5huO04oVDELVf1vTn0Ixi+HJ5UNcs9oifA=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4622:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;20:MAEomXFRhC28ZtoKWaib8s3xad34ZiRCCKQYTaxRB9fENoTvk6TkVf6Qrjh8sCe1Z7+L8iV+aIM9atdqIoJtyE/+JuD+V6/4BrtTnYhsHIJAqUIOJO8QrDR4U1sKy2SY9uXGuFr8SO3MbrbIEJ7BRRBRDXr6d/WCVit6VuY6j6lRYwuAqT5KY1eTdeWSUZkwJbLhguzh0+C/AzyprEgsIJUtTvhxkPSC2yqXtC+303hrzcuE5IDtQ+zbEiun/TztD3k480z2rowv+lDumR0zujq4WMKbt6lAY7B33sgBO8kvfiFul5jOOiDsfEYOiVVK2vQumrIEJEj6bPuQbo17Umnlv4pa+3icgqnvCHB+ftN1r2DCi+z1Y1syW73R6JbXsXaRGD1UV3ictm9gwewM2+YlwHuXZPlthDDZcR0xRO8ASPr/00tZWIhCihltq5oTV/xTCPH3R436qwDEQ+IF7KPvzfRznVfGB7CMwkYF3VKtMGVs8o8nu0y6ilCvcQdV;4:DHRPYk1IuEJvrpqq+gS75S2+/e57vfA4WqH0lk/wE2teQgn4x8PbnHq3cxxjzJBBI2WCWn1X26N+0XikmQUJUg3beBqXnIp6UCpUcqFLzrtjwccCwdYzdFuxQiObiriC4Xi77FECYIJU+bIqjEEbBdhJ6tUL68+CfRH8mUFQyNNPCk7AiYKrZe1Dr3uiZ6qEI3KMegDMwcU/Lg0v/K6FZxnXZbSQ+uUt6q8hn9r2sDxA9vYGSuDOFRdzEROawNy1Koh9BEiD+w2SEt5gcheldw==
X-Microsoft-Antispam-PRVS: <SN6PR07MB46228E392F8CFE79AD3D08E3F4120@SN6PR07MB4622.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:SN6PR07MB4622;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4622;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(316002)(97736004)(16586007)(6506007)(47776003)(16526019)(8936002)(76176011)(107886003)(106356001)(81166006)(53416004)(5660300001)(3846002)(69596002)(52116002)(51416003)(14444005)(1076002)(105586002)(4326008)(86362001)(8676002)(6486002)(6116002)(305945005)(6512007)(186003)(6666003)(7736002)(476003)(15650500001)(72206003)(26005)(478600001)(446003)(48376002)(486006)(50466002)(11346002)(956004)(2616005)(25786009)(66066001)(386003)(81156014)(68736007)(36756003)(50226002)(2906002)(55236004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4622;H:hyd1621.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4622;23:dPwWO2kpXRiHcybQu2UzhR9VxH2vNk0HkOa+AtNOQ?=
 =?us-ascii?Q?+GW4MLEcBLb8HcWOOwV/7VKWV2Q14GXIWoyHKycCH7/Io2STsfWt34iXDJ1W?=
 =?us-ascii?Q?f5Tdsqv6jgqgJALC9QYzSfoYWPTZnVx4FBqO/u1gvc8BdVjL1PM9hs6Alv8/?=
 =?us-ascii?Q?gyFCmwakAhsddit8IVapqIzmX3//adhCtXHDUi4Ck3VuAXkiFzQoHCOOZqIl?=
 =?us-ascii?Q?vItuuseNS0ck2U2sNsBthcnMZjOQzNjsQtFxAqkgmEf/9GEEsQD3BtDjnYWy?=
 =?us-ascii?Q?L+o4N/gdpc8xQAeJ1uy/9AIpbaRSB4uZkKQ+6lJQeUFYlffaPH/gTuzNI0Un?=
 =?us-ascii?Q?0J7Z3C1r2+gpyH7nAylTUYRPq2YbZfKdl6f5WX3FqRqaK5i2HIorTp59RC4D?=
 =?us-ascii?Q?3YKm7SwNF4eeH3mPTSyIZ16fWYVzRKjdbHWWe5nkA1gWG1aIOX2JjuCHZCut?=
 =?us-ascii?Q?M9mpqlPJ0o7yMe3/h4xu/yATw/vM+tdHHrHUS+tMfRpy8qIDKFFR7eHqrBnQ?=
 =?us-ascii?Q?gjh/E9L2EVaO9UHpOTH1D6mGBtwbeFvnRn2YfJt8mYok4i+5OUfdERcj3eTQ?=
 =?us-ascii?Q?MPq1oqVlwdsIcj6uGB6YJ1C3YQM0Czo4TfgI7oq2gti0nhBLpWzAVTbK8yN8?=
 =?us-ascii?Q?zNi0CHPiV7vt9z659W3pf7OU5U2vgPsGeyVsIsA6fALn2VzC+zJA3JLykcF6?=
 =?us-ascii?Q?MS1XHg/my/17dI9Vuew88XMUavWyx6Ttwd2Z+MBKNP4CPTuVPooVHju09WIJ?=
 =?us-ascii?Q?Yq0rm/xmxVKmfd5SSP+0D9Uu9MevX3Oc83hZruIE5z8Pgy/86o89hwso4exv?=
 =?us-ascii?Q?GVbXzByQKMb2QqR16IKEMm9uSI5ywOroAXgY5e1ac11YpRHcnIOawyZrmAF4?=
 =?us-ascii?Q?Fb5sUqtk2cU84FvwtrNJVY9ac5J/FaQFI/pYjRkRBC6D8QWlw+id1bZzy2cI?=
 =?us-ascii?Q?8/02/4gnk/sM97IbMe929p2qESninYOq9J5e8vx8w66ON5E4Ax2Xa6GyXdLH?=
 =?us-ascii?Q?v/cGs4sF/Vr+ZM9XH3G85y49k9vF0GfgL4pYyuAuQlMenxeFaOx/y72MRr0G?=
 =?us-ascii?Q?tTy/RWgNVx1ei5CFpEjfAQRPcuSq+FtwPNWQIgni3AJKEvUEIrVqs6WOGCbG?=
 =?us-ascii?Q?ClBV/qM9C60JFYSYfDK0aFOpTghmEqMcIr7zmALXNsq/9YT57wRZ7cJmy0oF?=
 =?us-ascii?Q?CUwOO0tRlEG7U4KP5PxwHnlqSdE4X+hBLwxc8FiTfKF8Hxr3yzk783Ccndwi?=
 =?us-ascii?Q?nEslaUc+qlFEV5TYBTRCrFsydXL4KodI+oWDuvUTwXFyt3kiE0W2Bsc/9p6F?=
 =?us-ascii?Q?LM1+hQmbiM9+0jaahR05yk=3D?=
X-Microsoft-Antispam-Message-Info: 2bBUk1rLyMUwmhaWRQMkj22oFDNQZGbYc9Rj9VFadA38oiNdyPXG3d4j4QEzdBWvjnSCmGNOVxmyKHul+ZyPish1IysooiLogvLFpdylOfBZHcGdfSlc6TfAhNb9EU218ce3yu98a6GQYKJa0Yn4ilP7qRXS+NgmfNJG5okhkDjT/TeZ4bJbcaoE1hagIZuFyZrO1xPznUXcUJGVRsmpxWM3WDcdBxuwzszuJecvTtMKCt+tf1eJA0dadNZJEnUTvf3LlY22mPFu7FPM9bTII1iNYlZu8DJRRMdy0WNYMrHZiIyT4i80nzoL5RREwT1N8lweEWkTkAXu2Q5Mgpny8hIyc+XUkIf7y7vs3RFSMnw=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;6:uCOng0G03i5LEkslUQ50F29TLKOeZ15QikOYIMfYsjZupcWeym8HRQaaoBodBJS+AicnQWNuQMrxhNGimAW3+I6ugVhSSFvcuxTZITokDLFJMJ8tKfaxAIS4wdmNOhYM1oP452cJF5FAWkRCKoswtVw3+m2O1N/BVtwXdGisM8SBxNXrXiSRjRv9rJZXztKHJ3cE+ty8A3cwMxzMdX1C0Ds3iP1CyfZt88GOyGUoKlI6ny7tPCnn1QM4yF7mKDA9iL3FRC4ftJxG45+MtacStPG8hOUhoyW4GwB3czWG5hVvQ6U4oVAi+4H89JImf8SIHWI0lMi2igUTikeiT1tfuYR5xpG8m51Y1qk/EvpMCOQpa4galVUNvP+/yTGk2ONpjTVcJhvSSdhH26RKFyu6F9sJeP7HmDZzSlzqnLyC0gzWoNo0/KYPwmPFqnvO4MMIPHC14aExIveYw01F6O+tRA==;5:vog4BKL4kVSO9C+8ocqovH41BVaxVwlfqxB1octub9JOSVP/IuqahK8mh9I/E9Nk2QWOkD38mKK+mW7uImfch+Wu1CR+Mk/q7hwsOxT8dt3rTmW3py50/pxNu4cs1Cvfech2v3YzcW1mNyxXAnK9AG0dEld/6HZk5Hh5VlYp4yA=;7:22CS+RZmwj7kiP399CmwXsHwEItobElyzgr3UzdRTe/+P/iTKybxPIXF2Z9erCgTk7t/vpdlcRw+7FgTf2CNmcPmx/aBWH0DY8OUG+RrzRvRcyRqEYjd5U+Ukxc4++12Um34LzSzBUirmNeqJpYoC1WOEgMrqKtu1/XzrPayTeIbGOky/BC4S4LhlVsQHqUwgAvXtp+8zPsb6JYSW2gVLBGLiyDd3vOJ/gpJaKqbnch64m8GaFp6AGUczTTGRhQv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:39:12.4206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6262cb-65ec-4ee5-1cc5-08d61fb6db5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated debugfs to provide device partname and frequency etc.
New file "stats" shows the number of requests posted, dropped and
completed.

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
---
 drivers/crypto/cavium/nitrox/Makefile         |   1 +
 drivers/crypto/cavium/nitrox/nitrox_debugfs.c | 113 +++++++++++++++
 drivers/crypto/cavium/nitrox/nitrox_dev.h     |  13 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    | 129 ------------------
 4 files changed, 127 insertions(+), 129 deletions(-)
 create mode 100644 drivers/crypto/cavium/nitrox/nitrox_debugfs.c

diff --git a/drivers/crypto/cavium/nitrox/Makefile b/drivers/crypto/cavium/nitrox/Makefile
index 6fcda6b56f7e..e12954791673 100644
--- a/drivers/crypto/cavium/nitrox/Makefile
+++ b/drivers/crypto/cavium/nitrox/Makefile
@@ -9,3 +9,4 @@ n5pf-objs := nitrox_main.o \
 	nitrox_algs.o
 
 n5pf-$(CONFIG_PCI_IOV) += nitrox_sriov.o
+n5pf-$(CONFIG_DEBUG_FS) += nitrox_debugfs.o
diff --git a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
new file mode 100644
index 000000000000..2f1e74ea846e
--- /dev/null
+++ b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+
+#include "nitrox_csr.h"
+#include "nitrox_dev.h"
+
+static int firmware_show(struct seq_file *s, void *v)
+{
+	struct nitrox_device *ndev = s->private;
+
+	seq_printf(s, "Version: %s\n", ndev->hw.fw_name);
+	return 0;
+}
+
+static int firmware_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, firmware_show, inode->i_private);
+}
+
+static const struct file_operations firmware_fops = {
+	.owner = THIS_MODULE,
+	.open = firmware_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int device_show(struct seq_file *s, void *v)
+{
+	struct nitrox_device *ndev = s->private;
+
+	seq_printf(s, "NITROX [%d]\n", ndev->idx);
+	seq_printf(s, "  Part Name: %s\n", ndev->hw.partname);
+	seq_printf(s, "  Frequency: %d MHz\n", ndev->hw.freq);
+	seq_printf(s, "  Device ID: 0x%0x\n", ndev->hw.device_id);
+	seq_printf(s, "  Revision ID: 0x%0x\n", ndev->hw.revision_id);
+	seq_printf(s, "  Cores: [AE=%u  SE=%u  ZIP=%u]\n",
+		   ndev->hw.ae_cores, ndev->hw.se_cores, ndev->hw.zip_cores);
+
+	return 0;
+}
+
+static int nitrox_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, device_show, inode->i_private);
+}
+
+static const struct file_operations nitrox_fops = {
+	.owner = THIS_MODULE,
+	.open = nitrox_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int stats_show(struct seq_file *s, void *v)
+{
+	struct nitrox_device *ndev = s->private;
+
+	seq_printf(s, "NITROX [%d] Request Statistics\n", ndev->idx);
+	seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
+	seq_printf(s, "  Completed: %lld\n",
+		   atomic64_read(&ndev->stats.completed));
+	seq_printf(s, "  Dropped: %lld\n", atomic64_read(&ndev->stats.dropped));
+
+	return 0;
+}
+
+static int nitrox_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, stats_show, inode->i_private);
+}
+
+static const struct file_operations nitrox_stats_fops = {
+	.owner = THIS_MODULE,
+	.open = nitrox_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+void nitrox_debugfs_exit(struct nitrox_device *ndev)
+{
+	debugfs_remove_recursive(ndev->debugfs_dir);
+	ndev->debugfs_dir = NULL;
+}
+
+int nitrox_debugfs_init(struct nitrox_device *ndev)
+{
+	struct dentry *dir, *f;
+
+	dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (!dir)
+		return -ENOMEM;
+
+	ndev->debugfs_dir = dir;
+	f = debugfs_create_file("firmware", 0400, dir, ndev, &firmware_fops);
+	if (!f)
+		goto err;
+	f = debugfs_create_file("device", 0400, dir, ndev, &nitrox_fops);
+	if (!f)
+		goto err;
+	f = debugfs_create_file("stats", 0400, dir, ndev, &nitrox_stats_fops);
+	if (!f)
+		goto err;
+
+	return 0;
+
+err:
+	nitrox_debugfs_exit(ndev);
+	return -ENODEV;
+}
diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cavium/nitrox/nitrox_dev.h
index a1442006f256..abb5c8ac54e5 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -218,4 +218,17 @@ static inline bool nitrox_ready(struct nitrox_device *ndev)
 	return atomic_read(&ndev->state) == __NDEV_READY;
 }
 
+#ifdef CONFIG_DEBUG_FS
+int nitrox_debugfs_init(struct nitrox_device *ndev);
+void nitrox_debugfs_exit(struct nitrox_device *ndev);
+#else
+static inline int nitrox_debugfs_init(struct nitrox_device *ndev)
+{
+	return 0;
+}
+
+static inline void nitrox_debugfs_exit(struct nitrox_device *ndev)
+{ }
+#endif
+
 #endif /* __NITROX_DEV_H */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 362e7217354c..5bd97cff1405 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -323,135 +323,6 @@ static int nitrox_pf_hw_init(struct nitrox_device *ndev)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_DEBUG_FS)
-static int registers_show(struct seq_file *s, void *v)
-{
-	struct nitrox_device *ndev = s->private;
-	u64 offset;
-
-	/* NPS DMA stats */
-	offset = NPS_STATS_PKT_DMA_RD_CNT;
-	seq_printf(s, "NPS_STATS_PKT_DMA_RD_CNT  0x%016llx\n",
-		   nitrox_read_csr(ndev, offset));
-	offset = NPS_STATS_PKT_DMA_WR_CNT;
-	seq_printf(s, "NPS_STATS_PKT_DMA_WR_CNT  0x%016llx\n",
-		   nitrox_read_csr(ndev, offset));
-
-	/* BMI/BMO stats */
-	offset = BMI_NPS_PKT_CNT;
-	seq_printf(s, "BMI_NPS_PKT_CNT  0x%016llx\n",
-		   nitrox_read_csr(ndev, offset));
-	offset = BMO_NPS_SLC_PKT_CNT;
-	seq_printf(s, "BMO_NPS_PKT_CNT  0x%016llx\n",
-		   nitrox_read_csr(ndev, offset));
-
-	return 0;
-}
-
-static int registers_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, registers_show, inode->i_private);
-}
-
-static const struct file_operations register_fops = {
-	.owner = THIS_MODULE,
-	.open = registers_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int firmware_show(struct seq_file *s, void *v)
-{
-	struct nitrox_device *ndev = s->private;
-
-	seq_printf(s, "Version: %s\n", ndev->hw.fw_name);
-	return 0;
-}
-
-static int firmware_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, firmware_show, inode->i_private);
-}
-
-static const struct file_operations firmware_fops = {
-	.owner = THIS_MODULE,
-	.open = firmware_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int nitrox_show(struct seq_file *s, void *v)
-{
-	struct nitrox_device *ndev = s->private;
-
-	seq_printf(s, "NITROX-5 [idx: %d]\n", ndev->idx);
-	seq_printf(s, "  Revision ID: 0x%0x\n", ndev->hw.revision_id);
-	seq_printf(s, "  Cores [AE: %u  SE: %u]\n",
-		   ndev->hw.ae_cores, ndev->hw.se_cores);
-	seq_printf(s, "  Number of Queues: %u\n", ndev->nr_queues);
-	seq_printf(s, "  Queue length: %u\n", ndev->qlen);
-	seq_printf(s, "  Node: %u\n", ndev->node);
-
-	return 0;
-}
-
-static int nitrox_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nitrox_show, inode->i_private);
-}
-
-static const struct file_operations nitrox_fops = {
-	.owner = THIS_MODULE,
-	.open = nitrox_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static void nitrox_debugfs_exit(struct nitrox_device *ndev)
-{
-	debugfs_remove_recursive(ndev->debugfs_dir);
-	ndev->debugfs_dir = NULL;
-}
-
-static int nitrox_debugfs_init(struct nitrox_device *ndev)
-{
-	struct dentry *dir, *f;
-
-	dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
-	if (!dir)
-		return -ENOMEM;
-
-	ndev->debugfs_dir = dir;
-	f = debugfs_create_file("counters", 0400, dir, ndev, &register_fops);
-	if (!f)
-		goto err;
-	f = debugfs_create_file("firmware", 0400, dir, ndev, &firmware_fops);
-	if (!f)
-		goto err;
-	f = debugfs_create_file("nitrox", 0400, dir, ndev, &nitrox_fops);
-	if (!f)
-		goto err;
-
-	return 0;
-
-err:
-	nitrox_debugfs_exit(ndev);
-	return -ENODEV;
-}
-#else
-static int nitrox_debugfs_init(struct nitrox_device *ndev)
-{
-	return 0;
-}
-
-static void nitrox_debugfs_exit(struct nitrox_device *ndev)
-{
-}
-#endif
-
 /**
  * nitrox_probe - NITROX Initialization function.
  * @pdev: PCI device information struct
-- 
2.17.1

