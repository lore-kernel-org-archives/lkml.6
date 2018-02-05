Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeBETZk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:25:40 -0500
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:34896
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750818AbeBETZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:25:19 -0500
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
Subject: [PATCH v5 1/3] x86/msr: Add AMD Core Perf Extension MSRs
Date: Mon,  5 Feb 2018 13:24:51 -0600
Message-Id: <7cf7bd5fa6d24cd46a9ea50024b0010bf3d01088.1517850303.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
References: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CO1PR15CA0095.namprd15.prod.outlook.com (10.175.177.15) To
 DM5PR12MB1370.namprd12.prod.outlook.com (10.168.238.21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 195bdeee-fe93-4e37-f292-08d56cce3012
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1370;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;3:JubU7YC+9/0p61q6uVhXdo7etFaEFCY4M5xYAno3YHkYRwmq3hZmcdQIs5F8zUhxIYq37ML0qOK82Rj+aweqF+qpv8+TV9iJxl2ATcdSAu0Y2IPc1pJulwVdHgfmeTsZGf6DgUI7iudokPKImZNL/JBS81LRfzJc8HB3LvfjaccmwXthHoDTtTpyXctB2+rHq6Eizw9+HoxaZp/QxF8DAmCBI1Jj+LRRNpWPl2EXEE4JcyFHHEj3ZJES/aJtRLwj;25:SFytYQO6QrhdbQrr3wgX9Np8KPvMaFy+4n1o2nBXIjj9p5qK1Djvu3MVmE2cWCvzyH0/NlvtkTZzRY/GY9GxYWpaSj/dqJlfv8lTdn73oRHjHRt8TJcOjE0E4+XWZ52T6zNJziNRNJ580wwAjVQSPYwU2HwvE+VRBkQgnvQlZ93uKszGw+9297pJ7fTSsiP6mIuDqNwjgvqh+pskl/Yt7oU3xO+OJVI8pnZww7vtB+fRtT1LFgRNVfjwvMTfBDupPin8tXJ3uqbcmxQGZl1E7SBM3z/ruak2h1g2C0BsDdybm0y37eRTBx+6IPIIuWOyV2A9+kImn5hWfCOWyLLyig==;31:FawStOUX0n9q09ciXA4rakoRKEg9RD00X9c8UOPCaPdAr86t3mHqpF+LsJEeYX6ibApGPtmv1D/du0XyffYAgmhtVQ7wDpObqfwShWxamzYnx417BZi2TC+IN1LXgx58C/xMjXNZ39TRLvpBVyeJ+xWr7987Rc/5aTdsK/zm58tNZzGRDIaRJsatN00fpAUhZwLMZ/RT8yv1OZGj1Ale6sAH5u+aCqb5Q9DoppZRNWg=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:hJQ5RWbiqeCPAK9x/qB1VoQgmm7rg+3+tmH5+pYE1WAJGu1f198OWz84oMURgVKtCZYinB2mTMOO0dkTeI5NB1qs9kVIo1XSgsMbrJ2jYQ94CZZuzuEJPdoMysrC329uZwp39Eic9lP5TBWH+twlpMBziGDhFveTHIfxFYMKTD5FE75BUEVp1BqZQlmaTIqIMnaV7M7I5p0G0vvEGf584z320D26EPDYNaKwlL9JZM9h9Zv4v36cEOaRQPTBKAt11vKvOybFwaml6hRsVHoAZmTrH00EAjw6WRFKSvQRBZzxqAmEfmjRGstOfk7TEj0vaZqGVV1+tRs3k3WWTnWp8RaLqStD6lV0Z3RK4RmnGTKUX3bLuQp1SbiLw0zpGz2BWn7PQaIEu5HwEvl96foyrf5l6ASGRqq8hu1XrRqUlS4F+tcCFkK0Ro0ksST5Vp7Lda3CfJc5JUoHNXjF5mF92DHFb4EA3s2NhRPwkZGOZGFcJtoIvX+XqedVoAvMKA1N;4:g2Zv5InmCpZWpUMZy0P7xTw2m0zeRLCkGqMNo9o2S9oP08IGWsDvoh5BQxFxxOdRA6WZChmEZY6PuLP2xCy0SWLjNwA/WraYRltq4x/7xEEwlbQz7RKPEWXnho/XwFw8obTr1wqJSEjB9nHHBLhV8AALueVv+i4rO2zBI1vBZmW2JJg27RKxUca5DEXMd/mCnPd8RvG6p5KlJeg0YNtUpm+6IYsBMBAbHTUxqjIopx8baRIMh7cb/JO6Lj+a9xVMhr2Co9Q+PNmVhIEid/DmXtAA9BArVtFPiTGPI7ROJSY1sNyXF8dG2bnSWO+ZQ5IB
X-Microsoft-Antispam-PRVS: <DM5PR12MB1370006E83F1A571BE051381E7FE0@DM5PR12MB1370.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1370;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1370;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(189003)(199004)(48376002)(68736007)(7416002)(7696005)(50226002)(5660300001)(52116002)(2950100002)(6486002)(6666003)(186003)(305945005)(47776003)(76176011)(66066001)(4326008)(81156014)(50466002)(8676002)(97736004)(53936002)(51416003)(105586002)(53416004)(81166006)(386003)(7736002)(8936002)(25786009)(72206003)(26005)(478600001)(118296001)(86362001)(106356001)(16586007)(54906003)(6116002)(3846002)(316002)(36756003)(16526019)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1370;H:gi-joe.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1370;23:QgZ2AlX1t3Jmh3DcQnT7WYVl+jKHKYJ3hPyDogVjE?=
 =?us-ascii?Q?3uxAF7MGhsEpCV1N5jhlNkVH9RY2SZcpdKYRwOl4MSi9sToP7O4UIZh0SP3z?=
 =?us-ascii?Q?cSsXCRFEFLIxybA1e4DnNXP1491wwPrlaIEQvR5ZPi9BgZb2ST22L1ROOTrR?=
 =?us-ascii?Q?+u8IdPQwuEOJWeqRxrMZKVgMtOBMwGb6ClF2LEOwK+8YQk43RA53RBesIWHF?=
 =?us-ascii?Q?xwLuMHLrAwsp9NFmuMwX5DvSG4yrXsVZxlrGe9H5RYm/QM7Kyr45mElzlqPn?=
 =?us-ascii?Q?wesGqUbTFdST6osZsRCQKocTPO1BX9tSKlF1Rh+9Utj8n9gMntDJQ7rojAX3?=
 =?us-ascii?Q?98jSh9w4KppuCTBU6QIsBVqcHFfkjFZEimSEvEPySEd5eU1liC14BgNcaeNL?=
 =?us-ascii?Q?4A/e3p0iAN0HXCxT/Io/166P+dFIIulybmIKe/EuMMHLOPbRduxbodJbfDVD?=
 =?us-ascii?Q?LN3pMxyA/E8s260SfNKjcZFiK3Oj0HeS84Y9MnpXE1Dt8t1HM/tVR1JXHnkT?=
 =?us-ascii?Q?dbcR1Akllk+/derrQsutVso9Z+dr8FblO/OEq44nexaGQLM/0VwfZA/L06Vz?=
 =?us-ascii?Q?2WUW24QpylkySj4IOoJmVCHNOOEYHBbL6YkixgSI1tefiVea/Vd+pGel2OG3?=
 =?us-ascii?Q?wnlxa6cLoDFu2rO3FtS+AlkEl8CXvemJa/L3wavGoutSNJEIg1GetR+rvbXJ?=
 =?us-ascii?Q?BqvSNagrzF6rmmZYkG7i8w6FHVSnCTUDrsTbviuxJwutIXN3owAJ2SVXPBRm?=
 =?us-ascii?Q?NO5T+RIUbfKt9QjPdDWGW921I4miKN0x10NhpxLwnCqYtmixCsG18auPdojw?=
 =?us-ascii?Q?qRJVXfnj1aV7JauK4B/AGCbHPkziBubT6T0pwWtYv3fhtqa/oXPsXGmxWoOj?=
 =?us-ascii?Q?D21pbXBswFrzezD/X2IU7g8ywakGL02b7IhBwDBzUqHVTrp5ySCtc41hNv9x?=
 =?us-ascii?Q?bkWqNiIYLTArbkaTOMCP2lK7umtIjvR+RZgUW5Lhgw+dBz++lSEE0QY+jtbV?=
 =?us-ascii?Q?p+eX353gOilDD4/IWTMlmdmh7bF7d6tIbyH4B4XJwi//8hyrZjOx1Jye7gT+?=
 =?us-ascii?Q?K9p7vkc2qk6P0pToTxDZKSnXXQC6LbyMKuM0Ta0LO1W2O02E69ScN22Kp//r?=
 =?us-ascii?Q?/EYyq49xa0vYGh19YfyfCsAQXHisHLXpx1leKKb6JX5p7yG2N3X1w=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;6:jxnvkYjUqSI2GpJS5EuSjiZPnzv2IDzYXfux5bzZcZdeX5tD4yVV42FttmGKMB3IFdF5n2hyOB4PsILn97i9R1ppRWD1HN1MFjJ1o0ZcqxBZu8h24Hn23g9/9jo27YyjKbjk5W64Fgc/orAS6xwiHoprUwOgO9gwS5foBiB0dO5new9VI6ND3Gw5FMXehszD77xxtqYOyKnTgTRXR3yvP4y6d0dF9EpIZVHG7LZ3UWKmaWkoYV+gLqMB4EpI8veBczLDkIiBx0uEM61TtB174CTCR7moeNBy9sfDniA9u/4xWNf4HkKYmbSMW6xkBinnoO3GlARbRBWVqptHWR9B1JSxYOE2DEeC6eb1OVMFEW0=;5:7mvBXPmxtncRRSEm0QX8kcG8QsRxVDzG4HQjeehDwhDYUH3jqyHHNiKgZIxvHiM4VSvvLBpKorMi1KBxdjtHAQO7rev+BIKG0iLvwsz6YO1d06sQ1KqsDw+mQgF300QJTTbyodK6ebwY8aRgMzssp5ald6gRv4n21OhZh1Q8DGo=;24:K9PhXRcKuyZONhZdwAB3DQBOlnYW5iwJ4kzBHHZb1LUa1QrT3y2AglUlUxUOaC0WOzRnK+wI1qTZ8HJJEzN9DNtiYXN8kL81zVma8zSmJAI=;7:LKSqlUlVD8xjRbY4GZXyMmLM1yXJeuVgqJBfjZ+2QiwXfa/1Qvm2P2y5lsFAatsrFD8lFUftpGB3rqcS/G+fil61Rp31XYR7eSv/QR8EN61838I2YF8alqK5ZC3bfHsN0t/6jESTPY+ebmroAAjm5FqtUFjp7mVISEV1VPbJq5Vmi/y0RSrwZVmAGkHIMK8gaQUIimIbxqtrTNuhVjOfVWM+8cPezQz7YCSzN11r4vsR4dQ1cPZsnsKZYiR26anm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:+aePN2/8ya58Xmbm0pBRUInzX6H151SIiNtneDeas4CVSj8pHZwhaIP4jcAPKAYZw8i2FR4DPFcXH06zyr80eoSdwIUq7+/jc3YOiT7letUj74WTphE2eRx3KqdfsKJhwzNvDBsTOwLi4FnyFU/cyhQvAVtRv9qEpziJ+xIK3+bujIVqhXdN6Cr/LqBQRI3Exd0x8vPifI5R8jE0fdOU0Fm0P2leW+0w/98pxfa0+2fLBu5kBCbgYjQvdzK2yC+9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 19:25:15.4185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195bdeee-fe93-4e37-f292-08d56cce3012
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the EventSelect and Counter MSRs for AMD Core Perf Extension.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e7b983a..2885363 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -341,7 +341,21 @@
 
 /* Fam 15h MSRs */
 #define MSR_F15H_PERF_CTL		0xc0010200
+#define MSR_F15H_PERF_CTL0		MSR_F15H_PERF_CTL
+#define MSR_F15H_PERF_CTL1		(MSR_F15H_PERF_CTL + 2)
+#define MSR_F15H_PERF_CTL2		(MSR_F15H_PERF_CTL + 4)
+#define MSR_F15H_PERF_CTL3		(MSR_F15H_PERF_CTL + 6)
+#define MSR_F15H_PERF_CTL4		(MSR_F15H_PERF_CTL + 8)
+#define MSR_F15H_PERF_CTL5		(MSR_F15H_PERF_CTL + 10)
+
 #define MSR_F15H_PERF_CTR		0xc0010201
+#define MSR_F15H_PERF_CTR0		MSR_F15H_PERF_CTR
+#define MSR_F15H_PERF_CTR1		(MSR_F15H_PERF_CTR + 2)
+#define MSR_F15H_PERF_CTR2		(MSR_F15H_PERF_CTR + 4)
+#define MSR_F15H_PERF_CTR3		(MSR_F15H_PERF_CTR + 6)
+#define MSR_F15H_PERF_CTR4		(MSR_F15H_PERF_CTR + 8)
+#define MSR_F15H_PERF_CTR5		(MSR_F15H_PERF_CTR + 10)
+
 #define MSR_F15H_NB_PERF_CTL		0xc0010240
 #define MSR_F15H_NB_PERF_CTR		0xc0010241
 #define MSR_F15H_PTSC			0xc0010280
-- 
2.7.4
