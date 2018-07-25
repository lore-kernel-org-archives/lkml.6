Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3056C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67BE20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67BE20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeGYSwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:52:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54822 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbeGYSwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:52:12 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so9848320itb.4;
        Wed, 25 Jul 2018 10:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n057FR7GqMfsgAiyBsMQA+aX/NItQQR2Pbi8cPuqOdM=;
        b=aaCDCJMKl0LrN8p9FBhvDu46uUuIrcPe+a2GsGaCDLiR45JmDVSIOe4pCeBQxKAzQW
         UMX1RFeM+yy3WrriTNDCY9zOgQSmUnKKAtAN+CRpzJjRgeUzEsBRNUgD9YBbnJGNAWKp
         XUsWYIEkzIlPp8ugNBdjSY+wpbn24NBUhHUa1OC7NiVe18cGuIImjn4cN3DUFJ2Fzeu7
         ++5agKAKUdQNxbP2emGi/xa932mRPxZLU/I40yJu2JuqCSwNMb9TxkN2XzPO6pWMloOg
         /ejlZFZKhUVNni0d2brGf5X5e5e6hUlVqZtxVJuFIIh7Fxyug0Gi5FRnQ1hnJ2HmMvN6
         YCZg==
X-Gm-Message-State: AOUpUlEvQfrgt43APOfTKCJTZmpBqqY2BRBS3n55AlvuMPYAMvW0HEeu
        oEIHH1q8C1TZqM/sqPKneg==
X-Google-Smtp-Source: AAOMgpeG4pSY78HmblXPhez3Dr3ejlAjYCAcyZCJsugtymXdo6kxOYTNr2e9T8IOX6tMqYiBTrN0nA==
X-Received: by 2002:a24:7414:: with SMTP id o20-v6mr7137375itc.116.1532540371845;
        Wed, 25 Jul 2018 10:39:31 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id d134-v6sm4592558iog.84.2018.07.25.10.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:39:31 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:39:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [RFT v2 04/10] pinctrl: samsung: Add dedicated compatible for
 S5Pv210 wakeup interrupts
Message-ID: <20180725173930.GA27860@rob-hp-laptop>
References: <20180723175302.22535-1-krzk@kernel.org>
 <20180723175302.22535-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723175302.22535-5-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 07:52:56PM +0200, Krzysztof Kozlowski wrote:
> The S5Pv210 external wakeup interrupts differ from Exynos therefore
> separate compatible is needed.  Duplicate existing flavor specific data
> from exynos4210_wkup_irq_chip and add new compatible for S5Pv210.
> At this point this new compatible does not bring anything new and works
> exactly as existing "samsung,exynos4210-wakeup-eint".
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  .../devicetree/bindings/pinctrl/samsung-pinctrl.txt    |  2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/samsung/pinctrl-exynos.c               | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
