Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE15CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA6B21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wz78VtNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA6B21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeI0Bkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:40:45 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:44491 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeI0Bkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:40:45 -0400
Received: by mail-yb1-f178.google.com with SMTP id x5-v6so36983ybl.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xaf/2HkfpAd6qa80iTcK11WNMdEE5ZYuxfG27JkSB3M=;
        b=Wz78VtNNM5IElHFno1vAF+XPYlcjdSMqgs0U3hOFP2AzEJTCAMyLLAh82Qg1cWh29r
         UXVYdviR6fM8KBesFr2jMEa53lvIVGCmuiz4anvM1O1qQRZ5VsyXvc0AkmiCzLCjy5VV
         KDtwi6JOXcBORMkgc2UEtLhB+wY+4mDOrxTgQFzb9uGUzZWkmd0jNO56IWrAwj0wfOCc
         7SVSGEE5dBxydYna6jgOG0WyR9Tzm5AdyDX8OLTAOHNQbd6NKIYOQmYGqRWhwi+MbeWT
         nf0MXjArvxdtINMzmKHJiDrR+JjT0YoSMb6n0ZYjeCOKOjqLAE4TsTSTxymKz7hI9f7n
         a9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaf/2HkfpAd6qa80iTcK11WNMdEE5ZYuxfG27JkSB3M=;
        b=cOEKqpCHJftT1KXQSi+FjEzNk7iXlvApn64yE+CG6dQkMc5gdHYsEQuqQt0eK8pF1I
         ulaEGo0UR9okwsIxHu07AuSwiTob7PSnj+ptrMq/xCSNfrybZmoNULoBfz1/maQ5TDu5
         +AWIIZl9AsLD+CwrtMNC0tfMwZdPhz5QMpGXC0f/w0HXrxrNpwOK0M2k1WtaI/lu5K9x
         zP0NvhviZ/23MjWSwnjjJmKp3/X8Rq5G9Kk/3Co9uTNunDuWPDx8LV6i2WOdTGqm9++8
         I8ZrpK+W6FRYgQpQM3EuZKegQH2uxSxNNpML2XCgq3/35UOrVbiivr7EMhKrc5Mqn/kY
         Uzzg==
X-Gm-Message-State: ABuFfogRN56mO/pRXatzElt31/gESKQPT3B0Gz3j9xfyXgJ39D8szjz2
        AyNQNFU44BJ3uUGmvPNHN1F5psjc4h5f9kR6jtD/jg==
X-Google-Smtp-Source: ACcGV6302wcx/PwAqhjLzbjrwhAfAZroi6NBRmUkrwuMjxqk27WQkn29TwlVn7HOV7NVfU1hGUZOCB4SB0MIoKeHUiA=
X-Received: by 2002:a25:6642:: with SMTP id z2-v6mr3916895ybm.224.1537989976851;
 Wed, 26 Sep 2018 12:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
In-Reply-To: <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 26 Sep 2018 12:25:40 -0700
Message-ID: <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks Mika and Andy for your inputs.

On Wed, Sep 26, 2018 at 1:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 26, 2018 at 10:49 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Tue, Sep 25, 2018 at 01:54:57PM -0700, Rajat Jain wrote:
> > > * Use con_id=NULL if it is dealing with a legacy BIOS (i.e. no _DSD
> > > properties in the ACPI).
> > > * Use con_id=<actual string> if it is dealing with a modern BIOS (i.e.
> > > which provides _DSD for the <string> property)
> >
> > Or you can use con_id=<actual string> everywhere and supply
> > acpi_dev_add_driver_gpios() where needed to cover cases where BIOS does
> > not provide _DSD.

This sounds like a good idea and I'd like to do this. I have some
questions though:

1) If the BIOS does provide a _DSD entry for "cd-gpio", and
additionally driver also uses devm_acpi_dev_add_driver_gpios() to add
one more entry for the same string "cd-gpio", which one will (should?)
actually be returned by the gpiolib? The one in BIOS or the one that
was added by the driver?

2) Related, I'm trying to understand how can a driver use
devm_acpi_dev_add_driver_gpios(), for *only* the case where the BIOS
does not have a _DSD (Or should it really care)? Does the driver need
to check for _DSD using some other ACPI call?

> See also Documentation/acpi/gpio-properties.txt for
> > more information.
>
> Thanks, Mika. That is exactly the way how I suggested to fix and
> actually fixed a lot of drivers already.
>
> Run `git grep -n -w devm_acpi_dev_add_driver_gpios` to find examples.
>
> > In case of SDHCI I think the correct way is to stick using _CRS lookup
> > only because there typically is just one GpioInt() and I have not seen a
> > single BIOS yet where they implement _DSD for this besides yours. If
> > there is not way to change the BIOS implementation then I guess we just
> > need to amend the driver to call acpi_dev_add_driver_gpios().

Since we shouldn't discourage a BIOS that is trying to do the right
thing by exposing the details in _DST, I think it would be preferable
if we can solve this in the kernel.

Thanks,

Rajat

>
> True.
>
> --
> With Best Regards,
> Andy Shevchenko
