Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEDD2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GyCyvZ+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfBUL7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:59:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44965 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUL7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:59:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id d2so5439274qti.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGOw9ywCSvUfCW1qXHASBmsRFCOvpvYbnAMF4vxN9BM=;
        b=GyCyvZ+7RA+5h5eWa08KbBvOzhXqbxjm8xI2l5cFMeY/WesYU+/TvL6iF42Adbgyt4
         Z5heJKf8wwRF6xLJaikSP8xx/dCxyyuV4i8JFVxXWfwcTAD6kK+eatByGswEYDbbuRNh
         OTzQBhhG0Ke8JjJ98HefIvd+pUH0gsW4FMogK9B6IBIKo+9HMIV4Tkcwbs4xarF3XvV/
         /GrRxxd/OLgYYHcgFqBMuwWtGCfa3ugkQdkmvU4XSGWEEzp3BTEhWJG/v6kyM1Jtw+JA
         UzoTs0hY/ZkTsu1boQ9P7n2JvSj1V3xF2hr1NoGTItoI2D8Lu85GHdlonszxUP8jADno
         4zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGOw9ywCSvUfCW1qXHASBmsRFCOvpvYbnAMF4vxN9BM=;
        b=RRfUoVt1KOtPJedz6yJPaEP8YMXJa2VL0oE0iHf7A3Y0D5DP/DIdYjvjKRCoRVLt22
         CcnR4PyRpQRzxG7jnLgtBXNmanS6S06VVNP8IWU6WTq2b6ucxh9ge9sAz4Me61wL0vki
         0iDmsZYODFBWq/JE7A3Us1nWhztPOcUz0MXyYm2D9GrNzkvfiZw+J+mjKz6sSSnbYJl2
         q1ek8VqXK0VWBzNwuqo7S1YNxTnRXV1H0u2o+ROeRQzLWguGk0TnBuKGa2ObZ6+twP8i
         NF27L5oqvq0CsvuyxflYaSg2N2Lj3qFKdI59LjGsN9fFvfmN/dy3SuzUexOedSJEAr1R
         ewvg==
X-Gm-Message-State: AHQUAuZhnHN8YPFf1mtGD65kq9oPA52p2LjUpmlaOIwnHQeY9xmUxUGl
        AqsKjq0Vh/FXJpfqx0oPyslXiwLQKhND+T4coSmAGg==
X-Google-Smtp-Source: AHgI3IawX7wKB8wlzuG+pwwlVbA4kzQJb8+K1gtZWLYAo6PN+49Pxl7FZigIHGx+j2KT1tLioTI3GKWk1ffJGRbkQR4=
X-Received: by 2002:ac8:26a7:: with SMTP id 36mr31988988qto.234.1550750385416;
 Thu, 21 Feb 2019 03:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20190208021631.30252-1-masneyb@onstation.org>
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Feb 2019 12:59:31 +0100
Message-ID: <CACRpkdbVUhejU5118pfur=PfqP6yvw19e34yeqW1sW2_7ZQ3Fw@mail.gmail.com>
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

I have merged this series (+ associated fix) for the v5.1 merge window.
If some disagrees you can shout now.

Yours,
Linus Walleij
