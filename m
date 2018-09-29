Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9226AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0102088F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0102088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeI2OWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:22:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41817 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeI2OWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:22:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id e128-v6so4883025vsc.8;
        Sat, 29 Sep 2018 00:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3ESr2xI28NP1aemcmYN65QISZL1RvT0IOKEwjQoj2Q=;
        b=bRuAbUCdi3vwij8u09Xr7AiLPGE2+0PDpgDfqK3EAvqS1zXyLko2+jUJy4kHjHx/FA
         0Jk58ZzZkvAgIfY9ieCrP5a06Wx8rUNZTLBu/SqMDMSwdIsKV8cuHz6q9GW6dUHo8r/+
         kgdENs7owt5sHGoS5dkAK7pYP3Feqj4mjPc+7x/zHdR8yg3LvEOHH8GAMDqHQ9w9nOCA
         RNNxFVx11tLM+6JFp5J5PUAJ6FLEih+PC5AnsyS0l2+hr1gmxwW2NfK5pREjAt2ncpaS
         WhdjuglH+JKTTPZL5kdu2fBfVsl6oPp2axcxkysn+vNCqdlHs22CTbGNlaagrfVTp9mV
         w/ZQ==
X-Gm-Message-State: ABuFfoht93ICPsl50V4Xz7okcaXB49L+xDnlJU1AICKjGgVE6nHciFUT
        tTvTvBsW47XqUOudZ8Ldo9HuHB9bS4ViusVCa9w=
X-Google-Smtp-Source: ACcGV62uUsMFWfuXzgg1xCyQ4d1hZ1EWb6uiPKJF0b0jHNvyNVvq4Ijybx7ejx0qwqJuJiHOzMIXLW9x/yE/wFcXiMo=
X-Received: by 2002:a67:6582:: with SMTP id z124-v6mr734814vsb.11.1538207720462;
 Sat, 29 Sep 2018 00:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180928223947.20751-1-f.fainelli@gmail.com>
In-Reply-To: <20180928223947.20751-1-f.fainelli@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 29 Sep 2018 09:55:08 +0200
Message-ID: <CAMuHMdVgpf2b8gOeygij7MGjTwxgBv8-Y0M5ggBBhNE0pS07pA@mail.gmail.com>
Subject: Re: [PATCH] i2c: brcmstb: Allow enabling the driver on DSL SoCs
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        kramasub@codeaurora.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        eajames@linux.vnet.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        manivannan.sadhasivam@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Sat, Sep 29, 2018 at 12:40 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
> same controller, make it possible to select the STB driver and update
> the Kconfig and help text a bit.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for your patch!

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -432,12 +432,13 @@ config I2C_BCM_KONA
>           If you do not need KONA I2C interface, say N.
>
>  config I2C_BRCMSTB
> -       tristate "BRCM Settop I2C controller"
> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> +       tristate "BRCM Settop/DSL I2C controller"
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST || \
> +                  ARCH_BCM_63XX

I think it would be good to keep the "|| COMPILE_TEST" as the last dependency.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
