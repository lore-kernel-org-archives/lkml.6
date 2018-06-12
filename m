Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4345DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036FE2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036FE2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934514AbeFLWOD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:14:03 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40309 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933727AbeFLWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:14:02 -0400
Received: by mail-yw0-f195.google.com with SMTP id p129-v6so195255ywg.7;
        Tue, 12 Jun 2018 15:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMW7qF1SXylCLXA6wjFGXhtDR81KgTht+4Bp40q6yGk=;
        b=mf0nPXa+ILyUtHiIJB1/3mYgQQzkeMbPiPdyl0kL9tIbwUEiwHguEWq2q0IH9wu/81
         ZtNb9ly/qVGRoEH97jgKLwTLBf0PNd8ikiFsYwbEtwPBxdCBZKsqxmT2DIT6C3mDQ5bl
         X7gOwFJf0u34WQiX02dEHsywDmXugz3Zvt1Be99OR4ypp4bgniUxK6S0XUNS5T8H0nbK
         kxel6PiFvhZF11470JbEEolg6AM5bZbg/D43PFyAYESdda0PPpu5KhCiHo267LuZiGlr
         4KuS48XhFdjKcqKJ7qbCCxMZUje5shwuc010kiBYLs+D8l9Evowt4UuWlX5rwL09ayKx
         03OA==
X-Gm-Message-State: APt69E0Ys9FntgnhHB9paXpiEtEpji2rs8Y4JJ+NUVDfac5vLffwBsAW
        QyqlYZt1vD47mlI/cyBAtQ==
X-Google-Smtp-Source: ADUXVKKvBsCjiyWdsu2J1903YivinDsobpeaQ9T6pilAvGNL/HbCyujrPIQx3xPwDAK2QRKFlAs6Kg==
X-Received: by 2002:a81:e403:: with SMTP id r3-v6mr1166490ywl.429.1528841641335;
        Tue, 12 Jun 2018 15:14:01 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p81-v6sm487438ywb.71.2018.06.12.15.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:14:00 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:13:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ASoC: pxa: add binding for pxa2xx-ac97 audio complex
Message-ID: <20180612221359.GA26741@rob-hp-laptop>
References: <20180611202211.15501-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611202211.15501-1-robert.jarzmik@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:22:10PM +0200, Robert Jarzmik wrote:
> This adds a binding for the Marvell PXA audio complex, available in
> pxa2xx and pxa3xx variants.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  .../bindings/sound/marvell,pxa2xx-ac97.txt         | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt b/Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt
> new file mode 100644
> index 000000000000..b3f2882d9c7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt
> @@ -0,0 +1,25 @@
> +Marvell PXA2xx audio complex
> +
> +This descriptions matches the AC97 controller found in pxa2xx and pxa3xx series.
> +
> +Required properties:
> +  - compatible: "marvell,pxa2xx-ac97"

Don't use wildcards in compatible strings. Though this is so old...

> +  - reg: device MMIO address space
> +  - interrupts: single interrupt generated by AC97 IP
> +  - clocks: input clock of the AC97 IP, refer to clock-bindings.txt
> +
> +Optional properties:
> +  - pinctrl-names, pinctrl-0: refer to pinctrl-bindings.txt
> +  - reset-gpio: gpio used for AC97 reset, refer to gpio.txt

reset-gpios

> +
> +Example:
> +	ac97: sound@40500000 {
> +	      	compatible = "marvell,pxa2xx-ac97";
> +		reg = < 0x40500000 0x1000 >;
> +		interrupts = <14>;
> +		reset-gpio = <&gpio 113 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = < &pmux_ac97_default >;
> +		status = "okay";

Don't show status in examples.

> +	};
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
