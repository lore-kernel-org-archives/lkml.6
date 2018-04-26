Return-Path: <yangbo.lu@nxp.com>
X-Google-Smtp-Source: AB8JxZqlnesxVvkJ6ZWcWCOpLu7ug5P3iIDt95UhLLIok4e1fPrbL5eKZII0PKzAQKrg1FCPTW06
ARC-Seal: i=1; a=rsa-sha256; t=1524738284; cv=none;
        d=google.com; s=arc-20160816;
        b=G9SYOms9qpzm6yA2Ut35cRnKcTAqbvNS7P06EyGBJBUjnwX/3m394K9RYmRNpflugp
         WLPc1vp4nCLzwBXWxSaiX7zbDI2dAELcNFGSRFlubRwjb0nPgNQ65vdqu4duLbqv7aSG
         XupGCjnePllo3gDFynoyBfmu5w5FaQeaWxmBaI3Z9tJHHUHu/d1r5SBEAtvfoP/Of/99
         46NkQj+wRYwrWCAeY59V2evD3QRPj46zPfLtfOgOVS5LOJA+GWNZFNcv/3VjKepcL9SE
         aLEXqdevI9u2CSGKgwEhTzS3vU8Wn9Gp/1iT+w2sKS/xP2U9JdJpte/aTnS+2CnKih5b
         VQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=S8YmpCqecEvftzud+GNZ4YZZUxOo7lINRELwiCYAaeM=;
        b=jHPjm5uClrY473mxBbY+ktLbzHhjq6Z+GEQ0prRc/Z90sB55FpAr7Lxtrde2zyGC74
         EDlwB5dbmohLPz8YIs/HclOJ8mfKB9htK2v+tV26aa3ywBgf5qMJJCJ9wxeA+vVnPj/v
         2gc9tS5g2zMBLS7FXTbDwSvL0b0CIJzmwTK4vx+/SHh5At6Fszvv99F/aGiPLQ5gv5Zm
         mpHObdbitojknJmdkKDjNI/WiBZ2U+bYkwbrQ5W3rLLYR35D6+h8x1o8EjoowGIB/Gy2
         TxfEMy/5kVm4iW9pxCvu3xkRIqsfpTaCf6+eOsxvtwQfQd00DvLokjQcbpocWk6VKaiP
         RfhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@freescale.onmicrosoft.com header.s=selector1-freescale-onmicrosoft-com header.b=QI4HiiDY;
       spf=pass (google.com: domain of yangbo.lu@nxp.com designates 104.47.40.90 as permitted sender) smtp.mailfrom=yangbo.lu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@freescale.onmicrosoft.com header.s=selector1-freescale-onmicrosoft-com header.b=QI4HiiDY;
       spf=pass (google.com: domain of yangbo.lu@nxp.com designates 104.47.40.90 as permitted sender) smtp.mailfrom=yangbo.lu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=fail action=none
 header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran
	<richardcochran@gmail.com>, <dan.carpenter@oracle.com>, Ioana Radulescu
	<ruxandra.radulescu@nxp.com>
CC: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 3/3] staging: fsl-dpaa2/rtc: support phc_index of ethtool_ts_info
Date: Thu, 26 Apr 2018 18:23:49 +0800
Message-ID: <20180426102349.45222-3-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180426102349.45222-1-yangbo.lu@nxp.com>
References: <20180426102349.45222-1-yangbo.lu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(486006)(86362001)(77096007)(336012)(2616005)(126002)(6666003)(446003)(11346002)(498600001)(39060400002)(85426001)(2906002)(6636002)(53936002)(50226002)(5660300001)(48376002)(50466002)(44832011)(106466001)(305945005)(316002)(8656006)(110136005)(8936002)(76176011)(4326008)(476003)(36756003)(47776003)(1076002)(59450400001)(81166006)(8676002)(16586007)(51416003)(26005)(97736004)(105606002)(356003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR03MB389;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD007;1:R2VN0EYAtL950+h5DzQffrt1eYdU/mQiueY54JfXFbHpStBhPWrzbbzXAacgpwJx3TepC7QwwLDVnmVuX+iUios6wVxXbFhhX7DJIN6s9+rHi+d9T7EvUCSTGlzWfHWf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:BLUPR03MB389;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;3:ecqzLHaMRuNMT4Rms3UTzLj8KfkNcrKbT0Os4abKqk3xQc/RvC/UEMSm5r5kEIfLQsswsz1KftR5pePMrGtuXoXod4QEt1CU1MAZXLijoZ7vzqjnF+q+O8hbmQ+Hb4t3yEhidJ4Nuk5/CaGTtkw7lTw6ZEjdiKjCoJblaQz4jAS/rRRe0HtfWTjmDn6V+npLzWp/NpilchYgiLkUWSE3cETRjnYIbliAGUFJts5qnUmxAWokSYX2LefmupEyZmediBbs12E/tzHCikRxSwVTjT0QJr8f2Jq+NEMaybPhE/2a3PqcDqapX4HBjMO3ZqAgmBAXTzB46gMFFYvCcOypmkkjhwydGYGmpVQ3yCFbRyE=;25:ILmZxrWItoYjAKWBhJvmlr9TcpC4Yu7+1vPEUx2tS3/wCokJJh4EZ8euIrYKeq96leZMETfzirq+MoyAjJHNbqi/EAT6G7ZUj8kxEPU74mmjnQ/fU+GkDdk7U+bcv4rrTmff9jhe9T6M3W1ausNFn579OFKwzSrAsTpyYM4kUKmdbHcTF2GsHHP09wKAtkotAhqShKruegmm9A+7Il1uW4/HVUawKLiHbUGTc4iGudqkV6Hvi7ofmYB3XyWutNYANWQdLSyPIDkXzfudyJ0D2kTGWsflElwx5f6KXb0DIiP+4iz3GWtjV9ipm0cJQHDLs5xjOTif3hcHNk5sFpyrWe1O4GNntQ5AH9Lkx4RADgg=
X-MS-TrafficTypeDiagnostic: BLUPR03MB389:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;31:AACxxWKJp50cXig5EdfqT8U/g3JmMTz8MBSEjpWOARMgHMbyRtOt6fbixW0KMDpXQRv0XpPoTNZKQcargYB3TUcij1RXKxne0JSfm0T3DAA5/pLj4NSB++NdEp0oisVfqjnKR52tMH22oDyhjo4D+g36aclkeeHcQakaBRadb52oVsO0glnzwAgYp5iZHiBsIAp8HPpoCpbqwUthldf6JTbaDyOlhBeGdUxpSpyozAk=;20:6UnmzUf4kz3uz8/kUlBiGO+rh/e6vs790RKSFv6l+HKEowrN90yDwrQEK/dky4BFNzKXrYuxp/czv1LX72CCZ1NF29uPqOtWiKNicC2Tp7Vo+3mQdGtnoNJLb62jxLDHwYv83Rpg8hh82zda/Gh0C0wUB/7+TrFDfPUxWt8E1bFfLzFh3G7o7C5XjmW1Feexx0lkyDRr1S2FbVqklbgDmrRBoknhvfmaKsDa316gFxEVFfkOWhXAMkU9/MXZDBJje2XT5l0E/VYbyuzzPkKNVkKzlhfJBTTj/8tP46D+We5Sjc/YAeRiYjjK8lnKzbPSirCDrZH5ekuulYg8pTBS3ouzzATJ/y8iNDY3ZI6fonLzlNUwLkskWomjP8VqGgG7lmgtCo5Qx9Ghv3mjG7dgJhC+JV0e0j+1/U5HDQdMzY05o3m1yCvtoiNJLyG5h9nnqBPLNxFWRM6VNGDn20ZXXdCWvdZoDLCLjVYBDZSMowLmBeZc4fxw5JhLa74WVuSif1Znw6PYOb7bnNmS11PbXGX+HfrLz6lMMlRoxb51ipu28mfZs4pHfgKLqe8U7WCb+EU+F9l8VTFQ4M4nDpnygmzNeYU58GC1mqjs7Tgv6og=
X-Microsoft-Antispam-PRVS: <BLUPR03MB38978B131685647F95156CAF88E0@BLUPR03MB389.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BLUPR03MB389;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB389;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;4:035kl5rZ0yNr4fhqo+rN9caw38UBxS8DhwMz0l2srCXPkn4rtsPBEzmYIULrU/eP9d6HrjWJqzFu+0hZPTsstMjuvMYe5al1WdAlqoD1QxZNGakqiUdnbI+MbJAREuIy69GXaG1oM4PiImr6mXrDoVcLec8z9pJHrHOFO+of1T8bVI61Hoi+K2xUxgmo2/mTMvoZDB2m2+Vqh96IVHqMbVbksmjoLRuKSD+QwuynoDX/E+7tixt/V29fXT6o2aspIySK5pPX6wvccXcENfZegZ+GNtA4fJ9KZRXRbdSQ7jiRbR9hje3+eTk9en0NUiRI
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB389;23:4ChHoRjHtbLVKx9YtkvgjIyrCt4MheIwISOnNhoqyO?=
 =?us-ascii?Q?HM2k68xpiKNLqz32k/lj94vESIuCikr/TnRHRmcE4Xnf1OKClTNBeWXdYXfU?=
 =?us-ascii?Q?cDxTQJ9v1HDDrHJzE9Tcv40BXcmwCgW/GLjBLP5NKEQbiv4+sCIfp0Kt6pvy?=
 =?us-ascii?Q?lMlHAgRhH7PYd8onPIWsuNUM4N523eeBFTV0lgSfxHw0PpRGLrm8kRgenOM3?=
 =?us-ascii?Q?GBq86epfKlWXy5+3qb4IZyiXBbl1vTuB47bWwNcBkm5TwiPxOj3ITKdIg5Cr?=
 =?us-ascii?Q?FMLJMbBx12eX3eR8Kpbc8ZNIL5tNMdxDrpk+/2hyn9jaX7jtZr6M8hpaQoBm?=
 =?us-ascii?Q?LNHEdq4ivzS8j9HbFzrmwYnPSO3eGZOXxUDrn8qEhotIO0czWdJoItbSbCjK?=
 =?us-ascii?Q?KP7iJAzGCofMErW6Hb9jdtJa/orsIeaBZ+xcsGA2EJVH01VFFcUR4ZqHgc7U?=
 =?us-ascii?Q?Dof2O1ceqBhW+q+aFEGd+L4fGB2sZa/ySnxreKM4jw+yZJKRI7taI2BX0XCn?=
 =?us-ascii?Q?ghrWhC5gfMT3MjoYafA4xZopgtXi2ayUfEPeiIDR/UcTnbFZj3uG2glwTYv5?=
 =?us-ascii?Q?ODiH+P2yzRMTEbEnkYTa5T6FqQ84iT1rcpIHsBsl30qG++1XLFsZDZQHIySt?=
 =?us-ascii?Q?bDVyBcIDGObhE1qLL9xzejIbVkPcbDZfeuD0/d7krUdt/ydQjTvIsu6EqfrQ?=
 =?us-ascii?Q?p0FdfhYm9lxE8J1ldGAErs4uK2bKNopGsDT084xC9liZFCad39bKPMEBtdMU?=
 =?us-ascii?Q?WYlMTWKHX9pSwKGpYEPoMAjS4EFRYNs9/2o2GwnRKcQbX2p3U/GpFcLX71Z6?=
 =?us-ascii?Q?yOfGD77F+f55Nit9wLM8tfEv0DiORvYoY0rh0DSBrWAkpVysinr0pS/APi58?=
 =?us-ascii?Q?+9pL97E+DJpZEwdDeopm2+KaaMmmxHSpl9kdSdPzqNw1ZDKvHQLghKFxw4Ob?=
 =?us-ascii?Q?gj5I54X1sQLbqpmq0hwmrgm+nPPHspkOxLGva8rizTtMA2m4Jg+Vwg4MTHg5?=
 =?us-ascii?Q?sAMyn5ohwNIvxinB3vdwbyxsc+IR2jh8w5Eb05mNfUxloW0nb95Kc/d/vXHF?=
 =?us-ascii?Q?0xwhGlznoiDLyRJYgjeclpkaZ8dxT5hvfWxTb/ULqHGgPJzoIPM05c6wqvto?=
 =?us-ascii?Q?7KV3jFWutytqfmplAgt3K84zWRYl/LMeFbqX1CEN0pd8HniA8NNHr7QB6zlC?=
 =?us-ascii?Q?3COL038lLipPztU8VSvg2KgQOROTviKNCs?=
X-Microsoft-Antispam-Message-Info: 03Im2Xds5fnDyWaArhRXrXi+WqnfqxvgBBKJsJ8+5C/527YcJV5zaqsSB2Snp8XfmOvY8ZFzWp7ymIWK7j0bGC/zaWjusH68OrvbL6c3A5DkbGjA/vH2ALYUoUCHVSWNoW9aSkeDAlNlRg5jmYYtlh4R0sck5gRWvlvHwwRXND67StaILXTbWStukT0EkeEj
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;6:6SHz6GKBQSb/bBHUI0uSW3eSn1Uw0tsmMZ9JiSGWTdo50UOdIRz/bFFvyZ3ycddf2cXETk58BoFB6yDxVL9tSRSeyvbH+1GSNKLKdzJeQByHT/jF3ctBtzu7mCz6L4buZDgCF8xyCcXeZ7IQ/LVbJlWklKVGhXy2MWYHTbjqOhPZSpdxvNZ3+ihyZ9XZwhcqkh+XsL+N0Xe5Hidi2m8jYmVxzCGpf4x8S0CAa3zNJKm62Qnd9r5xYZfPfertvxvK1M7qylJuKnEFMpJVJrtyjUZ8tCBTtPHKg7+vCmNSXLD78tmj1WroHm8R+jnxGRQmlAdDlwEVE79emVsyTZ1AgLA3P6M7Xr9ogSSvriHtnBdhMYxxAynCK/FzeeSchmqhF2RXuIqFaaPzm5eZ8LZbzcohmjaoU8PKkJb8n89babIApDTaKKwMPd3jpKJli7010P6W/RoMM4X/UbyZyjV1Bw==;5:mdFmHH8uGAznhIlXSd/R1xnqJdZeF1qe5YjA1qbdOqbtAbo3PbOPp8/wirwktmRJG3vxJSh5zGaYyrcyjWqVETmD40oyWKCChscH7ZGlmKPwL+1VlFxlwwEAk1Y8HA45Z8tPeifQZHzRsduBiBLoM7AmBw+x+m3bdPPLnhoMoZQ=;24:Up0s4L4/ad1SBguTScwnlSJWru6pVkY89hZD9h94NlcUwx6tmhV7ostq7bEWXYb9WkbMYyn3W9J+V7jl4gjgj2zCTtgSWSGCMoDdDtFeObY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB389;7:GNksIccB8qvZouwRwCgRoU4wgqzFGAbUBqgFgr2IC+gRFwg4g1sEo8qWAVtf8aYjP5XAqaz54PqfbWiIiG2BhltwzAR8ibgplkrIwtT+VdDB+pnNxBZNwpUPRU25k5jFRNgSEilND4Y7J7lIg6jE351Ia9EBD7cs/Xky3WN9FxXVcX/H6JM0pTTKCZOntxYF8x4qX+OQcm8SPNVUAXs7g30Ce1hhI4Fxmkj5HEprBJgY/IFvU7yiOfeGAZ+mT5Lz
X-MS-Office365-Filtering-Correlation-Id: d87a5fda-e74f-47d3-d737-08d5ab5feb74
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 10:24:40.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87a5fda-e74f-47d3-d737-08d5ab5feb74
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB389
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598803971836363795?=
X-GMAIL-MSGID: =?utf-8?q?1598803971836363795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch is to support phc_index of ethtool_ts_info.
Also make the rtc drvier depend on FSL_DPAA2_ETH because
this driver is only useful when PTP programs are getting
hardware time stamps on the PTP Ethernet packets using the
SO_TIMESTAMPING API.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Added this patch.
---
 drivers/staging/fsl-dpaa2/Kconfig   |    2 +-
 drivers/staging/fsl-dpaa2/rtc/rtc.c |    6 ++----
 drivers/staging/fsl-dpaa2/rtc/rtc.h |   14 ++++++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)
 create mode 100644 drivers/staging/fsl-dpaa2/rtc/rtc.h

diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index ea2d4aa..cad016a 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -27,7 +27,7 @@ config FSL_DPAA2_ETHSW
 
 config FSL_DPAA2_PTP_CLOCK
 	tristate "Freescale DPAA2 PTP Clock"
-	depends on FSL_DPAA2
+	depends on FSL_DPAA2_ETH
 	select PTP_1588_CLOCK
 	help
 	  This driver adds support for using the DPAA2 1588 timer module
diff --git a/drivers/staging/fsl-dpaa2/rtc/rtc.c b/drivers/staging/fsl-dpaa2/rtc/rtc.c
index 1d6405b..0d52cb8 100644
--- a/drivers/staging/fsl-dpaa2/rtc/rtc.c
+++ b/drivers/staging/fsl-dpaa2/rtc/rtc.c
@@ -9,14 +9,12 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/fsl/mc.h>
 
-#include "dprtc.h"
-#include "dprtc-cmd.h"
+#include "rtc.h"
 
 struct ptp_dpaa2_priv {
 	struct fsl_mc_device *rtc_mc_dev;
 	struct ptp_clock *clock;
 	struct ptp_clock_info caps;
-	int phc_index;
 	u32 freq_comp;
 };
 
@@ -173,7 +171,7 @@ static int rtc_probe(struct fsl_mc_device *mc_dev)
 		goto err_close;
 	}
 
-	ptp_dpaa2->phc_index = ptp_clock_index(ptp_dpaa2->clock);
+	dpaa2_phc_index = ptp_clock_index(ptp_dpaa2->clock);
 
 	dev_set_drvdata(dev, ptp_dpaa2);
 
diff --git a/drivers/staging/fsl-dpaa2/rtc/rtc.h b/drivers/staging/fsl-dpaa2/rtc/rtc.h
new file mode 100644
index 0000000..ff2e177
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/rtc/rtc.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP
+ */
+
+#ifndef __RTC_H
+#define __RTC_H
+
+#include "dprtc.h"
+#include "dprtc-cmd.h"
+
+extern int dpaa2_phc_index;
+
+#endif
-- 
1.7.1
