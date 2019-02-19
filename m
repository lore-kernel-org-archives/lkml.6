Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0304C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA7D2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfBSNNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:13:54 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:60521 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726221AbfBSNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:13:53 -0500
X-UUID: 755e4a9f7427416d9b2fc5338af9ab15-20190219
X-UUID: 755e4a9f7427416d9b2fc5338af9ab15-20190219
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 14881334; Tue, 19 Feb 2019 21:13:45 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 21:13:43 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 21:13:43 +0800
Message-ID: <1550582023.30065.52.camel@mhfsdcap03>
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
Date:   Tue, 19 Feb 2019 21:13:43 +0800
In-Reply-To: <20190216122915.hchghozcn7ntdkbm@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
         <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
         <20190205131641.GF12401@kunai> <1550109268.30065.13.camel@mhfsdcap03>
         <20190215090257.geumssb2cucs7rzt@ninjato>
         <1550316723.30065.44.camel@mhfsdcap03>
         <20190216122915.hchghozcn7ntdkbm@ninjato>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-02-16 at 13:29 +0100, Wolfram Sang wrote:
> > Maybe you think that MT8183 SoC only has the I3C controllers. Actually,
> > there are I2C and I3C controllers on MT8183 SoC. We will remove
> > "mediatek,share-i3c" for I2C controller driver, so these patches are
> > just to support the I2C controllers on MT8183 SoC. For the I3C
> > controller we will send some new patches which are based on i3c
> > framework directories(kernel/drivers/i3c), not based on
> > i2c-mt65xx.c.
> 
> Sounds perfect to me. If it turns out that the I3C driver can share
> things with the I2C driver, we can discuss it then. But unless we have
> an I3C driver and know for sure, the above strategy seems good to me.
> 

Can I push the V4 patches of I2C controller driver now? or you just want
an I3C driver that is compatible with the I2C controller?

According to our plan, I2C controller will use
i2c-mt65xx.c(kernel/drivers/i2c/busses/)and I3C controller will use
i3c-xxx.c(kernel/drivers/i3c/master/)

