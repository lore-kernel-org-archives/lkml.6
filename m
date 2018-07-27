Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA60DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CEB20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="athAdx/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CEB20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeG0MGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:06:18 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41483 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeG0MGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:06:18 -0400
Received: by mail-ua0-f193.google.com with SMTP id h1-v6so727310uao.8;
        Fri, 27 Jul 2018 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B5ipsHWpjV5F9Hej6Wn0EK1AtUmLueusI+giUSnEp3A=;
        b=athAdx/dAHnksT6NGzpZnQn11t9roR1OIhOnVkYNhtJs1injsGMB1oeDkIsI2hO08y
         Epty2h5FtF5M4clvKSKoxHTC/YLQyU3yJ730uYaz+ehqJhcTa3uUUiSUmjwAKgz2WLgw
         +uCMONUlvzq0aXKaD9Gq2H2Z62lz2lOmpjDu1g3nx3rpZThgzy+5XuBy66hIT0o0fpPO
         WO3lCsZ+ymRViYkOEJc35Dnnq1mmzyvek2ZKX3Tt4rXfG0TByfUxDdAZH5d1C7F97/4H
         uT7w3K60C9HM70Y7cWaR95nx8j969OAkcRQ5iNbaGf+P+KfIZZSa0T4pJWgij8l+lw+8
         UnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B5ipsHWpjV5F9Hej6Wn0EK1AtUmLueusI+giUSnEp3A=;
        b=uNdMdSqw+Yv7qdVO/YHTsN6grkEaRGyq8hJ8UVshRnEMC8zUKhtMoG64GhWaHaeact
         4dAE1+I/k+a7UjxFG1SZ2EdwnAzeWJZO5DayspXnDr0xQy635fX8W0tPDajSRRSZHFZC
         fTmscOAFB6hKj5Hl/5QR9HtrGVRfmYQ2SFu2b6hbajnvj263+g5nDvelygC+zrNSr0C3
         8gX1MaO7Kg4AXxVLzBfvPjVOcTpgoXysnaz+EDuh1H/d2gKtEGmDnOW6xFT+cBvjpNOJ
         hRnsLwI4D2nR+tvHibEaQXjZEyb1TClZSHHa1GA+xx8mMsPGCEBORoios8fAeZB5HsZw
         SFrw==
X-Gm-Message-State: AOUpUlGxLLxCRIy+1619eddH8WzIkmQBsQsTQvgyDqdTX1q7Hk1o+qaO
        4K8V2XfNq0T9xEPIrklw67p6Sl5AsaVvrKxYO2hyg0UP
X-Google-Smtp-Source: AAOMgpe6R6WJfPRe+NLgHKGfEXuoW2UK8YgLEtcKRVceIb0A65nn+UKC/j3VHbtJlH/+T2qFhEfPOEufcrSM0P08U+A=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr4063032uai.122.1532688297284;
 Fri, 27 Jul 2018 03:44:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 03:44:56
 -0700 (PDT)
In-Reply-To: <20180726225508.74612-1-dbasehore@chromium.org>
References: <20180726225508.74612-1-dbasehore@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Jul 2018 13:44:56 +0300
Message-ID: <CAHp75VfXXdzmp7M8rpcYTTKzwMT=QKt=_m7m7Bfp7uM4izMkrQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
To:     Derek Basehore <dbasehore@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        venkateswarlu.v.vinjamuri@intel.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 1:55 AM, Derek Basehore <dbasehore@chromium.org> wrote:
> This enables the async suspend property for i2c devices. This reduces
> the suspend/resume time considerably on platforms with multiple i2c
> devices (such as a trackpad or touchscreen).

How did you test this?

Especially on Chromebooks based on Intel Cherrytrail / Braswell
platforms, they have a painful PMIC vs. OS design solution.

+Cc: Hans, who did a lot in this area.

-- 
With Best Regards,
Andy Shevchenko
