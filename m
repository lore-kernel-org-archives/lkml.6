Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965210AbeBMO4g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:56:36 -0500
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:22240
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965122AbeBMOzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:55:45 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <shawnguo@kernel.org>, <Anson.Huang@nxp.com>, <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V3 8/9] clk: imx: implement new clk_hw based APIs
Date: Tue, 13 Feb 2018 21:28:13 +0800
Message-ID: <1518528494-25723-9-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630073428078873;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(39380400002)(376002)(2980300002)(1109001)(1110001)(339900001)(54534003)(189003)(199004)(76176011)(498600001)(86362001)(50226002)(26826003)(4326008)(2906002)(450100002)(77096007)(26005)(8936002)(47776003)(336011)(51416003)(36756003)(97736004)(59450400001)(5660300001)(105606002)(68736007)(48376002)(85426001)(356003)(50466002)(2351001)(104016004)(8676002)(316002)(106466001)(81166006)(16586007)(81156014)(305945005)(53936002)(6666003)(54906003)(6916009)(2950100002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB1409;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD014;1:tXsdQvIRHq/jmqN8Up+1XyJb43J1X4/2yduPFGpeREYaD6tI9gmcHGDUT1CvdrNnG4g4SQ610Ww48q3plLPX6tUsy9FItdhIgNHYaO2a/IlbKecfkVzE9IBGc6hyY39h
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1d1c791-b21a-47f5-04b0-08d572f1dad2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB1409;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1409;3:wTF3HTVCj4W+KZ5er0VooIpzzBTQAONj5pQqbTMA2rrodiry/7wRYJKPIeRpLrgUt8x+gJ9BKyB/TNGPpEByxvF57NOgxeKB+gCadaCCDPj3441nqUb/RSCp6nw5Vs+rQ0LVW6dR6hpDHOKSrZAnbYKczdqcrC4gVuB3ldmbSphpEOns8oNfv32n8n5l0YWpZqHAfZ8M21DLI4JzwBvgiyhZDeUpqa2EeCgrTUj38plUlniBAbsmwLhpd4oBmronQcSPIkPcE8VW1mV4pIo8yeqnJ3oqYX+bOi9Huf4rKdbdvGuXonA0EVW+ugcY+h0IIiGV2hwYvj+s4w4D4JIO20c8+QPLJe0JzoOXOnygqcY=;25:hjGT08aln3iQfli8zcPmm/iKUITEsgFpqvzRILC7RiCX6mnLDjwQ4GxyWhXw45lG3ZaLzdRvs4qjr/i0wXiujxlYSKU9WN9poBtetxvmCOHd1q/N65BRytlQTDML60H2s2GitLJhbXBUZaMmfaRbw1bMHmbVs3Z8cqucACGsuTBogOca53wlbDf6hABaGG+wZswa003j7Dx6TZuS24Bi39WUbCrzktPBPhI+/vzo/7dzqh428H6WsJPxSi+UpyRF3bnJlkeNU18QOS+2VsVoN2RfOSjouHGv9RfEIEEYrLqR4nl/cKwE7vEyunxiOsPp6+FTkYFwurixb2SrD6B7Tw==
X-MS-TrafficTypeDiagnostic: BLUPR03MB1409:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1409;31:2ztodV2wGSWIoxpMtA5wfrz+s1QxKydKNdUfapPt74aD7S7T4iuDfJ7CZVZEtutEWez+8M53etvT0X6P0TXPh23OI7PhdvvJoZwmS1s66TfRu50DEkyjapzuDV6QeK8VCIdFgkfqq1uOmSyaUCdA1X/3vCMNn/BpTU2QwzBZhxmh/5tr54QdJPAITBtL543IRafnD8XNMih06Uu6AhyqHKcRxUtXwPN2oZ2tI3RfKF8=;4:lSyFLRU4dlchqaxL/u/Gr4VPLvBqiVlpHFXAI3WRg/fmb7nGuXass2SzlNcPcMhx3fabBq//b7UK1HQpzXBoXJ4EkD0fq7FBKZlDPCa5D09/2xGyD7C7LDQujHYXlkLMiuBsO99RSVi5ZmUfMEQyJ8xji1Ji8dPwWc8PitAJ6d8lHEY3+7l1LT22EfPpN1sWYgeZLoGWHVSeFVCAjFC7/n6PHBl0MEsMbBqkQ4IoT6RFlnX1Mr+Hapxae+SLs8E8Ny2HAsHdPoHCTmp3otRJjzSSrU5KVuRmlyNWJQ8SqYtLiULfUCS5s0pKpOo9Yl0a
X-Microsoft-Antispam-PRVS: <BLUPR03MB14095F16CD0E1FD2806564FF80F60@BLUPR03MB1409.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6096035)(20161123559100)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(20161123561025)(20161123565025)(201708071742011);SRVR:BLUPR03MB1409;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB1409;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB1409;23:4mie7OY1yyPL8TNbCOLu3fRJzGuk5r8yFhT5CDXr8?=
 =?us-ascii?Q?1jgvNTo3XlXYaLbwuGBHD/ElAby98c+7EQe5DdKhWohLW/pLnmmS81A36QL3?=
 =?us-ascii?Q?G8tFV2guzsBXPiR2QQE6wJE/ugKXW39Od/vFywBrIu3f0T9bGeyEPlac6RB8?=
 =?us-ascii?Q?Qsfg2WTSyN36vYlFOG+x8Sn5zJjjPgfrA5267kNGCBJXCT9qijDt3Kji90bE?=
 =?us-ascii?Q?Wv6PvFHWYceb/9gFqigAy/ITYEy1a655UCyDNA3lK3Uo4a4/zGumU7XFqVHQ?=
 =?us-ascii?Q?lzAumKfqxbQ3qvuqsBzvMbgBSxCFkvjHxj7XtUVqLAqJouWhao9B72bkOaoK?=
 =?us-ascii?Q?+2kabEafb4VG/E8ImZEtc8utnp6IHMSI+5d9uuFZi8cjKSugrioWF1YOePdX?=
 =?us-ascii?Q?6eqfyNYe5zXj2EnYWIF0J8YKSTOjS0WPSAItKItWijs8RtRc6Wk2K8oPTVVT?=
 =?us-ascii?Q?717DD/OJnS80mJXsys1rXkD65+unv3faUJUINBiJUF5MoSATbudvMR2s+b/q?=
 =?us-ascii?Q?o8G3QoG+k3EEau3j14911vM8J1CVI8klA5o5EJZM0lZm5zR3eJizTQLiRjGA?=
 =?us-ascii?Q?Y8QUyIbuSXvu+5CfKoeuZbVGuO2Ovl2eIRZQItnO2QWQ8fh0o/t9OoeGonDf?=
 =?us-ascii?Q?CroDTIJVHmfrZbp3D2hJwcgAW20eC89oxScxR+t/hci1cD34igf+jJKeSTBx?=
 =?us-ascii?Q?u+pDlV58ehZiBro10kknOrxMcNfeesiOyGenWtkiJ7fh+HpqlHkDqpcD4fVn?=
 =?us-ascii?Q?z/9VKQXAipnOEn5nfM1hXQAWdqTpbR3yvAEfDPmWEboEOLKeNFf7RQf3ENDC?=
 =?us-ascii?Q?mafgKbbn55RgSG3PWDab8Gs6CM0unhyqrerfgtec06wyl71skx+pWU13zQhH?=
 =?us-ascii?Q?FBLERFyuhR5DKu+1mS6NSGWAcTZZ37Lwt3Kdo9GYWl0A8nNJvKMMrCZhpMY2?=
 =?us-ascii?Q?fzX0gjgVV0vTeBnZUjWtzJWpa5jJxyibyZ7d8DoNbEtX/udw9JTFM6fHjein?=
 =?us-ascii?Q?kRL+5UnPVM0sv5sf88pmMVCMChJ8tx9vxyfq8gtBvXTowocJZ0NfaD8NsKS9?=
 =?us-ascii?Q?CUxwPuMfccJQHdqZmgmW44TF86BNBDSvD8N2sUPz5lW+Qv7BaSKk+yTpFuwu?=
 =?us-ascii?Q?wvM/0EElKa0ePNWouUy/ZiC8nV6GsiyvxYoB5vKuYtL6n6MNqC6HgGxoHu/N?=
 =?us-ascii?Q?PSjOGURmaKNOJQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1409;6:pVwxNpcsq1ssGRTdgMOaL9G28HaFIwM0+0umeF3weGdqwXnERZLQBpdPHFmTtRozKb1DCCm3AwhY6A76gB+ZBmO/UtkDFlSl4mVu3D8yex6sDqifdbWNyRuXhYDoWaIX3PVXXCIUG1Odyo//zvwESArRQ0GGjLd0Ls++e/Dcx7ngWozp7R3jsY0Jo8h2dzIKD5ln232fUnkkaguQ/w/w+NQwT/i1WB7u99Yc7aaBGZU6Y4ljZ/IEkjUs7w75kXiW7TW2rMcW0GQ6pK+e4Yq83316V8A1cM/Jf4UqQsIbUPceZ04+zOFAdkMz8nft4mGf9/PFs+IjzoZXgbI9hy/M+l0YuKhEaiStc9giRRmYatU=;5:BSZO+ymH1OgnvvdRg1Iituwf9aQOPcZRgFIKacCdr0x9OHRHVckFGbHtmPzb7by5DHL2HmGnSM2tm+eDB3MmeHA1XeuV33P4k9okV+tUyCVbvH62oDQ/2If8oYor4n6Ahm2yKy6ojR9aXOHOvsr4fGRoYwFPkc40tgL6GjBXFZw=;24:yue3BxYhjTPcUg3i1jFOjr/K6EzJsT2Aw/yyv/GB27n+1ISotQ0qJXha5l549ougYLvXGHRGPMbEUn7p+PJwK+TZps/WsrC1S7M1Ro4w1S4=;7:2wZxNEbp/p4a057FeQVSaOPAqj/d/QNARFOyjDV4quaFhXZ5r38Efqb+VGe7z56JrJwdES+ffwulwg3uY6Z9unyAeFqHSwcrtxZIOEuJ+NjUY8XfgRu2T7FWxW+bkH4qZ1im0sx7n5wdzoucm30pjoYKAonro0VYVKcxacpTn99EcqfWOd/uU7F9zS0jMNEpLClipDenGLtuB2KCerlw3uJ4svoZvf2WabZSRLR13o8dBxsOfD3cQSwBXrMY+aJB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 14:55:42.4802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d1c791-b21a-47f5-04b0-08d572f1dad2
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB1409
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock providers are recommended to use the new struct clk_hw based API,
so implement IMX clk_hw based provider helpers functions to the new
approach.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * no changes
v1->v2:  new patches
---
 drivers/clk/imx/clk.c | 22 ++++++++++++++++++
 drivers/clk/imx/clk.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 9074e69..1efed86 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -18,6 +18,16 @@ void __init imx_check_clocks(struct clk *clks[], unsigned int count)
 			       i, PTR_ERR(clks[i]));
 }
 
+void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (IS_ERR(clks[i]))
+			pr_err("i.MX clk %u: register failed with %ld\n",
+			       i, PTR_ERR(clks[i]));
+}
+
 static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
 {
 	struct of_phandle_args phandle;
@@ -49,6 +59,18 @@ struct clk * __init imx_obtain_fixed_clock(
 	return clk;
 }
 
+struct clk_hw * __init imx_obtain_fixed_clk_hw(struct device_node *np,
+					       const char *name)
+{
+	struct clk *clk;
+
+	clk = of_clk_get_by_name(np, name);
+	if (IS_ERR(clk))
+		return ERR_PTR(-ENOENT);
+
+	return __clk_get_hw(clk);
+}
+
 /*
  * This fixups the register CCM_CSCMR1 write value.
  * The write/read/divider values of the aclk_podf field
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 956155c..3d58420 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -8,6 +8,7 @@
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
+void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 void imx_register_uart_clocks(struct clk ** const clks[]);
 
 extern void imx_cscmr1_fixup(u32 *val);
@@ -54,6 +55,9 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
 struct clk * imx_obtain_fixed_clock(
 			const char *name, unsigned long rate);
 
+struct clk_hw *imx_obtain_fixed_clk_hw(struct device_node *np,
+				       const char *name);
+
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
 
@@ -90,6 +94,16 @@ static inline struct clk *imx_clk_fixed(const char *name, int rate)
 	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
+static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
+static inline struct clk_hw *imx_get_clk_hw_fixed(const char *name, int rate)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
@@ -113,6 +127,15 @@ static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_divider(const char *name,
+						const char *parent,
+						void __iomem *reg, u8 shift,
+						u8 width)
+{
+	return clk_hw_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+				       reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_divider_flags(const char *name,
 		const char *parent, void __iomem *reg, u8 shift, u8 width,
 		unsigned long flags)
@@ -121,6 +144,15 @@ static inline struct clk *imx_clk_divider_flags(const char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,
+						   const char *parent,
+						   void __iomem *reg, u8 shift,
+						   u8 width, unsigned long flags)
+{
+	return clk_hw_register_divider(NULL, name, parent, flags,
+				       reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
@@ -136,6 +168,13 @@ static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 			shift, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_gate(const char *name, const char *parent,
+					     void __iomem *reg, u8 shift)
+{
+	return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+				    shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -208,6 +247,17 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_mux2(const char *name, void __iomem *reg,
+					     u8 shift, u8 width,
+					     const char * const *parents,
+					     int num_parents)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+				   CLK_SET_RATE_NO_REPARENT |
+				   CLK_OPS_PARENT_ENABLE,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux_flags(const char *name,
 			void __iomem *reg, u8 shift, u8 width,
 			const char * const *parents, int num_parents,
@@ -218,6 +268,18 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 			&imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_mux_flags(const char *name,
+						  void __iomem *reg, u8 shift,
+						  u8 width,
+						  const char * const *parents,
+						  int num_parents,
+						  unsigned long flags)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+				   flags | CLK_SET_RATE_NO_REPARENT,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
2.7.4
