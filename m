Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeCXTWK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 15:22:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8826 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752633AbeCXTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 15:22:08 -0400
X-UUID: 5c244dfc38f4415cb38446a377a64888-20180325
Message-ID: <1521919318.31197.0.camel@mtkswgap22>
Subject: Re: [PATCH v1 06/16] rtc: mediatek: remove unnecessary parentheses
From: Sean Wang <sean.wang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <eddie.huang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Sun, 25 Mar 2018 03:21:58 +0800
In-Reply-To: <20180324185330.GO3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <92d07e90f43899981a82fbc684c3d15aaecaf591.1521794177.git.sean.wang@mediatek.com>
         <20180323102123.GG3417@piout.net> <1521875652.28226.29.camel@mtkswgap22>
         <20180324185330.GO3417@piout.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23738.005
X-TM-AS-Result: No-11.357200-8.000000-10
X-TMASE-MatchedRID: 5+1rHnqhWUQOwH4pD14DsPHkpkyUphL9+Vb3woyMZbs7Pn66tDbCt3nv
        qbLkjGO6xUlM+UQkYGPbCHv011Gy9ZCoy9iDotiwaK+MsTwM+1nyCFKQHr4iUuIpRqgiF5rtF5Z
        RTdcETVTi8zVgXoAltkWL4rBlm20vjaPj0W1qn0Q7AFczfjr/7GyqBU+Vk3ub0jzzTIGfdtjHw7
        WNDwaZGz9XeJrCCXjuVp1wMIOxYcw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.357200-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23738.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-24 at 19:53 +0100, Alexandre Belloni wrote:
> On 24/03/2018 at 15:14:12 +0800, Sean Wang wrote:
> > On Fri, 2018-03-23 at 11:21 +0100, Alexandre Belloni wrote:
> > > On 23/03/2018 at 17:15:03 +0800, sean.wang@mediatek.com wrote:
> > > > From: Sean Wang <sean.wang@mediatek.com>
> > > > 
> > > > Remove unnecessary parentheses due to explicit C operator precedence.
> > > > 
> > > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > > ---
> > > >  drivers/rtc/rtc-mt6397.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > > > index 0df7ccd..4411c08 100644
> > > > --- a/drivers/rtc/rtc-mt6397.c
> > > > +++ b/drivers/rtc/rtc-mt6397.c
> > > > @@ -106,7 +106,7 @@ static irqreturn_t mtk_rtc_irq_handler_thread(int irq, void *data)
> > > >  	int ret;
> > > >  
> > > >  	ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_IRQ_STA, &irqsta);
> > > > -	if ((ret >= 0) && (irqsta & RTC_IRQ_STA_AL)) {
> > > > +	if (ret >= 0 && irqsta & RTC_IRQ_STA_AL) {
> > > 
> > > I don't think this makes the code particularly clearer.
> > > 
> > 
> > But it is still a one of check items in checkpatch
> > 
> > CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'ret >= 0'
> > #126: FILE: drivers/rtc/rtc-xxx.c:109:
> > +       if ((ret >= 0) && (irqsta & RTC_IRQ_STA_AL)) {
> > 
> > 
> > or we still want to keep it in parentheses around here?
> > 
> 
> Yeah, this is a matter of taste, I would keep the parentheses.

okay, lets keep the parentheses

> 
> 
