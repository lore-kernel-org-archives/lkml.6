Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELsD1swxrmbmRszCbARoK0VL6Jhc1N5JLVS6SxHKAGrDQ6/V0KjjpISUc10ODZHv1y0J5l6c
ARC-Seal: i=1; a=rsa-sha256; t=1520260211; cv=none;
        d=google.com; s=arc-20160816;
        b=tNKuVDIO1k1P7jzN1uz3H7VfZA515ky9iBoEkQlbqz3zWlRfer7AD6V4xxAgX1JMvH
         W6OLXfWOOS6n5cxBFaOTR2VOmwUrfiM5W2/BdJv0wOOJ/3bFOIMfE3a7/z1srObyPJlv
         ZvJhYKMIDz0jZ9iLJeBwQYtBF0GAz/1OW/8dPzJnCPmlf96XLNlKO5mVOdCr7lmPoaFh
         k3tiBcB3cE0fOmg/JF8VidziVsCshHfAqU5jwS3kByZWdRrjIbnDC5KQDzwk2L6/Kc15
         ooez9LYsF/VSC9XW5/q5gkK/QbeYEanWtu5pbSieM0ynQ4a6YU53zL+Mp6/Yq2Y/L7L3
         8S4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=P4DHSm7cbQ4anaEqY5I6fGjf3qmkiJRqTDPGrTjYMoA=;
        b=CAudPIBMf/RzBPE8oCH/lAu8zYhJnYTP/Z5LwNXoHSeMcfyP7xNdIdhrnt0L+HiFQd
         h2Vo3WAeXC82v4Fg47UcSamv/KJ0suBhXpGgj2dvOYoVxf1Ox/F0rmREWAvwPmmNKvnM
         53OO7r2ieN7MjtaSsi4n79nbbCdBLWKPPGz8Av9PUKBIgCneUsx5b19LIKhNEAF7Thwf
         o86VNpjYpmJTuuVjSjsbxYK0aj+3tO+FLecmsZmBIPCCfxq7abYQD6ljQB/BgDccuC6N
         o5XXyHZSVgzA6SWG56F9MdnYHTLLHIXgSG+3dfpqt00iFGOFDFNayvAVuaHlEPjUOpm/
         O/6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=nrfTWMmF;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.40 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=nrfTWMmF;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.40 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org,
	robh+dt@kernel.org,
	hch@lst.de,
	m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	leoyang.li@nxp.com,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Date: Mon,  5 Mar 2018 19:59:21 +0530
Message-Id: <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6086fb77-287e-42aa-1afc-08d582a597e7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:XMv7mRQVrDbJ3Slrgo/joYY+itBohiXUS51l6w7tbR/eCAkeoFTrwmwwiFYOkEd/2hpAXuXt62ylrwARCCetvRsnNa+XYhgWY/+Twp688Z1o3kLaEuFPHDWO/jHkk9cp7R2lZmpEtK4zFyeIhqHGjFyABp4oZX8h9Vl+2XZRoNHzyefR5RdhxJUw+8O9WEauUGozRXwTOE29/UEeY86Tmykwi5fowFeZi75+IO8CnhecIvhIyNL5gPyTzWhr+JV6;25:bwiui9odmVc/Z2BllCWj+cYdmtCDx3S2avHgEKVB0NMPTCpIp5qg15Nt5zjhqWyG8xChevvdSzUbDU6KRRMc5AZEXEVApKR7ZSGYVZ7QbI+qcoq1o95em39Dxap71P0iBABPFLT1LxpF0e3Uiq+5Za5qdldOiUMD7SDEcf/SwqvuTEfnuwQ4OQsFl3JSwGSGZIOhESsP2nmrmoTzTFSnBcJOf3IfqaCU0vZuGKQ48OyfRxkbxviJVwhymNw7MN0qJiBQnfJqZV4Z7WkD7OT1yNJkc2G97Pb9JU55GqVWbhKUKeTr+ncAfKKnbwBS5QLSSpH+QcGwNIrgxzCOpoEPvg==;31:C+alJF1/UviTaUVhOnHayp2hssKhC7wny7jShgQd/9Q99++MsasvS0sX8+rHkgOONe/Phk8srIONM8taR0r2jT3Rsro8AIdGLm1T/PyYbcy9d94XN6ZA8WhDwhrPldu5S/QCV8QxP4/Dcwi+ev3L5qS6DOHEK/AFZfoldgh/AZAl2DQy4/eAxYNgXDc0RDNJH1IKplGjCFF9ZGyioN3p4fGFFvYK9cMrX9a9ziq6sdU=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:YZduhm85XDXw2ZKCYSNpDqhMeHw9WEolfWrceDFcKd25hD/kHHU7gounhqUR5wNf1U9OKU5mnJRPZtk4iMnuZb2rhlxEm60E6hamHfiiH8M0rYAlslGDc9nwmExWhYMzFDkwlB/wmWF9GBzqUJd2wIJLnTcEIufzJS2RsqEJA0aI6/YUnBMrN96whJq0icCeYsrN+fvvwe2dRp0MYtVsU3PVbnXVf+w8sXeg0DjFLYmjdAy5D/kLgf2plcBO2YiBBPdeGgV7pCcj59ySd15lkQn2fycodbjZfslPzvhJ/rAd27Cr+iXy3EyxeEMUNWuJVlYHlBWkvLY8MUoVPgfOdqCeHksV87m5Ckn8vtpa7wpsrnsWlkC6GrCDATGH/Qa4BkcN3+zzrQbnyQQSPG48N8WYM7mLP0KZbFw5lLf2NRqPBwJj763U9OiTKAWcWTP0SBhOtmeOFjIuddpa/yyQuSo266Wpv1zB/R/W01iNAMlyfyQaEQYqn+4o9RUUNJdq;4:lTN6RvKLGUoqxh00OUSAP5f1KKtV3ENnaUpgPja7ZNb7pB4POPmuTUAwzdwZmLXzFJ0/Z5kxgs2MPERb+RVS737w0FeAoRkOTKJRwNKvyCq7X0TbqauKdZOds8FNpSnV4l96la8GTQdW8wKpX1TYK5R0E0cN4/38n8f5+1EG+96RQlAxoAKjh5f0YBXPYX4cp8Ealv2BAS4MmZDHU+H1JWMT/a95VgJtddFfLlrAuxTJk3dt8yFzQ0lkCejxFio/GWrGRfH8GizVwg3qSCr2l5LN0ztlhGCSdnoyTGYMvkAc8QrchMKDYHi/PH/exBjIT8/QS1BA79MIlbdmV91yiBO0027qwQuCpRfRLX1PU0o=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2425DBCAAB8AB1ADAB3C2433E6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(189003)(199004)(2906002)(47776003)(106356001)(6486002)(3846002)(4326008)(316002)(39060400002)(25786009)(5660300001)(6116002)(6512007)(53936002)(2950100002)(6666003)(97736004)(8676002)(81166006)(50226002)(76176011)(8936002)(81156014)(5009440100003)(386003)(51416003)(6506007)(26005)(16586007)(48376002)(52116002)(478600001)(86362001)(50466002)(66066001)(7416002)(16526019)(36756003)(55236004)(186003)(7736002)(305945005)(105586002)(68736007)(575784001)(110426004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:WNp6Vsfq0eYvOJJswtCFCPuTERgouV53lwnX7dA?=
 =?us-ascii?Q?hh6wNNNhAkrghD6sn9vSkNi4CpKdqhv0osWtt1ALS1h5jQf+YNhU/GN8YYHi?=
 =?us-ascii?Q?CGLa2YJyRz66dUtvOUzW8SBjcJKAAaj4/MmAQAgxnueDocGP1IqMTJUWbjOd?=
 =?us-ascii?Q?MFwUqBtXlqA4oTLgzxts/2WwAcJJodmtNwvKcAtbkP6zEQEbHqHDFkgyHjdk?=
 =?us-ascii?Q?1vVEX5vd3gNfFugrP6ZguOuv0fM33XP7M8AJbO6rMx/TSqYD5FqGO9MnWQNk?=
 =?us-ascii?Q?HntALChWkK+DwQIlJbwbrhe5M1TWbkMBQ1qUj+EuJwnrGG24Xc15NmpqJjfv?=
 =?us-ascii?Q?1wnxHYZQ+vlHt0VqtQn0vdm6Ki19BSI+zz5wsq4aPFnR/j/2xWiirlajeV9i?=
 =?us-ascii?Q?FIpfbFrXrFXuaYIAF2VWoMHmlKQoAPI1ZFQahPXTp6fRCe/zdkEW7VKlbLBf?=
 =?us-ascii?Q?a6QTgZ2yXfYl1SroWNmikQBogFYQN30iLou2Yf4tlXe8fvTTWUNv+SPq7GMX?=
 =?us-ascii?Q?SURh/xMn/1c76uJYNdWXBdy9nV5S1gUZo8zK0pVmSMBd+nqAa1Oedq9q7dbO?=
 =?us-ascii?Q?OtTu1+wNORchC1nOj4rEhCFxc/GzWk5EXP+cyBJCCpQwwDLdNNmZE4yC4I29?=
 =?us-ascii?Q?CIAtmvPXL6e+p9gVCiv5GmezzGcoGMN39J3WBXVHvJJsLOIl+n+/MQixyW7p?=
 =?us-ascii?Q?MhKjJqU52aI7PuYts8Ovk0ELijuPcqwzsNyUj03IutG4NAPf5C/GQZwRG41Y?=
 =?us-ascii?Q?zB+Bqfgb15v4Z/AdNARNrFS0hpNcoBziaTxWrvVbLUoCVDuXi4C4hy/HiwnX?=
 =?us-ascii?Q?Fuagz0Yk+5t1NSflFpPKx7rR/mfmNw2kpDuaKfl7lbuImnlLET47rC4xP/yD?=
 =?us-ascii?Q?3MVFp2MC37d3j0S7g/BzDms/83ATxXmWn/zgPADNoZvtew03lpZVGy0GTC39?=
 =?us-ascii?Q?EgX8gfhiFCsPoVKNHgxxJKoY5jNpnie9hl+7BxnWrVd0uWaRU1WqIcfoym9d?=
 =?us-ascii?Q?jbRN63Sxzo63wKSUI/Qvp7Dvp2W9b/4ZkCgOgYt2qns7uWYf95GCMDdCj18D?=
 =?us-ascii?Q?yqZ0791aYawBPWwglrN1GgaiUPwh35GGNLQddmmH7Udjxh03dqhrmvc8tkHJ?=
 =?us-ascii?Q?xEa5H3AyV1GdmbRDIVJq+66jqIgHG+FhkLBkoLOP7UkTA6gsZpQNU9KB3TLT?=
 =?us-ascii?Q?6d33B4sJ49HHXPraiwrZ0RUYjXRvfgUtLP8Jcte+SgssKy04gCMBAzLNeYg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: I3ylzAmt7diWcDaqFYVFxFTu5AP/Ax6C0aVEvPr62IyQ2aBwcOdIwmxCs4TfAt7nTk0MfXcvUMm+DdJ+4llstrhSxlIBehN4gF/1mEkh7ivlPC+9jy2YFfOIa1i5eAitqKZjoe0vM5Ovi8ZOLaZoRJmbw/J8e26CkX+bdQwG8moHFLTF47riZZBBxJcUIL+n
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:9KSF3Y7PTGUGiESPj24ma3zo8k7LPj/GaktgdO6IXaxsJpA1u4esj5gUlh8M232P6ftiJI+N/ehvTa1tLcrDar/zVkMCXiXK0+7WHZE7uaT/OvdJCENsm8VkYRcsbE7YQVJmsRMEIGeFrXzZkktamYSkvvHal+SY+/sjbLi3En3kbeIPzSie1kDuvMugPfJD3vG9M1MGPz93LNhXiAcQhDh7bgKbLD4yd9VS/PvfMkq9JSlyPiFqroetidZqtjZ6MkUKHzsv1uIQ3xR0EYZy/aRkLLzHm+3zplmJ6RNSlkec8y6Ikgm3Opf6iTDta1Z0TxQvmyZucBlP/wNmxOJpz6jhBI70UnoNhXolfXZRn+I=;5:kWhjE0SPkuSRDBJrgLDx0/Ek8nbkc6UGhURBxeoC2Tm6tyeJK9/AW5moLJmOp+R1ELNltz/Mt6EFgk4plhaJxs12xU+G0M4x+6gzl/TxBzYfjtwXNeJOUG05yS2BTDkXt0Dhb9UqlmARe9UerMNTvAX8EluBX+j40FW3/lW/XEc=;24:U3saFlroMdp5gQ5EWwuuWZKEo2hxDPDwkvZh9ORqcYbfFTPpJi9u0IvP89srIKpdI+1N+m5FRYb3bHgmm849Xuk4+j5Y9x2z+m9baOUWajE=;7:d2uESrdU0B0OylJPCLrtgnPgQiacjMa4iFbvQyU/sYCa9eeX5epA2Wc/DIpKMIy53f2BmAaUE7xzFP5b4/8kYCQNdCIPNGHkLydaS18USDXSNCnWorxNriU9c4qWBnIdVoEF0zee7NjfFlj19D/7zargIG82x/RZNzgNQEfvIEl/3J2L1NpUDeVg6bDgtwuQQWjN0ANWqa/l76wm0Cj9qxVuFG0Ju+ZerP+uFSyNOE6qKsN28DgYHat/qWV8cc4T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 14:30:03.5950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6086fb77-287e-42aa-1afc-08d582a597e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108370915742934?=
X-GMAIL-MSGID: =?utf-8?q?1594108370915742934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The existing IOMMU bindings cannot be used to specify the relationship
between fsl-mc devices and IOMMUs. This patch adds a binding for
mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 6611a7c..011c7d6 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -9,6 +9,24 @@ blocks that can be used to create functional hardware objects/devices
 such as network interfaces, crypto accelerator instances, L2 switches,
 etc.
 
+For an overview of the DPAA2 architecture and fsl-mc bus see:
+drivers/staging/fsl-mc/README.txt
+
+As described in the above overview, all DPAA2 objects in a DPRC share the
+same hardware "isolation context" and a 10-bit value called an ICID
+(isolation context id) is expressed by the hardware to identify
+the requester.
+
+The generic 'iommus' property is cannot be used to describe the relationship
+between fsl-mc and IOMMUs, so an iommu-parent property is used to define
+the same.
+
+For generic IOMMU bindings, see
+Documentation/devicetree/bindings/iommu/iommu.txt.
+
+For arm-smmu binding, see:
+Documentation/devicetree/bindings/iommu/arm,smmu.txt.
+
 Required properties:
 
     - compatible
@@ -88,14 +106,27 @@ Sub-nodes:
               Value type: <phandle>
               Definition: Specifies the phandle to the PHY device node associated
                           with the this dpmac.
+Optional properties:
+
+- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
+  The property specifies the IOMMU behind which the devices on
+  fsl-mc bus are residing.
 
 Example:
 
+        smmu: iommu@5000000 {
+               compatible = "arm,mmu-500";
+               #iommu-cells = <1>;
+               stream-match-mask = <0x7C00>;
+               ...
+        };
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
                 msi-parent = <&its>;
+                iommu-parent = <&smmu>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
1.9.1
