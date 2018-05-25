Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935962AbeEYHwO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:52:14 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:59072
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965049AbeEYHwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:52:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V4 8/9] clk: imx: implement new clk_hw based APIs
Date: Fri, 25 May 2018 15:51:10 +0800
Message-Id: <1527234671-31755-9-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
References: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To AM0PR04MB4210.eurprd04.prod.outlook.com
 (2603:10a6:208:66::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4210;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:BLkPXcIWdnCUd84Ot5szaWADIYpRR0a5dGM4t8jzU48N3CLxfexv71mb+A24AT4mtMeXwxKX0RL3vLO0rm/VltDSxnLnsfjVUeQK8cKxpR2oyh73GTKpxAkKcYHG0O0E3AoaHa9OrH7q/cEMArN2PpLbGwBp98tDDcRnxIvGxH8JcZBStYmsPt/GjpIJATlImM250sRrw7n/T1sjgeOaBc69enY5G4Oq2YLVd62YFrWR6eokn5cepg5tpVPPFdNN;25:LrdUEH/dfei3NQfEEXWuysD/IhFrF57vUN02fs2WqzFbh4YGqbqNs3YEQ3Rdx4v2Vc+y7JPs1mAQ3KG6aRc10DGeCMW3CPZdmBqbpX4Vj5u4L9yewkZEpWNfPJIazwhmfh91/d/Pzml9geI+4l9L79+O7tSTQSMw3qOkNVqIKmstTVMKJtyUGOYClqO2VbkuD+NgHT8gBZ1BBm4+5UaY3/zeNCE7mfg3Ymv/ry09Qe46DrtmvRoo35F2FZZXdlseb1IhxvvX8jSCSjNd95LZcklusEvv33TfT1sb0BZhNeabJAHOAW6DblEXFODdXe5VGcSKilRVleJEuFqURYoXvw==;31:L8HBq27EAxlsnSFF+vZvkeupg8nU06omSXFUFO0PepFVo526uYe5tOZYHSswP9/q+2pIYB14A2r6CxjkHXi20Sqk1jswJow5It1jiNi9+SYe93K/guiY0Y1fPxMO6P5MXfW4eRVYRKfDvYXCnjIB9d8+8TnfHToZ5xt8kQHoVGpURkwXmE1u+wtaiSwPVehhkBCVYd3GiVGfUDHEh1kOU/3lVLHaHYD2YbtodyAkV18=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:YpCKHrY0ZZ/H99RfBC+Smhes82IbeidJho6oZ1zcQNSveKz+TZX1gJPuThoUztom+rz/v5f21C3J3f70OGUiYm7Ylpkxw8umNQq0Aki3mIbrXj2H0klH4MK/WZ6YMvfxfyn1OMs50jRj4HEVSh3hU8R84VlFI+dukIFC2HKoVqrNgiDHtpCr1slvtnNgtVGVi12d7Px6s8LEvEAz1nsVdjKm0zQcMUVbcHae+DVxJfGtmu26prnI/awrNkftqxa/5xxGU/jFsSBLUUS+5+0J3ROxLuh/6b2Sky77KlqT7ZyL1RGNOp5aAeUPhgth6IAjZUAQ4sRPS+43+gLRh7ACt2VqlXr7BacnlJluFnYqzJr0CmPmu+S4g3l+owMEDAUb/d17vSohOhi5/PrDVKA6cPKCRC6iA/orP9B7oCWwQd6X2XNRMKtAer5a0jBz4l8JKNTQW1MxbfUVRImP3yiZ1H6ZlMvV8dyNbWQdIeWf1BidLYagQY96Nk4E+lnqdo8k;4:nBwZK0+EwvRi+S+fybFWP0ggMGjEmLvpU3gCYxdc5uhFOisJShgpalCA1CMwK09df7sz3bKcPu4P/ZMlr276vCIMbSCybHryPsmQURXwMZ9OGuwXgmascR0y4LaEoKmfsvkLuKy9X++1FcxKOTFA0VvynbFilK0u9F5bvozNz57Omf3wCljJd5p6DXEYGIoMJAZUSpgYcTLMFDuqmkF6OdB40lQebwsOXu9GQeILP6kGc9zIwI5Cw7SKcLqaJFMdUdUvFZdyhlzgkKIVUaaobIB9bPpIODdXZUHgzpOhppSMpk8/yl6OBgARIc25eLn9
X-Microsoft-Antispam-PRVS: <AM0PR04MB42108DFDB586508DBE54BB6280690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(59450400001)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:jvJgWmfHJ3Y80WtxDFko52cf6tTlXTRC+Om/1dWs9?=
 =?us-ascii?Q?nkz+x7A/mum/6+NWO/QYjy/+wOJp4R2vwPpcEEC2nMtWojJR6sb4XNJVw5LI?=
 =?us-ascii?Q?jlccr9Oc2XjfVBMb2Q6MJoxUi1L/6TGrMRwXjFjl9rCN4JngiiVHUvCu87+5?=
 =?us-ascii?Q?l3Qkf7LfV1CBz7s+zR0Qr33ZtscRhts4p6b907ILhHOp4C04ucKC2ajyDyY5?=
 =?us-ascii?Q?cuYunLMrSrd5qdvEDnxZtq+HZ6RLyQg/QzP+6Oth90CJwK47q3eS1W8hbjPC?=
 =?us-ascii?Q?IuO2mzbnDryvpUYdNSTFslV2ZX2INJwprT/BsGjBDunlTS//PLrSavNab/Pz?=
 =?us-ascii?Q?eTLGPsv3Puqjbs/bXC/9bJ1erJN/TbsS1T95wjK3ENpfronYavq0rTxQ3I6j?=
 =?us-ascii?Q?4jgy0SOa3sSXCp6pNp/PTooPxM05k1ntz5IZpM/LtJLvRoaCH/Ua6XHALSJe?=
 =?us-ascii?Q?mlTAmWmx5JIanMGkEERv5gg1xniKczMxbvTVN9P9LsXr18gQQqKim9/XYl4O?=
 =?us-ascii?Q?+E9VrStvnlz7uVn14mRqLoL88jXhEjkNr9MPjCHBxxpHeEcjReH3IxVV/sv0?=
 =?us-ascii?Q?JGEUUGsNd0sBfec8MrQI1C7Z1EJ2S+XGe9vNb2pgTqlOETyKH4/4KkriZEfE?=
 =?us-ascii?Q?UWQTzIL2Udyxz5+gkuNr2iibBZYFewxBrAiEKSPkvacZwzWsyfRW046vCHlq?=
 =?us-ascii?Q?fTRwQoFyEa5KC7CfBqg/UTcAu7VO8tWX6DTnDBR6+gSz2aDcQwTtLkxJn6FX?=
 =?us-ascii?Q?4qB8OvZWkMRo2lYhCkRXHjo4LB/yiuA5rnt0QRF+poUfuC2470OXTrJkDOTf?=
 =?us-ascii?Q?Bn+FbyNXWx47fo2G/pG863YHgGNfSIf6jKtEVQrgJGQBTc5f4eWYvd6SVDhL?=
 =?us-ascii?Q?u12tQcU0KZWhDZ8KPVoBQI08YDt0xX03gy1XrpngPemQ/aBOFPZ7VYbJrr6H?=
 =?us-ascii?Q?jlkzTnN8G04+GVfcjEZWRJjuo1A4ebtXUZpLCglEL7SuEtSm6uZ60WZSWo2V?=
 =?us-ascii?Q?i1ffAJbNmFW57s5iK3D4hgCWtu1miL/yVFhnKooM7p6uvNeYufOsWIfKW3zc?=
 =?us-ascii?Q?cEJ+w+GSNuH/2ZLhpXAVaGLVajFn0uBUH3QNKNqRGYhHevsStr3eZiFHdg2V?=
 =?us-ascii?Q?DXlqiPc5SkP0/t3VJrRFOiGJsddydOQyNt+GqFOOzb+158XJQETPM5kDWyfE?=
 =?us-ascii?Q?h84CJfJu6l0BsGhCRLCIP/HBD9FLVAenr1hmTAsIa/BgcRDkD+cCW6RttThd?=
 =?us-ascii?Q?eYBsaZ+a5BzIPJAQ+2a8RtIPmZJ2LpwQRYqJmFndJNMWFPiGbMz97uG7sRoL?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: zRwVTbWBSWVmiofJ5dDouW2B6k2O3triqAE6hlqPwW1+lzS11Iw0OOeZNFVppwkt8QM/T6Iz2BUmzjg93oLg962R+lI9fYvPVZG6/9dVAoJWePUcCMguOUqsZj8e23YZs7AYAaXj+58VvcG9s+1xp9pDIZ33TfegD1IDkv7APBu4drc0ao2iweohpbN541sb
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:qYYNcgIbR0m1DjT0HX5R+Usbe1jxKxda7gcAbfz7Y+fMmM8JoJ4tK/+6nTG80fDxusmqHu3a3dAX9uY5bl8UG5MnvQGuYWPl8h8BqXKAnbvO5l7I/JP9KYZXNpTGZ1tBQ4k2CN4juUZvnFUHbnHhUqNwh9Garxxn2BNLBup8JxdM+fnPIzB0M0OoGQ+xTZveyQXLuaSkZ8suEx/aJ6+A9UcvvJfyAQo/FG5O55Sw7f2atw/gFYUXDAPSz9wSBAEn0IvW+Bkc46JhLeC71fqZhsQWU54onI94rveSz0WBZnZJifxglJSfdHfkQg0A2AAOxL93nIEVHkKHYUawqznR0x/MTY9vvxKhM0x8sJY4r5e5RZDyTLUfBS3lOsZrCv5ABaQVmx1ay8irJ+yaihT88yjZGrHXpTMK3Xfr31YHPYLahzzQFVTba7B2zBDj/04YaoypJJanNUg+i2eH/8mHkA==;5:rPMMDEaAWomJNLnN6YJbJdgHIzk7De06yapKZaEGeOSKogntNdiQx4cVa6RdDsXRW+PMy78NoAYzw6ldxgim975UF7js1Fg+/KicPuWlaq1C7mTdektJmHFqPAmZDXdy5KjUeH8G9szQ8JNxPEdzBShHVQJLdQccFY81GgwhMm4=;24:fDNGd1km9wGfM1fdb8Fv7vK1pfcb0WCXm2uO1B8SN33ED01S7tzObTFhWPpzR7K6iKXdZ2GQ0Q+1z4VvU9Bj49mZa2FtM9Z/+o6V8wnnZbU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:ShAsj525+zGl+9QZeDX/kC8OsPaML58UHSdwNuLFNvyObO+qfiIcK9UImb9z4JSIVLg0p6kMtPUe5H6QEk4Ws3KDvw3AY6hJsmcAGk6V63fBY16AzIsErFlEVi73Tz32DxO3cTQUG7O5a4PqpU6+TMdPqm05pqHdLpBzPEAXMWWiWQxLXXQ0UalMrDfHqmGkIobWZn+u+0W12hn8KcJ1kmqNlBOiTZ6HiPyikjUiJvCD+77QoHRukdFKiIRZf7Hx
X-MS-Office365-Filtering-Correlation-Id: b7e86868-9503-4f5a-5a18-08d5c214689c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:52:02.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e86868-9503-4f5a-5a18-08d5c214689c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
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
index 7fca912..d3fcaa5 100644
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
@@ -143,6 +175,13 @@ static inline struct clk *imx_clk_gate_flags(const char *name, const char *paren
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
@@ -222,6 +261,17 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
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
@@ -232,6 +282,18 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
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
