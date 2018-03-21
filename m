Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeCUTNy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:13:54 -0400
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:23344
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752758AbeCUTNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:13:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de
Subject: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes with enabled MCs
Date: Wed, 21 Mar 2018 14:13:33 -0500
Message-Id: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:405:39::39) To DM5PR12MB1913.namprd12.prod.outlook.com
 (2603:10b6:3:10d::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d4de25e-4d09-4d26-88cc-08d58f5fe0e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1913;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;3:NsNfvl6XUaRDU9rV0VYZBehzH3zexo1U3YKL1MOJrrkD0FQH7M/7vfsIQJ7VQAOLn8FR0uq5TIRJLKS2qAyw/BKCPHAC9Z4qpstjauVmvg93aZsQPxcDJ1JvTTOuFwY8qrGkP2EHtF0Gn5jIKL0DqGkcF3gdDir4xYqhDSMtMNy8eJ9tSKzXfgI63CMtdfXDXHc+ygmQH+8sYfMZeZbMoDlo3lqR/Df7gN8sL0zaTci5y6rqZa2rLeTTnEHERXc4;25:BX586zc0dDHyMbb/TYo1x5ENCXqWziQULo45xZnjevhWbUqKYjDDkJJKc4vZAo4RYUhG283Mq7nOk33iUev40AnkfeVFQ/eRZ6DoZsJFbWl3Qeu5hsU92BnevCl75QlECLAI22i4ALYhNPZbYJsGqoq6GxZrZx0jkEu/EYgklo1Q5Dzq0csn/lC7lCrNDm9WZfk7ZpzIlhiW0GEKpmj3k7N7B7sj5Wc8blaJ91eeVyER0wgt7w26mEwapDc4fO7Js6MgoNrqkw5KiV79O9qWTbcXJp+KMfncuzafOGA1dFvcf6Ep9lri7RpI8wmemoDpy5X2+CDZCx9LfMalsSdaRw==;31:u7G+48QsQsGGlq050FfEqEu1BhE4wjBHahw4JmaMbw38N/n2sYEboXphTl2uf7rG2ZNAFQLK2Ex4Q9KkyGRkxcSE2AfcgB/ZynpzGpHq6brenbQOZbUYz+47N7ykuqYpS4XDPP38oKWgEm+oewVbtgPMwH1qP0M7TEm3GJsSBTCsMszVDZMWiLOw0COEiwi7ZtBU64Ia2oV0WOmMQhM5z8qOkgnCWnmY4GKtrgk+Les=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1913:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;20:mLCNpCrqhN44KH2wSew0O69PezHwOgICZgA5FToO3QcIrb2VPAYf9/KtVh8PCL770AWl5uYZo8a6EetJKvsifmS4txsEzSzSAGsg0UEM6cTYooNr/3t+4CcsmODp13mAkQPkGHE4avvavBCkBJTrz9P41JwJFqY1O7+1mdiSo0V6ed0VSbjPZHJXWxshAZnU42dejTZX6rq4ffYzuJcFGKiUwdNQDt/ok5c4U+Na19fh/43OvNzCJ/hgBC2GzTBtBTYjINpE+aLKTHAhhs+woT8jbmvR5YhIEsnFLzhexPhLtT7KqqyqnW4cmnbo0X6xLaNH/D4lWxsn7iW8cO3PJsh4FU+wZPXHpaUHqtxewPQWn7MaR/GJXL6MdQjEWqp442JiS3gjmAym3dLTqFzxQFFijb6gZAdoQuL7Fqp3TE4c0oek0bQ1fO0NZxgBwKgN124UxxBup4FQJC+hMfMd4jmatbYWxzxjMEpREpm724CW4io9vIDDrjARqvQU03Tk;4:dSe6FDXYXvUnRU4f3TiXHJA9zKEq2Bj9aV2ugd/Q0OjbKIz4lHf7eBmYmU5hgd25vhwNLqGpwS6QQOKeDH+m9ybCv30s1da1mqYb1JxwQBTMQ7BGXrE8oOD6e9n6iPzoZM8VJLRLLZUAEcZ7krZ53djX+ae3WPj+z+WHsf/taQ+1fyrhuRPjdxucspoR13JNKYf2slQ6IRWmZ3hQNFubEtA/0Ypvyd63D+S3421s9DWczXXOi89EX9mdI74Ikb0tTVwoT00ebSGze3Meawdjg5pkye7Tx3uPbCH98bde1gz8I3wvEB0jDmdw7WIP2bZO4xkQp1992jLFYZcYBfqxcg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1913AF985D934A71590B2756F8AA0@DM5PR12MB1913.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501326)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1913;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1913;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(396003)(366004)(39860400002)(199004)(189003)(186003)(305945005)(8936002)(53936002)(50466002)(7736002)(2906002)(36756003)(59450400001)(5660300001)(105586002)(386003)(50226002)(25786009)(53416004)(97736004)(48376002)(72206003)(1076002)(2361001)(6486002)(3846002)(6116002)(86362001)(575784001)(16586007)(316002)(26005)(478600001)(8676002)(6916009)(47776003)(106356001)(51416003)(16526019)(6666003)(66066001)(2351001)(68736007)(4326008)(81166006)(81156014)(7696005)(52116002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1913;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1913;23:X7kADgGtgAb9CoIYciPcPIwUpR7FIwvh3lKxYgF+X?=
 =?us-ascii?Q?H/aY7qUT9OWuRwFuy+g5Ov8zCH54WyDYwhM/GemvRyAKBIQQdzMCmZedr5Gw?=
 =?us-ascii?Q?XhtYxNUOoSe75ZbpASpkfZo7qoql4cgcPN+yW11CfYPe5JNUk0STp/wWTcuB?=
 =?us-ascii?Q?Watl+iJ/Bzy2Rj4P1tbKWvpVp8vvwDzx5nWe+ChkIIvCJHPpu0t7yXAW/NnC?=
 =?us-ascii?Q?VK+MhJHv/JCxYeIHe+rclIv/Q2yJ/l+lYmKwrXZ5IcUh79Rwqp6r2KiH0xBb?=
 =?us-ascii?Q?xKnIiajRP6ApXfcD/IyAFgyhbskFBCgIXHfF9vJLNQAix0U7s9zuKSfD2zn/?=
 =?us-ascii?Q?HCmRhgoMqu6wki7pH1w/I9XUouM1QV1Wcm6NtJM8tERs63wAjzugeo0l3TA/?=
 =?us-ascii?Q?3AC1lrX2KBvzzod8ewbjwOQ3DFr5SiLESCJdnmXsTIKWcBfwhbyiJYpJerjb?=
 =?us-ascii?Q?9cJb9fsa2e6i7xq4BHIgzcKHTREctrA86hNpYfat7aV/aoSeHmr4YBBAudTQ?=
 =?us-ascii?Q?eF/cCJ6NWQQI8a4afx1+ezwjPDvVYeSNdeVKTuWJ81rP5GwpaivLQpdnTHTt?=
 =?us-ascii?Q?1+J7g31QqLzXaYHrSUQnnPIlac9u2pDklasm8QRoeKzBYD1ThBGUliRX9+9Q?=
 =?us-ascii?Q?KffqgCosAv98JPG9AOCG21pypLiUvY5pvMNBasUCEcWlfCs6HNzEzCMlUW3d?=
 =?us-ascii?Q?1ptkGciqPo9dnqphk83UGkj0WDRGeVN+FetWb/5osegIWitt8scPX/InneP5?=
 =?us-ascii?Q?LgTHpXTWubGAwtaqO6ptFEXLC6TaitwefwnqcT4xez1iNs0WKRN8URLrSBnk?=
 =?us-ascii?Q?ko1CGcObeubdFbuGY5LRJqMu6aTPfgSyBEx4oWw0WmRt6gBLHbAG+kGZ+KOP?=
 =?us-ascii?Q?65ocsUHFSCHQ+NG6QR8hK1D90sH/DtJzHixiiOBFD4CntQybNIZ31V/V2Tak?=
 =?us-ascii?Q?G/TyL8c3Pt8o7XSBixC8N8dNSJDIP3w54+uyckFQYHsbumupBZiFehW0yu60?=
 =?us-ascii?Q?CK10QoHG53Uv0kqaxSxQ+mYnQ7k8q/AwEem2WN+XLkEjG1ExhoQtumxQ/NQg?=
 =?us-ascii?Q?tlW9CI5mpBEvHSSkqC48PP5BjpXX73lifxL+tULl9ikdRDhMm9w/P52GtQUK?=
 =?us-ascii?Q?I8SiGdxBlbGlG6bP+8yu/fUyn3usNRdq9rMYjXxTC/ae1S0ZAvLBuMk5bhDC?=
 =?us-ascii?Q?qkJAy8dlCU0fYaNE4Al1UVqB/ZR5yRRBcz5?=
X-Microsoft-Antispam-Message-Info: QcbrGyLmmY+iLyjRGyiXNvgHfXQpfcSMhcKoSJ8KpPQHmaRZcsPR+NVfU3nkoXskt498dh8IvNKrGHWn/5aH7Zb18N5/qup1UVFpyi+y0Hx2u2bKt/qC42aAEPsw0mIZMs91NsdPx4pqs+Gr8vOpAybLfNp7ePZcOVjbXQLY5wW1aE2ifl/cQtm4cdYpZH4Y
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;6:CLUhY8FTwIhi55/RgPv4OZ1hR0379BKysTDltakb6AnMtTleqpsObPPtdGS1WPZNR3i5qTAY2jiLETbVBX5LZ+fYZy6DSpuarna5eRba4vOwewm5ufqbSfKIxtyHWL6XiIRpWuHB2eCCe4oJUXWHoBSOkf6iQ6oawsuwDYrEQ+VLZCKIRVu85SBsSj3/2GxwfCBwbU181VMxHagl/H/44RDe1szzq1wbFlOj2sFN5KiIQ0S3Iu9nnKBvzdm/2RQlwMxpmBLQPkQkNFNpesqZ13Hq4/27m+cDGZzWYohhWf5S8I3NCrc8IL8h6/rTpxS5CgrDRN0A9FfntioAQtDl9Yem7kGwhgbmzm2fYIe1/A0=;5:XjeTK7uTWy6Ks8yKypuabf2EUOLcZpYmqfS+F3a4QxthE4vXic3SqbM11nTpIYSLJ/5rrijSdDZ2+Hbelf24aDj3tF2QgNThsMSRO6cY2HrwkD9GgkTDG5sYMZeXTW+H1N0DZH0HVbeaC1blMFw9dTcTa7yEEQNEVm3s5nSfPDM=;24:STGYLtgqYKptRnvNZW8kS/mgmpLQG9dar4X0PBOehVrS8OLJiHJ7qWPji7J175BgLsifc34hNeJl4n2uYvlCOE7KimKeiaooWB7toKVZucc=;7:29CCZpIwKsDS7G200bsZ2jgQdwX6L2oVOOsh63yATg/bxh9A6OsHJWf0uXHb1gHNEd8aqT228q01w5e7Wz1oEuekAI3lEnE+rkI7YmNPljWO2nsYLjAmfE5/2WNIdROQhB1Kqc7fye31nxBgafYdUMNHlcSmP2RGM4wFr4K8ifxE0nSuU4kPGD5bbc1wzBzFmIpGCDZzqmfq/4SgGh/NWGIE5BLuTegHZoswqw6tibUPhcDmKWCc6d9iWKxrydy9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;20:osExbvSXdRcmzjTagrUM74BM7iwHR2HghUIeAGwx53AcEz7RD669/mWcdpPzdyXvUqlYGP13kEzOanq+b/8c3oP4UeR+x6OSFlWO1wD+J3j01ZG/D/rRCfaf579IOIQ/D8fv/pbDz1wVt0A+22LH/35b1cX1VXAcHIp9maGkFv87KbZb5fFbvOoo5gsyeO4jG2BMfaD4MwYRPOdfMC69JqyyvZ9LeYWQbNUbj1iyggn+U0fECBuncYvtDIBcVXP8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 19:13:49.5390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4de25e-4d09-4d26-88cc-08d58f5fe0e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1913
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

It's possible that a system can be used without any DRAM populated on
one or more physical Dies on multi-die systems. Firmware will not
enable DRAM ECC on Dies without DRAM. Users will then see a message
about DRAM ECC disabled on those nodes without DRAM. However, DRAM ECC
may, in fact, be enabled on the other Dies that have DRAM.

Only print ECC enabled/disabled information for nodes that have at least
one enabled memory channel. A memory channel that is unused, i.e. has no
DRAM, should be seen as disabled. DRAM ECC information is not relevant
on nodes without DRAM.

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 329cb96f886f..af0ce9aa8d24 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3035,6 +3035,7 @@ static const char *ecc_msg =
 static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 {
 	bool nb_mce_en = false;
+	bool mc_en = true;
 	u8 ecc_en = 0, i;
 	u32 value;
 
@@ -3060,6 +3061,8 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 				ecc_en_mask |= BIT(i);
 		}
 
+		mc_en = !!umc_en_mask;
+
 		/* Check whether at least one UMC is enabled: */
 		if (umc_en_mask)
 			ecc_en = umc_en_mask == ecc_en_mask;
@@ -3079,14 +3082,19 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 				     MSR_IA32_MCG_CTL, nid);
 	}
 
-	amd64_info("Node %d: DRAM ECC %s.\n",
-		   nid, (ecc_en ? "enabled" : "disabled"));
+	/*
+	 * Only print ECC enabled/disabled messages for nodes with enabled
+	 * memory controllers.
+	 */
+	if (mc_en) {
+		amd64_info("Node %d: DRAM ECC %s.\n",
+			   nid, (ecc_en ? "enabled" : "disabled"));
 
-	if (!ecc_en || !nb_mce_en) {
-		amd64_info("%s", ecc_msg);
-		return false;
+		if (!ecc_en || !nb_mce_en)
+			amd64_info("%s", ecc_msg);
 	}
-	return true;
+
+	return ecc_en && nb_mce_en;
 }
 
 static inline void
-- 
2.14.1
