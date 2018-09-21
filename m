Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBFDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6A221522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6A221522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbeIUKJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:09:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3755 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725898AbeIUKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:09:49 -0400
X-UUID: 4320813f10de40d387ccdc2a384bcea1-20180921
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 889984817; Fri, 21 Sep 2018 12:22:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 12:22:41 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 12:22:41 +0800
Message-ID: <1537503761.9654.17.camel@mtkswgap22>
Subject: Re: [PATCH v2 00/22] Unify MediaTek pinctrl in preparation for
 MT8183 and MT6765
From:   Sean Wang <sean.wang@mediatek.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Sep 2018 12:22:41 +0800
In-Reply-To: <20180919043722.GA14181@Mani-XPS-13-9360>
References: <cover.1536404280.git.sean.wang@mediatek.com>
         <CACRpkdZtVBjYGs5C7-HWEyX7f7pnCqvnRYBH=fFmLKhN4FGymA@mail.gmail.com>
         <1537325650.572.9.camel@mtkswgap22>
         <20180919043722.GA14181@Mani-XPS-13-9360>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2233477D5B90D583037ADDB6734464641C4088D7182CD258BDE426DE9AF2344A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 21:37 -0700, Manivannan Sadhasivam wrote:
> On Wed, Sep 19, 2018 at 10:54:10AM +0800, Sean Wang wrote:
> > On Tue, 2018-09-18 at 15:07 -0700, Linus Walleij wrote:
> > > On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:
> > > 
> > > > v2 and changes since v1:
> > > 
> > > I had trouble applying the last patches in the series so I applied
> > > all on an immutable branch (ib-mtk) then merged that into devel
> > > and added a patch on top to fix up some GPIO includes (just sent).
> > > 
> > > Please check the result!
> > > 
> > 
> > Sure, I'll take a look and and test on the devel branch.
> > 
> > On the top, I'll add a fix for the issue recently reported by kbuild
> > test robot about implicit declaration and a new MT6765 driver based
> > on the series.
> >
> 
> Hi Sean,
> 
> Do you have any plans to add support for MT6797?
> 

I personally have no the plan to add support to MT6797 because I have no
the device, but as I knew some of people in mediatek have interest to
add them by volunteers and thus there is no clear schedule. Eventually,
if they're really done, they would be still based on vendor binding not
by generic binding.

> Thanks,
> Mani
> 
> > > Yours,
> > > Linus Walleij
> > 
> > 


