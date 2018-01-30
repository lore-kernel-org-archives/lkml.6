Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbeA3SPM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:15:12 -0500
Received: from mail-dm3nam03on0049.outbound.protection.outlook.com ([104.47.41.49]:53888
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753213AbeA3SPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:15:09 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Manish Narani <manish.narani@xilinx.com>
To: <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        Manish Narani <mnarani@xilinx.com>
Subject: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for ZynqMP Platform
Date: Tue, 30 Jan 2018 23:44:33 +0530
Message-ID: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(39380400002)(2980300002)(438002)(3190300001)(189003)(199004)(106002)(8746002)(8936002)(316002)(42186006)(8676002)(81156014)(110136005)(81166006)(50226002)(54906003)(51416003)(59450400001)(4326008)(36756003)(5890100001)(50466002)(107886003)(63266004)(478600001)(5660300001)(103686004)(336011)(2201001)(356003)(6266002)(106466001)(6666003)(36386004)(90966002)(48376002)(26005)(72206003)(52956003)(47776003)(2906002)(305945005)(186003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB1339;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT057;1:3X0KPWwjNrGBUP5To9O35o54oP+YxXQyvy1IedGyZZPLxYrbTqdcaC8JZhPosJxyF+sAqYSwn93Nd3OO3hDZO8NfNDZzIJAqDDWG8GwkEefJqflgkINFqxFWXRjILJgJ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70caecc3-fb9d-4653-2284-08d5680d632d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM2PR02MB1339;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1339;3:Lx9wYBnPX1pUf4GWmzlMMrlxsAoWZ18AMRlZ5aa3L0S/ZFo6vaOF0GKNBB52hqPkXFhXyoxfKLfNsdvmJlVJ1Ubpaz/yF7PyKyRvqFFbIGinn1vC0o8UoZb6zPhYInlbhMMYK6Q0GXZPpaJjbzMhDGRTfG1kb2nxOBpXxLiG38Imj+fUAg8Rm5GPp7Sq0G3kM2eI2SE3Pu2vgLoD3vmayoqoGPFquOaK+qRU/6mwZkSNzSlGUqnNJajjoJk9zUxiOSj9dr7COofkdXm8ntgx5QF+Ou8Ng4vcYWMCBxdZE2F3/t/2+/qthwy2IIy+biaE0Hr0VXGIw206YGt0xSh1P+O1I5OD44lu4Ox5kojeIqY=;25:6uzLm2+4o5nN+5hvfqGnab9z0+itRTjtxVxcggqbRssSbIfIE9BC0qVbpjxlkWFHgJqUUgt85NBz36jfDL7uum5mehmfA7G1Y1mbCE1WwCJEiCowRYLDCL0JOn5X+Mf8Syj7+046PKHJyol3TFU6BigFIOjEiooq1cLUqlPLlveDz0wVzJGOB4HPKhMTr0/nvMNRHbyq0HRTPUpfDStV8aFgg2mB72IxkCYX/zaVFeLle32ra5ZQfKlDEGasUG8QsxWb0MRJif/YKdz12AciyXSZBWlBccdadqVIACbHYiLI1i5+EUp82l7mPe0J6mNEOCpZWNTpk4IRYwIk93G+mw==
X-MS-TrafficTypeDiagnostic: DM2PR02MB1339:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1339;31:/cQH5+DEKUHm9ec3PJQXGIEX9s/tfBpbE36tcwxy3WTPcd0zVdk6W8zsOwQJgKqNKkUGbRumwcKzNuhhOMx1Js91cZIYOuPqryuTfQSQQbaIJcO4gbaaWCQiOZu+WXx6IKZ01zZBcVQHtpvK9/yVvGjhlgENennCrgAr3I0govn1ImOhOQxq3wTZYkwKxAEsNWk02hxy7Q7qfPSDu+yuJtXNDROEFXBr7s1xHbn0GX4=;20:AGgYS9aTVG13//T4Xz6PN3EwaOfGWbWWekigDrC6MHSzmNxe3akM6iMowtpMqP+66MwKYMSBBzptyZr5qaYk9aN0m56HvcxrQXO6hGXnRJQoMVzqK6huhBeGoo0BSiFQ5oFRxh7oSGxW6Cs1+/SIR6m4gKP3+i/mlY+XgrInVf/w0tF8kS9q0QX6uG2pvP1lfGdgXprSdlYYpC0uWpE3Xl8beTeMFZHe45zUv5ezb7SqdMb1Eep10NTqyNkK51bkkabd6H2L19OLcVI73LTvOsFtZC1siP8VVrsZIvm1PfBXMKZiWAdGSUYVrxpx/wTm6wVj4LYu2s3nkmhoYMvCpeXko+SmjBnw63gUsctzcI6SXiB4Q20nX5qVJbJ1zZwGdlSXoQ48qEPY8PPyeo2qY86UcG0Rnpsy2vsdBtwflXT8Ekus2idliz/b5twUiTdkhyPbR0u4hJGeMd3Yz4C5dvJICsgAHhSmxzvD+WKdKv2IlFNk2mxe/r6mJGHaVnP0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR02MB13391D61A6F79E3206D192BCC1E40@DM2PR02MB1339.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(3002001)(93006095)(93004095)(6055026)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR02MB1339;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB1339;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1339;4:ApXXiUBiKfe0T+gndS1Yzs1ZylzpdjyxFhcUFHjFycVC96sztnjBAkJ9nKKjXPmFoIp5VggwoDuX9bOJN9FM12fARNiAPW/DbqSYyscyZ8g2gijGiyG2x8/Z3CloIoxj4uBB09JyepSJW3Ma+wm1xl2ItVHJl/FnppRGLBRsv/RgixZLw5U+WyJQeXtJjnrLvfrtv+zj1nj92H5KZf1eOAhFU2Ea7a5apWb0bskhhJ9HE31OkXhhwTrIkmzGeS0Ofi3SNJaPqaTmvq1lz9msPs/+3NyFVRJ/PaX/cP2SkY24jSzOrzvJyfy9lyJDpQrp
X-Forefront-PRVS: 0568F32D91
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR02MB1339;23:7n4ru2g4lh/sSUJlOChQaRb6KXTz1t7KSt2Y+tqe8?=
 =?us-ascii?Q?fx+ftDezM3HS9ooXELtZBojvHy349NeDjLha/2Dm/93xZyrECkq20GwIc6X/?=
 =?us-ascii?Q?l953jRmckWywImrteuFpoDdBmUaQv18gpyUeYN4bbIhElYxckV/eNt+nkKUM?=
 =?us-ascii?Q?dWnZnF6p9hE+yLvzKM9HGe2OT28LNsdfOrBzvZ6AV5jbByUVyanqD+BSr7ed?=
 =?us-ascii?Q?mj2PX2R0PYgyNASK6v0UnhNQR88Ht9EkuVOkBV56qPyewKcFWHS2pzrt7nKm?=
 =?us-ascii?Q?mSi03PVgxqfP6VxPOn6xUHSRLYy3LfoXRjbK9Ib3AuR/tzxyTxqHr417ATQy?=
 =?us-ascii?Q?vw9NFWe8hfxJQWVgHn6nfFdX40l0dodk644EoGc9HavgNc+TZhCM+E0oIVhj?=
 =?us-ascii?Q?dAK/ukqS4vPcztOwG5Vbm1505nB8CxB1K29tT8/MjLTKUHu60zN7IHZPwEhQ?=
 =?us-ascii?Q?H81NbW2k2hE5Bk9gm921aEhUUtNH/3jd6inmXBiY9jek5zDJZV1/41YNs8bT?=
 =?us-ascii?Q?PGJVz48nQk9CfgMuDCzlOgnlfe5niJ8K9kNGz69mf/T2cARq+JNEtBbjY42j?=
 =?us-ascii?Q?P24HOxAxAA1csxN43VhvgR93sY+nd9q3cOlarHp1n73r9QCOelAnDm+hFjZ4?=
 =?us-ascii?Q?yO4Bvij8Vn9OKLx51E3I/pl/+/a8Lw/04h+KyeIQktj40qSvHw7qxkQHGQgh?=
 =?us-ascii?Q?+tKU29uZxnFtjhnE2ExA6xAd737naApbe6DkO+vw5d9xg6KDdgVQzmwva80L?=
 =?us-ascii?Q?CdoJPUw0yhzbNkn7dT/Y7Pw3QSUgjgtp8ngnMwdTuY3r9z2q8107VKy8oAFd?=
 =?us-ascii?Q?wJek+n8tWiRXrgMoRpmR1/bK4PSOQFCyhH3F0LlpF3PipbeABFS2pMCIjQN8?=
 =?us-ascii?Q?OJGRf9+7NFJ701GXawa2sNDMGZ+EKtBEmJibpmPVITkHbFvorkeglo7wlJg6?=
 =?us-ascii?Q?zW1AqkDo9uKqqr7Y5LB3rYy8DajbsHza7kP5pDNDhHS/MGTXCbnzpgnu7qFZ?=
 =?us-ascii?Q?0CtHGLyz0/3Gu6fDV6WQFRpRFaUq63iPNne6xj60Q/V5Do9SqGNpM6eEa2pq?=
 =?us-ascii?Q?zZPSrW+nYoOoLr89jJkuOgIEdP6cqkFHO/OWw9PJnkFn8dPeHb+6B3LvfaMV?=
 =?us-ascii?Q?ZA/EBw6pFYvIE3hl5a+SJQEPRjDpK8ciRmeybWcWn4QdaPCEgPYPQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1339;6:kvcMahaYjdOpK2VityhaUq8pyPa1JKu11rEn7qpZxrFs0lSX2CHLiUC53Vx17rUNWNqhOtwPek9BIu/iokSrfQrKyH38YHaMCTnzc9wLPY8R1K+yO7jhaA4hEIkJYqR1cMKZgV6/HZe+ifX/o3Edy3wAwoAYblTXN08dbul/ZpMYmCpo4M6NCxyY3ZRdPCjgru9iSQPvNZfAmeTLK+A7ojOA9Vf7OaIXUOjEOZWZxTTN8f5yncJaG5qJaG0LbaaAcq3rBBBvwh70NgYCvb1xXykuRzzXwc1ewtouHNpsaKA7WYjHHEWCLDKHoiRKsN6FXQ7cZdsQoGbZquZApWL9OfTTHsdbTKOQ+uW58H9gyEg=;5:Tb2iCT2JLFpNyFJ3CTMUSD5mFk9coE7w1uVKSBgfTbTU8DVf8K8JqkuG+aLoFBwuxf+EH+I0Xs86lbp1w+WJu1rYa7KpFA6s/TSOySK6PPN4PwQUA/fEpE+p0KHIA8olldCgOPo1kgW/PjR22Eex9sKx70xIJUOeVNTowbgrrGg=;24:0jaGB+TYJWDJ11Gis59kbhHOd0+IaXZNNHyCE9AcFaWoVc65eti65oJWagGxHbydDSX3K7agehGjjPiRDthm+xF6az/lKg5/9JDZr7jzV18=;7:t3ifq7kj1faI2qHJ4wDu52XuGcggH1ZMu7OROuX0y13ZgrAzEJI6tToPEFTmHxFhyEKnHcFJEvsjs8E7K52MxeI1tDWw/bXqt2c7rX6XVc2KBQRlfe138F34LNgrDGxgFVqA5XsqLUswK/uZeF/q5NcX0T/RskYdYJ0nCY9ljCk1ch9R7qb0Ln42gQpRZ265CW55hgSPo7op514Uf0Z+jnB35asJ9TRTBaRz2i96kNLsJbTroksfPXdxiXB1+FAf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 18:15:04.6652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70caecc3-fb9d-4653-2284-08d5680d632d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0UIFIXv016137

This patch adds support of SD auto tuning for ZynqMP platform. Auto
tuning sequence sends tuning block to card when operating in UHS-1
modes. This resets the DLL and sends CMD19/CMD21 as a part of the auto
tuning process. Once the auto tuning process gets completed, reset the
DLL to load the newly obtained SDHC tuned tap value.

Signed-off-by: Manish Narani <mnarani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   1 +
 drivers/mmc/host/sdhci-of-arasan.c                 | 219 ++++++++++++++++++++-
 2 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 60481bf..7d29751 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -14,6 +14,7 @@ Required Properties:
     - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
     - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
+    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP 8.9a PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0720ea7..7673db4 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -24,15 +24,18 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
+#include <linux/mmc/mmc.h>
 #include <linux/regmap.h>
 #include "sdhci-pltfm.h"
 #include <linux/of.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>

 #define SDHCI_ARASAN_VENDOR_REGISTER   0x78

 #define VENDOR_ENHANCED_STROBE         BIT(0)

 #define PHY_CLK_TOO_SLOW_HZ            400000
+#define MAX_TUNING_LOOP                        40

 /*
  * On some SoCs the syscon area has a feature where the upper 16-bits of
@@ -88,6 +91,7 @@ struct sdhci_arasan_data {
        struct sdhci_host *host;
        struct clk      *clk_ahb;
        struct phy      *phy;
+       u32             device_id;
        bool            is_phy_on;

        struct clk_hw   sdcardclk_hw;
@@ -157,6 +161,213 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
        return ret;
 }

+/**
+ * arasan_zynqmp_dll_reset - Issue the DLL reset.
+ * @deviceid:          Unique Id of device
+ */
+void zynqmp_dll_reset(u8 deviceid)
+{
+       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       /* Issue DLL Reset */
+       if (deviceid == 0)
+               eemi_ops->ioctl(NODE_SD_0, IOCTL_SD_DLL_RESET,
+                               PM_DLL_RESET_PULSE, 0, NULL);
+       else
+               eemi_ops->ioctl(NODE_SD_1, IOCTL_SD_DLL_RESET,
+                               PM_DLL_RESET_PULSE, 0, NULL);
+}
+
+static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u8 deviceid)
+{
+       u16 clk;
+       unsigned long timeout;
+
+       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+       clk &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
+       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+       /* Issue DLL Reset */
+       zynqmp_dll_reset(deviceid);
+
+       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+       clk |= SDHCI_CLOCK_INT_EN;
+       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+       /* Wait max 20 ms */
+       timeout = 20;
+       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+                               & SDHCI_CLOCK_INT_STABLE)) {
+               if (timeout == 0) {
+                       dev_err(mmc_dev(host->mmc),
+                               ": Internal clock never stabilised.\n");
+                       return;
+               }
+               timeout--;
+               mdelay(1);
+       }
+
+       clk |= SDHCI_CLOCK_CARD_EN;
+       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
+static int arasan_zynqmp_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+       struct mmc_host *mmc = host->mmc;
+       u16 ctrl;
+       int tuning_loop_counter = MAX_TUNING_LOOP;
+       int err = 0;
+       unsigned long flags;
+       unsigned int tuning_count = 0;
+
+       spin_lock_irqsave(&host->lock, flags);
+
+       if (host->tuning_mode == SDHCI_TUNING_MODE_1)
+               tuning_count = host->tuning_count;
+
+       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+       ctrl |= SDHCI_CTRL_EXEC_TUNING;
+       if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
+               ctrl |= SDHCI_CTRL_TUNED_CLK;
+       sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+       mdelay(1);
+
+       arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
+
+       /*
+        * As per the Host Controller spec v3.00, tuning command
+        * generates Buffer Read Ready interrupt, so enable that.
+        *
+        * Note: The spec clearly says that when tuning sequence
+        * is being performed, the controller does not generate
+        * interrupts other than Buffer Read Ready interrupt. But
+        * to make sure we don't hit a controller bug, we _only_
+        * enable Buffer Read Ready interrupt here.
+        */
+       sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
+       sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
+
+       /*
+        * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
+        * of loops reaches 40 times or a timeout of 150ms occurs.
+        */
+       do {
+               struct mmc_command cmd = {0};
+               struct mmc_request mrq = {NULL};
+
+               cmd.opcode = opcode;
+               cmd.arg = 0;
+               cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+               cmd.retries = 0;
+               cmd.data = NULL;
+               cmd.mrq = &mrq;
+               cmd.error = 0;
+
+               if (tuning_loop_counter-- == 0)
+                       break;
+
+               mrq.cmd = &cmd;
+
+               /*
+                * In response to CMD19, the card sends 64 bytes of tuning
+                * block to the Host Controller. So we set the block size
+                * to 64 here.
+                */
+               if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
+                       if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+                               sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
+                                            SDHCI_BLOCK_SIZE);
+                       } else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+                               sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
+                                            SDHCI_BLOCK_SIZE);
+                       }
+               } else {
+                       sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
+                                    SDHCI_BLOCK_SIZE);
+               }
+
+               /*
+                * The tuning block is sent by the card to the host controller.
+                * So we set the TRNS_READ bit in the Transfer Mode register.
+                * This also takes care of setting DMA Enable and Multi Block
+                * Select in the same register to 0.
+                */
+               sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
+
+               sdhci_send_command(host, &cmd);
+
+               host->cmd = NULL;
+
+               spin_unlock_irqrestore(&host->lock, flags);
+               /* Wait for Buffer Read Ready interrupt */
+               wait_event_interruptible_timeout(host->buf_ready_int,
+                                       (host->tuning_done == 1),
+                                       msecs_to_jiffies(50));
+               spin_lock_irqsave(&host->lock, flags);
+
+               if (!host->tuning_done) {
+                       dev_warn(mmc_dev(host->mmc),
+                                ": Timeout for Buffer Read Ready interrupt, back to fixed sampling clock\n");
+                       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+                       ctrl &= ~SDHCI_CTRL_TUNED_CLK;
+                       ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
+                       sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+                       err = -EIO;
+                       goto out;
+               }
+
+               host->tuning_done = 0;
+
+               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+               /* eMMC spec does not require a delay between tuning cycles */
+               if (opcode == MMC_SEND_TUNING_BLOCK)
+                       mdelay(1);
+       } while (ctrl & SDHCI_CTRL_EXEC_TUNING);
+
+       /*
+        * The Host Driver has exhausted the maximum number of loops allowed,
+        * so use fixed sampling frequency.
+        */
+       if (tuning_loop_counter < 0) {
+               ctrl &= ~SDHCI_CTRL_TUNED_CLK;
+               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+       }
+       if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
+               dev_warn(mmc_dev(host->mmc),
+                        ": Tuning failed, back to fixed sampling clock\n");
+               err = -EIO;
+       } else {
+               arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
+       }
+
+out:
+       /*
+        * In case tuning fails, host controllers which support
+        * re-tuning can try tuning again at a later time, when the
+        * re-tuning timer expires.  So for these controllers, we
+        * return 0. Since there might be other controllers who do not
+        * have this capability, we return error for them.
+        */
+       if (tuning_count)
+               err = 0;
+
+       host->mmc->retune_period = err ? 0 : tuning_count;
+
+       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+       spin_unlock_irqrestore(&host->lock, flags);
+
+       return err;
+}
+
 static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 {
        struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -262,7 +473,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
        return -EINVAL;
 }

-static const struct sdhci_ops sdhci_arasan_ops = {
+static struct sdhci_ops sdhci_arasan_ops = {
        .set_clock = sdhci_arasan_set_clock,
        .get_max_clock = sdhci_pltfm_clk_get_max_clock,
        .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -371,6 +582,7 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
        { .compatible = "arasan,sdhci-8.9a" },
        { .compatible = "arasan,sdhci-5.1" },
        { .compatible = "arasan,sdhci-4.9a" },
+       { .compatible = "xlnx,zynqmp-8.9a" },

        { /* sentinel */ }
 };
@@ -642,6 +854,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
                goto unreg_clk;
        }

+       if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-8.9a")) {
+               sdhci_arasan_ops.platform_execute_tuning =
+                       arasan_zynqmp_execute_tuning;
+       }
+
        sdhci_arasan->phy = ERR_PTR(-ENODEV);
        if (of_device_is_compatible(pdev->dev.of_node,
                                    "arasan,sdhci-5.1")) {
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
