Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELuoniCvTKWjeKsMgsNlZNe1jq5g8aY/QORiy7kKwUcqDdRUWbkfqWXHkhwe3KdIj3mF/ClE
ARC-Seal: i=1; a=rsa-sha256; t=1520260204; cv=none;
        d=google.com; s=arc-20160816;
        b=cIeCMp7OpTQ/6OiYTm+s+AUjxPPotalr7erxPWYe4mdmgIPgZ6gMkMZrA1Pi50OPvq
         sijyLtkd0YX2NL1T5mFrYaMJtcSYDC8aL36Ofv8qhOnAnhIlBUCjfvBNybb/rvD1u6KL
         0XPYLTZGAQdc1CbAFYKJjWBFeSGVrhX9MQ6OXFVjAnj3P5P7Hyg0ZnHK3B0zqO+q2JeX
         Bq3qXtL04vVXPWvDLWq/PlBZG1Ps2F70XNuSqNgXcPka8GaOg7XSOW++ORhZp7a8OtpW
         x54ucvxFvj3iZresoC4gdOSkcVWPGItbxAs+KCTO4I4TcLC+1fk3Es92SH6PJuF/q1eK
         nUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=i+qpo1+BiD4llIVX2LD8yFusuwIV0q6/5h/naPscjHs=;
        b=CfJXuc5FJZz4Na7qDyKkPXg3KzfjGzGgu/HYkH4FmZo5xmQRQdEzQqXasNWW0/sQhT
         7dFbPw3XGjLp2j9qPiTSPBMWNMpPcNS7NF1ZENkBszOcjkB6pttrR5Lww+rOkT6k9Cgx
         SRw3vJVl9wRLJSObWDydOjXFpIFI5e/H2iJiBMVZV22XPMLwYt92ca44DbUlBvhLawkR
         Z4lJh+28xjGN/kzD3eB+iQER3MjclJfS7Y4TLLY6p1/aKvfugmg/e+NIng3WefeyNvnU
         GPZWzCTohoDidi4fau9Bf/y9zq5bq4HouRsaXK7A+tIKa03EyBV1A0h1tSI+Jr+gSqf9
         TzcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=ebDPOyPl;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.52 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=ebDPOyPl;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.52 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 0/6] Support for fsl-mc bus and its devices in SMMU
Date: Mon,  5 Mar 2018 19:59:20 +0530
Message-Id: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd94ad5e-8d8b-4771-a83a-08d582a59447
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:25GJjEd7JblyBFAOoflg6gpjrahW3SS2F7dQXk2QavoV5yUc01Y4KgNYYteU4A32gUh927yBIBfgYvWnsJL2KHGPCapdEE0htpDsTKN7lOsXNuwPE3D6gt11kUdDbmn1MdfLNXsVo1MYQqXd/oxTq2v+VZ76FCWzq3X0LOmVRAKp79fX8BtlrxWxHTWRdpMdEMMJPHlPK/dWYONHLHplFhEBUXe/xM7d9HQP6sVmnxXqM9CMnq2Za69y1TVFsWSO;25:+2uinII6soWvA038zLuHFagKsXVTn15oQ6jzZvOWoRGe54VzPuHot60H2ic7BqDXZ4Zf5l3cpUY5GjLAmZKXkte+9FSDaIE20cYSVT5baPt9QC6gJEe//AoD56K0z2PTV0KnCOdvLw/0ozpwP1dkEkjyznxHdGJfx2LIuAx88QF2Q1WTa9QKgeII2tlXgFKQHbofQpAU+AEfeN9t1wkJb4tUlirRNku53BODaIjSufbXEnBZKQQNHNYkesfWiLbw2LQ7i8VRMYbyFzxCVcgTQc/EREC0+I2P+Z7iPqFYHImxxhIj4oSfpTJTbhgv19atNRG+QyYFTFTLtDaUEvX2jw==;31:FqNXa1GmEqdcv3KJPvlbVjeRC4X9iIvCMwW2Ms6ZA1xG2QrcuRB2WpQZQtiTB8JC6PBuAUID43Nl4usLsEYGkToPFRC6syhDlU0mQrB+uJ50EkMOx0IEmOBrNKV4DtslphVXbIQ5mYBpK92X42Zd7G02Y6jI1p02w6cXbsg+SGWniOzRaPdjp0OK3u9Zn3ijqvwUP+K/nPP+4BlCtxakVkQ21osFrRydUwKyPPkVC4g=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:p0mywK3utu6+XV+JcA+akgblNdylyTm0I4/qmLAWgx4Htw32HR3dMHs6aN1W8pQe0NLhPQ7Tg4zPXJH1B1LDLbkTdheVzDm4lKbA28q8qqzhtbm8pjFF1mQfv9xiKs6NJoZ5nmp7tb9nefTWEvb8P8NceVANYIRwp55tXirgIb2lncmgA/xkUZzjWnBaQseR7F2bHzhE+TowH5UpvUqUZ2O1BxDyFz7E4BSgGsYso0cQbbyKpUT405iFQUxWyYOIURF14Lh8YFqYM6EefTiJFan8iO8iS2WdnAJBpMtKKA7tLmWqZKSbBQXygnsCz6x3xwA1WgdMSXmba1hEqPuGEVfClVBClUXlqjZl/P/1P62SmJhbgVjKeJmcX4DqEMdEGKpwCH/XJ/U551KjNVBfmgPiMfOWqdJZS0RbfD9lXWaibs1/M+bPKgG4bXBq30iIZEvEF72uWFD7lXgf7/FwZlfn3qV9S58zBtXiMGP2XW3bdfuPX2yfIXnhtelK7Tpl;4:dIej8IT7jaVepyTgPbFU9yLR4J3ZiU9U0bCm06nKZXghrVczQ4SqzCU7vPP1NPMBKruaEFPWoQpKkHvNLgZUUWnXzoCEmWdZlkn2bOUkOPTiEaBnEWFeVuIHAQbCUyXXVovbohFRmQOlKPHGMEIDeNReycGUGNutvhHlhqiL1iCegAVUgDvNgqal/Ct3+UZQ2QKg4XU/3ANSRGVe3KCgSD2viCa5STGFSljoOw9Bfv0mZLKW4UkGaJIpltYOX3P7cu1RgSA9YMso5i1eQTHbaw==
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2425BE7417C4ECBF718B69F1E6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(189003)(199004)(2906002)(47776003)(106356001)(6486002)(3846002)(4326008)(316002)(39060400002)(25786009)(5660300001)(6116002)(6512007)(53936002)(6306002)(6666003)(97736004)(8676002)(81166006)(50226002)(8936002)(81156014)(5009440100003)(386003)(51416003)(6506007)(26005)(16586007)(48376002)(52116002)(478600001)(86362001)(50466002)(66066001)(7416002)(16526019)(36756003)(55236004)(186003)(7736002)(305945005)(105586002)(966005)(68736007)(110426004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:Vz3THr8zcFCjg/yG3OdQ0FQ9mnjy1vlCu9iD/mJ?=
 =?us-ascii?Q?WkqCxv9VobOSvfv6Y/iFqLaN5Slukqydh6kBJ2FxSIYwCpwJnTSfnf+xyClh?=
 =?us-ascii?Q?hsHLbZC8eeHLkZHMt8VlQ+eXQdMTyqzblY1+ItaiN0DTGBgQUqRP7Erp0j3D?=
 =?us-ascii?Q?svVy4V/aOqlnbGgEaDpxCusFpTuzPF4IcHQU8nCbK2bbFiC3JX0Q38cix5Hg?=
 =?us-ascii?Q?xIAcne+5pbsatc4BXjRxk5PNWx2rQHde12pBSNUEvOdwWePA5hdN0pkkIx8H?=
 =?us-ascii?Q?EVPhIi0N+UjvfASznZ6rvvmTo1UjcrYO4Ax990DaFqvQ86/ZAAEeNaFie47f?=
 =?us-ascii?Q?1x9dDeAKJItrrVNTZaCKC4BG5b5kfkN4yI5S164TyG0nfqA5ZcboUHduGZhn?=
 =?us-ascii?Q?hbaR6mcZg4vohH5cy8IEf59c2VxVssVBAnS4M3MURQ+br9Jh8g9+WGZ8C9hE?=
 =?us-ascii?Q?J3YX+ZxL0ajm9+iOXwsT0v8uNhQbdsys3CiyllLVLZgy1zVdvywvLcw7jpKg?=
 =?us-ascii?Q?QvvqBR/coqL99sbTlHRtzvS0NoHuY44j/czoJ/eYGmshNBlcSFxf7874kKRm?=
 =?us-ascii?Q?74O4WfLfm1OQYVzI01bT6m2vB/Zfsju9vpWIQ5foUDgqSw7ASQnQ/rV6I2VS?=
 =?us-ascii?Q?e6K53SDWRgzeEBQ2BawrFLUbA/p6wemlP5P2eMeMAgvbhlu/Q6E/WJRFnj1o?=
 =?us-ascii?Q?WuNr360HZSQRA79zPcqkHAZ4MBX25zqz4w0aXAF9IiDz/I34GICWJMFxKPP9?=
 =?us-ascii?Q?e7tOJhLz9FxeiFY7hMD+6pzlVaFiu5PG0efYqYYaiHE6hJ7UITqyAQeLO+1M?=
 =?us-ascii?Q?+pLHbvXRbPS9wFhjUP+X8AqQG2m3Z3p4dQrDsoVocaO9GsfHNYMBRelxy9A2?=
 =?us-ascii?Q?X/3cHgduu1LPbgBbJNDvvLIR19Qbf13kGQs5EogMyWUDpwRZIpPyWhJ8ua2+?=
 =?us-ascii?Q?LzKjssUkzMM7cJMAiasDco1ikrWMxYcP0KKycn3b+ZQh5+W/v6tnC63vhsuX?=
 =?us-ascii?Q?7QepRT+YW9O8k4WI21XpRqm+Di2RPP10R9vSShi4wMJt19ECCq4drnhnZU+E?=
 =?us-ascii?Q?i/ggeVCrE2R03UDIsl8VOktv5XXntK2WLEJFEpFCANZ25QOYQ1mn24E6tXSD?=
 =?us-ascii?Q?6oC0rb5pEutjXNG2q20RdnVl6FHnpG/8oG605u8O4URta12EZi6LRJdird+V?=
 =?us-ascii?Q?8cU3Uk8gIA0waZn0=3D?=
X-Microsoft-Antispam-Message-Info: +Pi9y0qmaAo17etyN8PfaL8TXTPG8mXIvHvKcGA35WunYbt+MvRSFDEjBEIHB46QsZvIow1X7ca89rLqlb00R4v4JlW2aFOgvQtYu5IKvRGu8GOVwcnAZN+vQEssLnhpyyWzjFifObs5ucQxfDBg9gV6rcIhPMRoFJWNQGsc9+EwSDaZ+YqUY6jCyE/I0D7X
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:uaVDZ4df8INZ1L5gPGJk4S2d3OozRO+V4IwQ3ZvAURyYDEJfykMjr2aj7DYBhjO3dl4vCEYhGwW7mwJLSVARyzkUc+CIvogaaDNsfkcsw14o56DzHGuPcz3K70k6H34tSRq7g1SU4wb3ZDaNUupSH1L3ZoXa07vvtTEy4LabhDAhztZsk4QcBV05J3l9owULnuL6t05+gUyeSe5MnP1dTV2OHFRln9MrTQAldTb6XQ5ENfexI/1NFNnx/Q1eq87WP/j/HATtrgL4dHJouBsfZ8sM6Nyoifdxym6XRx4m+cACO6oT8dcNrmbM5jKAS915ChWkyUpHQk+7j0tosX2g7eY8p2SdxEP465ruSSALkXg=;5:s6dxSKMnw0MBn3VoYcgwtf2S/BI2tPV0pUVKeqU/NMyj1+ScH8V1IbwSvqKd2X9X9PHaHYwu4cBf5Peu+vYUscyPRGnncvAhL+52XeyJyDzvjzVa/o87HY4jUMj6eeZ5alFCVT4h5Ed51SqDd+vV4EBiiDc+kcub6N8ByplYb7E=;24:CtQh/S9Pd6ZAFLr2owUwkXITqDPRPojuVrLbWEfjyTCLIMI8NceuaPFcbU2xg9DRFFqYc2AJAwfu5L+gJTLlAk8uP1vxzJ34FGULEDv/Bf4=;7:CLEDj19tzEr87bV4Kt/MnF41YH7b4kmDXm75q9scCmMmZYNumaV8BZ7lgVBUxFI7ckYklQiBaG1suJBwJfJvmQbs0X3+5oaiJdUtee03A8dTOIe87psEYDPGDJMFsh3t1RyQGeNOKgBNhXvYZ8AONoYIefNH99R4W1AJelvSq47NAwjZiJ3zkTmv5LzgI1G7hs+7ENnLJ3fYi2kT6KmX40SGjnCIdIBSPFHIdUedSb/jaS5k3Xw1g4xcoFAIT5m3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 14:29:57.5325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd94ad5e-8d8b-4771-a83a-08d582a59447
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108364344914360?=
X-GMAIL-MSGID: =?utf-8?q?1594108364344914360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset defines IOMMU DT binding for fsl-mc bus and adds
support in SMMU for fsl-mc bus.

These patches
  - Define the new property 'iommu-parent' for fsl-mc bus (patch 1)
  - Integrates the fsl-mc bus with the SMMU using this
    IOMMU binding (patch 2,3)
  - Adds the dma-mapping support for fsl-mc bus (patch 4,5)
  - Updates the fsl-mc device node with iommu/dma related changes

This patchset is based on staging-testing tree where fsl-mc bus is out
from staging

This patchset is dependent on patch https://patchwork.kernel.org/patch/10207507/;
otherwise DPAA2 Ethernet driver functionality will break.

Nipun Gupta (6):
  Docs: dt: add fsl-mc iommu-parent device-tree binding
  iommu: support iommu configuration for fsl-mc devices
  iommu: arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: remove dma ops setup from driver
  dma-mapping: support fsl-mc bus
  dts: fsl-ls208x: updated DT with SMMU support for fsl-mc

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  6 ++++-
 drivers/base/dma-mapping.c                         |  7 +++++
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  5 +---
 drivers/iommu/arm-smmu.c                           |  7 +++++
 drivers/iommu/iommu.c                              | 21 +++++++++++++++
 drivers/iommu/of_iommu.c                           | 23 ++++++++++++++++
 include/linux/fsl/mc.h                             |  8 ++++++
 include/linux/iommu.h                              |  2 ++
 9 files changed, 105 insertions(+), 5 deletions(-)

-- 
1.9.1
