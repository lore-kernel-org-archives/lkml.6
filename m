Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sgSyGeV0HlsoFAAAmS7hNA
	; Mon, 11 Jun 2018 13:11:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9B0B9607E4; Mon, 11 Jun 2018 13:11:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSJA9cUi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 04734601C3;
	Mon, 11 Jun 2018 13:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04734601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeFKNLU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:11:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39459 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFKNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:11:16 -0400
Received: by mail-it0-f66.google.com with SMTP id p185-v6so10797431itp.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eYZlrUF/pnSTAI6/KINBFuxtfAfPBvPKaN9O9UZcImA=;
        b=JSJA9cUi0L5503vqc7zu6mrxFmDEBxOB1glXLvI+pOEhnqiSXxS+SVir8TuPyWxZVt
         coh5Z745LMs3Ue6GZ2As/iaEm81+IfZkQF3RJJNfYAfce2tEciOv9FC6Y+9PZgwX57XM
         qdpI7yGk1FlKBJhJPYLa/1/jL7OmlegZxMeBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eYZlrUF/pnSTAI6/KINBFuxtfAfPBvPKaN9O9UZcImA=;
        b=E6UH+IbdvHgZtSnvdjyx1lxdL40iNY/A6RVMDz4BHeNIc4sFgsk6NY33LFTZ8k5pVQ
         nApKpVXs7PYy51j3sNS6l7UwcnQ/kPJpl7Sfh5NhJm86IGH4UAG0G+sPCloGdTh66G21
         GQ8G6Ja0MieedTX/tEEQP5Bt4fsWPYX2666CWP37rKpssVjbPW7Aan5DzQSiiUGdewU3
         8P8TBWDACapW2JhHZk+1bbJE7VQslXaofwJvp5n1Yd6Othwz3i0C8OQUHh/Cb1HvQK0j
         /IAJl8raRBAG9tCfPwv1wlG5lweSqO5rIpvPRZSQTsIu2dXA3Ekoh+f3/0MS/2cvZJH8
         RhQA==
X-Gm-Message-State: APt69E3M4dWahoC77oVa/x5pM5XFPBThkQvVehWPL2GSVNvRielL7bHM
        uv1LKxMQaHPe5jrQpLFqNXrbyQgAUSW4+NwLrZOYbw==
X-Google-Smtp-Source: ADUXVKKvcGYgZkTSKh8RUAYPg8+VJHmVDVhsVG86cvfP0hmUZnOPui/tLxYuwYaHIiOeFXeL2WWOk66OtUxyIZ5o/Vo=
X-Received: by 2002:a24:690f:: with SMTP id e15-v6mr10199738itc.70.1528722675963;
 Mon, 11 Jun 2018 06:11:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 06:11:14
 -0700 (PDT)
In-Reply-To: <20180601093511.GA11734@ulmo>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-2-linus.walleij@linaro.org> <20180601093511.GA11734@ulmo>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 11 Jun 2018 15:11:14 +0200
Message-ID: <CACRpkdZEMPfxHc8dZOvyYN+S4o_zwKuYCTBbMiXMLsCZRz_f6A@mail.gmail.com>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO descriptor only
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 11:35 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, May 14, 2018 at 10:06:22AM +0200, Linus Walleij wrote:

>> As we augmented the regulator core to accept a GPIO descriptor instead
>> of a GPIO number, we can augment the fixed GPIO regulator to look up
>> and pass that descriptor directly from device tree or board GPIO
>> descriptor look up tables.
(...)
> This causes an HDMI display regression on Jetson TK1. From what I can
> tell, the problem is that we now get a double-inversion for low-active
> GPIOs. For example, we have this in the Jetson TK1 device tree:
>
>                 vdd_hdmi_pll: regulator@11 {
>                         compatible = "regulator-fixed";
>                         reg = <11>;
>                         regulator-name = "+1.05V_RUN_AVDD_HDMI_PLL";
>                         regulator-min-microvolt = <1050000>;
>                         regulator-max-microvolt = <1050000>;
>                         gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_LOW>;
>                         vin-supply = <&vdd_1v05_run>;
>                 };
>
> We've got GPIO_ACTIVE_LOW for the regulator's enable GPIO and since we
> don't have enable-active-high, the regulator core will treat the GPIO as
> low active. The presence of the GPIO_ACTIVE_LOW flag will cause the GPIO
> polarity to be inversed, transparently in gpiolib, and the lack of the
> enable-active-high property causes the GPIO polarity to inversed as
> well, so we effectively end up with a high-active enable GPIO for one
> which should really be low-active.

I dug into this. It turns out there are some layers of mess....

The DT binding for "regulator-fixed" specifies that enable-active-high
should be set for polarity inversion. For historical reasons, I guess,
we screwed up. The example in the binding uses that.

I interpreted the binding such that also specifying GPIO_ACTIVE_LOW
was essentially illegal, so I patched gpiolib in commit
a603a2b8d86ee93ee2107da8ca75fd854fd4ff32
"gpio: of: Add special quirk to parse regulator flags"
so it looks like that:

+       if (IS_ENABLED(CONFIG_REGULATOR) &&
+           (of_device_is_compatible(np, "reg-fixed-voltage") ||
+            of_device_is_compatible(np, "regulator-gpio"))) {
+               /*
+                * The regulator GPIO handles are specified such that the
+                * presence or absence of "enable-active-high" solely controls
+                * the polarity of the GPIO line. Any phandle flags must
+                * be actively ignored.
+                */
+               if (*flags & OF_GPIO_ACTIVE_LOW) {
+                       pr_warn("%s GPIO handle specifies active low -
ignored\n",
+                               of_node_full_name(np));
+                       *flags &= ~OF_GPIO_ACTIVE_LOW;
+               }
+               if (!of_property_read_bool(np, "enable-active-high"))
+                       *flags |= OF_GPIO_ACTIVE_LOW;
+       }

This means no matter if you specify active low, the GPIO
will be treated as active low, as this is the default behaviour.
We will warn if things are overspecified as active low on the
flag as well.

The second clause (notice nagation!) specifies that
if enable-acive-high flag is NOT specified, we will be active
low.

Sadly this only handled the undocumented fixed
regulator binding "reg-fixed-voltage". So I need to fix it
for "regulator-fixed" as well, and then it "should work".

I will follow up with a patch.

Yours,
Linus Walleij
