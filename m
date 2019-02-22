Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB0DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFC02077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6IzQSZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfBVJH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:07:59 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33179 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:07:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id x9so745963qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYM8JAlsArP8ickQAVAzfA23wcG+aygQ4QAXwcDSYrs=;
        b=s6IzQSZbMYQg2nPJOLSEUuMNyPvfnGIuOVRQVY+pZLaV234h1f5oS2Y17T2QSFvqYd
         eOyTjOUb9+07+8V1ZfbggeWlZbn6dl4injlrphgmNfP+sxrr8uPK+wafdS16ANXEy59k
         66BxLoS/pkNk2PxERuXqV7nbuXCAOb9uXzi14uYoTpLaA607pT8LuKOVUZMBrUCti0Op
         PbIcMsVz1o6o/dr+xkmDaQ3fflj03N56eObeow/64h4/DYN2CZyJCcPFmVtT4cbqWBqF
         ZdwNORb30AY96paFBZ7Tu/75pIXLR2CZMkQuUfgCvNwZnl3bDISVSaWFjzHDR32jvCBA
         gsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYM8JAlsArP8ickQAVAzfA23wcG+aygQ4QAXwcDSYrs=;
        b=ct5bOhXoWjik2gFI3KEJ6gfL2GvCR0mujgbBHiZw2B8yhsXM7/HCWxxOZ9eZSdRQex
         ComGjc77GjZru8oiQgmMWdSJEFdoNKyyFh36a+1xrk6o7m6YYqyA5zX35gcPOD/cv8jN
         eSszEzGoRabG8g67m+5eSs2bHM/ZM8qGkpaZz3ocdYBU8vIanARUpDSZpk/uvlG/tQn4
         kKUz7c48AIG4l1PExLE61IPHcpRjQtNZL+Z5nZTsdT81F01fhcwLA9vAUlrBiwc+6rTz
         Bwcb6BxZEO4V2Tvzyryreja3EslwAJUc9XKHvzzwzmx6n/1xpbaMlZTw+Wgdw9XcLl6r
         P0tw==
X-Gm-Message-State: AHQUAuZ/y/wahjcM5ZFyusonug6NZ+TAHXt0tpj6JvcRtEe7klQk7meH
        4jXC1MdZlYLfFT4yCmxqITv7LahqytPCi/BMFm6psw==
X-Google-Smtp-Source: AHgI3Ia/i9xLFVpWpomwsApFwJ0jYX16EK7C2GnIPtJngUFhkOUN0tP3Fi/YE9/2WyEheFc+fR1LW6zT1O2M7ORf2as=
X-Received: by 2002:a37:7885:: with SMTP id t127mr514374qkc.109.1550826477927;
 Fri, 22 Feb 2019 01:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20190208021631.30252-1-masneyb@onstation.org> <20190208021631.30252-6-masneyb@onstation.org>
 <155020988635.115909.8353948296231202388@swboyd.mtv.corp.google.com>
 <20190215134733.GA21208@basecamp> <155026608236.115909.9007817366859489104@swboyd.mtv.corp.google.com>
 <20190216002359.GA24752@basecamp> <155077482380.77512.11109337732610217265@swboyd.mtv.corp.google.com>
 <20190222085713.16f7822d@why.wild-wind.fr.eu.org>
In-Reply-To: <20190222085713.16f7822d@why.wild-wind.fr.eu.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Feb 2019 10:07:44 +0100
Message-ID: <CACRpkdbFQ2B7AvVW38etdsq-R38p5uX7eMrD2oKxTtDE3_W5aA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] mfd: pm8xxx: disassociate old virq if hwirq
 mapping already exists
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 9:57 AM Marc Zyngier <marc.zyngier@arm.com> wrote:

> To be honest, I'd like to make progress on that too, if only to put
> something in core code so that individual drivers don't have to play
> that kind of game.

I am trying to pull hierarchical IRQ into the gpiolib core by refactoring
based on these and some other patches (like the IXP4xx GPIO driver).

I am working under the assumptions of what compatible strings
indicating the hierarchy topology and hard coded ranges of
offsets from parent to child in the driver only associated with
the compatible string, so no IRQ range mapping in the device
tree.

AFAICT that is how hierarchical irqdomain is engineered as of
today.

Yours,
Linus Walleij
