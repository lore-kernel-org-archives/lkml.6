Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42170C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF53E25FFC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr+9OOim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF53E25FFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965795AbeF0Qqs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:46:48 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:55466 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965137AbeF0Qqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:46:46 -0400
Received: by mail-it0-f53.google.com with SMTP id 16-v6so8504834itl.5;
        Wed, 27 Jun 2018 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEsid6e0oeVFtxzwOI+qxSTUI5G3DZYKZg8YaYtU0do=;
        b=Dr+9OOimXMy9DfQf/dVd/3pZEhHdgl3+x9WsUfnT5Y1i68+ugS6QVQN+UAatCDYPCW
         j2ZJtUYcM7zrmWbWNy7qxrPMD4JjZ1UmkWGGzHIc9ubk1NCtnlJ1yGdi7bc+Kx6pmwWX
         zdqdSW43pguGCCx+j0V+HrLZzkr19hxX7h1G01ZnvzfjaFbcIhiXTvsb4WKgVRhuBlwj
         ESyXBHrxQ0KaQZiVmRtQHqOHpPIl5ZMzgBR9rREuIaOyyBCcM7jACtC3r30fEtBnzmZa
         YZxB8ZAZVMlWWd0jdtCmTQ6fGm45lS85oxwY2DyZIGgsRVorLt2f5KxOPAME7i9FQ9OJ
         1Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEsid6e0oeVFtxzwOI+qxSTUI5G3DZYKZg8YaYtU0do=;
        b=XKJH2BQar8OJFivOU1EJ01/A7KJ0sXTWljrm+79egMLPxIXISdISPk7OG8TswsbUFv
         0b1LRytzsMeVqWTrFQWD4reoKRrU8Sda+04rxjo95fPGuIKqN7O/IWH3NLx3BmZaWkXd
         9ge/FwHfFzJmXwxBk6h5hjjXYUFtGE6DRvdMlvuyOrRpo14dbb2lOPX1+y257QHDObST
         WqGHOa5IK4QaLF1BRwPIYnpC7gUuynaiuzdBrgKJI9smmNXNszk+gNeVDMF5ECc7+VRm
         ubv0OWzcdKPmO8Dr7CPJfVVtui7hO3ilHvFOWoAed8uRxbXA+A6AjehU+sO1mBszx6AH
         Gpmg==
X-Gm-Message-State: APt69E1jAext9NuDwCW31c5L2IrbAAh0lCsRbwRgRrK3GLKq4bIgi7yH
        v0/8R26AsSzBcBEvCHR5KWtfCSYn8z5pjpn3v5M=
X-Google-Smtp-Source: ADUXVKIJzriyU5enRVm+ZPjUpQRgBijxjO94nOq79zsgDr60FHs5k3B3bnBNcA3uFhv+EeGzDcjYL/Eo2ndeseZRRZQ=
X-Received: by 2002:a24:1448:: with SMTP id 69-v6mr5489386itg.143.1530118005536;
 Wed, 27 Jun 2018 09:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
 <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
In-Reply-To: <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 27 Jun 2018 09:46:34 -0700
Message-ID: <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
Subject: Re: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
To:     nikita.yoush@yandex.ru
Cc:     Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita:

Since you are mostly arguing against the suggestions I made to Andrey
Gusakov in off-list review, I'll respond.

On Wed, Jun 27, 2018 at 12:11 AM Nikita Yushchenko
<nikita.yoush@yandex.ru> wrote:
>
> > +     i2c_gpio: i2c-gpio {
> > +             compatible = "i2c-gpio";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_swi2c>;
> > +             i2c-gpio,delay-us = <50>;
> > +             status = "okay";
> > +
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +     };
>
> You add i2c-gpio node to dtsi file without defining gpios, with reference
> to pinctrl not defined inside your dtsi file or it's includes, and without
> any usage inside dtsi file.
>
> Saving several text lines that way is a bad idea.

There are three boards that share that configuration almost to a T,
with the only difference is the particular GPIOs used. Putting it into
a common file avoids repeating the boilerplate and makes it explicit
to the reader that those settings are shared.

> Please move it to where it is fully defined and used.
>

We are now starting to give Andrey Gusakov conflicting
recommendations. For the sake of moving forward, can we agree that
this and similar comments are relatively minor and defer to the
maintainers to make a call which way to go?
This way Andrey has a clear way on how to move forward with this set.

> > +&usb_vbus {
> > +     regulator-always-on;
>
> usb_vbus is regilator-fixed, what for is this?
>
> > +&uart2 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_uart2>;
> > +     status = "okay";
> > +};
>
> In your further patches you include this and then revert by marking &uart2 as
> disabled. Better to enable it in dts for boards that have it.
>

There are at least two boards that use that UART2 as is. Same as above
this was done to reduce boilerplate.

> Same with ecspi2, ipu and maybe more.
>

Ditto.

> > -     flash@1 {
> > -             #address-cells = <1>;
> > -             #size-cells = <1>;
> > -             compatible = "atmel,at45db642d", "atmel,at45", "atmel,dataflash";
> > -             spi-max-frequency = <25000000>;
> > -             reg = <1>;
> > -     };
>
> > +     flash@1 {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             compatible = "atmel,at45", "atmel,dataflash";
> > +             spi-max-frequency = <25000000>;
> > +             reg = <1>;
> > +     };
>
> Lost a compatible key?
>
> > -                     sysled0@3 {
> > -                             reg = <3>;
> > -                             label = "system:green:status";
> > -                             linux,default-trigger = "default-on";
> > -                     };
>
> > +                     sysled3: led3@3 {
> > +                             reg = <3>;
> > +                             label = "system:red:power";
> > +                             linux,default-trigger = "default-on";
> > +                     };
>
> > +&sysled3 {
> > +     label = "system:green:status";
>
> What for this label games?

Same as above. Avoiding unnecessary repetitions.

Thanks,
Andrey Smirnov
