Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAD8C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C13020873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzdKqY0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C13020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbeG2W0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:26:40 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38733 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeG2W0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:26:40 -0400
Received: by mail-io0-f196.google.com with SMTP id v26-v6so8256857iog.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vswvKjw9a8ZiaxGQtg181He0WfBFps5hQeIAmxAkv78=;
        b=YzdKqY0Iuh6kCDMXFxN6AbKKLyxDcNmFnDcy6TZA7yOpckjhHdAjWoP4mfP8vWHbgm
         l0ogTes5PjCIAYssezSfYsiwLwvuSLblvVnv8AvTZ+iIHCECHh6YBsGP0WlmaIh/ZT89
         IwQ4REZJepMaVoeHYcZKuQ5wFVkIGOMRriUt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vswvKjw9a8ZiaxGQtg181He0WfBFps5hQeIAmxAkv78=;
        b=FDgMJRhB8kDb6o83iL3k9NlK9iT3n34SqUEa6/h4A5S/tj0IGAZqz+Adoe/dJfFEu8
         hQC4nmQFi+m80Me/YTQyyjiu28sYHV7aRMQ6kVgjlOjdGL58BJPoMVtB5yygJQce2YIF
         tdoNHbH4FE3dheDR7Ng81TuDZW1cH5PIMr021BOfAb6zL0JQwgOvDS436l8eBorcCyfE
         EP+ZoOxhOQ6AZlOHkS9QOED0AfaDxbxlNNgz2TEPtNVEFzDLHIgd8DawbwmckZQOQIi/
         EnWcuKwWwyfujAECYQe9xtM3U1Q1RdwfvICIa42pQUfncr5TphjlNEinBpMINNOBonPd
         GDgg==
X-Gm-Message-State: AOUpUlEmQmkrt4g+Afub365G3L9Q2RSDFipuSajhQRf4BQ+Ffurc33ag
        /Tqdb1pLVsETUJNkS0A1qCAAex/5MiIRypaNnjj4DA==
X-Google-Smtp-Source: AAOMgpfDowBaRdFA8Q6HwGOQoup13KGZdAlcQWGYroCqBO3wsIMPzeHZt9NHNef0LteUXa8fG7dvRUgT7gwcFVsXNPY=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr11483330iof.304.1532897692487;
 Sun, 29 Jul 2018 13:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <1531396813-6581-1-git-send-email-avienamo@nvidia.com>
 <1531396813-6581-6-git-send-email-avienamo@nvidia.com> <20180716154309.GA16477@rob-hp-laptop>
 <20180717152318.3608e3f9@dhcp-10-21-25-168> <CAL_JsqL1F0RF_6=ho0pa7Uh4AUsyvFRDGM50gN4=6_+MwBfGYQ@mail.gmail.com>
 <20180717183020.5ab9bfa6@dhcp-10-21-25-168> <cb67ced4-eef8-abb5-5706-3282a55edbb2@nvidia.com>
In-Reply-To: <cb67ced4-eef8-abb5-5706-3282a55edbb2@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:54:41 +0200
Message-ID: <CACRpkdbDjbi5+WAjU2kYLZZONVc9zrTuCAX9BiA86OrWN6vjPw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: Add Tegra PMC pad configuration bindings
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     avienamo@nvidia.com, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 1:16 PM Jon Hunter <jonathanh@nvidia.com> wrote:

> Adding Linus ...

OMG this sounds bad.

> >> I don't know offhand. Doesn't look like it if you have custom values.
> >
> > It's listed under "Supported generic properties" in
> > pinctrl-bindings.txt. The convention seems to be not to add a vendor
> > prefix even though such custom macro values are used. The property is
> > currently used by qcom,pmic-gpio, qcom,pmic-mpp, and renesas,pfc-pinctrl.
> > I could not find a bindings document describing it with a vendor prefix.
>
> Looking at other users of the 'power-source' property it is not clear to
> me if the values should/can be vendor specific or not. I see cases where
> some people use definitions and others use actual voltages.
>
> Linus, any recommendations here?

It's a bit of imperfect world here.

I always imagines it was some kind of enumerator
like source A, B or C... so 0, 1 defined in sime include/dt-bindings/*
would make most sense to me.

In general, use SI-units if you can, else use something that makes
sense for the people writing the device tree. These enumerators
seems to make sense.

If nothing makes any sense, maybe a custom property makes it
make sense.

Yours,
Linus Walleij
