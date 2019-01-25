Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40592C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1022B21855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfAYDsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:48:50 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33533 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726304AbfAYDsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:48:50 -0500
X-UUID: 2f451d7b0e6c428d82be0b570207cc9c-20190125
X-UUID: 2f451d7b0e6c428d82be0b570207cc9c-20190125
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 657249204; Fri, 25 Jan 2019 11:48:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 25 Jan 2019 11:48:35 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 25 Jan 2019 11:48:36 +0800
Message-ID: <1548388116.29237.15.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, John Crispin <blogic@openwrt.org>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao =?UTF-8?Q?=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?= 
        <Weijie.Gao@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 25 Jan 2019 11:48:36 +0800
In-Reply-To: <20190121084948.frpcgg6wkdjxkl7k@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
         <c007d399-af86-98d3-94f9-b9762efdc219@gmail.com>
         <1547866487.14213.10.camel@mtkswgap22>
         <20190121084948.frpcgg6wkdjxkl7k@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+John

HI John,

On Mon, 2019-01-21 at 16:49 +0800, Uwe Kleine-König wrote:
> On Sat, Jan 19, 2019 at 10:54:47AM +0800, Ryder Lee wrote:
> > On Fri, 2019-01-18 at 09:43 +0100, Matthias Brugger wrote:
> > >
> > > On 18/01/2019 04:24, Ryder Lee wrote:
> > > > This adds a property "mediatek,num-pwms" to avoid having an endless
> > > > list of compatibles with no differences for the same driver.
> > > >
> > > > Thus, the driver should have backwards compatibility to older DTs.
> > > >
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
> > > > - unsigned int num_pwms;
> > > > + unsigned int num_pwms;  /* it should not be used in the future SoCs */
> > > >   bool pwm45_fixup;
> > > >   bool has_clks;
> > > >  };
> > > > @@ -226,27 +226,36 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > > >
> > > >  static int mtk_pwm_probe(struct platform_device *pdev)
> > > >  {
> > > > - const struct mtk_pwm_platform_data *data;
> > > > + struct device_node *np = pdev->dev.of_node;
> > > >   struct mtk_pwm_chip *pc;
> > > >   struct resource *res;
> > > > - unsigned int i;
> > > > + unsigned int i, num_pwms;
> > > >   int ret;
> > > >
> > > >   pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> > > >   if (!pc)
> > > >           return -ENOMEM;
> > > >
> > > > - data = of_device_get_match_data(&pdev->dev);
> > > > - if (data == NULL)
> > > > -         return -EINVAL;
> > > > - pc->soc = data;
> > > > + pc->soc = of_device_get_match_data(&pdev->dev);
> > > >
> > > >   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >   pc->regs = devm_ioremap_resource(&pdev->dev, res);
> > > >   if (IS_ERR(pc->regs))
> > > >           return PTR_ERR(pc->regs);
> > > >
> > > > - for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> > > > + /* Check if we have set 'num-pwms' in DTs. */
> > > > + ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > > > + if (ret < 0) {
> > > > +         /* If no, fallback to use SoC data for backwards compatibility. */
> > > > +         if (pc->soc->num_pwms) {
> > > > +                 num_pwms = pc->soc->num_pwms;
> > >
> > > Maybe that's bike shedding, but I think it would be better to carve out the
> > > num_pwms from the mtk_pwm_platform_data and check against the compatible here.
> >
> > I'm not sure how to properly curve it out? I think we still need this
> > variable to save the specific value for some legacy SoCs (with older
> > DTs).
> 
> I guess he means  something like:
> 
>         if (is_compatible_to_variant_A(dev))
>                 num_pwms = 12;
>         else if (is_compatible_to_variant_B(dev))
>                 num_pwms = 2;
> 
> . In my eyes the bike shed should be light red and I prefer to collect
> the fallback num_pwms in the compatible_data as is to keep the code
> simpler. Maybe rename the member from num_pwms to fallback_num_pwms to
> make it more obvious that it doesn't represent the actually used value.
> 
> > > With a expressive comment it will help other driver developers to not start
> > > adding num_pwms in the platform data in their first attempt.
> >
> > Definitely.
> 
> My suggestion was to add a dev_warn, which IMHO is still better than a
> comment.
> 
> Best regards
> Uwe
> 

Unrelated to this patch: I'm ready to send v2 to allocate the clks array
dynamically, but I guess MT7628 couldn't work in original code.


In mtk_pwm_config():

	clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]; 
	....
	resolution = (u64)NSEC_PER_SEC * 1000;
	do_div(resolution, clk_get_rate(clk));
	....

I think clk should be NULL and resolution is always 0 here. 


Ryder

