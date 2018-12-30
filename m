Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72D9C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C36920855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQuTWS7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeL3ULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 15:11:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40780 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeL3ULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 15:11:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so22496571lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 12:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7qSuNVBfEXrTGo+kbMAT8dIaSpXqZyU3nSQ8LPwQzg=;
        b=kQuTWS7A6G8xGnogO3TEpRTLM18rsONYWvPEWMeoHMtXuUcEK1Zbmpg/L2xQF4QUCB
         fY0askaJvi5rtyZm2HsoBavXxX/o4GjKFkjBGLb32Fzqz9smBEfMQiteUxAWDtQg8Fv0
         wb+GlUbFPGXtImvCrc2zxfaHBfBkKFF57MnI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7qSuNVBfEXrTGo+kbMAT8dIaSpXqZyU3nSQ8LPwQzg=;
        b=hYx4oC4AS+gXkT3lqRsjfloOY3AQVOlYPdrOXPrPCSmKxWtBCoPzuk1BVsi+H5I6Zw
         XbuMWOA1BW9W3uvjMhi/FMdlgbIeLcx+kdr/CzxwkU8HZzdYOznH36i86B9FernQiWr8
         NOMSV+LsDhw4prXC+Pol4DfDQSk5/nxJCVKlJyliU1iVzVcdOTSOL7+1hXQFNWLsTV+L
         IArz+/ZQvPEigLXMxY506Bdp8PRb65Fbx5e0+S2fmOx/kJ5oAI4PclWFsRBaIKt/PIEH
         mPMIK3DsvyAso37FQff3LZZmarHvAaTq1yzTxq8O2QKGvEQGWL+sxBdhWaSmdJ2sDN65
         YRsQ==
X-Gm-Message-State: AJcUukfo33NCa2wnX1bhLjsi7Qx697GG6DjhOYRq1G008N6Sn275Dqvv
        cB4V0cc5QzcDr2Gv26w1B9NHmG5gOz1lFDfaTpUKrQ==
X-Google-Smtp-Source: ALg8bN5WeCQxKZewzWDU5MGUiyzm5jFiroTbfsd+nghU7fqHOEjgMtNvGOm6/mTRXhaDVlfQXIFA2d2iOhsGISlYsv8=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr20202699ljc.66.1546200701088;
 Sun, 30 Dec 2018 12:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20181229114755.8711-1-masneyb@onstation.org>
In-Reply-To: <20181229114755.8711-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Dec 2018 21:11:29 +0100
Message-ID: <CACRpkdY8SvDUqHaem+wgV_xynzyWVqLnv5705mBEZ_SOuD_45g@mail.gmail.com>
Subject: Re: [PATCH 0/3] qcom: spmi: add support for hierarchical IRQ chip
To:     Brian Masney <masneyb@onstation.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
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

On Sat, Dec 29, 2018 at 12:48 PM Brian Masney <masneyb@onstation.org> wrote:

> This patch series adds hierarchical IRQ chip support to spmi-gpio so
> that device tree consumers can request an IRQ directly from the GPIO
> block rather than having to request an IRQ from the underlying PMIC.
> The first patch in this series converts pmic-arb to use the version 2
> IRQ interface and patches 2 and 3 add support for the hierarchical
> IRQ chip to spmi-gpio.

Very nice stuff!

> The patches need to be applied in the order that I have them in order
> to allow for a proper bisection, however part of the series can be
> applied without any breakage. Maybe the spmi-arb change can go in
> for v4.21 and the spmi-gpio changes can go in for v4.22?

I'm fairly sure the SPMI maintainer (Stephen Boyd) can just ACK the
patch once he's happy with it and I can then apply it all to
the pin control tree.

> This work was tested on a LG Nexus 5 (hammerhead) phone. My status page
> at https://masneyb.github.io/nexus-5-upstream/ describes what is working
> so far with an upstream kernel.

I'm a big fan of your work. I have a few of these devices as well,
so the day I manage to create a serial cable for it, I'll gladly test
this stuff and see what I can add.

Yours,
Linus Walleij
