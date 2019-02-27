Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D477C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19BF20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NITrRMNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfB0NzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:55:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39656 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfB0NzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:55:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id o6so19207101qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqQ9G7jn8vIEoJWzmCjzWXCoLqsvFZiFGobGFntymRI=;
        b=NITrRMNoHTELuOT/tEauYhW+4IXCunovN9k65RYed2lkKwtRE6VfRTINaj9loaImDL
         FWjt+d5/gXLaEgJb6y/IBLA8gwxli/ewXfcfzkkGJBVvJAv+stsO/AjkhSaDJdqJPqoi
         gdQ654mOftRNztralf0F8aoaYwyMvlNPf4B7y6iuI7oGM0MfXM0Z7bAE2HcnH5ehCqJI
         oC6sR7Xx/Sv1Dybg818BpdRrU+wmZlS/wgx9VOKLcA/WN6GsHRKKXzmrXOD+MKqw2RfA
         VJDKBmY1FtorlKBksC6w9uIMy5rF3FB9T1+VhrfBopzqM1lCReGeSsPfjXQJ73gjrD85
         T8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqQ9G7jn8vIEoJWzmCjzWXCoLqsvFZiFGobGFntymRI=;
        b=F/OnAxqE4XY1AJoFKxcV8oh8JO66g3a+4SYtye3LWOZLUxopeTbE36D6FOAfU9fLlX
         sJdHUclS0SCRVG9a4v/wfJiKM2hdf6FKTM3oFB2Jk4rDp0CNnJvaqpDKIIxcGVPfd4R2
         23fxplQSl4tl73FMpl63Lg4GsavdIgZcqQ1RrO3DNpBtJiOWmbRP9JZHObHkwN+2CLqk
         eIxsHkjwqwHWCPdwqWKtP5zSVCy3mzY6jDs9Lil+xNDew1Ofw3CiVit3GDgA3k4dYRYO
         WSlRI27CdG8y1b1RZiD0eICkO8ZLN/GhM372gx6r08vjG9Ua19L5q8FKDngqBIBh5yon
         8vWA==
X-Gm-Message-State: APjAAAU/1ui1Ftn9CHI+Ghs6jNNGWJFDcAqtWiK5boJ9cK8YK9u5huv3
        zBPm9geYaX4wgkslxk7gJXI8o3/kqrQF2RpTtOmvIw==
X-Google-Smtp-Source: AHgI3IYSepXwyGn/S/pgu6u/5JTFssQ3M8yskc53xOPLC+OiqGXqsb1pMbTx0EbTFXQjaF0zTvU5dH+AxgwUaa7h+C0=
X-Received: by 2002:ac8:26a7:: with SMTP id 36mr1789611qto.234.1551275716476;
 Wed, 27 Feb 2019 05:55:16 -0800 (PST)
MIME-Version: 1.0
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com> <1551260094-32570-5-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1551260094-32570-5-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Feb 2019 14:55:00 +0100
Message-ID: <CACRpkdaa4K3uoo7mXkLqjqbmP4qHfrbmqQuqc2fDCE3D=s_2Dw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
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

On Wed, Feb 27, 2019 at 10:35 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This patch adds pinctrl/GPIO driver for STMicroelectronics
> Multi-Function eXpander (STMFX) GPIO expander.
> STMFX is an I2C slave controller, offering up to 24 GPIOs.
> The driver relies on generic pin config interface to configure the GPIOs.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I assume Lee will merge the whole patch set through the MFD
tree.

Yours,
Linus Walleij
