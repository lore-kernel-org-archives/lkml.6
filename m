Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BFCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97340222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbfBMHid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:38:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35358 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBMHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:38:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id j13-v6so1146688ljc.2;
        Tue, 12 Feb 2019 23:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EenHVuf24ybkr/5f/6rl+SHCbL/lzW6AFEcU0L+otA0=;
        b=GQP49B52yrKfigH9mtkGZinaX0WkoeNPlmMuTipxqGlm4/GgJ/jhBSctnpL5fiEYdh
         hZVe1Z3Jk10dkOmOSMVoYX/I2dbIRbr9DtUqq45lX1VC9WCOrSCekY0NaYoH61XGxyVJ
         6HANmzt2Z8gzuTwaJnXiEJV0wCoLoVYH+ElyTASuRWjwgx+6Rc2r/f/ysL+kLejW6tHx
         Ds8Gc0hoXRt019AkZu+foflYX0SGmCcSEibl5KSkvRX+dJtkxBTj5ZU7f0CLQ0Nqs6As
         oB82l/+V8Mpfsa/VMQQvpfHB7TygtOoA2ElEf86yK9oYbmHe6AbuGyvXYCNPGH4WcScP
         RvKQ==
X-Gm-Message-State: AHQUAuYD+LhCg5so3jxBqQTViTwdgNVXPpGjcziG/7UKbPag7gKwzYWH
        lTfYryIgYulb5yGfMftY5FY=
X-Google-Smtp-Source: AHgI3IZtMUs3NML+/Nto8s+n+6ak9mbxTDpVwTVKEb+7ZoE35Xy+wv+wPY92qsJEWiJox+IjZxBU9Q==
X-Received: by 2002:a2e:9e93:: with SMTP id f19-v6mr4797330ljk.122.1550043511349;
        Tue, 12 Feb 2019 23:38:31 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f143sm3593265lfg.34.2019.02.12.23.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:38:30 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:38:27 +0200
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
Message-ID: <20190213073827.GB12247@localhost.localdomain>
References: <cover.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
 <06c2f2f730b07caeb1f2fb86be60c02b21d7bea9.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
 <20190212160831.GF20635@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212160831.GF20635@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Tue, Feb 12, 2019 at 04:08:31PM +0000, Mark Brown wrote:
> On Tue, Feb 12, 2019 at 04:19:38PM +0200, Matti Vaittinen wrote:
> > read ROHM BD71837 / BD71847 specific device tree bindings for
> > controlling the PMIC shutdown/reset states and voltages for
> > different HW states. The PMIC was designed to be used with NXP
> > i.MX8 SoC and it supports SNVS low power state which seems to
> > be typical for NXP i.MX SoCs. However, when SNVS is used we must
> > not allow SW to control enabling/disabling those regulators which
> > are crucial for system to boot as there is a HW limitation which
> > causes SW controlled regulators to be kept shut down after SNVS
> > reset.
> > 
> > Allow setting the SNVS to be used as reset target state and allow
> > marking those regulators which are critical for boot.
> 
> The general idea seems fine but I'm wondering if we should use the
> existing bindings and just prevent any change with fixed configurations
> - that *should* just be a case of picking appropriate constraints I
> think.  Why does this need completely new properties other than
> preventing the user from shooting themselves in the foot?

The BD71847 and BD71847 have 'HW state machine' in PMIC. It has READY,
RUN, IDLE, SUSPEND, SNVS,.. states.

At RUN state, the enabling and disabling status can be either a
predefined configuration - or controlled by SW. There is one bit for
each regulator which can be used to switch the control to the SW.

By default the BD718x7 driver turns this control bit so that all of the
regulators are controlled by SW. This is done at driver probe, right
after the regulators have been registered.

Now when a reset occurs (SW reset or reset via power button press,
external WDG, ...) the PMIC disables all power outputs no matter if they
are controlled by SW or HW.

Unfortunately there is this 'feature' in PMIC so that when PMIC starts
up after reset, those regulators which were controlled by SW won't be
powered again - no matter if they were enabled before reset. This
happens only whn reset target state was SNVS state.

So with current driver design, even if constrains prevented the
regulator core from touching the regulators, the driver still changes
the control to SW. So we need to parse some attribute in the BD718x7
driver side. Besides, I did not spot a 'do not touch me' property from
the bindings :)

But after writing all this - I think you are correct. We do not need the
rohm,regulator-crucial-for-boot. I guess we can check for the
combination of:

regulator-always-on and regulator-boot-on

and interpret this as "rohm,regulator-crucial-for-boot".

I just think I need to document that those flags are required
for critical regulators if SNVS is used as reset target even if there
should be no one touching those regulators.

Thanks once again for the feedback Mark!

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
