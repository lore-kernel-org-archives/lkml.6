Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAACF21D69
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAACF21D69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755068AbeFZUTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:19:51 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43807 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754177AbeFZUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:19:47 -0400
Received: by mail-yw0-f196.google.com with SMTP id r19-v6so6532346ywc.10;
        Tue, 26 Jun 2018 13:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sEs8xYQqaOmmEu9IKPYDXtH4HFrJC1G3e+oD+2L+L/4=;
        b=Naf1UVQCmbfcX+0c1fvlBPpZJruxjK3yGRweNR/90fDmNc1/r3ysNUFdMCYKkvNaAQ
         MBzSoD/7GIitW7eGe1+XlL8uUe4htJsoZYpCmHal1mssiFkGuJuUMcyPkZekWRqCgqi7
         UJfWJ/phjup8HyzELmHhuE4+jdrkIma04lMNTSViAaYvo/nnmMcwR1VK8e3V9JeTkviF
         4LeFpeoYzzdg8BUUztr3LS/UD1obAXD4tPeAY8AwuzdiE44Kfgw4ICRiL1KaqHMMMIeq
         wR4CFv/PXuu2J8Mm2fwEL1JslAhCjpWbs4zSguTOt8GQWc37pGHxJdvq5c4p4QMA9tOj
         1hSw==
X-Gm-Message-State: APt69E19RPS1DLwAwyKp+SePxaZ4W/70ec1M7k14/jUwHAA5z9ZPJl4V
        KYH+fmS348Ainu2prELX8g==
X-Google-Smtp-Source: AAOMgpfovofvozXKjQrtR+6W/wFDBC37fbSObvademvSjcDZPlQhcokgfS45A9ZUOWsNONw2hQJ4Mg==
X-Received: by 2002:a0d:fb81:: with SMTP id l123-v6mr1590462ywf.47.1530044386010;
        Tue, 26 Jun 2018 13:19:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d203-v6sm936351ywe.5.2018.06.26.13.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:19:45 -0700 (PDT)
Date:   Tue, 26 Jun 2018 14:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anthony Kim <anthony.kim@hideep.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
Message-ID: <20180626201944.GA24678@rob-hp-laptop>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 04:31:18PM +0200, Jonathan Neuschäfer wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> Should I split this patch so that different parts can go through different trees?

No, I applied it. Thanks.

> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.txt          | 2 +-
>  .../devicetree/bindings/gpio/nintendo,hollywood-gpio.txt        | 2 +-
>  Documentation/devicetree/bindings/input/touchscreen/hideep.txt  | 2 +-
>  .../bindings/interrupt-controller/nvidia,tegra20-ictlr.txt      | 2 +-
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt  | 2 +-
>  Documentation/devicetree/bindings/mips/brcm/soc.txt             | 2 +-
>  Documentation/devicetree/bindings/net/fsl-fman.txt              | 2 +-
>  Documentation/devicetree/bindings/power/power_domain.txt        | 2 +-
>  Documentation/devicetree/bindings/regulator/tps65090.txt        | 2 +-
>  Documentation/devicetree/bindings/reset/st,sti-softreset.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8096.txt        | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
