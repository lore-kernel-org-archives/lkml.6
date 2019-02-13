Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031B8C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0177222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbfBMIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:33:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35425 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389660AbfBMIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:33:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id v7so1131830lfd.2;
        Wed, 13 Feb 2019 00:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7xCLK1ihUYI0iGbd9cf+kebEPgIOMYD+iYb0Qebmy0=;
        b=s6Mi1MVTSNnU+FzhugaddsM13omH5XIdZVW/WR1cEw+Lxcndxs5wU8Q8WX7EFoPFjB
         /VGLLGEkBiSIIb3l/XB9X+b08JxUz3p3V3OrVC0ntmNcTStrjWWA/8wRgB0C9FVFXXUN
         5FSulJWka8X+SwwdiXRaNCV+Ns67nIRrczFpU9z2g3GuyMPRMtzUNNWCP/xS1CLihXPm
         a8rQbSJsgVi7+kSJUapdoet2lY66uOtH9gs1WdvUqKx+MSkpeDX+Ey0jcupYOHJJeZZr
         /NL0CsXULfIVJIhr66U8NzrDn/NGOnio24uWmllNGiXQNBqMA+NtLkIlShtBMdXTfa38
         VBGw==
X-Gm-Message-State: AHQUAua0p7xg6MDOpHmAIlBVGizL49QwK2bIbmzwJA45MAqRT1r2kqwB
        dkudTuZaSxvKBEXcSvKZnrU=
X-Google-Smtp-Source: AHgI3IYF1kB7gi7nnhXEkvVF1V/8Q5YKouBTAJ2RVqYo0cUBUkuJCMALLe35eaIAmydXb6fnnYs/rw==
X-Received: by 2002:ac2:5489:: with SMTP id t9mr4926848lfk.49.1550046826372;
        Wed, 13 Feb 2019 00:33:46 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p15sm2178875lfc.88.2019.02.13.00.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 00:33:45 -0800 (PST)
Date:   Wed, 13 Feb 2019 10:33:43 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: [RFC PATCH v1 3/3] regulator: bd718x7: Support SNVS low power
 state
Message-ID: <20190213083343.GC12247@localhost.localdomain>
References: <cover.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
 <06c2f2f730b07caeb1f2fb86be60c02b21d7bea9.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
 <20190212160831.GF20635@sirena.org.uk>
 <20190213073827.GB12247@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213073827.GB12247@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello peeps,

And my apologies! I was in a hurry yesterday. I had to pick up kid kid
from kindegarden and I wanted to send the RFC before that - bad mistake.
Should've learnd by now.

Today I decided to continue work and use combination of
regulator-always-on and regulator-boot-on instead of
rohm,regulator-crucial-for-boot. I was ashtonished by the fact that I
didn't find my latest work from my git. After a while I found unsaved
buffer from another editor instance with changes concerning handling of
"rohm,regulator-crucial-for-boot"...

On Wed, Feb 13, 2019 at 09:38:27AM +0200, Matti Vaittinen wrote:
> Hello Mark,
> 
> On Tue, Feb 12, 2019 at 04:08:31PM +0000, Mark Brown wrote:
> 
> So with current driver design, even if constrains prevented the
> regulator core from touching the regulators, the driver still changes
> the control to SW. So we need to parse some attribute in the BD718x7
> driver side. Besides, I did not spot a 'do not touch me' property from
> the bindings :)

So no wonder it was not clear that the core constrains were not enough.
Previous patch did not contain the part of change that skipped turning
the regulator control to SW if regulator was marked crucial.

> But after writing all this - I think you are correct. We do not need the
> rohm,regulator-crucial-for-boot. I guess we can check for the
> combination of:
> 
> regulator-always-on and regulator-boot-on
> 
> and interpret this as "rohm,regulator-crucial-for-boot".
> 
> I just think I need to document that those flags are required
> for critical regulators if SNVS is used as reset target even if there
> should be no one touching those regulators.

Anyways, this is still valid - I'll prepare next version with all
intended changes included... :/

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
