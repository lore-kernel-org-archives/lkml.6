Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A912C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A8214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5A8214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeIZRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:55:22 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43636 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeIZRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:55:22 -0400
Received: by mail-vs1-f67.google.com with SMTP id y22-v6so2158747vsj.10;
        Wed, 26 Sep 2018 04:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8a2SWnZ9HIWRRCASC+WZvA4QSgGVs+4CVDnVzA5Asg=;
        b=JF/C/OY0TMP6p7mTfP4mRG7fYtx5512tGPraJ37trv6kmzHnVd7LamgaYCTKcCHwOa
         C4Q1KXzhcml7oPFB5ryo80CMZVyAZYvhuADjx+l1hjmUpsTZZTY0EwrgLy2VETsMeHRy
         9nLjkvfATgQkQQmWesljA5NZn0ajxtJcznMsomaDx23fyHr//HxkGzU1+ZqAUdL1S13C
         WcbxUs+Rw8bmdfbbG5jSxg0bo7nKRebL2nEmVQwmxmmVza3GLNZZHQ8mNgejjQiS9F+h
         9At7p3+AbD/NV1xmL5MVX3YjsuVIgqphAc2SRbVgrzgLOyD9oOCtG9oGp6W6I0Vh/BmE
         9c/w==
X-Gm-Message-State: ABuFfojCvMDXy5IgCjq1grL4bxopNHhvZ7yFsv62o6s5eocZiaQxanoO
        /cdkzQH8NMw3QU38SSLlQGvN10fd4rmAiigQ5EI=
X-Google-Smtp-Source: ACcGV61UM1YEjWpxjC7BYl6XIQbGgijECvFWGR37rBBAYMRYMPitmppC7ncHBur5x65EYuEUkQC+G4ND6xwkKk7kBlE=
X-Received: by 2002:a67:f785:: with SMTP id j5-v6mr1336663vso.96.1537962167296;
 Wed, 26 Sep 2018 04:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180926091053.21255-1-phil.edworthy@renesas.com>
In-Reply-To: <20180926091053.21255-1-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Sep 2018 13:42:35 +0200
Message-ID: <CAMuHMdWu-GWBompRMwbweOw-N2AOUtpGdAnO8JGbRAvy=Q9j=g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Renesas R9A06G032 PINCTRL Driver
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Wed, Sep 26, 2018 at 11:11 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> This implements the pinctrl driver for the RZ/N1 family of devices, including
> the R9A06G032 (RZ/N1D) device.
>
> This series was originally written by Michel Pollet whilst at Renesas, and I
> have taken over this work.
>
> Main changes:
> v5:
>  - Address Jacopo's further comments
>  - Address Geert's comments
>
> v4:
>  - Address Jacopo's comments
>  - Add alternative way to use the pinmux prop.
>  - Remove mention of gpios.
>  - Implement pin_config_group_get()
>  - Fix function to get pin configs, i.e. return -EINVAL when disabled.
>
> v3:
>  - Use standard DT props instead of proprietary ones.
>  - Replace virtual pins used for MDIO muxing with extra funcs.
>  - Use pinctrl_utils funcs to handle the maps.
>  - Remove the dbg functions to keep things simple.
>  - Change the way the functions are defined so it is easy to check
>    against the hardware numbering.
>
> v2:
>  - Change to generic rzn1 family driver, instead of device specific.
>  - Review comments fixed.
>  - Fix error handling during probe
>
> Phil Edworthy (3):
>   dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
>   pinctrl: renesas: Renesas RZ/N1 pinctrl driver
>   ARM: dts: r9a06g032: Add pinctrl node

Thanks, will apply the first two patches to sh-pfc-for-v4.2.0.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
