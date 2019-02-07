Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5ABC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07502175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfBGQeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:34:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34085 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:34:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so378315lfc.1;
        Thu, 07 Feb 2019 08:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhw+EJtPyFh0Bm+C9xNNPBirtOcjmn2ydehujSyIxQY=;
        b=MBtv/MYd3eqLiGKvaweft1CTP1nWd1iZIiddqQ4wJpX14a3ewb706k82WkXdPZx+vc
         zKNmdIzOxDsQNux6cIXVeTus6We8EtzvgkLmIiUtS27l6w++RAo7trLKhzdmTW9I+X0c
         +YTa6jiJzsBDpgZvZ4ABrKnSI8t/Z7Ghzr+7C8/8oEB5yt+oCEBh8zC54HIuUVMOjGUJ
         GdmxnSCHh2mMOsmAPm2V7sNiUEzfQn+52VrDJmWZziehmMdS4bt+qxiBjKn/H38AYcN8
         L4u9t1I8Dszfa1EO20IQ1rTfvhuPXurN6eFcpFQXDnUKtg6Typ63Ke54Wh41Rn7YMzSl
         RxeA==
X-Gm-Message-State: AHQUAuam8H3/9i0N/868e2OloogByOxe5HsA8impvH4IEhFy4YxXouX2
        x5pSI4E6LunWxaUc14BJC2Y=
X-Google-Smtp-Source: AHgI3IakxAEtEonwcB5IOpSpbFYIyv2i+u97ueRzcavsM07SFWpRNWLP3RJxIWf3QZi6a6iavCF8Pg==
X-Received: by 2002:a19:9508:: with SMTP id x8mr10477645lfd.112.1549557257462;
        Thu, 07 Feb 2019 08:34:17 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id s3-v6sm4408714lje.73.2019.02.07.08.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 08:34:16 -0800 (PST)
Date:   Thu, 7 Feb 2019 18:33:42 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
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
Message-ID: <20190207163342.GC1920@localhost.localdomain>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <52b17ed2599b21f4b93665ac689113ce3f8816b7.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140418.GH20638@dell>
 <20190207153600.GA1920@localhost.localdomain>
 <20190207154229.GA19277@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207154229.GA19277@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 07:42:29AM -0800, Guenter Roeck wrote:
> On Thu, Feb 07, 2019 at 05:36:00PM +0200, Matti Vaittinen wrote:
> > Hello Lee,
> > 
> > Thanks for the reviews!
> > 
> > On Thu, Feb 07, 2019 at 02:04:18PM +0000, Lee Jones wrote:
> > > On Thu, 07 Feb 2019, Matti Vaittinen wrote:
> > > 
> > > > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > > > drivers) and 4 GPIO pins which can be configured for I/O or
> > > > as interrupt sources withe configurable trigger levels.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > ---
> > > >  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
> > > >  1 file changed, 102 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > > new file mode 100644
> > > > index 000000000000..f80be7e40184
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > > @@ -0,0 +1,102 @@
> > > > +* ROHM BD70528 Power Management Integrated Circuit bindings
> > > > +
> > > > +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC
> > > 
> > > What's an Iq?
> > 
> > http://www.ti.com/lit/an/slyt412/slyt412.pdf
> > Iq is an abbreviation of quiescet current. Do you think it's worth
> > writing the whole words instead of an abbreviation?
> > 
> https://acronyms.thefreedictionary.com/IQ lists 23 definitions.
> This one is not listed. Yes, I think it would be beneficial to use
> the whole word.

Allright. I'll change that too =)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
