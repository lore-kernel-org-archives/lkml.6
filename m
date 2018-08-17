Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B7DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CB4208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CB4208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeHQSNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:13:44 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34750 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeHQSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:13:43 -0400
Received: by mail-io0-f194.google.com with SMTP id c22-v6so1038735iob.1;
        Fri, 17 Aug 2018 08:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yy1cmmcUL9OIbByBl3BjCGsuWy+927JFu49enswaX10=;
        b=TL98JnXtgECl91QHGsa3Myq8uehjrxT59U2/bSZiTn1iin28XRixVNx3jZwBIp5J6C
         nVtuAhiTtq66iLPXB9O3o7Ut8SEDXVydYXKqeVxXbM1dKVedkTEQLpW7cLEZwR8r9Z67
         w7AWRfiYvpobap09ZZU0Am4+1mokPEANYhFKt6yqUlouzyKJjg/2QV5LPMJ9q2QddOMu
         sUuto8xv3YUnU1cX6M3DyTAOpNltqaS/wuXVfMUmoFezDeCRbPQivfKc3fBmyz9wlodz
         Z0yErszX4HJ2yB3Tnaa8VNxKEArxL9PAjQYSNRSmm5ZeDMGRkZluyUPcW443L0Ef99rf
         Q5LA==
X-Gm-Message-State: AOUpUlFrzAISKSC7KD1OSr2kgEwLEz8TVf92jYnA+uardoXgmRUhE1LZ
        UNJuqaE7KPrGkwY1SOMTHiRZVmg=
X-Google-Smtp-Source: AA+uWPyyIbuAYiU9TgIY2vq+OjaDxuXZibj9FuwGtVRZB6+Vx92bXVDPZfgEBiX085TXWWbEszsVLw==
X-Received: by 2002:a6b:f80e:: with SMTP id o14-v6mr11989889ioh.139.1534518598944;
        Fri, 17 Aug 2018 08:09:58 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id q68-v6sm1990888itb.23.2018.08.17.08.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:09:58 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:09:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 7/7] gpio: ingenic: Remove driver
Message-ID: <20180817150957.GE20845@rob-hp-laptop>
References: <20180816163544.9072-1-paul@crapouillou.net>
 <20180816163544.9072-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816163544.9072-7-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Thu, 16 Aug 2018 18:35:44 +0200, Paul Cercueil wrote:
> The pinctrl-ingenic driver is now handling the GPIO chips directly.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  .../devicetree/bindings/gpio/ingenic,gpio.txt      |  46 ---
>  drivers/gpio/Kconfig                               |  11 -
>  drivers/gpio/Makefile                              |   1 -
>  drivers/gpio/gpio-ingenic.c                        | 392 ---------------------
>  4 files changed, 450 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>  delete mode 100644 drivers/gpio/gpio-ingenic.c
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
