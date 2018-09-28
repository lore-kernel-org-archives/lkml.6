Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2023EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06D32170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWKD/Zss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06D32170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeI1S5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:57:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41400 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1S5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:57:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15-v6so6358880qtp.8;
        Fri, 28 Sep 2018 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8T3xt4YZ/jzuiFPj3emz8wyggwTifi8XRQyHhp33ssI=;
        b=WWKD/ZssTpSbYt7NkGFaAanGgbIS8dst7Ha/wkFRSpTK4Qic0T4+O+P8DQv9IPO2Pb
         aDCrLLdRyh0hI37KHqVxH09ltYPXopagFoc892kO6hq4zajNIS0WP2DZ56DpoSJQgRwc
         3XaD0kEbKXl/PuoRscShxUT1cbK3iTzhWEA+F6uhbBxBS2tAZhh1qz+MQfw1SgDej+iD
         G7ds8CEWcnPoQnUNUaEl7nH3KAdRMZPgBHEuVLJrN0Y3t8WYTcKaHSBlPHN8KD+Qk6x5
         cfCHDL8NnVNMq8gh8TtphrvF4IMe7E2KY+q23czONP41PRQox/oQQQ6qQjTdstHz10I4
         U4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8T3xt4YZ/jzuiFPj3emz8wyggwTifi8XRQyHhp33ssI=;
        b=Hlxc/i91pFP0c2gddRtG/RN1kbBr+Vs5vj2XHh+dZOPX7gwPFqYdp+5fDknTjExXgT
         4ngvLAijZEtVT1ooWkE7cKQeC4HV+rLxuj9tIL3hSnLSrfW6nCzcn+lvpfjViMqspApD
         hK/2sQS/Hz+mPZX1pO9/q/iupghE1IwR8apFxpWfD6BTB2g0JJZXNI72d6OznEBQhT6f
         troerm92y+gAQZgooNEpn4VBK3hDNrmcFWesOBajZpBSJv7rzK9OwZn9I23NQKNkVsAx
         FoKqQ6W+Gg8Bho/APy5/PUqUMVGWzQmmEBYMV2PEPHMfQoiNAv2zBPp5PjMkdbiWjgbv
         DSyA==
X-Gm-Message-State: ABuFfoiuLLY+GUPPQuH01FN9u7sZGaLr8a7Kk9G2mS8JBvghH8eY3FWh
        JVAuhzf38D92gtjOpyP6ytLgv4oFWhZxlw2idxg=
X-Google-Smtp-Source: ACcGV60YI6WHQgBuoSmNjc3p8Cwxk1bUZgV9OmFVwNaQ3W2lHk5qRX+TLZOo+CodP/rF+Sf6qXnFGXxB7ypXunE7fDw=
X-Received: by 2002:ac8:60d0:: with SMTP id i16-v6mr6318104qtm.249.1538138053534;
 Fri, 28 Sep 2018 05:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
 <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
 <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com>
 <CACK8Z6HjFy_5sv_ZRRyfRgCYMYPpuoFqmKekyi7fSLk14YpN6w@mail.gmail.com> <CACRpkdZZW_HK8uFA=iQQ88DnoR7KX2mYTbO3HMtNBLd-3GpiWQ@mail.gmail.com>
In-Reply-To: <CACRpkdZZW_HK8uFA=iQQ88DnoR7KX2mYTbO3HMtNBLd-3GpiWQ@mail.gmail.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Fri, 28 Sep 2018 05:34:01 -0700
Message-ID: <CAA93t1qYN8BAZjOY+osHzTjYthYo+HY10zvfgQ-Z8+AQ2HdFZA@mail.gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
To:     linus.walleij@linaro.org
Cc:     Rajat Jain <rajatja@google.com>, andy.shevchenko@gmail.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 1:42 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Sep 27, 2018 at 7:57 PM Rajat Jain <rajatja@google.com> wrote:
>
> > > Patches are welcome, I think.
> > >
> > > Btw, is there any existing hardware on the market with such BIOS?
> >
> > Yes, all the chrome books available in the market (at least the ones
> > released in last 3 years) have same ACPI layout (provide _DSD for
> > card-detect). They are all working fine today because they use an
> > older kernel, but if we update them to the latest kernel, this part
> > will be broken.
>
> This is not looking good at all.
>
> Andy should we revert the patch or do you have some other
> quick fix in mind we could do? It seems reverting the patch
> could be bad for the mctrl patches IIUC, but this regression
> seems even more serious.

Sorry, I may have made it sound like more serious than it is. Yes,
what I said is true, but we (Google) does not plan to update those
devices to the latest kernel. That regression will only be seen by any
developers who try to do it on their own.

Also, the commit I mentioned above was put in long time back, and I
think it is more reasonable to put a fix in the sdhci driver instead.

I tried using Andy's suggestion yesterday, but was faced with more
questions that I did not have answers to (with my limited
understanding):

 - It seems that 1 SDHCI device may support multiple slots. It was not
clear to me if they could share card detect interrupts, or should have
separate ones? Also, the driver may not really know? So should I add 1
or two pins using the devm_acpi_dev_add_driver_gpios().

- I was unsure what should I set the active_low to.

Given these concerns, it seemed the easiest fix to me, if we can call
mmc_gpiod_request_cd() twice, once with "cd" and then with NULL as a
fallback.

Thanks,

Rajat Jain

>
> Yours,
> Linus Walleij
