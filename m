Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbeA3RdW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:33:22 -0500
Received: from mail-sn1nam02on0071.outbound.protection.outlook.com ([104.47.36.71]:21856
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752518AbeA3RdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:33:02 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, Len Brown <len.brown@intel.com>,
        Kyle Huey <me@kylehuey.com>, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v4 3/3] x86/kvm: Expose AMD Core Perf Extension flag to guests
Date: Tue, 30 Jan 2018 11:32:43 -0600
Message-Id: <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
References: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR10CA0015.namprd10.prod.outlook.com (10.172.33.25) To
 BN6PR12MB1362.namprd12.prod.outlook.com (10.168.228.20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 467758a9-8df7-432f-d54b-08d568078159
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1362;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;3:GEC702txW1zK3gVjeLQ+jN2S5vEo3et7yT4OK3t3cx32bHQdGw6Gcb7rY8T8f5g5hNIy5b61KZ2a3EewS1Y1XtIwSeWza5ufnzYrnJUkokHFh7dKq+/9pMrZDiweqOxgcMs5JiyHN49E9TgOfk376pieydsfE7xmNz/jllrQM4/5QVgX8/ZwJNaG998SEuPJ1AYnRylLEVLxAaI7sXRvPv05UhN0WsTOH2MzOYwAXXH5DJxkotgellitSbf8GH0s;25:L3cvT/GcS3mxgU1M80oYhOCIXmQNvAJCkstEcPbNOZt2pGpW3HFp74vxP+ivrTQRtJv0XasG6IOgDGE7hRzw1bn+Ytho1x8Ac2ymK1qoesrYPgsBxmFj3K6JE/2C17X5kfr8r3gI9AzW/8iGOko/7FwL3YOkBJxcTuU9is+uIESWwUcO8U3XsyxL75dgstoFlKXvyM6/Zm7y9j95KYcANjc3LuKH4FKcnLmM/daxTEIYDuDMGnJgzpzNoeQQldfJO3W3N2VPr3YFInsjCe17uhwYI6wl3B+OM0rkXn44z9OeLz0dZlw/5LPwSQK/0OMkyZx6tyEZQNAvZbkJgBZrcg==;31:v8RCxy1FdHYvGs/ZlypT01tGL9hLmmXTuYckItQfo1JeEJOfVLwGQuiMRBvTcsCXoFTcbrTPpAnb+4CS6d+dsGWQ3qa+tkTMQlC69CnVm5fZIquYLRb2F/Gc/H16F/adNNe2omUtFpvfai4FYNKat93eN+5/CJScm0G393IiqJ83qSL9X9kQKpyGHv3X8+d6IW0JlwqDhmBqB2wrVL3WGGanH9uWWFPuDVy+vmKwp9I=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;20:5U+farNNOxP/0EKa0MY0fpRhcFuPDHobdMGz0djuZcT/KmUDGQOcIc5dNMk6AL42aYCDkG1IBFqmpUJaAPNivB0FvbuyD8AnCgYpv6aCg1w0YJ6E0cFwwacVpTm3L17aiCdLGzsaG/H1PYXYeqtN36egjSYzvJ/ekyNPdxtlexrej3iDTsimigy490siseRRbfPj070RGVmsff2skoG1VKeWt1l75QvXfssCQ/5kcnx7lNW8NFFB8NTbd3r8TaahvhXFpRkLDXZYIfEnTRbBNi2y41YpPOtyq3ikPwIJvX3iTE+jT99DiAAy9LlUl2SZ5vXLuCE9I4vM6gJPghpBXY3ozJC1BFAW+N0wW4rh3XoEoRKwmszO3g4X9w+vxQ3rsz/Zk0Q9JRZhIbrWYUp7vYua1/YbVMdt1wNTPkP871srikXZYzuYxnIs7fby3UzAQZNzgbw7jjL8UQog031OIeVjZVDRntpJucugiP3ozc94wp3y2fJ6z8mf7BGm4kwM;4:QcnP3FZt45gOjdyIXYatXiv5oIcdzjHXtMJn8UoQAlnhntCbBv1F3IG3BKIVOSRt4Jsn/HfVfLFyrso+yzxqIVC6RZ7qZJN0SCuKLNU5xO+1mXETeQ+DCwICc6ecXFUHptm4KCPGeaTmLz+FHR0BkrHJw8tFYqaAs5QGKwUhJdTjH6PQ/iSSXG/Hns5KiwkuVtoD3gKok+P+PNzczI5UR11rA7mUTNOlKIpqgqjPQEQtyeYPlok/Y7I8Jtktw2bqVwOqTanpHAXUqAOrFZ5xld/E0XgbA7FKrf7VmWOcR/EVpq2oRvdDRSWqE14mJTJJ
X-Microsoft-Antispam-PRVS: <BN6PR12MB136227E85F353596C9048D65E7E40@BN6PR12MB1362.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1362;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1362;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(6116002)(47776003)(53936002)(66066001)(316002)(2906002)(118296001)(7416002)(54906003)(386003)(72206003)(52116002)(478600001)(16586007)(59450400001)(25786009)(305945005)(5660300001)(26005)(76176011)(3846002)(7696005)(6666003)(7736002)(97736004)(4326008)(51416003)(53416004)(36756003)(6486002)(68736007)(50226002)(2950100002)(106356001)(8676002)(8936002)(81156014)(186003)(81166006)(105586002)(48376002)(16526019)(86362001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1362;H:gi-joe.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1362;23:YfYwOLTvt6EJUqibrX6VHFff0G5rsp1Iamv9x1Zyk?=
 =?us-ascii?Q?YH9cMDszQjr57ixtc/xHHOjVdQLB1qQKFcMZwl563V1np8sW1n0t3INiP7Ll?=
 =?us-ascii?Q?E/d4njKPcRe2ay6mEjvNs9s+RlC5TDwGKUGw+sfXQ5v2rkHPTLIk3k+5t6KX?=
 =?us-ascii?Q?obE+PhNGa87MzQnSyT1mWPhyYlsSYEJ3Ret4hkOcVeEGUqMtSXlC6G+jsO6/?=
 =?us-ascii?Q?EWM/pXYLEt5B0RhPp3WgZJr+/0cGQSZnRm1PcHOsTcH1LVQxitiv0AQFGTU5?=
 =?us-ascii?Q?0yqU3bjQx+kWKCaLu/0y7nq5gS3nFBtLmptgFgHwZawh26vZeWFRV2OujaM3?=
 =?us-ascii?Q?nRT24nZxPCThSXqNmC+M8ezYjz9542MdOKSaStdBJfWmU6MVy3+1nYUdaMAQ?=
 =?us-ascii?Q?+txzxQcYHzXkvPDIddfW/BDixEPyLdDA0+3SGr1/7UUj0KgKDRWb+UfWY5Kz?=
 =?us-ascii?Q?/XFe/g4MkqmSZtsICBGBAE6tGYtUcKyRIpQ6n5Q9IilB5SO84/G4vy44MJnb?=
 =?us-ascii?Q?JCIyg6u6x291yUBUC86K2+rMLN6CVrC8O0evu4CI81VM4SnlbKBCisDPg5Pn?=
 =?us-ascii?Q?dDh/6TAOY8jY755WwldQ/21L39c28KyI4VnSZKHh5owK7EeJJ8D+kd+1x2az?=
 =?us-ascii?Q?TD1oM3JekuU103xhH/qZJgLmBm68p7S8haDKjZZRFnjaRi+5cwuDYh2bHJKg?=
 =?us-ascii?Q?Jrk8h4dejdtFvqjMjj6LYfeLpFuBAS/DrnQosbKczC6FQ4f0S+UaieEEVUIv?=
 =?us-ascii?Q?RqrCZZeLu+j3In8DAwyLhnbush1iAsHYoBaWZNRGV7KDV/TBfZmAsaGi9yey?=
 =?us-ascii?Q?+swAAX5V9tJDyEFUFmK5m/wNcomDzsy8Tw40v14fU3S41Kwm67EVcTz4kNX9?=
 =?us-ascii?Q?M5fOdSkhuz4cPKLRcOrj7wFp+qzK/a4pd1xghzFV1WbJfYDCKZWHXXVWB50h?=
 =?us-ascii?Q?fWbSB8Uq5XfRyD9zeBPUNtD/kYnGRpFxv3T1NQTnN1DWswR+H0LUOB1mK4tB?=
 =?us-ascii?Q?3ZF1pTjMCevUGBlD6eKS5ypRRqkmmlj3nU3irHo/4iUTNNUXZ/aFADfnGAht?=
 =?us-ascii?Q?LymTqsyvUZElsKAOYpqkDBCXpTaKJZAGYKt8vGyfRycgu+CTmzU+j8Or2sTF?=
 =?us-ascii?Q?NqhEUYHor/tzP/tiQXa+OzICosyqfEJQ2S/eJ23oL8FG2gdd0gT3xj9UKHaI?=
 =?us-ascii?Q?dmOOvxmyaoN8Dw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;6:xMdF6/96wmXO+k4dsrc7ZQo77m2EKOYyM7Ph04MX/EG6PHbXDGALt9R39xkLG+PhpOLK6lzz1gyqoG3Q/mnyDYrNqhXXrIRWw+ToBB15znZ28gqE7OfG4IixGk9HVqVnsodJ6J8ZpgaNdxLLZJuApBFYlKGNMd9HuLrHRabemi7SYBYYo3ATKpFNcXVuvDfsQ9seQn7LVRn6VnSEN5a288oSk+YXBCOjchAgKTq2i695QuH2EKK6PURM1fd/p8OpLjhQ8250SEmRAEIfDAZ6zZL9HctiXanfiI29kRgngK9SY/uXPTgFyILqSk2E05gfXO4PpDuxHPWtQUrR8Gor7V2A5o1u6lXHWeLj40PD5bY=;5:tXUQAJhlaeA0X/LSR7IjiFF3WY7b5qxU9xSztB8HSd2m96LpQmUNKszTUsQD/OyWlrmSjv52/0Yh5dNN4oFJYy8JUp7mewDCSRnZOA+70ElvS5FclWxR51aIgGfVLV3pZIcOmOvu5w34yZ+MgH+kWlThAzvhdkxvc6Q9ei54x2s=;24:YJdtIAfRHTM40Q0BTodgGkmJPzDSWksfcmcms6p8Bu4mKFPorXcs0AeiZU5Pdb4enhWLGwgoP3rIIOtnxhV/wR+wlbqZA5kVQPVNABwFbwY=;7:DCcP2Egjtah73O10Pyot/Y2Tbl/Fk/E24yD+e70f2kPBFZ3emsjdoJFbconQVezL7PJVcruwHs/LDkSbk6aw/ETUJfpy19OQrKLnl3NI4Tzvwwu3lAmitIZINfdE2T6Q8mB59HgbxR1ROyhgubVjuH7n5kIMPEowbXq8VsFKM5FA+wtGXdAbJdn9iUAaWWE1S8vTomsiWiIUTrmm53PVvnlHg/O7X41OtfrZDecIOknXdz1G0/LcZayzZbOCsQLP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;20:ksguM6xK+fxxCo4HI2Nz1B/kqVHDjGq9yc4f+3cWMrXnD5PmIRpDYBnnKe2us5bglTXIBeiuAV7a7BIfk9FvA9FXOti5Nj3k7Qunet4Uc0Tu4KfF+VaCV5JwFOHu9ZvUFWd0SlBvSONZw6pgxZhnzH7T4p62k3rIUIepyZoDquOdBDOVkJyvZgzzfqIbu+YWgiE1vrJpJm6uVi5//xbzI+tEVIXFCBXoS3aFzD7HAnMcnH49bKjWhqu9PClJ75cU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 17:32:57.4969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467758a9-8df7-432f-d54b-08d568078159
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the AMD Core Perf Extension flag to the guests.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/kvm/cpuid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0099e10..8c95a7c 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -55,6 +55,11 @@ bool kvm_mpx_supported(void)
 }
 EXPORT_SYMBOL_GPL(kvm_mpx_supported);
 
+bool perf_ext_supported(void)
+{
+	return boot_cpu_has(X86_FEATURE_PERFCTR_CORE);
+}
+
 u64 kvm_supported_xcr0(void)
 {
 	u64 xcr0 = KVM_SUPPORTED_XCR0 & host_xcr0;
@@ -327,6 +332,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	unsigned f_invpcid = kvm_x86_ops->invpcid_supported() ? F(INVPCID) : 0;
 	unsigned f_mpx = kvm_mpx_supported() ? F(MPX) : 0;
 	unsigned f_xsaves = kvm_x86_ops->xsaves_supported() ? F(XSAVES) : 0;
+	unsigned f_perfext = perf_ext_supported() ? F(PERFCTR_CORE) : 0;
 
 	/* cpuid 1.edx */
 	const u32 kvm_cpuid_1_edx_x86_features =
@@ -365,7 +371,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		F(LAHF_LM) | F(CMP_LEGACY) | 0 /*SVM*/ | 0 /* ExtApicSpace */ |
 		F(CR8_LEGACY) | F(ABM) | F(SSE4A) | F(MISALIGNSSE) |
 		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
-		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
+		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM) | f_perfext;
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
-- 
2.7.4
