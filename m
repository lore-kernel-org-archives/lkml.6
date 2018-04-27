Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZpvuSqPdaCyeqjXrmUOmQpHwN4s71WeEEbmdvSdJYfBrvMRytYMPkC2sTl0nunDaGU7AY4p
ARC-Seal: i=1; a=rsa-sha256; t=1524824877; cv=none;
        d=google.com; s=arc-20160816;
        b=yhRShTZ/Ohl47M58Uh9PQ4GFYJ2KpLSCPsbr5t+Bsp5/89RB0VeIAq81ZCwhkGSbV+
         02CngPho3qa044EryxJbTOjTx6Zcs4TUbK4MepfnEe3WNVy7rzTDG+7hFUHMVGUP5usF
         6nSixcL4c627iRLIC0G8UQr5UDCLVG89NWC9Y/TRYQZbt0if5DViz1size3h8t2tp7Yh
         N1DsDZTIfV4NbFCl92j7w83mm/974r1iMw4y1LsAECJO1gsFgyJeX+n38pY+J/aGbVLa
         t/bbXpCNMRWlBEjouPtXEic8OaMXQArhSz6QNBY7Z+iMz039xQ4jTukUYs1KnY6iHzFV
         t6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=YMZrbSRbQfXV44X7sdVh+KAResH3moFpT9Jly2tBDH8=;
        b=cDKJMHZ9jEryWoW5A8JWyP0IFDa64OtAGd86nYaDvrCAKF8Gh15MK16iojlKvDoUHH
         1eKGDvXNMRDDn/Yw8eWOdaI0AIgxSCs2LsyvneNRjeEEphsSAGdFYpJ1oJYdtHR0Sw2u
         6rp5BbAIrxb506q8g0m19DfvvmSYOlw2acg2dBnFSfMVnNFh6iGsqomk/02cgmY0Qgwb
         47C7wt7Gt1jKY4kgo05SIO3Dj8nJWNr92EuZF2MA+6u0WyJefzrvplFB84LH3BEaoLaM
         qqPrtP6OOtdG/dmRpDXNc47yjjWV+1ZZXzPqAlQOfW1DGvZ7FLuT3JV4Y1Q9BcdGXnYu
         xIsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=U5zmdw0V;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.43 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=U5zmdw0V;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.43 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: hch@lst.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	robh+dt@kernel.org,
	m.szyprowski@samsung.com,
	shawnguo@kernel.org,
	frowand.list@gmail.com,
	bhelgaas@google.com,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for other devices too
Date: Fri, 27 Apr 2018 15:57:02 +0530
Message-Id: <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12)
 To DB6PR0401MB2422.eurprd04.prod.outlook.com (2603:10a6:4:4a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2422;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;3:PSSHnKMrgxNaw68Wi9PES4ZXSWvF5+Sf3tVgb8z+S7MFvDDcwKIq7anT3efKdlCtZZOc6wEry5BsqcTdOnqhvqwafYlUXS+5jWCBh/+qK9drr+b9CNVmf9v+SVT1OumQUFkOlUPz/6fqCGR1q4RmRwod2OSCXGmkKkJBlJxqDxWqNHbVnoqhXpX4bRCdXtEBF1cwfswXodtbfxAxtVPnu6KVdkoVWFtQXw7nIOpY+pZOgbUsxAiqijULxN85gIW4;25:ONUivb1OaoGJWhKvrIVzcsqeAnznEgJs+pOqEvLyvJloEs9fWYKMlz2WhPFbOi6qAV9lqD/Y0lk2jpXeNROTusL2g5cpCq+3BIHfGOmkxRDDQ1dfsrCJpJ6nb7BMJmW0QYmMocfmuMb8+CeYjtlVBMNdCmNr39uQvrlGJme0kzfb8mmlE47lfKBSJqbccxen0ynNvGrcvxa2u564oL5fikaPgw3ittDN1n7o2/uiy7gzCIWLzgHtrK7hV/P6vQ9NgN+JvgQt/GWJL50Rb+JAL1JFqwYqaHhikAfUzQqPVZtR3qzFjFundFy6sWSulP8l28kMM4wv/TujRLnQcc6+cg==;31:HlDVVTUZ3Zsoa8NKvYtosPY54uK7VkgKH3xyGR0WIolPlZ4BsMS4WtBpmiaZ9Ao+0sTqRIb+P3Jv7CPrdGAi4NZLbFUZjvZocNLpk7UYYoHl5yNbfmflqtCbL+kWSEdTQzWFe43Jv7DWlfpvXhrC1QqHi9Pea28iV0yyk8IKopUQxwv5zoxsauLBOAybDRMk1uThD+GxXMSm8ZARo15zDGNJpuA34Bf2AiqXyxlHUlk=
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2422:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;20:kAimR9wxHgkxlNOk5fk3ag77/mqH64prg8MwEtuc8vGh3pVvretMfCIAro/b0ZESx2Upl0KzrLJkmwt3+lk4ej+mKK8vW6lxTEqfGdwtEXy4Qnax0IVTp+DqD6O/QNKASRhN4yfSluS3ocbzPWz1BHZCRzl9e1qcPjR/jLHA7PUyv7hCxS6ygrOighJSz8GS2fH5LSS6WxML/Uqxg+huou3moHG2Ayac9R0rleBO9KCIJdTT/UHJH3ovEA2PnfyZW8JhpX8EeRNyZw/jp9Bfm6bGoxpcEdDIAR8T8+WUG3W4oRnngpusWRvCIHa628m5v+pUUcGy/upq2BXWh/9CRgQWWXyfbsma91PFkoap7dqMnSNgb6VQe8owdBCvVXsomS8AzWbrk8h0Y0ftmJeJLPRF0TG8rTPoVQW/WWTlhcvoZeGOhQI8Vf1+5CF5WzLcw5T0DeXHhD9TupXay+LaYKFQ3O3n8cI+dhDeoXlkv00SSJmiikIT50IQlZ2JR03T;4:lwTHqbHAuSYagtFWO7KuOuxHcofn5LKlDzA2ERAVm063PxE+1VhT6YbmpL+RLfGpyXL6jFBlqlZdnAyM/dPHaWo8gZH5nl+Pi54UJ8e+kyzOwHJI8JnxgtQLCQ1ZzEGWi7hO/aWv0MADIpCIb5lAQcBlUTpUH3br1heMkroy2+eRNYbzm8JuFWjeCH3m70+UsZAx1jFWYVfiM8PDwjOjI4gLuDMTG+fmTW/555xCu0Nz6+Nu+5I0hEwmFwy/FzlrJ4XI0LD493z8ulZDSIXYs4zQD8eHLN4DjGU4pZTx7m4GFgYdMY3STp2P35x7uHmd
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2422202E58B37324742AB2B2E68D0@DB6PR0401MB2422.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0401MB2422;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2422;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(2906002)(86362001)(8936002)(6116002)(3846002)(53936002)(25786009)(5009440100003)(305945005)(48376002)(6512007)(6666003)(6486002)(4326008)(39060400002)(16526019)(186003)(478600001)(76176011)(52116002)(7416002)(44832011)(26005)(105586002)(2616005)(36756003)(8676002)(81156014)(16586007)(486006)(66066001)(11346002)(50466002)(51416003)(446003)(956004)(97736004)(106356001)(386003)(68736007)(81166006)(5660300001)(47776003)(55236004)(476003)(50226002)(6506007)(7736002)(316002)(59450400001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2422;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0401MB2422;23:28ySusedFmYrEX+KNPw9ewJoPDQvuot5xPnNyBK?=
 =?us-ascii?Q?B6htemXgt9ZBuN5n0ZUOc4S9r3pc8ZY4oJVk16eq6OcdDlDS0X/K3ZLkytC6?=
 =?us-ascii?Q?5t0Va/Ivlg0H44atULAtOI06QUiB5oWqryY+UPQDbARu/kwfcrAIoczczcPC?=
 =?us-ascii?Q?IPr0ZO54l3iVVyS1d9y2sYdzcS8Daqyru78foD0aV3Z+p+sWP77sA2I3ACVd?=
 =?us-ascii?Q?/zFNPcH32QTN0BBya9GCCPXNUN9WT2ERXB8MTxqpL6WoBirTcatTe2tCbFCL?=
 =?us-ascii?Q?rDSUOFqKV7QZ8PoMm9GYKzItsp1vykQnbOPn3Q/B9TvOztmsM2Aq4fg8tnhT?=
 =?us-ascii?Q?6XaKYF6sLmhMgZLpNvhYZ6YAIKQnaeFZOe9ejob2hjzSVmWkIJ5JiAigCKYu?=
 =?us-ascii?Q?F5IU+HEurjtgPJr4mmXRjmEvE+OZQLj6kYthHmEQMrmfb1PmMo/P9BU4igVa?=
 =?us-ascii?Q?0c+o5D+cXaN3wnezXrBP1LPVLe4BAZZf4qgq/nEndTbsHnN3rvC3z5kWz/2B?=
 =?us-ascii?Q?I7IY5e6bzUw3NefP/L8UuZ0+Gox2fUeJ3Yrz0deZqKSPFrxQcFwB4MtZWCzF?=
 =?us-ascii?Q?hGhog4t/VapLROkiuL4g3iL+NSEf76MBJuuVWf/TK7pUvX4RgBuGoVBF3kB9?=
 =?us-ascii?Q?09kjtCj/xCY1o3tyBhDZYE8zssx37fv6xtRqO3h9uaxckYdH2Af/0uT3r3MX?=
 =?us-ascii?Q?uNACV/4t5NIE3TZo0HMRd78hgsI4ai/7/ICYSliIrzRKz6sI7SIB0rRV+jMr?=
 =?us-ascii?Q?z/BOwCoKTSQk9+NTVyLrCz+aou+d/C8eVH5z/pseYvGHKDzZgteDhd1xqoID?=
 =?us-ascii?Q?lLBjc69d4e+5YUF9C8jPVOtMHwigqtze4jUt2WjjcDoeILMZ9iovc/V9PkKb?=
 =?us-ascii?Q?DCgockksA+OEdjgmbSnaZNqo5+fDJdpEJTSr8IVGlo05GVWTotA25Lpdwh39?=
 =?us-ascii?Q?DsDsgsAx/dCGICt1WJbGJK6gyvJZrAdtozuAxEs8bRkonNg10vKLH2++qktU?=
 =?us-ascii?Q?2LzOFnPSI6bVDv2oGsmmEKS0elkin6onRgqhEfKxSGFXBMuG0wzhJxqNwrd7?=
 =?us-ascii?Q?tdE04qc8V0LxXWvpZ/lDiW96JgWKriAMLiS4AD/QKVWYX00KJZJcQNuz6Rx+?=
 =?us-ascii?Q?v9FtgSPn22HKSGobBPJiFHPs6leUYamralyrs0gqbuS/8O4HihOALM+Onpwb?=
 =?us-ascii?Q?FohVAZw1yCOw2z8s9W2eF1XW9Y+9Fq5MLTpRD/9vb8T4dZezvW10oa5nioST?=
 =?us-ascii?Q?ecB9Tu3GFEIe6BKpNEAZzsKni0felByiG915wOmeahldAJOwQ44rzKxbaJpV?=
 =?us-ascii?Q?jYbFfDIRcrO+bJXFMCz49LGk9fpz/xowCpD57lJW1ygTH?=
X-Microsoft-Antispam-Message-Info: qxllbB23jUm7/zsPl6wPohSGvQGZlMvb4iEDk0ucfo6LsktAr7Oq0kspl+pffBSjnYSTzXQp6Kb4YJ1wuzvlBblAduYdlXDIbHXb72QxoXQHi8vk8wYti49QFIYs97nmIYiEyWZUe9Kh2OI8cDM/xWsuqKBJMwBSF/RuZbiAjKS/deLfBkFmw3kRV4e+N3Z7
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;6:EY3lFHu7Vphmx6v1++fJIVdVx6nKxrq83mNDLWyyqU4NXplCHOQWrEmxhV8H8McsBStP1R7EDVhkgNAXx85u7/23AFc/tGuV+EorOzypTtEbHD2LU7+//UiUOA1ypyF8cCoxvbRbZcMtgpWl6/TAFidshML7V/vAdcuNe7gu+31bDwrE+vfR6z7tDIYhJTPP8HX4hOGW6DdDGepakHKfwPDYYngi4ng+7dM93l7F8+pXaSiJFTQC/KXp6FEJj0hU2y/2WzeamwEES8lCuJaHdpwBjzF0nbLLu/vHSH3jkPfL1+PLB8WFcmQVwwZ2HP3wGxrCgRHInKaLxUqtX2rrZ0qKvW+E7pgwCwLTbO4n2dby1/TYQ7X918jUFNY9g+f/PYVAGHkfOmk2EN4yJ5EGAMa5zYF4K8OKuFrreaQrSebsrWpdhteJPMwmsPWE66XE/wHm/+2apbMM/d5hArNsRA==;5:ZVf5KeUg+JzMTlcGYn60H5FPRgvYOFHRpiNgJ7IzD7PsAGMW8ysAMzsaQoKPfL7eb64+aGWdDqa5zd3tj3nF2gMnpJJ3xtZK6yJ9KeSQ65IcdS+yWCxBePWvtetOBvaVrUluVf5DoMVacwy+tfpo+WMFUpzsGMuzoedjOh/Qhuw=;24:ahO2Hl6P7GZ4ti74v7AYk6yBepTgOiK6bJkkSl92rAOeCAeqD5Gu9aop1f4F893TCpb7hzfNpCcG1Kk1lbzQEange97iF1YBHH1zSlgLMB8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;7:JUWY14DVyiGi0Exr0aMZUm2RMO0zizfWCnMSjE7CeXtHwTBVWr0I60rOVdGKD4klcTZmE3u8IRijn2hOok+yEdkrj+DJtvI20L50rioTCGCzZF6PwKkDJLQVLkda3Bqq7IfUGL5M18tAG5pN0uFvbHDM4uHT7d93/xYlEKm/v7618munK4SNQFAiLlrQ+1WqhOAW056+C1o/ZlIwZlYXkj09ZarFMW57iIoFbgDYc0e6lFnM+Rx24TUR5R52X1dn
X-MS-Office365-Filtering-Correlation-Id: 0560d9ea-329c-4135-859f-08d5ac29892a
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 10:27:49.9257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0560d9ea-329c-4135-859f-08d5ac29892a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2422
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894771028861343?=
X-GMAIL-MSGID: =?utf-8?q?1598894771028861343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

iommu-map property is also used by devices with fsl-mc. This
patch moves the of_pci_map_rid to generic location, so that it
can be used by other busses too.

'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
functional change done in the API.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c   |   6 +--
 drivers/of/address.c       | 102 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/irq.c           |   7 ++--
 drivers/pci/of.c           | 101 --------------------------------------------
 include/linux/of_address.h |  11 +++++
 include/linux/of_pci.h     |  10 -----
 6 files changed, 120 insertions(+), 117 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..ea9ecef 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -21,6 +21,7 @@
 #include <linux/iommu.h>
 #include <linux/limits.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
@@ -149,9 +150,8 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_pci_map_rid(info->np, alias, "iommu-map",
-			     "iommu-map-mask", &iommu_spec.np,
-			     iommu_spec.args);
+	err = of_map_rid(info->np, alias, "iommu-map", "iommu-map-mask",
+			 &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 5334991..4163f24 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -985,3 +985,105 @@ bool of_dma_is_coherent(struct device_node *np)
 	return false;
 }
 EXPORT_SYMBOL_GPL(of_dma_is_coherent);
+
+/**
+ * of_map_rid - Translate a requester ID through a downstream mapping.
+ * @np: root complex device node.
+ * @rid: device requester ID to map.
+ * @map_name: property name of the map to use.
+ * @map_mask_name: optional property name of the mask to use.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Given a device requester ID, look up the appropriate implementation-defined
+ * platform ID and/or the target device which receives transactions on that
+ * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
+ * @id_out may be NULL if only the other is required. If @target points to
+ * a non-NULL device node pointer, only entries targeting that node will be
+ * matched; if it points to a NULL value, it will receive the device node of
+ * the first matching target phandle, with a reference held.
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out)
+{
+	u32 map_mask, masked_rid;
+	int map_len;
+	const __be32 *map = NULL;
+
+	if (!np || !map_name || (!target && !id_out))
+		return -EINVAL;
+
+	map = of_get_property(np, map_name, &map_len);
+	if (!map) {
+		if (target)
+			return -ENODEV;
+		/* Otherwise, no map implies no translation */
+		*id_out = rid;
+		return 0;
+	}
+
+	if (!map_len || map_len % (4 * sizeof(*map))) {
+		pr_err("%pOF: Error: Bad %s length: %d\n", np,
+			map_name, map_len);
+		return -EINVAL;
+	}
+
+	/* The default is to select all bits. */
+	map_mask = 0xffffffff;
+
+	/*
+	 * Can be overridden by "{iommu,msi}-map-mask" property.
+	 * If of_property_read_u32() fails, the default is used.
+	 */
+	if (map_mask_name)
+		of_property_read_u32(np, map_mask_name, &map_mask);
+
+	masked_rid = map_mask & rid;
+	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
+		struct device_node *phandle_node;
+		u32 rid_base = be32_to_cpup(map + 0);
+		u32 phandle = be32_to_cpup(map + 1);
+		u32 out_base = be32_to_cpup(map + 2);
+		u32 rid_len = be32_to_cpup(map + 3);
+
+		if (rid_base & ~map_mask) {
+			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+				np, map_name, map_name,
+				map_mask, rid_base);
+			return -EFAULT;
+		}
+
+		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+			continue;
+
+		phandle_node = of_find_node_by_phandle(phandle);
+		if (!phandle_node)
+			return -ENODEV;
+
+		if (target) {
+			if (*target)
+				of_node_put(phandle_node);
+			else
+				*target = phandle_node;
+
+			if (*target != phandle_node)
+				continue;
+		}
+
+		if (id_out)
+			*id_out = masked_rid - rid_base + out_base;
+
+		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
+			np, map_name, map_mask, rid_base, out_base,
+			rid_len, rid, masked_rid - rid_base + out_base);
+		return 0;
+	}
+
+	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
+		np, map_name, rid, target && *target ? *target : NULL);
+	return -EFAULT;
+}
+EXPORT_SYMBOL_GPL(of_map_rid);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 02ad93a..e9ebe1e 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -21,8 +21,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_pci.h>
+#include <linux/of_iommu.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -588,8 +589,8 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
 	 * "msi-map" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
-		if (!of_pci_map_rid(parent_dev->of_node, rid_in, "msi-map",
-				    "msi-map-mask", np, &rid_out))
+		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
+				"msi-map-mask", np, &rid_out))
 			break;
 	return rid_out;
 }
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a28355c..d2cebbe 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -362,107 +362,6 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
 #endif /* CONFIG_OF_ADDRESS */
 
-/**
- * of_pci_map_rid - Translate a requester ID through a downstream mapping.
- * @np: root complex device node.
- * @rid: PCI requester ID to map.
- * @map_name: property name of the map to use.
- * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
- *
- * Given a PCI requester ID, look up the appropriate implementation-defined
- * platform ID and/or the target device which receives transactions on that
- * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
- * @id_out may be NULL if only the other is required. If @target points to
- * a non-NULL device node pointer, only entries targeting that node will be
- * matched; if it points to a NULL value, it will receive the device node of
- * the first matching target phandle, with a reference held.
- *
- * Return: 0 on success or a standard error code on failure.
- */
-int of_pci_map_rid(struct device_node *np, u32 rid,
-		   const char *map_name, const char *map_mask_name,
-		   struct device_node **target, u32 *id_out)
-{
-	u32 map_mask, masked_rid;
-	int map_len;
-	const __be32 *map = NULL;
-
-	if (!np || !map_name || (!target && !id_out))
-		return -EINVAL;
-
-	map = of_get_property(np, map_name, &map_len);
-	if (!map) {
-		if (target)
-			return -ENODEV;
-		/* Otherwise, no map implies no translation */
-		*id_out = rid;
-		return 0;
-	}
-
-	if (!map_len || map_len % (4 * sizeof(*map))) {
-		pr_err("%pOF: Error: Bad %s length: %d\n", np,
-			map_name, map_len);
-		return -EINVAL;
-	}
-
-	/* The default is to select all bits. */
-	map_mask = 0xffffffff;
-
-	/*
-	 * Can be overridden by "{iommu,msi}-map-mask" property.
-	 * If of_property_read_u32() fails, the default is used.
-	 */
-	if (map_mask_name)
-		of_property_read_u32(np, map_mask_name, &map_mask);
-
-	masked_rid = map_mask & rid;
-	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
-		struct device_node *phandle_node;
-		u32 rid_base = be32_to_cpup(map + 0);
-		u32 phandle = be32_to_cpup(map + 1);
-		u32 out_base = be32_to_cpup(map + 2);
-		u32 rid_len = be32_to_cpup(map + 3);
-
-		if (rid_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
-				np, map_name, map_name,
-				map_mask, rid_base);
-			return -EFAULT;
-		}
-
-		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
-			continue;
-
-		phandle_node = of_find_node_by_phandle(phandle);
-		if (!phandle_node)
-			return -ENODEV;
-
-		if (target) {
-			if (*target)
-				of_node_put(phandle_node);
-			else
-				*target = phandle_node;
-
-			if (*target != phandle_node)
-				continue;
-		}
-
-		if (id_out)
-			*id_out = masked_rid - rid_base + out_base;
-
-		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
-			np, map_name, map_mask, rid_base, out_base,
-			rid_len, rid, masked_rid - rid_base + out_base);
-		return 0;
-	}
-
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
-}
-
 #if IS_ENABLED(CONFIG_OF_IRQ)
 /**
  * of_irq_parse_pci - Resolve the interrupt for a PCI device
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 30e40fb..25cd3f1 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -120,6 +120,10 @@ static inline bool of_dma_is_coherent(struct device_node *np)
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
 void __iomem *of_iomap(struct device_node *node, int index);
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out);
+
 #else
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
@@ -131,6 +135,13 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
 {
 	return NULL;
 }
+
+static inline int of_map_rid(struct device_node *np, u32 rid,
+			     const char *map_name, const char *map_mask_name,
+			     struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 091033a..a23b44a 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -17,9 +17,6 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
 void of_pci_check_probe_only(void);
-int of_pci_map_rid(struct device_node *np, u32 rid,
-		   const char *map_name, const char *map_mask_name,
-		   struct device_node **target, u32 *id_out);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -44,13 +41,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
 	return -1;
 }
 
-static inline int of_pci_map_rid(struct device_node *np, u32 rid,
-			const char *map_name, const char *map_mask_name,
-			struct device_node **target, u32 *id_out)
-{
-	return -EINVAL;
-}
-
 static inline int
 of_pci_get_max_link_speed(struct device_node *node)
 {
-- 
1.9.1
