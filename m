Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A72C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7F02168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UodrHhur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7F02168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeI1Th1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:37:27 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:38916 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbeI1Th1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:37:27 -0400
Received: by mail-qt1-f176.google.com with SMTP id c25-v6so6522391qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xvCAP5NTwbSHjqmkd3Iz1A7oKKr+ZYMVP63d5r08D8=;
        b=UodrHhurJ/nUZUNFJCeFLbsXxxOeF9oIf/z4gxySACqJzdPUNSFBYZoybqcnr1L1C4
         /qvg0P4HGBQAQYtCLPMHUkqxU7oQZHjylaaBsh9aBr+Dg+AXhSsoHBjmsRabO7skdfxQ
         Pr05rgGTj8Rrw/ckKdyJFmVp+sYT37op8i/CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xvCAP5NTwbSHjqmkd3Iz1A7oKKr+ZYMVP63d5r08D8=;
        b=Z4zsFvw81HFADcSVB0l3JwMY6DsqDN0rqkvIat/iuOH7C2ttFbuW9dGu9lLaF1FpX4
         2AFyOR2s+kY8emmLKOZcbnVZLHRQoPfmgSJODJ/fvgaDofFsR4bd5pUwfBrVC8BbJTqj
         W7i0pFQpmBDwAB7j9JaSDX1TBZYjbeC/0c1yd8NZExySiVyp/jSOvAOhD6C/4J83Lho4
         hbXpQ3Tyq69A1/nmBE+fVEkhwsTXQOMy+TyRae45yOokYZ7zUu8G1Z2qfdAMDyE2R82B
         p8TuqlkyVXFP77oIAlAuBKy1xMotao6z6YNGwMVUq/2k2/1JFnJ/Xb2wUrtB+/ebgahY
         W0dw==
X-Gm-Message-State: ABuFfogPSE0NQ2ubsMw79Il0bwAFz57O7Admv/huQUtBsCo8xxV2iBq+
        b3jtdMExbw3PomkcDQvgVEWFN4ScPC2rP6X/xua3uQ==
X-Google-Smtp-Source: ACcGV612aGRGykkKKRMLampzS4C79u057COZlmEICcpTlkr1yGX0XhJm2Cj0nEx5VOnzbas4RzbZdBAvLqTUNyC0Po4=
X-Received: by 2002:a0c:c202:: with SMTP id l2-v6mr11751484qvh.209.1538140422952;
 Fri, 28 Sep 2018 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
 <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
 <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com>
 <CACK8Z6HjFy_5sv_ZRRyfRgCYMYPpuoFqmKekyi7fSLk14YpN6w@mail.gmail.com>
 <CACRpkdZZW_HK8uFA=iQQ88DnoR7KX2mYTbO3HMtNBLd-3GpiWQ@mail.gmail.com> <CAA93t1qYN8BAZjOY+osHzTjYthYo+HY10zvfgQ-Z8+AQ2HdFZA@mail.gmail.com>
In-Reply-To: <CAA93t1qYN8BAZjOY+osHzTjYthYo+HY10zvfgQ-Z8+AQ2HdFZA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 15:13:31 +0200
Message-ID: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
To:     rajatxjain@gmail.com
Cc:     Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 2:34 PM Rajat Jain <rajatxjain@gmail.com> wrote:

> > This is not looking good at all.
> >
> > Andy should we revert the patch or do you have some other
> > quick fix in mind we could do? It seems reverting the patch
> > could be bad for the mctrl patches IIUC, but this regression
> > seems even more serious.
>
> Sorry, I may have made it sound like more serious than it is. Yes,
> what I said is true, but we (Google) does not plan to update those
> devices to the latest kernel. That regression will only be seen by any
> developers who try to do it on their own.

Given the number of core kernel developers using chromebooks
and relying on them to be working as expected, these are the
users I am most worried about, really.

If only 3 users in the world can't read photos from their SD-cards
that may sound like a small problem, but if those 3 users are
core kernel developers reporting bugs, I as maintainer have a
big problem. So not all users are equal, or how should I put it.

> Also, the commit I mentioned above was put in long time back, and I
> think it is more reasonable to put a fix in the sdhci driver instead.

OK cool.

>  - It seems that 1 SDHCI device may support multiple slots. It was not
> clear to me if they could share card detect interrupts, or should have
> separate ones? Also, the driver may not really know? So should I add 1
> or two pins using the devm_acpi_dev_add_driver_gpios().
>
> - I was unsure what should I set the active_low to.
>
> Given these concerns, it seemed the easiest fix to me, if we can call
> mmc_gpiod_request_cd() twice, once with "cd" and then with NULL as a
> fallback.

That sounds like a resonable fix to me.

Yours,
Linus Walleij
