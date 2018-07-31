Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB7EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B1420841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B1420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbeGaVSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:18:35 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40963 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeGaVSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:18:35 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so14053350ioj.8;
        Tue, 31 Jul 2018 12:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zjeh5tWvnSSWR7N9TwVVW/KeD+Dn+8LoWNgWxVgOLrk=;
        b=H/Jclz7Pi9mrFG87iyKh3AUorUVrexYg329CCSO0frna++k3kM57JWBE2IWP7FIPWW
         US1cO35hKdWySd9UUOjtK3Acf2iVr2kiGU/NT07/3cQzzPzAXaYCL09pMxBkJNlo1UXH
         FF0xMbzg9npG2Qczbx7jujWdj8/Hxs7Y4Q1D+aqvPZ3dDZxwFoqair8zP+MWM3HCyqMS
         USdelmf6/5FaJ2PebN9ZFTI9TRm8nHE9T5D9brYemk9m4ULgVq5ZeiTTlZoLC6AQKy3L
         iVFoEu9LM+lr2xUVG6MYTC8NL+FRUi5rYNatf1OO19e09/cRwHQg+J0Uei/0kZsK+VZx
         oN/Q==
X-Gm-Message-State: AOUpUlGoTmwQa4rbACyC/RKuKY/ocvdy7HRDBCeljrlLXhdU1GgewkRN
        Rk1yQ7L63IK/WMwOVlS5XQ==
X-Google-Smtp-Source: AAOMgpeHnPZJLesZpZ3QnCB0TsdCjoFvesjEwSP/zu+Xd6KHSyFImInAYKShRwz3dZxYO9Hgvt5qoA==
X-Received: by 2002:a6b:8f4e:: with SMTP id r75-v6mr968736iod.252.1533065806143;
        Tue, 31 Jul 2018 12:36:46 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b90-v6sm2009837itd.18.2018.07.31.12.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:36:45 -0700 (PDT)
Date:   Tue, 31 Jul 2018 13:36:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     djw@t-chip.com.cn
Cc:     linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] gpio: syscon: rockchip: add GRF GPIO support for
 rk3328
Message-ID: <20180731193644.GA10459@rob-hp-laptop>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
 <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:59:19PM +0800, djw@t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
> mute control, can also be used for general purpose. It is manipulated by
> the GRF_SOC_CON10 register in GRF. Aside from the GPIO_MUTE pin, the HDMI
> pins can also be set in the same way.
> 
> Currently this GRF GPIO controller only supports the mute pin. If needed
> in the future, the HDMI pins support can also be added.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
> Changes in v4:
> - Rename the GPIO binding to "rockchip,rk3328-grf-gpio"
> 
> Changes in v3:
> - Change from general gpio-syscon to specific rk3328-gpio-mute
> 
> Changes in v2:
> - Rename gpio_syscon10 to gpio_mute in doc
> 
> Changes in v1:
> - Refactured for general gpio-syscon usage for Rockchip SoCs.
> - Add doc rockchip,gpio-syscon.txt
> 
>  .../bindings/gpio/rockchip,rk3328-grf-gpio.txt     | 32 ++++++++++++++++++++++
>  drivers/gpio/gpio-syscon.c                         | 31 +++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt

Reviewed-by: Rob Herring <robh@kernel.org>
