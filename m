Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2ADC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4E42083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+aikRdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4E42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIZOy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:54:28 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:45253 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeIZOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:54:28 -0400
Received: by mail-qt1-f173.google.com with SMTP id l2-v6so16363436qtr.12;
        Wed, 26 Sep 2018 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0GNsE1a/twTLBsaKEik3GVfYLJgbc3pBenDaNstH6Y=;
        b=d+aikRdMYADiZlqZfqoHxLuIKE2qWahhg73sZXr0dffmQv3XjfM2ZpqeyLIJXLUyjm
         RobedK8n6GThjCt5oV3++JCZe32MYYCfry1tIkRp53mT1OsfSGjjTwQYcfQtKH+vlfOP
         wHoloNhSJRszMbpdFpDUu44IsUdHMxy2t29uEO5Ur91ACvJkpxtYJxVDUUEVRyjvum8B
         bbMLy5/YGOczPDzoCfiLX0N10Sf7wCAA/jbKcBayOXQdI7XnfKSLtiP4nAVOngVIq3aa
         dH1F6HBAusWZlexzW5SRm5K+4Oujpqx+5p5St4/uAPRQm/cjjqY7ez3Xi8Ijcmi/bjYv
         2hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0GNsE1a/twTLBsaKEik3GVfYLJgbc3pBenDaNstH6Y=;
        b=dBh4D+DHXdedAO7SnvQMBMoehNcwxTiPPN6XGPJvkdU0wq76dbw83F09aXIycgA1dq
         8vsiv5yTwjbCx2dMhrK6/WeCRYIrudrVxI266cpH8IDCd/vykli747A2vGDX3mws2r6h
         zLL/UBgD0GyXDKZj4m48goC0+67aCwN4JE37OSc6Q1YZxhxB7eMZlFcF/y4dhLI35yKs
         8TB8xuHHHbSo+V6CXwRTH2nJypStcZRcVLHu49PyjSkTiXrEwU2rX98WkrqQ2w2HLWM1
         SfEphO7Sv65LJwdxu2erFAESVa+r/yxCKpd0w01QCBMhqU8F6IlBnakjJLq5uhygJbOz
         Xnww==
X-Gm-Message-State: ABuFfoj53bn/6C3vjUFYlrxHXQicPxLYtToi6SiS+MfivHEh9YJ1aJQz
        srPo2nWzlURxOgcp29btL2PX1VrVP75KIYra9Ro=
X-Google-Smtp-Source: ACcGV60st9YAPF9/x6ButZNjHAO2HdH4Z7Mbh3usOD2AwqSq32RsdRNqjK2VakmcVe2jriZPWCBeKOIqO1BXVNNPNU8=
X-Received: by 2002:ac8:16c5:: with SMTP id y5-v6mr3732370qtk.187.1537951357705;
 Wed, 26 Sep 2018 01:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com>
In-Reply-To: <20180926074756.GD2664@lahna.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 11:42:21 +0300
Message-ID: <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dtor@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:49 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, Sep 25, 2018 at 01:54:57PM -0700, Rajat Jain wrote:
> > * Use con_id=NULL if it is dealing with a legacy BIOS (i.e. no _DSD
> > properties in the ACPI).
> > * Use con_id=<actual string> if it is dealing with a modern BIOS (i.e.
> > which provides _DSD for the <string> property)
>
> Or you can use con_id=<actual string> everywhere and supply
> acpi_dev_add_driver_gpios() where needed to cover cases where BIOS does
> not provide _DSD. See also Documentation/acpi/gpio-properties.txt for
> more information.

Thanks, Mika. That is exactly the way how I suggested to fix and
actually fixed a lot of drivers already.

Run `git grep -n -w devm_acpi_dev_add_driver_gpios` to find examples.

> In case of SDHCI I think the correct way is to stick using _CRS lookup
> only because there typically is just one GpioInt() and I have not seen a
> single BIOS yet where they implement _DSD for this besides yours. If
> there is not way to change the BIOS implementation then I guess we just
> need to amend the driver to call acpi_dev_add_driver_gpios().

True.

-- 
With Best Regards,
Andy Shevchenko
