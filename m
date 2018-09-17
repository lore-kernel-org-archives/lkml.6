Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84600ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234C1214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234C1214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeIQLlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:41:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46779 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726863AbeIQLlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:41:20 -0400
X-UUID: 5823fec37d274453be009dd91287fb3a-20180917
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 650972610; Mon, 17 Sep 2018 14:15:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n2.mediatek.inc
 (172.21.101.79) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 17 Sep
 2018 14:15:20 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 17 Sep 2018 14:15:19 +0800
Message-ID: <1537164919.12287.0.camel@mhfsdcap03>
Subject: Re: [PATCH 01/13] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
From:   Yong Wu <yong.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Kurtz <djkurtz@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>
Date:   Mon, 17 Sep 2018 14:15:19 +0800
In-Reply-To: <5b9f3f52.1c69fb81.a7f7c.f34e@mx.google.com>
References: <1535954502-30646-1-git-send-email-yong.wu@mediatek.com>
         <1535954502-30646-2-git-send-email-yong.wu@mediatek.com>
         <5b9f3f52.1c69fb81.a7f7c.f34e@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2E4A1360F7948DE17AD9FE61AE47F367D3CD7457066D6DFB832C76ACEE8609872000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-16 at 17:26 -0500, Rob Herring wrote:
> On Mon, Sep 03, 2018 at 02:01:30PM +0800, Yong Wu wrote:
> > This patch adds decriptions for mt8183 IOMMU and SMI.
> > 
> > mt8183 has one M4U like mt8173 and is also MTK IOMMU gen2 which
> > uses ARM Short-Descriptor translation table format.
> > 
> > The mt8183 M4U-SMI HW diagram is as below:
> > 
> >                           EMI
> >                            |
> >                           M4U
> >                            |
> >                        ----------
> >                        |        |
> >                    gals0-rx   gals1-rx
> >                        |        |
> >                        |        |
> >                    gals0-tx   gals1-tx
> >                        |        |
> >                       ------------
> >                        SMI Common
> >                       ------------
> >                            |
> >   +-----+-----+--------+-----+-----+-------+-------+
> >   |     |     |        |     |     |       |       |
> >   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
> >   |     |     |        |     |     |       |       |
> >   |     |     |        |     |     |       |       |
> >   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
> >   |     |     |        |     |     |       |       |
> > larb0 larb1  larb2   larb3  larb4 larb5  larb6    CCU
> > disp  vdec   IPU0    IPU1   venc  IPU1    cam
> > 
> > All the connections are HW fixed, SW can NOT adjust it.
> > 
> > Compared with mt8173, we add a GALS(Global Async Local Sync) module
> > between SMI-common and M4U, and additional between larb2/3/5/6 and
> > SMI-common. GALS can help synchronize for the modules in different
> > clock frequence, it can be seen as a "asynchronous fifo".
> 
> s/frequence/frequency/
> 
> 
> > GALS can only help transfer the command/data while it don't have the
> > register, thus it has the special "smi" clock and it don't have the
> > "apb" clock. From the diagram above, we add "gals0" and "gals1"
> > clockes for smi-common and add a "gals" clock for smi-larb.
> 
> s/clockes/clocks/
> s/don't/doesn't/
> 
> > From the diagram above, CCU(Camera Control Unit) is connected with
> > smi-common directly, we can look it as "larb7" but its register space
> > is different with the normal larb.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  15 ++-
> >  .../memory-controllers/mediatek,smi-common.txt     |  11 +-
> >  .../memory-controllers/mediatek,smi-larb.txt       |   3 +
> >  include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
> >  4 files changed, 153 insertions(+), 6 deletions(-)
> >  create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
> 
> With those fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob. I will fix them in next version.

> 


