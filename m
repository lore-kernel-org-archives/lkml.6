Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx4+qNc7rSmiVdE87udm7YCglnRJ1RETDz+313yunW6Jq2yaQkKgIcJ+tydKLuvEQN4H5/jJl
ARC-Seal: i=1; a=rsa-sha256; t=1523960802; cv=none;
        d=google.com; s=arc-20160816;
        b=JB/C4FtmxzPMLFolBs1Lz+oBuuKfzijnig+qsaV9B63n8YEfxRQconKyrgIBGK3FYA
         QXoNmFFB9Be6rJmkEFwQtjE8lbXiHDBK6si86PwGjKS/1edQtKOPfK6Jjgki5LtPEeAn
         nWd6QXAA8C9oHRxfWG0GJnW4/dTWTFanScCi81DAbSPR0lvR71u81mTYIOG3bDfR7Qxg
         JaOloHV2uCSoK62SHdBClDpGroSMLBHvhUMM2qL102yusArDb4DzHzhduyY3sV5ocH3r
         lkGaXuQsertPoeXvpjZZ/2cUicruXzpS8Ga4kODwRVXYUXLiJRRJBSLgZeyoJ4y6xUam
         97/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=u/WFSTb/EACS4rWR0ioTSm2SudUBMIHYgcb6KTmkIRM=;
        b=PzzZvYgj64K2Etfv4bSJEQEGHWJnswI2EE5NDYOVHbOx7AeUGlk5I0bUM6PHoYDU1R
         Bt+2OAp+MTcQ+xrOPX24kTE4vfcLaMRH1cyVpLy1IqbUE8xNeaae1GDyb/C2hcszWgCw
         lmM11pyE/c94SvlxKuZONAFqYkpz5C7ZC5oNQm1otxYk0O0WcNtSlnWOBegseUWRQWBN
         NI4yNSiBSwDze6MSrkn8XI3Nb1Nqr1FhZ6Dq9q3PpV5cWSWnmCBxf3970xIsfty+2Y9y
         SCsd+okj/OFRrD6zHHaAiwdcZAQbOUS6WLdkWYISvHV/Tfs11Yqy6jnCShgXLv6KaMAC
         md9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=rlu8BhW2;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.71 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=rlu8BhW2;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.71 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 1/6 v2] Docs: dt: add fsl-mc iommu-map device-tree binding
Date: Tue, 17 Apr 2018 15:51:49 +0530
Message-Id: <1523960514-25457-2-git-send-email-nipun.gupta@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:ggfega3+TqFnbZMwGJqlq2cN1yS8yKhojEpk23SVM/Y3OKcMhspwFCNg8GldUF6TuJ9Bpn8rPL3rvsh/CyijNqcfdguORCcUODPaC030yisko4ERsyiSUZr0Aq5369ATn1owJiNfmPrEiStYH9I/sHYqVM7cJiswYWuDJ/dirEeLhyXIDnXrXhfBDiBK+8+ppDSwVPp42alID9Uf3us37OBNOi6QPX52Ajx3MlJVoYVdGZKYxxXYeeCbTplvT9HY;25:V9+cqjn/+DsD7gyb9ECORn+X9t/GHtQ/SKFlwyCD3cY3QcgbGUY9fCa9U+NrQWzQLVeWq9+vhrOHkAvzRNQ1n4L1lo2gyCxBP30qS9nsoXqRLtkSeB2Ukp3bUQMMOXI1brK6kLFb/L5Ige15Kp/Cp4MPXhTUDYNlNWTzugWNTjOhBLPLC3I4byBM2HIHpRuM8bEbEsY3YgpFOvJYLvSLDI97oSsXI77mwN/kqpATRegG+CXao4a/5PghyuyMSSWDNr64sX7W96uVrdaRg69gwmSkWACx87y9GlSIZ0kbP6oQZWNf4kypl71iRhcsn9yqHvhi1bXBU8/FAwDEIiQmCA==;31:6swpAnRuihJtRd7jJiJY16k0QzesqyyFtz3FqxVzKWIPvzEPsem3y+mXoatQXvlfmx5rPXVCdkClc3hIUv3kF/msryi5BDtYluzJFT/qrVrtK76gQ9kXqPpP1REl1KkS6lp37fY3w2RL1DOiYYiVL6MpZODfH/RraGhSgAuxVMANA5B/nNz/hEmwH7yH29ZA55dy7w+5dphm1p3VeI86n9eAk7tQ42kVLp3OkZC1lkI=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:5dyapgW0XkKSxdgOLWPFP5NdaozA3jDCWxMft1vSNXXOAZ+HtNuovr35dCo36QxxcLYFzAFkOkT03yYWoLnyF7+nRTa5wWQRvUzhV2B5lm7p3+BVSqmSMdYXTMkT0gv4yOtgUqgzVfN+L7wXKSXNn85IW44zU7nuyy896P+fcMWG7qlwqVes0yl3PX938cnGTCb7VC+9P+zzjLvmcBh4myIU0HLes/ZZcoKMgu9WzWScIG1BocDBUXbVhrZviCBNPEcg8Jylm6wwZozxKkOHA0hlv21NhC+ekGqCbv1y6XzuRElBIARmGpLQ+vE4T8kASpyaD8Lpaw3vAgrMXtilo+S1rwuPiiBlhp/NUokwQI1WBqONCzeG78jC8iteFnjRbIHbAsjgYtmP9icI4JwnAwGrXJpWDCwVvT83d7kmq1lBIDB/ycRxK2fF4/V5u30TYoH9YGVZaouvcvW5UpEaLwkiuAJPzGSCnrBDQG66tLwmK+nqDtvQPG+5eYOOrC8Y;4:OLBaqanT5MdAK7DnprBHPgWDXjhje6KYL86mJcUZqpPZUQA7N9rSyWdAnnZ8HdteyJt2aT1i8gdzgZuoJ83jZJglaH3VTPYCQyFPAgdP2KU6Af1AL6GtX6dx62x76Hr7uQlPxGBqsuTYNspDGDBUADZhSyA3kyJ4MBqdqbn/iORDK8hoTKvlX2sRcrEaCNKSWxADkyNJP5gaixyOm+01kJ9G3LmYarbg6PFnfLlQ25+P86HvdxAe4fbUfh0LL9VXiD/7Dll+bEr1egF6IBfSFolHCq97DgzXikg5P9l8Tw6gwiRlOuoMjAbaz1+Vqs/57jpDnjkbGjBZQDoysKU7iFlpnBhAnHwMb0PZIDxbzNk=
X-Microsoft-Antispam-PRVS: <AM4PR0401MB24185B9E9FAEBA198A114E16E6B70@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(6506007)(386003)(2616005)(446003)(11346002)(316002)(486006)(97736004)(956004)(16586007)(76176011)(55236004)(6512007)(186003)(16526019)(44832011)(48376002)(476003)(86362001)(575784001)(8936002)(7736002)(8676002)(81156014)(81166006)(6116002)(3846002)(2906002)(53936002)(50226002)(66066001)(68736007)(5660300001)(478600001)(25786009)(39060400002)(5009440100003)(4326008)(47776003)(36756003)(106356001)(305945005)(105586002)(51416003)(52116002)(26005)(6486002)(7416002)(6666003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:BziF/vjNnMzM/WYM5jbUn5YwFmanXQwhf/vA4cl?=
 =?us-ascii?Q?reqlPvWI51Pp8ot3nx8kFP5cKfGoxizx/4oUR4tregneI7zDkj/4TfIpyFz+?=
 =?us-ascii?Q?Bs6UmEL6WtQVB70vAkJEW/dOAHLoqM9cf4z7+as5NEXs7jI+fxAZdcDU3CGn?=
 =?us-ascii?Q?6g4JHtJ9WoXwvg1oAPOQRBsFml/b1KmNxLiqJhgBOad6fRPXAdCHXirFvptU?=
 =?us-ascii?Q?WgWft9VqfifMLohKDkZ6qiy0HgvHUdZ9ChKagGiXMuLtwQz8sAnPwsE4r/66?=
 =?us-ascii?Q?UmUj7btrfVcQoQwcaPWJZHQy5nlce3ryhp1TdUyp6WErHB5OO9gstGTSJ0xB?=
 =?us-ascii?Q?Kc4WW4toDD33I0lGqM8y5JSv55+n6P3uoScz3Tl0IcxME3jI97wlKvZDYDL6?=
 =?us-ascii?Q?mNUeplBH8sO+nrlTrz5e3RP4NLqUyt1B3m+1ZTchdj9zCMLVKzkgYkQdVQlg?=
 =?us-ascii?Q?0XVZAS/d1NvO1CL006T8GW6vS2XO2mqOz8PBv/ILD0jGOrwltAX6m/wcX8mu?=
 =?us-ascii?Q?IKYrQw0i2QdOztE99ce7w4RIFHzmx3t/b8UAZWOmhBfhuuMyuluqzdB17IP1?=
 =?us-ascii?Q?oZnG97vLf1tt2uYWklD2ARda2z7/K7ShlGvXiIjo3tIPXMJark1wXZes6y/h?=
 =?us-ascii?Q?szFdn7RKQ/Ouo3FsVT3DwwaKqkaWLC8vuxjPOrZYh40+KmyHcWW264HRHS4g?=
 =?us-ascii?Q?sdEUjZT7kEHixfkfMOsDxIGLOQC6DcxOjAhE3pr5JvITlXFbUPLXWf9GwzyF?=
 =?us-ascii?Q?HroUN9PbQYLlIdLD4v2h9ok1fBJZhDtGnjNegA81tkK1PSfyGOrsxuIXHxAU?=
 =?us-ascii?Q?VjXR+XKvxqgaQXanxGEjRzPdiDPYhao3jPABi5QxRYxezecl9c3WWDNr2xhU?=
 =?us-ascii?Q?UKDOUrxQ/W44VPNCgfbxU5YZ3S8B2V6BGznO7q4RrRUvQALDrlXnKyhqdPV0?=
 =?us-ascii?Q?57iACM1ExX3/fHtTvHyPyA8haRXP22bDgdggzdUnibVku3oB5dKbzw8y9cfY?=
 =?us-ascii?Q?N/fcn1JEPKTO6nVN6mL88xcvsajz5r2dxdNwANnPGCl+EUe+NLMo8dAXcoHv?=
 =?us-ascii?Q?nv3oSEdnvswBpBjNNprpzUmuBVSfciX1YmRr2D6XASsnFcj7UUc6aTFSFgiZ?=
 =?us-ascii?Q?jftwQ4UzXTS0WyHvAw1Fm+DbLEayMAsPMZLbPhfMpVEs0VJDvzEDCn7luqng?=
 =?us-ascii?Q?qjYX/K01xobnwckoM5piGvBjnWzKEV9kg6cYu8j9jI6XaIVn7lz7mGhG19cg?=
 =?us-ascii?Q?IfBmOxn7TQ3syy6Y5E/yIwKMBc0x5ubRyiapa9D+t5sM7MK5WF0mgBMDABH/?=
 =?us-ascii?Q?WgD5UUhQvG/BdH2Es8VtP5a8ZLxhg7goM35EDlbUSR50g?=
X-Microsoft-Antispam-Message-Info: xiMxYzFdVo6TlT+TLr8HtIobG+8CiHlyGbdas+TPmZtoDXIsSgdwBaY8FBz6MTuUiL5WDsXWGLyEZDXbmoR/mD426UE8KckDxxFxISYtJMe/+6aSTPjn9vtUDBgKjppY2YsB9rvdiA3vCR4SRe+2Oma94xnHOiNxGgUSTImg8t7ypC2ETOr6CaLizah0CDIu
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:Xs0tBzbvPgaj21zoN2Jc/xdqzVKlvnL0TuoYN8CPcawiUGk1b+b82baONVrdGIE68SrdVh0iFbvHe4VatxVmgambSl1c64qO7A/SkONpBpnxdUopY3nmVeIzY1cCEhWCe87iwYzNxXNCw3yTR+rH8crBgrBn0jVHuT8y/LAHgpq+1+rUgYvyizs091JAsEc4fX2VjYUlzBTitOvmCfXYdQCjQJocRh9z6VTaX+WeEikQMgsRVJUv9t5h/YnBnBNM47TF+oxdX7QDBWFbApO6WOVar5ZUwbstC/bEh76BH9TNBQEB1+i52WwAmCYSHtIBkSies7OeDvAlZth806nZE542qw6vlI48kTh/61VQx6aCDQYCq7fEBTwBb8QWBSMd5hWBV5ZiNnr3GnOD96jkOXXJt/2DynBnqltzESrpkcD/MmVfZyANpAkOvRr75LAfKnrsVZgKMVcFqEuhI0ioVQ==;5:WTTnMOYVTlVIF9kaR8V6tUfGbUoaqazxVr3FSw/wBYfLHvjBV+gLsIMC1B1GKMmXTfhqbxVwfEXecRsk9ryBJEavUVn7pMf5j26AgV2Ke6beK14HsH9DzED56S9zXB+IgsL8gvu2gdGZoX9ShtRIe1DS/pOyDnfbG44GGiZNqkQ=;24:w+eAFZpt4XcvfmwgFQXDppuVKd9ExoDT/3g81yv/JslFkc+mtBQyh3tEyvZ0GgGRABifCRkPbUyGte0LJN1k1J0iNzA5LNv1b8/IH6Gwiww=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:eSRIq0vbAyhPfatv07KsACjZ6km/StGlqKem8T0Aiau6GuLWOTnFmT/+XJnQueeRlkOMriEBbZXY7Ue3KnDxDT/uqPcGx56i9w1X6WjD4bFfGf23tkS2PIB8soGcdcutWKxO+wxjgcfJduF0nlU+baZ7A5etWMkLhA1kn7pviWcyeZnmbhHEefRMATeYTRZ4y19K1yqCCRzLKg89qqKVEeX7Xj9cGCJRAUByiE3BvgQRB9U10Q+thyYzZWFOtlLU
X-MS-Office365-Filtering-Correlation-Id: 0d2f300a-d716-4557-56f9-08d5a44db4d4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 10:26:34.9175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2f300a-d716-4557-56f9-08d5a44db4d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597988722461631355?=
X-GMAIL-MSGID: =?utf-8?q?1597988722461631355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The existing IOMMU bindings cannot be used to specify the relationship
between fsl-mc devices and IOMMUs. This patch adds a generic binding for
mapping fsl-mc devices to IOMMUs, using iommu-map property.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 6611a7c..8cbed4f 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -9,6 +9,25 @@ blocks that can be used to create functional hardware objects/devices
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
+The generic 'iommus' property is insufficient to describe the relationship
+between ICIDs and IOMMUs, so an iommu-map property is used to define
+the set of possible ICIDs under a root DPRC and how they map to
+an IOMMU.
+
+For generic IOMMU bindings, see
+Documentation/devicetree/bindings/iommu/iommu.txt.
+
+For arm-smmu binding, see:
+Documentation/devicetree/bindings/iommu/arm,smmu.txt.
+
 Required properties:
 
     - compatible
@@ -88,14 +107,34 @@ Sub-nodes:
               Value type: <phandle>
               Definition: Specifies the phandle to the PHY device node associated
                           with the this dpmac.
+Optional properties:
+
+- iommu-map: Maps an ICID to an IOMMU and associated iommu-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (icid-base,iommu,iommu-base,length).
+
+  Any ICID i in the interval [icid-base, icid-base + length) is
+  associated with the listed IOMMU, with the iommu-specifier
+  (i - icid-base + iommu-base).
 
 Example:
 
+        smmu: iommu@5000000 {
+               compatible = "arm,mmu-500";
+               #iommu-cells = <2>;
+               stream-match-mask = <0x7C00>;
+               ...
+        };
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
                 msi-parent = <&its>;
+                /* define map for ICIDs 23-64 */
+                iommu-map = <23 &smmu 23 41>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
1.9.1
