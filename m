Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8210C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0E724731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMgAyrpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0E724731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbeFVS3L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:29:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38949 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933969AbeFVS3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:29:08 -0400
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so3589996pfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T94SLZ+3P0JUahJzZMZk3akkR5GB0Wxp1oE4OhF/AbE=;
        b=eMgAyrppPwr9kogqXs772KSO6bn2QO9DTf6RkvDvprGCe9VxkCFA0ZHK3KQdpKfnYj
         XWMpJgC8sfl3zrmbWv2dasVFrtywOPKlQJr9P99hGjaN6mOFZXKhL+nwf+Le5TDn+z94
         0wEsX9+VvtRJZ2HaqmfcRckazo3COcyMRI7QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T94SLZ+3P0JUahJzZMZk3akkR5GB0Wxp1oE4OhF/AbE=;
        b=Tf2XOGu8t6Dh8Rljmek2Qlm4uCYawxwbnsnHIFDFsPvXQL2MOJ1QrzRNjXxvLpKn8V
         JJhmvwJdyBfWP13f0BfgOS3DxzlsHJflk1pJRH3UJynNXUHN+ckNr4J/10PNcnE0/BVU
         v1mtvvZJ2NsOLRjgNBAT78LK1AW22MaaQ6CG9YYanLaBNYrn7lWka6XGqmHnR7snWNuL
         eP3b5GIG7LcstI82/UoS6tzp9Iqi/FK96QP5VTzle3isAL5vagyej+0a9oG8f16CK63N
         sKtPph0SQjBikw3T8FDKts7c1zhqskXQeSuKP21Ik9p70+XEW0Cvte0Z13SyfeqBnCGF
         4euA==
X-Gm-Message-State: APt69E2Q4K6QALNPrX27UbusBUX8Y4nT/tuXk55Vf0Kz+3ZEAZL2rTY+
        oePP1QqdyS+3sjOMgzgQchWXXw==
X-Google-Smtp-Source: ADUXVKLtD+/HAcO1XOB1jZYjat+DT9JRNCMZITNlrQ006KP4hJwwWToI5wo1JUQMoysKpdDixxC3qw==
X-Received: by 2002:a62:4282:: with SMTP id h2-v6mr2903996pfd.242.1529692148313;
        Fri, 22 Jun 2018 11:29:08 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u84-v6sm15534380pfg.156.2018.06.22.11.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:29:07 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:31:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with
 gpio_request()
Message-ID: <20180622183129.GD3402@tuxbook-pro>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622175836.GC3402@tuxbook-pro>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Jun 10:58 PDT 2018, Bjorn Andersson wrote:

> On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
> 
> > We rely on devices to use pinmuxing configurations in DT to select the
> > GPIO function (function 0) if they're going to use the gpio in GPIO
> > mode. Let's simplify things for driver authors by implementing
> > gpio_request_enable() for this pinctrl driver to mux out the GPIO
> > function when the gpio is use from gpiolib.
> > 
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 

On second thought, while reading patch 3, when would this be used?

While both patch 2 and 3 are convenient ways to get around the annoyance
of having to specify a pinmux state both patches then ends up relying on
some default pinconf state; which I think is bad.


Further more in situations like i2c-qup (downstream), where the pins are
requested as gpios in order to "bitbang" a reset this would mean that
the driver has to counter the convenience; by either switching in the
default pinmux at the end of probe or postponing the gpio_request() to
the invocation of reset and then, after issuing the gpio_release,
switching in the default pinmux explicitly again.


So I'm not sure we want this.

Regards,
Bjorn

> Regards,
> Bjorn
> 
> > Cc: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index 3563c4394837..eacfc5b85f7f 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -176,11 +176,27 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
> >  	return 0;
> >  }
> >  
> > +static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
> > +				   struct pinctrl_gpio_range *range,
> > +				   unsigned offset)
> > +{
> > +	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> > +	const struct msm_pingroup *g = &pctrl->soc->groups[offset];
> > +
> > +	/* No funcs? Probably ACPI so can't do anything here */
> > +	if (!g->nfuncs)
> > +		return 0;
> > +
> > +	/* For now assume function 0 is GPIO because it always is */
> > +	return msm_pinmux_set_mux(pctldev, 0, offset);
> > +}
> > +
> >  static const struct pinmux_ops msm_pinmux_ops = {
> >  	.request		= msm_pinmux_request,
> >  	.get_functions_count	= msm_get_functions_count,
> >  	.get_function_name	= msm_get_function_name,
> >  	.get_function_groups	= msm_get_function_groups,
> > +	.gpio_request_enable	= msm_pinmux_request_gpio,
> >  	.set_mux		= msm_pinmux_set_mux,
> >  };
> >  
> > -- 
> > Sent by a computer through tubes
> > 
