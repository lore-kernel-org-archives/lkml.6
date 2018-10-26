Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA2C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B9520824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2BLKUcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B9520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJZUFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:05:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42430 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeJZUFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:05:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id f3-v6so793762ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGKeCiAtS2NQzYC2py3Oz6uAOUcFgJGaewawQCQmfRs=;
        b=C2BLKUcpWBnQ3nWZXNH7X46wDlOmZIpWXpBYnr1mZj627g4fuWhtIZac1t2fWDBACA
         s78pCgNDD0VA/IBML5Mt2ONmY2eBxwAXcCEt0XjGzjOOVLWhuxo8iqeBgxhb8fL6nvYe
         MHHiCRHrZq5Cn88bjLowO9B//FiGjYcQQYFuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGKeCiAtS2NQzYC2py3Oz6uAOUcFgJGaewawQCQmfRs=;
        b=RxzEOB0rgb+E+DLssjhCDRWZEjs3qRIu+usNe+fo5EH9Cs/ntdGUr3QLjDtZsZAnau
         IU3wiofujskGzTy/Qu8jRXrQGdfWPazbniNyjFIFpMhoHcCL6riU4adaiCStwf76M0U/
         58bWZP0JGjCiYC3av1GWXtdLFGhCg4pIbQ7zLcuYARFapGyufUxOUVf+eXF7uGAcjlaz
         m1KlaI5GCs0qsNUCY6G0KWk1x5IniB42DkcehMFqMt3kABfQHHC6KHOct3xNN4fBYI2B
         A7HQpYfnYb6O8YjDA6DIKzm3DZuTRuigtKWkU2+GCPq+sIa+p92D9Yh0Ra1b8JL+p603
         Y1yQ==
X-Gm-Message-State: AGRZ1gIoQCMcJaNL3KHAhmo2/N0dqY7sBsto9z+cEJSzJ0Yr8Bs9Z2gU
        sclBu3t0l1EazbcJrrVd4BVvCUaeGeOfUYmm4mRRpg==
X-Google-Smtp-Source: AJdET5fWKkmb+YZH05+RViYfUMEBBSa4FIw6rtP80r30tpbSi9qqggv8dczrORQF81a3YArjajhb/0ijhqeiU4Wg8IE=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr1968607ljg.23.1540553331999;
 Fri, 26 Oct 2018 04:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181025135515.8397-1-TheSven73@googlemail.com>
In-Reply-To: <20181025135515.8397-1-TheSven73@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Oct 2018 13:28:39 +0200
Message-ID: <CACRpkdaprWOr9rpsanLNZUHouWKJDkWAC1si+80zFp423eA3SQ@mail.gmail.com>
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document
 devicetree binding.
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>, yuanzhichang@hisilicon.com,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        bogdan.purcareata@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 3:55 PM <thesven73@gmail.com> wrote:

> >> +               fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> >> +                               0x00000000 0xa0000240 0x00000000>;
> >
> > Is it just a copy/paste from
> > Documentation/devicetree/bindings/bus/imx-weim.txt
> > leftover?
>
> No. We attach the bridge to the i.MX WEIM bus. Every fdt WEIM child node
> requires a fsl,weim-cs-timing property, which provides the bus timing for
> that particular chip select. It's the weim driver that requires this,
> I'm only following its instructions.
>
> Should I just leave this out in the example? In theory, the bridge can be
> connected to any parallel bus, so fsl,weim-cs-timing is Too Much Information
> for the example?

No it's fine, I understand it now.

Whay you can do is write before the example that this example node
is using the WEIM bindings and reference that binding document.

Yours,
Linus Walleij
