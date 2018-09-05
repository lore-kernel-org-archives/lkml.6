Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4082CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BDB206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkIiLMFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BDB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIEMsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:48:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40585 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeIEMsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:48:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so5458153ljc.7;
        Wed, 05 Sep 2018 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLOoQ8DK8xtx6gwKI/UCn2K/qifXex2M6r0t2iBHwC0=;
        b=gkIiLMFP1K8aXxG3xPU4yiJM9HGUfGnpdAf5Ksqyn7UQWfoob4EbPY0qM0P0VQtlEO
         z7iTYXyqoMACEAPeV6ZhkAvkTQfGmjU2y6m/4IfaSOpci73ajeAaCOADVb2Q3MX5un2+
         KbvH2gi86YFt+CsMmmegdoX8d1CS4pFCRVeTOBAFOvMzUiEfyWuR2Y2n7FzJukwvijDi
         4AR/ue7+ghprSYr5/8ngx778RSSEGmTeXb56IdHuZllE4Z7bXdaFI72NYYQNOUR+TXIm
         Rqj8ch9KCVxWO1vV0cfGC22KHJMDlz7C4XJpWSNtjoiWWgdRdiTjHINixkkrAwBMK/N1
         MHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLOoQ8DK8xtx6gwKI/UCn2K/qifXex2M6r0t2iBHwC0=;
        b=lxOsawr81IXZRhp8LRr2GxK+eMk5Buj5ICLf6txiExMkRkiiEZFhsSt/+OBVXbqCcw
         0gaTuBP9vUsMBsrWnMhIFACws8fT86K/OOTplCYRC34jhA9wikdGnNBPHhZXilUHD/Zx
         l83Dm/jQbdHHjomDiajGn6Gkpgh97NfgOez0EFPkQuWG4e81+wzdJ5fxN1tLHV3PX8Zv
         yQ6zszvi+KOuG062LLJKPrOSJ1cWqxytbzp5MWRYQ32P4p0ClyUS+9zbkTXyzok/wlkZ
         XoMsrNoh4jlV2lPlh5jh7QIIH7wnLtAWJyeJ8++Tymrm4sM4vTVccRjMTtUMlwr+kt40
         Phww==
X-Gm-Message-State: APzg51CMzCAhOQqLZlU1QiTNuM8BDE9F7wzwMiHtUY91YT6Ofn/Wocjf
        Q+f1De38qM+7vs+ASK7n7GU=
X-Google-Smtp-Source: ANB0VdbFQeTrO7cQeHoc64yv5z38Ot82fWFjlsglBKGmPL79TELH3v9/mHa8RQAPiDkZvw8KhmMDTA==
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr18529364ljt.56.1536135570610;
        Wed, 05 Sep 2018 01:19:30 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id w18-v6sm185612ljd.73.2018.09.05.01.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 01:19:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxT2J-0003j6-T4; Wed, 05 Sep 2018 10:19:39 +0200
Date:   Wed, 5 Sep 2018 10:19:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        andy.shevchenko@gmail.com, ajaykuee@gmail.com,
        daniel.thompson@linaro.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: implement GPIO support for FT230X
Message-ID: <20180905081939.GU28861@localhost>
References: <20180904124924.GA7278@localhost>
 <20180825204744.2307-1-pados@pados.hu>
 <2d91567c930ae5770cc55f92c37a9c6d@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d91567c930ae5770cc55f92c37a9c6d@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 05:53:14PM +0000, Karoly Pados wrote:

> > Actually, after thinking about this some more, it may be better to just
> > configure all pins during probe. The device is managed by the kernel,
> > and we can't really consider what user space may have done before, at
> > least if we can't query the device. Better to be in a consistent state
> > while the driver is bound.
> 
> The CBUS pins do not affect the UART communication in any way, so if we're
> not using the GPIO, I don't see any reason why we should destroy the CBUS
> state just for the sake of knowing what value they have, even though we don't
> set or use or need them and there is also no interaction. But if you wish so,
> I'll set them during probe, I just think we are disabling a possible use-case
> with no added gain.

Yeah, I understand that point, but still not sold on the idea of having
potentially all four pins change state when you request one of them.

Going back and forth, seamlessly, between having the kernel or user
space manage a device generally just isn't a supported use case.

But there is another (aspect of your) argument for your approach, and
that would be that people may be relying on this behaviour already. That
is, due to lack of CBUS support in the kernel driver, you have libftdi
setup those pins and then bind the kernel driver. Would that even work
today (i.e. it's nothing that gets reset when binding the driver)? If
so, me may have to continue supporting it.

What is the default state of your devices after reset by the way?
All inputs?

Ok, you may have convinced me. :)

> >> + /* device's direction polarity is different from kernel's */
> > 
> > Why so? You could just replace gpio_input with gpio_output. I think that
> > may be preferred.
> 
> That doesn't change the fact that for the kernel (for example in
> ftdi_gpio_direction_input or ftdi_gpio_direction_output) '1' is still input.

Actually those two functions don't take any direction argument, but
get_direction() does indeed return 1 for input. But you can find
examples of the opposite too (e.g. FLAG_IS_OUT in gpio_desc).

> Yes I know we can do the inversion in those functions "for free" by setting
> instead of clearing and vice-versa, I just thought it is better if I choose
> to stay with the kernel convention and turn it device-specific at the deepest
> level possible. Not arguing, just explaining what my motivation was. I'll
> change it as you requested.

Thanks, I think inverting the direction mask will allow for some
easier-to-follow code in this case.

> > Factor this out to an eeprom helper that can be reused by other chip
> > types.
> 
> Yep, I'll consult the other gpio patch regarding this as you suggested
> in the other's review. By the way, sorry for the parallel submission,
> I wasn't aware of Poulain's patch in this same month.

No worries, just an unfortunate coincidence. And the more eyes on this,
the better.

> >> + priv->gc.ngpio = 4;
> > 
> > Shouldn't this be handled the other way round? IIRC there are two FTX
> > device types with four pins, and one type where only one pin is
> > accessible.
> 
> There are 4 devices with 1 GPIO, 1 device with 2 GPIOs, 2 devices with 4 GPIOs,
> and 1 device with 6 GPIOs. Source: http://www.ftdichip.com/FT-X.htm (2nd table)
> Do you still want me turn this over?

Yep, as you noticed in your follow up, some of those devices you refer
to above are not USB-UART bridges.

> >> +#else
> >> +
> >> +static int ftdi_sio_gpio_init(struct usb_serial *serial)
> > 
> > As the test robot reported, these should take a port as their argument.
> 
> Yes, I already sent in a v2 for that. So my patch incorporating your feedback
> will be v3.

Great, thanks.

Johan
