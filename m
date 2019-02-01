Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A788C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F6F20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfBAIWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:22:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1726 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726665AbfBAIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:22:12 -0500
X-UUID: 6772f3232cb74dc68f40cde2641e240d-20190201
X-UUID: 6772f3232cb74dc68f40cde2641e240d-20190201
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 31460023; Fri, 01 Feb 2019 16:22:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:21:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:21:59 +0800
Message-ID: <1549009319.22634.0.camel@mtksdaap41>
Subject: Re: [PATCH v3 01/12] clk: mediatek: fixup: Disable tuner_en before
 change PLL rate
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Fan Chen <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Owen Chen <owen.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 1 Feb 2019 16:21:59 +0800
In-Reply-To: <154482465853.19322.3763394015657394960@swboyd.mtv.corp.google.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
         <20181210073240.32278-3-weiyi.lu@mediatek.com>
         <154482465853.19322.3763394015657394960@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 1C943B2EDB332A25667006B6380681675011916E18904E5C47EB34786F5F0E832000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2018-12-14 at 13:57 -0800, Stephen Boyd wrote:
> Why is "fixup" in the subject of this patch?
> 

I'll fix in next version.

> Quoting Weiyi Lu (2018-12-09 23:32:29)
> > From: Owen Chen <owen.chen@mediatek.com>
> > 
> > PLLs with tuner_en bit, such as APLL1, need to disable
> > tuner_en before apply new frequency settings, or the new frequency
> > settings (pcw) will not be applied.
> > The tuner_en bit will be disabled during changing PLL rate
> > and be restored after new settings applied.
> > Another minor change is to correct the macro name of pcw change bit
> > to CON1_PCW_CHG because PCW_CHG(BIT31) is on CON1.
> > 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> 
> So there should be some Fixes: tag here too so we know what commit is
> being fixed?
> 

I'll add in next version.

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



