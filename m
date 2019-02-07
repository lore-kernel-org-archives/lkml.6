Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFAB2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfBGPgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:36:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38930 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:36:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id m11so197583lfc.6;
        Thu, 07 Feb 2019 07:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLlD7UXqXViY2v937QoneKMBrXgwy88me6VdYY9HaoA=;
        b=JWIIjtdme7EhyToI2NqdQ3c97zd0cYzmr8mu9YIIJPisp7d/E2kUcrWpVlYN94ctsV
         fkHt/nwYbihWlsl2dflCwaMYVrEDF58lRcvFrRAzsf5TD6khHPZ8VoqDG5C7fj+DNOcr
         Uh1rofuZYOpneOcd7AMALYRLXWv02MaVBPWPJkitpnSzAoYMCXetaemHKIQvQUNq+7hl
         yzwN3/REjEy1IFwoQt1Kdxk5RcjKvlnUDJ1CLJM90+5OJ188KnpwxglI9QoRg4Xh0bC1
         3v2nsWcUuvB8aTbllvInVo/EwhGiV+UHo5cjskds1xq4gHXQE3FQWkkpzRqXtBuMnhLC
         WkIA==
X-Gm-Message-State: AHQUAuYxKcfBBzHzOI4eRTzeqXXOaW07kQdpvc+D1yVRKjZOBjKSdf4f
        6v6PmD2KjupB5aKG1B286hY=
X-Google-Smtp-Source: AHgI3Ia6uKspEN1wqttsdp1k99z/uqow9AQWKl9nhS0wmwqnWzzgEIuDGt73x5EaF3gXYUBhCFSifQ==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr9478150lfl.129.1549553800017;
        Thu, 07 Feb 2019 07:36:40 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id b25-v6sm4354616lji.94.2019.02.07.07.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 07:36:39 -0800 (PST)
Date:   Thu, 7 Feb 2019 17:36:00 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v8 4/8] devicetree: bindings: Document first ROHM BD70528
 bindings
Message-ID: <20190207153600.GA1920@localhost.localdomain>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <52b17ed2599b21f4b93665ac689113ce3f8816b7.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140418.GH20638@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207140418.GH20638@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

Thanks for the reviews!

On Thu, Feb 07, 2019 at 02:04:18PM +0000, Lee Jones wrote:
> On Thu, 07 Feb 2019, Matti Vaittinen wrote:
> 
> > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > drivers) and 4 GPIO pins which can be configured for I/O or
> > as interrupt sources withe configurable trigger levels.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > new file mode 100644
> > index 000000000000..f80be7e40184
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > @@ -0,0 +1,102 @@
> > +* ROHM BD70528 Power Management Integrated Circuit bindings
> > +
> > +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC
> 
> What's an Iq?

http://www.ti.com/lit/an/slyt412/slyt412.pdf
Iq is an abbreviation of quiescet current. Do you think it's worth
writing the whole words instead of an abbreviation?

Thanks for the rest of the corrections, I'll fix them in next version.

Br,
	Matti Vaittinen
