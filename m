Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44546C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122A22081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122A22081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeKBULh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:11:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40051 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeKBULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:11:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id n3-v6so1039074lfe.7;
        Fri, 02 Nov 2018 04:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJLBWPTobejOHjhshGYxLBc/kfbkjwTRvM5ai8I8Bw0=;
        b=n3vHO9KXoqSoo8xSv14zyN9BkoFwwpO8aZIKRsf9EkugHASeYfM5nlTICBglSjJMWO
         pJUQDOnYzqOdSs2n2bHFL+tSiNL2wYfAjYOBzd5REmvTr1KHI0xAUFdtHoa4caj8jRSI
         hKUKlkGRXTFXK7cIgfPXQVkrBXa86QghNXFYOYHk51YNea4Q5ex6DixRnEgbCFGwYOEQ
         tV0S0MX5oDWzSL0Tua6gbbIN70N77y/1nvMki9VeYh1U1K+W29Gkch/qE6hXMdIGzlwx
         N76pkF1ow63ySupoBLZ/EjaDYVX1DCEUI6w8tx6fx0JzAdYNvK8Tug5AnrTSNwOhhDFT
         aX+g==
X-Gm-Message-State: AGRZ1gJXvlUvR2sLqIjeTKX1bsK/rN3b+h1G4W5HhOC/0uFYEiobbJFM
        EFTbvBno4AzJVwJqWYrfybw=
X-Google-Smtp-Source: AJdET5e35/vKv7iA3Xh9gFr8i8h2SbcXQIHhDKKLWUasPAu8tofQ+Tnr5qS+7G3vwILJclyQrH0z4Q==
X-Received: by 2002:a19:2106:: with SMTP id h6mr6505915lfh.29.1541156688851;
        Fri, 02 Nov 2018 04:04:48 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v19-v6sm5283112lji.10.2018.11.02.04.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 04:04:48 -0700 (PDT)
Date:   Fri, 2 Nov 2018 13:04:45 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     corbet@lwn.net, mturquette@baylibre.com, sboyd@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, kgene@kernel.org,
        s.nawrocki@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>,
        andrew.smirnov@gmail.com, sre@kernel.org, linux@roeck-us.net,
        robh@kernel.org, sjhuang@iluvatar.ai, Akshu.Agrawal@amd.com,
        rafael.j.wysocki@intel.com, djkurtz@chromium.org,
        mazziesaccount@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] clk: clk-max77686: Clean clkdev lookup leak and
 use devm
Message-ID: <20181102110445.GC29664@localhost.localdomain>
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
 <83e985f2f60a68f89fac777aa29c55b1edb8769f.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
 <CAJKOXPd=E+S3j3XnpCVRs3JdStY2z+pHe0bh_HNzQTmJW_dH=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPd=E+S3j3XnpCVRs3JdStY2z+pHe0bh_HNzQTmJW_dH=Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking the time and reviewing this!

On Fri, Nov 02, 2018 at 09:15:17AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 1 Nov 2018 at 08:19, Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> >
> > clk-max77686 never clean clkdev lookup at remove. This can cause
> > oops if clk-max77686 is removed and inserted again. Fix leak by
> > using new devm clkdev lookup registration. Simplify also error
> > path by using new devm_of_clk_add_parent_hw_provider.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/clk/clk-max77686.c | 25 ++++---------------------
> >  1 file changed, 4 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> > index 02551fe4b87c..b1920c1d9b76 100644
> > --- a/drivers/clk/clk-max77686.c
> > +++ b/drivers/clk/clk-max77686.c
> > @@ -235,7 +235,7 @@ static int max77686_clk_probe(struct platform_device *pdev)
> >                         return ret;
> >                 }
> >
> > -               ret = clk_hw_register_clkdev(&max_clk_data->hw,
> > +               ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
> >                                              max_clk_data->clk_idata.name, NULL);
> 
> You need to re-align the next line.

I'll change this to
		ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
						  max_clk_data->clk_idata.name,
						  NULL);
> >                 if (ret < 0) {
> >                         dev_err(dev, "Failed to clkdev register: %d\n", ret);
> > @@ -244,8 +244,8 @@ static int max77686_clk_probe(struct platform_device *pdev)
> >         }
> >
> >         if (parent->of_node) {
> > -               ret = of_clk_add_hw_provider(parent->of_node, of_clk_max77686_get,
> > -                                            drv_data);
> > +               ret = devm_of_clk_add_parent_hw_provider(dev,
> > +                                               of_clk_max77686_get, drv_data);
> 
> The same, please.

I will change this to 
		ret = devm_of_clk_add_parent_hw_provider(dev,
							 of_clk_max77686_get,
							 drv_data);
> 
> Rest looks good, so with these changes:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
