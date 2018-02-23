Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeBWUFd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:05:33 -0500
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:12992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933487AbeBWUD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:56 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 3/8] efi: Decode IA32/X64 Processor Error Info Structure
Date: Fri, 23 Feb 2018 14:03:28 -0600
Message-Id: <20180223200333.6410-4-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR04CA0033.namprd04.prod.outlook.com (10.172.163.19) To
 BN6PR12MB1906.namprd12.prod.outlook.com (10.175.102.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2146a5d2-d75d-4341-9b1e-08d57af8904a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:DJYbCDsL5NkqWeBaYOUgMqbsQ1Tng/7aYSC+7EGFL0dgXMg+4CzIjRbTWbwECaJ3yXgtaG3NBFzuwoIqBU4zcQHtNk1e3u2sr0aWuVb8KQiy69YRQdEzhdbWaYQVJ31sY65qXRk/tw4t+i2VRnVqLXrNkaV57C0HMFGeTzIltfmiIfN+XPc6VHmVO/86PLpg41lNZkm+8Hb+ZlNv5Ed4f6eWX9bK0WlgUp4i4nM679JocgD14WNyCSIZxeNLbJ9X;25:FPmWeYbAZYMm/qYxbBxVpLw/0wbky0V9yNkH60+kQLWBZqaCpb5KZJitvkQ8Ku1voC3H3MTZ7CHWw42FMEwkKm8YNOQw/4Agnn7Ft29RWQ+MTV2njTPyxdHW48EDZeqeoa4bQLl52QTS5kisDKR5kd2acBdd3b0007Dw5b8yVIyDZ7MluyBDQUlUj+SiY9gZWs95DnmvQa4ukEIy1i+L1IlQtFTs89oRjBown2fZlsXqOCTNHW4qrF3QD2HS1f7jFgbsguSoYjcUvMMR+GAWWNIO9gOLBMCA3HP2IlXL7zPdiTVbwiOcgvy0EbHNiBpDbAa5awGDwSXRV+NCjBr0eA==;31:3oyRqrSw5tu0XWGvFXOOxjx3NOQdIV/bKvTjz8zmgiVf0tG4bRQG67oihyoswWT93s2Ns6X8Rdw24JKLqBPWVZu6gkmVGgCPnxxqEVdwaVZf7/83gDSjRVRtonzFPM9Kip91V8huApnSrru8K7InzmFg/Xjq5znVX6UdgZ5gl16OHnoH9cSlv9WGD8NJIuoREJsh0N6DzUZjeWYYeo0QIsCOsNuK39g7xHKQBD5Y7F0=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:zeqf+6TmtnQW0ZpQ527xtYyCogFvqyqq9Qjo9/sMM81jjHNGLRY6nTWqzieV6zddXdEmHClI0a8uPvaAoi8cdg8bpbTUqMHgbNY5eYZ8fi9G0xhNLEqe+MJW2V5IcFwK4YPAM+M99a+LD751kTttEV+BgcC5TV/36GUVyJyJiujbM7WCPiu7ZiEULPkN1oUR/OMZURa1e9X7UGWcO/xeSdX+JV8/GBDq0RQHHQmxhDH4afkzG78F6nQqTIu6CV5FiPzAw5Gl+MifoRiCxAozmOPGBIckRRSU3vzGFmVIeXxhMZWaRqRRxUaiDcl1zWer7xH9tiReUsF7Gd/MtI7mLJ2rkPwATDM7OMXq4IfATbPyr3CsgiMQzZ7jCsXCinBMh7fSR9NsfYx47k406yPDeanuCgICv/jT98lz1bwOSGIJHi35SJvOYlDFb23c9GDjDHhOBtwcjmDuXTmCX+xXTGQzyy/gRN88ezccZc16EtBXEKUyCNL07FkUlmOY7ZLk;4:Ulp0jcoaTd3v0K7QUZnfRWB0lAOcmCl4azbxK6n/qpPgt221lZ9Y1rWYUi7fZYZ3oieG3PxrB4E9z2xQI6FmJxWCpZrotPmGtUYriyGc8H8Kqzj7ktWoyqJf1baM9ZMPsFDTqdrL/bcHTp7DbIkKUavFYwiOlEnrZWJ4A4bkb14bBs+gyTozCbZTUBt68KiPPvOoOgcsXnEmwc4JhZ0w4Ejo5jlSyyyukPVSFua2Oi5DRdqfpGKX8RnuCBx12aKljFk8ghJ2ApWcdsmdKjayWi/TjftkVF2cMkLL0aEqoize7DSiSuu8kHJFqVXTBOEOLu5LK0mvOh630DBtm/Vj9A==
X-Microsoft-Antispam-PRVS: <BN6PR12MB19061F61658149AD68810FD4F8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(76176011)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(2950100002)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(16526019)(186003)(53936002)(50466002)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:WajlbAbyAV7UsD/NGkWcri53Tg/gPG62WgTek3X7d?=
 =?us-ascii?Q?o7yswGatolqP0BE8AgF/cxpc9ods9Hfj9JIIvbsafjbmZ+SnKr4tjM+jhTXp?=
 =?us-ascii?Q?5KVJM8/VrSj6qjWPIvTq51w+h80brDJbKcbh2aTGssTDfg/WYkxsGYHBu4QY?=
 =?us-ascii?Q?mAJbs3tuRwyEmbQozXbiT9Ql9Moua7/AHEm91X3pPFi47SpKr5xOqE8RKWej?=
 =?us-ascii?Q?PxnYJkta/hfcztNrWQkzm7tLiI5szctWe6/c4DqEbZnAHrtbmaW5lGIkQNN3?=
 =?us-ascii?Q?fMW2GqABFmIa3ZviSimtEkwQGAm/1U4odajnHC3fWtHueovoCu2phbtMzy0J?=
 =?us-ascii?Q?VKbNG2OEEVUxgAQwRvv9P4OLCAbgxQTjCIQhowq6cS7xdsIPZInF+UoP5dm1?=
 =?us-ascii?Q?rouPzCo1xLlK0E+ZcRlZ4LW1hBNx/wZE2G9xgDEkZ81NLFWGztlbYUVRiohd?=
 =?us-ascii?Q?ISZpqDWAd/JqAxSdxdamJiHrrQg3d8JBlW6+zCZR1I7GcdXcO8Rt/iRqOW3G?=
 =?us-ascii?Q?Av3jyt7R/KU99Rh4ZGSEMVijV2DtukwuJbcxpKrAyGle7Ej5YKt4JrHYXB4u?=
 =?us-ascii?Q?sgnJhQIF7X2AmUWfemhPmnuJx6NM0lxO+Ox4onjRkHfiZ4MnE2ztxDhqOyeE?=
 =?us-ascii?Q?z/lr2USKi4Vvp6aVK0pAyVICWcxwN5CYxrZd9G1rBJzR7XHOdoPXfjDnglJg?=
 =?us-ascii?Q?9Oi7q1Ya88NYKxjzu3aPZx3b+aemPQHj39+I4rxYkv4R4Kmvz8JYwIB4sEgc?=
 =?us-ascii?Q?nQcnQlbJ7EBwaZ8Nlm9u70Qu8hEPktqEwAPNwOP0pTmrPZJsEWroAA1XcDxe?=
 =?us-ascii?Q?eaFR/Bd5a7yigK7ybPmjX2XOHNqVgO5tiwg82GzgeCFPwiCGn5PGXU4JIavU?=
 =?us-ascii?Q?yvjT1DVByyN6Xuv1Ehu1Uf/225SaC11GALjeKLHd7qjJ4l12gEU7Pidkv7V2?=
 =?us-ascii?Q?EOScZqR1ta1gb+par0L7ST/9TXRfNvCyOO1vuALZIpCerDODkJMSoNyYSg7D?=
 =?us-ascii?Q?RvSI7nBmvDMni5T9Oh4Hv6dhlNr5Vv+ZIDETObljeBEjjrFi08eaP+ZgbSzn?=
 =?us-ascii?Q?N6vd4DAtI6bWOYVUYY6OJaJ8ALBavm0Slcdaok0rFLuLk7wciZRktXcRH/1j?=
 =?us-ascii?Q?nFASBSFPzsEPB4Y3cAn6PiXPu7z7Jd8IdttEEXHBpuvLTHc1KUsV8qvJi6cN?=
 =?us-ascii?Q?wD4a/wcYPDJJlY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:kDFyk0TM0T0H9gNjWQoxVsScoMybOypIcZxM/hcfPoQm6EJb9CB0JPKyPOZX36Mp1KWzL1gyAkAo8T235AKM4stPKsh/gF8TwfTIETTonHWlzBO+d7GB6xwsIuOMMrLAKXn4ysW/7Q6BmAdRhbXFIxFnrQddUk8fPUK+R7lGjUH9eea0qqw4sx3CPEjI2cr1hPSGnMXpcenTaKtb2xwCJttg1W0cIoU/wUoshm7SU5adV+g+cNmI5ePb6QW1kiNJIL79XDs5sqyR/gKWZhOVB9HIkjApAsDHEMK8EMjF8wCKKPtGQYLlBQMmhnAVEVuJp+oe/GP6aZnaa9+zewNCkEtHBGXQeATBsG0XSXh0qkw=;5:4B6QNpyrLu89xjTzST+xKwBAB1mOFhxzf2nm6+xwaUacGIuVJzSX3B6v/D+soSux0a+jkEvtF31i2tjOKM4s06zvNyZbutQysJKjo7WlnFxMu3Q6qFdrJVSX+i3HvPF3/oRVh+qEtsxoZXP3G44lOVU/rLaUXQmnVD4LWptdZNM=;24:ka1o6rUv1gvfn6Wj63SoZumEDsNAZSoSzVSu2VyxcoMmJ+kwuQD0BZ8ZS+z9zukI7ZECQdoLhASj2aGjb3AZZW6L94yQay2MIn8YLnpmQSg=;7:psXzusJXxxj48DVtHR/MwmndAC6PwXrEmQqO9kekBcuuBCdn9yMKA53PCiygMqMmu6lMrdiHHvHNKYtkOVXBVXh8YRh47eD7YZAjpm6BGcsEh524cEm79Ma6Y+ZmwlVl1V+cTMC3CTP+inWOcpu7UDtpTWlwMEE44eES3gANPRsnllbsbrYuUH9hCObqPzlhaxci9R3lo4n/QuvUO28QlRnVJCgBSGMhhSqju3pvO400ZWg/jl7eDkIkJPVaC56p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:hgNB55xeoTD9HKMY3hmbjldcmJc2WNf45/Zich5LAlq/oDT6jHVHOvlN1NlzIVj2YoVyYZV6LI20n3AmXpab2Zd4MTpItzf5qArsN/pGtdKO9Q95iKhE+fWRL9Y1Y2YUIoy+DXp9VitBQaepmIAkVfgMNWvSKK2OZYmA0pp9tvweycjwNNtIKs6ALEQOXAObf8CBLX5qbrLv+F/CeJEzYAYJx0sGv3EWKXXMdplrAr3NGKte41UkD8IpRcjIBIeT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:03:52.1267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2146a5d2-d75d-4341-9b1e-08d57af8904a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the fields in the IA32/X64 Processor Error Info Structure.

Based on UEFI 2.7 Table 256. IA32/X64 Processor Error Information
Structure.

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/firmware/efi/cper-x86.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index b50ee3cdf637..9d608f742c98 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -4,15 +4,28 @@
 
 #include <linux/cper.h>
 
+#define INDENT_SP	" "
+
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
  * This will save us a lot of line space.
  */
 #define VALID_LAPIC_ID			BIT_ULL(0)
 #define VALID_CPUID_INFO		BIT_ULL(1)
+#define VALID_PROC_ERR_INFO_NUM(bits)	((bits & GENMASK_ULL(7, 2)) >> 2)
+
+#define INFO_VALID_CHECK_INFO		BIT_ULL(0)
+#define INFO_VALID_TARGET_ID		BIT_ULL(1)
+#define INFO_VALID_REQUESTOR_ID		BIT_ULL(2)
+#define INFO_VALID_RESPONDER_ID		BIT_ULL(3)
+#define INFO_VALID_IP			BIT_ULL(4)
 
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
+	int i;
+	struct cper_ia_err_info *err_info;
+	char newpfx[64];
+
 	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
 
 	if (proc->validation_bits & VALID_LAPIC_ID)
@@ -23,4 +36,44 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
 			       sizeof(proc->cpuid), 0);
 	}
+
+	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
+
+	err_info = (struct cper_ia_err_info *)(proc + 1);
+	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
+		printk("%sError Information Structure %d:\n", pfx, i);
+
+		printk("%sError Structure Type: %pUl\n", newpfx,
+			 &err_info->err_type);
+
+		printk("%sValidation Bits: 0x%016llx\n",
+			 newpfx, err_info->validation_bits);
+
+		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
+			printk("%sCheck Information: 0x%016llx\n", newpfx,
+				 err_info->check_info);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
+			printk("%sTarget Identifier: 0x%016llx\n",
+				 newpfx, err_info->target_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_REQUESTOR_ID) {
+			printk("%sRequestor Identifier: 0x%016llx\n",
+				 newpfx, err_info->requestor_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_RESPONDER_ID) {
+			printk("%sResponder Identifier: 0x%016llx\n",
+				 newpfx, err_info->responder_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_IP) {
+			printk("%sInstruction Pointer: 0x%016llx\n",
+				 newpfx, err_info->ip);
+		}
+
+		err_info++;
+	}
 }
-- 
2.14.1
