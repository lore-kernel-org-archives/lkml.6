Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeDDGqG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:46:06 -0400
Received: from mail-sn1nam01on0077.outbound.protection.outlook.com ([104.47.32.77]:10368
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751241AbeDDGp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:45:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        rientjes@google.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 1/2] x86/CPU: Modify detect_extended_topology() to return result
Date: Wed,  4 Apr 2018 01:45:13 -0500
Message-Id: <1522824314-25345-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522824314-25345-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1522824314-25345-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:404:4b::15) To CY1PR12MB0134.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38f1332c-fdd8-4b78-2671-08d599f7a617
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0134;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;3:8SoAXFPs4DiuGctvrpzB5VEfICecnDiyg3edX/JCyd29YHVDqfPGUHdf/vVqTp79jz4/kqXyunGkWtdsrvCSCsibT1t4LXVUkh9RUBmcJ1qfDSQgyocZmJjB3rMX5AAUJUXHwdGm/h5W1WTpm48hcywrP6mUgUhKc/MLRL0+LRzva09pCV6b+3SlWTIwakWU1swyfEZKfZV6bdJ1hWRfr2Y2aW6LHHliU9Tp3ecTHpyHUzH/k3rV0kb+uf0HowHZ;25:YGI0fg3bIyKwy6tw2oLDenpCqaxm881zkVpzE4omL56dlSDqB+sUslzzcfU7KSMnNb5h1mg09yuc5flsFEotrAXOB/Vy+ORZyeWNyNZcOjHAwnBmFiaETNMGFRLOPjtH+5ehoSjEL+yhwrOSrILfu8cLgW+6fCAuVFMW+H20lSFGtpTTlykPkm7HP+WsTowlUwG6gIpSEssq6LgTpyQo2h7cEjrZOoznt49AB0ImM6qjVm8D65BOtKk/azoTIdaZO4L52CPbVGnfquEHdnve0I66upn3EqiaTuQAZG+AJKfhJFGlBhWOvxKn26IFuk3q6eSzJShqOY8OHmg+hVoIEQ==;31:Ncs3PbJ/cmafApDKLC7WBmNxLeu9VEySqY2dEt0aLE05SbWcUpUEsoEKVdofJ3rL8RpdwDz5YdoUUX2bP3SGeWCrpQXEbjz6ISo0O8EW561jpfjfpdgv84ygXD3NlTTRTEh78+Gp+Dah2CJNx3oZep38PfFHUan65raH7csQothFKN/GeLuyUKKXz7hiZ7Q6+hS/i57ymI6y+ZeH7UPwnYHHauqMBgPqoII0aCOxKpk=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0134:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;20:3J1D1kxToOz9BpmAA6R/2m36QYvkhuUqovyU9s3n45ReYZGrHo8628xqYTtdigwmEuEFOt/0m4A3ZJKbb0Kb109+QqTniACsomCzmMR3hWNpwHUY75oCZ8AkQedFNvM2Zpmar5K0Xfz/E57wClOoJJQ51TyREZnAjnJWKm6PeXWYeI/m27rd/sR8P/Lc3Wa5f8tiUkgZZK7snyeOmUcH5MCDaPMByESz0aeBk/El5Do1f9Mml+5IrS0gVxCmaq4FH6bHMGNjEYU8cuxp5wlfTqu09qusOS0He56RvxtsPkftgFKY3wsuzjnhYl4hK99I123HmNAQBcWPBSdqDZ+Tg9twtb+BeztyFwqkBjkEq04bYCn79DzVHm6DVcXGN6C5EFqVoHfSM2l7+88oAbZN1iSxD0EKzHYztR17jH+XV9EUkC8YbbMFRc3pG0WyQ9h9/iIjSqrzBE4iPOdu46peMat13SUJF0Ej/Vk1kKMtzwyopD5Lw0v8Ut4wnhYJ087V;4:GM1cfX7Uw/KHET+kpsHmoiXYnqJAeow/A4n50BW8dQ5bhh/VMwZNYRO9c2PTiXfROAsDgpkfp7hBpmOpeypVxuVCJAF+VD7Fa7m73FRebwunJf6lwZtn1JZQWdqu5y0xiEWFo8S8ghr1Xbzckc7j1JLG3DrS5AiW4BhzrwNFxgChCEicOoeyla5mRHzesP8E1KYk3CjnWVCQvssewZaFxh7Gul+coU3WOGKNbs8KbaVGOSj+LHe79yJZ8oTRjdp7fnbECgUf/D5EuD/CHHa/7zGnbSjJKuOTqzv8n6E1LCymcERzAqRGMiIYI2OpSLMs
X-Microsoft-Antispam-PRVS: <CY1PR12MB0134EC751D8D707ACE286245F3A40@CY1PR12MB0134.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0134;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(47776003)(16526019)(66066001)(52116002)(386003)(59450400001)(186003)(316002)(16586007)(6666003)(7736002)(68736007)(486006)(51416003)(76176011)(2906002)(7696005)(305945005)(4326008)(25786009)(476003)(3846002)(53936002)(36756003)(81156014)(8676002)(6116002)(106356001)(575784001)(8936002)(26005)(86362001)(446003)(81166006)(5660300001)(478600001)(105586002)(97736004)(50466002)(50226002)(72206003)(53416004)(11346002)(2616005)(6486002)(48376002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0134;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0134;23:khgAblHvkLRRdULJXUXTgzuJw4lRKOcXj6rnPXJty?=
 =?us-ascii?Q?qcrFfJffXm2QVUxo6ExL14c+VH8M7puFVyQOz4j7wBaMC529HKzWvowICY0l?=
 =?us-ascii?Q?N9xTDXvQZRLdwslfuoir9Oj/OWyv+fQVQ0LhFn319/u61wNTIhP9BDDzZrZh?=
 =?us-ascii?Q?0xZdb+LwODOTpizFgdSTMe4zNm28bfDHe+Jc9uV9J3IJnzIoZLyM7t2C7XQF?=
 =?us-ascii?Q?QaZibll6KZDqQsFWCkHr8sVXcaONDsom+9PJPN+42jDQ9alMfkYkbkHZm77E?=
 =?us-ascii?Q?2w8E4vApPux0rVG2+xxybyjZgfm6frll4cFS1v7QSYkL/9T86UD3TcZW3YD+?=
 =?us-ascii?Q?ZssPrG09vB9to5VRgfIaAjsofvX97RM6AVSZtjjlGtTrz0eb7m1triW14Bk7?=
 =?us-ascii?Q?iNDwuKzFKOhNiDFFlR4jnHl7eJn01xZ6nJmIjd8juhSn4yy3blZ+Qmkeyo4W?=
 =?us-ascii?Q?iCAyeV1YwFz1KFht0bC3Bf4M0KG+NyxFZEo+pVWp+u5FSS0Aerws+RcRn+3e?=
 =?us-ascii?Q?ct45oVhWnM2TMKeruqUbtsioU5a9e+l46xadmw9pIzywKGFN+chEaFTxMGms?=
 =?us-ascii?Q?vlPH3hPdniAEqemxfwqHfoqKhoOIGWQvEuEaoRBltgEFwQT1RF/gBPhWLrRw?=
 =?us-ascii?Q?+u9nEwfaJJ7KjmCBm7S4utOVdFa6aOlh1CcAt+ESzkUPg8rCZzq9BMQEptn1?=
 =?us-ascii?Q?f5FrLynPlq6RohESNV7+MuPj8k3IW3tJlXFJyyTYp/3whMhOqcZeQ9144eH+?=
 =?us-ascii?Q?8U0UuoZSFWXqZJ4BJBcaZ93xO9O5ohVklgja5kKhquVT7k3CHmMee11VL489?=
 =?us-ascii?Q?ZZPNEtysI5UDN3FH7sTkTwrt4v8vKi0/RXx3ToGNk1n1PWGCt4jRdhEpCTq8?=
 =?us-ascii?Q?2gpNr7NDv5cS7YEnTclrJYKEEStvcYoXpIan9u5r9lb8PTZlmFCT0r1OSeCu?=
 =?us-ascii?Q?x94RyUvWUBdYm+ZG2hehf1rQZEHRUMTlHCivkubq8pwRIgHw3CgJzJ3ANIin?=
 =?us-ascii?Q?JNBJLDAt4rB2wbptbDa6qiRTknl0OoragjXH2Vlpw+pal5HXkgV/0PC4tz+h?=
 =?us-ascii?Q?FtdS+MzbASB9U5P4CxpdjanbjFHwHe3ZUc9Crb6qOvhD0Aag66ubkf7XirQ7?=
 =?us-ascii?Q?glszQFm2dAkeinYNFwe85LMYWQSCfnx8bd9GWhey+8mr9CVSyyROODlul01k?=
 =?us-ascii?Q?0fBCEJ6S/IdphKpqS+hyozRJXX4j6U2pHS2jMQq3Y4ETD+cWkASqmul8A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: q9Tkg2OHZ6fY9J6mrVNJ41YN84iUz+kSn1dzGN4QcucniprnLqKtnLWz1b9fikfkwkMFdg0PdhfRhiu1gmTSfOakGGKNpb8LsI/XjvvimZ5z8+Mb7RWMKLoJOVehvKQJxDf+ACqjoTXZj/PdhIXluUQsISgcKToMzSs0yYkkwyQriWsfMaxL+X96VjxDjBqJ
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;6:/hqAHuJvuh+v9684JugYP49co3xk+hOgw/zk9yVZcIHwDzj6wSa9APGGAtlCuthdsgDLNRk7uIy70m+3glSXqdWz/VCyOzA6yCXlXiBbE2+OHAH9jXQNH/9C207yu1ChCVxKx0rRDUseiVl0X5cwruMrT4OA5gBg14oBNH+I0Wtj/2IlLtCHYf8UNvPpzi12UFvNDBYyKbdSsU+0cDZ6bbmvC/vh/qlgDqTG8x9AsgGjBZdbytY16sSAW1pKq8RnnaNTnZN01zLrRg2Fe3GplrFpeEjkK10X+CBlKEtmWu7TXz+TQLAiTWFXNQ93+CCqF1WVENxORJxsC8hghXCLkhGcLUjFVCNnMJUWbLY8PTIlc/dTMosguiqhF3duq1t4vhwnKRHllmvmJAJsixasdWc+UbSkhi5ovzcRHmSAKD5MU6vdNjTB07/oCKImyga+5PRSSHQehIcHgW8qC6puhg==;5:ul0WYHCJ0qpmVdsY7Mymv3ZN7o7HfVovNvRGcj4UTYGfl2tqoc+AO2r2uS3yYa1h/eVaCR+vOGdyAY8ZJLwMdJHZ0jD5ypARPvuAshV3jtEky6+hPxa7EubpbJMYdHo486mvpZM80fY2UqVBvnLeLB0k6QaQ9d4vHVusjZUBIMo=;24:lzoIHMP7q5GVOsLFPXxtrTObgWUdsC7JWs8CbYM6na/qfrMSpHXG4EmMyXCoFZy2pmIM8hQLEC9bxXfOFRRuHbhxwe6n45fsTI6AO0FyFcY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;7:Z/ZkPbdS9khodAM3xqXxZEydQ2IGPx7ddp6G+3uE+pQrBXobT1agDN47+x8wDI4o9LzeEMiv9MxMTQIPwSmx4XY1zhhItFMIZq7QoWZDfTVmlWwOL9SoE+BM7k9dpEET/Umu4tDmZjA3EoeWCux/cZbZNaz8/wCTuT4+77bAlJzV4YCviavEI4JnVx9eM1DNUuWY2U9JD8VJJkjfYV4dfUuutYt3kR+HCI8Vvbn6kMWkEn+OqGJ+AEFh4EndU14q;20:rjHk+9OQsz8B6hVi2VSiVq1xIB8LrDLviDB5i0u44Pk3ZDrRDgeYKiQvRMpp12VEoVZMTKNwQa7EhV9xtPzYo+fXYztDJlgDw8MntQ3UXeAK+3Lv5mKagPv0vSkUfH2q6MbLnJyhzbeNPXaecb5MhoxHFa20dP1xiAm3hstL0Xk8FpFio5dMbKadJjaz8kGUAbtOWySgC+7oLQtl4PgEIVrchJiJ/FPqtivkC2ECAJkbp5nP4JBg62S+n4kf3XkY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 06:45:25.4831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f1332c-fdd8-4b78-2671-08d599f7a617
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0134
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
