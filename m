Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeBEKrt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:47:49 -0500
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:30752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750949AbeBEKrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:47:42 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, alex.williamson@redhat.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu: Do not return error code for APIs with size_t return type
Date: Mon,  5 Feb 2018 05:45:53 -0500
Message-Id: <1517827553-81034-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: SG2PR06CA0108.apcprd06.prod.outlook.com (10.170.138.34) To
 BN6PR12MB1732.namprd12.prod.outlook.com (10.175.101.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f439c374-8209-4de8-c3e2-08d56c85e08c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1732;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1732;3:D9GsqmaUJYD91rFE8k9AJ4XwRXQ2u1CxmgIhdWL2/29kCmAj53YZ+e6eE/xOnTPq7SjIYVRi4z+XURmPcCrqs1cgh+EgECJQ8NpRcwTzbqtHpV1cTxoX/Eom9rJ6Gi4OxkNqyg0kgRkOAtW9cQyQlKWxa5G9RtMGkF1neTMKacgbNu30IPo0sr3VekDX784C4R+qkE/FVHX5Cw3i5o/iknwenJW/4+S00GbC7VLCxdCD33HR7/cDyE8qFsfTlA8S;25:rBek9XqygNS0GLSfmOOqOWofoIcg8Hps7jlHokx8SObYAI+PaJePfIbONCZN1pzjOG0x99kZ9U7dsVjRX84/5UIl4kwoJ7mPK+cGKi1O+sz11Cytp9VfrHs//7RFWYYzWchTS7AWZlSEqI4Klu3b+xpKuNgeOPedgAGS2Q1WSoofJvq/zqB+w1Y44SA6tzkrpNzavq4Bmae7Eyb8AcM2A0XuduBqC7C5GkOe9DzH/cMSV8QueqrIf9vSee/9X3FGKwga3wnXZadidlQOQ2TIE56WCe7Z2NTZDjExQt89WOusv2Le9i8TVbegbfE3PozRIY4ZtmkPzVTSIJ2MszZJ4A==;31:oD3lRtkqy8LXXPDs6VyNSs3Xu/iPGRNbFuJW4uJpIPQivGyov7+8CD6/2Qmpf5xziJWl4iXOW6BRf1jf9YvIoT4pVUCXAO+7GjXQVvW+BlVS6yZyOyqOK8Q8muJ4GKwIjSbK3e6DZ2rjX67fZEabvVvOYhJM6AnOl28OvlpyrYBkokyKvGzz+PzPVuHFVFpuCT5DIcqx5V52p0jhRr5cqXBRm1D6/cXqbPGuTsWn0bU=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1732:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1732;20:IhlcX3v6mYa3E21nzxdfhvntYpP+EEixzi0/QWkTXUHJJC8BYv/iHf2oUxr+4Gn7G4gmAS0pulfpaGlHsJJ8RVfa/gEDEL8IhZzkrYEoYZUc7YJgdKT/fZ2ykA7t9b4mVWUGZyd+4Kx5CEU2NiUP6BwA3XqrSXwVJZcnW0yytBFzSDq1FHUa8KR6ZBH2//GTf1MnVJD74HfCO9dEpjoWmL7+B2t8t9UJeYMIA1ryDTLW8OyoTv8ix49MP+jlgJg8JkuEOhj6a0vzEIUYO9Y86J0Ptxs217kku6naEMfRR6vBzIxWHy8n+eKRYPFq2oe50/EBEIvlU9KergTBYL6rtwPoBJPeLUymaaBHIMp68xTF/OtiJrwgy8ViPtIDXgFSJ1Su//8Bv8ZnisItKfsmUIgwODooQBcS5iPx/LIbA/R4HvVQ49UeYVjY2BZzS3H00Ex+4nP8Gls3A2yXk0W18jtJwEQ6SHn1230VmfdfGAjKaiSNfv0gQjeTkp/KTa7j;4:IIF7GCvJHLH2OmGY1OXf/PaF875N/1LsXFOJ/Jx+tsInlEs/jmT1Xj/DQOR883muXFccKqPT/2VcWiC+761R3P+xp+Jk9gbipb5MyXyrH8JZEnBVIj4wZALLpuZR70Q3oeNK43/yypD2TUVCuVVUqngmpTZGs0T43mjibsvpNzsW2zNei53xvnwTVVaKATXiX3MqPtZTezmrjST/rh/vE1ZcscZmxby8KxRBovgcyNWoWYcybqEzRSm/WaH6Dn19w0gYVleRD+EvCqbWKKel3na0nS1GJP/MlF0yaJAkDTaY6shaSVCPwvIbwtKJq5Mg
X-Microsoft-Antispam-PRVS: <BN6PR12MB1732F3306DACBAD410A9DDA8F3FE0@BN6PR12MB1732.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6055026)(6041288)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR12MB1732;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1732;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(376002)(396003)(346002)(189003)(199004)(6666003)(105586002)(6306002)(6512007)(6486002)(4720700003)(3846002)(6116002)(48376002)(36756003)(53936002)(47776003)(66066001)(86362001)(575784001)(50466002)(52116002)(386003)(6506007)(72206003)(25786009)(478600001)(51416003)(5660300001)(97736004)(1857600001)(59450400001)(4326008)(305945005)(7736002)(16526019)(26005)(186003)(50226002)(16586007)(316002)(68736007)(8936002)(8676002)(81166006)(81156014)(106356001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1732;H:ssuthiku-rhel74.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1732;23:Uzxn5Mgm9KdrP/TClN4OfcpYz7iv36Q0riGQvq7d/?=
 =?us-ascii?Q?i+QkhK0yf5MzAiNToCwFBIxSY//YCxa6ymFtNL42BugJWiRLjmMnUaOVh/WU?=
 =?us-ascii?Q?istH7eHxagyCGgzf2XOb1O2/gcLmHhNJXBkbdKIKeSBXs8/K2YvRDlkAqjgL?=
 =?us-ascii?Q?NyJJxfYul4y2gVeN7EefUNACuxcwh4NcE8UKfhsIwe6KsPKRtxhkYgcaTC0V?=
 =?us-ascii?Q?voqeGirAtw+74CDffTuq6jjm2LW+vsVi9DXpt6qQT4Le1qHJcsrd8fOb/Vls?=
 =?us-ascii?Q?jphfMonAh37Le2zKwiShHmuxBVOii4hdhl+FIOKhRqnJgBxhkne1wN0pjyft?=
 =?us-ascii?Q?m+Zoaenx1i0WrNKhBrKuSsNda4vSgoI29LEcaqqTxxPfPvgKGmJWtx9PlLMI?=
 =?us-ascii?Q?EEsvcrllxwqxjikgjoMlMGTAw/KnJR9HKv6ILzpYzp1t4C+H4Qpv0CkjWPwu?=
 =?us-ascii?Q?IvVBjbTLM37xHogYy5wOpf1sd45l9B7rO1HnCPp7k0ExTFGZLOekCHNE/8Qz?=
 =?us-ascii?Q?GU0Ca1tVR2FWf+0Cgw+5JoMWj536R/zTe4nkkUMs+iHcfmQZ3yqJgU+Nqv1r?=
 =?us-ascii?Q?y7VBLydeT8NgTz07XXpwkc6FFI4W4Breka80HVr4AlPCoclI+53rEEoUTj5U?=
 =?us-ascii?Q?bJUEqsOR4s9ro35QJ0wOkFu6n4dvE7rpcoISLqiU14PeSSquWqBye/sS+ccL?=
 =?us-ascii?Q?rqjJaWF07P+0yfW5EKLsCvsf9YTFU6Ts1dr7gwTSX3VxwRLIJu/fJPIwVSTz?=
 =?us-ascii?Q?72eCMvbKZ1f7rvM8yqAH6i9l8aT7bhp4zxxt+6ZOKoPQCbvKRPdgc7BGuAGq?=
 =?us-ascii?Q?7+8pVcnm/QzY5mzDKACdOiZt8zLu12I7ZctcAvBjtsfqkMdDHRJeh35MjV5h?=
 =?us-ascii?Q?T8/Rgj9ae/QstTvaB9r07ifPMKAnjuHL2M6WzbG4XYyMT8EXo1drgO+6WFE2?=
 =?us-ascii?Q?Z91Ghsr/xViVdGvM0LvS8WaPYhDNYcg9cl2tLs3ZQJ4M12on8angzhlTe+xZ?=
 =?us-ascii?Q?4QWRTGJ06kl84Mn2mepwXiHA3TWYKvDaHJfG9yoR60OYP7wFcaGXeqWRD/ML?=
 =?us-ascii?Q?VHaNHZsrVu76f+5lFGKj2E8mXYs3VggM3M6hioVcMdBgvy9Sc5J0eKUn2uji?=
 =?us-ascii?Q?1DXInkhphWtVi8B9rG7D1t2ow5sqFNuVdAaFsvY+xK3+zwaRE/vX/3CVXvL2?=
 =?us-ascii?Q?cHUukC+9VCjTh0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1732;6:J7W4k2AyM/mtueOtXjfpVmVMZE0ssTnSpdm9arbRPLxyEuAz8+gyi2ZUEkqA6/MJwvDFGusZ7BI6dVkFPctF4hVletvb4Gqgy7RnnSChZuz5D2tuaJfkRkc8uQkaaWXClXkrtQNNv3mMcaIhbGMNmfVpVQVhUisI7n7geF56c4xs45gaVaeJA+K1zX4vL/rJaBXQLrmgcOieQDVl0hEAAmMbH0uZfqDwp4Bg8yirjXFewkhIl0qjfJ+BG6GG27ZVSbmLdKnUE7gClKxvJ19IX+fp/W3fr1QxefGW4OriBE4MTf649zQqP2G8qi0PdfULiuU+O+X9o7ggiZb4flxLoueeIgzE6L01cWubhHNZnbg=;5:X5G4bLAT5SP8qFHP1l9z2bcqwG8cZADQwuhKy8O01QKyNHyGdWh3ZJ0p3SbsHXrZGa+Tc4v0iRfHnE4QJAOIdrWffqHigtJoAbwo0eJkeZ7wELdVWQZgtSjXzHA8hOaumT4rQr/1yEpKqKw3dkaq6ACVlnCE6smaZHG4Clr6fZg=;24:W56WihgeUwLhWTLKeIhW570BngbN+/X6sxbNhMGnRzhZ0xwvexb3iDwpclqRsrHdErBXwuMpXKkVle6sc5twqAcyTNlYcyOSCgTTCaHAWiE=;7:d28XVd7eTD5xgrVsG084N6G+4apyNM9+hcMCAOXk7wQwFzYZMZPZK0Zx9DRhR/rYggIDHVeFLX3/MkjH8+hJ8mlCzahUO9OjhArsCgmVsNZYWqGRWtk5GIX5DV9Ibuqt3AHYpmP7fCpI9s/AH3TFl7tkSmOnfMxvYHcLdxYnFUCsKO6Z5wv/UiZ2LNZmZDeqjZ1PwyDg3yPJCjE24ONAEUSRyO3XXPQ/FwhlEptwE4Bi7bIgsX35vGdjkWdrvZPc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1732;20:h8ugVNCIEGMeunYwm7bQeGAGjf87py3xNUFF55T6OxXH54g54F4hVjIsTmA/VR2v2rH0sG4Nkevevnz7kX5GayxSFvSbhz6yCuKzZh/Mh39VP/7+whvTGdiysS+8b5zu4O986b9d+aiUI25u4kcHOAWch4eCYFNV9RzoItKHZsiN4mvn668VtpbMvzPFOmXmcc3WBhr5Moz0UdrnB5LhF9fpJpkCnRUCAHR9hxIOiRiJUX823fCvI7PQGYCl26nH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 10:47:37.3085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f439c374-8209-4de8-c3e2-08d56c85e08c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1732
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, iommu_unmap, iommu_unmap_fast and iommu_map_sg return
size_t.  However, some of the return values are error codes (< 0),
which can be misinterpreted as large size. Therefore, returning size 0
instead to signify failure to map/unmap.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---

Note: This issue was previously discussed here (https://lkml.org/lkml/2018/1/30/873).

 drivers/iommu/amd_iommu.c |  2 +-
 drivers/iommu/iommu.c     |  6 +++---
 include/linux/iommu.h     | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7d5eb00..fed8059 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3037,7 +3037,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 	size_t unmap_size;
 
 	if (domain->mode == PAGE_MODE_NONE)
-		return -EINVAL;
+		return 0;
 
 	mutex_lock(&domain->api_lock);
 	unmap_size = iommu_unmap_page(domain, iova, page_size);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3de5c0b..dcd55fd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1568,10 +1568,10 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 
 	if (unlikely(ops->unmap == NULL ||
 		     domain->pgsize_bitmap == 0UL))
-		return -ENODEV;
+		return 0;
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
-		return -EINVAL;
+		return 0;
 
 	/* find out the minimum page size supported */
 	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
@@ -1584,7 +1584,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	if (!IS_ALIGNED(iova | size, min_pagesz)) {
 		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
 		       iova, size, min_pagesz);
-		return -EINVAL;
+		return 0;
 	}
 
 	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 41b8c57..19938ee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -465,23 +465,23 @@ static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
-static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			      size_t size)
+static inline size_t iommu_unmap(struct iommu_domain *domain,
+				 unsigned long iova, size_t size)
 {
-	return -ENODEV;
+	return 0;
 }
 
-static inline int iommu_unmap_fast(struct iommu_domain *domain, unsigned long iova,
-				   int gfp_order)
+static inline size_t iommu_unmap_fast(struct iommu_domain *domain,
+				      unsigned long iova, int gfp_order)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline size_t iommu_map_sg(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
-- 
1.8.3.1
