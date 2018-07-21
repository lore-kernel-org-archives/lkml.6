Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A477ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF21220854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojPWODIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF21220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbeGUM4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:56:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43277 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeGUM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:56:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so11797746edt.10;
        Sat, 21 Jul 2018 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4Fkp/KHa7FEOEu7VoafhS/3yTx22+dgWdZXXxfohOc=;
        b=ojPWODIjvniRPm8IkhnXQuB441H6P5TsZE3JMoai9Hc6HWmF/zYFBzeimHAnCANTMY
         hQo4KHoP040q2TPZ89qJ8jzXAJSeDLQd9JSj5yWVEv/IqM6nO8tVzjA6oMHdn2/GkZPt
         LwH5aiEaJZSppVO5CznrGzlrCeMqKdRbxjXL4b2JCu9KYIoG/93BUrcaL7P2BjpxfBrE
         T3PmHQft7OQNM/4HC3NfAyDSd/nMtQOlULKWRDTqVh19k/el0rQ3k3IhNVFQcEJhmGjy
         53vJeBx00OtEA3Kh5BFgAijjHCxt7LBOcP18GwljyV/AR8g60OHOuTNHrMsrM3fAkVNx
         VGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4Fkp/KHa7FEOEu7VoafhS/3yTx22+dgWdZXXxfohOc=;
        b=YVDxKHzD733tTZjD5xZMRFwMW36VRakXMwXH0fhVNSJ2doHxxHP2PqsE3H1XzY5+Ok
         9s8fz2jkvd6AbqZS4xb6l5lC880b2RQw4kPmZYmLg13BZ3K+7v9TTxzVxsdVqFO+82UX
         kQXcvgR+Gy3bvYnB98H/vAeYUIsoC2JYrHzCvkGUh4wHAyJM6zItVJhbMlFQ7SK1hgRH
         ofOFwFiSQ36WbWt2mWhLhKyXfIXaZyooAJ8K/7M22uTcVzbImxVWEM30p6a3aAGJNEDh
         SKt4Mv/heRuaklDiLgDUPphW+9QA9ELRWbF78aZoKvsmGKfo4i7ptDuH+kuRDLG7lHQX
         58PQ==
X-Gm-Message-State: AOUpUlFv0KFRHZ77868llp250YGkjdCtqtstOHRewqBepD1g9KKvKYy3
        fOHc289Om+c9zleJrXnwHJY=
X-Google-Smtp-Source: AAOMgpcv4zOIY3PzM80A3vNuJYKXOF0RVlCEHUITNu2gemhasFi+wYrp3CldlIP+aSLkrAtsj5JFMA==
X-Received: by 2002:a50:c211:: with SMTP id n17-v6mr4373111edf.11.1532174639853;
        Sat, 21 Jul 2018 05:03:59 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v3-v6sm1948840edq.92.2018.07.21.05.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:03:59 -0700 (PDT)
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
Date:   Sat, 21 Jul 2018 15:03:57 +0300
Message-ID: <2195096.d8yV6ZqeS2@dimapc>
In-Reply-To: <1532174119.19673.24.camel@toradex.com>
References: <20180720080424.31505-1-marcel@ziswiler.com> <8512069.csTsg4TRIJ@dimapc> <1532174119.19673.24.camel@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 21 July 2018 14:55:21 MSK Marcel Ziswiler wrote:
> On Sat, 2018-07-21 at 14:17 +0300, Dmitry Osipenko wrote:
> 
> > On Saturday, 21 July 2018 12:56:15 MSK Mark Brown wrote:
> > 
> > > On Fri, Jul 20, 2018 at 12:31:07PM +0000, Marcel Ziswiler wrote:
> > > 
> > > > On Fri, 2018-07-20 at 13:16 +0100, Mark Brown wrote:
> > > > 
> > > > > >  	ac97->sync_gpio = of_get_named_gpio(pdev-
> > > > > > >
> > > > > > >dev.of_node,
> > > > > > >
> > > > > >  	
> > > > > >  	
> > > > > >  					    "nvidia,codec-
> > > > > > 
> > > > > > sync-
> > > > > > 
> > > > > > gpio", 0);
> > > > > > 
> > > > > > 
> > > > > >  	if (!gpio_is_valid(ac97->sync_gpio)) {
> > > > > > 
> > > > > > 
> > > > > > -		dev_err(&pdev->dev, "no codec-sync GPIO
> > > > > > supplied\n");
> > > > > > +		ret = ac97->sync_gpio;
> > > > > > +		dev_err(&pdev->dev, "no codec-sync GPIO
> > > > > > supplied:
> > > > > > %d\n", ret);
> > > > > > 
> > > > > > 
> > > > > >  		goto err_clk_put;
> > > > > >  	
> > > > > >  	
> > > > > >  	}
> > > > > 
> > > > > 
> > > > > This isn't reporting an error code associated with the attempt
> > > > > to
> > > > > find a
> > > > > codec-sync GPIO, it's the result of some other operation.
> > > > 
> > > > 
> > > > What exactly is then the of_get_named_gpio() above please doing
> > > > if
> > > > not getting the codec sync GPIO? I am not following you, sorry.
> > > 
> > > 
> > > It's not in any way involved in setting the value of ret, whatever
> > > value
> > > that has it's nothing to do with that operation.
> > 
> > 
> > The comment to gpio_is_valid() says that it "Returns GPIO number to
> > use with 
> > Linux generic GPIO API, or one of the errno value on the error
> > condition". 
> > Comment doesn't explicitly states that the returned GPIO number is
> > always 
> > valid, but it is kinda implied.
> 
> 
> Do you mean I should be assigning the return value of gpio_is_valid()
> to ret and use that instead?

No, gpio_is_valid() returns a boolean. I think your patch is fine as it is is.

Probably Mark meant something like this:

        ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
                                            "nvidia,codec-sync-gpio", 0);
        if (ac97->sync_gpio < 0) {
                ret = ac97->sync_gpio;
                dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n", ret);
                goto err_clk_put;
        }

        if (!gpio_is_valid(ac97->sync_gpio)) {
                ret = -EINVAL;
                goto err_clk_put;
       }

But that is not needed because of_get_named_gpio() returns either a valid GPIO 
number or a error code.


