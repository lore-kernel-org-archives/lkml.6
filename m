Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B50C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4875121925
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSwFbA7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4875121925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeGCHd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:33:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42440 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933013AbeGCHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:33:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so829549wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w6tOV13Xru5Ia0IJy7+xEspAUzX0LXnI2FU6lGwoL+8=;
        b=YSwFbA7TV9wTDr/DW4jnsl5xFQ+W1B5iAU+VzM7U2yjMykFAwaWdP3WG+exSxgW59+
         y4PsTgWgj71dyy3SKIcijNj3ja5yZLrU3bjI6yu7NTzF2QKSl8UVv7JbSVnBoO2WwfHO
         09lTCVolMnuJHuGrxik5rhWVu7XC4HvjKW2OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w6tOV13Xru5Ia0IJy7+xEspAUzX0LXnI2FU6lGwoL+8=;
        b=BD8ll8BCEIrscC6wOWthroa0by+JPFUUifPH1gqjnyTWMQ2W5KFq0I65vSLoRH+i3D
         mrNQIoZ3xGqBHaMYnzja6mqgR8bIOABWrjDO3/Cna3hHyOvd4WH+HfCrUzhbAcnma7lz
         q/1lykAWegJJa1IxMiPPq64+5Ofkdqg/AE8sWb33earhjva0zsP5iIxhKbH8kDPi8sgg
         MDHH6OfqiuSy8jUnJ9GRf1acSVqpF/pW7h6LA1KiJads7EroXfAR0T0by5wdu4ltis39
         JivVatrZhz+mk+C5HRLY3tQ17618+Juqpf1giC5Y/nFbM15G3ZUgIMaSnHg/zVjcxwRU
         BsPQ==
X-Gm-Message-State: APt69E2mKmqYhkorLWLGgVgfG/wJ0AaCGdEligSjC92GzGtS1LKS1TIA
        7wjeEUu0gYX/wfPWomU4+xfwsg==
X-Google-Smtp-Source: AAOMgpeu9uA899qoaxnPu/ToC3FcSR5gIM7jSmXzNSAojsqkfxV0h9fKb7ty32az1uQrrrJxN34NBw==
X-Received: by 2002:adf:92a5:: with SMTP id 34-v6mr23250940wrn.83.1530603230444;
        Tue, 03 Jul 2018 00:33:50 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id y189-v6sm893421wmd.19.2018.07.03.00.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:33:49 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:33:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 23/27] devicetree: fix name of pinctrl-bindings.txt
Message-ID: <20180703073347.GG20176@dell>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <d04d47f9fba035cf9de8589a288964c636324d58.1528990947.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d04d47f9fba035cf9de8589a288964c636324d58.1528990947.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, Mauro Carvalho Chehab wrote:

> Rename:
> 	pinctrl-binding.txt -> pinctrl-bindings.txt
> 
> In order to match the current name of this file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt | 2 +-
>  Documentation/devicetree/bindings/mfd/as3722.txt              | 2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/mmc/microchip,sdhci-pic32.txt         | 2 +-
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt            | 2 +-
>  .../devicetree/bindings/pinctrl/pinctrl-max77620.txt          | 4 ++--
>  .../devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt          | 4 ++--
>  Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt   | 4 ++--
>  .../devicetree/bindings/serial/microchip,pic32-uart.txt       | 2 +-
>  Documentation/devicetree/bindings/spi/spi-st-ssc.txt          | 2 +-
>  9 files changed, 12 insertions(+), 12 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
