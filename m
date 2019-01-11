Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1892C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF135206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217949;
	bh=iY4Th81KtGGWkR8i0Y4pIaA4XX79YH6IZLGJw0q2sQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ysaUeO7sceDdQN9FN7PLOf4pJoBAnsYZZ9Mjzq8HTCH5xPKUzR9OFyy6NKCKzeX4A
	 kkNZEHCcxnrhaULaDL4l4YNJeSkCTEI2+Q7ZrePKLzAqqoNh4T4HynUx/fNcmVkgdU
	 nTcFa0/huYw/qMNyf4Uf+MO/36UaTFvewGes+hJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404424AbfAKOni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38471 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbfAKOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so12349600oii.5;
        Fri, 11 Jan 2019 06:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VmNMexEJZpklasIyqDSBw44e61uRs3mXmalNyuff3vo=;
        b=DDOzYrOhtQVMfOp6Yc5aYEIgsGAhmh4LH9SE3VBBfBs2EE6t5v7zW7uxWgRfA9oizU
         1m/OMB/NDAP+5CCAceMUN81Y56Bom1u2lRq02gw+v75JDbhVKOtcFvuIvL9Y5PMs8LBr
         h6CBHx7FSeFhVkQuqQf8wZSrerXW/viufU5U1vmGMCwVgJodUrLvGxazxvA3i1WiyItU
         21+uaIqDBIkhrGQ35s1O/COweH24y8TWf+8i5JVdBTJxG+2hjZpr0VvqtT5b9JRC+pc7
         T5DEQzNPxE21RFOmiR/wISbpORKDxXdPGU28m8b0Kyw/q91815L9MITZ0EO962M/Cm+k
         fcxQ==
X-Gm-Message-State: AJcUukfuekQGiZwwevX8z1kQg9ZUWmnWgkbAlW0IrDfsudQwYZFsNb6r
        396fOJt1VRgA1Su598dRMA==
X-Google-Smtp-Source: ALg8bN6tSMtWxAF1mjQgAFaZaC6mw+66Xfx5YOQNm99ZApmdtMc673DuJ48emHIV93cDl24Wychb4g==
X-Received: by 2002:aca:b642:: with SMTP id g63mr8797361oif.195.1547217811969;
        Fri, 11 Jan 2019 06:43:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i12sm33665709otr.74.2019.01.11.06.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:43:31 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:43:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: gnss: add gtop binding
Message-ID: <20190111144330.GA30111@bogus>
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
 <1545994235-8309-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545994235-8309-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:50:33AM +0100, Loys Ollivier wrote:
> Add binding for GlobalTop GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
>  Documentation/devicetree/bindings/gnss/gtop.txt | 33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/gtop.txt
> 
> diff --git a/Documentation/devicetree/bindings/gnss/gtop.txt b/Documentation/devicetree/bindings/gnss/gtop.txt
> new file mode 100644
> index 000000000000..24c86703aa46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/gtop.txt
> @@ -0,0 +1,33 @@
> +GlobalTop GNSS Receiver DT binding
> +
> +The GlobalTop GNSS receivers uses UART interfaces.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required properties:
> +
> +- compatible	: Must be
> +
> +			"globaltop,pa6h"
> +
> +- vcc-supply	: Main voltage regulator
> +
> +Optional properties:
> +
> +- timepulse-gpios	: Time pulse GPIO
> +- v-bckp-supply	: Backup voltage regulator
> +
> +Example:
> +
> +&uart_A {
> +	status = "okay";

Don't show status in examples.

> +	pinctrl-0 = <&uart_a_pins>;
> +	pinctrl-names = "default";
> +
> +	gnss {
> +		compatible = "globaltop,pa6h";
> +		vcc-supply = <&vcc_3v3>;
> +		current-speed = <9600>;

Shouldn't the driver know what speed the device operates at?

If you do use this, then it needs to be documented as to when it is 
needed.

> +	};
> +};
> -- 
> 2.7.4
> 
