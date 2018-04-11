Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeDKG5e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:57:34 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:46240
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752588AbeDKG5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:57:16 -0400
Authentication-Results: spf=fail (sender IP is 192.88.158.2)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 3/6] powerpc/cache: add cache flush operation for various e500
Date: Wed, 11 Apr 2018 14:35:48 +0800
Message-ID: <20180411063551.30368-3-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180411063551.30368-1-ran.wang_1@nxp.com>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:192.88.158.2;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(110136005)(6666003)(68736007)(69596002)(48376002)(498600001)(105606002)(104016004)(6636002)(76176011)(16586007)(53936002)(77096007)(336012)(36756003)(59450400001)(26005)(54906003)(51416003)(446003)(11346002)(2616005)(97736004)(476003)(86362001)(8656006)(8936002)(126002)(81166006)(81156014)(316002)(8676002)(486006)(1076002)(106466001)(356003)(2906002)(85426001)(7416002)(47776003)(50226002)(305945005)(4326008)(50466002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR03MB2189;H:az84smr01.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD017;1:0TzOV6VkNnpZgUk77pIDon7YC1Qlj599/AMnaowkZYYtQMG9JCas0Gxy5lRQgUPz35oD5ao0PMgkmgzyB/7IbbtK9nQc2AWzqcO+z9N1pF4rfE9ox6FITiCzuY0A+vw5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(5600026)(2017052603328)(7153060);SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;3:HulU/JBbbzbE9R7IembJbJLlvCIVnmrHXn4VOsOgzIvkBXeNsUMw1k5WPja2yBpOJuZ32b0hfM6rVYcpFiv5+dH5d7oVoLJiPWvuQlipW7OCUc974JZemeVnri8vrTjr//PvaYoN6ZqyRc8VzRDhOY3UlncfVzS+WhVazf0WJU97RN3FX6GGl3IRsHeNzbm8k862CAY1kOiFoxBtIsx8ei14ZAwnsQS1nwoE/bDLbWbM62aQXxJQ/f01+WmStdA1xuIqwaGmAc8IxH06PmLiscn2sOtQG7vKsF1dwndRWo3EM4maMgEO8WHw7jrF3z7Lndhm1CiQcLpf4HbS5uVRp9dWKAaS7GgXd4ecQkEkrVg=;25:qw8i2UPXrL/KHclyZ/g5T710QWrnhUSYw/e6wkthHaO1yte5trC9zV6yeEhcsWAgD8ELCXr0oB04io10b1tGuHggJxZqr/1UHq0am4LZ3Bcrs8RxUzqlqW0HHgNUaHwN8y0NQZf7MfjfoZFvXtvOvCnIuA1rp9m+lDAmOFH1or9Fi3BdkzXbv4CqJedl9jJ9tRPRqjnB9wm5T/xQ6rj9aeDV6zdcgYlVUKpNA8DAhfZOIyYMjCrOEkqHIWGuHsW0NhcLoxMgGjYE+uaonRt343VDfjscDfYzmnwTjGzersacnyBXWMMWAob3+2GycYZlCyF2YsXbVbkyKKbHftTX6Q==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2189:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;31:DjKm3UM42mQBEHnRMJwW9+SZxYmAiiMXNaTMAgBB1uDSRJKYx/gb22VDNHGojuGbk5sDG0AlshMT3SIPzEVJTK8222CArE7ACh2x9xTLqLZLO6tMf/wD6GWDqSyqxpChSSaaaPoFd6hLL7NwGM2yTsE0IMiVkzpoWT6y6gxfMZZjL0jmtKmuB13yUaaw+z0tOXGh8vz5lK4ZUwcPAzt38STPJ66sKz8z+hoUp3O2jik=;20:WQ00t3FM8uC3uOpZoxldPABr6GCJeeIqfIP/WxuPhMUISezUwdp6w3t2EN0UE6kfeadSu/b/Vj7ShMoSbyCbhRzDvw+vcIjLqiHylNL+ES4W5jvKCqLncPi7SXULKlj6u8hd3FL8OhF4ac2NVx7RpdP5jYzP8U/yx8yWcCCj2bWYblXfqDSkzgqq5e6YGwlxUBQoz2JbBamkajAmMHsVlo3VomhaCRpP7KzM/M8lTinBLD3O+EsOGzix8LtmirIXUocnlh+YxUiKpY+dNNLQNjEjsQTUaVVt3nnksiOYl700lKtgx82uvCD6cPmk3ijnozJqkbZJ/3Z9gpovGrW3s/yZqcqcRIFzYgVgANqfZk/makcXah/dQmQMxUG6zHfaL36IJWxhGhZ2dSf74zaol6N8OQRvQKGgzNTn0inELWF1wXdI58+o/23RqwG4JYh5U+29q2YMvbC8o7ZI3LkiFsvDKglg2r9vYZiEo65IRM13/BKsJGGw8ksoguWHGIw2eXPAmaUz6IXbsbMIJ1CqC9HSVZXyJBrHwen/efTV0WheaLnfN9ywt95N7IdcWTHxXK8NdQKijVe2ZPbN9WrKoBM9mQ4r8shjp3GwTuOvMWg=
X-Microsoft-Antispam-PRVS: <SN2PR03MB2189D4FEB87B95607F18231FF1BD0@SN2PR03MB2189.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(6072148)(201708071742011);SRVR:SN2PR03MB2189;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;4:LB0CfBTk6LxO9U9PFOQujMqnd3D16uFwFz7ZKxh5YJPKO2+/SSbcij6CZNOaEBHob9KBj9/IA71BDjBE1xCXm2HVtHwvTOIBay+t5IhmAr93NplY8JMiN03g2O2xcHfcItNADzCZdqI8dHlGFtzjyzPEvEf6J5v5HHmcSGc/7zuqU7f8DgIga8yggeVYyivNQCTSBXV78TY8sio4H3uTmi1kim3fTTu2Kn9tAEjzbxx6GedkBYLFgshqD2W4Gxgwh/70PHBQuul++E8gO1KSCNkCkltV77rtvulDwBckOL98yVgx5mBWgF2u/1U722DwaizSXi9bgIh9zmCSgj6ze8Mb4GuYUiINzRBUHalF9j/T59HhJyDRKRa+VWBZU1zV
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2189;23:TlZW/YcpGYrKYOmsoHeImUEOvrl2lQfu4STFHR3P8?=
 =?us-ascii?Q?Ko0SmbUbIJ6Q9nsiTy+ItPIpaMCGEwz3jKY1nkgN/63zTHrhIsimwybcW1vo?=
 =?us-ascii?Q?bF/vPDMkkwWXnBVgEZY5f8pE2HIy/KxLiUkeR8463dlcvVtsO+bdy/bjTLNH?=
 =?us-ascii?Q?rWuP40wcMqnr2PNiuEW3HpoGDAmiAbrssPmP+wEHqiC2tqd6o7gzp+hddzvG?=
 =?us-ascii?Q?7wcviaCP2kelm+zowLIbUgj+DGZHpvIyyAFiqpELmQcu+BAtoaW9soOMwOpJ?=
 =?us-ascii?Q?KtuCZ/88t4jFXX9aerxvgH5hxo/yVNwaVj/6pSeavHAsq02mnwo2T7JDGglF?=
 =?us-ascii?Q?3PWHpOe5EnErTmJaqodDsKTn7bUV2JsF3qvlkeRhWJokiTIzO4TyV6g4d959?=
 =?us-ascii?Q?d4WvOfM+gJFB4f9IpoPQQAPgWGsIUJ4SjHZrXEuJDUracoIWlBvw0KZWg69K?=
 =?us-ascii?Q?2BuphhZ+HQtx2nsF5KLJyTfXu6MpIA1Tyf3M2qDfE664Bq9RDvRpiZt0YzrU?=
 =?us-ascii?Q?CJcu9eFZDxSen1tVK8WOtjKOT7nwqNXMXVepyhym8oRg+ZZ0rCz5FuQvHitz?=
 =?us-ascii?Q?qoXzBT0nwA/lZW9eoUofSVUs0CBd7b1U1R/JNvzj7Q/TgPcaf8uLL4CAlNuq?=
 =?us-ascii?Q?i70Ct6hik3DAfpBJQDvauP3cjHRfNpxEHh0/RNOFnPq5YfEVl3jrQ48d426q?=
 =?us-ascii?Q?vmdhKtZULJ31SVXxypguL6VC7pyumT474iAvSzegvAY0C6fN/oMd53D5VFNI?=
 =?us-ascii?Q?QY0U+nODESCL3NTMocj1bwG6XMDkQL0dH1ghhkxvIQmegVoQZAMjGHKpyEKI?=
 =?us-ascii?Q?00mpAN1XAMoNt3gBxRW3j9Koyss7hMVmYT/CHC5KQvchi5mBmpxgURNVHaM2?=
 =?us-ascii?Q?wkgIkimTzntaDU+bKt+GZ+Jpe4HgI0e4ihR4BmQLiNjdsLzp8bt83SN0lTHG?=
 =?us-ascii?Q?1oi9vWlPtyKDTnmOy8EwOX7XesMo/TGRLx9KT4oebNjuS6azUuFC66u7VHWp?=
 =?us-ascii?Q?VBZXEvqTNZzMF9ZhbyyJOmZ4YHp72Wr7UlGvABHsgmHuz0XwOUeTnF2iOJzS?=
 =?us-ascii?Q?e+CiXHhP0ktAoGxxw8j+yJextnPi8rIlpasEfYQiGqIMklqSK2lJj2y4BS5S?=
 =?us-ascii?Q?SfWJ0wdXcCS3hH7PXffadz++IhTQFSTMlQXoQRfzorS4DRmXATw4T8AEhOnz?=
 =?us-ascii?Q?CvZZDR83YlYmMCYCeHDQ/VyqEsOSUhIRJuMeH108h3kw3QAbnd+Sl9IK13Hg?=
 =?us-ascii?Q?dzlvz/73QMoioon4l6o29RVk4MzXYiArHc1/RzI?=
X-Microsoft-Antispam-Message-Info: t9gq1ftMTcbC2cDR41XYHpHyzTISZAolR+o2b6b8G5JIhl6+bal8QYj6YwJwA4OzV7oCmeJinl/pfjMnVJN3411LoPbb/KSu1jqEABdQYDS05PJ6iHLeTdDKDfA9Bhs2thagnujUqPNL/+6fplASA7+Ojzc5nVFL1AdO7LzW/adlK2zIWgiUEtio0Z6RxnbT
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;6:R2G8nZ8qWhexZkWSmIOTRR9ozw/dRFyOJWoTnDOkIRdGXApW6ssJ/44e9dBgbICDpxwnf/mi/2KsdMkpQWIUNqSYg57j91ztR4mneB/GddPa/OpK1ys58tqcMMZh2nDj/zA9xt9nh+w1wzpZrywH/EaN7GSk1QOVdXplaJc3r8tf/NdWaYBqL2OTEexk5ohl5qY85sz1BNwNf01qSUjdb57DPUvKSCcbqVcvHt3dhbXwlJ4pHzR+XkGtQrneIpaObIMxUjI5PrZwd2C+p+A2NWITX3IefwmWcVWKNAdP8FI0Yx/c3+CUnLoaKPjP6qL+k92F1z/DG/oVytiv2y07Pf97XoujEqBN4+K+o+EzN5VuF0/LJQyWfEKPX/KRQTZOeMpzgzVkTV30aLPSaQRKBYJEQxsseKDVVyvrW5i/r9XTeLF7zzooOsgQOt2MHYrcSGRFepfL+UcgUYbgoeaAzw==;5:2VLvd4/5XiOuMP6SEUfkBsNNp08GgsuViHztXD4F+Lo/rivpZIYAANOyJ9DZbopznfRYn0KOfcVQmc+ccOh4xYbbwfLsmcnx2Gqvu0VmBSeCq8yNk6KydwLfn7aip2H/yf6lk1m0xmctQJdUEBrGV/C2LWjrglk8F32PLoRL+K8=;24:igfysTReTPD374sLw1sOBD0EFKYFcQ07d2785fCAc3w1o6bU1qi+omXhN3v4c3TikOFDXNiM6vLoi0wm37FczEwg3uyMQCoOsWcCnpxx11M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;7:o4fz5qzJh5UezeYAjFEzyxdEh4/bnaRkpUsnUsSYmBJxT1Tet3I9Zh+ekqGW51lPRQJtkesUSCNh58TVhQ4Sv+tbmLQev4PTapAxq0q//RPNH5argHV+HSSQXznQZh7YOyzXXSZKpdH0CpMihjkG/wXykDd1mWhwltnQvwZzpwZIQNlT01uwRleGox/O15kbzL+eX2FcoeWZ6xDKfHC5WsV5+QHSB0Wv2zsO/qaOsiQ1jv8lm6ykHqpxvgqeZuSJ
X-MS-Office365-Filtering-Correlation-Id: 5659e648-5312-4aa2-bd7f-08d59f79740e
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 06:57:12.8527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5659e648-5312-4aa2-bd7f-08d59f79740e
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[192.88.158.2];Helo=[az84smr01.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various e500 core have different cache architecture, so they
need different cache flush operations. Therefore, add a callback
function cpu_flush_caches to the struct cpu_spec. The cache flush
operation for the specific kind of e500 is selected at init time.
The callback function will flush all caches in the current cpu.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
Reviewed-by: Yang Li <LeoLi@freescale.com>
Reviewed-by: Jose Rivera <German.Rivera@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - no change

 arch/powerpc/include/asm/cputable.h       |   12 ++++
 arch/powerpc/kernel/asm-offsets.c         |    3 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   81 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c            |    4 ++
 4 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 2e2bacb..d04c46d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -44,6 +44,14 @@ enum powerpc_pmc_type {
 extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_e200(struct pt_regs *regs);
 extern int machine_check_47x(struct pt_regs *regs);
+
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+extern void __flush_caches_e500v2(void);
+extern void __flush_caches_e500mc(void);
+extern void __flush_caches_e5500(void);
+extern void __flush_caches_e6500(void);
+#endif
+
 int machine_check_8xx(struct pt_regs *regs);
 
 extern void cpu_down_flush_e500v2(void);
@@ -70,6 +78,10 @@ struct cpu_spec {
 	/* flush caches inside the current cpu */
 	void (*cpu_down_flush)(void);
 
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+	/* flush caches of the cpu which is running the function */
+	void (*cpu_flush_caches)(void);
+#endif
 	/* number of performance monitor counters */
 	unsigned int	num_pmcs;
 	enum powerpc_pmc_type pmc_type;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ea5eb91..cb4b869 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -351,6 +351,9 @@ int main(void)
 	OFFSET(CPU_SPEC_FEATURES, cpu_spec, cpu_features);
 	OFFSET(CPU_SPEC_SETUP, cpu_spec, cpu_setup);
 	OFFSET(CPU_SPEC_RESTORE, cpu_spec, cpu_restore);
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+	OFFSET(CPU_FLUSH_CACHES, cpu_spec, cpu_flush_caches);
+#endif
 
 	OFFSET(pbe_address, pbe, address);
 	OFFSET(pbe_orig_address, pbe, orig_address);
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 462aed9..e94eb41 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -345,3 +345,84 @@ _GLOBAL(cpu_down_flush_e5500)
 /* L1 Data Cache of e6500 contains no modified data, no flush is required */
 _GLOBAL(cpu_down_flush_e6500)
 	blr
+
+_GLOBAL(__flush_caches_e500v2)
+	mflr r0
+	bl	flush_dcache_L1
+	mtlr r0
+	blr
+
+_GLOBAL(__flush_caches_e500mc)
+_GLOBAL(__flush_caches_e5500)
+	mflr r0
+	bl	flush_dcache_L1
+	bl	flush_backside_L2_cache
+	mtlr r0
+	blr
+
+/* L1 Data Cache of e6500 contains no modified data, no flush is required */
+_GLOBAL(__flush_caches_e6500)
+	blr
+
+	/* r3 = virtual address of L2 controller, WIMG = 01xx */
+_GLOBAL(flush_disable_L2)
+	/* It's a write-through cache, so only invalidation is needed. */
+	mbar
+	isync
+	lwz	r4, 0(r3)
+	li	r5, 1
+	rlwimi	r4, r5, 30, 0xc0000000
+	stw	r4, 0(r3)
+
+	/* Wait for the invalidate to finish */
+1:	lwz	r4, 0(r3)
+	andis.	r4, r4, 0x4000
+	bne	1b
+	mbar
+
+	blr
+
+	/* r3 = virtual address of L2 controller, WIMG = 01xx */
+_GLOBAL(invalidate_enable_L2)
+	mbar
+	isync
+	lwz	r4, 0(r3)
+	li	r5, 3
+	rlwimi	r4, r5, 30, 0xc0000000
+	stw	r4, 0(r3)
+
+	/* Wait for the invalidate to finish */
+1:	lwz	r4, 0(r3)
+	andis.	r4, r4, 0x4000
+	bne	1b
+	mbar
+
+	blr
+
+/* Flush L1 d-cache, invalidate and disable d-cache and i-cache */
+_GLOBAL(__flush_disable_L1)
+	mflr	r10
+	bl	flush_dcache_L1	/* Flush L1 d-cache */
+	mtlr	r10
+
+	mfspr	r4, SPRN_L1CSR0	/* Invalidate and disable d-cache */
+	li	r5, 2
+	rlwimi	r4, r5, 0, 3
+
+	msync
+	isync
+	mtspr	SPRN_L1CSR0, r4
+	isync
+
+1:	mfspr	r4, SPRN_L1CSR0	/* Wait for the invalidate to finish */
+	andi.	r4, r4, 2
+	bne	1b
+
+	mfspr	r4, SPRN_L1CSR1	/* Invalidate and disable i-cache */
+	li	r5, 2
+	rlwimi	r4, r5, 0, 3
+
+	mtspr	SPRN_L1CSR1, r4
+	isync
+
+	blr
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c40a9fc..eec3ca7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2100,6 +2100,7 @@
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
 		.cpu_down_flush		= cpu_down_flush_e500v2,
+		.cpu_flush_caches	= __flush_caches_e500v2,
 	},
 #else
 	{	/* e500mc */
@@ -2120,6 +2121,7 @@
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce500mc",
 		.cpu_down_flush		= cpu_down_flush_e500mc,
+		.cpu_flush_caches	= __flush_caches_e500mc,
 	},
 #endif /* CONFIG_PPC_E500MC */
 #endif /* CONFIG_PPC32 */
@@ -2145,6 +2147,7 @@
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce5500",
 		.cpu_down_flush		= cpu_down_flush_e5500,
+		.cpu_flush_caches	= __flush_caches_e5500,
 	},
 	{	/* e6500 */
 		.pvr_mask		= 0xffff0000,
@@ -2168,6 +2171,7 @@
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce6500",
 		.cpu_down_flush		= cpu_down_flush_e6500,
+		.cpu_flush_caches	= __flush_caches_e6500,
 	},
 #endif /* CONFIG_PPC_E500MC */
 #ifdef CONFIG_PPC32
-- 
1.7.1
