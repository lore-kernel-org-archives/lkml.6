Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04D6218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAVJiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:38:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53110 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726872AbfAVJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:38:02 -0500
X-UUID: 8217302001924eed8072d121d076e89b-20190122
X-UUID: 8217302001924eed8072d121d076e89b-20190122
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 854190347; Tue, 22 Jan 2019 17:37:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 17:37:56 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 17:37:54 +0800
Message-ID: <1548149874.27796.3.camel@mszsdaap41>
Subject: Re: [PATCH V2] pwm: Add MediaTek MT8183 display PWM driver support
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Matthias Brugger" <matthias.bgg@gmail.com>, <stonea168@163.com>,
        <dri-devel@lists.freedesktop.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        "Ajay Kumar" <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        <linux-mediatek@lists.infradead.org>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        "Rahul Sharma" <rahul.sharma@samsung.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Sean Paul" <seanpaul@chromium.org>
Date:   Tue, 22 Jan 2019 17:37:54 +0800
In-Reply-To: <20190122091603.ic46eyf47lu5f6pi@pengutronix.de>
References: <20190122090243.27304-1-jitao.shi@mediatek.com>
         <20190122091603.ic46eyf47lu5f6pi@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 10:16 +0100, Uwe Kleine-König wrote:
> On Tue, Jan 22, 2019 at 05:02:43PM +0800, Jitao Shi wrote:
> > Use the mtk_pwm_data struction to define different registers
> > and add MT8183 specific register operations, such as MT8183
> > doesn't have commit register, needs to disable double buffer
> > before writing register, and needs to select commit mode
> > and use PWM_PERIOD/PWM_HIGH_WIDTH.
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> 
> There is no difference compared to (implicit) v1 sent a few minutes
> earlier, right? There was another patch sent with the same Subject last
> week, so I assume the mail from today without "v2" in the Subject was a
> mistake?
> 
> > ---
> Adding a paragraph below the tripple dash that points out what was
> changed compared to the previous submission is a good idea to help
> reviewers to more easily see what was changed. I guess you only adapted
> the commit log as a reaction to Matthias Burgger's review?
> 
> Best regards
> Uwe
> 

Yes, I miss the "V2" and fine tune the commit message.

Best Regards
Jitao

