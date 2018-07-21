Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25143ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66A22084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXQe+xsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66A22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeGUMK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:10:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43580 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeGUMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:10:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so11741197edt.10;
        Sat, 21 Jul 2018 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFQwbZIr8IkIjYVIuVcqtgW2+x8k/UzqJfdM4uVFoZg=;
        b=KXQe+xsx1/jQ7+CO7VTtlYEk+JXoJ1nAOJ2AggvlyydwQhNgmaHjL5BVedhHNBap1+
         1jma+nNIEuWX6eZN9l1wJhFe8hvGAm4a68KeOMMw0ytaIUdNlTDPr0YoQv3+ces/Buwr
         syU0lLYCpkRXAIWwh1MJWuajUAVDSS5Ue2jpB+vjG2WKL2gkPjAKRUkDAGSWV3eLIr2V
         X5z53Kr0pC3ccqNdjCJ1AmVMIZfMrAk4OXpEDsy967Bus6tGNTPsL1BdN87hfV4RwHqH
         4PkXYDWUYCgXzc8IDXBGyKjvMvxezrLVNgFNAN3HGzNPsxOGQuNOGV43LJ5fRetrCvX/
         SeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFQwbZIr8IkIjYVIuVcqtgW2+x8k/UzqJfdM4uVFoZg=;
        b=bIeIldOMYNf4arXF2892e2QXOKkGlPw6Qr1Mfyktr1JFpt9zx1S3xIM4hsyuh6Og3I
         tkecXmiwoT6+O0jPCBml8EmlkbWk4MVzjibQBBmrZWmokRBxQTDrSovu5XsIYU8I9EU5
         w38i6CMF8uoYbYeavVic942izzRjukcCYyWh3actQ9e0HTt0YXY4MfOO5+rRCzCx3aOx
         tFEkPj1WTit7/wCNu1IB0GIGxxvujpkKrsT3aiBLuhM0ialB8Zw8uK19YhAKN4nrdmqS
         9i1UAfjQ13YsoJoedAc8F7QwRi6aoX24uQMdHKXctyWxe33cxZFaJLsWySyYf4GhIPAO
         13eA==
X-Gm-Message-State: AOUpUlFOJ8M6O9tcjewkplgfZ+DX/tiq3kl4v+80UKX8kw9HAwgeyVmL
        ih+yjIm7dnc0E7qmqQnQMhk=
X-Google-Smtp-Source: AAOMgpexTKjbBFMG4hADMNK02TjtTUvDRX6A/ELcAb/teiTeRU90DcgURu7y45dmWaYdxoNYlZeGPA==
X-Received: by 2002:a50:984c:: with SMTP id h12-v6mr6393010edb.150.1532171882032;
        Sat, 21 Jul 2018 04:18:02 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id g1-v6sm3272070edr.52.2018.07.21.04.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 04:18:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Date:   Sat, 21 Jul 2018 14:17:54 +0300
Message-ID: <8512069.csTsg4TRIJ@dimapc>
In-Reply-To: <20180721095615.GG16228@sirena.org.uk>
References: <20180720080424.31505-1-marcel@ziswiler.com> <1532089865.19673.13.camel@toradex.com> <20180721095615.GG16228@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 21 July 2018 12:56:15 MSK Mark Brown wrote:
> On Fri, Jul 20, 2018 at 12:31:07PM +0000, Marcel Ziswiler wrote:
> > On Fri, 2018-07-20 at 13:16 +0100, Mark Brown wrote:
> > > >  	ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
> > > >  	
> > > >  					    "nvidia,codec-sync-
> > > > 
> > > > gpio", 0);
> > > > 
> > > >  	if (!gpio_is_valid(ac97->sync_gpio)) {
> > > > 
> > > > -		dev_err(&pdev->dev, "no codec-sync GPIO
> > > > supplied\n");
> > > > +		ret = ac97->sync_gpio;
> > > > +		dev_err(&pdev->dev, "no codec-sync GPIO supplied:
> > > > %d\n", ret);
> > > > 
> > > >  		goto err_clk_put;
> > > >  	
> > > >  	}
> > > 
> > > This isn't reporting an error code associated with the attempt to
> > > find a
> > > codec-sync GPIO, it's the result of some other operation.
> > 
> > What exactly is then the of_get_named_gpio() above please doing if
> > not getting the codec sync GPIO? I am not following you, sorry.
> 
> It's not in any way involved in setting the value of ret, whatever value
> that has it's nothing to do with that operation.

The comment to gpio_is_valid() says that it "Returns GPIO number to use with 
Linux generic GPIO API, or one of the errno value on the error condition". 
Comment doesn't explicitly states that the returned GPIO number is always 
valid, but it is kinda implied.


