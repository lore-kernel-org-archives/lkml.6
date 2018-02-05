Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeBETZ0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:25:26 -0500
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:34896
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750846AbeBETZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:25:18 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@suse.de>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v5 0/3] Support Perf Extension on AMD KVM guests
Date: Mon,  5 Feb 2018 13:24:50 -0600
Message-Id: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CO1PR15CA0095.namprd15.prod.outlook.com (10.175.177.15) To
 DM5PR12MB1370.namprd12.prod.outlook.com (10.168.238.21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fff6a8e-01d8-4638-267f-08d56cce2f03
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1370;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;3:NiK9U5jmzTo0CcO4ESy4K8FLO8ti5YcZ1k5Xv9+yuFXD6a/TLq6R6sq+G+7grUY1HrMJxyuk9XSJJEUPvd+AVKlu7qjkIj6o71Qdu113gLZmcyWiTp/V9lZMkfTHoCLUD58egiEl6xUoxpxiC4rVtUZwPxeAd0feeKmQf/S++b3Ub+RrHCGduBsH8VpR+eTmDLgoeaO8GmwB+oA9Gm410Y7bT24wPoDN8H1Uz7CkAmUPIMEpdipRXF3ibdEaZu67;25:jL3mnoR185p2SezLZ05ZRSghlGs6SxsmJXKZQqVnrV7W0XkypmewFo9Pf5XsjmGLhCtk8B6vespvrkevD8ct0xDN3zA53g81HRPw0KJGJCpFRygQKR1zrdwdyI3jRa3f+OSLWyhJa7fhCz0eSZopOcDeKt11EGTywzuJnE046PkrHHQo8cmYbV8FMHvjFbpPz6TLQv1lZq+azubDvTiZqj1n58uiyRNbU1yxz+XwLL1wYY8Fr4or539vT4qz2IlMX3qEKFAjPBjA13lZRZLzPoVkG1JgwciKa0LsHv/E3AgDfuxrfmHpxjqBX6LsOY80M5IP8TjcPrkQLU4rmRGiPw==;31:L0vUxNPhGYqhEKkdmefG36AqnTydaqm0ruA2MY32J9i+WrCFZkRPHBVgsetPVpAAvI3CMnuQowaeZ0Of94DZ928L5hRJvCoy0fKqY38Coxf9eT/jyJ3Hw1sB9qFL6OH6Agdz5SIZwmoEqo6Gb5HO/Ax8S36skc6pCewJLM065nhLPxg4CUIsJU9N4YexiGHqISjVK6gpaYiMBV09LCXxwsfjBA9wdCaLj7eVviPX/4I=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:PUaf9SSh0pY1SCn6rAxryKW5CehH1bH19NlycSyCvtSoyWt2Z/cYSj2jpT6mJ86HUmW5cOFGOl4eX682bMzUnsBKq2gs0xCBejhrLDARm4n2qPoMeFAfjD7kika1kFBnGipelTYLeLG8arigpWAduYXPugFNIJVta2E3ByQWENdmF3KktVoKia97NQbjxJXl2zLzMZ6j8k38vsxGTQ4252FSP+SSIFMwaEUMBKnjwNNS3uDfbieVn6jnL2TU0L8lQe7gmcz2F45NSqFvLZD9harZUyiQhj098xtKXa6Fi5kxrsER2UvkliMoUL0otdtz8t2avngh92WWUaQXqGyHQJtDhX29eEc9sai4EAjKvWfrNL0LWtSaKZlh9FvmXIDCB27HtwjwaztMud/sIdq4B9kl4qDWueChKq5DhqKSRhaxmY47vVy8Ert6HU/g2Bkqd0ogFsRz6FuoWwsZoZU692BqFOS4v1ePOSooSihiJXmsPxRg7ZDUOyX/U2jBb3nk;4:Zy4y5phHA2Qyr3PaiT3oAue1ByECb4/K4YHqiKZZ8ZWyBDZ7JD0C/L7Eoo/tt+cB+W9bj+O3p4aubdWngBL9U4Xk0bHS0M0eq6eeOQpbdbn/wXwGxIG6Ip0sUnqBgnlXhysRl6vE7jdHYNKSSTXv+K7/aMTT0C1wGBphyCzDI6f80MfdnXsf9v9H9KwXqH7Pd7w0u8Nq9RI74cSOEFcrYhrynjXdFItAhVLK+JLpchliQv1PoAL3p4AZEtCmYptaQRZallrTqpc/35dgCTw7Yg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB13703F95758188383197437BE7FE0@DM5PR12MB1370.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1370;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1370;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(189003)(199004)(48376002)(68736007)(7416002)(7696005)(50226002)(5660300001)(52116002)(6486002)(6666003)(186003)(305945005)(47776003)(66066001)(4326008)(81156014)(50466002)(8676002)(97736004)(53936002)(51416003)(105586002)(53416004)(81166006)(386003)(7736002)(8936002)(25786009)(72206003)(26005)(478600001)(86362001)(106356001)(16586007)(54906003)(6116002)(3846002)(316002)(36756003)(16526019)(2906002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1370;H:gi-joe.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1370;23:S2KNNFV6RVo6omuzLq+u6Y2xs6HCUK/EiqAi8CXJ9?=
 =?us-ascii?Q?D+8XIuL0rtC8JNIORbYfk+nJTSro/EmjBFJcRCY7V9UZWay7CdfaEDL2g7UR?=
 =?us-ascii?Q?PLs9tgvp5/3gqWPHI6Pm+cTmzh+N3OsXsq/0ligtgU61pqayxfxX5wIJygPF?=
 =?us-ascii?Q?cxFNXS+5N/v+ot1pFUa5tkj5cz4oZ/jx1kZ7a2GOsO4PhLcWLyQ7T+1lCPJX?=
 =?us-ascii?Q?oksnyltYTuOVWLVNG7MHUy5j6KDHhvII5IH8hWe4DaYNZHbti9tLERVL/rOU?=
 =?us-ascii?Q?UcCjjdNknD6PUfyi6d0SBmRpG3AISWA3/4esyXpZ9+N8oL5Zal0JijLBSd7p?=
 =?us-ascii?Q?YY9RvanvziyRpoF1u7KmdCLMtwF1dJyfnpFqc9kXPCI/yNM/seldViF4oAiQ?=
 =?us-ascii?Q?PtAJ3pFmVk7OYfRT7ir86tjegMrzWMSJrDsDqIaa7AzSZqoQHMWWPW8Vu76N?=
 =?us-ascii?Q?NKWV9F/KRRcjbA2fU8y5JPS2Vmp9t24JYo2W2csvWj0DI8SI1aC4p8AlcuIC?=
 =?us-ascii?Q?Z8RJiKwZE9Q+S1Iq8BVnQUFj1eUR/+114Fm31pi+bXz6Pl7NAKN3Ovqr0zoK?=
 =?us-ascii?Q?swCsWZXt9jB4bOJXzO42Q1Cq5NkpetmkkbvFHawpsQjNvy4uJhQGH1YZgzb5?=
 =?us-ascii?Q?A/b+qM5woC30MrCJkZSb0zT0RspXLneJmtp9Kyvl87OORDIT8vcF6UgSZdzd?=
 =?us-ascii?Q?7gFPfmpqMZ5KRqC3XdRF06gc8fZYYK4QdmAMD2GzvG31E0p7jOi90eexen/r?=
 =?us-ascii?Q?MMVI183/a700nb1fdb5MsMmQE7lEgJ4tpxxT84MUiGJN+MaCjdDSQVxud8Xv?=
 =?us-ascii?Q?HgVKpB8mBIAQ2ugaZDJ3SQdGB6AwaGUDf/juA3xg7UkoC69zm13681KPRQn7?=
 =?us-ascii?Q?JGgqT8PAcPJCcIz1XGKWSeXx+Lmgc2Ii9KXJUXEFpjGEZA+E006PWCILUFYD?=
 =?us-ascii?Q?ZzDWN68+b8ZNAC/8S/1EQoXaWCxac/oG2yxIVVqTT5x6mPXN81SZz9nJR5/2?=
 =?us-ascii?Q?sHYJbQzSroFeFc9aRK9WlBwyyCtHONQLKmXURQm5yFQHqFYDXY9Am58LWsJ1?=
 =?us-ascii?Q?z7ADC5CtdEr5ObF8Wax/WlE2iPSAsZ/6RAj1giVukcyc37A6MwL/z12pdLp6?=
 =?us-ascii?Q?nfijzgoXVg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;6:yjnHagr3IDe5ZxQsX6WOy0YjVQmDI/xa68Yt7U3enWTCMCC95JpyacPa07uM/PhPIB7YEqUE+NBSjn8Qu2x9SWq0GFSXf4hrrjungv2SQntSyfY48lTwbxOyftVs5f2IMxvZa1q2GolbQmAsvm7y4KGOOMVrn7EHCJOnQYPz+Fq4uVzQMKbQmTAbLXlY5A0GXdTnIHPfJKCIVZYh8Bjulfgy8JYUh3XQElZI2GUyG1+dvbJA+SrmQA8XhWNqL4Hr66C0Q1P7SH+DhCzGc3zs95ucMycxDT3AYsp/XTOuaFP9IpUJ1hWiYPtLQkc1fpMecc1FGchT32H91bO1I27CeIrjUmoZWN2x1qXORMWQXfc=;5:ty0I4p2U8k2cr1gZf5HFE6EKpJhYle7W1dTMkGZ88JMz/HBr8XMBOrhIXDV58s8PXPTxy8GaI1C3bUhtJR90OURHoFa+WBubZg742GRMs2H/YZq29twSI3n4HMEcyAak6Z6I+LTuP2oV1zXvRqzHhcSma/V/+nSb5lanZUrs5Pw=;24:oU0F2zfVXhIADqEHLSVyTj9jUo9KthfuPCCN/GzrfKJ0kjAh3XdnSaklLSOU4Vlixspg7qkC7iKpXu+AvAZ6atlh+fVDou0AyjnGxJTV/Ao=;7:MK3ng4OQKYhv/VXgiUKBxqM8InlFbWE8KYsYSkAsupmzjC+1cUeJzEljbW8wiyUi0ovsJcMBDAHA3suZni7Utjrq7q86Zlfegh0KdKSAdhzGEZM3B5qQhk2041RYbML9x1yVRjZ2yGBB2FHF3RICYt6u94nGPolsWUN1oYThaxnda+iF9I/N7X7Em2q5jGvITlrOHrVh8zmHifLMF1rwgAwfFwEtzXThSGfqvVjUB/MtM6GByf2biqXo/vGtqKt5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:yN5+I30u3fMsdlgo5yBUs5RUbcslZa/PpE/Q/qRK39/hBxWyIWBe2sP8iVEoVrGVOGofzgh/KU1y4wMQciah+zX3oABNr8DkHAeYjhshbZjZuLMODQLJeFqa8u+u43c2CRd2YVgLv4P3aKn5o4daYa2YTC8uZF4mHsfIXpFWos980WRzx2IjnDl7H6KSNirAPglyQI+LwEEQ1+vtzu/6EZfVtBJ9OCfm41SZfXoTGbzGrxxMqtKJOAQCxdNLgPLV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 19:25:13.6372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fff6a8e-01d8-4638-267f-08d56cce2f03
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Perf Extension on AMD KVM guests.

When perf runs on a guest with family = 15h || 17h, the MSRs that are
accessed, when the Perf Extension flag is made available, differ from
the existing K7 MSRs. The accesses are to the AMD Core Performance
Extension counters which provide 2 extra counters and new MSRs for both
the event select and counter registers.

Since the new event select and counter MSRs are interleaved and K7 MSRs
are contiguous, the logic to map them to the gp_counters[] is changed.

This patchset has been tested with Family 17h and Opteron G1 guests.

v1->v2:
* Rearranged MSR #defines based on Boris's suggestion.

v2->v3:
* Changed the logic of mapping MSR to gp_counters[] index based on
  Boris's feedback.
* Removed use of family checks based on Radim's feedback.
* Removed KVM bugfix patch since it is already applied.

v3->v4:
* Rebased to latest KVM tree.

v4->v5:
* Removed conditional check when exposing Perf Extension flag to
  guests based on Radim's feedback.

Janakarajan Natarajan (3):
  x86/msr: Add AMD Core Perf Extension MSRs
  x86/kvm: Add support for AMD Core Perf Extension in guest
  x86/kvm: Expose AMD Core Perf Extension flag to guests

 arch/x86/include/asm/msr-index.h |  14 ++++
 arch/x86/kvm/cpuid.c             |   2 +-
 arch/x86/kvm/pmu_amd.c           | 140 +++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/x86.c               |   1 +
 4 files changed, 142 insertions(+), 15 deletions(-)

-- 
2.7.4
