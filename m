Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14684C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64A8217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfBZEBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:01:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53358 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbfBZEBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 23:01:00 -0500
X-UUID: 35409fa9809348ff965a6b8a54683ebe-20190226
X-UUID: 35409fa9809348ff965a6b8a54683ebe-20190226
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1235902666; Tue, 26 Feb 2019 12:00:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 12:00:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Feb 2019 12:00:50 +0800
Message-ID: <1551153650.1047.4.camel@mtksdaap41>
Subject: Re: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>
Date:   Tue, 26 Feb 2019 12:00:50 +0800
In-Reply-To: <155082168901.77512.12893153125579041936@swboyd.mtv.corp.google.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
         <20190201083016.25856-2-weiyi.lu@mediatek.com>
         <155069033021.77512.14493210110678229730@swboyd.mtv.corp.google.com>
         <b7abe484-71c1-5ec0-796c-544f1ac5d6f5@gmail.com>
         <155082168901.77512.12893153125579041936@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 2566077B6750DF2BE7912EE4D2CBC442DA67555DC3CF1235DF24BEF0A4BC65E02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 23:48 -0800, Stephen Boyd wrote:
> Quoting Matthias Brugger (2019-02-21 00:36:24)
> > 
> > 
> > On 20/02/2019 20:18, Stephen Boyd wrote:
> > > 
> > > What's the merge plan here? Do you want me to apply these patches to clk
> > > tree? Will someone be sending me a pull request for mediatek clk changes
> > > this cycle? It's getting pretty late for much of anything making this
> > > upcoming merge window.
> > > 
> > 
> > As far as I can see, the clock patches are independent, so I think it is OK to
> > take them. SCPSYS patches will go through my tree once they are in shape.
> 
> Ok great. When patches for clks are interspersed throughout the patch
> series it makes me think that something later in the series depends on
> something that isn't a clk patch so then I can't apply it.
> 

Hi Stephen,

Sorry for making such complex dependencies between the clk patches and
others in this series. And just like Matthias mentioned, the clock
patches are independent from others. I could resend a clock-only series
right away if each clock patch in v4 is qualified to merge into
clk-next.
If there still some provide need to be fixed, please let me know. I'll
fix them and send v5 only for clock.

> > 
> > Do you prefer to get pull requests for clock patches? I wasn't aware of that.
> > But if you prefer that, we can find someone who prepares every merge window a
> > pull request.
> > 
> 
> I don't really care one way or the other about pull requests vs.
> manually applying patches. It helps if someone wants to pick the patches
> up and send them along when there are complex dependencies between the
> clk patches and dts bits or something like that. It also helps if
> there's someone else with knowledge of the particular SoC saying "these
> are good, please pull these patches". Subsystem maintainers obviously
> aren't experts in all SoCs and their various quirks, plus datasheets
> aren't always so widely available, so sharing the load with SoC
> maintainers who are familiar with the hardware usually makes a lot of
> sense.
> 
> Otherwise, if you just want to put your "Reviewed-by" tag on any patches
> that look good and are sane then I'll quickly understand that these
> patches are good and that I should pick them up into the clk tree from
> the list. Just please communicate one way or the other about patches
> that you care about because it helps to know if they've gotten attention
> or not.
> 


