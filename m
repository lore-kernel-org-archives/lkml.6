Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeBZX0C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:26:02 -0500
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:10832
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751245AbeBZX0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:26:00 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH] x86/mm/sme: Disable stack protection for
 mem_encrypt_identity.c
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 26 Feb 2018 17:25:54 -0600
Message-ID: <20180226232554.14108.16881.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0006.namprd04.prod.outlook.com
 (2603:10b6:803:21::16) To MWHPR12MB1152.namprd12.prod.outlook.com
 (2603:10b6:300:e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30e85099-7172-4d76-5a60-08d57d704a88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1152;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;3:Y4LZCDMmVqgsh5NGAAT9DqfRhCwXPHavM4bsPQzhDOas63oituPxG+MZnItmM5jkYRz7vrdyidBQe0537OfvHkm4LgiZBYA40wQFaa2hCWMTkuLHT4MN0ev5ARDKgDbxq7Q6qmccYMmhiV/oLq7Ckh5LAsD+WazA4mCCvb8TMy2/3zUdsSynZiVkLEwWg9jLYW6ZkHYS1Yljtg8uM2BHb8472lUY/YQBEs8FCkv5vJTVyCjxNgBVPv3h/D4zhFb3;25:zAp4N3HpzTPQKa+HMxUcuMNPR52A1WeV1Ft2dzygGxkWefPR/C1xBNn1srfr32bFuUk/TIn2kI1UsUOs8G+QofRsHkNNY8nYMnyDFGwou4ez6Z7UhdOCfwKzjF/TgSFG6G6o/f1Ggl5vcnjISVDWhQ5ZQqVe9lH7TX2n1EUoMFOyvrfk511XgskprSkPMXPg5GO7RLeP/zLHhUOfCw66uY6kBIZdFc9JVPLScqbgxiP1Ny4feJ8llGXD91Z+foVeRYGsWpmurjMgC2SeNmkJkDbLeliAcK+3pFq4wQvx3Yoap39t+KEmf7KbDqxVB8yNklxvDto/IsXzbT/4GxyE5A==;31:syljfsiIhi3KDIeyFfwKutR5k/lL592rdGUUZG6O3YJbgdY/4DywLrr1W9SoKrMb57r6PaNggJYAFwSA7ld1G0t0NbHOMZEJRpzoPk1z9cgKS9qyDxDGvipJYvWFVe9Xq8UmpF0RbJ91Iw6SebDI57LusQo8CpCopouGVj4sU5XV96xb2FlOTnw4/5nCdAzPj4A9TAb7tl5bEb1OoT8n5csoay2Pq7rj3JxoDsM6RCM=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1152:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:C/s7yrqVUN+i+NcZvxlfOewDWEpvTQCiKLNVxWqbN87T+CEynwQ/Q6kNZ529c5/SsXcFPrHRY3om+IU9vsgumnlxfyF2082+FFpV83sByH+XOX7d0gIrogDaeekrchfDF5E81XiFRL/cZ/RhATjz+iHOuX3F/Susv3OzX+5gANF+RnJeHzlFo88eXo4/mW53O2KsbGCitYrodHotPptETO625DVacZZ9WFtPAJFSLiGlwF3/P55d2vIulrZJfHBXMfMdV7940hiPuWW28SgUB6eyd21GQaD39UHfpieTySfVg7Raju39Qd59gsR2Ltu29KyYzwW2xvO4eNHju/V7FkT2WOaUQDc/1A0e/y58Y/s74J92vXcneaPAoM3uABC8psnU1flBBWUpMJaHd+2EK8+qGVRFMe0/s29i63L33Th8C/9ZUeou5/SDB4dxq4/OftF79bGYc80dF7gdBlmmKrIE/ues4eBsoybHsViBKA25gjnZAdW026/qCAOPJgL9;4:ubwp2mGqEErhtOabpCvjqfB4rSN4IGkC5s3XvebiWYFhTiawMNCT+14jXSQvW1Sgg0oRPvmfzIX3SNSdMeGM6EBkawxYb6uHHWNGhWGo2MxJas8omXW/TBGkSlCssKcKn5n3WSIzXXqEMYnEhY+6XZUqKmlKAVfqj6zwNv7VXplF6tvs5jHnWIIHoouW99S8ubBQyCX0it6RThwDVGDpEJVuyD7ybtrpPyIsN3WcLwDk63mc5epMU0S/RtOXd/qY88GQrY7aA15/RwPHUPRWDZkrcXcMuNlg3JIcYUiCOAM5QLU+m68hMo8leK/GplBX
X-Microsoft-Antispam-PRVS: <MWHPR12MB11521724089314335C560466ECC10@MWHPR12MB1152.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR12MB1152;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1152;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(86362001)(5660300001)(68736007)(316002)(50466002)(4326008)(97746001)(1857600001)(69596002)(386003)(6506007)(3846002)(230700001)(25786009)(2906002)(1076002)(16526019)(186003)(6116002)(105586002)(26005)(6666003)(7696005)(53416004)(305945005)(55016002)(478600001)(53936002)(9686003)(47776003)(72206003)(97736004)(7736002)(8936002)(8676002)(81156014)(103116003)(2486003)(23676004)(52116002)(66066001)(54906003)(106356001)(58126008)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1152;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTUyOzIzOjdVcm96RHNEL05UUTJ1Q0dWYTZ2RXp3c1Rz?=
 =?utf-8?B?T3E4RVBkdktlOHJWcGZaelE2di9qUC9ka2k3ZG1ONzZlSTd5eDBEcGZLcmpy?=
 =?utf-8?B?R1pLVCtOU3NFODlNVkNKMktXNjM3MW1aTjRLYkNxL1JmaXFOQzVYbDB1UXh3?=
 =?utf-8?B?NUJ5L1pkZUljNDkrZjRSMFV2NDhndTVMb1ZOY05SNlh6bjFaT3lVVmZWVy9h?=
 =?utf-8?B?MUlId2hhYUljZGFHRXNQQUtGY2EzUU05MHVYZ3JYclNtUTJnbWpIdTIyR1Vs?=
 =?utf-8?B?SnFyN0d5ZUo5aGM1c3ZSNkdENjVqOW5NRjJPTnZOdGQwYitCMFZGdDBxOERs?=
 =?utf-8?B?eDlTdXdoRnNkRDVkWmZZVG85dE1LekxVM0oybHRoZWlwOHBSNzZuMXNkcGtv?=
 =?utf-8?B?UWo2YncyZTVLd3Fwa01KU3pZM1NNMFUyQ0Q4Sjc1YkFzTzNuckdGNTRyVzE0?=
 =?utf-8?B?YkFTbWVwMFUxZHIxekpIZUVDdmR4ODA2S2FpUGg0QktkWU9JOXY3bFB2YStq?=
 =?utf-8?B?UERrLzl2R0JuY1k5VWxXbzBsLzlEWGxKMG1JMktmaVJ2M3F6YVVwNWNsdUQw?=
 =?utf-8?B?MnpoWlVLNjBLZlhtUHM3YnNaT2tBOVVCcStKZ3BMRy9ZYW16cDNyVlgvNmlk?=
 =?utf-8?B?REtTbEJLNjAvejQ4YXdFOHNtMU83bEgyaWFaTmIrYzdURnVyVXo3Qy91K3FP?=
 =?utf-8?B?czZBSVVUb3F3akxPM2lMRng1eXR6bVhjT04xcmcvNlZ6QWVJblo5d1ZFSDdq?=
 =?utf-8?B?RSthOTU2RW9hOFVtdTZsR0xEYjdmaHNlRjJrNVdsRFVSSlpMaGhkcVhibW1X?=
 =?utf-8?B?NWxJc3lsNUFZbms5azVFTHlnUkFOditBdWVZQmYvQ1hRV0NSeGdRSHVqZ0ov?=
 =?utf-8?B?MS85OWZnbmlyRk44cTV4SzBidTZRVjQxQlB5c3V2Z0dKUXAwNkJHUFVvT3pB?=
 =?utf-8?B?dk9IYjJJMjQzbEl3OVJXcjJBdVE5VWxJaVNKREt6WFJMc3RnMzFyMm5FQ0NJ?=
 =?utf-8?B?NVI2VThRMkRBckhkbVhibTdOT01pS0lXM2wxTm1rc3BsaE5TT01zQ05yeDls?=
 =?utf-8?B?TSs2SEZrU0JFN1hweFVEQnM4bXpJTmJBMU90N1FURmJ6RW5NRURMUzVOVUxJ?=
 =?utf-8?B?MElDZE0wcnFhQUxzN0k3UEJRS01ZdXF2OWxHcytCcjdMUkROaG5teWhLdmQv?=
 =?utf-8?B?bTFSSVUxQ3Q1N0IxMmV4U29QNlJhUWJGZTdFRVdoSjc4QkRZWXhTK3R0b09v?=
 =?utf-8?B?SFhad1lPTyttRUhWNEdkbUk3cE9xN0pZb2x6aXorNTBtemFXVGJpL0h6OEwz?=
 =?utf-8?B?UTU4dmdBendxeWVlckZEZTdjclI3TEF4bzlyUC8wMmNZQmE4SW8yOUR2Si9X?=
 =?utf-8?B?UG9wTzdjcjUrdmlpYTJUbXFxL1E0c25rREsyR0dIMHBkZit2UndYYVdnMWpw?=
 =?utf-8?B?bTdsUCt3UjhTV0VPK05LeElORHVBUi9jbTRyNVRlODhhWi9JZGtyd0tGWldi?=
 =?utf-8?B?RmxQU0JDUEYxQjhxb0lQNjJDTUhZWlQzTEVGSmVZNXRMUDc3d0plVExkUmtw?=
 =?utf-8?B?WGZNcE9lNEthNmtleUN1RDFmYmF1cUV0N0RYc3hFL0NpdldmaDNOQkF0cjQx?=
 =?utf-8?Q?Igdv7qhQZEsPMTBMdCqq?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;6:Klh4sFVMfJ5mVyuh5TuO+wxDeffPZ6+H6zMHyT2DPJbhL8lXhvD3vllvmcHu/cZnZjPq0jDNfAnsLsV4NTwRm7jbd2N2v7fqKWXWQqan3wXB1iX2XFrlM7yCNU3UCGd0j9X1NZwtujpjmXUONpoRc6ywdHt3ysyYUC6D5QkI6RSIZvntJc6VY86WxWcfFcsWCRrC+I7RPgE1f42DV4SVDBGSjYoGe+WEGrnijBcmVaAYK8c0/57tzfI1FAaGHG6IcdbCfAHLDa5a/yRS99ryPZt3kZh/Rg+OngQCGdQHcpKYi0tiNR99BzRE9sYlCpQFum04qUXBQs7s4FcUVOn3L/evnbTUWQLiq6oa4655KhQ=;5:C43aQbUsytTLoMP4C3LVkbBRwl/MZSouBkU9f1LdOP1RmtdTOlB8JnfUUipvM7qpRX0PaqmZtlpA5qL74RqulycE2w/iuSFY7qiqjkwboZdohEE5wsiprgmYWN4mwTs8tzh8MUJZJgaqREJAgIJzZM0DsXtjXtz6Xqol0cQCbTk=;24:b8QpY6ZlSL5dTFMnNPNHTOh+EQByoxE73ZpUSYtnflZUwqcwPv6vpiRVVlb22+ZDRLJfwLzRxby4wOUPx00SdPerGsPRA9vzrQgVFbEk7ek=;7:SkyZDZRIbBcyAk39cv9kHonAVoPuyljDB87dVlU1hc+HAFRJj3++mX+ALKI0EJWOagpdxBZo6lYWn0wvvXl4eqYlcO/sJM4D7x1ztURdDI+4JV5rVaVyhDZ9qBmgUHIgRtwcTEAvKv6e8vCSNvo57Ado8T+3wv9ZQvZ/mLUsMFVnELa99YTcG7m02rTEaoz8fkU/Dii2MQ7vRiJe2Xl2Di7CCalKZ88tWvutOuM/XpTYlYPJZDteZys8PocpNb9g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:lPw+R3ZrCUpm8chCzsQbXAY+E1kc+MKzTHqy3ECFqlrFuyCUHn4GtFbpaMe3JMsLseMbdRuKUVx+7iRJRuXONN5iNX1Sxqf9zt5dmgV6DUiyOCYolByeTLPlKqPP8Ju6VrLAji3Fy1WYpuSmEGTRNjbpkuYt1LOxnUDcuEvRYIKBqFw7Y9ZCQByS8zYUWAo1LOCSBoAohp/Y1E76kZprp75mDp71TUOSW4JHUuwPFuOy2AnudkxKqgZZ/Etpy6yM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 23:25:57.6333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e85099-7172-4d76-5a60-08d57d704a88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stack protection is not compatible with early boot code.  All of the early
SME boot code is now isolated in a separate file, mem_encrypt_identity.c,
so arch/x86/mm/Makefile can be updated to turn off stack protection for
the entire file.  This eliminates the need to worry about other functions
within the file being instrumented with stack protection (as was seen
when a newer version of GCC instrumented sme_encrypt_kernel() where an
older version hadn't).  It also allows removal of the __nostackprotector
attribute from individual functions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/mm/Makefile               |    1 +
 arch/x86/mm/mem_encrypt_identity.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 03c6c85..4b101dd 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -19,6 +19,7 @@ obj-y	:=  init.o init_$(BITS).o fault.o ioremap.o extable.o pageattr.o mmap.o \
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_physaddr.o		:= $(nostackp)
 CFLAGS_setup_nx.o		:= $(nostackp)
+CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 
 CFLAGS_fault.o := -I$(src)/../include/asm/trace
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index b4139c5..1b2197d 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -266,7 +266,7 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init __nostackprotector sme_encrypt_kernel(struct boot_params *bp)
+void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -468,7 +468,7 @@ void __init __nostackprotector sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init __nostackprotector sme_enable(struct boot_params *bp)
+void __init sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
