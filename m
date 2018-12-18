Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1D4218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545153635;
	bh=T5PcE17zxWrJHgtfRGz7WHwWqmcsVv3obSgIGUDebv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sozm5MXN8bYtkZj3V5fe6INvx2lS6CTw64BZZpnbmZZKv0KRVAQJGeNMvZLskzzuc
	 Z+1P4MbE+sJwrPx0lZDdXPcraBK4vDiA892bV1aQxWL6IvqY3zygWgZSBsxye4emsh
	 2TV3qI9E2UyhH3YUqNyg/u73iFes++W6VLWJYNxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeLRRUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:20:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41105 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeLRRUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:20:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so2559337oii.8;
        Tue, 18 Dec 2018 09:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ay0IswX+sRWNKX5ziAV2hvU/TN5PQDEK6pFJnClTI3Q=;
        b=r0vz9PG7rf/48lq1Uj/rJ8zeI8pfzj0OGoOgdTd7AX/pOzJweFCDioxQUQwZstCIlk
         cfmViT+26Nw5s4M2/SYX8TT1OSM38Iw/1y/xVmfI9VKlizahNK0AuLthvrluojV1vjYn
         2+haJQibgiziNQIm56gwT9XbSHqse89CLVIwuGEEoE2cIeMHybHyRRDjjVefPiazhWM6
         3PiZk1CjXZDwxNkZQh4zbIw0Ok+M2NPgWKorRo/NcajLxmwv5KSwZixW7LVU1VZds4Pd
         0a6c+HgqljMjjdVMr3anEfwec/kssb3uFKdBE4l5+p3B4rT3XSjmvdu6nTwZ3VMLewAR
         iOFQ==
X-Gm-Message-State: AA+aEWai5T2ye4w//j1xVzkv+cFLlmOkKL1BMXhtubvoT3nM0yr/AQ9I
        Yfb6xL/MdYKRzUHL33rgOpY9xxmZ+Q==
X-Google-Smtp-Source: AFSGD/WvNjfb6eF+KnwrvCaF1Q03GxUQflfTylnXk3tkWA2mz++vItu2t/i0MNrl4EfD8GPJvPaIzA==
X-Received: by 2002:aca:a60d:: with SMTP id p13mr8771745oie.2.1545153632929;
        Tue, 18 Dec 2018 09:20:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm13246235oia.55.2018.12.18.09.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:20:32 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:20:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, thierry.reding@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [RFC v2 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Message-ID: <20181218172031.GA7272@bogus>
References: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
 <1544768442-12530-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544768442-12530-2-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:50:41AM +0530, Yash Shah wrote:
> DT documentation for PWM controller added with updated compatible
> string.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 0000000..250d8ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,44 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently only
> +supports one period for all channels in the PWM. This is set globally in DTS.
> +The period also has significant restrictions on the values it can achieve,
> +which the driver rounds to the nearest achievable frequency.
> +
> +Required properties:
> +- compatible: should be something similar to "sifive,<chip>-pwm" for
> +	      the PWM as integrated on a particular chip, and
> +	      "sifive,pwm<version>" for the general PWM IP block
> +	      programming model. Supported compatible strings are:
> +	      "sifive,fu540-c000-pwm" for the SiFive PWM v0 as
> +	      integrated onto the SiFive FU540 chip, and "sifive,pwm0"
> +	      for the SiFive PWM v0 IP block with no chip integration
> +	      tweaks.

This should reference the common doc Paul has written and not re-explain 
the versioning scheme again.

> +- reg: physical base address and length of the controller's registers
> +- clocks: The frequency the controller runs at
> +- #pwm-cells: Should be 2.
> +  The first cell is the PWM channel number
> +  The second cell is the PWM polarity
> +- sifive,approx-period: the driver will get as close to this period as it can

Needs a unit suffix as defined in property-units.txt

> +- interrupts: one interrupt per PWM channel
> +
> +PWM RTL that corresponds to the IP block version numbers can be found
> +here:
> +
> +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> +
> +Further information on the format of the IP
> +block-specific version numbers can be found in
> +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> +
> +Examples:
> +
> +pwm:  pwm@10020000 {
> +	compatible = "sifive,fu540-c000-pwm","sifive,pwm0";
> +	reg = <0x0 0x10020000 0x0 0x1000>;
> +	clocks = <&tlclk>;
> +	interrupt-parent = <&plic>;
> +	interrupts = <42 43 44 45>;
> +	#pwm-cells = <2>;
> +	sifive,approx-period = <1000000>;
> +};
> -- 
> 1.9.1
> 
