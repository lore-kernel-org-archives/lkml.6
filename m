Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCUH4c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:56:32 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:26656
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751628AbeCUHzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:55:48 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <mturquette@baylibre.com>, <hdegoede@redhat.com>,
        <b.zolnierkie@samsung.com>, <linux@armlinux.org.uk>,
        <linux-fbdev@vger.kernel.org>, <linux-imx@nxp.com>, <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
Date: Wed, 21 Mar 2018 10:54:51 +0800
Message-ID: <1521600894-29919-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
References: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131660925468696461;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(2351001)(336012)(81156014)(76176011)(8936002)(81166006)(36756003)(77096007)(85426001)(26826003)(50226002)(508600001)(54906003)(5660300001)(86362001)(305945005)(107886003)(51416003)(8676002)(53936002)(316002)(356003)(6916009)(6666003)(450100002)(2950100002)(16586007)(105606002)(104016004)(106466001)(97736004)(2906002)(50466002)(48376002)(47776003)(4326008)(68736007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2756;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD023;1:uE7d6gYvyuF5JKyueZ1W1+KUrpc8iLEodsfAcaV/7gHdD/8wwTKBoAOIuOnXhIU0zOQhU6KTd5WaA7ld25827im7DawwZpswMhXPXkfVvDYFXNUBirVKyUdV7U9ngXdj
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5478ba3c-66cb-4eb2-5f8d-08d58f0127d3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR03MB2756;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2756;3:2xSvj66ws9glQR8P/ieu+9QF31nJW6VYpdNGYEBBPRdhcDLOu5nzl4y45Sqo26sjnkgeuB+NXnuuSNhN3TPTjX72mzMPkCTe35w2eYtRh5lkiJbL4UGVkro+hUrlbL0k8CBWx4f1FvW6e4RLF2UVnNRPGZUFD0lg/uB2OrjNScdn0MDWKQMDaB4Y6TwzCEsq9n6P+C2SEqBYjwBSZsVFpoItdYdxkuP2qlxfqwFSthkvWIeM2/2XH122elR0g7dXAlmayICjmknOgskkO62DJoFkLBrkqBoWNHTAFO5y5Sw0wau7IBrfyEqcsJhZ4VnWoRHv5KcLCwaQC5W7bFtNn21zL2frxXfpiyLJ45iTZUc=;25:IHZ8lcTysE2Wf3UQuXiAdlqAhdAml6lPi0OXp4bw2uggemAAJ0bifbDhAuF7xrHsmlBW5v7VpPUm1PqKaMaLkDYHy43nXw/I1mnJBvqnkGH4zAIO0cCfQliF3+hQooMiPOQkaylD+r/pvshNv/AifjzWtsGK7FLSyqp5ih7uAh87EalY0xhgmMrecW39fPdguCs0/TlLnZKejN0vF7bCZnxy+cfFsEGkTI6tmSnaCHYZHXIo6uKAX3JHC+YykMS9fXdsaHTDI0IALclmx2TcYPD4KabgZjsNghlVc0y6CfqVD961DAMPIQUTFDOCwlaXny11gxZHAXdzfciItLs5ig==
X-MS-TrafficTypeDiagnostic: BN6PR03MB2756:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2756;31:gfu7Zq/0zDpFYWWXaayiym9ltpvLf83lOFDxJWQMXUGpD7kK8iRYkYCiyQlg/2ttAucloVGCkK1YnyrzizAHobu7bdN/PTx8bvbb4FWRolWNSgwebG9sU3yHDZ4BLgQNFnjI3OCHT9uivDhSU6CVq3pCaCcToen6OBdAd0eCgojAXkdoZUciTIRg7NDGh2Fo5K0jt0CO8T1LKq8t53YmXRG3dwD+fHqwljVR6n7wP18=;4:yVg1jXPCdmy6bhcoxrtR6bzmVG0K21MHsn24+zPgTlZCDLh0gXqG8XYNQ75Yoo8E5Ey+4VzhBze/8O3FmYItleoq6KRvKFdo8mHxwiLcVzyFMwZ+1AjXtulPBJIpZvXuR6tsX8Vqmv/I90pkUTy6S81mUh+i+ipq2EQsLdu0tbAgjwa2DsRQk2gr0zxk6QbMtubCzx3qHynClWng6LVMa59CpMsTStauvpwCPPu3aXynHR9U2+G4dBHD884Z+flpv+/OPPZtSJVHhAxY1rALJVNMoiPq4+CBPykYQRKXNpScEVAGqPiidPHRc6S49k1I
X-Microsoft-Antispam-PRVS: <BN6PR03MB2756E19A1503C3F5C32A2AC780AA0@BN6PR03MB2756.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501320)(52105095)(6055026)(6096035)(20161123561025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123559100)(20161123556025)(20161123565025)(20161123563025)(201708071742011);SRVR:BN6PR03MB2756;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR03MB2756;
X-Forefront-PRVS: 0618E4E7E1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2756;23:FcIpE/DdvwnS4elWIQ1L0F8aduESQFJgUVz5A3eXj?=
 =?us-ascii?Q?TEMvzcwLX5QcO6t9WpuHH+4WeRdlHUaee7ZFNaRI0NE1T8veS556dMTOnf4S?=
 =?us-ascii?Q?TYYq7snkMIbIb4G54az6YfdAfVeMqc1YwtAbVXGlp/NPo9QgOuxUMMe3shLF?=
 =?us-ascii?Q?siniWisaWqJw2IE+h4o8qPBc5V488HCIabWrIcoWrt4h6LLpeHcrETwUPArr?=
 =?us-ascii?Q?4GF9gV7VLLKVBWdF0WeepTbsQ4NtcfO9P7hqftsjFITWn5rZUj0beXinlQFU?=
 =?us-ascii?Q?59O8hp3y5HZZG1pCna9AkMOLT9e/MIngCwzsCUp1FkuaM0p6rvWnJkL8U3SB?=
 =?us-ascii?Q?9L+hxXTq0B8NYQfPWl2TuxymPreyE8luSvdr+sRiLIfKN3tSCxM6SAw2QwWs?=
 =?us-ascii?Q?ItIM06Bkwhj6FWccJ2YOdx5r76XgrYTU48ZC3pmNAcKnycmql0iKXojomUjQ?=
 =?us-ascii?Q?VP332J0xfqRLkpiBpn7KV9G8c2s5/RNMrP6ypxLFLyZvdhtAG04zl2A7gYmP?=
 =?us-ascii?Q?EhlnPzVCCIATjquitpuJtlSxWRGqR7LSi2gMmrTKsYyu3z9DVcVDP5xUtQIV?=
 =?us-ascii?Q?K4nAHZJ1/7B0TYM2zUKNg+5GCwqwyoKFm8rwJRcvCIpW+fYRpkxD28iAhDwe?=
 =?us-ascii?Q?lAib4mQy5k1BWPUrT3YDVt+vVt9M5mHru6RpqalUSi7fhdZ5u/cn4varUegS?=
 =?us-ascii?Q?dWy+w3H+cg57Aiuari74geCtZyrY8SkVB3jmlnrNlRjE2aFzIAqVdBh5/VR6?=
 =?us-ascii?Q?QO/TPrIAKMKp3UAt8lZIZmJiNMJAI6hdsoNkcM+bIc3QTglyoR9vaRXPWCLw?=
 =?us-ascii?Q?DjJrfztoOCrWlSqBR04rjbT8w/zWdFhsF4NxodqTb0MJci+PqEzVwPUvQVVA?=
 =?us-ascii?Q?sBcEmQuucovW3S1juN319qLv3z7w9+2rwxm5NOVe/uN+dIvmFyN3V7IAkSoo?=
 =?us-ascii?Q?V5/XklxGTxQnNySF51gPOO+rwkluuUfjadzz+cd+V6VXjXizvbTdKNe6yHBL?=
 =?us-ascii?Q?9Z3XY+iue1sVkzOKJCJGU75wD9pNNO/kVaZaqjJsZ1TkSyRQFfq9WHG7HaCx?=
 =?us-ascii?Q?C2INuAMaiRo7rY9gRr20DHK3QSFmYPjNLvAO22OYfXl2jW0B4Ce9mMj6KMYZ?=
 =?us-ascii?Q?akI4qlKCqdtZnlLJH9RyLMV5MpBi88hLxF8q/Dl/0nKsFcojonFJA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8pZcryyOhttOLpAYaURTDgCdpDJzO3ZO2u74/pcymamvsup6MBe33Q0gCKzLxvEFgFNilfwx0sejdqiteLafWAI0FfMfNazJnOOBzqjA8jkSCXx5q9ckotKhw5n/lhN66D8+qUOTWIBgKAiNz8EYQj3v1CxSbY/WtMA0XnjMI8Oc3GXHo2obC4/6k+8i1HoQ
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2756;6:J7G6rbG+znhWtCxh4/d+yxE7F6RKR/LW8Mnfy1eWRMjESp+xKAeepvBzUiTyBGLu+a5xW+hkBCBJcyKnu877YzVZqvGYNPX5BHW4t7gI4s2W+yFPtvhSK9ZFFYojAyiJyRaojLafAFLV+oc3D/iLm8a1O/QDi6Y3R+pbPY/JjoYSiR2w/Nliug1rEDcxsirp1WvZoEMs5daA1dUibUxTrkkJCVOolLMU5XokMSTQSV08BCjxUWbY8hz0DdaQOtZjjByzuEQY/2EZ8IA2TedJNtcxEc0OqHX6tK13HBbn3N1lXZ7JRmnMy3d66N8v2l3rdLFC+E3+NKEd76IaWSTKsGDwDqMARqXG0ttPXPCFXDQLgnemVmA/x3ndlYliX2Iy31Q+u0bp9ksolz8G/NbtlWBUA8LGptnwiYU5rV9X2an+6B3qlI+bNcFVXMMUy031/ee9waL+s6BOZXWfH3j3pw==;5:dSCm+5Tjcny6h81jfHdplJNYbPyj1ibl+VSrGOkAWk3bujEtdSP2iJBEHpHBio/Qa0feZ+zOeNPwZMt1kcrZuIAKUgBIXRZ/m+heQ/3xl37XkYi0AEz3FYCJWi9FLjhmUO13JKEGNeClqLJYstxFnoTTZVc8UHu/IoGXoYvFglI=;24:QGF/mU+MUL9qNq1WsJdgX5XwP6yjawkD5oChrKcwkYhH8O2Kxav8Cw07EeQ7OaEh45vJiX3A33r3+S3Hoin2TwCpxBTTN+FQnkgh73qlUoc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2756;7:TagSm7hK+F/4tfZP9DudLvAUp/m6javjSE5YkuxDDfHng1WGgfYQd7wC8E7PylBV1lC9TKJDORCi9LzGvW0+a85SqdJ2XD9zBAOR+UkSnGtwXjstccS5DWmAz5sQiAs/bPEHeC80595srPKmP7qS04MEVknMgdR/FCOLsxmtNv3MKzOmqQ2o5BjThWhxIAHi7euq+C9R/v1kE0jXiVAsnoZozt5XLl/uvJgE3PjtvgbCaoyrcjX5n8ix8EVj+i7E
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 07:55:43.4376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5478ba3c-66cb-4eb2-5f8d-08d58f0127d3
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2756
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clock-names' property is optional in DT, so of_clk_bulk_get() is
introduced here to handle this for DT users without 'clock-names'
specified. Later clk_bulk_get_all() will be implemented on top of
it and this API will be kept private until someone proves they need
it because they don't have a struct device pointer.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk-bulk.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4c10456..4b357b2 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -19,6 +19,38 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/of.h>
+
+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
+static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
+					struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clks[i].clk = NULL;
+
+	for (i = 0; i < num_clks; i++) {
+		clks[i].clk = of_clk_get(np, i);
+		if (IS_ERR(clks[i].clk)) {
+			ret = PTR_ERR(clks[i].clk);
+			pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
+			       np, i, ret);
+			clks[i].clk = NULL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	clk_bulk_put(i, clks);
+
+	return ret;
+}
+EXPORT_SYMBOL(of_clk_bulk_get);
+#endif
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
-- 
2.7.4
