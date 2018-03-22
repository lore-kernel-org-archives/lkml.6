Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbeCVMzu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:55:50 -0400
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:20019
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754484AbeCVMzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:55:45 -0400
From: Abel Vesa <abel.vesa@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC: <linux-imx@nxp.com>, <anson.huang@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 1/4] arm: imx: Update clk driver API
Date: Thu, 22 Mar 2018 11:55:26 +0200
Message-ID: <1521712529-632-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131661969443533601;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(39860400002)(346002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(356003)(336012)(8676002)(53936002)(104016004)(16586007)(48376002)(105606002)(110136005)(54906003)(59450400001)(81156014)(81166006)(76176011)(316002)(956003)(446003)(6346003)(26005)(15650500001)(51416003)(47776003)(2201001)(4326008)(106466001)(50226002)(8936002)(5660300001)(86362001)(2906002)(450100002)(498600001)(68736007)(26826003)(2950100002)(36756003)(6666003)(50466002)(305945005)(97736004)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2877;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC001;1:qJbgUo/DD64dGrWSLIbevNv4OUaJ4G16vCgIp7BHz3jDnQc6b5YWWtHclXWxffiwpUd00JzlIaPZSI+vbMIEK+F24u/YAZFeE78D6dgS0dfhrF+A/HUpVcd3E/WihEWB
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4807729a-9f03-4c62-d1c2-08d58ff43990
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:MWHPR03MB2877;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2877;3:8pncrHwL14KE/Y7ZRimrS9nYmYYrbJXxYN23eBjmz2uzIrqVG8NkY+UIYy0UBMs0rwACHsiGW1vi8zOSdodiYBxyfrZMe8zfbzhWzmGTJ+s+oX09fotlq5KAOOotURbnl3Jeobd6Mlc91OHvyZEmP9x5ZExpU2+xp95P5Lp9TxTU6S+dyJyO8MJercM5OrZ9hK5shUwYccdSn0PogjZ9V6QGmHEsPSmE/BVjk23NMjTiIpZSUStS02A0w9fMoyMNeGFsQFFoVABB3We9vts4Ma8DDY/F2TPgDHiljDKblEMLGHEUG7EQrbyzPd0EdnHlkoYbQqZmkGSUwvnN8x3/63cZZrZsWxYXqLR8jrcEmIk=;25:YDirPSyStI0CeGTnPopaXxy0X8x/AAbOPOOSJP2cZ1KaZ1owBiwr/HZBiU6yOsgIBMnIXgwAegX1a9ePkPcZMw7ZYQPZQA8pHysrMoDYkqc3nRj22Zd1BZ+b4Ky8XKdIemZfU4fRh6gvqNf1nxiFcggNB0FegNnYHxLqoR27e1OEESQ2tpF9+Rr3OU7adoQ0KSFGEQTDkt6fp1NYkMLOFs0AMvP0uDL9YVaXtpmD9qmJUquK4JBIb4tgQGZbK+KJukSd12dAxr1yWYOmnJAJtTWmCUYEA4P8/McUgPtgiSQM1kZfCiil33LVbrey1i6nczXVbL7ZCSesPUwlojhvAw==
X-MS-TrafficTypeDiagnostic: MWHPR03MB2877:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2877;31:IEXVuxXXLutP73VMI4ssUE1kpZKNc0aXdNW0pQYiJO1r0YpTyhOsJGzQYDfVQAW/ZxZ79n2alM576PYb19JNJFUnXXWhimf5TJgOmJsGJz4EKjz43V1ApiXQgZ+VmQMlLGQPTg9S89Ki/Z7ASR2Sm71aKg51pWFh9Ha3jy6XAop5O6iFW2EfHNiexGXbaRyheBsDar4rKyzqf7BmSIEoIdaVF3hpNBUo6YmsUQt9Fz0=;4:SFUJgtBXJEQpCWK2Ja7H65ao8teQrdYXdVVy1sikDrhYFrlkWxSSUwGI9R1iFTewoWSeSZWwGoe0TKDfp2eSCwcn+apms5lVTwMOLDXXNrRXRxyAJ8/zfSjIQlG6ypqXpyrqbqm89IRviTtHsix5eWpo6G9IjrOvOchx5atiHCh3NWffO6u5i6I26spS/uJbs0M9ixllPIoGjm4Yhkb8NvgXCjdzoNV3pBXtWSc55WV375j4CAzzfn7XcbtXj2pV4swEP2c6YK0lX6VEXCVAARG0lxtKDxzhq5P9Wp8/IqrvJm19j7fHAYGqmjhUl6/I
X-Microsoft-Antispam-PRVS: <MWHPR03MB287768CF14AF027DE3298F25F6A90@MWHPR03MB2877.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6096035)(20161123563025)(20161123565025)(20161123556025)(20161123559100)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:MWHPR03MB2877;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR03MB2877;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2877;23:JwNONiZwAZwvDPSpUcqxzrXOBqwmE/I+ixOcxKqfI?=
 =?us-ascii?Q?bYmLMvOX2XSvw36hcIUcm/Q5u5uWy006YdUTYiykGHM8qmss6hCb6AiG5mQK?=
 =?us-ascii?Q?sAflMR6aahA711eH+zZi7JUvkjIgUSC1IpkUcKXqNPQovyfzXK+Ghx1ThXS8?=
 =?us-ascii?Q?qko9oG1sWCLPJSbYvL/xoHudcfDjAPD46qFMz+PlFf3ozqHfg6Mn9+HUUnbv?=
 =?us-ascii?Q?r/JmdV2PUWkMV38fEvVQ6HrYrdeyE+WkLd9rUiyc/jsDjV2X0M8T+UTC+t32?=
 =?us-ascii?Q?ZmOu8B74DkIEtQBVH1UMViQv0P3c3qFniMu33dBQ5Jf8bSmErQ/AsBMCE07K?=
 =?us-ascii?Q?LICp+XMLzmbM0Sl7wPXUZgCoNld16pua2n5CiPDfoEL32OtcK1ueYonmQ0s+?=
 =?us-ascii?Q?jQe6g5TVh7oG8TEWZGnUO4jAJdyx8bpK4+3A6nSnfPh+gA5nosKjBu5rYXCw?=
 =?us-ascii?Q?dil9d4splW1SPtDMh80wqkcNBHcv3708VOc6MGd5jH7NvtXuZvhUbLS5dbiP?=
 =?us-ascii?Q?nl4jMHQ8WaD1wrEcNZIGT8T8LIdtkhH2VWbSljrAFrz9vlK9HLWJIiWWkF55?=
 =?us-ascii?Q?Ja2BlQr9ErOj2CodWM9TyqPulqVmQYBWZJc97SoIRHIQPKeF+qiCNwU2q0dB?=
 =?us-ascii?Q?4gG0hXZzIdYx3DT6J1Q0Nm+MKeB9OFX30jqILIY9ZHBVu3HjrVlw/9URH3zx?=
 =?us-ascii?Q?4VhbxhnNWbPB70LtaMwumuEBj6eUSJfrvC98c1mzENVJsK6HVUreXwP72ltG?=
 =?us-ascii?Q?5qFRx18f97T32bvXENpjQXXucrVW5WwV/jxFWc3BRV///McPyzxfpde3GUkU?=
 =?us-ascii?Q?TEHxGc3rdfJw5sehUsOrIUTJifIjP+MvSMrgee7o/agjhbnwsG551e3Mhg+V?=
 =?us-ascii?Q?q5Ld5giiqaTVVHprjCoBWGG/AHvE1GjDXa5b6Y04+sBss0jogzBotpnFhw8K?=
 =?us-ascii?Q?pVp40/FRRyG7eHjfvwg/RmD2FDO8+3sqYoAEDaP8WgeqFvzZGwl+pPdThcQ+?=
 =?us-ascii?Q?GfZMufaz3R1G96br0j4IwOOUrY8y5V/VGvzxYhL50KAweweJZImT3XG5iL/V?=
 =?us-ascii?Q?HfCFDErGuj2Os4e6O8R35PakyGa9VHtWnS9QIGngHt+H27hQM4gj0+laZl4t?=
 =?us-ascii?Q?FmcPgHqLE3sVNIuD/LJifjm6Xhu7qNbKElRpy3PMWgWotjCw+Md8Kw5LQOIK?=
 =?us-ascii?Q?lCgamGysfvTOMM1yWW7GOlOZy6BZodH+W5h?=
X-Microsoft-Antispam-Message-Info: FaFBOtNSIkoSVqnv9hzg7OlnVze3mSlqMOq44N90AER83xZsuEXOkvXv+6eNkt6pwrcCfF2uxLUlcdH+WizGmrvk32gidXjJwOncOs6oklCV+1HnliRuL/WdNPamMvqpqKTuLvrdhaSMgLZBB9WJh1QTVOFOTXVEp2sDVvCAzOZ4EahzNKcLnT5dXhOwjtey
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2877;6:ZPIOlHZelyIrwVD2BCGOilfcbVqUUUwNYDHu9lhA+qq0QtDNLtp8PdktqN5kM1/uAE3idRBBZLLC97Wz5sa0LQEdY/885DZ4/BxR7cn4mUdHRhHpJo4Stk83alx+BijRk+00M7lWCn4FlWLJPHekilKp4Pkzdq6/79lBQ8XmLqhC2FTRRNXe+R6ChWQFFWOnw/pD6fcudaGvQyeiMHzjT2StPrjUciA6sE2/Y/WPkjECb76zveOododj2t4CzTOWtG1sp4ZvGyYGW2PQtFiQaMdpWeuOQ0IfNUgxtfCSRW242VvAXxuoC154hMQaKuTlBJQC4cpfBxflfzmaynpR7wcV+XEckDMA9yJbb0mvDfE=;5:E1JRsd/2n1QhwfJugnMlOKQ0h+NE2xjMIf8h6ZOJ2f5O/RmKaJpT59mXefrkIgZrTRGss7kvqOrpZAg9p8Q0ofqman75FQ9uZfP2iPNJtHkweiCG04UzvZiIhEeEUWyAOvr+M+9qsLmib44Jst7p2zrR3XSuLfR7NfF92b3jFTk=;24:wcMa5lM4DVPyiWhpW3JDcWrH1+i3/f5iMRhCdtX7tnmqm1MhLt84DN2vqRbisw33BRPOwz6oTtqWlL+pffQzi09Owwb0qLJ1Akm5Ky8nqbU=;7:KneO3nTdzqGsxRruNG5VzykrYs6krX80ZuWoej71Luq/CTRppxieeH7Ud4fQ1HLWqReqfXFQs0jY9sg//cxx7Gbxn21nGyA3WWNt2eMxvfyioUL0F1Oel6PcWJBQFX+KqBU3oQ6yA+/T5WUmfy/b1mtKXyjBrnpoZfZ1TavbtRRYufmDuuoqLGZTe+PPr2ltBybJ16TB0RAQM5dYuw4iW9dffzfuzc1C8X4j9X7Fv/fy/wXWUPpOVRWpK2o+xocr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 12:55:43.6357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4807729a-9f03-4c62-d1c2-08d58ff43990
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2877
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following new wrappers:
 - imx_clk_gate2_flag
 - imx_clk_set_parent

It also updates the flags for the old wrappers.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d69c4bb..466c37f3 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
+#include <linux/clk.h>
 
 extern spinlock_t imx_ccm_lock;
 
@@ -54,6 +55,15 @@ struct clk * imx_obtain_fixed_clock(
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
 
+static inline void imx_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret = clk_set_parent(clk, parent);
+
+	if (ret)
+		pr_err("failed to set parent of clk %s to %s: %d\n",
+			__clk_get_name(clk), __clk_get_name(parent), ret);
+}
+
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
@@ -96,7 +106,8 @@ static inline struct clk *imx_clk_fixed_factor(const char *name,
 static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+	return clk_register_divider(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
@@ -112,7 +123,7 @@ static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
 	return clk_register_divider(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
@@ -133,7 +144,15 @@ static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
+			shift, 0x3, 0, &imx_ccm_lock, NULL);
+}
+
+static inline struct clk *imx_clk_gate2_flags(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, unsigned long flags)
+{
+	return clk_register_gate2(NULL, name, parent, flags, reg,
 			shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
@@ -141,7 +160,8 @@ static inline struct clk *imx_clk_gate2_shared(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
 			shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
@@ -150,8 +170,8 @@ static inline struct clk *imx_clk_gate2_shared2(const char *name,
 		unsigned int *share_count)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
-				  &imx_ccm_lock, share_count);
+			CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
@@ -173,7 +193,7 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
 	return clk_register_gate2(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
@@ -181,8 +201,8 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT, reg, shift,
-			width, 0, &imx_ccm_lock);
+			CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+			reg, shift, width, 0, &imx_ccm_lock);
 }
 
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
@@ -198,8 +218,8 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 		int num_parents, unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
-			&imx_ccm_lock);
+			flags | CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+			reg, shift, width, 0, &imx_ccm_lock);
 }
 
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
-- 
2.7.4
