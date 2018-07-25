Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C04DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38C620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38C620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeGYQeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:34:15 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51872 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbeGYQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:34:15 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so937295itf.1;
        Wed, 25 Jul 2018 08:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUGZ8yQvdACe2ZxrMtgWCtHxkP603WoiUzJ1qHIXpvY=;
        b=Qg+VardcEdYKmNbcYY4RgRjd0+NIoatow1jGEo/RcTB5w0qmqPq4N/Hf2eP4qZoSaE
         BliCEAroqlP080uWeAQAXEofyYd2lmT4NQjrm72PCJRewgiJEbM7FVaHW85BsLCaH3nU
         z1Uci9ByFkJh1Y897FC+z1q3TcmBCSqvQoZYY21a4i2+BNl6MT943khPeaMjm15W6Sim
         hoYuigrIusyGW2wmOlRsmq3+jq14QXrMpC+2gxR2wBcwPiA3vKChc9BDUWzResu93W+N
         mqjpuZ9GgA4wgQDVk1AoARaVW7MfIX+iu1rGVNh14WdTozm3BhTkIoM5o+MEa81T6Uwm
         rUzA==
X-Gm-Message-State: AOUpUlGAQq8iA41jnDM8iGEmMDnm6hGZ7JRCJPbjvJkUMG6Qm1U0NxTo
        Kwyok9zds4ISa6BZ1ujeMp4RXZo=
X-Google-Smtp-Source: AAOMgpfBERNduaebSHhGkU6RDd/OglPPwcFWY+zzqYRU/xkD3PrLTJ5XAwxdVAPAPadsFNNwidgHRA==
X-Received: by 2002:a24:7941:: with SMTP id z62-v6mr6323443itc.20.1532532126594;
        Wed, 25 Jul 2018 08:22:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f195-v6sm2635184itf.41.2018.07.25.08.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 08:22:06 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:22:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 14/21] clk: jz4740: Add TCU clock
Message-ID: <20180725152205.GA6941@rob-hp-laptop>
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724231958.20659-15-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 01:19:51AM +0200, Paul Cercueil wrote:
> Add the missing TCU clock to the list of clocks supplied by the CGU for
> the JZ4740 SoC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/clk/ingenic/jz4740-cgu.c       | 6 ++++++
>  include/dt-bindings/clock/jz4740-cgu.h | 1 +
>  2 files changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
