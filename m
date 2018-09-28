Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB889C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9412170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="far/vZ5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9412170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeI1PFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:05:01 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:35697 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbeI1PFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:05:00 -0400
Received: by mail-qt1-f177.google.com with SMTP id z14-v6so5809594qtn.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtpzZ9z9D5DPJAZAqg9zIW+VJnsjD+flloKCaGnEFSo=;
        b=far/vZ5U+EUZsrEefK/T6T6s074MPQzv1qIxiT1KiNggOEJ2OSuct24EcF2UfCK0RG
         QfWzvpZIKFY7QBT2JKyJiyoPTj5B+5G4KcugtNcBS33SPzG3nb7S8rCM+O7LlBsS0O3s
         Gm6iVqNnep6ovhD33aL+b8vLgXEoZnyReonBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtpzZ9z9D5DPJAZAqg9zIW+VJnsjD+flloKCaGnEFSo=;
        b=aBHqi9ol05f0WL8qY8MMb5w9OtUTGvO2wsiN+KGM0/XFjTug7UgkwWQrXPF0devm1G
         7qwts5gr2MafC5wEHfhe4No/BY82sDEJnLhKgREz2Qf1lDCQdk8JkOEmv6i1fOJYY3/h
         8o9nQdaYiMP2b04rPWEj5uekP10iArzauJU5SaJ0N1Is5L6jnNuB4wAfvLiRYiO+mmD5
         9UtI6/OxGnSWQiD+H/cocHQZuuGdHL2RzjhlSLFMpDgsqylI1J4/8dDHfA13d9WjAf3U
         G6LIwr0kOas60hT81ciVJu/WDAVq/VGHHRUl+1a7hCAxdQ4/V0X78wLj9uj89msb6Ys3
         PXuw==
X-Gm-Message-State: ABuFfog6PX+icm3QFxrSSNCMDFLg6QpLjhOj7hSRBDKevl5BcdVbZKFS
        dkFf1W2dcm8NVW8jGROLSrLqHnC4Xrv8WFSh9YeaaA==
X-Google-Smtp-Source: ACcGV60k3bI6IPzNuR/tnyomlJr2HywMGJnNQq9dNBbTWEXZVW4Eqz7XXHFYUeg6KT0IGIbQH0sMXwP9r2E9pJQzjio=
X-Received: by 2002:aed:3a68:: with SMTP id n95-v6mr11784964qte.283.1538124139546;
 Fri, 28 Sep 2018 01:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
 <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
 <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com> <CACK8Z6HjFy_5sv_ZRRyfRgCYMYPpuoFqmKekyi7fSLk14YpN6w@mail.gmail.com>
In-Reply-To: <CACK8Z6HjFy_5sv_ZRRyfRgCYMYPpuoFqmKekyi7fSLk14YpN6w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 10:42:07 +0200
Message-ID: <CACRpkdZZW_HK8uFA=iQQ88DnoR7KX2mYTbO3HMtNBLd-3GpiWQ@mail.gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
To:     Rajat Jain <rajatja@google.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 7:57 PM Rajat Jain <rajatja@google.com> wrote:

> > Patches are welcome, I think.
> >
> > Btw, is there any existing hardware on the market with such BIOS?
>
> Yes, all the chrome books available in the market (at least the ones
> released in last 3 years) have same ACPI layout (provide _DSD for
> card-detect). They are all working fine today because they use an
> older kernel, but if we update them to the latest kernel, this part
> will be broken.

This is not looking good at all.

Andy should we revert the patch or do you have some other
quick fix in mind we could do? It seems reverting the patch
could be bad for the mctrl patches IIUC, but this regression
seems even more serious.

Yours,
Linus Walleij
