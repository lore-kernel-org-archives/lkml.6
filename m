Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeC2D4f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 23:56:35 -0400
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:64288
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751172AbeC2Dzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 23:55:47 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
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
Subject: [PATCH 3/5] powerpc/cache: add cache flush operation for various e500
Date: Thu, 29 Mar 2018 09:31:41 +0800
Message-ID: <20180329013143.22527-3-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180329013143.22527-1-ran.wang_1@nxp.com>
References: <20180329013143.22527-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131667693449289864;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(396003)(39380400002)(346002)(39860400002)(376002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(51416003)(105606002)(508600001)(305945005)(26826003)(5660300001)(356003)(106466001)(59450400001)(48376002)(68736007)(50466002)(1076002)(8936002)(110136005)(54906003)(50226002)(76176011)(316002)(97736004)(47776003)(81156014)(81166006)(336012)(16586007)(8676002)(85426001)(86362001)(6666003)(486005)(126002)(2616005)(6636002)(450100002)(476003)(36756003)(53936002)(486005)(2906002)(26005)(104016004)(77096007)(4326008)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB387;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD012;1:0aUQozII5Z+ud88y7dUUPdWsLjQA7olkIyqateIbgeiWL/ddkNDURgCf62ljg1k65/fpFB/LLfzhPCfzvlWMzMN8Is1fSvKRn/lzU94QLzpt1Ye+QA3JKO7DZtlo567F
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2487fa5b-afbd-43f4-9580-08d59528f2d4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BL2PR03MB387;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;3:U/3pMHykBfpVJowJFpONDAXzeApnywrDQSQOanopnzj+Gfiao2JxWjtFsvztYPQ6hGytnWwBVYxhD/HLxXgSDrhOr99sGj7VPxGABwgp6FMDVI2Hnew+6lAzy8/w/qEmkupXm6w0TiY2kyA07h4H2yNclwjoR6gic82xvDKNDuYLfNscWAx1NHESUY2xCiWCn/OM+jxP3CJuZLvJNZMoGbXOOxSjshPEMmUuNrsB3cvPXMmOeTUtwmQhFgDhSxLKl+KtcrvzgoSpEMmgSIlyEqc7zk7eoz+35JrfdUPaH40p0aNBNf148/dKaYXUytsWd4eRiSEOA4IJ60+t6SFZlPvDCZRTiqlB37NFAncDeJ4=;25:yoQvf/gjKd95qzfpfIrRbqyCdUTc77NnFhNC7Sc1UPvgkldF0f+3iev75tW//U7v7uj+eoe2Hz6ujWqMvgVFNmICgE5LMil8f/brenUsNVcAnppPOx4iUdC/cV9eBmeVijMn6GeWRROmChTPSJZp6Q+grZyUgF9nxd+THVDQrP7HdZhoi6LjgjtftwwSs39N32R0dAxPdQ2H7b3ZtBqgifEp2dYZlAITu19fnmlFk1NV9fLt1Mw4zZM3YUu4b4CYy+UvB4OXd6toH2MB/npso7eePfoB3p0WTKK+dy6o40HAqMjrE2xPcWh7lWRzs9bblN4un63v1zn8MGGVskrMAA==
X-MS-TrafficTypeDiagnostic: BL2PR03MB387:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;31:Xcx9lXh/vnRV2VUHaAbnhhTLTWA+rENXy5hGmkKhLN1mwFCoyS/sbQQyHY+BYQe0yPBgfD47g5NYrZZKT9o10njUbkDZ4onP95JfjT8PgtmOSnA8LjoQbdvmIjQCjL12tZYuyTLfFgw5WAb4Ksy4HksPFOcxxHfB0HefzRc6Ttp22mJCH2nylBWX54hi3Fy5nnAyNMQW9fAV3VP8RZBKWw5Udys+sfKYbou+MoF6S7E=;4:7H/4JS/t1b1RIvMDi5yq1xi6kk7RcRVvUe+LP3+R6PaerV7Gf7DwMSFz8tyVS5h2c9iKAQlpZ6J8YllR8ilQoN+ql0b78C2qUyo5KBFC4Dlgd/ba7mRM5sP8wcwFPUT3P4Y6x9NHeEvuvc71lsKZyyoihTilgeZbQAyGRDF10FP5ewu4KksOCII23Ic9EKip2qftGgw24cX5tms8BTY1Fpjo8Edr9f7WjjHa5+q0bUWbwy8iWcwc5KpllYRVXk4g37Ve/DFj/2ZWeXaXXcrrMmMjQIW1PBDGY0SQOzbvldM6/+7V49v3IEK/BIl6fAeNnZsDyJPmA25w1749E/8OUJ8ZqZAFAWY5pM90g4u4VV0yHA89CE2zNwFFZ/DLPxST
X-Microsoft-Antispam-PRVS: <BL2PR03MB387C172D8D3AF9A65AA02BFF1A20@BL2PR03MB387.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6096035)(20161123563025)(20161123565025)(20161123556025)(20161123559100)(20161123561025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(201708071742011);SRVR:BL2PR03MB387;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB387;
X-Forefront-PRVS: 0626C21B10
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB387;23:5tVe/c5+0ixT0jrZKd0sjC46ITs0mGqNH9Rs49LYQ2?=
 =?us-ascii?Q?SYt+dhubc3jjTbnVDs/4WnhK/WuqaZBjjeLtDLIBepIxubss+TpKCsQq7DhT?=
 =?us-ascii?Q?iUNZUUDXp/IjlKTTYB1+DS41hX+eJdzEPPsgC0gMNNxDcXbmxiPptwrJJigp?=
 =?us-ascii?Q?SCNuc49IGXeNS0YJqM+gSHdOzLle/Jabya9w5c27MltQH+vWwIFUicEJSTSK?=
 =?us-ascii?Q?5IopaDXkkZFQU/Z2FqJ/1JVetRZ4JFD+XGlbCtI4UBJOWGGo+Nqd59eQbzUq?=
 =?us-ascii?Q?HHOp5CsQYO6RtprEUtoFBhjPwXoSHFsmzG1OGm0aRo9zqERvbmKbOPilkx6q?=
 =?us-ascii?Q?IOt/NH4Atk+MlgzMYNWxmL4uiFNA6+9jad8Bw1/EhDoxtmGN4DdUQmcXMha/?=
 =?us-ascii?Q?FBaTSSD8uqMgr2v3W1g9X2Acc46Jn1aC9xe/CHsdcWaiNJHUQwEIztbJUEZn?=
 =?us-ascii?Q?cdwq+6bFmCkOQYZDnjF6KxGurxZ9L8JuYtxCW+KgOnUsc2iZlzXp2QHAUDt5?=
 =?us-ascii?Q?reVKRYxL/N2cCGesW8HmwicgzlqxKY7nnNvh8dFSnHJ5/97nFr+vsAf0IWaw?=
 =?us-ascii?Q?L0J5eEFM/XBg6JqbtgVVIUSnYMzE01QUXHKcYg6FhsrmqFvGNqMEa2+ArtdN?=
 =?us-ascii?Q?gc1kgaKvrOk5w2SUpyQ3R8fAlo3xlCg9kMLspEJWVAXLLQLHhLYsQUYXYEJJ?=
 =?us-ascii?Q?6UUH0nh4bOp1b5mJPkCCK1AoJMJVazQVGd/EdiMFUWI36Zq+MLujGpacH85s?=
 =?us-ascii?Q?X0pEN4sskpuM4+bTM2Zziuv4LRQJgZqFs+Ro+crouOnFAtdUha5laKzMY51i?=
 =?us-ascii?Q?6MNbZIBMqyapm0hDBb6zUXTbYnGuqhqsQN1prQk7w0BV3F9kHLNi+GR7HrAW?=
 =?us-ascii?Q?XPD2ezQMEY7St2BIYjB8ei3P0qravlzzZhicSd87BMdoIO1YhY1usmmK8UCZ?=
 =?us-ascii?Q?FQv/OWHcOqOt7DUxtHSQvVAtkdbWePVJ1HNGgQYjk57AzgBid61Yxw0/7reV?=
 =?us-ascii?Q?qix7iEY+e5hbugZCr909r8rd6v7X+um79QwrylzhRSjnqwCp137+KAWfXQgs?=
 =?us-ascii?Q?ha6fZl/c/P7hPqcDf5luG4j0Y72KTZpbA/mLjOWMiDdhT7kBCjFOozDvqxa9?=
 =?us-ascii?Q?7Fq29IKhLG5AiyGxJlevn5cMT6HbXa2D/XvO3skOCH2lROUOexD3kElkAq/B?=
 =?us-ascii?Q?JDIVz36xvophAcULzJHYGHSaT70TyLfLUQfgP1iQHXOgFx/rA33nsFPiEb06?=
 =?us-ascii?Q?V888HYpnmc1HpqrnjzALPuUUEPgl1aD3kxJqL0n0wB31gWYC2wd6NZ0VqKjQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: pAsq4SUjlz9W3F0MhUgR8I9Lswxmtas86I0w3Ysrc2fzOf13p7v5IIo8BB9FnsFHueGL1i+kQTVD6uV8VmTrNDcLHqmGUEn2NjUAOGBEGrpbRM2fwMkNQMHBGb/Qt8l9qFt6G3cOGMpE8pVv/xvlfkAfOAcAWV3bgNGCSGFO2zCazFIo43HXGgF6XVFzVZK2
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;6:Okm88u+vUpUP/nexBhg74Honsi3Bir0m0boCqO5L9vFDR6+cpi+pOQWt3CTchR0O/67/9PPNPSRgrdKOdJgmRX2Ba4OmP0swOpPIeq60NLFBDOnnoyI7RqCYqe5Jy9mVmh/4Uwawz/WWPv5Gg4aHDsDZL1PLACxNghdpVTB/IKrj9Jqa6pcJk78lHSZnOXyYHKuxORP6AcyjnZo/GSROEtK4+RboVetyG+UdsYYCnuL+yl0BzhMe5rtwSPAULdic84DQeNpb3NAa6MLwpAkvqcOGpgGIARuCqGkZMQGLlTbDBVNgJyUnwPlG3GuCZ/z2lND4VUONNs25bxs5uSYDQ4/9kJ7WtH3ihvJUFScrB7ztn19rt0TvATBM6AegUU1KJgG59nehgejyqCCiDbN4lmP+gMXBtM1HImEE9pGZGCXURtzXjSaD+QTSeMTr7JfFQ5qg7UoLPZc9QieDq6emMw==;5:dDGPGXsPqsBjwFQ9F+cevHhxsKmul84mUE31DwEmearMdGmajGDT/owYoAmjYSH8Hi7q/LixAhgBo1gQmGZSvbiPpWpAByWV6qOIdCFsjmcdbTHhjWYkhOQbxsCBbGOHNbtTc2qlJvucRkjMo37RjGl/QjJI4snni43Jtzl77Vo=;24:IsZOvKDLRXJwCGnxiod5eq/T1AC9JbK0oNyrF8lWtXs5UOEi82pv1NDrfBi7ZnRolrg+YN4cbiRkPLHLXmJI+/yO4ZEXaD+fak20/VRNvUw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;7:mxx1i2jnnTyAkuqISweTwPI922sr4Vg4UJ1/rDn30t/oCo0isQQETyjpRKYGj/x+++w0JcZTTq++V8N3oq5aPmap9elUMBGvOdZbhBQnSZrrS9Gh9U2W8Vey+x009r4SGtxqTmkiQ/DKp1kOkeJJG50ZBN35Gr6iQU67vme/2Gr6dHVfz/eRGbw4u46yutbcp8E1iJp4wbeRrWhVFsrRVfKd5+bOCumXLPF4bMTfAanHlch2VibJwqKNgsEzfJLo
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 03:55:43.7433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2487fa5b-afbd-43f4-9580-08d59528f2d4
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB387
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
 arch/powerpc/include/asm/cputable.h       |   12 ++++
 arch/powerpc/kernel/asm-offsets.c         |    3 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   81 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c            |    4 ++
 4 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a2c5c95..364e6cf 100644
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
