Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F978C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13BA222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjA0P3vK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbfBMIih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:38:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45254 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfBMIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:38:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so1230022ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeTngYgb/4MDOX0lTbENW3uviJ2EzDI0XEMt5X040V8=;
        b=JjA0P3vK4pOU7F5qrd3IeVvTQo9T4FfV7/zrrNxO0/NN1f+51FZB/ZNDvTn+at2cV7
         j3WenQxHYUROFMA4bX2f9ScfUB83loKPLUN3va79aOuTSz49FJiedvCehrzu3ZhxvDwb
         0Q8pkGq0hl6GFfBdcXq4RE5U06yA/6i2ows3PjVpwAWOKmplYH00hwuUiJ+rGGEv0C4F
         jDODiTT4nZ5NJUy7SC0dBSaX92aXY7NS22H8HS/Z4hA7mvadEB9N4MYWUJX7RnGK19dX
         E7oOPNH3Uwl4nU22HyNawHrPGCLN6Rym7BhZLz2qlLsz3/C3K6hrnBHFR7nzVvOlMA/f
         DHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeTngYgb/4MDOX0lTbENW3uviJ2EzDI0XEMt5X040V8=;
        b=I0kd0diP+knFOyt5bJBvXo1Giz7USfBoBo3pafGIwfNKgNHAK7z6S+Lg3ek6QH3Cze
         CKk7sr3xGhuUfH/YqBqVOHaN17wxqiY7v+wjZp7vuua7QcQNPScqocO7Jo0Te1u0+/iD
         hY2cvraoVZyHQdQNGXtxiJ3wNAgGU6CJfre6l7oOkALjxwH78YbizrNi3cDdmAerXEtG
         qNBlJPDykVXorsAknRQush+PILsLj5G1iZjrK8nRLZ7xwfWb0zCM35YONLhfEgmC8Dfp
         xacMpi9jtjeXKW6y4RzcCpNovstV6VE+Xr+SOjKW+pGdmvBSaYTmz+EcOnC6cSZGY4qf
         OseQ==
X-Gm-Message-State: AHQUAuaZepoQMj4AnnnBCwTinl4PeUUO54L8Lad6Y/YQR1SjH1OCCZF/
        nTYYrmsDWar9vvoZtJr7udCiaFOH4LJI3ulefBWn7g==
X-Google-Smtp-Source: AHgI3IYKI3ujB+z/zvj9R5ko8c5vEvF5fCQ+jE8sGD5YhK8ET9x/GDcq44WdKqu0NQ/R799tXjGPUwQyLxQ6GfYs4kw=
X-Received: by 2002:a2e:9087:: with SMTP id l7-v6mr4673657ljg.153.1550047114497;
 Wed, 13 Feb 2019 00:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20190208021631.30252-1-masneyb@onstation.org>
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Feb 2019 09:38:23 +0100
Message-ID: <CACRpkdYHK1qwcy3AzRjwC1A_FB3ns9T7O_UnCgbtk30Nx=S8+A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] qcom: ssbi-gpio: add support for hierarchical
 IRQ chip
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
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

On Fri, Feb 8, 2019 at 3:16 AM Brian Masney <masneyb@onstation.org> wrote:

> This patch series adds hierarchical IRQ chip support to ssbi-gpio so
> that device tree consumers can request an IRQ directly from the GPIO
> block rather than having to request an IRQ from the underlying PMIC.
>
> For more background information, see the email thread with Linus
> Walleij's excellent description of the problem at
> https://www.spinics.net/lists/linux-gpio/msg34655.html.
>
> These changes were tested by Linus Walleij on an APQ8060 DragonBoard.
>
> See the notes on the individual patches for the changelog.

SInce we have definitive ACKs from the irqchip and
MFD maintainers I have queued this series on an immutable branch
that I will merge for v5.1 and offer to the MFD and ARM SoC
once it builds fine on the test servers.

I don't think the Qcom maintainers will complain.

Yours,
Linus Walleij
