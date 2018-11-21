Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB3AC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF322145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF322145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeKUTy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:54:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:63206 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726665AbeKUTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:54:59 -0500
X-UUID: 9a5647383f5e4047b85d4ba513ba9ead-20181121
X-UUID: 9a5647383f5e4047b85d4ba513ba9ead-20181121
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1117219631; Wed, 21 Nov 2018 17:21:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Nov 2018 17:21:04 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Nov 2018 17:21:04 +0800
Message-ID: <1542792064.20593.2.camel@mtksdaap41>
Subject: Re: [PATCH v1 04/11] soc: mediatek: add new flow for mtcmos power.
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>,
        <jamesjj.liao@mediatek.com>, <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <owen.chen@mediatek.com>,
        <mars.cheng@mediatek.com>
Date:   Wed, 21 Nov 2018 17:21:04 +0800
In-Reply-To: <154278766192.88331.16232130563413450456@swboyd.mtv.corp.google.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
         <20181106064206.17535-6-weiyi.lu@mediatek.com>
         <CANMq1KDbauouMDvsZS3KsNJrNs1gGg7mDjsKRw=zTcuQXSTa0Q@mail.gmail.com>
         <1542681454.5132.9.camel@mtksdaap41>
         <154278766192.88331.16232130563413450456@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 8C68A4B578B6415AF37CD1230BEF4E76EDA0F59254B6F4314F58C520F9EDEEAB2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 00:07 -0800, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-11-19 18:37:34)
> > On Tue, 2018-11-13 at 11:31 -0800, Nicolas Boichat wrote:
> > > On Mon, Nov 5, 2018 at 10:42 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> 
> > > > @@ -226,6 +397,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> > > >         if (ret < 0)
> > > >                 goto err_pwr_ack;
> > > >
> > > > +
> > > 
> > > Drop this.
> > Why do we try to drop this? Once the power-on step fail, the following
> > steps should not be permitted.
> 
> I just see a whitespace addition that doesn't do anything. I suspect
> it's a style nitpick and common practice to not include spurious diffs
> in the patch. So remove this hunk?
> 
Oops! I missed the extra whitespace. I will remove it. Many thanks.



