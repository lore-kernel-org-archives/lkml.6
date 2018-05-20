Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeETNv6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:51:58 -0400
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:11440
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751426AbeETNuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:50:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com
Cc: hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 3/7 v5] iommu: support iommu configuration for fsl-mc devices
Date: Sun, 20 May 2018 19:19:47 +0530
Message-Id: <1526824191-7000-4-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To VI1PR0401MB2429.eurprd04.prod.outlook.com
 (2603:10a6:800:2a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2429;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;3:jZw0upvJNcZDKpHE7R9/fXJekA0f+E+wNFjkbIWEMiKp5oEaKuaa5zCpmn9jWvvT/E2CddNbV4+tjB6Ls9s2hC+GYR39X9gkFl1fD7h8LyrODN6ikk+V9C+hRkJkCjsKqCSBPfNJr9HY0zKC4W7Mm1hUcrcqxZ0WVTc7KS6OD+RX7R4HzgRWQmxAv5gmKNJq/G6SbnjXDyhDuGHTHbYvNV7irBgTgYHNK1Lj8SVIZG18TfbvYJH+7xzu4ZGtej3m;25:XIXGPWaACRWnpUn6haR+AWkCqanRy7UHqkepNgVYOr6RrA+3wSXyZW8+I1JJIS+fX6wHflyCWJBp3K+KTo8mjSqB5OCvQA2gJPVLDFL7Bbgns1Sho4J6QXNNXAK6FxlMAK/e1GIv8nPdGHzgQtX9O7dc5puzLJjYdRvwNecw9s2zBf70dc2beX/UBi3anJXrZtjK5KgQkCIaXtw/btBwIWmYLxy4SDm63vY+pLJlGE/OcayviaThlo3CVtOVM0tDYN0uufP8eDwdST6NLhZHQsjlFB3X0Ycv5HP2G+vapdv2VT416VT04cjHlnPlx4B7YlL/6P1w6G4LKnVZ1qcBvg==;31:332AYmaBsw/ZHz4bWWe72vYWKtKk0QhicJnsjtguDIQJA3ZA9loe0oBMQcgGMilpiq6l7iapqTnYJXropzvokGEukeNv7tjDFoXqEgUmujCXGy//+fchyhnsLtRDZgEnxFERKutaAGIJXOrEhFV/tXUo0iLBohgMEnlQQzjFv8d3dVj9cyLTJ4515gnL45x19kEYASEc8uHptMiFffpVB/w1VO6NZyTvjjLVHNajYSs=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;20:bU2zmr2OrHPObWe5aeo9Av47UymIhPp1Ew7Y5bF3GFSP+uPFaOUlUeLvExf6K64zTqMCb8w/st8xY9WpsuF93BkFemKJl9llpNZKAlH5cynlmYsiTVlO8IrTG6IKa/LokkXSbcBUmdkh3vPQ/RfqHBLUbTQBZs8C8OhQ5uOZl2qmltFlNsYuK/FwEHC1eui+4OGNhZlBkMyaw6MSmlx074u976EuB3qdClyv73QEHqnauB3nZ6WW6jQxHYiZZV5K8nv64oq3OUX/5GlbmOfLMARXTcAlOAq0JR2QSDCLj2/dYT8ah98Ig7oS/1avFKmXLaxYAN6N7ha6QEjsDuR+jBZZZRRzfapetfSvck31upPE69YBRsgW/gmBgAejTLn+PKxfaGmARWnG5PG38gndpD8OkBxoYzVe7SjhWDGTaNi/5+uIPo49Ey8ABrKUP7ZfsduYEvbNaxS0wltqeuP43xO7P9CwthZsW/4NP38ckrcx9C/kriWq8mRhyYtwYbwr;4:64wFo6Nabcp/s3pDjgMhqo2OhMpSUg52OZPze5kf+dAXse5MDUReJ/Miz0tibyhXfzg5plgEjAgEmrpjxo7yi8xc5cVPDzc9X254Jb3wLaVVWaOkU0+oFWou/Gii2sxSjvLYR6RVTbHRe3Ujyu9K050Ts/FkqIVBpv8p/UySfvXgG50F//x/V9A9dH53u0S0YZLZL7nx3vpLCm1+bjLhNY/pdROgFAK23WJSN43I44gelyqEEL7tcp3wUXeITjaORczVdhKMjcsBg2/RTQoBUsgKRpsIKOrnHao1LEm4BEPWavH/vHw/A1s2VsXlvK57
X-Microsoft-Antispam-PRVS: <VI1PR0401MB242922620D0B65990DAB62A5E6960@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2429;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(316002)(50466002)(50226002)(47776003)(3846002)(86362001)(39060400002)(66066001)(6116002)(8936002)(16526019)(8676002)(7416002)(53936002)(6512007)(48376002)(486006)(186003)(26005)(44832011)(478600001)(81166006)(81156014)(76176011)(5660300001)(7736002)(52116002)(16586007)(51416003)(6486002)(97736004)(36756003)(68736007)(305945005)(4326008)(6666003)(106356001)(446003)(25786009)(5009440100003)(11346002)(55236004)(6506007)(386003)(105586002)(476003)(2616005)(2906002)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2429;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2429;23:L8PiDj4ZJ79Gby980t6MI7UruMw71j/z98l9NwT?=
 =?us-ascii?Q?AOldSdNenAJaJD0KNSIQ0nt6Q7KllwfkvOFI2NwBMb2w8wlM9WVmG7d25X/q?=
 =?us-ascii?Q?NpkFon0fm6qkcUrwRH+cwqtRp359wxA6Ce7oqDVTlJJb5ZULfEX8iZ4ZTxaN?=
 =?us-ascii?Q?wNr0Xq78ixTqF7jSjD0s8NYy8XJAp/KIwRWf5H1WxgC5SXbqpM5BQo8y/9pC?=
 =?us-ascii?Q?CXfLHpnLikOWl8FaJLlT/5khsE8Uwiw9XgbETaPV9RSzpdENhNVKiaAoeU3y?=
 =?us-ascii?Q?NsqAZC22uXnOqY+v8y/ohjq3gPeh4TkGrzIokM8/rW+IM1W3YTeUO7zhJ57/?=
 =?us-ascii?Q?LP+DWy6P7wJM3DtAtL8arF6xNST7Pr/Iu5rVtTApB66iiQShYSE2w7uaekEw?=
 =?us-ascii?Q?omjWaNzKktbuL7HRiGqUfmxeRb5M5XPUe48O4av0Bil9z3Y8EtjRIqjKRI5e?=
 =?us-ascii?Q?DWybOTAyGmjtuK+q2hWTspH/OnPxKRFlncQ/z5//qmikOBSEBBBK+Te9fTNp?=
 =?us-ascii?Q?0mYMjilI+MVdJ2pbUk99vl00ouKhm6gt5FhyC8WqC0XvL0WzSFXgEUuuY4EI?=
 =?us-ascii?Q?zzfFsPDMxZjbyiR9gVN7z/zwlCFW1lcnxRiyMbIgZXykSn5ld6XzPxgj6npm?=
 =?us-ascii?Q?/5tZbgwfVR/xeEXE3wo+DCNXnb3Hvt3FFjxSm8A350EfI/dEu/O4nc4UH/vo?=
 =?us-ascii?Q?pKbmOlh/pzwRu/Mb2FYiDKHMsZ/oCeYno/I2G2BDCkJGjvG9lwDXXM21J8ao?=
 =?us-ascii?Q?LrhCiNRonoUnTVJRkrFp7Hg2CFeb22++m5bqTeda9VuyH5lQinLfQmc7ursz?=
 =?us-ascii?Q?VUujZkgXekI0m/olVCFxa+4uXOYVJr7AF5wJqtH5baRmP0S9zwFAmysqHHUu?=
 =?us-ascii?Q?M0pg/HvpwAt0kOy0fnlxZ2bl2Ws7LGjPKDr9ekCcCWeT3eBuVY+4cTm6mprP?=
 =?us-ascii?Q?kD1B2GNCvJJjZXneMsvE3XnLPC/rjcfxxNi9E9jXtinYznIrX9pOICfAZWLF?=
 =?us-ascii?Q?a7RS8cTEQKgebWr/hLArYHJLELYGFXzkkLN4qppGyfRFCrUjgi4F6jWzrTgF?=
 =?us-ascii?Q?8s1IuG+PkkSsIrT1/Z2eTI+0mejDBsz4kGm5spF9zQqrAa6k2OY/wpv25EU4?=
 =?us-ascii?Q?Ul97xIHn7AB/ZfD7CPk/+lmhM6GSn79Mo6TvlyO6xI65t1GYq0WJV7LxJZlu?=
 =?us-ascii?Q?2x7TXPooxrF2smTFQnoOatASz9AoL32Yl+Cmyy+m9lD5zSCDypo9fmCoJdCa?=
 =?us-ascii?Q?x1nm0GPgyAU1qOIi6OZAJHw1PONKei8CsPw9TCqGEpub6Dh+LPkzV4ZHZccL?=
 =?us-ascii?Q?o/FbYAbXr+FD1kLGuV3CpB+s=3D?=
X-Microsoft-Antispam-Message-Info: r2G6OLg/13bJ8KwwnbMbCd1/EanYFVQoM/AGFSoyODn9GpPRxWHMOUi7tIEPuz9x9jrX+m+SLHcMJQpYTWOe2p2QZjZ6JN80STPdRVhSf70aFYzKkKvl7dY23lue8iIkkr13vF4Bn6mJ9OKlxbO3eJuADwQtoTvphYZw2LK/MHxgJIgZ/Ef17QJlN760Wymi
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;6:qex4KaoMtIm27svYz9ND5LJgMyRh5mY1uw/tOqvZ8gcPmqjLA+dk7Qb+rrt7YyoIkGhF6FbsstTvFOyVy/r8QyW03mYoVs6GOZ6nzh0WbUE5lKIQ5hojGkSpKsP4sioM0V/edaQ544coeT5GfXhnppjjZnvN89TV9EXMyDEBcmBNvBJbCXowGr775Y3tf4WL7yXq4+AGaGWN0TIinhge2RnToaTYd9FFJgTuQWFpsd4gPNsHuJzRUuPex0qqT9pin6rNC4yBHPfqZx/6gdA3abofSZEnycAl1hdqz79nPeiUZaYpmZPMOIQUgNAaGMLka77Wr7npYPwbhcPi52FsspMZTJ5r082UiSOmt5jJtSwCpPcFpfaHAb3UiHtGuLvE5eywQMGknWNwTKyomUMrVuNil9nQfhWJmjVxwpKVlTDB5/9Nwylwj/1O6pgAo21hZuN9XE7BeseZwfEEW7qciA==;5:SffnWW5Jr++/LQMMcyUo7MndXDwBjvqAVw9DAcftomB1OnIvMqTs//nprtUttc75JSAumVSSkzDh4Kc1ZhUuXshfPj1xcHHjWazHdrVreXLqFNGph9FzLTWFhhXtNgb/A8XS8Ek6gNlgK2+FT2NEi2SURopAJK7wnoTS24Z765g=;24:iJP36Tx5RlMlFsCyyaUcqxY601/qEhkEf9E1coaklFKnmXxUK6I13GlQLXSCqaBdQhl8mSuVxJWxS6BeXEBi9HBCjxEHfXP/dDwWHBvu3+c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;7:j/TKq3Fm5eVoGQjj5Pqz5oV3MvRncSSWPxMu7fUC7oruwcNAA3Tok5ZhesBASs+QnQVxIour9Ro8vSoSIDudXAYb3O9wJ7lmAI4BAu2NwrK1ne2igwUmQyDHX5f07eapEJJ2GbdEePKvjIWI+DbswoUP4dAZDpDdeBzCerB2tgbNRflFAB0UHpzulEEDANJqcF8kwp0ZoSrFm80FvDKSCiq4teC9OjM2WVlmrU3oqBQG3KzfSL2M/5eNT0Gs2qHn
X-MS-Office365-Filtering-Correlation-Id: 6986a2cf-0b29-438c-9314-08d5be58aa0e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 13:50:32.5086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6986a2cf-0b29-438c-9314-08d5be58aa0e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With of_pci_map_rid available for all the busses, use the function
for configuration of devices on fsl-mc bus

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 811e160..284474d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -159,6 +160,23 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
+static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
+				struct device_node *master_np)
+{
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	int err;
+
+	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+			 "iommu-map-mask", &iommu_spec.np,
+			 iommu_spec.args);
+	if (err)
+		return err == -ENODEV ? NO_IOMMU : err;
+
+	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
+	of_node_put(iommu_spec.np);
+	return err;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -190,6 +208,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1
