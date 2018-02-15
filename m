Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755943AbeBOVKU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:10:20 -0500
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:8944
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752408AbeBOVKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:10:13 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH v2 4/4] x86/MCE/AMD: Carve out SMCA get_block_address() code
Date: Thu, 15 Feb 2018 15:09:43 -0600
Message-Id: <20180215210943.11530-4-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215210943.11530-1-Yazen.Ghannam@amd.com>
References: <20180215210943.11530-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:404:8e::21) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1aa95f48-54b6-4ae5-c244-08d574b87eae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:4C+knlJJWTC80l5CLa6d05MBOqp+x0pZMGBVuBX+Z1wUnIZ4U8K1iaZFmLHri+fF726TgeFEOy41cMlGx8xGUYATASluG+0cLvu6D6Cf5yQrIlO5wwRFUMPmitYwvMpZTYSCilB2+bsfIYoB4LhTZBWpXrnvNuDH3+knBHtVqdtT6euY+cIrrbEXxEVi5ut4GguQDwu/lqe4BccfocvpTL+HAxg6jT50HqDb5139+nLPaOq6aojzckviA3otQQd/;25:yO8N+KwSUzlUOTBrcvl8fYsoo5d4rw5sJExx0AHKWE4pdFhNtqPNi5pae4C4i8MqJ+0QjKtD7sVi2LZpWbNhsS0Cq3xV9nBxU2928CyK1oYp03A59ZPlD7J+j8V7DjXRSQyBCjYlGlg7aJM1HTLND28Bg/eHk7VB+pOZ3CO+vHfUOcL/ec5cj3pm9y4dlQ9nBMXMH8lG6O3o/MKS+aFHgUvY6h7Ua+L7u5WFep+v9eNzfDHoFYmak3NlJVFLGAVNZUYR8WcNCVoAqRTI0VaMjLeWOfte2oAbPo2aVT6ZGhMXknaThVqDxxy5t9rO582IVEHER/MdzAsYgvuGBHAFmg==;31:WfzU5jmmIvJRSkVTfpfs/KTeEhbUREO+27tpq9uy7XVn5OYJTqwLTimzvCDZnm195Ozv9wLMhyviHW9hBbGmQ/5v2uQKYrI5/w5x/YBrsSxJMgrr8o+l1+6KKxPyHuKMq61Je9Va058OvfV3vBTVyZ2nHJpb7ogbPpc6KoXaqyGffXKJWt47I7udwczlFtRHn3GFgIDWbyWk/yjv8VGLkcrvByMFwvrDFfYxMyOTT+c=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:WDgC2SG3GJ2N5P7UzYP4SWwBz6TjjqZwIgjC54zjM0cAKUvZnEUz+kiKrxrZmQ3dqAuHQFn1Z4C5vz9YGGS3OaAxA/laeruW0a+0jvolv8NReMW0ZD89yWaf7Sko6BwHdHHncmMQIUoSnuCitnEuw+pTpJo6jmSoiykqfX03ILhEEoT3iqgT8jAFnUx5M1t9SnS4Rvomsz52zhSkJxN2nPaRjp8buoZgC1dFGnseWGfkDxpw6aYtINIE/LSZYKBEQniXPi6h4C50UeMKHtPw96oJ7Z16vBn1GFHeDb14vfUR7aJ+wwgTdBObJI6g2GeZULHOnN0XVvKRp0nwBp0E4OHtSt5xFja5KQpHbuvZtnIrUcFaJNW0MxsWXuTMjITUhOUfGxZvX8AHJvzkfC8CwnnwpCOyg/54GwJRAj2jCo/+V4087pRNgadiqA5AfDePb312r5Fcv2JTf+RewZjs3wsRInDSDNIhRvXtK4uwDNYveR0sjSpH+lkraIcbDyQM;4:5SoVcIoVxZ7KLusTB89RhrrNEEHLOqyyjrIf55TW7iMdLrvrzSmKVmefZ8Duua0+c5L7z+T+MJ1Ngi2gq9RwBkLZkE9T4az8bIC0oK7Q6UziqjZmUGYcV4rX/bTBzEFASHNIXZLwuub/3jb/1uIO9tZ8mikxMoR88MXZQIdXpP3q8JJqO4ceTqrGyCmA+sqx2u2KRW7OKyQSZCJtc1vaOL4O3ECFvUEFeHTQt/IIFLBm6bbj0PWYviDiSrcuDT5eT49nj5Rlp7NySupD9Oa5eIkKwU/Ei+7JUYzjbnWKcdsubYWq9IYzDAVfPFu6RzJW
X-Microsoft-Antispam-PRVS: <MWHPR12MB19173306432640E427C2E280F8F40@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(76176011)(50466002)(5660300001)(2361001)(97736004)(48376002)(53416004)(6666003)(305945005)(2950100002)(6486002)(2906002)(4326008)(1076002)(53936002)(6116002)(7736002)(3846002)(2351001)(106356001)(16586007)(66066001)(47776003)(86362001)(316002)(478600001)(7696005)(51416003)(50226002)(386003)(72206003)(6916009)(105586002)(26005)(8936002)(8676002)(81166006)(186003)(52116002)(81156014)(68736007)(59450400001)(16526019)(25786009)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:UGPNIos15BaVJfBwvXU3FIyPUhTWnSgjxLOD21R7b?=
 =?us-ascii?Q?woVbVwjCfmJQBGOVdxnE9oD6CuDUkiXb5X2Tye9b3MuZ1dVEmV8Ptjn0E8NQ?=
 =?us-ascii?Q?4FtnjQoWBMT5Cgs5hoQPwpuM0npRnE+RC2KTHYGB4iUi99K0lt80EEL65LJL?=
 =?us-ascii?Q?p4xWG8gSMf4b3IfrPdy0m5x6Qv4EVcW6n0lIHNw1eINB4aHq9zMCRB4wUzwe?=
 =?us-ascii?Q?tQ6b2nqf455MlP/I7FsU9cNeES9dEy5yX1U17Dkyn554ySowHYEhVWm/s6Gx?=
 =?us-ascii?Q?SMfHeUNZI6H16Y8DrF56J9MtcbyheKdfzZTEo8eDq+aQX2FbXm26rVnjJxWl?=
 =?us-ascii?Q?WptTFjjEAbr6uNsrOfeIOnpdXRbDPGILHQ5Sr0sHYzfdXdbZCpQj3fZwAgKR?=
 =?us-ascii?Q?m7xqfSAkDG+zmbs/pwIxz8C0U7IcqWa9o5UTtoJQosVyiy5BwC9V0RE+gCed?=
 =?us-ascii?Q?Y7Zqjtss/r3OMKvm0O7WhAV8/FAQP8xBINsl1n8gwdE2Ja59Yd4vWnzcwj1V?=
 =?us-ascii?Q?ou8d1iWwZy8IZLIO+Ll6GyJVSvgVIyGKE0hQyqhZW4UpraoLpMwE4TS8qbsh?=
 =?us-ascii?Q?N4oP5ZhnkzZ9OKBZPn0UpHSemq2jT2zrZYhX5KDpsHIf2VPKoGXuKLideL/j?=
 =?us-ascii?Q?xg438fr3CWcFb8K+sw6rv9VtVJW6TTIfZFLPNtsurVCMklAlPqTNvOW0iIGD?=
 =?us-ascii?Q?C+2WkPNqU7N1VH48TIAyOYkCh5WKVby2RgD75/2VvgyEgfEywFUTW/LLn63e?=
 =?us-ascii?Q?dBdKAXP8CfoB+yl6aWE7raH9th2huc0KPvyhsS9ruNXwXdIr4rj6Jw7FoWN/?=
 =?us-ascii?Q?k/Dgx/ePL6RM60aZzOXrZQ86Gc3zYFbNmGzer09p0r2Q5am6GjWvhYpVMXWZ?=
 =?us-ascii?Q?yu/pNRmgoTh41FKltHgjKwSyR0OM7d8smnv+KXjBqG6liEBt2dlNMx7aIlLs?=
 =?us-ascii?Q?QW36J4gt1nh5MSvkqzJrzK5/0HLhjpwFA2wDKwL1DX//KXJuK4L49F4vYu0E?=
 =?us-ascii?Q?ZqN248WIp1nKiYQvhcyN/PPJaI67xfmqhrpN+bxJ81nBZtBGGV9IGPS5GuGD?=
 =?us-ascii?Q?zP4V0gE8hg7Dae6Z0Vef0Bd9pWv33JBvF9MOZbMoUUgwB153oFsrCs3gj1Ni?=
 =?us-ascii?Q?qU9ch9QESiLA59kR3UcGa5gT/jmJcEY++B4+NjOqDKSy1fzt1oqVZgj6yMYU?=
 =?us-ascii?Q?t4WSibPlkOHJAZUtImCul4ZMrmO2oBvqpas?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:rwnZZtLIwUbtJrno3FUnBwcgFqkokrYGET0+DgBjdZSlqyCgNqUY3oKsegRNuWIcWs05LMapX0pg+D6yXy8u7S6rABQfRdQhDGfRvXnquLWnETZH1jkSFhG7woiyHLQ6Zmri3P+scUeuBEMDuSNjTfojCMOzC8zAoqbBP0S5VyFUGHgbr+t/PEsvPmCtoSf/UZCfHlTftNhVeYwtvTGoBW84hsdLz2XFjTD7RixUtDBxNwjBdJktXZS14breph+EzMpXqKu8i2PbRdzcUdekgMiExyKqgq25Uq2c+N1kib3AQyOApmXNHMOoHhtkoEEMURt2KwhnO/P5bNrHUKgcoZ97ld+YEX3+dySsrGPkcZo=;5:mgecArGRyRYFYck0FWpLpS+QjUKVCeuTQFgydMlUuQAjZTieeKV732ooO6aeCNmkUu+UZB/a633kRlsyPYyhL6iSUFsHWDt3XA5eZEncGLjBVzxpMTOIUmlf+4GvbEAN0RlwOhjtCYOpZhHblwt9jnK7+CwKEwJZwrDPkcqUFGU=;24:5mMAg67aXIx03ZFiLLwB1jEKewnXRDsh/nX623B8++VimuCZBB5mCqn+NUoS6jeXxz6MjJTrt1bLIkLwLoXENuo/s15/sJ/TJUuxNuohOK8=;7:y4h/7rBjongjgVCOee5XCIV5eDHUPXRgNlOqeV0zXNxaqJys6Qs3O4SwSMPEvE3QdqVuZ9pS3/YZ9MsDrNWymEUuwa30uc+hKmi8nxanZJ3HE5YLBeqZ/MEVHfqNbqiH1oFIsPNVQCTxs3ZCbhqsemghe90Vcn5QSryB/lPOm9qOl9HmAunGciJRcZEB+Tt+VjDHALG59U3T9GmXs3NE4RMj/SRNvdoj9I+Sx4Z9zO9eKE/29GOrP+bbtJBz2fZX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:BKJ8/GXOMtToCazFL7JyE4FbLuycZZvf+GMPI3hAlvrhGnfoZwkJdZGC3UhSeAcqgH5RLAdpsEYf5nQj/ri3aeoyqsWbohRVhfrDZI87BLGaD1EWKwF7wYPFVyNZn8+jELJWl5ddAAgBT+QrcxFdsp/Qi4X+oG7IlMfAhtt+erCk+g2ZsKlrj+Imd2KrSbmxYEEh0jMJSp4OOi6+A4ewCk5ryQqEJLZAC/R9dhFKXjXtLPywpSXJ/YqgpejfYnap
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 21:10:08.0980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa95f48-54b6-4ae5-c244-08d574b87eae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Carve out the SMCA code in get_block_address() into a separate helper
function.

No functional change.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
v1->v2:
* New in this series.

 arch/x86/kernel/cpu/mcheck/mce_amd.c | 59 ++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 12bc2863a4d6..7c451850d8aa 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -431,6 +431,37 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	wrmsr(MSR_CU_DEF_ERR, low, high);
 }
 
+static u32 smca_get_block_address(unsigned int cpu, unsigned int bank,
+				  unsigned int block)
+{
+	u32 addr = 0;
+
+	if (smca_get_bank_type(bank) == SMCA_RESERVED)
+		return addr;
+
+	if (!block) {
+		addr = MSR_AMD64_SMCA_MCx_MISC(bank);
+	} else {
+		/*
+		 * For SMCA enabled processors, BLKPTR field of the
+		 * first MISC register (MCx_MISC0) indicates presence of
+		 * additional MISC register set (MISC1-4).
+		 */
+		u32 low, high;
+
+		if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
+			return addr;
+
+		if (!(low & MCI_CONFIG_MCAX))
+			return addr;
+
+		if (!rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
+		    (low & MASK_BLKPTR_LO))
+			addr = MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
+	}
+	return addr;
+}
+
 static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block)
 {
@@ -451,32 +482,8 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 		}
 	}
 
-	if (mce_flags.smca) {
-		if (smca_get_bank_type(bank) == SMCA_RESERVED)
-			return addr;
-
-		if (!block) {
-			addr = MSR_AMD64_SMCA_MCx_MISC(bank);
-		} else {
-			/*
-			 * For SMCA enabled processors, BLKPTR field of the
-			 * first MISC register (MCx_MISC0) indicates presence of
-			 * additional MISC register set (MISC1-4).
-			 */
-			u32 low, high;
-
-			if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
-				return addr;
-
-			if (!(low & MCI_CONFIG_MCAX))
-				return addr;
-
-			if (!rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
-			    (low & MASK_BLKPTR_LO))
-				addr = MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
-		}
-		return addr;
-	}
+	if (mce_flags.smca)
+		return smca_get_block_address(cpu, bank, block);
 
 	/* Fall back to method we used for older processors: */
 	switch (block) {
-- 
2.14.1
