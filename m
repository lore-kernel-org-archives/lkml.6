Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZrfpYGFcy/Isidzw0nqFsTRlTPR8vr750pQDOQlF42XasyPfEA2w/4gxQMD1nY6KO5XhXUF
ARC-Seal: i=1; a=rsa-sha256; t=1525069706; cv=none;
        d=google.com; s=arc-20160816;
        b=sFcBbAH4dK9PYwE0Jsej/GXB0+jUWMVLJZQqEkln+pYbY5MuNHUpOo1AOZdKyAN8IG
         R8+gQrVkM6izSZ84Mu1M6k9ElbTA0mZMbWSGdYECIOujfhqjywfbe0ONcyeUwl4j7X42
         ZO4LQ+wWeBvj2J3TAmsnYcR7Q6B8/0FwP7YZ00754tzbdGs0d4wFq/7DICDi/mJs4L47
         k4A85pDjXwFyIYKVl0wczOxQDscxHscnXEOC07IrzBgD8rmYOeZIiOfTrWYiRX++XEJd
         IHYjkBUnwWFe1ZMirkpqwJZyy2L9xexsyLmRmq6/9Q3fGaCZ4/pz0KkBLeCN67Yeed3O
         1FXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=d9h3X6nH80a78dCyfgRM76QM/OR4gGACQP0YP49V334=;
        b=ozw4qNsRx2KonzeJDtvSbwfiyLmLaH/s3aXlg5p6PYZCX9g1VttHRpNr6qu35/UMp2
         3Fm9eSZ5gWJnTKO06TBDx7aMNG2iEXV321a17nz5/l6SNGvMRbMSwlxfVHKpEQZ7w4Xf
         vs07Dbw7Ow4nbbAFVbQSbbJCV9g/Bm3auavBR7hjZb0q6UbYEHZs3ZvMPKT7wAI5v4Z9
         100kY58FRXjZZbHFOs3O70UBlOAPJ0SFepm13/sJNd03ZiAywkBM0pqWxa7TblYa/yrL
         depnpvmQjCJ7b9HGGmFPkmz/NQWIsyP1i5nCWJnYYPZGrsJG4OpSnj6ColQ9TTMW4tJy
         T0uA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=rVcn/qem;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.67 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=rVcn/qem;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.67 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH v4 1/6] Docs: dt: add fsl-mc iommu-map device-tree binding
Date: Mon, 30 Apr 2018 11:57:16 +0530
Message-Id: <1525069641-8523-2-git-send-email-nipun.gupta@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:AX3XmspH77RmosMJfbdkg1UGx6+8LYJPez62H0X/wsSx30gFd7mqJjRa9BASL7jSyRR1IxHvRaUFKVoJr6ieFjFkAZ+4OJGWkzxNwO8IqhM2Rc8F+d0zPpik072OSVVKyrTtqMcnXCOgpYFOegIru4akZxDKsV1CeK3S+NX1wEdTPeM7HeYptkgKK8wwTWr1/A70Injwvw6QMkkxky0tQ/leQihsW5DXAaXExUTuRqD3LJegoahvJnCOpvPa90H3;25:a/cRd7J8MylNG6VxO+IQknY575kbYntaB67lQcJb/zSA2m/rrJTFE7ju9UUqIZM47+z8mtNUkqynkP22+PTKtvRXJ9MEeBWXa4ARBHaVJnYxwylD99+5aO+GD5RnCjblBheejzlDw8uegkmN5gsk0ddECyX/lvnFMt/0Ppc94WbNdGWBboSJLUtsyjRZ7ERMH5a62JFfUpv/UIZmeOry73KEaI68Y7yarEUz6Eqrgsl01TUGigmNoVeUCb2yi0uj14FNmBMgGScinU4dyZHP2qv6/NhMZls49LNu+uy1U74T3cclvu6YzfOeT/TLT/UYFkJgxiZCJ3JCUnAITJ18ig==;31:ZfeOUuMtFW7ZmUwH3SzHkgOx5Jm0HtdgxN3RG4MypnsDtS+1MxAU77ELdOmYq74UzzgUujb2HT8vkRX6Uif6EzQQ5uGN1cDXTEO03HlEaGNAXaA8X1ONRIbpNEvDFTDDZKsCnyig0HCcVAISZXkO5bmJsf41HAKPYIWtQmbQF7Pnt2A9DOpS2o5yUmopGyzejrZrAZ2tp5aQ+JgHvmt35wYAvqfbOf2mu9+7Fmk3YVM=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:vzmO/GISd2JZloE/9pP4/btD7YRMrL4Nkk+5FRaRkUlfGl1pvONIF1O6qXLODu1MVAhD5PoIcToFDB1q7Xx1aFvxG+Z/FPfNPj1P29h169hid1J2Qb68J5V4lVVNpoEYtj5Wf4JepXbvRq/jd2a5+XBBu/faeKilyH7axHqRcchcAD6zl/fbOXJzO6NPSjpcTGXBt+U4q4O2NM0njtZxVlCJ1coKOWCUqBpjyOAKzlkEbkd2x5KC9xj3CCAQgGA0mKKswxS4hqxs4rXy216Dxol7nfINK+b4yh2GH3+YJ2iGuFNSYjSk2QJYNVUuedaFbSDvsJLwQTeDxRiKdHUvNLoRjzzWZZ3fi39s6d95BJeYhNmWPcO4guThdn/tkS3sH9U0P7tmYI3lFixJWwRcJJ1GR6nIPdU6jbnbUcvG6tIgxiXaBT7/zg75Lb9IVcjapXCKplIHuJm/w528xRLurOXEOPp0YaFN2nczZ6GBqrx8swsIC/Ws7MjqJ8v7X4lm;4:thtwaS8ei3+T3M0yYoMXTL07MqbGqrHHbt5Kb3mmLqrqpmFNo0h90SVFsChlQI0brcMt4P655M5uWJ4NKdefU9YCu//ntEIUx7mRqwOoLgUR7wTAs3nwbLKY1zFrzcnFFI6giIpHS8w+sZuPVLsYJIDfFwgn+34PMH9yqY+YxqyXqEJxnTizdYzN+/rQl4LcnnGYmuI7+1DNrMHbq2Ows6ut00bIHZ+TdOYsRFhsXVn/rcGvPabxY5vcNtzHlMbl4v099nwPoy6ZY7KOjMoL53tcrIpGBgb7Vn4ahEEO9kKErYZFt+c2njtB59gQiEoflJY04Wm5DDmWARuh+mPvUB4jkjRnvx7NSDHFutLyuDc=
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2418909A3AA73F2AB4BAD301E6820@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(36756003)(7736002)(52116002)(5660300001)(105586002)(106356001)(486006)(48376002)(50466002)(316002)(2616005)(55236004)(956004)(11346002)(446003)(476003)(51416003)(16526019)(186003)(6486002)(76176011)(44832011)(47776003)(26005)(97736004)(5009440100003)(66066001)(86362001)(575784001)(68736007)(81156014)(81166006)(53936002)(16586007)(50226002)(2906002)(7416002)(25786009)(6506007)(8676002)(8936002)(478600001)(39060400002)(386003)(6116002)(6512007)(3846002)(305945005)(4326008)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:6YZ6tjCIyS8090ZtnRd05qR17wm4MleTHF3SI/5?=
 =?us-ascii?Q?E98C6oaVh010qmMLmv+/wpBDwdDzDc4kWFi/VtfMzdKvmzvkcGOziuaMBwal?=
 =?us-ascii?Q?oHItnJycU0KeuSNj5MxSygkkHQcL+TPIBT5A9EPWWkAdx/4rCbOWPuobXNS4?=
 =?us-ascii?Q?QR0O/C0rFQSTasFGHFqQP6EB56Y0wAFW2DtA2mHX+U6jBQHZ6bLWWM+LfBQ8?=
 =?us-ascii?Q?T5B82XVaUBCKiUNQM5l4KaCDsPcSRLUy1NtiV6MsZKHykh7XKVpY4NWG+9P1?=
 =?us-ascii?Q?Put9X3o0ZKt74fEPeFAlWAB60x2v4/T8/6kYpc2d5Fs4FjhAY+t3TBP9A+6K?=
 =?us-ascii?Q?df6RKohElnZNJ6bOPFDP9fd+GS2Qwl/7kZoQHvTcpeLCsg/Fm5YPAjKl6c3i?=
 =?us-ascii?Q?pc80b48bq8i7qX8gAm2Q0zaW8o/WKp4iGLa5D/7JK6Rg6UuekldBribfyN5q?=
 =?us-ascii?Q?4joDw7skOx2LOyWlNTHmrO3XbnLxHa0Px+BsysPJZp7GaomiNyRwa06SH4I6?=
 =?us-ascii?Q?wyAaYouSdVH9TYh/5s+wuVqpoC8rtoHWGs2cVYxGCPoaxIsCilxQbpWMWfCV?=
 =?us-ascii?Q?X+X75yizYR1q35h+F+RDssyvXxN5/pLH4Zvjkknf+TJgkMlOTNPGJiUe/IX/?=
 =?us-ascii?Q?prbGSq/5yUME5nwnaBV8b8JaGtjJ6AFooKM419iVA9NGWagj26rUtMo7RjYc?=
 =?us-ascii?Q?WHlW68RwhhojeDxuWvc/im0LI7nNJVY1jZwhcnc4+NESCt4RQlAjNfUJWrjP?=
 =?us-ascii?Q?rpKA1BOL1KocEfVMKSw0txbe25LsnFCjg9FqDKqF/04mG8lS5JSV8VSMvloN?=
 =?us-ascii?Q?GF9v76xNnxJoFjRRSH+INDWP5vpK9VUm6o9z+SC33lK1XiTU/78PFqYN1Iox?=
 =?us-ascii?Q?ydtAIRLbBmibBZALUCAnpMlvuBJVUu1YoGP6vvH7Fe2qAuXkanWH1TEunz+M?=
 =?us-ascii?Q?5jDyVLZi5/jgXG7Z0zkYbQd1y3LU+q3geLiwVGOI+8LCWhn15iMBMaYvyxhn?=
 =?us-ascii?Q?RlxbWum9dwMMOrPN5ajJPqMtJyKCgFIJquyvToifMdaKc7VDme6ZYbWB4MzP?=
 =?us-ascii?Q?7YXFME1ppbpwdc3hmIao7hG2+2gxChhoVh4/AiKC8zWVYeExL0Qa8az2YCgL?=
 =?us-ascii?Q?P6h7bqnRCbECKBMhwhN3xt9wDeud5kMIXkyY5KLL7eK2ZoOjk+xhR2/sUp+I?=
 =?us-ascii?Q?TVARI5biVjgZOAqblWV3uH1j3Ff1gN/roUoxlB+K8nAgJVs8kCXl5/NBkdwX?=
 =?us-ascii?Q?zIEgPKBVp0IqvbV+vfImej3NfXVv9zv0kw6y/rovB/+6LPnl9dwut8/1/aDB?=
 =?us-ascii?Q?yZwXW82A1aliIpWC2POrOzCU=3D?=
X-Microsoft-Antispam-Message-Info: 4DJqiL/P/hn3U/oDCnH9pN1jVOwgaiTV87MqpxaEIKuVPDFnTlnKuTO+wMcbFXZ4KQ58lHrrkycw9nLiy9LuHjeinsN7AV67DVU5Y8nj3wLPRXroKMPtvK1XgBxCUMYfxHSHWsBZGvbnmnw7wXrBg2l/Rvea5aHpd+yh/Msqxpf8Zpwx5L2ABbtBFx5M5Fn1
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:eb3aS/cuEg9zfhNlRssLZM1h3bh1bFtPjdhTcZmqtk2t1TgfrupZJ6GypmUTpDNyHO0kn6dgzv0cppJi3hiTRTBI5kvPDkJdTSgd0OIYn50Yqrmg+51Au3tCTgIoqxy1tb62DsQacfQrJmqJGko/qVFRgGpEr9EIylGKN6senP8uKuwjl6q/e6HvjtllYJhwAoNnsQ6zYDC9BommMaVfhdzdK2MOKjY1jWGwDnkcZ0Nfx1h6idx/tQ5Bwk8mA1b+eadwmqd6tUeythNQPLQAXT6OP+U7Qo13YudeiqkT2HOlW6J9heHWAoGpgaRAjh0xrJg1ajL6Oj1Hdee+FXeveQETdVciWxVgLqIKxMCYyDzk0VnfTZJwAxY5IjWvfiw4C/Iz869t66bLwoR3KYNZDwC9yDpPPBbMsZl7IvyjTAPbRBNMtcZs30sDIsVWiXkvZKo7rDanllxAEPcJvsQxiA==;5:1hKw1cE0kcLeFj/V9d6BGxvZoNvGKO4ieQHW6enmbBR+yUe0zluMhFeaHt+epiwYUtBdcr+F9EKh9lI/V6Ix+gW5jX8mtHvv8ImoNS/mDPtay4av+I39WQ0F7BIVPs+//lioZ06A9mXeYq4jaS4yGXH2D/+HA2CVQ2RB7uIzljk=;24:w4W4Ytiw6rn8O0Io5Uk4PI34Nqqxiv8krM7QKndrvZ/gNcTzJQSolH2jTEWBiiCVSY/dAGzf9obVV2KSdKFYNWLBQMs+vnmgiaz+OyehS1Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:vF4VEDSGrBHDfsR/aPVC5UqT18R3Nimiu70GC+fM6d6UdoKR7JHpT2UOiWzDFaMGh3Ii38EgK8i1W6afhBi2Kl7/hm/PbzDBCflmZ5e6gn7bW80Zs2ZaoMRCwBGWQpm7Y8Hsn8uQq2a736dycRUouKSK6jboyc0+vIF6JU3quVDtoQFkOCwkQAri8l+6QnRj7NrxCqkAkCmcaDNtaiHEa0D5RNRGS1CkoNxQmEX634/nMEb1oRHI7d6IQB8BnlPQ
X-MS-Office365-Filtering-Correlation-Id: bbc723e0-0efb-4b49-a54b-08d5ae639299
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 06:28:18.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc723e0-0efb-4b49-a54b-08d5ae639299
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894765369527254?=
X-GMAIL-MSGID: =?utf-8?q?1599151493238519649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The existing IOMMU bindings cannot be used to specify the relationship
between fsl-mc devices and IOMMUs. This patch adds a generic binding for
mapping fsl-mc devices to IOMMUs, using iommu-map property.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
