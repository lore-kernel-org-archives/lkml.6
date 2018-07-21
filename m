Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D209FECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700AE20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJRh3Vv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700AE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeGUNIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:08:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36614 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeGUNIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:08:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id t3-v6so11805671eds.3;
        Sat, 21 Jul 2018 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JqCZVyEGL3VUIeNxjcTtNpdU6BNr5k4ixiARd+y7iM=;
        b=iJRh3Vv4ZaxFKoyIPdOBhJjME5wcPDRl86MeeMJwpGp9Z/ActLobS5Dj4RVhWm7KFD
         n4Y+st/VfYCAwF7Xj/PhCizi+UC2IjupZTaBxPFidCmjyKEITWd9Bd//gjCoDDUjYOKv
         mMpZcGPZgGHvf36rGcgC/r1yDRxVX3g9P0LKurLWvPWm9kemP/peN06MgjjfIf60M3Ql
         7GkUNIs1bO/enXkJwvy2EFxdOIb5wuU9kB6v15AF4C6DGWwCEfA8x0b5KbkTWeP2gfAu
         +R9FZEqzVeZgDgF7Ex5t5b8vGS6mGZAKCzQVu9e6k5DUyoKdMoc2APY413snOb1djHVM
         5L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JqCZVyEGL3VUIeNxjcTtNpdU6BNr5k4ixiARd+y7iM=;
        b=p26JQiRs7h9gcvnczsYG7eT+fhgwKggL0Ah/9hoEr8wUhLvFC8tfBJ3Dv53W463Suz
         fHgTNxbvHDWoBc43SqqKZ8N6KzCPxywGUtGufY6+9+12/eQqRyTODi5045gQ4IgNs9yB
         gw11Bx2H872dXabA9/UQbZAY8EM74hPYKRAl/xRLC+oQoSZGLA7aiDHwwJEO4AzwtEXV
         eSAfwW2y/Adq0ewrDWlwn8+WoiQ6x9ZkT/tJFU87hKH5ZoB+03SzYlHe1He1rmEH5AHN
         P6yAWQne9z6L/o2le0CTERu4fuvDYNx8Bz+5RzM4GAw0CIrp28of8mk/D8yeyb9YoNGq
         oBrg==
X-Gm-Message-State: AOUpUlE+uoaBuXYKuD1AWd1A6E5r3YS9CVJaLJV8pHJ/Ta8TQ/0rS+ZR
        /dDdmvuWkSC1Xq5mxf8YuoM=
X-Google-Smtp-Source: AAOMgpcX8Oea9bKzxg1zJSaGx5cr/2EbRhmY7xuUyg2+blJLN/w+RJPnAxrtU7InB2DnOklfta+1Vg==
X-Received: by 2002:aa7:c0c9:: with SMTP id j9-v6mr6520971edp.135.1532175338986;
        Sat, 21 Jul 2018 05:15:38 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id i10-v6sm2585774edk.56.2018.07.21.05.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:15:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Date:   Sat, 21 Jul 2018 15:15:37 +0300
Message-ID: <102145026.ENfUlVqMES@dimapc>
In-Reply-To: <2195096.d8yV6ZqeS2@dimapc>
References: <20180720080424.31505-1-marcel@ziswiler.com> <1532174119.19673.24.camel@toradex.com> <2195096.d8yV6ZqeS2@dimapc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 21 July 2018 15:03:57 MSK Dmitry Osipenko wrote:
> On Saturday, 21 July 2018 14:55:21 MSK Marcel Ziswiler wrote:
> > On Sat, 2018-07-21 at 14:17 +0300, Dmitry Osipenko wrote:
> > > On Saturday, 21 July 2018 12:56:15 MSK Mark Brown wrote:
> > > > On Fri, Jul 20, 2018 at 12:31:07PM +0000, Marcel Ziswiler wrote:
> > > > > On Fri, 2018-07-20 at 13:16 +0100, Mark Brown wrote:
> > > > > > >  	ac97->sync_gpio = of_get_named_gpio(pdev-
> > > > > > > >
> > > > > > > >dev.of_node,
> > > > > > > >
> > > > > > >  					    "nvidia,codec-
> > > > > > > 
> > > > > > > sync-
> > > > > > > 
> > > > > > > gpio", 0);
> > > > > > > 
> > > > > > >  	if (!gpio_is_valid(ac97->sync_gpio)) {
> > > > > > > 
> > > > > > > -		dev_err(&pdev->dev, "no codec-sync GPIO
> > > > > > > supplied\n");
> > > > > > > +		ret = ac97->sync_gpio;
> > > > > > > +		dev_err(&pdev->dev, "no codec-sync GPIO
> > > > > > > supplied:
> > > > > > > %d\n", ret);
> > > > > > > 
> > > > > > >  		goto err_clk_put;
> > > > > > >  	
> > > > > > >  	}
> > > > > > 
> > > > > > This isn't reporting an error code associated with the attempt
> > > > > > to
> > > > > > find a
> > > > > > codec-sync GPIO, it's the result of some other operation.
> > > > > 
> > > > > What exactly is then the of_get_named_gpio() above please doing
> > > > > if
> > > > > not getting the codec sync GPIO? I am not following you, sorry.
> > > > 
> > > > It's not in any way involved in setting the value of ret, whatever
> > > > value
> > > > that has it's nothing to do with that operation.
> > > 
> > > The comment to gpio_is_valid() says that it "Returns GPIO number to
> > > use with
> > > Linux generic GPIO API, or one of the errno value on the error
> > > condition".
> > > Comment doesn't explicitly states that the returned GPIO number is
> > > always
> > > valid, but it is kinda implied.
> > 
> > Do you mean I should be assigning the return value of gpio_is_valid()
> > to ret and use that instead?
> 
> No, gpio_is_valid() returns a boolean. I think your patch is fine as it is
> is.
> 
> Probably Mark meant something like this:
> 
>         ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
>                                             "nvidia,codec-sync-gpio", 0);
>         if (ac97->sync_gpio < 0) {
>                 ret = ac97->sync_gpio;
>                 dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n",
> ret); goto err_clk_put;
>         }
> 
>         if (!gpio_is_valid(ac97->sync_gpio)) {
>                 ret = -EINVAL;
>                 goto err_clk_put;
>        }
> 
> But that is not needed because of_get_named_gpio() returns either a valid
> GPIO number or a error code.

Also note that tegra20_ac97 code doesn't check the returned value of:

	gpio_request(workdata->sync_gpio, "codec-sync");

That is a bit fragile. Probably would be better to move the GPIO requesting to 
the drivers probe function using the devm_gpio_request_one() and fail the 
driver probing if requesting fails. That should be a distinct patch if you'll 
want to implement that.


