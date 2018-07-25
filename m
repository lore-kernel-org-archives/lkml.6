Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EB320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EB320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbeGYSvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:51:07 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36747 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbeGYSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:51:06 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so9796392itp.1;
        Wed, 25 Jul 2018 10:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ZYNMraE45yoayfKYmMKBMwB0niswFTtF5Y8itzeSi0=;
        b=Ji5RD48Ll/rx0HGpEEwAnyQpwsYX98DheTPGFtHoRXhHwm0hrObblbXD6lOfR1LB1A
         A6rmAC4Ss4ZkYZaxrH/tYjHzM+xnQXCcoBoM6tEBl6ENMGJ8l1NlV1yWBYRaJmQQyw92
         0uEQXnyp3iXpBYZmYDjWu1Cnt5OLXRVIOATfqbxJF1839crdT80BX/iOv0+NkMItCncQ
         b4X2i//iRduHsFv672Dnhy4BFprvC85YRCbEVKlW/1nxRSRYPsIY/gT5J86bWZR7dp8e
         mhqQIepPVM11dnv6+883rOHeYC/VNpr9xDqIe85LEumvoWj/oSgGIWSDtG1I7/S78LGQ
         IUtA==
X-Gm-Message-State: AOUpUlHqbk10DTc81Vm8NvUNUdcqIoemR/DNE5CCfQQa9FxgvrArpE/C
        +478br4tdOibpe9Wy+I8PQ==
X-Google-Smtp-Source: AAOMgpdv8lSSZUcYvXXakDTlYd0rPLHtfUckWMVeY1osoOY9FM+ZcaYKwwy1gZhMyG5/ub05B6BZAw==
X-Received: by 2002:a02:3f25:: with SMTP id d37-v6mr19614972jaa.109.1532540305155;
        Wed, 25 Jul 2018 10:38:25 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v82-v6sm1502735iod.14.2018.07.25.10.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:38:24 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:38:23 -0600
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
Subject: Re: [RFT v2 03/10] pinctrl: samsung: Document hidden requirement
 about one external wakeup
Message-ID: <20180725173823.GA25530@rob-hp-laptop>
References: <20180723175302.22535-1-krzk@kernel.org>
 <20180723175302.22535-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723175302.22535-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 07:52:55PM +0200, Krzysztof Kozlowski wrote:
> Hardware (S5Pv210 and all Exynos SoCs) provides only 32 external
> interrupts which can wakeup device from deep sleep modes.  On S5Pv210
> these are gph0-gph3.  On all Exynos designs these are gpx0-gpx3.
> There is only one 32-bit register for controlling the external wakeup
> interrupt mask (masking and unmasking waking capability of these
> interrupts).
> 
> This lead to implementation in pinctrl driver and machine code which was
> using static memory for storing the mask value and not caring about
> multiple devices of pin controller... because only one pin controller
> device will be handling this.
> 
> Since each pin controller node in Device Tree maps onto one device, this
> corresponds to hidden assumption in parsing the Device Tree: external
> wakeup interrupts can be defined only once.  Make this assumption an
> explicit requirement.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
