Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD4C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F9B218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfAaDVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:21:22 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:37688 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfAaDVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:21:22 -0500
X-UUID: dc45659d30064ed0be046f2078a93792-20190131
X-UUID: dc45659d30064ed0be046f2078a93792-20190131
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 480530882; Thu, 31 Jan 2019 11:21:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 11:21:06 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:21:05 +0800
Message-ID: <1548904865.19710.37.camel@mhfsdcap03>
Subject: Re: [PATCH v5 19/20] iommu/mediatek: Add shutdown callback
From:   Yong Wu <yong.wu@mediatek.com>
To:     Evan Green <evgreen@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 31 Jan 2019 11:21:05 +0800
In-Reply-To: <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-20-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 11:12 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:00 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > In the reboot burning test, if some Multimedia HW has something wrong,
> > It may keep send the invalid request to IOMMU. In order to avoid
> > affect the reboot flow, we add the shutdown callback to disable
> > M4U HW when shutdown.
> 
> Sounds unpleasant. Hopefully the reboot flow still continues properly
> even in that case, since this shutdown code may not run during some
> rougher resets.

Thanks this hint. I will reword the comment avoid writing reboot.

> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks.


