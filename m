Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB354C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814A021874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wYO4tnt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfADKgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:36:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43620 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfADKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:36:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so31363361eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 02:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JHFNuMXhkn6JkJ1AKiIggGsFpzQjYAkfcc/Ferbgp8c=;
        b=wYO4tnt4oVtFuZ/8hNXbLIzMeg//elvWv198r9sy05dgozlppbsgOuznFIBU3LWQWq
         9m/cSlry3A8WgYWbLEfqHOYI5ZcDjTY8uMsKC9mLgmTNLeVbNrQM8tkuziHPYes6ygrK
         GMQxR9OXJnawCDGj8PmUcaG4+O6a1kMhNn2fsdEFBXmp40WKI5NKsWCpWuogV0P2uSGK
         b2vIZZ++K4kYBGa1FFYLTVp7qZ3Crwo4CLOGoTliY4v6d3MpDg8ZLuH6EwhS18ZE76q4
         QaBGW/dgnuPtjXLsNmUud5qzNwY3m5AEPlrVMlvFh30VDJdioI9aMjpzSte5ciIWRQtW
         YJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JHFNuMXhkn6JkJ1AKiIggGsFpzQjYAkfcc/Ferbgp8c=;
        b=rJCTb4z6L5BpS28dpkm5fNhuDmBg5BwFT0emLXwykz/Wt64htvGnow90jfkJ9hVZYK
         hnu0p6ACgow8L2it2eFR1VM/49ycAsj7iZ5K0TQh3zXrIDz6tiJkFcd0S5hk1r/zdo3a
         aMm7WW6fKsUpBU9H7FZRjJx7Sp/lziprwQZGuA9o25Vo1pB1oSaX1fKqqae1uT8M3sEn
         rkAEn1Q0CP5cpLtnGOhtG4NeY+8eqT80AJ1kUwOcMa4FkxZ2/dYC4WbnTgMJ9yn5Rx+B
         DkIRX13kCv7wo2r8tvDHL446rO4pz0/KSxiGBMvqqNLfXdpgGQO/NXOSYVnjSb1TeThG
         iMYg==
X-Gm-Message-State: AA+aEWb8vhEv3meRtC03ROGmMjyu9Yw6afHvIWxGDQC6hwSVvnwQc76O
        NHLiUH4xuuN8lxxWA6NE/DUpvg==
X-Google-Smtp-Source: AFSGD/VvaoF8MdqU8dVOeRVOWhaidMnHRUttyz5/5YctzrIGOdrD/9PZzK9ocQNULODyRbvytyw95A==
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr45134491edy.231.1546598189508;
        Fri, 04 Jan 2019 02:36:29 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id f6sm27533591ede.53.2019.01.04.02.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 02:36:28 -0800 (PST)
Date:   Fri, 4 Jan 2019 11:36:26 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     bhelgaas@google.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: amlogic: fix build failure due to missing
 linux/gpio/consumer.h header
Message-ID: <20190104103626.GA8448@Red>
References: <1546592917-27846-1-git-send-email-clabbe@baylibre.com>
 <20190104103015.GA3738@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190104103015.GA3738@red-moon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 10:30:25AM +0000, Lorenzo Pieralisi wrote:
> On Fri, Jan 04, 2019 at 09:08:37AM +0000, Corentin Labbe wrote:
> > When building on x86, I got the following build failure:
> 
> Hi,
> 
> what tree are you testing on and which config ?

I use the next-20190102 tree
The config can be found at http://kernel.montjoie.ovh/configs/x86

Regards

> 
> Thanks,
> Lorenzo
> 
> > drivers/pci/controller/dwc/pci-meson.c: In function ‘meson_pcie_assert_reset’:
> > drivers/pci/controller/dwc/pci-meson.c:290:2: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
> >   gpiod_set_value_cansleep(mp->reset_gpio, 0);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~
> >   gpio_set_value_cansleep
> > drivers/pci/controller/dwc/pci-meson.c: In function ‘meson_pcie_probe’:
> > drivers/pci/controller/dwc/pci-meson.c:540:19: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_gpio_free’? [-Werror=implicit-function-declaration]
> >   mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >                    ^~~~~~~~~~~~~~
> >                    devm_gpio_free
> > drivers/pci/controller/dwc/pci-meson.c:540:48: error: ‘GPIOD_OUT_LOW’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_LOW’?
> >   mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >                                                 ^~~~~~~~~~~~~
> >                                                 GPIOF_INIT_LOW
> > 
> > This is due to the missing linux/gpio/consumer.h header
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  drivers/pci/controller/dwc/pci-meson.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> > index 241ebe0c4505..e35e9eaa50ee 100644
> > --- a/drivers/pci/controller/dwc/pci-meson.c
> > +++ b/drivers/pci/controller/dwc/pci-meson.c
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/pci.h>
> > -- 
> > 2.19.2
> > 
