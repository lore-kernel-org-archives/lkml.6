Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx4/WxvrRLiu0KSiI1rzeQrj7o16ECfWk+vHs3kfJ3eEqZsxX+aZX2aI2KeQzy3sUsM4eQ6NP
ARC-Seal: i=1; a=rsa-sha256; t=1523960796; cv=none;
        d=google.com; s=arc-20160816;
        b=ccNuz5ohBx0O6XYfYUt+EniONmjAPdPMA10BHtTurqacU1swiGtJNtS0KXmvX0GvrZ
         RaHtf36983mEnKLuSxWWwLtnvDowQagGWXWJCsY+QGg8pd/FfuZc0pyNm7JIGaqI08Q0
         +RpuHnNJM/1VNb+PqkDi/1zkbl9Epd2nfnSjGqhc+Kg4V7Daa7R610zogOpv9+MfWdlu
         rcT8rTicu8s60DoudZ7aA+xXacjDWSPQ7lLv0935B4hsW0SWswHeBMACbu2Krb9nJss4
         BMy8VtWVPwkLivt+EyqsSwAnz6QlV+t2AQGdPuwhbkdKPqyfePK3ZwSlTrcxjU97Zg43
         eW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=BwlHZIzx8ceY7Q46TgvxGVzvv+AfmMLRbFQ5JnarLFY=;
        b=yIiofWXfABfWyAo41xVRuQRnSIX7y8wpmYNgJkKxOY28c0Uj5LO06r+5so0Ud8ceBf
         m9dsS26MTt98gfFW1flrOmrlbRgOTrdIMor6EOLIZWOrLOQX/yhaRgTwnhwBcJMkzKA7
         SmpvG0stbk0zN7fC42khWg+HQppriOTBpTVlyDT391/ozwzKux8bjKrKgBwmHF3xeEh+
         Kn/I3lIXUW8CXwhmgkLi+26AY5kouh/9pPzIvIb7s6Fu861jd6lOx/9UifUd7jyqmS7a
         EoVT1cVCa+o22UXcDubVgjYYx04tsaI4nTKrXZcK8Q2DdMjPWBx+uhzjXoGotZ7yre68
         TJ1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Swli9fDj;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.40 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Swli9fDj;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.40 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 0/6 v2] Support for fsl-mc bus and its devices in SMMU
Date: Tue, 17 Apr 2018 15:51:48 +0530
Message-Id: <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::21) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:IMTo/RvN2eUv9pfo64Jd4IDIFUGuaByTl+3obe9zXfxIYOJ6tKx4idfsLwTIuZzyRKP8rfnz1e7euejbRAfsPjRRuu/3+64lOn/Vd0ckLa4gDTk4oU/11YP/GFhx4ImbxzpBY83Lk92tUkuTgmbt983ZW+pgdL8mekfwcY6+El6w3NUmbSlGi40ZdXpRQOUHgcS25OBd4U2LAyurY4MGW/6npFeQ+ddqLQ9AY7hnFDAaZfhCS0cRyVTWHfaqVxBw;25:4jVeY+CdsAgKYsrDddMRMHh1xpO7HnRvb5SaUf48Po3CJAcdE1NeucuFDXMwOWXgrGGjHb15APe/iskIpDXPXUVrCCkL1BDkDsat8c6ycQRtrd9jaYkUsANhVIjJJr6/fRex1D4YuA64HAGMQJe9QNgHxXNbZQHHOxXDmB/4+1Ep1tP1k4gL9voiZGlnoyinAPLseF1s4ZNHYBsYU3DtAOvZ/AcZnsi5Y7ZQZKcozolzALIyppqL60LkDWcqwTuKWVp0z/rI8maoZdtsl8mTtAI+j4mZ/nUt1zyAy/lDgoFv8Yx0q1OmbXiKM4yaT5l0IqgSm3joKYm72iUA2kaW6Q==;31:4DhhOxFP5mCmSKAm44VTese9UKZwJb9tp0XVSD+ZnjdK0fEk6z9r1MNeUcziVv5BtkRhzsrxj5xC/ld+VJAEySmcLjYiP9DhnR5QB1vRhfkIyUgC0Wgvb5pkSFUAO38pRQHqT1Eiqt+2paC+QwgEsJbHYyJSIqhvwIrEcIxlhgeLuYos5YCz8+oKlbFo61sP2qNFD1PuDLF3x4+b+iA98WtBmZNGH15VX55wfJymQ04=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:aNFJ3vw1pz5+jWRziiitBbjTpDHjF/TIcls710m4BOyCvrYledUj0kYdNUr58qee+buEwjTRX0uWww/RNobS5BFlLi5DkVsZw+Jq6CfE+JQyjYq25weuZY+04vl2JCCYolukjlo2UFpo6qOfBfK6H5385yLNsQWOHMiniAeQpi3d0OieWztF5j1L0cSsKIpY4l9DjC1VwAapR2H8FN9p0FoGoPRQiUyI7s0Jv/HBAjEbQ+8A4hYbIjS3nDkVBVtfJiuhvzZcMLpI7MwJBxpQv5pn1vzyo06WmACZXIsOWFimXTlS2jMGKjb7vuMA7z2AzTafUFqsIqFykZu1Iuta85jsAU61rpmRLDdWE0pFoWaiYbOb62tdgfqWMrGEAYhrz1B4f5iRATtkbNF8AepPVJ7g+TMzbt9y3gqlDU2jTFhGQFBUr9K1p1JS/YQLyVAZnzBTWlVObgxW6AomL+EyQ8mjj/9lKtLpBBKw0vxQ8O7yqKaNp83s7Gw88c+ruqvx;4:bHlWNzzBVi20Fz73sNEUJGOIiIf/LgARud6Dnz6xJiZLr45V7XYso9LveVVPgCgxeb7PnaK01B+dwZHBGqBcfzXHsEIP+562iPqIQHznNAcNNBaDkNfiJqM73Il8Hi7XpG+WnDPbWG+7n0/FSMnzqGpkyWHjLc7fgzWfQzJqutj8sRVh5wt4AtybJfYU15yHeqi8bR7z5SHOf1j4oPX30yglpJxdWaq/FWWV1r1ZgewmSGSKaOkfT1vDl85tHtD9BrdZQ/3WTPVLPvSRToh33g==
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2418B00ED2EC664398CD282FE6B70@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(6506007)(386003)(2616005)(446003)(11346002)(316002)(486006)(97736004)(956004)(6306002)(16586007)(76176011)(55236004)(6512007)(186003)(16526019)(44832011)(48376002)(476003)(86362001)(966005)(8936002)(7736002)(8676002)(81156014)(81166006)(6116002)(3846002)(2906002)(53936002)(50226002)(66066001)(68736007)(5660300001)(478600001)(25786009)(39060400002)(5009440100003)(4326008)(47776003)(36756003)(106356001)(305945005)(105586002)(51416003)(52116002)(26005)(6486002)(7416002)(6666003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:atdbabpJAiPd2HYf68i6J1Voq5i14NN8BOEMOvr?=
 =?us-ascii?Q?hKD0Mk0dXlITMdvLQXzRfHbfa/sHzx4rIeeLFniiCfTjjoUEw9HS9EoFOijT?=
 =?us-ascii?Q?RLv/GBZTZlBQ3yWctjO6UTuyzE5+zvJqnoiwEsJtHpbm0FmbfoOp/PS+qHpT?=
 =?us-ascii?Q?si8AEFYzFNDj+UuVPid6Vh6UooHZTj/wd+yrU79gkCYewRgkp1pYdmCA9yIK?=
 =?us-ascii?Q?TJwa2PzsMiAvflPf7SNznN5WejY11QG6UVhOSeajjs0ZlYltCWVKKXT3986X?=
 =?us-ascii?Q?G9OQSR2ZAlmwEk2qe3iTzQXwHFJtIXYr1KNJ3U63AdwtgMJrpL393eTAHIm6?=
 =?us-ascii?Q?uRZ+CzEap53XVxzDdfNpcg3GZlfV05yethLKfYtqHaxS+pDWQKS9mD99vU5p?=
 =?us-ascii?Q?iKnt3x6II/JfbpVDnJQB7ZtvSGTzMjnlOr3We7TZ+toNyX2wVgmHCFx7ENM6?=
 =?us-ascii?Q?ZKWEOyrXwHPEYGobzwXtYAJevKrO5GqomGjmJm9XgLbYpxgJEcJFR8G1k8zh?=
 =?us-ascii?Q?8MwDvMYigF4hYdOWQV59i3O0Vam+KK7u6qXzcvYVpku9BuMtNvhvyxEPMzIV?=
 =?us-ascii?Q?IctLAQ23xbuhqpqxk6a7Ym+9G5jEBcAuq/ldDaGm+rQ+9r0z1J+Q6zKPnH5r?=
 =?us-ascii?Q?J5AiKhZKCIMfWJ0Wg3jTZcrupOaOiNcfVt3aOD/Iixl0/f0nkCh6OGYG4sFR?=
 =?us-ascii?Q?i2sRD/G55E/uGMltf5jxY6sUzP8yge1JTCdLaD6q1vH9SBZj3YmQjx9GeY9b?=
 =?us-ascii?Q?yR1i2wzPp85RvMdb8RjKM7NqKjd4ByWJS/3g+f+caHIni/7ReCWb7LwoFE7N?=
 =?us-ascii?Q?Q4veBuZilB4tBq0AUf9H67KUhOZmpXFUc8MzrMkXVCKWe3rznppTQtyIV0Sj?=
 =?us-ascii?Q?iRqdFBPtikfwk+J3ZMqmYCKBQ+lZ8F+rphK2t6axp8J270qRgAIfCx5hr2+b?=
 =?us-ascii?Q?ciykCM8IwAHNB2e3SLT8gSgO0HXKwO8vanbI+Otoy5gQt+6pRe5q2DtpMeGe?=
 =?us-ascii?Q?p/YCbi7hWBSrPHZZKN8qD2bVBp6dtVppTg3HueO69/A9nhS6IvUOa5/B6Fpj?=
 =?us-ascii?Q?eLKcSXni810CPdFgkEzEvhiZhssuUoMjeRq/6y3fZFDISemGT4Arxcz+5gEW?=
 =?us-ascii?Q?R8BjdmCeAELO88XMBE9cJoSCYNZXe8zaLBgwkOn41pOQ0diYErBjM5FfJGNF?=
 =?us-ascii?Q?3zGIr1sVQTOZPlxFf1KHLDw1dxiV4zxR7F3GNq+CTgs7beQ01Dv1sg5hFIDN?=
 =?us-ascii?Q?+LyFrY9y+ahGEIqUKBvebTMTKINPeByYt63Vt0s7BJZRh4hZEnZrfEsydRlU?=
 =?us-ascii?Q?qx61yUp83BBsdV8PQ8gTmmGzU8OJrkM7J96KW23rSxIDU?=
X-Microsoft-Antispam-Message-Info: R6/vCgPPoQlAljaHkbn2VbbglJm8TjI9iypzmrKvc/Cs/RrC+/YzNsECNVInj2JfxtDVJm4Luiru9EEr1cyfuBxAxxkiDyqtIJgZaJ3gOmxEXU2Dvhoi+H9qQv5XzffefpsYjmIl48gwR1Nl0eApOUzNfm3r6ZpR0HEdtLRjBJwWv5zd9oh9z9b6ve1whEtZ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:iOLrGiFFaAD7CnCFC8RWPTbdQkPx2mRqBbYtdXxb5PreZ2ZFWKqZR6UiDzM3p97vWVLxGCuyEtB0JXCkntq5Pc4xphacsaHAoPjRk0UfzFb+8Gp4oq0+5MyMKPOHwrvFomtr0Qy0Vshw5vezXy6pk6m3BSTxgLTem4qXesECQrSrAl2y5A6SpdDWdcLNWpDPEnDUiVJ/p3hjXJAzTd7x6sGvk1YDl5nyzLAocnP8eBnzl+HZiWrHFtXFfzAXvmNtKUw7fm5W+AtPlh3/bPSo4UAkOjcQdO5rxwkR+loR3Z8MP44kffqWwmGdD0xkuT4myl1ZAlqYwXItxj42aBwbDBOEXBkjicgdlw4lq4w/lyFBoG2hM3lcsN/1ZF5dnEe4eGEoT+L+qGZeLQ7gJgzaN8UPYl/xR0upRcvGYsekGlSnUgianoD+t8+w+O7du6+rgSywVU2ZImGi1db8qGSH7g==;5:3yeV2Wx3K6mkg60WVRFKqqW6UVc5kaQC/sTQnH0UJVIHzTR8nb0AMl+cbcxKk0bB9sYmzaKSg1BVVGRuGXLn1UJloG/uA77EJMEure8ssdAWd5OBeKopVaulZZBHKUeFYR6/kwXq11E3Dz3f/U+33QUtQD5RMjY+bq6u+Grgsqw=;24:nOz2HmG1CoD0FIa10NjNCBvIi2e5zgUeXmUR0qbfEdZ0tp3BCAV1vu0A0skTqY4uLsjaofg5hM+EluYAfSsFc4csg/scDQ9H752Yf/zTjow=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:hCw0byVVwQkdGjMkC6wkvcBoHOYCwKNVOEcDLhEOY1WvNUQj5uksqFHCIZHClXgab4iw+qrNk4k/imT5ffuKZd2fVMwCnLNPaNWPu/DaRKHscDxjlttWxanMOdgZ+tX9omONNGFbmXITjIksKPGwNBlBq/IVXn+XZaDOcExlZ45v4g6CyKEzSK0W0esQ+CSjmFLIelActaGV504iNeuL64+YUn2DP7z+xKr6KvDvsJjo0DJiExWevujE2+RpwH5M
X-MS-Office365-Filtering-Correlation-Id: 8e8bcb96-dedd-4b8c-d087-08d5a44db10b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 10:26:28.6012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8bcb96-dedd-4b8c-d087-08d5a44db10b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108364344914360?=
X-GMAIL-MSGID: =?utf-8?q?1597988716109702673?=
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

Nipun Gupta (6):
  Docs: dt: add fsl-mc iommu-map device-tree binding
  iommu: of: make of_pci_map_rid() available for other devices too
  iommu: support iommu configuration for fsl-mc devices
  iommu: arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
  arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

Changes in v2:
  - use iommu-map property for fsl-mc bus
  - rebase over patchset https://patchwork.kernel.org/patch/10317337/
    and make corresponding changes for dma configuration of devices on
    fsl-mc bus

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   6 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 ++-
 drivers/iommu/arm-smmu.c                           |   7 ++
 drivers/iommu/iommu.c                              |  21 ++++
 drivers/iommu/of_iommu.c                           | 126 ++++++++++++++++++++-
 drivers/of/irq.c                                   |   6 +-
 drivers/pci/of.c                                   | 101 -----------------
 include/linux/fsl/mc.h                             |   8 ++
 include/linux/iommu.h                              |   2 +
 include/linux/of_iommu.h                           |  11 ++
 include/linux/of_pci.h                             |  10 --
 12 files changed, 231 insertions(+), 122 deletions(-)

-- 
1.9.1
