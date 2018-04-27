Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932943AbeD0Vso (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:48:44 -0400
Received: from mail-co1nam03on0049.outbound.protection.outlook.com ([104.47.40.49]:57424
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932373AbeD0VsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:48:18 -0400
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        rientjes@google.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 1/2] x86/CPU: Modify detect_extended_topology() to return result
Date: Fri, 27 Apr 2018 16:48:00 -0500
Message-Id: <1524865681-112110-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524865681-112110-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524865681-112110-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:405:39::46) To BY2PR12MB0132.namprd12.prod.outlook.com
 (2a01:111:e400:585a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0132;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;3:MFzqyJZzh0W+JhkiLR1nS8BoV/z/79rUZe0BOls9OnR19/pEpQIjWizX7fZbnsHFGNzbKfIRxvJNsEx1JhADzYqkFjo0CIcZdjezMYC8ptTLIxt2wnyqypDPEKtXsmkjwzVBOiCj36P5vUt5KeqNnYGBOajs/NruvuQ+62hVU47geRQXt/Rye7NzPl8NYsmBqSWifoEbZ+0iuanfUB6NxJOWba7vg2fG9sYQEp08HwkPa3Fm9dPN/bKVjSSapPPk;25:S0bX0OM3B8JePJ5J7/+diRqYL/6YJ019hZ6eLrZHYqLUggk5ojaZqjC7TPMiQdzbOiqolILAYslfO47m+m6oPGNCwM6xdBvXUoqylgpWIAsdN/QmE9UwyKC7BMAvOsC+3/mgUIDNAo8vh277+rD4FEi7xJBHar7q3EQ24CyYCBifv9IxqfsmtnnQHScqqS43/xTf4gW9cO+r3wOOpzQ3aADCJfhD/osSt7UmIisAe3zXMPc1+HHe1KWXnfFhkDA6bRwAXDzkc5a2/KDpspErq5BW+06QJF26ALaxoY/cXDPRccLbT16mBWVY1DfGjLn2d5roIydQqNRgl3mi1ZP/zw==;31:oDYvzpsUE+hiFzlOz17X/JqMgGE5Oy/F29lrsnxaVZMiprtf4mn/Cg0bUWv6p0DfkElh2F4Jp09v3+tzbxgpw+s02SrUNd2l/qzRuFGQCEvTu8Mjp57fGozqS2C+Min0NgVVjJ6nkriTIFxHIhXzH7dxLy0gLoXRiU/yZTZeGc5aDhNWRvQ+Z73zirqS6qrCx95qWYk/gif6X9J/5V/gfer/lIcSOzjbqo41H6q0DLk=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0132:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;20:N9azxdDyy18cdZ8ycjaigyUWH1TeMdUSTeotX39nLacaF04hqi26Qwdteu6eRRUZP73jPhD9IChBXNz3PyZCJEKdVSfqV7fwAgbFzVf4WAzPgGYaFYeL5KmJoCSU8kX0+jaBAe6vx2zNt+LjbOXj4I656PXt7pkiPFnyvzJHMHShIFbv0PD3yYrQ7TP4UMkwmq1LnzysvSIQMSqpp//qF54ABVDbGrxutcb/aQ97tnwzEOPeBpdA0XnpRlybac2sD2apC7Gi1lPhZeA08/0MccrBS0bwo11EOI3ivKpgbbtm2H/GJZXUsq68ov8xpZcN8FC3X0+5F1LVAkun+9T0Xmi+cHmHnswwqGRdy6LoIfSm8vdFWuD9RYrj4GbQd5GCLwNCLEuaBEtdk2++UySNmAxbMw/3btH2/yEFu1LTyOJSnFTTCCuVzbTxB7bM/UZ1Z5MlsWkl/Nu2TOns+PI5MLI2o53m5nPlDynT4YY3fI/QrHfsMk9u9KuRT4C1XcZm;4:KqrEk6VrbMrDA2UH3fiwrSL5lsP+i5rAD4lym4YpH2SFO7q+dSg5tqpxvhIYjRCWMeWsoivxRLux/rw4fa3TqwoGQJVh6tkgsDOD4r+9cK5BSe4LlQI4WLn61hc6yD9k3k7MM4x7L7TyQwaoqb+/boKu+y9OLOZCTes7mH3YU1UK/E/+L/n6fr+drMcJLV7B8wjodGXU4YItahe6occJY6prkEXAEPsnBcqLrJANGUBtha2BSGtglV24AkC3YKhkbJc9ePTD6cs0aWCP5e4O1tmtUDsfA1EH+989lURY4+X8bZtrX9NznEoXJ8GrFEAL
X-Microsoft-Antispam-PRVS: <BY2PR12MB0132A4D3D8E32BFA55873D00F38D0@BY2PR12MB0132.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231239)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0132;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0132;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(199004)(189003)(66066001)(186003)(105586002)(6666003)(16526019)(81166006)(51416003)(81156014)(6486002)(106356001)(48376002)(486006)(476003)(68736007)(53416004)(50466002)(8676002)(11346002)(2616005)(956004)(446003)(7696005)(5660300001)(8936002)(52116002)(2906002)(36756003)(72206003)(386003)(7736002)(59450400001)(76176011)(478600001)(44832011)(305945005)(97736004)(53936002)(26005)(6116002)(575784001)(86362001)(50226002)(4326008)(16586007)(25786009)(3846002)(47776003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0132;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0132;23:f4YZTjkLZtlKdjrnKEqpKyTDOV7D2AKRIJl0EB85D?=
 =?us-ascii?Q?7YYbFpSgTD17kANZQZfU9FRZLeJZ4zynjq827A3dbWhN1SGNMKOn5jSNE9mk?=
 =?us-ascii?Q?iSQamseNALn8AyAePjMrsTpDiDFBb0ZJQxY9rSQ+sn6lNSfJwvmkImOcMjZT?=
 =?us-ascii?Q?FpLXrvI98zvuGuirLIehGVoeQh5Vk5+pe9vdQPU8T/ue35Z66ldE15P+JQ02?=
 =?us-ascii?Q?Fr/2HJd70ul3UoG3QIgwQaptqhfEMylOAEaI2eyjp5lIAu90A8Pdw2SScrSq?=
 =?us-ascii?Q?fVeJuSyCeT9IHl3RCypIoP395drM0+VBwx/+iYEnXb14oxV1elRm+3gan0Zo?=
 =?us-ascii?Q?2YSLGag6PqvdzQ3K7LtJXR+vCOUEbG79Iz0TkwayVKdOs3GvR1eI0WaSHROw?=
 =?us-ascii?Q?o3nER24XBxQLpsltNqw5L/JZIscxs23ZdDbb45g+4T5byAGaoC6Fq9ei5H7i?=
 =?us-ascii?Q?+9xC48RZRCC2rdXO6xj7w38LDQmS9QhD+5ZJnvhDFi318QoNS+ZVEyNlnJmf?=
 =?us-ascii?Q?7oxWQq+axgnWbDu20E6TpTq+wLFUpUX35Rrp08bgJkTNrU4vXUXuyQuREMFn?=
 =?us-ascii?Q?w4JaeYojpXLcNysldacWdvaXia19fM3lzeeuWRn8QTQD/sMA3nBQsaoEBR4E?=
 =?us-ascii?Q?12zHypbC4hAh6zK8Tnt+bMxuA5i3Kj656V8mQthykoiEZxDbFbv44Wh63jbB?=
 =?us-ascii?Q?LrTTweV0M1XhRdOWCK+lPRpPmuM1njFQ3WaM895yvw/Tj4gbkuOJqShe6hX1?=
 =?us-ascii?Q?hF+yYf6uLTxETSCA+vxY1RF8cXCDsxH02zunPZYWy7gZ1J0+P5+sYt+ZmOMF?=
 =?us-ascii?Q?Lh0ekRJc9nBDnvgOEIQ7IkAOoo+05eEo6n/yzLESAP+UZHKIv3Xy74IKpwpS?=
 =?us-ascii?Q?kiGkWRor/KHCS/VPaylv0lV7MvDfz8owvuMbWfxiZICx2B9uQjJWPIrOjLbP?=
 =?us-ascii?Q?C/XO5T8InC2EQfknZ1jbOvyNnwAaqIysq+s5LZcpo9xgOEKc1smmAvgzWfIQ?=
 =?us-ascii?Q?NpumQIZKZQ8EAK7DRDhMXGMtgPmKQaE3vKSpAeRQBt1ORy82X4yRZ+mW4HST?=
 =?us-ascii?Q?0WmS6wkq7qqpB/BOkP6rcKwQQ9YUjc1v+0ZhrgnZVHwHf0hBU9mc+WOgZu4X?=
 =?us-ascii?Q?89jTHlqto3GovrLvtZd/JZbBoY6epzXWaU8tD2u6BC/FumzrblD5BtvOcB2K?=
 =?us-ascii?Q?9aX6d1kqi/bUI+c1YZp0aaSoZiEupGQzb3ckemh13QdpKcbHoJjLxmxaUO4M?=
 =?us-ascii?Q?W+6J9X1Rur2BrubzNU=3D?=
X-Microsoft-Antispam-Message-Info: QAgvQdtgke9lvZS2tfK7vaChnOPaMdJdJ19A5AtKgw3BvOf3igvYv05fJ5LF5+4QTXCzXAAQVHdUYptDTXe2x+swfQgjIGl0uxI0nT4YaIZFtSKHLWEYf32pNddDttzutl19LiNpAgJ3E9tyIEURAWXfVGSX6r/s4oEHkbHJxndcjx7Xyo3iS4PA3kPSpoft
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;6:rCMYSp+NpEx2NWpeVibaZdSve+Ohpyvbc+vi817FRxbI4f6xNqE1fx27FGUzAph+JPn9pDgsEtSjrk9igXT3syGzhZUbjwDovekD5N8b8bi1SvZyiz9My/yTD2zwrWDu9dDauOb74rcK5woMmPh3k7Dp+ZqoJGxMcCsMHfxX5TFKmgnK6/VzzYQntA98/2vnef9bf/MRPv+d4iNV9LuBfQ6yr8heUYi4h6Z5SYAEbjQ0Npu+jbgD/VhN9B7RO9aNAirw+zpBLwqQsamLI/JhGDJtK4MnN1TfoH2Ky6aGcMyaQU8Ptlicxy4PVUgHmTM7Fw/MLqrj4pugv08XuMC6cWYjEdSNg+WDroVznxbvtwU9vJdsq910WLRV8mHZvL/piGaNbSKx1n+eWTV7EMkm+BgvN2a1XCkdPvohRybnKjh0ZPB/3XLa1PfhltH7FRYACCZblE84yHH0Mg8Tvv39Yw==;5:YGNY5EhoxRMl4zEBQftdoAZYGyCjhgEsMOMfGLA+AM4GNv205papILey3DBa5NSCs8WAFzq3HfmKyNYJXUI+hcV8TkGtG2rg/cX4sjrshKokYz9BrOnhI2Zrt9dwoWUjUgVzdTc3zZ2qSrrKdmHTQRpYCkVRJ0CC5BISn7wJHpM=;24:IthnQflDlQYhXX1XANKCb0QB51+Wy8vC++TM24ZVEPTxtGanbOO1rmaW/CtUOiS5uZRRuVR8TANgFgpFGHfm091ZKwj5VckoyLzbXv8tFW0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;7:nF/zbO78aRtRF+MHx/1nHtT9Pf+2Qmg1wSrexJOqPeOHLgmRGeaHQyM2yCUlH1HNOXB2pKqdBqSAwcXm8E3dfhXLEvtdj1OlGzLilVciM07p5feRQSYJQPm0l5krh1GMnyL3fwmRGZM7u9c+8oklznMRdcUTuz+n3rl8O+UE5KNHR/h5hO28Fy/VqKB/6ZUW6xKpSR07x8ebNLQyOhfDupPvcBA4i/G1L6DvViFDQzvfT5DaT9wW+OVQj1HmIsAC;20:APnv76UaUVDTHcee6+ZFvWY+GKI+xL2eF3ehZzdZRwcQJow/+LzFXD564x7REjXxvXx/Cufvo0XoY4OrZ2c9qrYo5Kmfs+RkWZDNJJ/7y+9kRmZYcgA6c2YK8vv0ZqwHCvf5Jv49cplQe5CCawGxi6DCbCek+dO25XGfhsvXFzeePlZPgAz0T/55zLnGM697dnM2KIcUdZckPnLgWXgXeFExYPewXJ8869AR7RZjy29M1sNHsM3ATNAXxUN92XvU
X-MS-Office365-Filtering-Correlation-Id: a46cd479-d806-41c1-172f-08d5ac889507
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:48:14.6533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46cd479-d806-41c1-172f-08d5ac889507
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation does not communicate whether it can successfully
detect CPUID Fn0x0000000B information. Therefore, modify the function
to return success or error codes. This will be used by subsequent patches.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/cpu/topology.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b0ccd48..2a5d5ed 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -193,7 +193,7 @@ extern u32 get_scattered_cpuid_leaf(unsigned int level,
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 
-extern void detect_extended_topology(struct cpuinfo_x86 *c);
+extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern void detect_ht(struct cpuinfo_x86 *c);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index b099024..81c0afb 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,7 +27,7 @@
  * exists, use it for populating initial_apicid and cpu topology
  * detection.
  */
-void detect_extended_topology(struct cpuinfo_x86 *c)
+int detect_extended_topology(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	unsigned int eax, ebx, ecx, edx, sub_index;
@@ -36,7 +36,7 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 	static bool printed;
 
 	if (c->cpuid_level < 0xb)
-		return;
+		return -1;
 
 	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 
@@ -44,7 +44,7 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 	 * check if the cpuid leaf 0xb is actually implemented.
 	 */
 	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
-		return;
+		return -1;
 
 	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
 
@@ -95,6 +95,6 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 			       c->cpu_core_id);
 		printed = 1;
 	}
-	return;
 #endif
+	return 0;
 }
-- 
2.7.4
