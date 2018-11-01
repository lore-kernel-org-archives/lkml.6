Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BD5205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XS+2YOkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BD5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeKBG6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:58:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42448 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeKBG6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:58:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so15267941lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCZJ3nHxCwDoSPUNAwLklQQEK7UGVlV2Zp4EOFDBd4M=;
        b=XS+2YOkb82UXAo/8D9jI00Rwy3O3XCMYjJhJkBlY84sDi/vh82fAj/B6H00R0vi6WE
         BgkVUVdle4rcsmLLqrnRx8YB4xTiQG2itWjo1dpi5I+2afgTBK7MXCF252vkgP34F93g
         OvdMUDUD571W0LQItDPbwP6nGrVLgQwZXAUhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCZJ3nHxCwDoSPUNAwLklQQEK7UGVlV2Zp4EOFDBd4M=;
        b=VzlSOmzKTIO1a6lRMY1RgiVZEFVAiwDOmlaSMPDdh6RrGloU60DLHWM9RrBo9KiGqR
         0ZQO24sg4lyJNq+z39XjBZGftJgrOt2xhwNLhOv+ZuUePeJR9cxRQOU/jT6Wkj75hsqF
         2X4aVl+EfiHweFcKSitNfN8KPjx8tGvNgqF7Nu4NYI1Bho4JHqAlcymiEVfRI5njUQlr
         L2q5L8CS2NR5oDSnOq8ZZRvdJ9mjGSMigGIZ6HUwDoyhuqyf4R7z1xeuP/2yTWMULAQd
         nXiU8n6DZOpCThX+Rjvh8JRCY0GghfuAycaYk3AjIXiPij0CBgwR5KdEXbKdH7m3Dzvy
         Niow==
X-Gm-Message-State: AGRZ1gIeJpmdIwWqKzMbQYXmYsnbR9dzAcCpVtB/6+fxM7OiZLSWtBmt
        vuWVtCkabAkK0oE8/PYJM1VnsOUtVM5GkorgD3HzYg==
X-Google-Smtp-Source: AJdET5feTJxns45wZATobDdXelgcq1srv6dVTYuf3wzMYz999YxuraE9SVeg7Fs+QfQVNZRNrgAVCsNoTZKvTY8VYA0=
X-Received: by 2002:a19:f813:: with SMTP id a19mr5269273lff.67.1541109238360;
 Thu, 01 Nov 2018 14:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181031194425.32132-1-TheSven73@googlemail.com>
 <20181031194425.32132-2-TheSven73@googlemail.com> <CACRpkdai-6iNbz4EGuHNHkQYyR+yhTEJdRXP4G6fUKpA+XApjQ@mail.gmail.com>
 <CAGngYiVorxYY+8e75068i4=PJi1gEvnGkgvBfi0+9H+c1qD-oQ@mail.gmail.com>
In-Reply-To: <CAGngYiVorxYY+8e75068i4=PJi1gEvnGkgvBfi0+9H+c1qD-oQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Nov 2018 22:53:46 +0100
Message-ID: <CACRpkdZkv6ikrFmJptBTwftj7TkR5Bce9e2R1ceTw_pLqH1LcA@mail.gmail.com>
Subject: Re: [PATCH anybus v2 1/5] misc: support the Arcx anybus bridge.
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, svendev@arcx.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 6:17 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> >> +static DEVICE_ATTR_RO(version);
> >
> > Do you need this in userspace really?
> >
> >> +static DEVICE_ATTR_RO(design_number);
> >
> > And this?
>
> Unfortunately, I do :(
> The application software reads these out and displays them in an UI. It's
> important to be able to see these on a running device.

OK...

> Perhaps there is another kernel abstraction I could use?

I don't think so. If you want to be pedantic, document the sysfs
files in Documentation/ABI/testing/sysfs-*

Maybe the properties should be on the bus though? I don't know :/

Yours,
Linus Walleij
