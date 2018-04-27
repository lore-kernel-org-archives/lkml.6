Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZrm9/+eWVFVErp/Vh+XzvI17HgVijzb/FfxNzuojV4RNpmOPrt+cj70XDIhxwh4g2Pdy+7n
ARC-Seal: i=1; a=rsa-sha256; t=1524824867; cv=none;
        d=google.com; s=arc-20160816;
        b=mdI+EQPtRslTHf9kVfvZGkMSR1BuOeZafdYm2o+0M9KSkRfz7Z9ERbu+XLlJYHpauv
         I/3E033WTQVA7osRi2U03bTjT31Z1+4W3EEMEK7lA/oifGMLyBbJ2nevGhlDlhWGoW+F
         DSW+f4isLRLsr+KinhofGZ8K2GvRvA9s2LnSCsBCZbuQWuAaTIAJXLtrfuMF2AxnVW0M
         HSyV/ZeIlh8ezHAbHaXx/iQBwMTLUwhvGR702Y7uNjCRFtxvK3F6YAGT5GNFf+rlWVtA
         qF9Dpiu57CYJru2DAWkoNbkickD8qMr/QADQJ3g2/hbqxYlmJJuww2EMVS2cX1u7lhmk
         EeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6EV0q5YdB080foWruFu1UxDLKD4mGzkz5sqoiev8qW0=;
        b=mUey+2+/AuKxU5zQLpbmAjE5xWDyLVMQmQRVJxuXeAQ9D+JBub6Y3HcFklfLa1ZyHD
         2cS2pejNi1tJD7/U25o1gH6OQm0mi9Pl3n2O2cdEEoWplGWE5nnqSKjxQwXqK8+Ax3lP
         qTfWiLcW5eFOARGriJTxvEibDMU3GEX4IiL3JUHwNnPfksnEkJAAWK/IrAX2NHGBwI4B
         0+n+IzYJXKaNeoFI2l1x5t5dfDWNyTnj4kQxd2+cOsfHgl9FFmyP4Hz98YwxV1BYP/fY
         1kN4vNRfkioSsTDJt0uv5w6Wrw9HTl33JN5A7ZXBvkEGsM8ODEII20iNimyEVpDyuPmF
         aPtw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=S7ctEoiF;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.41 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=S7ctEoiF;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.41 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 0/6 v3] Support for fsl-mc bus and its devices in SMMU
Date: Fri, 27 Apr 2018 15:57:00 +0530
Message-Id: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12)
 To DB6PR0401MB2422.eurprd04.prod.outlook.com (2603:10a6:4:4a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2422;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;3:tcUUP9cgxT1+0naXYEGZEBhS2xbnMyeK9AM2adwb/wE7jX9hNjz8g3mieMqMxoLp9rxkTYCr0G9lET56gmHoPjVy3lR363Od60hOsLunZABk9w5juEB4hIHctr9vMmGGyGXcjlG+NWoGNwKsp43b/aOnIns0iQjJyegf88yVVu0xUGB/LBRKFBzjhoAA5uT+xvahc53wASmyPJbHVv1PrhUH2vMDO1VK3HPrSAFyjrh99d2hgXbZkKEJAdYjp3sR;25:tRdXBlQupteqm32o0Ak/RL06mpcR7povb6UEeAU+2CsbyPzFiSzKQ9L2SP9Hi6EN81uTwtQjvQG5EKSbmCNf2yBEIcOKj0UiTkgkimhHET4nbD04+cQdFcaRW0HgjWbPuztMr5uGQre1soMbZz2hzsvlJPMeiZ6ondlvZRWR2uSPv1PoyMLQRAM3/csy8CYER2r5ogVXKeOGIX5GwxBcEE3z5Pc1bk7z5lzJqAu9BCyL8Y4iQjiRm/wl/5XZVBphdAx2ytK9GHTMZESoSTNZEHIEd2N89vxsSLTb5jge1bvVebVmWTVT6CR3JINmqNAeI0GiyMZd+NemYOjRGybcZg==;31:xn44Te0hptfaVCdQYA5dMSF6a98+6uvrqcTY6cFFfNbdfcR4B+9sc6+fXDU6eeoENmL/N5Alyhw1+LZYdPhI1apVxm8UuDE2PqN3V0je0tg37rSw4D4iYHgnJmkkdVkt5KPNKn2UBUTYzCEmDVfUM8jVZKxhBsxmX/fCosHtUs43Z5IeXB03FCICreuBffSlUlyPaQmbXcxQxoE6WIfYWGnUXfU6/pFCey3ssAmLaMU=
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2422:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;20:c0JZCccp9qLQPp7lkiO9adlG25EXJ39eeGr+2ZureMeebd/C3mQj2fa7LbiuuJk5kz6BymU1VCSh+SopvdIowLNhSSD5TlbUXjcJmv9CdMU4pz0MWDc4mHA1gWEszu/UNGGmqj2Q4svrY4bAvp1wIOJUDJvTk3O9andwFAgMLn9Y/hCpk3SiZADnYc0yMxQBF/pzVdZTt3jWmL08gw5a7LE8PT/h4Ce3M7C/hpBmYtA254gk/fSmCGFI4gLtYJqit8j9vBRLaHEmdhzxNLfDFqctxBh8MNNN+909zd4oBl/vhb9MyXUfzjIc8beSWJT87DW+SCyrdnXcTBPToTgyZimokeMdvP6Nq8XmkPNkkuUl7O0R2kKiebDbXb8OTYQE1NW9lxb0l5R++5W9QwyQkOPPc8wDbXplGQFftCwCpPsfmhad4+UmT/Hn5eG6AzNgr/6D7Bn9aZC0DdpyOcnqWNFZGOyv3ax3Q5HNTAuyUHvN63xFw+uN/OLzCX6+EFfc;4:W60GzqMw99buMUpqaTPFnvxscRW1fvN/c6gaCxw8CFbabnr1usOBG/LkILegVRIxTx48w7V5x+TcTiV7TRioTtDZ5wSYqYMbNu+byxfkFO30DH1ALWAqQPlbcyVvE2IEGItTXJeywtg1L1+WF4jTRExG9A5ucXaElilOrBaj1b1TaJyEZdH76+QAJz4aVK+Qgwo3CRTkLZSV253qyHsGwiaP+kB1tVWnVIoqwJoFP4M5m42wRu/yJqbX2c0UOnMnOGWUyLnmV4yo5WAZ4VRBjQ==
X-Microsoft-Antispam-PRVS: <DB6PR0401MB24229E5CB6B92DBBEB69D2F7E68D0@DB6PR0401MB2422.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0401MB2422;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2422;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(2906002)(86362001)(8936002)(6116002)(3846002)(53936002)(25786009)(5009440100003)(6306002)(305945005)(48376002)(6512007)(6666003)(6486002)(4326008)(39060400002)(966005)(16526019)(186003)(478600001)(52116002)(7416002)(44832011)(26005)(105586002)(2616005)(36756003)(8676002)(81156014)(16586007)(486006)(66066001)(50466002)(51416003)(956004)(97736004)(106356001)(386003)(68736007)(81166006)(5660300001)(47776003)(55236004)(476003)(50226002)(6506007)(7736002)(316002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2422;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0401MB2422;23:XS2hGCXblMqFQHDDd6EyEaQJOVbzr81/u5HsRXC?=
 =?us-ascii?Q?mFWCoN1ozdO0v1W48xHRQ5trxJridH9AYzvab7b+r8LILc19cJ58Ua6tNhOg?=
 =?us-ascii?Q?BVsSmgVjfH0Y2m3Gq5XeFttfwnZF2ZCzbp5svixVvr8UEiEs4qdl2pQzE0lb?=
 =?us-ascii?Q?EUw9iGnJ6eAblNCaY82DQrV98DIrX8yP9QECe26FJ+mdjeoTMv4v16FLwM9l?=
 =?us-ascii?Q?RAppZth5+YWlg3W5BluognatA6I6SovQDIRpIi4ew2mQhgOl1j8D6HcIKPdW?=
 =?us-ascii?Q?rnQGIF5XGGGr/8mDpUdC/4AyLWBgzhde7FRKsnG1+LykgN8TPEHCSpWEhcWg?=
 =?us-ascii?Q?fcpoFAbrUW77cNUe0LzZ3zm7UQcsr/OgsAHsS+BYIODWpG0SHMcN4PwT79xp?=
 =?us-ascii?Q?Ty4poJ5PjZJvxgVKvKano33yhcdd/v/jm0wzYk2vXQ9ZU4NBf5bPrifZ6XoK?=
 =?us-ascii?Q?zsqlQOy4CAeW0aKD0bFM8Q34r04hc2Hx7O24zk7RaeJkAdytHUK9gzrZ5dLR?=
 =?us-ascii?Q?ya2hrKK+TT9rrBj/2ShOWP65iHHpVsbxnlh/gITVHpWK+OK1zf6joqjqgidD?=
 =?us-ascii?Q?u7tfJXwNcX0VBJMWRC4VxPcuXwmQO4CiyusmH4Rr7zBpM5lLzCJnvkXWM/lc?=
 =?us-ascii?Q?Hx+vvovwT0rOBg8iOlELgQkHJ0MIbrSTXDS9OZ0Ac3mtvANhW1kxTf/JPBZh?=
 =?us-ascii?Q?URUEmEO3Lk/1UiVqQU1wTIXmsFhsOFeOn2zLahl/NaHcZUZwmsczsF/w8xqu?=
 =?us-ascii?Q?12eZY2DKPCGvbBGrPaPEX29Ng8+W6L+ovRYrqYjHoApwio/ZbD9P5k2DC26P?=
 =?us-ascii?Q?hA5jjMuyAD1+0thRj9j6WlJ2pcZJVXYwjaXoz4NfHZT/tzPKZcRB4of2UTOM?=
 =?us-ascii?Q?xngDXfzES+ozJjWJc7/Qm/igY6nV8M/FqUOtbJW1NHPyckvCIyjnkY43WeiR?=
 =?us-ascii?Q?tSDvW5DyTw7qcP4ul9U7ZKmBsX5snpF2LKXq96HAb+6pX9xMJcWLLHucFtgT?=
 =?us-ascii?Q?4KvCvFvFqtuWQGEImtQ8Tv2ENziN5vFWKRaas6DSsgU4cJP4+dDxgttfezeg?=
 =?us-ascii?Q?Ob7c6drWFB0uLBu5H5HRiUbBedOGbp0kj1vsGA1P2Pfq7FUJNhCuaMZXa6FA?=
 =?us-ascii?Q?Gkr0rrcTiIzi//UdaGn/dQZKfYh1CqgWode3hQqezoF8o7yCYbIASB1Sl26W?=
 =?us-ascii?Q?0EPd9G1tqxaZytL9KbCOGHkUW0Hrheeq6aVrMZKs+VHpsL0ZbZp73pb2vqd5?=
 =?us-ascii?Q?svuGLxLRTZMdwcIcCLHbj0C4FYdbx3D2f5BL1WbznXnG6sZX/SJ+O1pEV0GH?=
 =?us-ascii?Q?JyQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: pS4nONvp5s8XCyai3YCsnzofpvj4YuvrOu2W+mc4woORO1eVr1PrSvOiU/14/y/l3/4v35pj+jVd3Duc5dr/oCxD6BaIMhQTP3MSMMpAs69JjctiO39hlNt6ZxwtGeoIqYN2Q26f8RxLA99ppFAOw8Cw4Ib98M68FFzUtDm1kX3kNQN0ghpNnLgN2pdpU7Js
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;6:rsOyIK0wWbeiKHS3WoM/bqBlXnX5Yk1y4v9ziqZr1qcZB5sjHtSzWDad81hdGtwi8YXDjWcrnteevORKBozTL0mS358AuAZamJOZCk0xd62xHVP4hKlmdeJE4QfuGR30wgNAn4FBGp8tsJF/12X6io6qwRd3m2rMU+xsxi3TPAOE7XxpEvAxRpyxvCgS34BuI+zjejI5r1Bs+RWGDa/y/aeBuMF/zb7ODF6tcc9YIYJb2PSLL8/XLWZmmI0IogmERDl2KU7UFax9zRcmejRlab3F6yihftnh7DUT6ZC7rNtwNgM3wGIb7Da2/sK39RKS8h4Mm2FYoeM09N7iabeCc1FZnVNqJdOY1aG1Sfxev1XFVqhUvjgBG72n8hEAv/Kw3KY+OySOq3Yd7bPfrbls4ndpMBybEsII7qkgwysXV5jqxvoyI5ue87YMj9EKw5T4zQskfirzXq55wWRXii7orw==;5:rffdc7KFvvvuyn/guY9+PYjYe7yHxjwAzG6bWESPm+IyUPtIGOeMsExqcTiTh1YleKXzxMksLcRwVF4JYmLhFzi1nfdFZgWaNrVIZxKTf1AZeXS02XEnCYPKaTRAJyhk4cl6lwX2jddaBorSuZN5xDeX1q9a848YHqo0ELUdg90=;24:jSYtfZm85fl9hzutUvjBzfuYcULrPB69Vi8Pvl6cT/QFn/sk8chRkcprudipCL5rcAMSdCpXp6+lh8hw3WzXn52CjCTG4rPt9kmtKdpADwA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;7:diuWw6Hq/QT+jcd3SyHEOEgp8fKaHjYkfocFnlG8Lrzh4eSEM+NcTEjdcvEXJlCttGjpd6eNa+hp0/ZAdvJpNepQRW6KOEPdLzFSOUlrFQsvPt5bdP72Yr/ZkEWRDvMo3dh5u4968biydJnUQAiRoS+qh2qpYI4v21Xjn3j2WfWuIoQYHNWS5VLrhzfhPZXELsUvfp8xYZaQmxOvxxLYJRdc2SWODh6/VxKLrLTJOlBdikxabyWLKNt6UMb/b1tG
X-MS-Office365-Filtering-Correlation-Id: fd5233cd-c174-4aa2-de9e-08d5ac298310
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 10:27:39.7537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5233cd-c174-4aa2-de9e-08d5ac298310
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2422
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894760308217340?=
X-GMAIL-MSGID: =?utf-8?q?1598894760308217340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset defines IOMMU DT binding for fsl-mc bus and adds
support in SMMU for fsl-mc bus.

This patch series is dependent on patset:
https://patchwork.kernel.org/patch/10317337/

These patches
  - Define property 'iommu-map' for fsl-mc bus (patch 1)
  - Integrates the fsl-mc bus with the SMMU using this
    IOMMU binding (patch 2,3,4)
  - Adds the dma configuration support for fsl-mc bus (patch 5)
  - Updates the fsl-mc device node with iommu/dma related changes (patch6)

Changes in v2:
  - use iommu-map property for fsl-mc bus
  - rebase over patchset https://patchwork.kernel.org/patch/10317337/
    and make corresponding changes for dma configuration of devices on
    fsl-mc bus

Changes in v3:
  - move of_map_rid in drivers/of/address.c

Nipun Gupta (6):
  Docs: dt: add fsl-mc iommu-map device-tree binding
  iommu: of: make of_pci_map_rid() available for other devices too
  iommu: support iommu configuration for fsl-mc devices
  iommu: arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
  arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   6 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +++-
 drivers/iommu/arm-smmu.c                           |   7 ++
 drivers/iommu/iommu.c                              |  21 +++++
 drivers/iommu/of_iommu.c                           |  26 +++++-
 drivers/of/address.c                               | 102 +++++++++++++++++++++
 drivers/of/irq.c                                   |   7 +-
 drivers/pci/of.c                                   | 101 --------------------
 include/linux/fsl/mc.h                             |   8 ++
 include/linux/iommu.h                              |   2 +
 include/linux/of_address.h                         |  11 +++
 include/linux/of_pci.h                             |  10 --
 13 files changed, 234 insertions(+), 122 deletions(-)

-- 
1.9.1
