Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31777C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0623820855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfARKBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:01:19 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:29815 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726062AbfARKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:01:19 -0500
X-UUID: 985531b764df4676b7349a91f8c3c67d-20190118
X-UUID: 985531b764df4676b7349a91f8c3c67d-20190118
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2140491853; Fri, 18 Jan 2019 18:01:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 18:01:09 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 18:01:09 +0800
Message-ID: <1547805669.8969.4.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 18 Jan 2019 18:01:09 +0800
In-Reply-To: <20190118095313.pbpdn43hd76khg2x@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
         <20190118075925.noilab6glzm3cig6@pengutronix.de>
         <1547804574.8124.6.camel@mtkswgap22>
         <20190118095313.pbpdn43hd76khg2x@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 10:53 +0100, Uwe Kleine-König wrote:
> Hello Ryder,
> 
> On Fri, Jan 18, 2019 at 05:42:54PM +0800, Ryder Lee wrote:
> > On Fri, 2019-01-18 at 08:59 +0100, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > On Fri, Jan 18, 2019 at 11:24:41AM +0800, Ryder Lee wrote:
> > > > This adds a property "mediatek,num-pwms" to avoid having an endless
> > > > list of compatibles with no differences for the same driver.
> > > > 
> > > > Thus, the driver should have backwards compatibility to older DTs.
> > > 
> > > I still think Thierry should bless "num-pwms" without vendor prefix.
> > 
> > Okay.
> > 
> > > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > > ---
> > > > Changes since v1: add some checks for backwards compatibility.
> > > > ---
> > > >  drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++++++---------
> > > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > > > index eb6674c..81b7e5e 100644
> > > > --- a/drivers/pwm/pwm-mediatek.c
> > > > +++ b/drivers/pwm/pwm-mediatek.c
> > > > @@ -55,7 +55,7 @@ enum {
> > > >  };
> > > >  
> > > >  struct mtk_pwm_platform_data {
> > > 
> > > Unrelated to this patch: This name is bad. This struct is not used as
> > > platform_data and so should better be named mtk_pwm_of_data. While at
> > > criticizing existing stuff: I'd prefer pwm_mediatek as common prefix to
> > > match the filename.
> > 
> > I think we can take care about that in another patch.
> 
> That's what I wanted to say, right. Do you follow up?

Yes, I will do that.

> > > > -	unsigned int num_pwms;
> > > > +	unsigned int num_pwms;	/* it should not be used in the future SoCs */
> > > 
> > > I'd drop this comment in favour of a runtime warning.
> > 
> > Sorry, I can't get you here.
> 
> I'd do a
> 
> 	dev_warn(dev, "dt didn't specify number of PWMs, falling back to %d\n", pc->soc->num_pwms);
> 
> to make people aware that updating the dt would be nice.

Okay!

Thanks
Ryder


