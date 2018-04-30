Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZo0puY2h1/Scf2xPIUrKyfHEKLV1cgWQAYA7gVk1qrtmS6KSytkHZEMaY13gVXPMBkz3DHD
ARC-Seal: i=1; a=rsa-sha256; t=1525069697; cv=none;
        d=google.com; s=arc-20160816;
        b=tEY16q9ZpadwZRuRdfBXVnpWMgkukpVePC9VhcSw2SxkyuaeeUAFgYghbmQqdjdIc6
         DEGsj/U8gofn1r8elC7nItIkFo+SVHgV6PLPVmo18jkmZ4sZzyIr7qZ6hiOZqB0GDwGA
         nnhK/VwWRESSJ761ZAkQlqraU3+i/lf62pCvAro1gPtDLuHUps7eiqA3OP1GECOe/Ykb
         bPMje2RQftMD0zBwodXSFLib+8Tz2UshF7zpJMN2u4Vv6IGrt2taFsSm33fyvFXrCu72
         118Punc1XKigt0pbYkHRuleDpCY+C5F2Wq/nWjHOIxzEEHX7+mHUHTkIQDJHhxMShg2C
         cCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bbrVgmFKo4Ok9rXK7KrTEpsVI70W2csYVf/m0m9rR7I=;
        b=CGs08OzyOE64JYBhDNjX3GcrxheIqa9PMRsOts0LvCNalLEXicFw4faVhTiW/myWye
         gQD33Fu26HqtCJtEyhma4dU0RSIOnuqOZhSWND0t12TYRRNBBAJXdEKAPCGC0jMJiGv2
         +FUgfImmEL1eXboJFf7nmovdqs1+XR1VuSCrCrn/ALBjNfOxg0/uKpd0DMYatDGjQadb
         p9XsO1AXcVnzWjkyyKlKqRTvIyNBCmVOiGc2x6fwD8/+8YkIVqkd9K5z6y4NHSKbdg9+
         +MKfJNCSUrO1b30uiWrPJYOPh4Fnlk8TK7RFe6iWfuxiXuW4wceAsidIvBPLx5me5prq
         FBqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=gVzd0ec0;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.46 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=gVzd0ec0;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.46 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH v4 0/6] Support for fsl-mc bus and its devices in SMMU
Date: Mon, 30 Apr 2018 11:57:15 +0530
Message-Id: <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::16) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:MqzE/aHMGb5TFUDxTnRI0/y54DfxYElAXvEy/ASt4JtApAsbrk30ITmQoKV9Qle/VgBzUTWcfDp5W0WvJH9cB4jFLT8+YRNBy3563NoUZ/2o4oLHpHX/dp963x6c9IjfnTA61CWSTZM1FYQuwL7PQLCoNyQGwfYlUk8UDX0nLeoqh7JQyMctcHG5zF8IcnicXQYBlYoSilx2dd7/vMVF5tld40+TZm8298bx+p75zQIIsXAelUdeVBNVUwC2bbjo;25:/UifOkyikeukS0oNhpiXALxvAgybkpZhAt2TZhKpjpAckw2TPzGbEDqc0hOZSkoPkcTREgWyOSIRV5KmLxnfozsyBtnYKmz0NWcDeQ9uQzm7rDj2a9Yoplv4DaQGpio+IZ2rUKnHur7V/orb2T6vLGTet7lD2QIgYCAOh68q90ZE19RndJ7K6Pnz/XyEc5aY7LNOs6w3UUa+Q1DdrmYJ5ZMgyj27jKzBAnorrgjDaspnUbvz0l3kabcBIGmE4yoFnNRpHGacOLAfIcUO5GN6OqQjmXiv729oC1tF3LUo3UDfNQBRRuO0tGNUH1lhcaTe1M5ovRWFNPY5JkYNheA9eg==;31:8Zfyx0xRaf/7YOU8Jk3AmjzNwPNTlqGqOit3gU6Cw3L7bLeWzZxANaNKVmZXRWcL2DU2OhnERAWiF4YeKE7bzI+HxlHlPUxv/d7rDlcBxcDPnrCMNKrTF8UywwN8GTqv98o1vdvmIhwRs8Ih49hxG3yFL0N0Pc3Q0YTlaW4hSd4CZSzYzvkhVqWcMyIW3t/HaOduuqbzA1kRO4hM3y/0ebnwn7ilZgaYPaSKySkXh6I=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:EG9qsCmX0OoLRgxY4e4xPNWVHAl0q7mf9gH8tiwSHgqSVbyiaVFCj8vSF8oOD5miLDeIPv5CWBeKnSsHFztn15p91t4JwDbdMxRkcjArbOORGkmvjWSwe1+G9/reujsYL5cd6UE0fgvNKJda2dVKNAp3ztW32+g1FYSAuAxrMOO77Nk5GYEEAv2ltgzMnocTWT5GWNm4Acv1lQKxfT0FB/nioHeZpz9k/50Uvzk2c1v8gqMy8HGeGAmEmRQtGQlQbFe6fiJjQmVzu9Os3auNzPifVbS5LnZw3V2DXcwWW+IjgbjauhX7TbICWwyz4ftBDu2pqM+EVtE7U93sN7jSh8HgxpkxLNPrN9erwzjdi0X3gnheZW8nbtTSVkAQfemlMkkkonK8lIbu8lLax0N8qDaB4532cGdovM1sHoDfGDdentBDMlWyYLjBoSF+fPWXm/LUkb14Bkvs6qBilEBgeIOuIBHZkA2Qvj/XWPx7gdBsFY5juCCJVPEc1HSZG6w+;4:4FpI9JsAtT6eSpPCGDvEaNFtCWbr7qjoSwSk02YdG3zzIVpYd7NJOltUI8rA6fFD0ljFuuI4hdDUD/rSzK7vKqb3A6aZO66wPF2oRAdB7iGdteK6sa1UkC4dsX9rQYmurH5gmnCIETdaNS2lW9rbWeBmsPkc1O93Z/yC61NTm6UG03e7Qt8Jmb4LiUdvce6WnMT2VAxEtTAgaRUVaB9z7SmK8e0noJUehWifLBJ6kWOQUJk4tsYZNV0QkYoNFimkS2vGuyI/rM1Ikws7YvzH2A==
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2418F444F3C3229CA330E657E6820@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(36756003)(7736002)(52116002)(5660300001)(105586002)(106356001)(486006)(48376002)(50466002)(316002)(2616005)(55236004)(956004)(11346002)(446003)(476003)(51416003)(16526019)(186003)(6486002)(76176011)(44832011)(47776003)(26005)(97736004)(5009440100003)(66066001)(86362001)(966005)(68736007)(81156014)(81166006)(53936002)(16586007)(50226002)(2906002)(7416002)(25786009)(6506007)(8676002)(8936002)(478600001)(39060400002)(6666003)(386003)(6116002)(6306002)(6512007)(3846002)(305945005)(4326008)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:gKjp+h/osQa9v6ACaj/UuGRsBKpTPDlTAyDIQdr?=
 =?us-ascii?Q?ShLRiv/0qZEz47lnyeGq56kIBQjTO9Nh4SzlqbFK0GGmqH88ty2bPHKK7Jmw?=
 =?us-ascii?Q?pZp2g8jRxpxMxWK5c494/Ms8Mo3AZKJQ3z0v0vkXRFyfxH3E2dAu2oC0+dUA?=
 =?us-ascii?Q?dgAlCe8+OnfMTfrTXF8dTqhct7UXjKZLSA6pgGhY65Z6LBTBIuR/sb80bdL8?=
 =?us-ascii?Q?QkAw9nL1L6hyL/cq7wcpn3Fcmd8VPgvpuz1thrEHtD7oqildSW9045e1Tuw5?=
 =?us-ascii?Q?PsAsv6Rq8dHttdCEVvT9gsxlX73O9VSI8+5krI13uwhp4Yr3IZ9C0OzVdCm7?=
 =?us-ascii?Q?xbm8wTqFqqcEYDNE3MgLE5oWX67BU2CarHQIcdMpTOZrFspS4TQWjvj3JVmP?=
 =?us-ascii?Q?M8aY6N491iEZ+uMGoefhdvfIJJYJu61dkxSaV/bpgazMdlIhPp59qzO4L/hS?=
 =?us-ascii?Q?qqS+cohVvkx4ZpYrH8yMzz94Klc5SILD7PTRy8TpfgntNdo6DI1mkU4kELRA?=
 =?us-ascii?Q?somQ243DILxKnnOP3y4xDs/gm1HtevqXezODn5UeP7ya8ciVyb/m3bV693+e?=
 =?us-ascii?Q?+ZqAaS6ZlDiLYFx5z3hJTY2bdmAyF0SqhKIdH8kTKfiVrxQ3L0DzpR/sQXKu?=
 =?us-ascii?Q?rdTwhHeQYIHsAxThNg5nY06w/PHb5Ivsh4ubAA8XEUq8gjQmYfYd/AxWMfff?=
 =?us-ascii?Q?MbDFJmzH6fxwk4fyopplVGudPcalbniFJ/nMYH4AKkYncrgTiEZO/MIWM7+G?=
 =?us-ascii?Q?ZzzvV8W7MYQv20RZcnz3R+y5vzMoHoT2blo6W8OY0HsSrm/j5nUpSRH+Cc+F?=
 =?us-ascii?Q?mtXdY+aFfVFm4Iuyxg3rJw40PJx4izN4H3IqSSF9jUnJIDA+j9pcx1Au6JZD?=
 =?us-ascii?Q?SuOfVnqOOAsWsYzVD9iFNPfqu8ZSGgW4MihXl8XzRIlBiDETeiaWAlK1o65j?=
 =?us-ascii?Q?rpr9XZWchUcsf9eK1jfiMjV/Lo8pfCiQqX19JWU1kkWngrqgzD3aA81UsBCy?=
 =?us-ascii?Q?+JEkEnmChE1zfI38YCqh1irDJczOm71R9Hy8kqSjXMiV7X5+F8m+VRB4eHlF?=
 =?us-ascii?Q?AN81l1UsNn3jh4eshlOBobpt1qIi+HnJ8fxhTqrQxOpCqc3KaneN/Uq1Br07?=
 =?us-ascii?Q?aThpLrRghsFmRWEEhJxEbQN0Cnh0VCPLZcx8dc3T8g7G5pUFemy/JpEl4ksh?=
 =?us-ascii?Q?ZvCeFwR8/UGKSE4tq+vVa7W+Cc671rdh12ZLmIH+w11snja1wuS2iRtJgoQH?=
 =?us-ascii?Q?/qcTTQXqNTf/XhBDU5Lj4CdNrajUojb/nsFLciTHS2ZrSACEmXE8sqhHh+fA?=
 =?us-ascii?Q?Gnu0kcwBfcFwpiu7B0opilO6dNrZsrp6Hw5p3/lsQofdb?=
X-Microsoft-Antispam-Message-Info: yZOlJFLkA2L0ToWsfePIypw/2Qn/kLhZFGuE+mq3H2dKw6aeRJqjjuPKdzyGIulmyowp1+B0xYp0uE6HLn2Ldyq4J6Ddz0oJLtd3uGMYp/W6AD568GQHp1cUd3T41Zo4wM5n6IGMvvJmSKmV09eznSbrYoSAHfSHXozWSqZkzW0towYv2lFKWAfMigwIy56a
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:BxpsNs27Wzp5cJYdqnEK+1YXpSnzhi290abhTUBTZCmoUuVjXpDZYgKlG4eKycqSBfYhUwP+mt4eSBCfVLtfVxfpJvdrmMZ363i/DwYhHPEUAodTqQOj9glpHocbFkQx1t00osSrg+LZYQChyl01awrinGEOeu+D/pAvfTMOsJNfadxFAlOr0Q+t+XoaIllCPI+k8Vu4nIV9wIMdvkgPwgri4WBvcozl2uNgGH4gCk0O+CXb/YFZ1Vu4SdZiOZ7XRxgmtcDDgUmthf8IHrLsqmXlUCGW1Rng80Gskm/cTBMQ0A/TPUj9slje2yzoLeeAm+LRf/BhTgO4u1Rn3nycTA/z6RlZm0CUOa+7Jv43Ey3CROsCD71PofRhiyaEBfRWrIcEnHMk9UDxD6126+IRWvyBCxyFZNeKKcBEErnlSz5XcboHhHt64QpAwOih/goHN3Ritar4uZreJN5leoGAiA==;5:kIuWxttBggmSh6GE9/fYPiXRdEccI47Egu9+BvfY51tlfGrkiBUBUrXHUPBvm3kxSkKIxKJlxCOiXNwJEx1iRKCXNBf55woxtSqlmmfmiSXaEZVfsQvccnm+i4HAhhzjBn1ZgslKzjayxiHjN9WxIDugzRiKaXjLNm8jWyoJigE=;24:Ng+RtTO2tdaFYK+oBVzBYN1/nP92kfE19OxDM+IaMREORhPif/+gfZGAXaWIW4ZWz1b8sS3nXn7DdPbwgduqMQAPdIFpPm5Ag27z08bAklY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:QBCLv2mhy5gbwECxHyGJnmp4e0eH3wU+NcXHhggkclJLurpFIXhV56EqPl9OAXjC2+a+xA2vaiVENSYXDewZ9TlwvtGZQF5CiLZ0CFCL8kIONKHwYoyJ4n0TneVN4b3/nTG9N/fBN/l1ByOPpq4xgjXM017yMMFpE8tfS+xZbnf7ygPzAzcXlFjW332iBwlrPgmuEQrx2TZUJmRJUnI1FnN69I//Fo06d+GOVl4e+ZY8MMZSuzySVvF5gD3qSUqJ
X-MS-Office365-Filtering-Correlation-Id: 018ee1b0-3379-463b-4da6-08d5ae638c92
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 06:28:08.4321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 018ee1b0-3379-463b-4da6-08d5ae638c92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894760308217340?=
X-GMAIL-MSGID: =?utf-8?q?1599151482801208054?=
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

Changes in v4:
  - move of_map_rid in drivers/of/base.c

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
 drivers/iommu/of_iommu.c                           |  25 ++++-
 drivers/of/base.c                                  | 102 +++++++++++++++++++++
 drivers/of/irq.c                                   |   5 +-
 drivers/pci/of.c                                   | 101 --------------------
 include/linux/fsl/mc.h                             |   8 ++
 include/linux/iommu.h                              |   2 +
 include/linux/of.h                                 |  11 +++
 include/linux/of_pci.h                             |  10 --
 13 files changed, 231 insertions(+), 122 deletions(-)

-- 
1.9.1
