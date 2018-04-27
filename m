Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759436AbeD0VgJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:36:09 -0400
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:62624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759221AbeD0VfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:35:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Borislav Petkov <bpetkov@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 1/4] x86/CPU/AMD: Remove unnecessary check for CONFIG_SMP
Date: Fri, 27 Apr 2018 16:34:34 -0500
Message-Id: <1524864877-111962-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:300:ad::16) To SN1PR12MB0141.namprd12.prod.outlook.com
 (2a01:111:e400:5144::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0141;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;3:yV9cGqoYOXP7V0qdw88S8TZig4VjBDv4OaQIZea7IbAjl1Ew/0ET82ruqc9/yCFjx7PpJtYAWUu45PB83zxsY0jtydPUa7Jn4IxtKwy6bsNgCeGTPH+bWWSzsVjnz0LPQlE9+fLP7fWi671J3TP0ppAVGH+jjdRETUgCTFcQEor5HPEW8NhL5/fI9VsROnON2lyO7GqrT1TVBiO771/gL/8ylJkntJEiagQCvDKKIGQfc3VzCRnfYkqdSpLYVDn6;25:YVn1mK3jD6b6oMFazbDBIpeULFTiTu5oNI0Ipc8Jp0YMM0XYfUfkzkfbhosKCkTIqoHxZKMeRqghvYxDYjsuktYH35TahfXtasIT/QXGn2BoFNbaAbGR2ZpOuXERL0qb9K2N4CxmykjOs2LKDsqh0oW1DlYozzuYnxPbPte1m2jg95q8efrJ4EvHwTpL/l/6KWx9UYRo8d32dREFmgFE5J5onkuPuVymfsrLKnOHulpI/Rzem5uq6aaaGok4BMpjSMKw++y6dLK++SgilIGks3j+L6XDWAaYWr4e23brGWJMdykr0BqNlCTm2bN5l0d2IbEFhTApQ7g1DnyC+dgWiQ==;31:tque38rTeQhuR1H3yZHoqrgTn1XPVYlYUto3K/BhoZQtUSRNHqB8WXfonLdIr27nwKrsddXiNVasd4iNwZzFMQzWTv5XxP5sv4ENH0EmDjVGQbjpDKPYhOWH8XAFX4K++oYqFPy0HafWYURBProt5LJ8GslP1RR9lKpicBknbrBTpilqb6wDV26kcgVF/Ua5XFyDO2hMSqI9x8SJoMBU1nyrCtGecjoxH1ltBrVl1Zc=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0141:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;20:SQp+Nz6dhF0YfDmTq5emNuzUNNhZ/Ih72M5BzGbRR+1+MXA+IvIePMS/41cwz8XpzQzYW9rwm7lGFOtZ/APPaeBzoOvEuPyQKlzxU65n0PfZlDDo3iAwblLXWPJevN+6XKJPJ0ddlRaRMCUDvvmAIcQhiN6PnC2RZC6ewn5qG24KN9weVTA1rbb9K+GayoYLn7JLb3YZYLRKcMf2BWNvRIS8R8r+8DRniiADA8TB7yHbkWLFXWQpupIoXE+JnNS8Y/n7zw7XouMJXpikpUc+0xtMcfa+by9bruCGxtdcF4lkeKdUsvLkn6b+yLJHE3JR3UwPk7xUq+qielL7MKhahEt5x5XDFHFiXk+C5m1Yrzt4Bw563EvJJOzTeNVe6Y5aPpd9nY1rhCV0Cj7ymuZhRdxs61ZmO5EKT2iMJsx7BplFbVhvLuBqSbTCbAmEx9ccajGYGULfEE27+nM6f+fJIPemX6IBpQ6DJQyl3fP2Hri1wZ0PqS8KwKqegr4aAvr9;4:L3LfeBfdQROAvItv8lAK1B8hxT/7Kcb93VKVLw+TZyXdw6HUHAcs1slhyIN4wLyvUxh5/Bo6X8bygJsKrOWmthvtCTHHeaZtqTmnzVJl8FWXQ/uXp9fDiMIBJXEohQTYMweOKwr1qNSnySiyt1BJ60tsdd4Y2P1ntpCw9cxanTZk9qdd6AklB6X+q+hRCnAOfLT/0/9RAhy0ypRX/IV3oMONVjuQKdfE2zGhd7l3x4b3z7lMJXthFJoWcgb7UvksjPfHND6/BD4WyZGxvefPUaf8XkbESk6xF4vyysQatvMZQpIceH4neBdVNyBTZ2Ui
X-Microsoft-Antispam-PRVS: <SN1PR12MB0141A67BE32419C6653E8A78F38D0@SN1PR12MB0141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0141;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0141;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(478600001)(956004)(72206003)(446003)(44832011)(2616005)(486006)(11346002)(59450400001)(6666003)(76176011)(97736004)(2906002)(52116002)(50466002)(26005)(3846002)(6116002)(51416003)(7696005)(53936002)(476003)(48376002)(6486002)(186003)(50226002)(68736007)(81156014)(105586002)(86362001)(66066001)(305945005)(16526019)(316002)(81166006)(54906003)(7736002)(53416004)(386003)(5660300001)(575784001)(8676002)(16586007)(4326008)(25786009)(106356001)(8936002)(36756003)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0141;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0141;23:lBvPf3wfh9CQ4AFtYpPo2H2n9SpBH4f2vRtK1/SfQ?=
 =?us-ascii?Q?F/fEk/4cmjwjO4yTvcY+vSbuO5kQ74Ur9gXsKuvnWa0IEDuEUITRgq6J5MhU?=
 =?us-ascii?Q?yrxxdKoCwFb5TNCTP8wtlKD+i6dza1mTBp0eYFlpS5c2A3xyr9n6+MVvk//5?=
 =?us-ascii?Q?sEdiCeSW51+Q3YsKDbePn2uJZcCAm0kXjC9xG792BrrhU4CD6wQ4vYwrvVZd?=
 =?us-ascii?Q?phWNUPLIk6vHN3b5IYni80DbFmiLu2da24wLeVfZeOk8JJPnCsnBlLqvIRx9?=
 =?us-ascii?Q?iyexpkU6vz+hLtwpxANOjO/3CUzo0+P8NhofY9cudXJVPUv0yDfhvEYtRaFY?=
 =?us-ascii?Q?BO6RhP2dvUmh7rMxgo1m2tyPxLFV6fImRNh1Avb2ZiaJfMIf1q2xqIEUwK/z?=
 =?us-ascii?Q?0cgaI2y+M6cJ8x109UqVtV+GoCD5885CLbz4DvYd8FYJysL6PyaSu3VRGKF/?=
 =?us-ascii?Q?PG79LIqEWBvoMC2mGdDwWT1rupNQR2IB5rrigMqWSHvQVkp63/vp648ivB2h?=
 =?us-ascii?Q?z0eBck1REHS6wIVSbDOKHRq44qT1B9xh3L3n/xpGrCqPiM0d/Z9ZVcmdhuQy?=
 =?us-ascii?Q?S5kgNLxj2opsoNZ9qXFwuRmMTAFie+2/UAuQVGBPQVxaCSl+kwhiyy956mZ8?=
 =?us-ascii?Q?ZJQS/5dBVmUOE4KK2ovb2dsIxOGOcIbNB5DpOk5NaF2qbuLARh0DOSqJeYdd?=
 =?us-ascii?Q?/tvJTE03/7n0nplSAmEVuD+e+8x4kohAYW6gr/Pe2+nvbv44+EWjsFoR+pcK?=
 =?us-ascii?Q?Ol4v+k4Svh7mtRJB2TfWyjjTz2ZJQRlYVAwUETZsI0GblR/dmUXkajOTZn2E?=
 =?us-ascii?Q?70osv7UxbcdypC3SssRQlSPMz9dlhj68MHbDGfjdo4weIVf01sKgAl2/HDhV?=
 =?us-ascii?Q?krDaPXm6Zu2pEZX14pKCSwJr+vwo5rcpB+L2VWYGzf6dHXoK4WZE1VVSSGXj?=
 =?us-ascii?Q?wkWbpNM5r/43P+/MJDM4mIWgCGeekq9v+TygDw8schdN88MI8PRVPka0E2jb?=
 =?us-ascii?Q?SMMP7H4d93i4prlddvDZ/nJndRvx7v1lm1/xBq/3iNCg9bFfaJSnVp+VTXEg?=
 =?us-ascii?Q?uPGkuEH1P7aCHwyCL8jWolSAyhxHXBRr6CqFHOGGVPBMDjPdzVpeKrmVo9Ul?=
 =?us-ascii?Q?L+iwxvm/JNaZevf+41EfzX1+IgxNU0bsBTeximTSNaqnOM7I/wUU4XeuVO6i?=
 =?us-ascii?Q?fTdc9ejLLu8xCo/MdwMjeDD/x8JuOirCfCfMzvVkUJcR1n94lDVUGBJilHIh?=
 =?us-ascii?Q?cLaNvDg6AYYX7Wt9iK7K2lb7TfO9L/JM+D/kb3+?=
X-Microsoft-Antispam-Message-Info: uZ3nrDAP9xz7xhjtnp2I2kjcMQ6SXvNqyyxntSgnbOu/HnKjPS1Qq/MKKhN8s0ugGINHFvbPl+ugFfP+ooX/TJAvenHa8UGzj1EA+tWrM9Ixz/5x/c6IwoTCFvPCV+asJnJO8uM3xjROVRBAwGOArqgvr4dcdy5r8YlXSshK4a4xJ6Btaz8XrbqUY9rA0hTI
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;6:8oYG1KpLktlux3ujXCFkY/sCalaOf5PYFW+vF+ezrG17jk0v1miC5w2kuJu+0aEkFL9HpH1zaDGoe61veARw6D71daUGzoZEV//QzPzUqJmqD45depNUdhrpgZr+WoT/J8JdSUKHQCgdOYcbeqs2f/kW2p1xOw4DA6TvtH0vGEj1g00D1+bPDhxJxEvFjOg5J/frZIJig/4Te1afRh/x53xaycvTtjQLwaS2i9jdf7VMVXXxKwCRHhxqIw6Zy3E4pDsHpbNEDTQFxjyK/aSW9Rug161rsq60XaCicvYLy2PuMv3Ij1u/VCyzoBntoIVAa88alVLygySJEm5uxfO2tOCVjkzHWrPeWWvhwCoLX2KHC8o1eb58l6Baoz8TLyP7rFUezpcIpNPoTHII39yuwj43kJdLbLdWRXjOr6stKmQNwIm7TRRH1//5gX9D4QGfDFEIy+GTau9zSfo96DiS8Q==;5:GsZGaODd4Rzkj2AWbWVZQGkCkdcJOYGT7aHTJNwW7bV8SQUUCvlXzT48qWUXxwO7B7eeIQKN1Y55IFhS9Nt+eT5LvkO6dRLv8NbB9vXGsbPpNhwv0q/6qIp0PeD8fGEkYBJiv9J4kMLJfLcxoKypoNlfp+92JkaYQDblQW8MbVg=;24:K/VaAdyM2qgpNBShC6IzVQyH+f88/pGY3eYN6QlIM672ygd87kwyR3RU5FIKYY30M9mpnEn/x+8Hn+ez92I/ROKwztYyAW1bumEkP79YFwY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;7:GukxCe+LTZPJlGKY/qsvItf3i+pfFEI4RoD5cUtPjGadwbvhzjYSBdjxcL3xzZtPOvFhXsEeWuOdeOYvq5kHOI47fwOK3udUrybE3Usr2kOiMQpljzZfwlWSTmXeA8Jpwpc/yIvkH3/Z7j/DZoKUTh/vybjZu+4Ky9Ta8NPAI3OwuHkF9gzNw/y1Hm3WXfAsH8U2/LMemxPv4VoLArYo0lJznwb0A9Id3+Km0KueU65F29XvSCukmVH0R4AKzbaE;20:bTeDutwKBQlmO0pJSun9hGXypKX4h4DbuxmnrNXmwSZ4hZY2btyt3Jy+DLF3stSSMqupyeUcAUIXA9tGJnIIE/x3UqlVKzyMN/fCH7go/WvSNA7Ni+QNpMuv0xpmPBFAfpYs54IiWotnNjXUd12zPLm0Jwq2LsMiuFp7++hVRwRODwNw1WwaoPSPIQSio17gu34WBarT4h/un0zYna5kXaaqw5gcqvPLzLA3bE0rWguaPsjhAUXEtscVIW9nNZ70
X-MS-Office365-Filtering-Correlation-Id: 7ba07f3d-4ca5-46fd-f250-08d5ac86bb2e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:34:59.6460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba07f3d-4ca5-46fd-f250-08d5ac86bb2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bpetkov@suse.de>

Move smp_num_siblings and cpu_llc_id to cpu/common.c so that they're
always present as symbols and not only in the CONFIG_SMP case. Then,
other code using them doesn't need ugly ifdeffery anymore.

Signed-off-by: Borislav Petkov <bpetkov@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/smp.h   | 1 -
 arch/x86/kernel/cpu/amd.c    | 6 ------
 arch/x86/kernel/cpu/common.c | 7 +++++++
 arch/x86/kernel/smpboot.c    | 7 -------
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index a418976..59a01f6 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -171,7 +171,6 @@ static inline int wbinvd_on_all_cpus(void)
 	wbinvd();
 	return 0;
 }
-#define smp_num_siblings	1
 #endif /* CONFIG_SMP */
 
 extern unsigned disabled_cpus;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f0e6456..922f43c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -297,7 +297,6 @@ static int nearby_node(int apicid)
 }
 #endif
 
-#ifdef CONFIG_SMP
 /*
  * Fix up cpu_core_id for pre-F17h systems to be in the
  * [0 .. cores_per_node - 1] range. Not really needed but
@@ -375,7 +374,6 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		legacy_fixup_core_id(c);
 	}
 }
-#endif
 
 /*
  * On a AMD dual core setup the lower bits of the APIC id distinguish the cores.
@@ -383,7 +381,6 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
  */
 static void amd_detect_cmp(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_SMP
 	unsigned bits;
 	int cpu = smp_processor_id();
 
@@ -395,15 +392,12 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
 	amd_get_topology(c);
-#endif
 }
 
 u16 amd_get_nb_id(int cpu)
 {
 	u16 id = 0;
-#ifdef CONFIG_SMP
 	id = per_cpu(cpu_llc_id, cpu);
-#endif
 	return id;
 }
 EXPORT_SYMBOL_GPL(amd_get_nb_id);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 348cf48..2afd854 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -66,6 +66,13 @@ cpumask_var_t cpu_callin_mask;
 /* representing cpus for which sibling maps can be computed */
 cpumask_var_t cpu_sibling_setup_mask;
 
+/* Number of siblings per CPU package */
+int smp_num_siblings = 1;
+EXPORT_SYMBOL(smp_num_siblings);
+
+/* Last level cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b..91d48f3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -78,13 +78,6 @@
 #include <asm/misc.h>
 #include <asm/qspinlock.h>
 
-/* Number of siblings per CPU package */
-int smp_num_siblings = 1;
-EXPORT_SYMBOL(smp_num_siblings);
-
-/* Last level cache ID of each logical CPU */
-DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
-
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
-- 
2.7.4
