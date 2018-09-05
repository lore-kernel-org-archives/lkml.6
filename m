Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5E92077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwV1kXR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5E92077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeIEPHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:07:35 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50390 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbeIEPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:07:35 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so9216715ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVNFoIZXHwSjSyG/EAYj/Cfc4ha2Z3R4Xtv1AfGLQLM=;
        b=OwV1kXR3QhVXX4eaEj0RN8Z7nT4eBILTAX1DjTlY8QljyV2pnU4WDaUZh6i35ltvnc
         A5FfcdrKyOW2Dn4zULDTkHQ1gkuN3mqv6NlmnUFuQ+PcyKCiTHviU6MA55WciRCjvIoQ
         WdRCTRygsXJ9Wu/ogWWySbZSdzAOLoIaOhM9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVNFoIZXHwSjSyG/EAYj/Cfc4ha2Z3R4Xtv1AfGLQLM=;
        b=I62an1hqu4ewXOBOduZs92nwfHko5pQUPXr3DZSH80Z5ihyA9ZzS/fwoDZsJh01ACK
         7o085kDwe2X+r3kVHgM/X1tjB0znI/AsuRK/QVEZKWnduUH0O9ecMYIAmxGZLFfwP8dQ
         TApyJcmhDbDaRK291nnKU5mb9gwnlVGZ3ZcGWG/XrBEvWpwQBX3T/4oaXR5cOlDgtzP7
         zCqG1ePXrbRbHeM/DOEIOHrnza75PL0gH11bVKNxiywJnw1ewHxfn0epeJwEe6+zrRkq
         n4tUwDG+HorANsA6O50lEQwvkVmV9M6fnXTIb9SLGy3M3PQbfI2pvcRmIJdxr6n6O3N1
         Zthg==
X-Gm-Message-State: APzg51C+t94F2J2LYgulNa+cwKXox5sX0wdGNsDjnbhPdCiiN4fv2Fc0
        DgiHdTPoN1qy+Sii6qcgJrt4QuKGbTqqr6I0YgmE+Q==
X-Google-Smtp-Source: ANB0VdaRAeysJi0v1mc8WsMyiIPJZlmDXB4ux6uqG6bgeR+sG+IRHXd1hz8U+GjwsB/HjDbFt/6qOgysv1UjeMEIZeU=
X-Received: by 2002:a24:1f06:: with SMTP id d6-v6mr3065854itd.54.1536143878242;
 Wed, 05 Sep 2018 03:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180831191326.25106-1-afd@ti.com> <20180831191326.25106-2-afd@ti.com>
 <2a02c241-ac91-1bac-380d-122858bb03c3@ti.com>
In-Reply-To: <2a02c241-ac91-1bac-380d-122858bb03c3@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Sep 2018 12:37:47 +0200
Message-ID: <CACRpkdYvNeKyfRf5Et5zC4=hcu9cfDubftRFRHtrKLN-5Snd1Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     Keerthy <j-keerthy@ti.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 7:40 AM Keerthy <j-keerthy@ti.com> wrote:
> On Saturday 01 September 2018 12:43 AM, Andrew F. Davis wrote:
> > Use dev_name to get a unique label and use -1 for a base to get our
> > selection automatically. We pull in all GPIOs per chip now so this
> > does not have the effect of out of order labels like before.
> >
> > We do these both together so we can drop all the static data in one
> > patch. This also lets us normalize the return paths as we don't need
> > any cleanup after this change.
>
> echo 28 > /sys/class/gpio/export
> / # echo 28 > /sys/class/gpi[   12.839205] export_store: invalid GPIO 28
> o/export
> echo 2 > /sys/class/gp[   22.165728] export_store: invalid GPIO 2
> io/export
> / # echo 1 > /sys/class/gp[   25.961392] export_store: invalid GPIO 1
> io/export
> / # echo 3 > /sys/class/gp[   29.981918] export_store: invalid GPIO 3
> io/export
>
> Export fails with this patch. I am testing this on keystone-k2g-evm.

I think the GPIO got a new number didn't it?

Did you check the gpio file in debugfs to see which number
it got.

This is sadly the global numberspace that we are tying to
get rid of (new apps/scripts should use the chardev).

Are there applications that rely on the sysfs ABI on DaVinci?

In that case base needs to be prerseved.

Yours,
Linus Walleij
