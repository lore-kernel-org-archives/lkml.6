Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BA1B4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71711208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71711208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965511AbeFOCsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:48:14 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:1806 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965345AbeFOCsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:48:12 -0400
X-UUID: 7a6089e3e55d4d448b4f3b1b3c142cb4-20180615
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2010608972; Fri, 15 Jun 2018 10:47:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 15 Jun
 2018 10:47:57 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 15 Jun 2018 10:47:56 +0800
Message-ID: <1529030875.28160.10.camel@mhfsdcap03>
Subject: Re: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Arnd Bergmann <arnd.bergmann@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Date:   Fri, 15 Jun 2018 10:47:55 +0800
In-Reply-To: <CAHp75VcEp2kFO4hncvMS4Dh1AzvoFbrps7+FLmdk0RLyNTHz7g@mail.gmail.com>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
         <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
         <1527850145.28160.6.camel@mhfsdcap03>
         <CAHp75VcEp2kFO4hncvMS4Dh1AzvoFbrps7+FLmdk0RLyNTHz7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 13:52 +0300, Andy Shevchenko wrote:
> On Fri, Jun 1, 2018 at 1:49 PM, Honghui Zhang
> <honghui.zhang@mediatek.com> wrote:
> > On Fri, 2018-06-01 at 13:17 +0300, Andy Shevchenko wrote:
> >> On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
> >> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >>
> >> > +#ifdef CONFIG_PM_SLEEP
> >> > +static int mtk_pcie_suspend_noirq(struct device *dev)
> >>
> >> __maybe_unused
> >>
> >
> > Hi, Andy, thanks for your review.
> > Bjorn had point this out that at:
> > https://www.spinics.net/lists/arm-kernel/msg656774.html
> 
> Nice, one more maintainer with strong opinion here.
> 
> Arnd, that's what I mentioned as a split in opinions earlier.
> Any new developer or even existing contributor would be now really
> confusing since maintainers asked for two different approaches on the
> same matter.
> 

Hi, Arnd, Do you have any comments about this patch? Sorry I missed the
previous discussion about which should be used for this approach.

thanks.

