Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeAaBsq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:48:46 -0500
Received: from mail-by2nam01on0060.outbound.protection.outlook.com ([104.47.34.60]:51968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752530AbeAaBsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:48:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, alex.williamson@redhat.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/2] iommu: Fix iommu_unmap and iommu_unmap_fast return type
Date: Tue, 30 Jan 2018 20:48:04 -0500
Message-Id: <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: SG2PR06CA0102.apcprd06.prod.outlook.com (10.170.138.28) To
 MWHPR12MB1742.namprd12.prod.outlook.com (10.175.55.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71fa8fc9-8d27-44ed-43ff-08d5684cbf06
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1742;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;3:XSjKMPaoTOAkh+T+Wwn2/JgaZ8yp1lyxeW/nNBqatKoNfuxJ1xk2QXPm3sjGpK2wk0RRGdHkcYLqCYg9D1JaSrIY/Kjz3Vhhu9me4Ok/qMzPDl3j/+uwhXrJNqH7nG7FFvz3z6iqXTHDGuZ70pRFQP0368xCo0gw9RFS1GsqngcIpKVYj3x11oZiRlsahoIOYc+aGAOVbwvOZuG0eoYq8195IRO4LdW/DqSXPg0J0MfNezMFpxALQGfXVbmjYZy/;25:do4cciu+noho3luz/apzO2SLrwUxMtU1mpvB8RCy4apqEKrylYBY2kRkkesHeB2PKCpHec2yEt5M6CnkE4xGEi8GJYDdn2DcoSuN+Qo+1PKF1AkSWR5Ws2c+gHqtivhEPE0BQ7+CM5/M4wfhYNJnpFHi9Q4NKUZhUCjhhgkYyjSR9DA5UUZkz4NpQwAXtHymTl79qzF+vTkgYZld/JBoO53zZqwhDNydgw+Z7lRtHn2fy/uYK+OBy6ZVjSq8kUhGz6kZ2H64D/dxb0/VMIbyoi5on8Qp1X3bXY0pGSKnMfmRLi8WeJ0xKwWzHGT2sy3poifogiM1EOGemO7/cE8fug==;31:vZxwuK66h8UMI1YgM9RPPUG9AiYJB0z4PNbgDmbtfCzXAcInswnD8y01QTHEgHxIOKIJQud+Uokn91rkDkNyot3u3vNE6xfd5ZKF8/Bhde9aVlau2ankhzPwe/qrVvVIzYWciStsJ3XQ2FO3XiHwfAy7YN/0UR6c4gAUNyb9k2dBELwWonPReofz9dL4k2RNfSxEm7uzPvXPMT215X1snV7qYWq+0QSibKGp1v3b91Y=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1742:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;20:rjRr++I8viiMxA5VLsFJJVjt9rvL+axr8d/PL2jMDIAbuw4WTBtppReiUaWg1mT+WK/6c2Prg07PuUxEHNBwAkxfE9raPI+ZroNdJB2bFXXmAi9z7vsyHbwytjyJcVV8AENjNIGF3fywyML04n/Yd/UrWv7uK1Z+OcWX2jN9ZxSpg/PWmK5E9wQnGVvNIY2WMr0QfI0oxSqQq7rZr5BVwtwlXO2Gp2+E4N2UuITAECDNFoMPmd+qqT5q/pNQNrsGRTpKOmtKhRwTp6NEGP+skNEmekl67zV1O24zxkf5PJnjvpC8rvkEQUtuRibe/Wl1kage0Cg/RtrZlDZdb6n1vOSdfmjdtACXSsMZCk4syS69rRva4t7sFlGkYj2DnGh27H22xn9lmnY6C7k33MeQsFSFU5pGc79AJxEEper1O05l+aORRpzCqShO76buzv5HwF3ZYKBUR75xInEUPYJKrqbweL1cpi6AgisHxX4taPlFCcf6sqPXTrg34J+F88H9;4:i0kzpOMsa8elxFlgc9H/Wb9xEeJ9QmJIUKhFB7j1EMlPrWHxz6EkOBo78++4U/myuAyv2pHYSWIGLyYNgIwsWj2tmyX/rM656Cyl+/orfD8neKBQ1UBtpA1jrFW+eSYrJmUWpCH7XdgI3HPqGLOgLESFh8R/e22TGfhV6w8NV0O1XnKNCYxqxq40kv0SgvWWKrJ5ikvMDGgCAUAU8yoCTFgm04xWis1Z3Nrshy0zM2zWE8KXDDfxt3X0LkR9Ts86i5Ymfg6tHvK0BTe+WG8NM1w9axCLIH2MF8EoXwpLHK3R63Mnwc2IbcS0LtzR1t9I
X-Microsoft-Antispam-PRVS: <MWHPR12MB174242B8544D8632E02D8DAAF3FB0@MWHPR12MB1742.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1742;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1742;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(39380400002)(366004)(189003)(199004)(106356001)(53936002)(575784001)(6666003)(86362001)(2950100002)(4326008)(25786009)(66066001)(2906002)(68736007)(4720700003)(26005)(52116002)(6506007)(316002)(59450400001)(47776003)(386003)(6486002)(3846002)(48376002)(305945005)(478600001)(36756003)(50226002)(97736004)(105586002)(76176011)(51416003)(50466002)(72206003)(186003)(7736002)(16586007)(5660300001)(8676002)(16526019)(6116002)(6512007)(8936002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1742;H:ssuthiku-rhel74.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1742;23:fvyfXNlphWU9NLu5Y/NSyBNw30P1WAew2XgBRvqei?=
 =?us-ascii?Q?K00nlwvegCStbWi9LgsSD/QlbRRIhpgxE4IOMT3h+EFiH5Bv25o/M3vUyO5O?=
 =?us-ascii?Q?9is0CZ6Q0joylX6K66h2v9ig/rhS4rX5/cHfcnoknkRp+GjrgrHnR2QOrwRK?=
 =?us-ascii?Q?kenGNIDGvO2RPn+TnNID6tT852eujccgBAHX9u6aMmsWicQOxrf/gY+EIUQf?=
 =?us-ascii?Q?LQs+RbNkMK/bD95bFcPvTw9EJ2tM2sgZ00etN9GDmg6Q6azEBfaaLapDpW5d?=
 =?us-ascii?Q?8cSpNbUSq7/9lzQxccc8+7rLpuM+/pICouDNHAkvH5qYWKZKPqQrZdxZbNW0?=
 =?us-ascii?Q?3Wa0Dm4d/n+ddrn1/8nrRJvoNgERYiv+g6fQuOqErWEDGQsig2gtsR08PUiH?=
 =?us-ascii?Q?vmZNdHZkbDNmdVn/I9JkOB8RXt2LHzecq8gH/xN2XZMWNp25aw3V1veISqjy?=
 =?us-ascii?Q?Gx83TH/8ukeKYvQTKK2phy2W/llqbqSdNNrWJxvlFZcCxzTeXbLazrMk/Avu?=
 =?us-ascii?Q?bVi69x39O3lc/knW3Yk63ZdFlA98cANiZyizPr0e6DhXWRFYn9V1buz/yr6o?=
 =?us-ascii?Q?T6XhFEAJ/uL6tB4ETq2uWOUJca9izWb0txaJgmZ8FlZ+rwbPxVaHZCXZohRX?=
 =?us-ascii?Q?YmOtauxwGWSnZqm1DSDaUCgN6QtybLsjFp45ItEZuiIHZAi5aVSkc1HDMp55?=
 =?us-ascii?Q?b3auLaRl+B/W9ZATjeQbAeH0p2oREea5up5YA679IWm3Z8AOdIr0voBfftlX?=
 =?us-ascii?Q?n6wFdu2YpZvPy2qEtd1E9+sPJkVAkSXrEvdRnjEgQO+yQ/+TUmiPA68auLCg?=
 =?us-ascii?Q?8aiVODePV1QlK+E3sCejGgfVWHm8bs68Mt8WB9fYKpWi3qo3BTUSodCBczvd?=
 =?us-ascii?Q?MuGNQZA7M4fS5MDvh9+3MIANNNCP+WBZmCcfPCjZ0GlkE+8D4OvHzB7bY9cB?=
 =?us-ascii?Q?Fgik25EkZovoj3irh728cE+rLxig9VY5WdCBR1L5d3Uy1qCEX9hTGSvCpOqF?=
 =?us-ascii?Q?PXG1Dhwpcf1JYlBW84A9hk2Ua88XQraUBFhxJQ9x3LUQJta3FpPEdRNvs8+6?=
 =?us-ascii?Q?cSC2AtdAFTbRM6Yn97M14mzXEC0Cg7o9V6G46DTMiuDZyqtZfJ3gXUrqSrZX?=
 =?us-ascii?Q?A8KmUw62xjdPc9n2s6bUN7rUzd128h3hP6zbjMWW1aOTVd/NwKy6G3EwDfV9?=
 =?us-ascii?Q?tOfnHlfazSboKE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;6:yDg4OKaFD3oxVfrZ9GfkW7qW6Ur9TUNRwLA9VPq0kaCsdie97D6Cmqa61x1nbKColO3UvoD96HN1MDCGAd4okG7EQiLVlfOAo7sSRaGP53t4OqW4Tg9Zg1BSMyMlAA3VWa3juQZER5m4SOsw3TSTUUQE6iw9uxtsm46VrHu1FuUo0shTS2VLJOR2jqr9H6PxVDV/W93H2ztWBYvOL+cREchyt6Vy8+sm5nY8GtwPJK21SGMjMcZAHlHibI42NE/d+rrozh2vbghS3ZIXyq1qo6ATf+wksJcRVYUeRRhbmC+YFh/uSCySwrW31h/iAMZ3vFbu/Vs/5EIV4bnL30OmtavSElwv1wP/5i5KpuuudJk=;5:sgzJym0ZRw3Ae+ftowifQRR9Sv/Rr1emKBEw/5wk+It5SoM045c62PdF61txOR6J2H5kjsVz7QV//ubZNCxIn8NpW//U4IWeZlhGhJHwzpL5HO3EdZNBanqX/4smznBtVe5mGJAffnSEK/AnP+7RWBbzRgZtiOqrwwxdo1PVXUY=;24:adyE7fDHjiHGIDIVt+To3gvD6fHMG11SwwPx/wyqvW8ThPqRlGpxzs1MMh9OYkxW3W6n343UnqZTVoNjZcuw48H4dkJA/wgnzF52wH1REKM=;7:AjS4NrX292ggbv37Q1gs620Y7XYhwEb+8sP76ZjpoYevrbGcTWIE3AR1nMxDBlrtswXWFeO3gBvsGEolIdmb0Piov4tzOqbeiKikt9tl/69lflHXYYOuyJFoRPSo92d5w+C23LTEZ8ayRFexwH7oVou2apu24Ut7+y39VMRwa8fUeMzCkg87rUgLvkI9LUAEQ2yJNKhurm0goNKmsVWWVSTqKBLkkPhGI7FB4fdZRtN3eCDM6tio+N4oCmunopZf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;20:4f3ROStoORVjCaMmp6x8K4B+vGydSVKvB+j0pKGST4Ix0FfsZfHL7aB/n6DP9e1FITnWbDq/e1ng8iCBgs4lKjLenpPrDF9aFzd4ajcQGWvKe/I5wyO7JRW8mcGIEwJAe4FWM8j3nuEuUN3SOX1VRE1kpF7zdy9K0NOOZc/P0Kc/4ewLHgovfwFaO/ZBt6VvpB3nJdbmF+FF21pS2ifoyFVVLQVULtkwSC56UulM5VCvFEQmSx8oUG9fo0iihCZD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 01:48:35.3986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fa8fc9-8d27-44ed-43ff-08d5684cbf06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1742
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, iommu_unmap and iommu_unmap_fast return unmapped
pages with size_t.  However, the actual value returned could
be error codes (< 0), which can be misinterpreted as large
number of unmapped pages. Therefore, change the return type to ssize_t.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c   |  6 +++---
 drivers/iommu/intel-iommu.c |  4 ++--
 drivers/iommu/iommu.c       | 16 ++++++++--------
 include/linux/iommu.h       | 20 ++++++++++----------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7d5eb00..3609f51 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3030,11 +3030,11 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	return ret;
 }
 
-static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
-			   size_t page_size)
+static ssize_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
+			       size_t page_size)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	size_t unmap_size;
+	ssize_t unmap_size;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return -EINVAL;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4a2de34..15ba866 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5068,8 +5068,8 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	return ret;
 }
 
-static size_t intel_iommu_unmap(struct iommu_domain *domain,
-				unsigned long iova, size_t size)
+static ssize_t intel_iommu_unmap(struct iommu_domain *domain,
+				 unsigned long iova, size_t size)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct page *freelist = NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3de5c0b..8f7da8a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1557,12 +1557,12 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map);
 
-static size_t __iommu_unmap(struct iommu_domain *domain,
-			    unsigned long iova, size_t size,
-			    bool sync)
+static ssize_t __iommu_unmap(struct iommu_domain *domain,
+			     unsigned long iova, size_t size,
+			     bool sync)
 {
 	const struct iommu_ops *ops = domain->ops;
-	size_t unmapped_page, unmapped = 0;
+	ssize_t unmapped_page, unmapped = 0;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 
@@ -1617,15 +1617,15 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	return unmapped;
 }
 
-size_t iommu_unmap(struct iommu_domain *domain,
-		   unsigned long iova, size_t size)
+ssize_t iommu_unmap(struct iommu_domain *domain,
+		    unsigned long iova, size_t size)
 {
 	return __iommu_unmap(domain, iova, size, true);
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
-size_t iommu_unmap_fast(struct iommu_domain *domain,
-			unsigned long iova, size_t size)
+ssize_t iommu_unmap_fast(struct iommu_domain *domain,
+			 unsigned long iova, size_t size)
 {
 	return __iommu_unmap(domain, iova, size, false);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 41b8c57..78df048 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -199,8 +199,8 @@ struct iommu_ops {
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
-	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-		     size_t size);
+	ssize_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
+			 size_t size);
 	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
 			 struct scatterlist *sg, unsigned int nents, int prot);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
@@ -299,10 +299,10 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
-extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			  size_t size);
-extern size_t iommu_unmap_fast(struct iommu_domain *domain,
-			       unsigned long iova, size_t size);
+extern ssize_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
+			   size_t size);
+extern ssize_t iommu_unmap_fast(struct iommu_domain *domain,
+				unsigned long iova, size_t size);
 extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 				struct scatterlist *sg,unsigned int nents,
 				int prot);
@@ -465,14 +465,14 @@ static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
-static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			      size_t size)
+static inline ssize_t iommu_unmap(struct iommu_domain *domain,
+				  unsigned long iova, size_t size)
 {
 	return -ENODEV;
 }
 
-static inline int iommu_unmap_fast(struct iommu_domain *domain, unsigned long iova,
-				   int gfp_order)
+static inline ssize_t iommu_unmap_fast(struct iommu_domain *domain,
+				       unsigned long iova, int gfp_order)
 {
 	return -ENODEV;
 }
-- 
1.8.3.1
