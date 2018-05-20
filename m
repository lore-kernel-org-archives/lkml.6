Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeETNu3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:50:29 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:52496
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751030AbeETNuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:50:25 -0400
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
Subject: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Date: Sun, 20 May 2018 19:19:44 +0530
Message-Id: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To VI1PR0401MB2429.eurprd04.prod.outlook.com
 (2603:10a6:800:2a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2429;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;3:6k7GDC1GZddNUy+M52wiyFF8FHpH3CCJqpKgtuhEPIBVmAp5+uYm10GhkPGZ7f4DsPA0a4xNDVQW0QEUr50lFzipIOT5IvNRh5gwigN4LiSpI4qU1+m1fXRoDm9dmEknlGuFCBo/jWeQFBv2ORJBiy8ou7UcLL62Ean50xVF2v2KGmMyCqFDHHBwhH+iVwuYtMDtcoxY1Uvc554zV4VCallUOSqZ7i4kKqr7Q/GYdVtVftZC6vBLYAdlY3tHrRKA;25:GKilc2XjwPIJrDs+ue9SrwCjF/SrlM2NpjZWzWEYMc5/ygs+bemQLd2yJXEA3z1wvYKYKeljICG0QR6LaO3dwuh0TSmXrb3IpYLLe7/RSdBzkICYmLOt9FeU0z+o5l98dRwdq7BfoWGqd6NhGN9Uhe3VLi/T36mL3tKQ8V52zpBnPXBzUzW4oJMaVYmdrg6mvO/35veb3+jZ3B37I+f/880olHhQ7Sb9davBSLjNpY2Nr4O4a8wwMV1poiawVF5hjiX+XcClV8PJ197RtTARIkn1UWAsTHsEEkgYcR/W1Qs2AEv3S5EOwOfjvMAcpokNDJ9w3K0zvP0B860EZBmj6A==;31:MkXxms0R7uXpYiB+h7cGDqdXpflJYt1HcBy6JYSZD4XRyGjRBtWUQQN9cunJL8xQeI2s6LA43AyMd3pjSjg5yiOtZq7clZ+NE8+BShz/ZlIuyDs2uErSE+Rl5U/bwke4u1D9w/l7T8r4znpWVPbjrXMpbU13lxU8YDC/4z9Bc7fOWeO+sdWBFyX1DNqC7pFHTq2CRzwfH/QeRSs5e5QysIsjERo0Yx0kkbJCP0FaztQ=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;20:1ZmhagGt7LPGI90/weAr/IREI3kUogK0mFPZWR0yUeMzPW6qgBEEBEaUL56s4g3Epzvlx/az+JavdoiLKRLWUG5k/etRxji99gYVfRala6OZrXXdlI+/jtZz+XemPB5FFIMm8i9D/HmC8k4M5hcgJ04lONLDTskSo9mSsd5N/jUiFw5t9vGJbNIyvUZVylZsl1tuvpimQc4qYe5btnxL3n0nj/92kt9k5mquP+gz62TTboTYcWEKBI/eK3JyEyvorBdTOdNUYGlLea6f/beFWwqOLVaxcOqzxn7Me3i4EV+d0n/d/UhvhYI4UQKlZvjBuYHs/mXkLNLL5O5yKjSRz3uPwj6dxth76oDVSQI809jxRjcSeobLfnfL9NKV4JiBIaB48PzDq6EiWjlbIBhriG6uXl78mXlekkmB0BCRZ9VTpr7PPUuKjfG7irzSbM/wTmNE/0ufgck/zW9wfcI8HXqi5gr+GNsyU4E4Yek33i8lJ/0wbn4UoH1jp/xbJG8o;4:ZGA/9/P+pLTTPhcR2t215xXb8/6J8z7pRsj/YJhGPrOiJ6Csi20E+Lq7Hk7rCqJmeWhxpCXITtHk5gV6shitayspeAdu0HUty6OYoQwX54m2nzLCMfJDb0fqA2UK/ebz6zj0Bejv5ett6rf91aYW2r0hmlwPVGzAzdr13lL7tYcbXKkMb77MV4nMlq2G+3zbIkr97eiJOoQbDEK5gzCvfZ9fuZSOtEBm741Q/pLLqJWrb8T/IE1ul7mVM7A33ScrmAKGAJBmnrV47a2IFyouQA==
X-Microsoft-Antispam-PRVS: <VI1PR0401MB24295AC1AE9B64B6C4229417E6960@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2429;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(54534003)(316002)(50466002)(6306002)(50226002)(47776003)(3846002)(86362001)(39060400002)(66066001)(6116002)(8936002)(966005)(16526019)(8676002)(7416002)(53936002)(6512007)(48376002)(486006)(186003)(26005)(44832011)(478600001)(81166006)(81156014)(5660300001)(7736002)(52116002)(16586007)(51416003)(6486002)(97736004)(36756003)(68736007)(305945005)(4326008)(6666003)(106356001)(25786009)(5009440100003)(55236004)(6506007)(386003)(105586002)(476003)(2616005)(2906002)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2429;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2429;23:csOi91maexFPgGN15UHPXz+7sr/UGT5M3zxZlqI?=
 =?us-ascii?Q?96tFvq+tjwOETgyUhncRKXm28z6mjFJf8Fnp9IXJma96xrB1BXMDcqtriFeA?=
 =?us-ascii?Q?CCt1QS05X7VpcVUkYn5JNo+XwwZLWjiGgCMmkFVcw/NvjznA5q0noteqTHAx?=
 =?us-ascii?Q?3UCxIM4EK2m/CsmjVk9kO0fVQFZds6HI8L98+XNBbQDBvxqoWPKJPfkNFJtR?=
 =?us-ascii?Q?jIOuLRCeS6PP34xg6Bw3Mjs/wDCAh0qdZmzm9O9ntDWb1qfXe8Lq9EIZQ8LK?=
 =?us-ascii?Q?eMpK7AaLvVL5Pd6/eIHnsvJt/guq6gRzslkUhTu93q/34FEDEGUGfDZbH1NR?=
 =?us-ascii?Q?ELEzuNL4upqJN6GbFdFwl2gaq8oRPJx+fh7DRnbFteCTpH/OplP16WBXYyFT?=
 =?us-ascii?Q?dnpRfHNRvn7SzrXCCKOx+Woit6WIUfBP/EILKE/bJhYJSqCAdeJN8wSC0jUa?=
 =?us-ascii?Q?tA86xOOVoz0eH3xvwvr7xPL8dt669j5itn7dXnLjur4qKPdCJY3Xy5DAjuVD?=
 =?us-ascii?Q?v+nmTg2iM9hJYYksIYhg/znxQa9CMx1cSG0zguKQPRPfthyKzVb4m+T+lFJR?=
 =?us-ascii?Q?zRfwOBQMKsYp8Uj3LJGSIiZ+oOGT3Dc6VHYnaITwxZ9jMusWMdk31dNdiZ6t?=
 =?us-ascii?Q?uLUbPbN2YA56mwX7RZ/KNKw/lnSOtNpZ10F4nDlVP+RVEppB7yVB9ffokvzR?=
 =?us-ascii?Q?ctDicPboUGin5PXrXJxk8pUuzIbO1nhR8moqyUcdeq8qmAu4tb1t0RsXM3Sx?=
 =?us-ascii?Q?k25CTO3UMOI9s2FojzWAP6mikSKHHlHPBDKGjz4bO9ORu8aIyR8FGYU4YC67?=
 =?us-ascii?Q?W7m17patP382EO8k9GFigMSbaR6pADukwTYchQdsesL7xxYLtE5g7TIyaziR?=
 =?us-ascii?Q?dGzVw8z0dZGWn70gxYroN11BKgIa8PfbZJthsYuG0IXWFjT5PVk5dlH6b5cD?=
 =?us-ascii?Q?2etBN82OYiZWq6cHP0VU35Xe2BTSZATvArzYfIchQqQFQeOTlFYPXaREf3+E?=
 =?us-ascii?Q?c3UqvO1VjMSAZ+sIR9rB3IX/vfPZNWWWCfBQpOF5l9I6Yy0MYQiOUKkhOEC5?=
 =?us-ascii?Q?Xju3JrDJMhAZ7zOjXoYvbfpyDhZRoQHyU3H9Jqem/St/lXVK0nmT/v3wWK8D?=
 =?us-ascii?Q?bbvfdZzfFNHH9OCi8CicVDj2RJywQ5JAwIemC+ZM0/dglHZo+45w71qx7mDY?=
 =?us-ascii?Q?isvJxRjPvdCG1aTAlVrvZY/93NFmZAQjmaUtfSlLeLDmjHu8u2pSUX9nqEVu?=
 =?us-ascii?Q?JZHixYppDaYz/24UV+FRzkF7RCDDFh9EXITDbRU5+PbByB5/jy8HOoiDMsY3?=
 =?us-ascii?Q?1l7ZxVORrQGPhQEPqdfrx00o=3D?=
X-Microsoft-Antispam-Message-Info: KQaeF767TVeBSqxx4S2bYHujudQ+XfBDbov34XdkUxuCM2kzKzIc11v6a33vFMLRUUAhhTqU+lJpuhInaWofN8vt03HnrS75NYeiDV1z5+DfYt2Dpiu1SDvPuFwmEcXP7AMSdEePQU9hWdIEYLnYTLAau68rZKKRB0Cm8fqcvP3C2RuCIyb0ZOzy8A4nNf2P
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;6:4F7EufLTcc8pRlc5GHD1VOmH7knqKqvfQt+41mX11s1ZZifAwOqeIzUCAKr4Z/Su0lcWPg6MkZmhR0gd0NfScNNtMWq/Auc5I/eSbEg6bEtGkT36gZFVBkJxkLv+cXs9tTVbRMzbPuc+srRvMIOfwPp/0Mz6hEVG0c4jdY+40GZ0uC7iUInu/IPkLOC7UAE02JYSKJuDOf9mxCmPf86rnXkJpKHMZaX4OMlddFxdFmuEUPclBt5yCs+Qoa5IRmdCPUIIn3JJRFHHlesELw0Ld28rfjaEtxRMIIERRYTdhy2cmJDkNYRD6C4JKhHU6dlGyi0zh+N4jQK5ADtopyCY53BSu6M9RQXT98+CThof/AUUJSso1ZihMJ1H0FXdxr+qvz5oa+JKyo+NQDpabLHv/luagq3+jxzxGu6XkYmKkaTMmkBXdAku3YNbtIM1hN6TRh0K0prFuhbGKCxVl9JnyQ==;5:9jpxPuPpvBMQuhCo591VCmyUrSCVrNRt4nY1N0Ugx1dKus5RkUk2MUEG1BcsdHLZMnIkHj5lms47nF/1lb8JCk9n2M4cD2EkBn1HDc5yXKwY2oDWmfBGyh130466yZzQyM9FLb14ISlgXVk5DlBj/qMYggWee66cV6BZXHJd0qk=;24:L0UITCTyzNSq/GHnBSCqoS2pXaSpZUlWspp98j9cTqaB0fEbFlNXmTg8EEeMlXBWxprvKXXmNXBGRUySdLH1xaWaoZ6Wi/PjLnF5iCuHQp0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;7:DpGU3QXgCHMM0st+N1HM/+CUN1mX+4jtObXL0Lt5nIiH/IEYw75oYXNLaH2f5mzsEdlfjgYs9YT1J/jXrQU4uIwnGlauGUt5y5sx18m3o5V+Vlcq5lxODD7kGmPZFHuvfIV8Te8o3ylWKsornRypDwdxw7oAsmePJvr45x2i7YRSe7htEh/MacPeV2LiwWBa3Gsz4Z/tFKue5JoDdoZDwdB3gUe8v8a6XuL4M1pmaMDT1THDBQakTnUhifUv/d6u
X-MS-Office365-Filtering-Correlation-Id: 0a460334-371e-4753-b26f-08d5be58a050
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 13:50:16.1335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a460334-371e-4753-b26f-08d5be58a050
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset defines IOMMU DT binding for fsl-mc bus and adds
support in SMMU for fsl-mc bus.

The patch series is based on top of dma-mapping tree (for-next branch):
http://git.infradead.org/users/hch/dma-mapping.git

These patches
  - Define property 'iommu-map' for fsl-mc bus (patch 1)
  - Integrates the fsl-mc bus with the SMMU using this
    IOMMU binding (patch 2,3,4)
  - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
  - Updates the fsl-mc device node with iommu/dma related changes (patch 7)

Changes in v2:
  - use iommu-map property for fsl-mc bus
  - rebase over patchset https://patchwork.kernel.org/patch/10317337/
    and make corresponding changes for dma configuration of devices on
    fsl-mc bus

Changes in v3:
  - move of_map_rid in drivers/of/address.c

Changes in v4:
  - move of_map_rid in drivers/of/base.c

Changes in v5:
  - break patch 5 in two separate patches (now patch 5/7 and patch 6/7)
  - add changelog text in patch 3/7 and patch 5/7
  - typo fix

Nipun Gupta (7):
  Docs: dt: add fsl-mc iommu-map device-tree binding
  iommu: of: make of_pci_map_rid() available for other devices too
  iommu: support iommu configuration for fsl-mc devices
  iommu: arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: support dma configure for devices on fsl-mc bus
  bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
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
