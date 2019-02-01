Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F464C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE77F20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfBACNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:13:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60926 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbfBACNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 21:13:47 -0500
X-UUID: 3aaff567ac3a462fb6265feb0a3146f6-20190201
X-UUID: 3aaff567ac3a462fb6265feb0a3146f6-20190201
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1495882304; Fri, 01 Feb 2019 10:13:38 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 10:13:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 10:13:37 +0800
Message-ID: <1548987217.28835.2.camel@mtksdaap41>
Subject: Re: [PATCH 5/6] regulator: mt6358: Add support for MT6358 regulator
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 1 Feb 2019 10:13:37 +0800
In-Reply-To: <20190130151825.GA10665@sirena.org.uk>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1548839891-20932-6-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20190130151825.GA10665@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, 2019-01-30 at 15:18 +0000, Mark Brown wrote:
> On Wed, Jan 30, 2019 at 05:18:10PM +0800, Hsin-Hsiung Wang wrote:
> 
> > +static const struct of_device_id mt6358_of_match[] = {
> > +	{ .compatible = "mediatek,mt6358-regulator", },
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, mt6358_of_match);
> 
> There should be no need for a separate compatbile string here - we
> aren't describing the hardware any more than we already did with the
> parent node for the MFD, we're describing how Linux currently splits the
> software that controls the hardware up.  Just have the MFD instantiate
> the regulator driver when it probes.
> 
> Otherwise this driver looks very good and clean.

Thanks for your suggestion.
It sounds pretty good and I will modify it in next patch series.

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


