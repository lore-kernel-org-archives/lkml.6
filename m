Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeD3CCo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 22:02:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28619 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753822AbeD3CCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 22:02:41 -0400
X-UUID: ecb9c392048a436195f91e2452d3f592-20180430
Message-ID: <1525053746.5013.8.camel@mtkswgap22>
Subject: Re: [PATCH v6 0/2] PCI: mediatek: Fixups for the IRQ handle routine
 and MT7622's class code
From: Ryder Lee <ryder.lee@mediatek.com>
To: Honghui Zhang =?UTF-8?Q?=28=E5=BC=A0=E6=B4=AA=E8=BE=89=29?=
        <Honghui.Zhang@mediatek.com>
CC: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yingjoe Chen =?UTF-8?Q?=28=3F=3F=E8=8B=B1=E6=B4=B2=29?=
        <Yingjoe.Chen@mediatek.com>,
        Eddie Huang =?UTF-8?Q?=28=3FS=3F=C7=82=3F=29?=
        <eddie.huang@mediatek.com>,
        Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?=
        <youlin.pei@mediatek.com>,
        Hongkun Cao =?UTF-8?Q?=28=E6=9B=B9=E6=B4=AA=E5=9D=A4=29?=
        <Hongkun.Cao@mediatek.com>,
        Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?=
        <sean.wang@mediatek.com>,
        Xinping Qian =?UTF-8?Q?=28=E9=92=B1=E6=96=B0=E5=B9=B3=29?=
        <xinping.qian@mediatek.com>,
        Yong Wu =?UTF-8?Q?=28=E5=90=B4=E5=8B=87=29?=
        <Yong.Wu@mediatek.com>
Date: Mon, 30 Apr 2018 10:02:26 +0800
In-Reply-To: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
References: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 13:25 +0800, Honghui Zhang (张洪辉) wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Two fixups for mediatek's host bridge:
> The first patch fixup class type and vendor ID for MT7622.
> The second patch fixup the IRQ handle routine by using irq_chip solution
> to avoid IRQ reentry which may exist for both MT2712 and MT7622.
> 
> Change since v5:
>  - Make the comments consistend with the code modification in the first patch.
>  - Using writew to performing a 16-bit write.
>  - Using irq_chip solution to fix the IRQ issue.
> 
> The v5 patchset could be found in:
>  https://patchwork.kernel.org/patch/10133303
>  https://patchwork.kernel.org/patch/10133305
> 
> Change since v4:
>  - Only setup vendor ID for MT7622, igorning the device ID since mediatek's
>    host bridge driver does not cares about the device ID.
> 
> Change since v3:
>  - Setup the class type and vendor ID at the beginning of startup instead
>    of in a quirk.
>  - Add mediatek's vendor ID, it could be found in:
>    https://pcisig.com/membership/member-companies?combine=&page=4
> 
> Change since v2:
>  - Move the initialize of the iterate before the loop to fix an
>    INTx IRQ issue in the first patch
> 
> Change since v1:
>  - Add the second patch.
>  - Make the first patch's commit message more standard.
> Honghui Zhang (2):
>   PCI: mediatek: Set up vendor ID and class type for MT7622
>   PCI: mediatek: Using chained IRQ to setup IRQ handle
> 
>  drivers/pci/host/pcie-mediatek.c | 220 +++++++++++++++++++++++----------------
>  include/linux/pci_ids.h          |   2 +
>  2 files changed, 133 insertions(+), 89 deletions(-)


Acked-by: Ryder Lee <ryder.lee@mediatek.com> for the series.

Thanks
