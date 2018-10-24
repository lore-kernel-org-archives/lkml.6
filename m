Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC9C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6682082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6682082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeJXWYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:24:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37032 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXWYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:24:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so4127511oib.4;
        Wed, 24 Oct 2018 06:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nY2TGgNHrBcJVwcbT8yBBXw3agKmjMSEoy9OPBO8Yg8=;
        b=noHJaL2ZgOcHZjhZrJIaNmKx8kyE3a32m6Dk5wvDTyppPp3x6iPYrVfJKKrQ2++M1D
         b8sB1d+MUP9uFitBmUhTYFzD35uW4IU2F7sdcnm0db76sTLQ4gZuVEvNFQGMjaxxz/6m
         nHPCj1wlxUO/PhxcSGy8M3lLJm24QyPlzJZQdVyhGiJIWrCWh0wGDhAU0h4hZMJ8jFN6
         UgaYTvjHIb3p56jeiBeIgpIa3kjdhwJ4EZW8ZZZrMHvwT10qSoy76Wm4IfXXG2N1K0rF
         nJ/jq5Le6P1/T+0xHE5JmDQ++ocFaS94/kGnBZRA+jAjFJN+BfiPUyaces/f4OwtZHOw
         B63Q==
X-Gm-Message-State: AGRZ1gJVHDsVnL2SEE7/xoJOdSXrQLMLf6grLKP9MReMJF9tJ5KPuHxw
        pWws3u9RwuSsIotlgTsE/cS1KS8=
X-Google-Smtp-Source: AJdET5c0TFrweTeLjXfCKcXnfudiLoVwKCiAMNidfPcarIP45mN5V1d2mWl7AVzuNaXxehoPKEn8Zw==
X-Received: by 2002:aca:efd6:: with SMTP id n205-v6mr1379843oih.3.1540389394703;
        Wed, 24 Oct 2018 06:56:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r17sm1770645otb.65.2018.10.24.06.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 06:56:34 -0700 (PDT)
Date:   Wed, 24 Oct 2018 08:56:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Message-ID: <20181024135633.GA342@bogus>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-5-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023185330.10472-5-oskari@lemmela.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> The AXP803 ADC is compatible with AXP813 ADC, but add
> specific compatible for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
