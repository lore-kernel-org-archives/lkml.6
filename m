Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCZGfr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:35:47 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:48357
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751730AbeCZGfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:35:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 2/4] perf/x86/amd/uncore: Fix amd_uncore_llc ID to use pre-defined cpu_llc_id
Date: Mon, 26 Mar 2018 01:35:14 -0500
Message-Id: <1522046116-22578-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) To DM2PR12MB0139.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb647e58-4280-4f18-7e63-08d592e3ca40
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:iKY7O6rxBG8ERbDApqNvb5BuzgZkSl3IotxEGI7F7RDei2YgKBchRj9ut8V0TOpxUxh90tZhzgEbc8gCyQfV2v1/XP0HbzdQPlqwdvw4HRXpboI8klTHllYve7nkmci+WdV9YuNBWiLvHPbMXn3/ug031Awy8MHIHxM/hBBuV6xRyQFyg1HqLvwcjsKnKC07jZWPgM9vsTb+DraneMmmXRK9YDdPKMCC/WmqnFoekEG4piqcG9jm0w5X8aDv3ZC6;25:tzc1g4i8QS3F2HNpEja42JN4GuQQOiHD/T6we+T1eiqfBUmmStR+lUcvwuaOEydclMXUJ70EOlnEGzZZy3lw9+X4zJOBGqMeryJHSP6SRItymZYh43/f7s6Q94lAWZpyC7uO/KoG9yE9zJMrAWW+Y4UzNxl36bgWeAjLKdZwS/x9V/Mzr3AxOd+H/NSaR0mc2WuHeakjGWO5FQF5IXPqngljK9OXyuV9V+MZTpHvL/n5ncbEZZ1i1bwoIu74JCkfqrST9AUJuEmuLOPxr15tAdwvmh60SYE6O0lP0elpk8v5xnie+2zif9zPTBcNrUCLGNnA4zy7HNU67mKOibp/8w==;31:2ObLbjbxuOlnRCS1SEPNS7VLXafPrf5ItQUQbKoI1PrpBWCRTm3YA2A5FlaEVHC4WLBAOGCCzrYeJG6oVoJEHB1+hhAkrTUigWhCZ4yb3z/wo5P4oePyvFAYlcoZRtySiu+jn2+Azeg2KleOGb7TstPl6x0nRbAqMTMQaC5H0Zz99QM83RNCvbY5TRgO83tt2B/lO5O3pQ5xtZqr2C8Pb+vS9esF8oFI5rfe77fDL3I=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:azszhgj5vZVm+EVxUBxNKBRapJac6an2p8Auz5qfvxpx0bwrgJ1/yrljcoI6b+BYMyHOftYUtoh99hhQmU39DvEDSUAdKN/JInGDx/3JRAa0P62+VnEkYoPIwEDMnjEPBjuSZdJXFgJ8Rk6j+UyP2y/Sm4/Nm0LDpsDfYV2HFgrnpBH4qGOWKkv6Xp16Kd8BxNI6YvYwAdUz8JsVAYTsFrDk5W/EhqM1m4NqOGIlcmp5Mdmt6X+jWppqNihCJawsauU+J/xr2lEriPnJ258j/ntq/7U4vhbDbxs/dbvrGWqUVIw35J+L0VczizyZd+Pq+7Km4eyQkSQ7yvvjHOPcT9ScdBfdEB/pH/i7N0pzQwRJYtCeSFc7/5S46UAGy3Y1pi/L7CmpjYnc0ykcgdIs0rnStqci6f9+pybQOPBAJDtg4xixA8aPwbPoAu8E8gptfrA/HJwR6QY/PtlCz9+8eSyts3iv7vlrhNQNuQe+sK7zcRE4MVdmoJ14Pj2Ri3tQ;4:lOg2sB9wd7pimsIqU9HihHc9+s6Iv6LYQ8B2hCYXFn+kLn02NbBfC5Avsy4Uy9cinzU6Hdv7i104g2/TeyipnaEc3MyiTHDM/NEn3NrbPkG+v3Z1wfexWkkNShjyiL48ithHfI7C9xRaaimb9NzjOEYxY7d5ZYI7GkjBdoMH+GaoI/EAQRUmUglpGJy1JAJKlb4cu37A07omOI7v9qongV/iLJYKsuca5IcqfNZE9FtPDVImdRYt1wwURv3wElb2LT0DM4X+kxdq32iEWQIfauy5WXMp5xgiDK4Hjiy9iIxWxDromOUONn6JdV+iDnlB
X-Microsoft-Antispam-PRVS: <DM2PR12MB0139F164BADAE3EC1CDA3730F3AD0@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(48376002)(76176011)(16526019)(6486002)(52116002)(316002)(186003)(47776003)(86362001)(3846002)(6116002)(54906003)(106356001)(105586002)(53936002)(53416004)(68736007)(81156014)(81166006)(11346002)(478600001)(97736004)(8936002)(446003)(72206003)(8676002)(16586007)(956004)(6666003)(25786009)(7736002)(305945005)(50226002)(50466002)(386003)(4326008)(26005)(7696005)(51416003)(36756003)(59450400001)(66066001)(2906002)(5660300001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:ZqNZgpaY9/MdFENzNfCQGe99OAt10p91TJRZSWfkP?=
 =?us-ascii?Q?TOs4KTk9HRscv9aMyylXxaeZu+n6/rmOmI/DpYg8KlciEvfGpcsq7UE07igc?=
 =?us-ascii?Q?wbjT9piEISC7dgkpFOiIwjGQLX3+7J5pckzA/HfigvKApnH4AnkMX4ccZuJK?=
 =?us-ascii?Q?veT2e9yLhFtHVFyXPyEIcNFUNB7Ib5UOGbZINjaiC/O6gaCSUqXWxKF8kFzQ?=
 =?us-ascii?Q?UZ2rpqNXtDGJC59moAbVZa49ICIslZliFBt4lyY2HlNlD7XI+k2vROkNBemR?=
 =?us-ascii?Q?+VKor2CQAYHoIObA77LLfyIlSj15Viz6Y4glZacH/bhOvH9Cc4nC1+QUEPay?=
 =?us-ascii?Q?QggVICqwkpXd9MKiPDOVb0xIFqYdVs06MnKRkdv5OlnhkwJAYazHanMdf1a0?=
 =?us-ascii?Q?BCTjNenlYmdJScSMp7AspiLiOhrF6JdPp+g1XgRI6tJw4cBF0jQaMsD7L6I9?=
 =?us-ascii?Q?T/LBt14GEzzkGrmeXKbwjSBw4CczN2GTOcdL5uc0dYtJBUAWM5/XMSDzk3e1?=
 =?us-ascii?Q?IYZdix5Bxmm++G6XuEKhvZfavy4T3QKoNmvTKGG0mleWDkqopbp5yaUx2vYQ?=
 =?us-ascii?Q?jI6j/0Jnmui8z2SdeyVE2Srnulu6zYSKWZNIJv35G2vs41XB0aDocsJ1hza0?=
 =?us-ascii?Q?08h2NtrysLxxYkCZ2G/8z7UbfZ67WdO+AQKawCJRu7AvX02HKH4bZjZZ7ztU?=
 =?us-ascii?Q?AHu7V7UpviIQiG4WCNFtXoR+jthKiyWYbPy0SetNv5OMsjsz4NHIHK8B394g?=
 =?us-ascii?Q?TTgrKijqo0cmem/gVPAOestgKA2EpIFLQg2qIjPWYJLg9oE4g1UpEopocbDv?=
 =?us-ascii?Q?fMi+FRz+gqC3+WQlQt9wo0NOAZVLjY7eh2htLUX8Dcub77y45qLRTId8XQ9G?=
 =?us-ascii?Q?6kX5/jVjA2xshMqxO57d6tJ8csju6CdWVbi67sNgFHpefgi7G792WnMISHDQ?=
 =?us-ascii?Q?cn5YGNSq2qAZZpS1LmoE5xb658ra29CD/0CDWrNFp7/BTScZ0bGT60Fasoy6?=
 =?us-ascii?Q?z6lrXKKa+MxCg0sWjtohNhcWL0VIYWRrJdgQJaD82aIiLzo+zCb9V9CNuyYi?=
 =?us-ascii?Q?PoDS0r5RMJdoKM3dYFhnW3imOrkZ1HbkrhPdIuOfI6NyLOkiHu6GsD2vMnTk?=
 =?us-ascii?Q?yuIt+A1eWdL9N3j7/FZ7+AZ8vullzuQwmgC/BNavCCXx5L+DVnYQuAzJva8U?=
 =?us-ascii?Q?eEU4WpjvSiDpuvxaMbcdCy49AI9MEbz5sut?=
X-Microsoft-Antispam-Message-Info: t5Qknmwaq/4XEedIFytUfODyIEAFYtwoRZyOy/DrmE4b0xi/w1hwDgVviw6uxYHf1M4MwGjdGwWLWBqGQ4WBmljo1fEm4OYfK9MnwNJ+lIRkKpcFZTB+QvG7+2J0VkHSPiN68zu+b8S3Eg5UHPGQKD5RduuRAzwo3N/PzZOLocraFPxtKZ2fqRFmGjKo0O4Q
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:ydVllVER9Ktkd5bcqYst6FckCVkGpVOJasLgsUocCqx8MIGp9ubdGBfkshAidgDki9DGNL+O5nJDzO0S8wJQj2Rt5UxUNsd65Y7rVt2on49VyB/PA5J+ulnl44qKPv59q7eP6WXnoJpL956YrLwaGKjt5Kg542OdW+1kSmv9qXpXbYa9zd4ev7iN0hiaM7OaerWohNLcVZyOr0eBNcvHf4um3Y8QQ1FyF+O/oDV+H2GGvqjLbyZn1mie22Cwkvsn4tC689T7eSlPTZwJ80Qi6lGQ67PtpBKC09PDIPkQ0qNT02RCUwjwxQ/t6ryiyOH8PRM97sgDffrHiTUjzYAq+K+C9LTfnEgm77ee6hitI00=;5:OCJTMm0nD6JOQQrrBrMtD1JDEN0xJSB91VSCAF6pciI0ymeIx6mjfB0BIgYb48IWd28fxqeHI2I4zFaoi6F/F0pTzknFCdw678SIzveSQIOhFqcHzp2DTINhV0PBbgLnBo2tMebOXotgdrhcHr0ku2qnAmAu1FCdibz00LZYkO4=;24:dSuS+q0h2V8su5M4/WvRnhAzVNRqZZoOqlAqnWaRJcMTHpT+TMra+ZOGvnaNqDXoRCiIJZJ5nX5WVc30QLWKGX1HPga4FGqtkowLL1c+xJc=;7:vJfUbYMRE3pn8TmHNozj8E16n4cACZ7zl228bmlCfCyMftgZyhaAgaIkFjprHgeO1vFlx0HjJYm6EvBuH59pDbKbTeqG6JO+JmBr1HjXoEo+vfq+YoiKsaakR7cMt7+8ZHShCOTdINpBrdqLvMeeI0kEhgrdTC/rTkGDI4GQ2861Khe4mAYsY62ErkOGV0QTHdMX7/4kDUf+z6DpPjLP+TSsufMoRKh29auQ/af68BPLndrp2Q5RfuGoQYtVb+e8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:HC+JOfY6NpEquTmP6gabJjA4+jvbaV2tzJoTGciKNCu8JTlGTT6cIsbsnmRkNThp97vlNmoOa1XwvlATrrrFHcdrSSwS91+snOAG/NoHDovaZ3eSWspoZAmu9AO28P9/iQ5VTwk7MG0mm1kXeAwsCxVvn40afRKm0QTqTZsNaouX7GI8iIFfC19GOV65/oneqpW9bAt1SAc4hJzBBtEegfiAawe1ddD/Qee+FJjj/EeocrmNHCgR+iyMj1z8rRFv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 06:35:38.2655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb647e58-4280-4f18-7e63-08d592e3ca40
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current logic iterates over CPUID Fn8000001d leafs (Cache Properties)
to detect the last level cache, and derive the last-level cache ID.
However, this information is already available in the cpu_llc_id.
Therefore, make use of it instead.

Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/events/amd/uncore.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index f5cbbba..981ba5e 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -19,6 +19,7 @@
 #include <asm/cpufeature.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
+#include <asm/smp.h>
 
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
@@ -399,26 +400,8 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 	}
 
 	if (amd_uncore_llc) {
-		unsigned int apicid = cpu_data(cpu).apicid;
-		unsigned int nshared, subleaf, prev_eax = 0;
-
 		uncore = *per_cpu_ptr(amd_uncore_llc, cpu);
-		/*
-		 * Iterate over Cache Topology Definition leaves until no
-		 * more cache descriptions are available.
-		 */
-		for (subleaf = 0; subleaf < 5; subleaf++) {
-			cpuid_count(0x8000001d, subleaf, &eax, &ebx, &ecx, &edx);
-
-			/* EAX[0:4] gives type of cache */
-			if (!(eax & 0x1f))
-				break;
-
-			prev_eax = eax;
-		}
-		nshared = ((prev_eax >> 14) & 0xfff) + 1;
-
-		uncore->id = apicid - (apicid % nshared);
+		uncore->id = per_cpu(cpu_llc_id, cpu);
 
 		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
-- 
2.7.4
