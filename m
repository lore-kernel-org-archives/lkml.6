Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx4/mO/9jgMfJjodfw0nQoKX184P87A1+VipTddSSF0vHFHt6O6ebcblVhkTMhc0ENrpOILua
ARC-Seal: i=1; a=rsa-sha256; t=1523389178; cv=none;
        d=google.com; s=arc-20160816;
        b=qRwVvjTnQVMszQAeDWJaOg7S3YvKOhuXxWlaZEgxTBwu5P9LyqOMsMFr+pWwTJFNuQ
         PPL8KXMhg/swHJto/1PpSlNbPPfGoX4lF3v2bKX/5Jw5hYW0CrU7hH8dZ5dQ/YmmO8ye
         Jscf+ygtL6eejBzrmRraj45dDnjLBJTaqU8+cOQnaIBo5Nyl/euCkcFE919Brel1zn/H
         t8UMYvA5eiJHJVoJ0IyqnNI4fuIUUTDyrN89BguZDoLMMlUx9av7A0lNysXHiNAszgRS
         1oOFNoNgq76OhdVXp4V8a9nVfyi7Wr+wPRpCI8Zvf4rzQEbUc0At5lcbYDH9QUyI/Q2E
         oeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=IFVttfL64WyQVxz8hEmAXQZhCtXynDvmNVfTtCZrGD8=;
        b=JOP4IxFZpJyDUyLwoqav8wAKcbxPJbHW0BCO0ijZmqaqfpWZOoHvRPYmfFvMoo4T8Q
         2HYIyhP0XDThugeKk6SHxYu5Np9DypR2UODuuzK0KcBx0QYNTZ7NuMPNEB1N5LhqIxan
         LdN+Hxs25JkxkZ1qZHxKK8kFPMWXqD1YALwnZuGCHPxgfFb54eLJwoXA1aBxdVbCVxP1
         WSzA52NJvSo9tLiKoqYwJtmtIbB6UuaLbMUKs9+3pBhHhHP8NcuvHqf01swzTeZU7Icm
         hHBS3/Gu6kaz1zWYKg6PX6U6ny07BhKlkK6+TZcsM+0ueI/hxxHcPOW9Ns4HrP3PxcN7
         WfBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=do46vAGD;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.38.86 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=do46vAGD;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.38.86 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jolly Shah
	<jollys@xilinx.com>
Subject: [PATCH v6 02/11] firmware: xilinx: Add Zynqmp firmware driver
Date: Tue, 10 Apr 2018 12:38:38 -0700
Message-ID: <1523389127-14243-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(39380400002)(2980300002)(438002)(199004)(189003)(106002)(50226002)(72206003)(4326008)(11346002)(59450400001)(478600001)(305945005)(48376002)(50466002)(47776003)(336012)(9786002)(446003)(7696005)(356003)(81156014)(2201001)(8936002)(476003)(81166006)(316002)(486006)(6666003)(16586007)(8676002)(54906003)(39060400002)(36756003)(36386004)(107886003)(76176011)(426003)(51416003)(2906002)(110136005)(63266004)(126002)(2616005)(7416002)(77096007)(186003)(26005)(5660300001)(106466001)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1400;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT031;1:9bhbkGVdPY9ZyCUBN7zGKmBVx8tclLBuK6SW2WSHcofzR4ba7fb8M3li8k8+2D4OarWj/ZucnZOeqCv5OgPd3dFgRxrQ4i9q+pKHjVfVWIS5YKPpIWm2F0lPrEnSurDm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR02MB1400;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1400;3:XwJA4IuqYKR1oJwWQjmlvxHF7iufypQwrn2zLY25vHV56oayqqzBgRj8ywJ5GBI/SYcXE1c8n0nbS8H0NA97R2DgHNraQ9N3enRW6cqCmbQR0hVIjPL09bslzhq6SYeAXDEnaMgmf4bz0fGi6E9WRUu6SaPAXv9nGLiRn3y1k5ibMh1zEnnwfC26EqFMfmkDt3WwGmMbhqAeb8ZjyCgTCcKZKAQ0NtTpQPTKoNbETCkhOYVasYDX3KkwqOhhKQF3Lgkt0xCe0XMlZotWnyGLyrZrtZXjrybBiHndT+n7uQTeuxb4NL7pKRiP1UZZWjggC9LBKAGR8i4Hak9rBviBBctx0MT8Lk9Sdu02Vp5eDUs=;25:NLlw7R7Lw3/vnP/m2xzd9zJRjn+03CKhmN9XITpFlvXiRjAYzijoFh4PKhqVwJggHZpwJ39Uh8slGHWkGTi3C1eqtNx3Rq1iWD3dqvtpsdXHk28km22ngx4Z5lbpla0VO7pLCFg41IDUQw17f5JbgNZ3Mc7pX53e2pVCbxj1322MrtP7ug9VL6wPey39gyLVIuipVjc4Wv4wRRflGj8iRF9hybpSLB3XpMNPRsjYzTv5Nn+sIVZYZyAwzO4fka8nZj2cK/zvLFZGO/1SEUwhUJEUagsaZgWEVYWtJtXtAIOYpZGBSjmyAvKKZg2McwJlUV1uPBDWGHA0L8nL/skqjQ==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1400:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1400;31:ErcZY8KXDt8I1vCVXk3YYpOcG42Mw2UfLTjwe6AOflQmGUauFZBc1YjGM55TTOUxG3UfrPIL3i6FwkPxKA1PwrpbSbILIKaE/hl55ffO0KTCJALRDZxDo3FIhibjxiqXUP41cRIS959Op79jJZ2Pq5HcFriR0/tbstNEJ02WRU08FY/cjyemYOoJDGcK8wLLbhiRCcTiLD9A+erjjAX5EMwe/b4fHEd+TzKHrbx68IM=;20:cXmenhVzsdiQcfgbXFg7t7FMBm9V5l7ZMhNa0h/ThTIMM733jZt5FoelAuectrF2YHxWyX/xZ08dLZZbzsPK5+cHuTlv2oKgDgDdOzHBIPoFaeU3tJfWSbX+L8jVnqxPLaJwl44tPQCRow0uejMUs7QQCN73binkKeKOM4TlD8hOl74slQJ/m49j+N8d9kMVA3P9L7uvnjg6Ew4LDIqb1ONFbb9UZczJeYpEcNKh3wz+p7bD5bcx/RQkH0aPgjpYsOOHd/Dd89H4ajTXDXd8RQWIoqu1ykWRfurHO97E2fK5mEJ1O38NenJB06y2/tVXvUi2CFUE402owVXGaorezilB6fB4DzzlCvJudLRCF1cxAfE9rj7Dda7go9lZGCZnzS/mBnqTIvCnhn/nCYAsArNKJQdgfyDVSgiFqPnePlaKOQnyqwlQciLpb2HVxDvP6EI8b0wHedb0tmKAy3eVlENWnEe3Z1Z+s3PpLnkV1Us4C0I48GRyGQXed9Z+nRVz
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB1400FB121ABC670F748ECE15B8BE0@CY1PR02MB1400.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR02MB1400;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1400;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1400;4:MFDpB74FBi7T8U1Z9sqlUrTKAOq+9z7knLdjOnyyVxRPffVz2oILEtNPwYYwOooIpg/hb2TviVQO2Ou3TXIciB6DIFc8NvzFFBUiR3qprOxk53AcrQ321xrGmvfEB/3YJ7UHtrRgRp7GAOtC4vDh8GG2GRoynvwsXPp0S67KIw1SkppozegL+tGLVLwqWZaqdesLCEeEwS5bUK33sYuy/qOU+0vhpEu0oKKdOGHRKjoMhv+seBTBIsBKs43sAxyehz94Uxgau0XMwwZUCvHp6xDnrsOggx4kJBrYcoxHwG22CmN9M2/kQB9ZJjIaJNKc
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB1400;23:lHqTOfjOlSchrA2sqOtEo779RvSCy96yFlf4DBRuB?=
 =?us-ascii?Q?rjyFTudiEvZpobVAG0jyOzgR5qxo1UGV6Z+8NJAkRJg55gZQKDuBETYkB3vs?=
 =?us-ascii?Q?KZXHtcQ+Gly27dsET1F6ByAir2c7Xp/AvhObPzHG/11Vq9KjZ78ao0WS0SKn?=
 =?us-ascii?Q?SnLK50DClRJbA0JfUVAR+EcjE6Jf+XB058kaa+qfxR7Cbx7OlFRVDF+ivfbp?=
 =?us-ascii?Q?Mi2zrLact1dUhW4bmVYIonUQt+jxW+Qw/vhn1P6SaTV9+AkSLsrstfU24vUS?=
 =?us-ascii?Q?1Q6uiKGT5G6lFTJKF+xvRfGSBH9QwDOtKkfohOQQTvg9R2+o5Thh2mtNWOs0?=
 =?us-ascii?Q?cGIZSpOWmObMUQ1kvLu9q9RJWL59Zp4S2h57E8SjW2J6ihAbVexZ+5Tp+S9O?=
 =?us-ascii?Q?a21B46J/NJE7k+Czz095lnr4UFKH9G4BJCsgEDT7Jm8lmAx1Bkkw2a3lKowq?=
 =?us-ascii?Q?iJ78fzab15ZOi7gbd0Y7yq1MzHQH6wX9snrMQnXxY1pQ8l3UVv7cKPGqjew0?=
 =?us-ascii?Q?rTiHfnr1jIQsK55NZp7KJOAzsgNMyRAK3tztAwpRh/C9E2I356F9lgxIFCq7?=
 =?us-ascii?Q?WQSRUpM4YURQCLP57pvRwxkel8t6M51z1WVlPQ8++AXyLTb7D9CjvPC42IUV?=
 =?us-ascii?Q?YYH0KOYEuMiQ7EFusA+nAl1+HBtQ13hrycG/KrKpRUvnvZT/rZbCKBZb2+/c?=
 =?us-ascii?Q?MfZ5OQM4FZS+vBCgG5jjJkiy7nB0iUwfhllrhXecqX5g2MZLSRpGOHg7mlcK?=
 =?us-ascii?Q?TXYNIxkMCMMcaZrIg0XftVek4b13gSBmHg6gA0eKns6Rgfg8CrkCFjQCOKrq?=
 =?us-ascii?Q?7nMV/dwURcZ/bXYgE20b4n4lx2posXe6QKIcPMVvpC2CsPrlB/SdJk9wdKEP?=
 =?us-ascii?Q?KtK1700i79t0LVMwuTTeGgn232emeg5xREeeqVkZThwaaF9Mc9GA2+uSfvzu?=
 =?us-ascii?Q?PS1cbCWNDojyguaGq2qNWwoEhNoOcXdr/wzAymcZ+NaN3z3U1PdhGlPweZIT?=
 =?us-ascii?Q?I3yqatzoB52pVXO5z4YSNN/RkpVBrnCG+SAL6fGChu6T2+v0Z1btWX7qmexh?=
 =?us-ascii?Q?GNoyk99zcEq+beKkBrY0RrHd7M3Zdij7cnEhbBD02RQFvjHw4iz5JNCtiLPs?=
 =?us-ascii?Q?AYimwpSUlRiueX4yL8SQbw8IQzd/ItuooIVSu25yvmca+AizwT5Ldj6j6ocJ?=
 =?us-ascii?Q?gb6a5oqtS67sSUjlWZHEsUIGqQHoA/jYUb1fVlw8h6heCB+n3JouWpT5bAyR?=
 =?us-ascii?Q?XsixM7YqYFpOqUoLN0khSZ4GUO2BOmIbQMg2JrR?=
X-Microsoft-Antispam-Message-Info: Yzqv2Clu0CWfOTqHggq2LX9odHvw3BGS6q9iulmF4oW+72YaVFueywOuM3gAuPNaq/pODMsg/LcEFngZUzT0qTTL+wfbYR5wt4fXVIholv9Sep1SkBcB0GmKDAOZnKX9Ksh/czmfsJj+CFLUasbakTiyYZ6IyWIt8NfykaCl5L8BGwGmLFuwUan/cV/GuYWi
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1400;6:ypaGYLjnhJtJgQCLcuENrsAtx6RGO8xKaZanVGXm6/mLjT0XGc/y19xiRnebcIdLqAxo8SPjLPm1J8/X/kdhLDvKI1fnCl8yvrUenY+vjAU0+aYaK8ZDPj4v6JDfT+qPQejacqT+nhpTwTFhL3MdlHQ3jcJsotx3w+BRMjsSAH3fblXXpGHv9JzkOz4KvqdWB4UnaMi1Xu1NS2RjkCZD/pv6sWaOL9G+/qzyOiQybQOX5HdXL8kqoQoOUVSuIOp+bLTERmPh4pe6dPoljT+E5kASeO65e8PXKDQUtJURJR6yGxOHhVH4nIEdv49A8VMckqrXlY4XdvmGZgNX0xSGo9MVTVt0N+3ZFXpp9uPfHC4hxTSaKjnXCQ5YZx4pVop2RrjNYgJABq/PccW7UDbWt09HD/hf6dNLdwuZVMzyaFskM4vxGTdfjxCezBFz9+cI04uApkWKFPrm0+DYIpsfbA==;5:OW513MYkcHNGEF2xIFK2QMoRaNTFd0tmH99u+hP0qa6U78gviBSLY1lPxCpqF1/d7Yw6tz+XwOPuGa+m4OIEFPnNbngGTGaAxMrL2x+wLqUtIGEaYelD9H3vaj1F06jCmB9pZ0nxVQiI7qeB7n59JK6i25+tKUNIjrmpZ5Rdx+k=;24:cjePooxa24GHBjRpgpvbpz/4KaTs/0lFuFu4LyyZixILYUxsjQRgtMfEWN5knG2N7oo8sL/4SNJ0oVIw5KpRpvXKOH1EnusY9ewhbRhlBmQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1400;7:Q+znoYQ9YyH/XdIcZ6LZW+KHgQFpDdzVidDl26RJDE7XFtOk/qOiTwr2BCEh49yRPvmmZlpCuD0+cIeU5G/v1UFK72Di+eoiejOaYpl1U1tPW0Xk6c7CptkKMO3KbWycDfJuea4pUrM0C7WEqxby4MjKoTcE0Ziys96wNyhXrKknpA9djXjiDleUixSmS+WFvO0q5Zp304zJZTDAghgIjEvXqWh/xoBwkIs8sx5NcAU/XfjIeiBBBh2PjsH/xuLm
X-MS-Office365-Filtering-Correlation-Id: 5c4d1dea-99e3-4ff4-588c-08d59f1ac6e7
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.8278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4d1dea-99e3-4ff4-588c-08d59f1ac6e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1400
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389331213451831?=
X-GMAIL-MSGID: =?utf-8?q?1597389331213451831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajan Vaja <rajanv@xilinx.com>

This patch is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 arch/arm64/Kconfig.platforms         |   1 +
 drivers/firmware/Kconfig             |   1 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/xilinx/Kconfig      |  16 ++
 drivers/firmware/xilinx/Makefile     |   4 +
 drivers/firmware/xilinx/zynqmp.c     | 313 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  63 +++++++
 7 files changed, 399 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2b1535c..4f27225 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -286,6 +286,7 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
+	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6e83880..36344cb 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -291,5 +291,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index e18a041..99583d3 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 0000000..cce4e4f
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kconfig for Xilinx firmwares
+
+menu "Zynq MPSoC Firmware Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_FIRMWARE
+	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	help
+	  Firmware interface driver is used by different to
+	  communicate with the firmware for various platform
+	  management services.
+	  Say yes to enable ZynqMP firmware interface driver.
+	  In doubt, say N
+
+endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 0000000..29f7bf2
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
new file mode 100644
index 0000000..490561a
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return: corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc() - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via SMC call (no hypervisor present).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc() - Call system-level platform management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
+ *			   caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @arg0:		Argument 0 to requested PM-API call
+ * @arg1:		Argument 1 to requested PM-API call
+ * @arg2:		Argument 2 to requested PM-API call
+ * @arg3:		Argument 3 to requested PM-API call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration.
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC	- Registered ZynqMP SIP Service Call.
+ * PM_API_ID	- Platform Management API ID.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+static u32 pm_api_version;
+static u32 pm_tz_version;
+
+/**
+ * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_api_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM API version already verified */
+	if (pm_api_version > 0) {
+		*version = pm_api_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_trustzone_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM trustzone version already verified */
+	if (pm_tz_version > 0) {
+		*version = pm_tz_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
+				  0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * get_set_conduit_method() - Choose SMC or HVC based communication
+ * @np:		Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3.
+ *
+ * Return: Returns 0 on success or error code
+ */
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct zynqmp_eemi_ops eemi_ops = {
+	.get_api_version = zynqmp_pm_get_api_version,
+};
+
+/**
+ * zynqmp_pm_get_eemi_ops - Get eemi ops functions
+ *
+ * Return: pointer of eemi_ops structure
+ */
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return &eemi_ops;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
+
+static int __init zynqmp_plat_init(void)
+{
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	/*
+	 * We're running on a ZynqMP machine,
+	 * the zynqmp-firmware node is mandatory.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
+	if (!np) {
+		pr_warn("%s: zynqmp-firmware node not found\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = get_set_conduit_method(np);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	/* Check PM API version number */
+	zynqmp_pm_get_api_version(&pm_api_version);
+	if (pm_api_version < ZYNQMP_PM_VERSION) {
+		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
+		      pm_api_version >> 16, pm_api_version & 0xFFFF);
+	}
+
+	pr_info("%s Platform Management API v%d.%d\n", __func__,
+		pm_api_version >> 16, pm_api_version & 0xFFFF);
+
+	/* Check trustzone version number */
+	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
+	if (ret)
+		panic("Legacy trustzone found without version support\n");
+
+	if (pm_tz_version < ZYNQMP_TZ_VERSION)
+		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
+		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	pr_info("%s Trustzone version v%d.%d\n", __func__,
+		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	of_node_put(np);
+
+	return ret;
+}
+early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
new file mode 100644
index 0000000..cb63bed
--- /dev/null
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_H__
+#define __FIRMWARE_ZYNQMP_H__
+
+#define ZYNQMP_PM_VERSION_MAJOR	1
+#define ZYNQMP_PM_VERSION_MINOR	0
+
+#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
+					ZYNQMP_PM_VERSION_MINOR)
+
+#define ZYNQMP_TZ_VERSION_MAJOR	1
+#define ZYNQMP_TZ_VERSION_MINOR	0
+
+#define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
+					ZYNQMP_TZ_VERSION_MINOR)
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC			0xC2000000
+#define PM_GET_TRUSTZONE_VERSION	0xa03
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	4U
+
+enum pm_api_id {
+	PM_GET_API_VERSION = 1,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL = 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+struct zynqmp_eemi_ops {
+	int (*get_api_version)(u32 *version);
+};
+
+#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+#else
+static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4
