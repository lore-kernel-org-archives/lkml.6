Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CAC2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jipL0owL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfBAJLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:11:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53643 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfBAJLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:11:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so5272477wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bvh41w/U3RRcIzYzoxWiR0ASsP/7HPiC6Gb7KnZQZTE=;
        b=jipL0owLaYaBIp2Srn1opv8BvjG4Kx9wj3Qy0Eml4V+7N9BChEYm2Sb1yAlE7mCqHJ
         75Eb0I0S7PIzxbhOhUA8+G0jmHZlRkwH9PplHsKtl0j4jOxmELWoONxxba7QXq/MwH3P
         ind5tbljjvlT7x0ejFX9StLkN7NLIvoWiliGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bvh41w/U3RRcIzYzoxWiR0ASsP/7HPiC6Gb7KnZQZTE=;
        b=JGPr+oQoGu5Ml9265AnH44eCKKHnTTLXnbo+BalVRkt9oTDeBQTa6I4urgyq9ckV8G
         8KgnkSlvTH1nOmLcKGPTIFEkaMntRI/TD7piDGsRypFvN1sq/HMxlIPhTpe6Ceb4/WGC
         QEcpZ6NLbX8/heyUGBeU6GtzMuEs0AO8wPFzpOgoy/33tZecPEWOKxzTa9W//Dlvs9MP
         h+dMSpi+aCKMTw0g66E88dSk3F6I625PODBZUiFpTQzZL5D2pjPTR6ea4/XnaKGs6F1a
         W5qPmBm7M56lF2lPNQtADeayHn79yVnr9mPJ4f/b59xyIAHnnWNQAQ1cNOkCwJQQjNlp
         MZ9A==
X-Gm-Message-State: AHQUAuaJXOk7zJV39rvoL4FFJUQ8SijH4fh/Lz0q/koRyHDXswwcdiiD
        68z+uUFc6F1N2KkiQLK5hjhIgA==
X-Google-Smtp-Source: AHgI3Ia2EvGX1L5dlr4tZLWt8tz5bVce6m1NA3hTK1cOW/t1NECBQsmL0WyrSlUP2TJLdZ1Hc0qSbg==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr1442974wme.119.1549012277932;
        Fri, 01 Feb 2019 01:11:17 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id z11sm276244wmb.45.2019.02.01.01.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 01:11:17 -0800 (PST)
Date:   Fri, 1 Feb 2019 09:11:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 12/13] input: max77650: add onkey support
Message-ID: <20190201091114.GD783@dell>
References: <20190129133545.1931-1-brgl@bgdev.pl>
 <20190129133545.1931-14-brgl@bgdev.pl>
 <20190130185328.GA149208@dtor-ws>
 <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
 <20190131122813.GB20797@sirena.org.uk>
 <CAKdAkRQUAMsT7SA7oAaEmLrkZ6hOdAqCC9RC6HGRsjJ+TvASrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKdAkRQUAMsT7SA7oAaEmLrkZ6hOdAqCC9RC6HGRsjJ+TvASrQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Dmitry Torokhov wrote:

> On Thu, Jan 31, 2019 at 4:28 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Jan 31, 2019 at 09:15:01AM +0100, Bartosz Golaszewski wrote:
> >
> > > I'm not sure what the policy is on merging MFD drivers, but I'm seeing
> > > that Mark Brown has already picked up the regulator part into his tree
> > > (including the binding document). I think you can just pick up the
> > > input patches and it will simply not show up in Kconfig until the core
> > > mfd module is upstream.
> >
> > > @Mark: could you please confirm it?
> >
> > Right, as it's a new MFD the Kconfig will stop it causing build breakage
> > until the MFD is merged.  I'm doing it partly just to cut down on the
> > amount of mail from resends while the rest of the series gets reviewed.
> 
> Ugh, I might have pulled it in if it did not reference the new header
> file. As a rule I try to enable all symbols that result in input
> devices being created so as much of input code is covered... I'd
> prefer input piece be merged with MFD.

That's no problem.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
