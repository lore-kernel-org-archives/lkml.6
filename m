Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D2CECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFC52151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiGlqsyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFC52151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbeITBaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:30:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38194 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731250AbeITBaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:30:24 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so9338050ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPVlf7SSIJ0tVQzQtZer2qaRgrUfCv+Bhzrf7Cp7YDw=;
        b=YiGlqsyA0elzewN9SGeKb3VnvhoBv44hmaRtfaDYZRbcZWTZAFtHuujrUk9hGkrSm+
         NJB/A93x9SxfLE8IGAFdrvCW7Q3/fSZ/mIS40+ZUZly6S8jc0u+IKKepghPpOn4x9q1h
         O0IkUWrLp7CesCoFWPDIDRwg4WThExxADDqlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPVlf7SSIJ0tVQzQtZer2qaRgrUfCv+Bhzrf7Cp7YDw=;
        b=M8IPrMmYlgl3AGumAL+XryHjeB0HE/J3iTJozhjJuV9iaMs7F5w66lDMCtVOzf0s9s
         Cqr2ew6VXa6X0kVuVflFsyBpWcVp/tpuy3Qeye6Ps4KcagQfyDguNZrSiTzpvOgkhj02
         oafNeIxC6vph+fXKaq0nO2W5vSvchje7G045Fo9BnrtRgxobAxK6vd59Uqyse1oQAZUW
         AdA3NI8Z9Mml8Gh4UEnSWgWmZL+VNEZQKRCdujbGouC1N1+IIo8SpMt543U+6oX+syYz
         XvyQ6D6ikfsfuuHfQBIY2wpusrarxAmDFCplpAklKUC0LH4YTl+nEstOPR90S6CjO0WE
         GT6g==
X-Gm-Message-State: APzg51ADb3v0VsjBOVb8cTPJhQkIntQOFH3nF0NHfpmzmIJ3tD7xdO38
        txI17MrjBfN4xyZ6Yk5fXNoK5UMI+uAFDjvC90lNGg==
X-Google-Smtp-Source: ANB0VdaIdyMpMG01/X9IVSr/Z9SFXtbH97utONsuQvr2UAFISZ6JsoL/khvPsaYMm7tN+RpjS+tIFkYbO54wA4RYvgs=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr22958477itd.130.1537386658158;
 Wed, 19 Sep 2018 12:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Sep 2018 12:50:44 -0700
Message-ID: <CACRpkdYvqf165oGAZFXnFw6YwdZHejnOHXKb109N9YZ6kjEF9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Introduce STMFX I2C Multi-Function eXpander
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This series adds support for STMicroelectronics Multi-Function eXpander
> (STMFX), used on some STM32 discovery and evaluation boards.
>
> STMFX is an STM32L152 slave controller whose firmware embeds the following
> features:
> - I/O expander (16 GPIOs + 8 extra if the other features are not enabled),
> - resistive touchscreen controller,
> - IDD measurement.
>
> I2C stuff and chip initialization is based on an MFD parent driver, which
> registers a pinctrl MFD child.
>
> ---
> Changes in v2:
> - move to MFD parent driver for i2c stuff and chip initialization
> - improve regmap configuration
> - take advantage of the use of gpio-ranges

I'm very happy with this version, and Lee can merge it into the MFD tree
with my Reviewed-by tags once he is happy with the MFD core.

I hope the DT people are as happy as me so we can merge this for v4.20,
the GPIO/pinctrl parts are definately finished. any remaining snags can
be fixed in-tree.

Yours,
Linus Walleij
