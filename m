Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22065C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4229222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3jhDVQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391147AbfBMJCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:02:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35388 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfBMJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:02:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id v7so1191626lfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2qnIA1z9ec4cy2md+pd6mgiSd4N85RX1AUwCJqOSwU=;
        b=w3jhDVQ26rzJl9cpWu9fFAdG4PukT689pwlRNkt2l6hD7MY/szHSmWaB4PECpWlFTc
         XvcE3PXz5accSPXy9NFxT3m3Mt2Jug5OgwS6c71ig2dY/tjSC+Nh8einzvHF00jAm/pg
         6aHiOWBBEr0e2ga1VUW+cR0OTxTLGOpZ7W4LVFr+wtyUjpMOD/N/aHFCKkQEBJfeSLY5
         etUFxCEWQvOmxvtbQeUVlMd2z9vaxSiv2Tx/7Lx9ylxCyp6P/NjCbr3wPSPAbLw5PZ/V
         A6VUXIYpJrkHyfr+/vsX5maFDybfEo9DPk4KroHfdip0X+xws2QJ+9tlWMCH7rDOBpgB
         3Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2qnIA1z9ec4cy2md+pd6mgiSd4N85RX1AUwCJqOSwU=;
        b=IvCeuSD1c+C0v1kT3iGo/dhK7hall2PY8qX//7hG2r++89w4Kf1YAifrRVAI33FZnr
         TYWsATZds6Zv0nvleIvFhNoKlNp5JLorp9Wn95xSAJvOX28A11cOqA3AbadXhmb0CKfj
         rM4vbQVuCVJf6PUwyyHv+yB7ajUzMYu1QSxjlPTHfuMNguAtKkOWKiQYlIlylYEoUlqq
         na9MiP2VNFy5qYeC1FBPdI9ox1J8SIH5mIDtOJUNuF2X9v1be4JkpiVVwbWBkm+7BSRm
         UvQH2IszobJ9kyaiHaGV1KNJn3D2pijKzPOi1ehrNt29YPUJXn7ZhPyOLCw5RJUIa55n
         i/qg==
X-Gm-Message-State: AHQUAuZ6WvQLzEYB5GCenaDQX1nq4ynPSJuXZeX13QXtVSY9AnO9trQu
        O70twA3umeKsgK4pFtEM9mcX461dBPlUacEPEo1FPA==
X-Google-Smtp-Source: AHgI3IacWoMx2C6GA9JGdnzrOu4wD0XFh5R2h3TaatyA83k1GT8RdTeU3Ws4qK1lIfu9pBD/5o4qTdNJaQfC8CK8ljo=
X-Received: by 2002:a19:5611:: with SMTP id k17mr1370735lfb.168.1550048541521;
 Wed, 13 Feb 2019 01:02:21 -0800 (PST)
MIME-Version: 1.0
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com> <f751539b-d844-9ab1-169b-ce6aa0056de6@metux.net>
In-Reply-To: <f751539b-d844-9ab1-169b-ce6aa0056de6@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Feb 2019 10:02:10 +0100
Message-ID: <CACRpkdbvY1FiqmBHj74x4H9XX8SZW7voTMfj5jq-as73_B071Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:46 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 08.02.19 15:25, Linus Walleij wrote:

> >> +/*>> + * struct amd_fch_gpio_reg - GPIO register definition>> + * @reg:
> register index>> + * @name: signal name>> + */>> +struct
> amd_fch_gpio_reg {>> +    int         reg;>> +    const char* name;>>
> +};> > Can't you put this in the driver file?
>
> I'm afraid, I can't. Because the board driver needs to tell the
> gpio driver which gpio's we actually have. This seems to be really
> board specific, and the register layout of the FCHs gpio bank seems
> to be not actually linear (or maybe the pin naming is just weird)
>
> What I really don't want is undocumented registers or lines being
> exposed as gpio somewhere (not knowing what they actually do).
> Therefore, I'd like to add only those gpio registers that I can
> confirm being safe - at least until I've managed to get more
> information.

What we normally do is expose all the lines from a gpio chip
as kernel abstraction.

This is because at least in theory this chip can be used by
several boards.

The chip abstraction does have facilities for masking off
unavailable lines: in struct gpio_chip there is .valid_mask
and even a callback .init_valid_mask() to set it up.

This is currently used on ACPI systems to mask off an
make unavailable lines that are handled by firmware/BIOS.

So this is what you should use to make existing lines
unavailable, do not try to hide them by not exposing
registers or line offsets. The abstraction should model
the hardware, not the usecase.

Imposing a restriction from a board is a new thing,
and would involve setting these masks somehow using
machine data from <linux/gpio/machine.h>,
I am sure we can figure something out if you absolutely
need this.

FYI there are tons of systems out there that expose a
whole range of GPIOs that the developer have no clue
where they are connected on the PCB, the most common
case is that they are not connected (sometimes not
even leaving the chip die) or go to test points. They are
very seldom dangerous, in fact I've never seen dangerous
GPIOs, just dangerous set-ups of pins already known
to be in use for something.

Yours,
Linus Walleij
