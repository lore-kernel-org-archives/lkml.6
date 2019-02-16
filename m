Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7140DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45130222E3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfBPLcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 06:32:19 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27245 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfBPLcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 06:32:19 -0500
X-UUID: 28b42441216a494489c2a4836339c4e9-20190216
X-UUID: 28b42441216a494489c2a4836339c4e9-20190216
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1313132266; Sat, 16 Feb 2019 19:32:05 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 16 Feb
 2019 19:32:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 16 Feb 2019 19:32:03 +0800
Message-ID: <1550316723.30065.44.camel@mhfsdcap03>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From:   Qii Wang <qii.wang@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <ryder.lee@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, Rob Herring <robh@kernel.org>
Date:   Sat, 16 Feb 2019 19:32:03 +0800
In-Reply-To: <20190215090257.geumssb2cucs7rzt@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
         <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
         <20190205131641.GF12401@kunai> <1550109268.30065.13.camel@mhfsdcap03>
         <20190215090257.geumssb2cucs7rzt@ninjato>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-15 at 10:02 +0100, Wolfram Sang wrote:
> On Thu, Feb 14, 2019 at 09:54:28AM +0800, Qii Wang wrote:
> > On Tue, 2019-02-05 at 14:16 +0100, Wolfram Sang wrote:
> > > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> > > 
> > > I am not happy with this binding. There must be a better way of using
> > > the I3C controller in I2C mode. I think it would be easier to tell if we
> > > had an I3C driver to see how it implements I2C fallback there. Is the
> > > I3C driver on the way?
> > > 
> > 
> > I am very sorry for the late reply due to the Chinese New Year holiday.
> 
> No worries. I hope you enjoyed the holidays!
> 
> > After confirmation, for I2C mode in I3C controller, we will push an I3C
> > driver to implement I2C fallback there later, and we will remove
> > "mediatek,share-i3c" for i2c controller driver in the next patch.
> 
> The problem with DT bindings is that you need to support them forever
> once you introduced them. Because there might be old device trees on
> boards out there which need the property. So, I don't like the idea of
> having a temporary binding which is meant to be removed anyway. My take
> is that you should just send out the I3C driver which will handle the
> I2C support then.
> 
> Adding Rob to CC in case he has a different opinion.
> 

Maybe you think that MT8183 SoC only has the I3C controllers. Actually,
there are I2C and I3C controllers on MT8183 SoC. We will remove
"mediatek,share-i3c" for I2C controller driver, so these patches are
just to support the I2C controllers on MT8183 SoC. For the I3C
controller we will send some new patches which are based on i3c
framework directories(kernel/drivers/i3c), not based on
i2c-mt65xx.c.


