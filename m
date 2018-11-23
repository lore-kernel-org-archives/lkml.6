Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CABDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260F920672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260F920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501922AbeKWNhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:37:40 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52945 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389875AbeKWNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:37:39 -0500
X-UUID: b8f42b8cd26549588c2184a8ac2eebf0-20181123
X-UUID: b8f42b8cd26549588c2184a8ac2eebf0-20181123
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 573804835; Fri, 23 Nov 2018 10:55:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 23 Nov
 2018 10:55:11 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 23 Nov 2018 10:55:10 +0800
Message-ID: <1542941710.15759.8.camel@mhfsdcap03>
Subject: Re: [PATCH v3 00/15] MT8183 IOMMU SUPPORT
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Fri, 23 Nov 2018 10:55:10 +0800
In-Reply-To: <20181122133526.GA13896@arm.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
         <20181122125931.GC1586@8bytes.org> <20181122133526.GA13896@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-22 at 13:35 +0000, Will Deacon wrote:
> On Thu, Nov 22, 2018 at 01:59:31PM +0100, Joerg Roedel wrote:
> > On Sat, Nov 17, 2018 at 10:35:27AM +0800, Yong Wu wrote:
> > > Yong Wu (14):
> > >   dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
> > >   iommu/mediatek: Use a struct as the platform data
> > >   memory: mtk-smi: Use a general config_port interface
> > >   iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
> > >     helpers
> > >   iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
> > >   iommu/mediatek: Add mt8183 IOMMU support
> > >   iommu/mediatek: Add mmu1 support
> > >   memory: mtk-smi: Invoke pm runtime_callback to enable clocks
> > >   memory: mtk-smi: Use a struct for the platform data for smi-common
> > >   memory: mtk-smi: Add bus_sel for mt8183
> > >   iommu/mediatek: Add VLD_PA_RANGE register backup when suspend
> > >   iommu/mediatek: Add shutdown callback
> > >   memory: mtk-smi: Get rid of need_larbid
> > >   iommu/mediatek: Switch to SPDX license identifier
> > 
> > This should probably go through the IOMMU tree. For that I'd like to
> > have Acks (reviews are even better) for the io-pgtable parts from Robin
> > and for the memory parts from Matthias first.
> 
> Robin already reviewed the pgtable bits, I think.

Thanks Joerg/Will for your comment.

Hi Matthias,

  Could you help also have a look at this patchset? Especially for the
memory part. Thanks in advance.

> 
> Will


