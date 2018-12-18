Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D38C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398C62133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545154411;
	bh=JOfZMzOVTlyicqfXYkjw8gRCahIBs+OxkaXRces6KHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mWhxsoOB0cqUgD/vWAcyAf2BCYM+udxSMoUwBu438CMcZIg3WsdmzV0bs1Qe04ZFY
	 DJnUloP7v8o2OWI3XxP5Gscl4FQLBNxm0QcHo4cBaLdL3qfCAtxEZRZsDpw3PcTkIU
	 PTCAEjPMvFCUb5CsXDQ1u5DjzQpkcShulL8f3eKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeLRRda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:33:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41445 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:33:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so16413677otk.8;
        Tue, 18 Dec 2018 09:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tV8/DGJ53qwJSmkJnArvpr8WpIblVj5jGwXmw2hy6qc=;
        b=VfaOlPJtFGjvbA80IyIHNCdYwRWAKBndE+CvT+ZxGhIZDRsJCk8HfwX7sW0oCgz8SO
         jjINUqRvOwM8dDI93zjUbQjQMqLD+972x1OA1/XOjuHD3z+EZK2ukdztIVWioNYr+1NV
         /QqcBx664RaaRhygKEO5RLBrrVglXKE5QNYnE4dfmnu8jDpwyvQjKJWb0RQT5Ve8h70b
         Z3x+jonUrLStb+RBYLkdzVwAYmedB4B//VqVrWqhkp9KwXCBhLUJmKmaHPDH368X4iFS
         9iuI6boDlzHAFg9H8NtmIgiVCoLsNy1LTVmEdG3GHhdLOqEVmhk1B5nqKTtZPKtDBKRe
         NAjQ==
X-Gm-Message-State: AA+aEWZ6L8+n7FL16DumSnpQrAOsmvp2MfZvJaDYKDw2NVUR43a/G8+2
        oqO9mOGncjpl9UT1nqJPIw==
X-Google-Smtp-Source: AFSGD/WUGlBonC9ony+dPtBD3QPDlWlv800IpZJLkfoMqIfG/mlatgAjTHVlioyUP1FeXgRSxgDvnA==
X-Received: by 2002:a9d:5415:: with SMTP id j21mr12304860oth.202.1545154409080;
        Tue, 18 Dec 2018 09:33:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i22sm7678557otp.7.2018.12.18.09.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:33:28 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:33:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jan Kotas <jank@cadence.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        mark.rutland@arm.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: Add bindings for Cadence GPIO
Message-ID: <20181218173327.GA29063@bogus>
References: <20181217153652.20056-1-jank@cadence.com>
 <20181217153652.20056-2-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217153652.20056-2-jank@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:36:51PM +0000, Jan Kotas wrote:
> This patch adds a DT binding documentation for
> Cadence GPIO controller.
> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  .../devicetree/bindings/gpio/cdns,gpio.txt         | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/cdns,gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/cdns,gpio.txt b/Documentation/devicetree/bindings/gpio/cdns,gpio.txt
> new file mode 100644
> index 000000000..c87a47827
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/cdns,gpio.txt
> @@ -0,0 +1,44 @@
> +Cadence GPIO controller bindings
> +
> +Required properties:
> +- compatible: should be "cdns,gpio-r1p02".
> +- reg: the register base address and size.
> +- #gpio-cells: should be 2.
> +	* first cell is the GPIO number.
> +	* second cell specifies the GPIO flags, as defined in
> +		<dt-bindings/gpio/gpio.h>. Only the GPIO_ACTIVE_HIGH
> +		and GPIO_ACTIVE_LOW flags are supported.
> +- gpio-controller: marks the device as a GPIO controller.
> +- clocks: should contain one entry referencing the peripheral clock driving
> +	the GPIO controller.
> +
> +Optional properties:
> +- ngpios: integer number of gpio lines supported by this controller, up to 32.
> +- interrupt-parent: phandle of the parent interrupt controller.

Don't document interrupt-parent as it is implied and could be in a 
parent. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
