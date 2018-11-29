Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED94C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7681213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIYMmMZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7681213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeK3C3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:29:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34967 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeK3C3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:29:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so2368163qtc.2;
        Thu, 29 Nov 2018 07:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=is+M9lfCxSLvLN4wX2s9Fg4iCHDVREcp0U5nUggWNOQ=;
        b=QIYMmMZ3hJBAPm85juNNhRSF8ItSoFqa3d7BIe3j2I7t5n4a+VA2RaxkOp7FNzL+Uc
         CGsMotuA3Js8KxFMyEc1elTRh0qqoIiAZ92FyG4m27wHKG419NpmbmSUbYPaQpiX75VY
         WTFpwg/iAPFT/u9S0xeI2jIEul4igjIHO7U7rLLyZAYwH7ca0A+VY5/PZnHYLBlBSZ8r
         GNQrTKe5YaZknlUjs2v2xRmD/fz9ic0QxbxbZ8fpfDzEFRyMcgEsovE/A7/HMh+1WWRT
         kJBL9+U15Zxx/qBB1wInolrV/rbcB/txyPkliTf2GEnPQ+G2Q3W3oDscRTxwKib1aKR1
         8K3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=is+M9lfCxSLvLN4wX2s9Fg4iCHDVREcp0U5nUggWNOQ=;
        b=b6Ny2MO/GeYMl8gUH/jTXTGz4fpS4KNT85Vw4Klqvl57gESHfjNoqZyxpjLi/Tk5LH
         sYZ5aWWBByJfvr9SiyUPJEmrYiu1M6YNbPv/bHwCvUVsAZxOLi4c3R4cj1p13N3jIuzT
         fM+RqiGsz73H0JDzD1nI3Kv9XHBET0XlaaaYOgtPEVQHfQBjmPRKe4b5E5BSz3dxwIQu
         aRKzkgWmZN3UWgwp4nUiXCQWPezdHUxmf6CIel3YqN/DF6pB8pFeRQ32IpuLKPbSs7oZ
         g4/UTfxS+BkmUqCaQmoQpdFwaiB1u7avaTRCROnvHzW1bGBGQonazFyv9siTH2jCKfGP
         i9DQ==
X-Gm-Message-State: AA+aEWaSnbP4sp5+639aTN/jMZpToQ7hmx8ybRKxehftASeuD+l5puPi
        s6vhDCp+3UngIpWnSC50it5AIGqY9Y7EnTVuPUw=
X-Google-Smtp-Source: AFSGD/WqC9SdK0ZeZI4JDnvwW4AApAMrRUlDyLC+HqFnInakVlgTCJHd1nNwpIdxS9TcalBaghrOxe7X7DJvYKuont0=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr1773209qvl.180.1543505051580;
 Thu, 29 Nov 2018 07:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20181127132508.5501-1-fe@dev.tdt.de> <CAHp75VfFYJQzTv_oe8RKPo03-FLYHy6BkrKaG23svAKtC+jVBg@mail.gmail.com>
 <583ca922b4a877a4b0577994e40ddf5f@dev.tdt.de> <CAHp75VcKu4fhP8=NH7fgfSFCh6xdCLWrNLcsHSuWvMcW+irfmA@mail.gmail.com>
 <70e7b8e2346b9837273b5edce0524584@dev.tdt.de>
In-Reply-To: <70e7b8e2346b9837273b5edce0524584@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Nov 2018 17:24:00 +0200
Message-ID: <CAHp75VfSKz8sauUKq2pxUhQ6xvmX4UeOBw6eEA+71=NUyWES9g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add device driver for APU2/APU3 GPIOs
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 4:02 PM Florian Eckert <fe@dev.tdt.de> wrote:
>
> >> Thank you very very much for your code review "again" I will update my
> >> patch set with your hints.
> >> Should I send v6 or should i wait till I get feedback from you about
> >> ACPI?
> >>
> >> >>
> >> >> Until now it was not possible to get more information to detect the
> >> >> MMIO_BASE address from the ACPI subsystem.
> >> >
> >> > I'm sorry if I already asked, please, remind me where dump of ACPI
> >> > tables can be found?
> >>
> >> https://www.spinics.net/lists/kernel/msg2887290.html
> >
> > Unfortunately the file had been removed.
> >
> > Btw, is the statement in above email still actual? "...I can fix
> > required things."

> Yes i will fix your hints tomorrow and send a v6 of my patchset.
> Thank you for your hints and time
> It would be nice if you could fix ACPI problemmatik.

I would like to see the ACPI dump for that...

-- 
With Best Regards,
Andy Shevchenko
