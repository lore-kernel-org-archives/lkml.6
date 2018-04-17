Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx4/oMtBsaly3muNcA6tbW5MGgyJkWAGmOxLUT0B/EFRqqU77EqzBhpfwCfCA4TBvLN4bf8bd
ARC-Seal: i=1; a=rsa-sha256; t=1523960813; cv=none;
        d=google.com; s=arc-20160816;
        b=nfMMjGXHFQjTZ6ZEUlGOaJt9Lz1YpKK/UTNkwi+eJbuBlH12CKJoOkBWavaMzEU/FB
         WTaQ0M4dO4CACyIituH9asGHmzs4ez+RpbHYEv3H7xFf13JCtL7L+AGioVOox/ukgfdV
         qZIgTSSXDzWol6QNybvsVF2f7p79kpGVoXrY29qE00ytfIP/bTtDaC/36hiKLexwqSBA
         A9IuhvT71OGIIU7M66s/CmULARSEi6eyp78mqJJiZHXltiDToBlq57Srwuir1Y9y/EIz
         NRfxUu7u9HwRFaOYidngPiduV7um4KhV1Jf+zH0ePgaWxvQPaWjge8rH1yo+OAorYCLb
         POOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=KUXB9pphJav/899Bl8OB0xpXUK0pf9bVcx8h4GxqF4I=;
        b=m0zrRaJLNeQ3k30SdhcdCQDE5jS+HqPLhWgdISg2tQ3MwuxUyBEtlIPd5t2H5jakzQ
         yD5w2ugWGVF9ApGO2GdlY8MqbRWKWUKJLvtVfqiE5Q4BwUeU/p+/EUbyD/cTnd3FTJnt
         xgKTxeCHBoYqEv1HRtkmbyTc+TOAA1S0XTx4Azg0ySVooB6MJrJgWOK7jzh6lpC1Wjpu
         wG/SxFPsEzmGLmXwWOxtN59c4ccKSru/FSrgZLBGpIh0ENRY9HQ2D89QpUdDklNF7R3g
         aA2T8ZLKmLKYodcz6tFiCvBowGzyzOe/pK7or/vdd9+NxgNmRW7/xeYKuiVE5er/QIqg
         0UYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=pYVGWb9l;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.43 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=pYVGWb9l;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.43 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for other devices too
Date: Tue, 17 Apr 2018 15:51:50 +0530
Message-Id: <1523960514-25457-3-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::21) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:u3Kl2l33avso0eKpxYcaR1wy8n3rxNYpPTrMUZ7b9mHfNajkZJboaFnNUJtpuDb+fLyJ+4RgYsguSohLsqJkQm9ObDq2i4VwQ0ZsnuhPAXWo/st35rz8JcqO2XmJ8JGoyeSbuU57SnSpwrAtI1jR9N4e/6lxXjWLtQLFamvW+zfPnExk/2DeJgtY3FtCD+WgoEN/7Uh9J6l2FxerK/3//u/mGhRxqp5JdtjGpoPyqNad/e3BHvdHC1I2EESh/GJA;25:6I+0iG4WeATc4GidlOVEVTdTOWSzObEmyCgxDXWsgtClpAdzedONxJIwCuZi6r9A2OqItkbWqUCXwQHF2dBJY4aQ2JyKS+KtzWuLXEL2iWMFf+YgjTZoiVACd6m7v4DCmuf1PimC6yIErS8pz0v7enBypl7/5avB+7g54E8PjWCTKD5TsSzyML/rqSJoKvdAHaS0rjr6aM/8A9wJeWuGRdHKjyBmk/2VSr30KE/VZof9ho63x4VqmTi89cl00ah1dR1KBkJDNHTVhOopHS8UKVOOEllDatVTCd3N6dwy12GhKNznCJZs0r6fgemersaEHSPN+5dtdQmonefphrZspA==;31:XE8vYquN1jNvJLWVVBA3AH+wc67FjR/tW4OWl/6E2xCTCwFDig5j6/V5lkJ3dwUFkyYZfvLUSvJua49omfN6894BOSsrm9LzLtExi5MkPMP7c4sAok1DqtQtpOGZ1sQ9CfIwNj39a/bbbYQxL8I6ejcoxZGtePz3ZcnGthZbv1SdzHsDgq44iee3CS2tjF0FTWnVTICmUB7xehiY2umlv5+xkMfnleJ4kBKxrKqD1Vw=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:CPR0iRiaRNRiVMAvwl8KlYTJedGJ4r4MFnHkMtxrX2ZvzEG88oaUglOefLTAl2k4IDwEjKTYzxDpm+wfVF0C98xZcVUTZlKUcD5p32XobLGQCCflbW/PWFf5hmCCdmlki5RpbydOa5FFJGPTBV7Iv0rCzxE5KUdRqnrciFnlmr/WJJizuW+0o/lbQaB4px7QYlnqJadxxBY+lFy/FbMWjKJHmpuQGtlhUtOsfO8tyBDLq2yN8Ift0NOpAk6LOeZgUyQKgpNeIfxR21HqFacY1Ra23oGuzyc6XZJ4lFN+7ErpqXJKXXsP1708d/FKjvXgH8DAwhkw0tLoZ0JbFgz6XEPTdFcmSMurRhsatLgJfxape6dZDQ1SSNYprGMdN5/A9iGEypd+6NeIztTdwEMa4NuJALBJ2voDACBUYVuCzgn/a2VvUkhgoeflOClwu8bRyuTwpb6SKkfBRPcfd31YvzGMRTvG2+vtwzvK9+DoOW0MfmSp6AN8gYIwGZ5Fk2zz;4:O6kk2FK/icXLoW6PXq4q3ctoUQkzvUFe8BOQJMTKShnHpwrMPEP7Lw7DvFGY16oS6iwZvwOc8To0LGpJ6Z8Wp1qwu1cj41tyotCKHlQV5xwZ/JLyTyOxdMhYBH56mmfd5+i4SWdCPjFjsXsecDxaYPX0Tptpn1ty6k9uBepmpCR5OEy1ZkPr6A4rRLYO1BLbtshMp388IlnK4wW65jgK/y7tJicb+TTbyuWbihrrC8cGwNVP5THql1nvHSKTupdJppLk3Xw0ww8kiSMCrCYQX9RDM7ywCLSWvqlYdxbXCXrvsXHw+OCMvKoYfM0qkWI9
X-Microsoft-Antispam-PRVS: <AM4PR0401MB241874B296CD81A759EE0369E6B70@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(6506007)(386003)(2616005)(59450400001)(446003)(11346002)(316002)(486006)(97736004)(956004)(16586007)(76176011)(55236004)(6512007)(186003)(16526019)(44832011)(48376002)(476003)(86362001)(8936002)(7736002)(8676002)(81156014)(81166006)(6116002)(3846002)(2906002)(53936002)(50226002)(66066001)(68736007)(5660300001)(478600001)(25786009)(39060400002)(5009440100003)(4326008)(47776003)(36756003)(106356001)(305945005)(105586002)(51416003)(52116002)(26005)(6486002)(7416002)(6666003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:I3IDUuCI7z34w1qYY1RRwBq/e5vNDO6ZIDnfz1L?=
 =?us-ascii?Q?WLQyKMoGr7z/uMOQ8si3gGF3G16N+aUeaeoYZ1g2H+XWpLVWchv5s4Ab7iUL?=
 =?us-ascii?Q?Y+x7DJFGlAkg+aB3W0RTCBPpYH/hpGqJakiP7UZEtaNq+RoLAPT4PmG/J/9s?=
 =?us-ascii?Q?gwRqXttkrSSXB8th2MWRKdL6+CgquwTQ00GHN9d2q4O5YV+OmGSVkTiwwDIz?=
 =?us-ascii?Q?h/4xijSfEArPmrE3X74sCd4A/uBjEhcH7qDGRNz2ZMb+L1bdBtWmlWlkUQ+i?=
 =?us-ascii?Q?C2rxnLUN5YpyiSJUrZOaMBEuRiDFj1pNm0Z2aappcalf2l7Adj/2169vcT1Q?=
 =?us-ascii?Q?OVSt/RWmHVyOivJS9hBroPXWpDB+wNIA4EPKZM7aMoC2Q6pUGDj4v2+Zb7Ln?=
 =?us-ascii?Q?TBqV+9eCYSY9/PXr4r1Wn8PKrvAk3b2HxEBhsUcjUrunlGDFbQ6c1Z43uhUL?=
 =?us-ascii?Q?dHMajWIHy3B30ndIwiYAzvIYu6rfgIfJMZS+qnMg6FprsqSkb0lE4ShMIoVt?=
 =?us-ascii?Q?vuyhIfo9LqfpPQAoYlqAypz8XTKwBd2CH8v9WnBZF6pB1HpR/GTiCOKL8b80?=
 =?us-ascii?Q?hK9ZXCOLZPfku2yixja9zD+EExtg/J7qICgPA0BQrJTe/p46GKx0OKR29K0i?=
 =?us-ascii?Q?Nt0BB84X6dHBPVfUP9HywA3XPywFbyoNREcWnwrG85OoAsOsUu8A4soovMf1?=
 =?us-ascii?Q?TmNoirUe2P261KSYHw4Sv3QF0HvRTj4PoJ5ZAnzd0iu067Tofw2ziJT5BLvr?=
 =?us-ascii?Q?k4GLJp55WBX54N+lSYIZzoiNz+U9k3MyUlRHlb8BsiJNXq/XhL4QlIjFkALG?=
 =?us-ascii?Q?0FYK6d1L6AaA/MPNgNW3QiFvNjGsW16eN0ZL/LBMhOBVhEA5cDGk5u7rlRB5?=
 =?us-ascii?Q?AJaUTn4hF2KxP4TMVwGw/L1n/aBRv3qjwY+UeZfgHumPTfJ1ShytSJsaunOF?=
 =?us-ascii?Q?3RykPANj1ExTiISAM4um0L8pZEIDJPwTURY3wvDyz2nDzImCkI3HMGEsGAoe?=
 =?us-ascii?Q?ZZk0cqzXDzrGUDGG2C0nyGcN1bo7BD9/0Zl6ObwG6K4kHl1h9TSPrddCiuKs?=
 =?us-ascii?Q?B5pelf17R7oDkYI4B4I3NXQZtx/UUMdhYhCIzjQTI/rh46Euzr9lJEN5nYG3?=
 =?us-ascii?Q?Vhcdb6/s5ooUDnUijj+XoxvxBcjKyGVn5JPDwQj+wctlZgHjbiUPqbq3yBLI?=
 =?us-ascii?Q?FroAbUCVEcnHH7CgM33fa6CLHUwISnnEsgOvdDqFrKUyJMglc3pAMjVi3Vnk?=
 =?us-ascii?Q?GnNAoEeVXKFqWXWqS2fvhCZ+0HP6rUkJkSlAZOGccwVcTpW2cioKic6U0YP7?=
 =?us-ascii?Q?JwM2/EWunn8+VAUdytRzMRByFeMXGpIm2WCMF4QaVeKNM?=
X-Microsoft-Antispam-Message-Info: RsJU6+JevctAHjaPh8gQVg5lZThwgICmtX2UAJU86IFOzwP6abTKG9Kqe7G0kllqQccyPyQUZl2HNNkwYYqwFoqvUBGS0pwVEjnaXJQ2sMv6MyjgaTiXoEauVkcHcq4tGdWTEuZN/I3/QUXO0gN+Pexb7qZnRIbOu/m6xIWNHDmZ3qKymoAOydPgMLf/gYbW
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:cd0ceKIfac/IqyOqtpcDtPtkbx6lj9o92xgKdTiBrmVBvH9+mHtT9KgtD6SZEbA302rciioUtfUw0KeWR8jnBJ/2nSuUQyU73lmi41L8mwbE1526ZhM37vQTS16ccczEyDHrfKzWbbflMZYK6IjpzH1Tl35ekuapWiRMZ/bwaWZ+ZIn0bm0LrE1VJHyV4X1EDuO/vfnjDpJVt5qcCev0etxjXjFFwrFdEkoVLb5edxZUPodkFGqaU0AxWbl3iZfwprbpzwfA05zswogtdV63E2kb3eTKI9XSmAMJaelCfPhXKwSlAbGVWc9pkDWDtd3Bbl3IcLCBqPvkCitptDKriV7OoTiLEG6U3PSQXayS6Uc24THm7vftZ/L0Weu35WTjzOCOaojcYDYILVe00vASmlMpFI8mNWDdXP07WRTuUKXfycc3Us/sDkVoLDE+dSwQILlczFUFMxCA3tdYj0WSlg==;5:q2ovZRD/CTRnmX7Ni7z6ce7l2X1k/caMDWt0lH9O23La4J7QAjiUfQJ66JxHSQdX6bt1HCsFLgxbhKIuOktRuUg7dgH8dKOW1ad6BPLcn52qMn5BLggzodPsoppWAW3btJIfpVGxE3rXVuW3H6ug/fnHVi4YLSa0DHHXsQUo+Ps=;24:RMcfaqxF1eQLpQlnn/JRTG9pq9tdPrJJgIfMs5HkMAaAMMnx+dLNok66XTAX04b1cz9eZopeeSYTst4xsatrLhUQJS51dLDeobnFpY0zG/M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:z/JYu2HZEc+dOfttTZnXfGSXbGgnPiz6C8ADLNIXnSJKCOUg1wg+BbFTVqP41SE6FfLpC8cmk75IVo0aK5Fj/Ku1bZXpZOE4G1mOZ43qiwkNHekJsdobPnsKA3L9e92pzVroGIlxd/z0x8HJdr1zFaN5c1cSyUdaoBdaY5zHXK5Zua0Ay1kfSUEeK2YpkNexbhwyOeSennXWtktQaAHerk9HudCUmWX84WZVIZHu4O9A7/P9L5wIQnHNFuoCwoHZ
X-MS-Office365-Filtering-Correlation-Id: 3406a44e-7f9a-49b2-a1b4-08d5a44db873
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 10:26:40.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3406a44e-7f9a-49b2-a1b4-08d5a44db873
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597988734561955050?=
X-GMAIL-MSGID: =?utf-8?q?1597988734561955050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

iommu-map property is also used by devices with fsl-mc. This
patch moves the of_pci_map_rid to generic location, so that it
can be used by other busses too.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c | 106 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/of/irq.c         |   6 +--
 drivers/pci/of.c         | 101 --------------------------------------------
 include/linux/of_iommu.h |  11 +++++
 include/linux/of_pci.h   |  10 -----
 5 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..4e7712f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -138,6 +138,106 @@ static int of_iommu_xlate(struct device *dev,
 	return ops->of_xlate(dev, iommu_spec);
 }
 
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
+		   const char *map_name, const char *map_mask_name,
+		   struct device_node **target, u32 *id_out)
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
+
 struct of_pci_iommu_alias_info {
 	struct device *dev;
 	struct device_node *np;
@@ -149,9 +249,9 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_pci_map_rid(info->np, alias, "iommu-map",
-			     "iommu-map-mask", &iommu_spec.np,
-			     iommu_spec.args);
+	err = of_map_rid(info->np, alias, "iommu-map",
+			 "iommu-map-mask", &iommu_spec.np,
+			 iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 02ad93a..b72eeec 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -22,7 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_pci.h>
+#include <linux/of_iommu.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -588,8 +588,8 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
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
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 4fa654e..432b53c 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -15,6 +15,10 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -30,6 +34,13 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
+static inline int of_map_rid(struct device_node *np, u32 rid,
+			     const char *map_name, const char *map_mask_name,
+			     struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
 #endif	/* CONFIG_OF_IOMMU */
 
 extern struct of_device_id __iommu_of_table;
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
