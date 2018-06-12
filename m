Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 903F4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D97E2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D97E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbeFLWj6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:39:58 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:40621 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934418AbeFLWjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:39:55 -0400
Received: by mail-yb0-f196.google.com with SMTP id v17-v6so219528ybe.7;
        Tue, 12 Jun 2018 15:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9VxIY8A1QgTl9wG8rWxmmjfVioRKwSc3V0fBAbeN1L4=;
        b=TK4QSK5SKicWT1ElrG8xyLBfgmz1BcYcWQGDkB+LH1TkrxC1pRbVK+1EsoaRkcmYbd
         QZS2MtNQojmBqijOsabvaV6oRqVxxzLe6JFFVx8iWoUqhd6SZhzNPoySOXFG4qQN9ahm
         ZyxZjYnp4xAInTfoLtgpl4zT2jahp+7kjfNOhRcYjxaYBSjTKV1pGgZolPvfSi0Y3Ad9
         ghPzBlGitSx38L3OG4Nj17NzxSu9+pc4DodR/ufXBa/swYjfG72D/Pkjt+KTHi+ilRII
         ZHZ78qYdp4Zh6v880uikr9CS+zipRoF6zeK23t/DuEh08f44Lklc4kwyiqlJDRXtEPTs
         EgRg==
X-Gm-Message-State: APt69E13t/7T9RVa3KRzOOuTRQXKRLC27zF8n+ntM/KZO/lyry/QdEFo
        qioquXyuVqCZcy8IjUt2qB+k+NRvUw==
X-Google-Smtp-Source: ADUXVKJ2mjvZ2ESBoC4mnqRXKKg8conwXymjqZZZSF96yMP1h6iEdQm8oyJMt8QZpctwkPn8XuuXlA==
X-Received: by 2002:a25:7910:: with SMTP id u16-v6mr1138500ybc.209.1528843194920;
        Tue, 12 Jun 2018 15:39:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id u17-v6sm542970ywu.16.2018.06.12.15.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:39:54 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:39:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com, linux-mips@linux-mips.org,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 7/7] tty: serial: lantiq: Add CCF support
Message-ID: <20180612223953.GA21621@rob-hp-laptop>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-8-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612054034.4969-8-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:40:34PM +0800, Songjun Wu wrote:
> Previous implementation uses platform-dependent API to get the clock.
> Those functions are not available for other SoC which uses the same IP.
> The CCF (Common Clock Framework) have an abstraction based APIs
> for clock.
> Change to use CCF APIs to get clock and rate.
> So that different SoCs can use the same driver.
> Clocks and clock-names are updated in device tree binding.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> 
> ---
> 
>  .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +++

Please split bindings to separate patch.

>  drivers/tty/serial/Kconfig                         |   2 +-
>  drivers/tty/serial/lantiq.c                        | 101 +++++++++++++++++----
>  3 files changed, 98 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> index 3acbd309ab9d..608f0c87a4af 100644
> --- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> +++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> @@ -6,6 +6,10 @@ Required properties:
>  - interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
>    depends on the interrupt-parent interrupt controller.
>  
> +Optional properties:
> +- clocks: Should contain frequency clock and gate clock
> +- clock-names: Should be "freq" and "asc"
> +
>  Example:
>  
>  asc1: serial@e100c00 {
> @@ -14,3 +18,14 @@ asc1: serial@e100c00 {
>  	interrupt-parent = <&icu0>;
>  	interrupts = <112 113 114>;
>  };
> +
> +asc0: serial@600000 {
> +	compatible = "lantiq,asc";
> +	reg = <0x600000 0x100000>;

1MB of address space? That wastes a lot of virtual space on 32-bit 
systems. Just make the size the actual used range.

> +	interrupt-parent = <&gic>;
> +	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
> +	<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
> +	<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&pll0aclk SSX4_CLK>, <&clkgate1 GATE_URT_CLK>;
> +	clock-names = "freq", "asc";
> +};
