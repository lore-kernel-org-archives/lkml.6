Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeETNum (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:50:42 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:15951
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752526AbeETNuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:50:35 -0400
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
Subject: [PATCH 2/7 v5] iommu: of: make of_pci_map_rid() available for other devices too
Date: Sun, 20 May 2018 19:19:46 +0530
Message-Id: <1526824191-7000-3-git-send-email-nipun.gupta@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;3:30s0h96jwgNV+1eRt0hBH+8POsOQO8VjJ8cq72kz4m5zlYacNvwFZSgRBaaBXo48E1teJ2Q4TopgO9oEgGi545fJVIsrA2h0dDcJKvZGhQhwWfwLbOaT6b5/Ns2/dJBaC693L0SWq5D4QQc6Gtm2kTHgauWwfluzsKTLkJZYGdaeNR+SzcXGztCpucfMZ+Vt+UGQNnzYr4t85arT6otcq04KDtrL/4Z20jnTeMg7javSl1pmF3WdJF2t+6H3FH73;25:qvxn5bu/RQa8fOmryszSoCitqcPVJhUSmf+vRiyi8yxNJQ+pmF1gBO2zvYup4M5OainehX/REvmUCTXj8Q6Y1FWFa1loeKhCJKaPOd8wD1pFUT6QTxEcJigtZxQY8Gy//EiSsdmj+4otOe+Gvx5ZRU4cBO5Uylrww6/7phks90jSMJH+sO3/GMDp6M0KwQ5AGmKMdZ0YI0URoP1t9qoz5pY8fXtCUNRKFDrEOJb+XSsLCgsJGvl2euYnowDq7FJvqPKNfnuoONhPrNmNDSnFTDjwiIVGrG8Q3KMKFtt11RRSiv6knYrENECEtuu+EIsvEcI+Zn9XK3Es6pehcPRFfA==;31:hVuAO2VsT7tCav5U/+dZm8WzgnbW3qg39Mho//9ADEXlMK9q90A8raK5jV6xHj/JrFyFmMYobLN0dQhdF2luHSZD880mSV3PESdveta2GRgQtxs+mX7lwqpymUOsfn6gDyRFOdg9H4BHQqhxsrDGKbL9xhVCOZ1x1Kt90MMZINpgkLUtiv3eESchIsC/6K/gKWUYq1xmiSsvFecvIBBSJGg6bck80zlEQDS5DC+6Pss=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;20:+UrQ+6ppPRlbHxrbFsz0zsnPBm7uRRIu7Cg1dzYkupNU91HAALYqtU86GA7dMx14PcPcb8LojMRokQ64tV9Y3YzdO1UtinM/nIf77xxGAtEwb9PJhpGaUH9o9BB/xF8NeDaRkop3TQ/3OOigNhjswRvIH/KQoIDYYqMSsQxSIVNM5BaVQ11anF5AX7cCNbKLU3QventaX+NghfiPPWC9kIQXQ7ItOnlcuaMfEKuZvMm6iM+GXMeNd6EqcfKFUUA01LYQ9Rv5Ep+qNDFcs0yVNmNVuwcHFUTb7oe/CI10TnDEUEireQx4qo67cxMPRLWdIZfTw+Se0ay1qV6V9nSnEfM1BP0sBjf9ZdcjWTNDYRkO8wPLVAD62CHC/KhKMc0WhNM+zIowcH322rh1fAbDRFzCuxjUxjol6EVSHKR9HjQ7dKLYnS1EQwhHtQik15F0sxd5fAWYsvoLB3IxSPxo+OLZQn8sekmw7Zy5YoiLW7lN/K3Syq0BFjc3dd53FUmO;4:4faS6QJO/u4m60RZfRkUO4aaX7sYOBlZZdXHr7VtNIiPKcilmBmB1RbijlYJ2lolU6VP+LHUvY2rC/BxiAuLPjLa6zHH88A8Rx4sDlHn/NLSNP19EFnfqD9JKz3trQdQ6gtFJlPFG+er2YGQeSSAmBG2Nh5A+mqETfW+o5Elz2F3NUlPqcKOjALDc8Oo2g78ktoc8Aw+2Y78h9Cl09GZMl7PFwh6gt3q26W8+on6fM9FpTss98uAFZPneIAMYSPxUs7cGHMDAy2PmAPl/mOLISJR2APYbShz8boT25ed8N3YW0onEBooXGmURgPSFc2jX1sIOM90XQFW8j4RcvCULy3pUbNH4W/fMtkbzLKR0rwT557gQkDiZnPOPJ18QYxy
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2429AD4AB04F37DDEAC31A06E6960@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2429;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(316002)(50466002)(50226002)(47776003)(3846002)(86362001)(39060400002)(66066001)(6116002)(8936002)(16526019)(8676002)(7416002)(53936002)(6512007)(48376002)(486006)(186003)(26005)(44832011)(478600001)(81166006)(81156014)(76176011)(5660300001)(7736002)(52116002)(16586007)(51416003)(6486002)(97736004)(36756003)(68736007)(305945005)(4326008)(6666003)(106356001)(446003)(25786009)(5009440100003)(11346002)(55236004)(6506007)(386003)(105586002)(476003)(2616005)(59450400001)(2906002)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2429;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2429;23:SXXY93+WBBvwDnrIRvMVXlbSf9JLKMx7zPavRsV?=
 =?us-ascii?Q?3FCCi73/s76JNNQnARubZTSdmfudCiv4UkuMVbkeXPcjElyNQ8gxCEDp7kXg?=
 =?us-ascii?Q?xWJX70aLOuJNjaZxWpqFeYkfXwHZAnidOf7aWIjTfEt0RAtKuGuUA1Wy3JYA?=
 =?us-ascii?Q?6r50VDk4etJNPB+LK6UdKiiQHbtRmGPcdL3y5im1yTkMgZ4Os/JNweEqDOFT?=
 =?us-ascii?Q?/2GC9xUnvMVQtSgjExvvS0bt+sp7Zdon+mp6RCK4kK9XKTwYzxakTNHSEi1z?=
 =?us-ascii?Q?awDisIaNMM+Q89GsbMuwEQRBo1EZj8TR8w3V23O9di9nOGSyLYT9jchpPn6k?=
 =?us-ascii?Q?XwtKTDXl/ZiR8BouWzYrXTVuAvXUs0li2IYSZP/Fq6s1jhhhkLKgSGDgVq07?=
 =?us-ascii?Q?vfy5v89qwGdavY6wv1jqCrXFCOBp6flEpbf5Doi4M8/SkFLceFYaHLz2u2Kf?=
 =?us-ascii?Q?m4Hwwykod1OZDOs54UHDfvMzsMQVdV1HRgPFkKtRGMBfsVsWGHvRLtoE44VJ?=
 =?us-ascii?Q?YEdgyJeLP/+W1i/pYHiYvxJ3M8mGiRitjBP2MRKyThLgSf5lSXZT9NHBqEPA?=
 =?us-ascii?Q?qJXdgI5HYLeZfA3EAKPT0bepsHfWLWBXg42D+VnV7bdxhR0Wz3gn6Lpfyupg?=
 =?us-ascii?Q?EjSCl55LAq75unVp5bV406apiKCGv2OVO0OchxpTTTUV+nWkVgxvNQgzceZ8?=
 =?us-ascii?Q?sXO4Ehft/WO7yACLOo2PEvcg82hbwLK1V8NAJjkGwmvnsdadpCclcrRMvAXK?=
 =?us-ascii?Q?/q2mPPNT7qHj/Gu0wXL86Xup+BfhzqqdyLJg26LhlqJ2SQC0nj3eZq3TWNFl?=
 =?us-ascii?Q?9Pof/dqunFkKm51ksUZ1v/NLGYG2MgyZEYXvc8bemJnTo3vgySPmSVFlpYza?=
 =?us-ascii?Q?N9n3rwlC2QgTpTlqTpLROENLtitKsADhdnLco2gNSet4bQXxmWXdaNVWFzyp?=
 =?us-ascii?Q?Gk7duc/zGugVX010/sNOBaFzI1KOSXIxCKlR6TgaolsqkSACv1FScOVEfNfS?=
 =?us-ascii?Q?scPNFIOjJ/ctrC5zMYAEAmzY9lYdVZO+GIme0qLC1zfKy9fVgi0vaNiLnFO4?=
 =?us-ascii?Q?tUHbjsMnX6j1SpPtlqYweM+2EAdrf8VH8bpLbgsUa1wWNwhuDCH9QBkSmk+j?=
 =?us-ascii?Q?wSMg8ptgAFhqzl6O0IagxTaZxdsIPvE+PHrO5sDuGVtUXZD5/4jwnzGDJ9sY?=
 =?us-ascii?Q?PP8pjnAJ6wifgK5jyjLihNrIPOTOW9xPVUyiAVhWs9LdLBZLLODvdT+nplH6?=
 =?us-ascii?Q?u1S3tkXM81JostUW6cnbgGZHTk/BP6JKTbj30GxuEBZGDss3Am+H349f1RAi?=
 =?us-ascii?Q?Xy3K7uWhqh+alaMmJbkty1jr61tFVS2WNR2j9mESobHc5?=
X-Microsoft-Antispam-Message-Info: ewe7pZpvO2eFY/gcPeTbqvKAmSHcIQYqVt5kHmvfaNXeqDsQwQ2+QIA8FX3ULbQivfZr/4EHeubJ27xSdMOpeT3gzqRkDc7xLVeN/VgCZePaHsrBnKBjG9pB6W2p8FqvrggVJUcKDV7MaynebkN18rEpzJBVP2jauqdf/00aeYJ1a8KDniFcZtbbS/jhBwv3
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;6:pWmq7zYo0xDnNW+UcSRORYeL2XQcpX3Cn6bpImH8fWQ5nkNtP7u7rZg8LheFRbcHaChBsTQ3FrWg1UZWWUfH+b+SEoyVdkNDif9IkNdPXQTsKno0IgXZzSs/2aSseKCvjw/eB579g60FU7KsLu14JGfd4AONV61ERDADLT29IP4FczTC1N/W7xTt0UO3rXo31j6aO/IruHXqFO5erKSYMtxuhWmgH3Zz5RqnadeLABLFih7WXJEcN+SEbapVaWy4WzfbS8g0DZ4Cer1jFiTFFEco2TMG9cCGaQdM9lzQlfjch61OEck5tXKR6Y35bW6O1p5uCsY8EQ1PFVQVkU6mCjYV/Fe6bUZ3b6lX78+AgogNJkrPRsotNzC1mGT6qYS6okj6Xz+pTuG7X05aZrkqQYnBD2V1pNWOt0C+kBt9BgWDWJ43cwOm3pLlthqEzcb9LttYhTJZy3T6mR2ktJScGg==;5:2pcX2wFMcHyuB/vBAeJm73b5Huq7syUBgcm8N8M4TQXvcFd8zRR7/R1TnO2ImdKjKuayhpbJlPct7HfFUBn0RXy89PMgdcRd0XFxZXhkhlcRlmZLa0JWvkR9xGFn66xgFdMFssnosDkXtQKvOqxW3ikuk0dY+Tos52GdJmrHazA=;24:4c8vWN8hT5vZfvmXsy9tY1NMkjOGeOS+8Ezdciu5tnocZ8Fuwv7pFY3lLplFzRpNnJGge01PKGc4j77ZYE4vsMWGPXL6Ep1p7maaFwaNDKs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;7:Fy4q4Me9VEObjK/1h6Ud5rNMqF9iY4sxIQKJ3QLalaqxwFhfgNJL9zJ6XStNjau89knF5DIjSx2TLTefiTqAy4MoyPE+ZPpqUUSJDGk6lABTEkzXa7eFDrbrNlEM3xjLq+CQicr/0XyFGX3SAP8yMZh9DSTmjS0Ip4HwDkBGyyhkGmYpxtCZtXQOvdiQ1QSSSVmr7rOOs3xaDWPreYPAn/ap5/Be1pCAOJ4iPpA3WvEod4/HdVNJQrh6FLF9DwPb
X-MS-Office365-Filtering-Correlation-Id: 769f4ce6-93f5-46ff-65ca-08d5be58a718
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 13:50:27.5398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 769f4ce6-93f5-46ff-65ca-08d5be58a718
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu-map property is also used by devices with fsl-mc. This
patch moves the of_pci_map_rid to generic location, so that it
can be used by other busses too.

'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
functional change done in the API.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/of_iommu.c |   5 +--
 drivers/of/base.c        | 102 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/irq.c         |   5 +--
 drivers/pci/of.c         | 101 ----------------------------------------------
 include/linux/of.h       |  11 +++++
 include/linux/of_pci.h   |  10 -----
 6 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..811e160 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -149,9 +149,8 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_pci_map_rid(info->np, alias, "iommu-map",
-			     "iommu-map-mask", &iommu_spec.np,
-			     iommu_spec.args);
+	err = of_map_rid(info->np, alias, "iommu-map", "iommu-map-mask",
+			 &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549..c7aac81 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1995,3 +1995,105 @@ int of_find_last_cache_level(unsigned int cpu)
 
 	return cache_level;
 }
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
index 02ad93a..e1f6f39 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_pci.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -588,8 +587,8 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
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
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f..f4251c3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -545,6 +545,10 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 
 extern int of_cpu_node_to_id(struct device_node *np);
 
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -931,6 +935,13 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
+static inline int of_map_rid(struct device_node *np, u32 rid,
+			     const char *map_name, const char *map_mask_name,
+			     struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
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
