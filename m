Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D0CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C85206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C85206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeLDXD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:03:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41534 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:03:57 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so15848803oii.8;
        Tue, 04 Dec 2018 15:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uurCF9stpgUWLdN/+O0Avc2znMI1EjioC+IV5uSeN6w=;
        b=OAbysNTEN29MsI8YDMR/JB/XY/qheNi9QJaJDDBQDRKd0ZQsFi/bMhwlQpsqzOigvV
         uuT1hJWgHUWb9uPnQrQ6dpT444KuahP6koDZtk3eeHk1xYXebc4JjVx2meN/mMd21A0f
         wrM4hHU3yaMLlj55qwfT0PO1aJl0lMRK9k9L9hmQWS1xTdmrd0yxfNV1hIan3wYpr3eg
         yLgK2yz7GWLMteHmG8oZitM1ac4rUUayM29WhaQ60jk2zvuTVyMWgXPQL7+DS7hgFf6Q
         sC5Im3XCEm3Jg+SBvVmSWW+18NtXvLCnFNVqivbXN6jhzNJzbQj8B6IAXf+3XA5zXr4+
         VtcA==
X-Gm-Message-State: AA+aEWaRenGh9RxwXJntAmZFwO8Ril6lxdyEo2wuj4dqI2/g80nnaIVs
        ynoLDSCMRJNB9B2M5opDJnasKOM=
X-Google-Smtp-Source: AFSGD/XkidUmgMaieg28TxC6FZr0clsvrMO0F06X6pEJn7D2i4sik76czRBTVsvb2LiAowIS12Pt3A==
X-Received: by 2002:aca:2108:: with SMTP id 8mr14027635oiz.171.1543964635862;
        Tue, 04 Dec 2018 15:03:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m207sm8008320oig.2.2018.12.04.15.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:03:55 -0800 (PST)
Date:   Tue, 4 Dec 2018 17:03:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer
 description
Message-ID: <20181204230354.GA26204@bogus>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:01:09AM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut M10V timer.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> new file mode 100644
> index 0000000..ddb1b31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> @@ -0,0 +1,17 @@
> +Milbeaut SoCs Timer Controller
> +
> +Required properties:
> +
> +- compatible : should be "socionext,milbeaut-m10v-timer"
> +- reg : Specifies base physical address and size of the registers.

How many register ranges? Looks like 2.

> +- interrupts : The interrupt of the first timer
> +- clocks: should be "rclk"
> +
> +Example:
> +
> +timer {

timer@1e000050

> +	compatible = "socionext,milbeaut-m10v-timer";
> +	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
> +	interrupts = <0 91 4>;
> +	clocks = <&rclk>;
> +};
> -- 
> 1.9.1
> 
