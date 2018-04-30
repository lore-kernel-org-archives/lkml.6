Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZoRky9WUOGiZ+SSbKQCvRzYHo7BYORXn7DdW9a45qJO/ABgGOASGuJAienp6lrSFCnqvlKY
ARC-Seal: i=1; a=rsa-sha256; t=1525069712; cv=none;
        d=google.com; s=arc-20160816;
        b=tJoKeeGxVtEvG2WjPW/E/kCV/jXCa3ReN4T3XEaUqYTb9JgiGg0BWPPZXx6WrdyWVj
         3BtEklGpd7QPdFEO5zOb/pS5kD6qu9zhQwi4HjNbI7ftcEhwJYJm+y0wCRF9wRSJ+SdH
         dWCtWqsT+RROvyyMo3W3ekB3y3jXODCJhXD8bcj0saD/IsKqDXnKZaaasI97S1CpeOGA
         Oqj84/9libb/t3aWWBnU0jO5S8DvXDNNbU211ONY6cTHTb7EoiLJQjTjPrMai6odtY8t
         /VxmAHxjaQ97hx3QObs7WumPlwYykpTFDz9inDhMpmajObNO4kBb2/A4rwX+eIzlrkxU
         29iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hb0vu6iAdVcqHCIbxKiVWjY4aI0120RbN/he1MmRr0A=;
        b=obp/KsoflbttHevZh+qGthA3Q5Finbe4w2O1Z7nSmiVv+1kKXds+EkdvRJ5UNgh4hD
         7SI26nlfIw6dNgicOCVoqGoe8TBGnlV8SBiK60MKqrgL+ZechGeH1vPGkj2VTT1YfrYH
         MSR/cn+szjs1yZbR3N3UGoUGaJvsbKLbEtzC7qckG6sc4Xg0Yh8tBfixnmTx7aQ2bhuL
         HxlJkrSQXq5YlopipKwybGXf/AUYUJwvFL169RlNKqG8VSumF98FZwW/w8JcwUayJH9t
         8jCF995mO97zcGKKSEHyGGHuaIWKlwNIiBSViCXqYf3QmR9SyicRC497nWbxSasl9a6s
         OMMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Q0aODru5;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.44 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Q0aODru5;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.44 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	robh+dt@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org
Cc: hch@lst.de,
	joro@8bytes.org,
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
Subject: [PATCH v4 2/6] iommu: of: make of_pci_map_rid() available for other devices too
Date: Mon, 30 Apr 2018 11:57:17 +0530
Message-Id: <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::16) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:zOrs0kuZ6zbA6dAGUSyDpcwple2Jvlkv5BxD847fjGXvy13z4FZVPYHmfOMUCC+RoI0Rv2O/5Ld3pBnH9QOXSvwEakysn5WxtfZSJIBHrZYoFGMKV+xT6Te27E4HuHcSf0vxCP2FdKYsn9iaw93dm9JN+ISXvPMWTa3BvEi3aZGrtsRgR6Bivu56N2Id9iLOzXKJHenKBRb9pJyj84yuqw7rMkZPNoPlWisRXJXBCXHRPvTReuctHb7gfRKOjJlp;25:qEq3o7Nw3KvyMnJ6usBtvHtOZFhL8eY6KMGAS+DaW7EN6BCB1/O6GD0drWFhwaD58e3CL1iONlIP2bUbTJ1h03HfXWv59/+68kd/X1I3duuUmGvPc4qQ6ZvxGA1RsXkp52Jh/ORmnjzMQQkDCV/uLkqo23EfCgZtC1bGXT4jDg/MSMHceCyiyjrGVAJivNyBLeWqGKoeBw/aW70zU/g+0axhbNfjowgIsyD1UnBLVKTAziZvbmhcnigVLJHTQ1hLzIYTR2LevYBx50j2J4kRrqou1cITnKiB4G8YWfrIN4y529j+Rt73LRsi2TXN7RskjVkGPm0UGfRSD4jZbEQ3vw==;31:tlSy2zvlHPeuCD9ve2j0+xQlsAAVvnwhJ+TFIIzSg/dgtlLdHfdFNh1++H+CiQwhpdJhEL3yN3Nh0y4JOSjJK4obnug7mqEjMCJhhJdXlDYm/KsJA/pf6CyWGDgUuQ9ETJsE75ZhY6cmwzuu9+0HEvNAY5Gc9F7c5TVT4ivcQAZbjstiTalTyidxGCL+HaqCk3T/wu+7kjtxovPxr6CrVpFtlC05SusO1f0aclar29E=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:x4KPjwbYbgh0YzCA+43/ifkXhyIMCSsjaxcBYA/fKpdfBPyZZKQtIenwh/2hV3JX+89DfP7dTMuGcyaQBHnF33VhujsxM8Pto5n25vyOrgodmm8XUmlVr97qBNwbR+4AJe0pqKfdnZO86u8D/yXL8XqOlMP//YoaYGEXodusTCDwvC7C0VY+r9PAh336vM6VVJ04ppKPzdQu3KneuZIoGR5J+dKXDIXXVGRoffT/TSTa0CxCsC0q14uPR9B6/UfxhptGrPS45ELPuSpcWLd19Z2go5hixE6Q0nOgn9P5HvalcJz1L/q/jWJ/vEP9MrKMOTkXY+QLUdc/rzjbc6PQCCYhuxxeXB3Ft0+fakam1TEPfVPHDLSKjQCk9D5pG0bOTjZvHnegGLcQZFZOxyDoRkW3P5STLXcOixdaBjkoT5bap71bjZ/2nKE/a5sIkabicsRc581M1uO3HA60G5eQvNo2DdPoRvMjLGgtKZIxQ++RyiIGkl/+b47bOi5Sxpg1;4:eUjPmvsBKidc8e6pUceoMa3/VqfZxkgMNu4GRQR5/uF8ymCn/tMq2Z3tUsfIFHRkoUt4/s4Ln1uABQCbNsx0T+zUeTlK3WSWKD+C9Cn4rRbKC0Ae6Nlb1h1d7otve7DV4FCYVgDTDsVKyX2/CJ7/5UGkQcTZTKZ0fbGeZNp9lgVFRsd+N7w7R1TEqQy2K2ftowBWE03MkN3z/nnpvArmz2fR71J9bNcPBNH4P+aF4eMr51AfY5EvxAecIRnBRyKsIWnemcRzW48U2Nw8z7Oo5OGzjTPtZbg63L7850hE3flTYK2dVkBxnK8xMHvtMVv3
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2418C097B6273BAF1247041EE6820@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(36756003)(7736002)(52116002)(5660300001)(105586002)(106356001)(486006)(48376002)(50466002)(316002)(2616005)(55236004)(956004)(11346002)(446003)(476003)(51416003)(16526019)(186003)(6486002)(76176011)(44832011)(47776003)(26005)(97736004)(5009440100003)(66066001)(86362001)(68736007)(81156014)(81166006)(53936002)(16586007)(50226002)(2906002)(7416002)(25786009)(59450400001)(6506007)(8676002)(8936002)(478600001)(39060400002)(6666003)(386003)(6116002)(6512007)(3846002)(305945005)(4326008)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:gPxcPI2qM1RMiCXYSgeofVoe2nNEsuC9K+IDRHF?=
 =?us-ascii?Q?k6icMvLCseEcxGY8TyNL9gQV06Uuh1apOnKq3tLbfknIL8414YVApoCibeq6?=
 =?us-ascii?Q?B0tMHs0R0J5yev3edwefgp+m/GUHx0jsM0F7vuxVCwD9QErBEnbId7PGFcl1?=
 =?us-ascii?Q?POk7CMnw9qHA3aNCdKexKqQPxo+9NHJ/awGQduR4ahXf8lGh9xjQa123Uvx/?=
 =?us-ascii?Q?I8hvINiNOnQhPs2nMOxYO1bLt0VU0iqMtO1lWp8vaCCEL2jVzq++3TXs7vno?=
 =?us-ascii?Q?T9pwkh2NvyRGWLKClBC9FOP5+OlK3Q/TnOlYXkmg7mdt0gKbcD/dikYSDzjS?=
 =?us-ascii?Q?qK0VXyEsYWDoXkrOROsfevkxYIddXdf0ruAONCEjz5vUGrpJaKZ/eaRhf7WQ?=
 =?us-ascii?Q?KCxC7vPIBlMUyQtKELe4wUXafKKW0HNnmtJUXw5B9Y9grOItbqB7vRje/aQ6?=
 =?us-ascii?Q?rhM3NB4hl4Zd8c1s3zaiIOU9tlbZQfWU1BrL8/edRIpn1sxJ3/alhL31Hvbh?=
 =?us-ascii?Q?b0z3qp19pL+px933hPXVNbDiIcrHof87xa4ob2Zqdo1UQky/d/IDvdoFJp3g?=
 =?us-ascii?Q?sVjmrBP4Ccn9ZuEoAb8jjEo0BcvsjNwsUZGVQ0Vg1xSqF5IeD/rmOWNzac57?=
 =?us-ascii?Q?Xt8cDKPoa8j45TkP6f2fJKfjP74OWyYP0kZi5AZ1MfsbxHWRQy7VpNqCTDyc?=
 =?us-ascii?Q?QSJnO8rAqRzXk7naEfQOEUqjc6Q7fbWeZWyT9pNoPEucNn3p4c72/Q65seDv?=
 =?us-ascii?Q?gRF4Y0pue7FcgMiZpNjmDOU9kYxNIPRx/DSA6GeonnTSxzLlTTrMjZhZVBF5?=
 =?us-ascii?Q?U56y6QUKf+i28s/Wl+fveFTbmaOjAOxyPzw2gZEGhTevPRTac1gxfhkHYL5d?=
 =?us-ascii?Q?6qEq7o5uhFliXyTGcDyWQmEjzYWh+BuwOOeqwX1doj5uQplQ9Z4dVahD6ABg?=
 =?us-ascii?Q?NKvTy/CEwtkB6z7vQWjCtetmpYGDPDyxsiJIuP4UBz1W9eexcyXbqlSk1qmM?=
 =?us-ascii?Q?10wBqMXtddSDQBGfwBm4CdntxFxcE+wq9ClZLAoOsnXMaqR+QO7r41MzfnmX?=
 =?us-ascii?Q?+6+7MqKK9yO19gkD8mTQ7WyAYPe766QL7wD29UwH/Ac5r7+samOLLYFB4yVx?=
 =?us-ascii?Q?oj6dBaxOUHkVDlRGYmHVz3Uwp4nY6r312kEj3ElOoSi/YEN+CpVzp6BjPgwt?=
 =?us-ascii?Q?xG7rSoJNd5sgRiXFmduWPOEFI4Hw2+I/G6GV3kJg/6rTYKnaEEyQs4Ts8aTN?=
 =?us-ascii?Q?NEQElWWgGKuOzNx4sX48lpeOTntkUB0NCYkv+oxK2/EC9guaKbNU+5ToZUVM?=
 =?us-ascii?Q?Yc64NufpOVFuZXt+DRsCy2hAgyFKkMBqMslIvTnMJ7WKT?=
X-Microsoft-Antispam-Message-Info: iXy3KW94ENz3SbJRyri/OmF6fERZ8xysKoxHQ/9W07hb3DW8Ag+X95vdMj9kKbdAygTWRQDB6piRzAa/2KOHpJs29q4C6d0WiLJiUfZ3RfKaTIiff+DqW1BFlqr5KV6o/QXSfEu+0Y8rKttVRRYhUiOAdTLRQAxR2YyHi4jZVOnE51r5FhAaN5fZXr2tK/VN
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:iASS4yxT3p9WcTndiYLkbPBP4BduxfKHtwOpKI8vMOqmBNKY9sMlt3ZfUdZH3lP9hvCnhJW+PnLWqOwdewMajRjrY6XzCo93M2rWMHXEpoznzZ6Ev0BXWG9hnKOGZBoiOxgIsw/AmPT1ryjMainsJVheX6OvuN++/XgRzCKwnahkuhxSE4TXPC2T8kJ6oP8VHmx2IoQCz1ZIp0U4zPyOcYOi4Ak0PT99UVaGI0iKYvqEsw0gi9bje4bbA/pr2JuXbt3FmQwEOh8LZDhCUbjBnlMuaFdo3KtwfeB4LOuqrVXgmU1MM9K73jwuekUn5FfzNa6NS/EaoHSdAMO+rs9vrAnMZe0uCdQ5enP6+gPE/NyWfJhMDPkrDX8zB7d2ADAGjm4gYzYCNHQMuk1EqPIu4NDM1sVLTw+7gMou3o1EFPhF3LiT2YV8CdMFGtP/NWtBGx41egDLKoRlep/A0KGKbA==;5:OfgvuW8RfAUDVWmRE2iXYMiDSS17kj1467+Ud8kR/JKoutT0/KTVwaeZu1tm6EXyhx5QKIc9+UMmR4IHHuTgCBeaX0zl+7JuUF+WamidSPp8F+ZXGIvc0zl/4m/drN/lP7gMuReI/wm8iFty/nvwSSv8sBEC57OupI3xI5cAO/o=;24:xtYn19jVe3JcZ/76x75fTRT9LkHFrVMzpjb3iB87zIhUNrFl+QslCbzrswsjinkicNBpKSymCxfD8RXTWpqjGkOgmVxjo95Z/xJQ+Eb6q1Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:rZPV9SRlJy20Hk7Vsz9kuTAhbP2FQyeqPIF0bTHmtSy6pID5VhMYGVd6BTq6F9iHXWekQ50PEqMRhhpr51Vzga4GMnj/nWfwnY0QCv/7Zz1hfCJ/L9imgIKqjvEl6Pl/T0JbcJcQt9SDFEt6ihIATMuUX2MUeONVXA8AhcJRaDmfVPK2cr2vHVeUwUBz8wktqVDf98etnAUsoI0CWohmJqNQsM3XW1mBQ5m164heKg9BNcGOQL1xvV3DD4ljlrbx
X-MS-Office365-Filtering-Correlation-Id: c7274768-7e52-4b8d-937a-08d5ae6395ec
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 06:28:24.1593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7274768-7e52-4b8d-937a-08d5ae6395ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894771028861343?=
X-GMAIL-MSGID: =?utf-8?q?1599151499203545991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

iommu-map property is also used by devices with fsl-mc. This
patch moves the of_pci_map_rid to generic location, so that it
can be used by other busses too.

'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
functional change done in the API.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
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
