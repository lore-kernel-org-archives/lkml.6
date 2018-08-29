Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01293C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F092087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F092087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeH2E4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:56:48 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40708 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeH2E4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:56:48 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so6237158oig.7;
        Tue, 28 Aug 2018 18:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6u5pDWncMuuXcSOYA63+Yybt7J38Dq56BpU3SX9IL/g=;
        b=cfIAUrDz2YyRcQxOX+QY9XBURnLgzdgyMOOuXsXZO/qsPItkoCwsuRIVuIebKJoDSU
         GjLxnDS8J3oWUFQOxSqqjjTRFaid0jmHVJEGHSQVjE/hAKJZdyYOTg+mNQSYJ12ZweSG
         wRsU0yQxNFB4+jxeIMWKHwoUnxNl0QGkLkQWlrzlwATeBOViG1CnUkW9/r0dY8qwh6V3
         MtfCJWBg4xjhV+w5TlQSrsuLN6zuGa7w4Cphily0/ozb0noQ1Y9EdILHZmMIxXDNXAmA
         8y3nLLGzeZesnwIKK64CsHzBcZySzodVY9o7M04CMFo55OJk8yb9+X5Bd0FlivTbudST
         RjJQ==
X-Gm-Message-State: APzg51CRbLy2qe3VWp8PakXXBNaVTGfES42IT7eIxetW60WdoKQZgrAv
        nainSih/eqsobcyOtVVulFHNd1JfSQ==
X-Google-Smtp-Source: ANB0VdanlUkQ3w9cbxXWxni3CFRU/IXZ5YHYzuiex40dlBlwJB8M7oyzRFDCdnHiRmZ9IAlj/2rOxg==
X-Received: by 2002:aca:c34b:: with SMTP id t72-v6mr608711oif.338.1535504551853;
        Tue, 28 Aug 2018 18:02:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w84-v6sm2435131oie.40.2018.08.28.18.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 18:02:30 -0700 (PDT)
Date:   Tue, 28 Aug 2018 20:02:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys GPIO via CREG
 bindings
Message-ID: <20180829010230.GA16393@bogus>
References: <20180828112721.28178-1-Eugeniy.Paltsev@synopsys.com>
 <20180828112721.28178-3-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828112721.28178-3-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:27:21PM +0300, Eugeniy Paltsev wrote:
> This patch adds documentation of device tree bindings for the Synopsys
> GPIO via CREG driver.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  .../devicetree/bindings/gpio/snps,creg-gpio.txt    | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
> new file mode 100644
> index 000000000000..eb022d44ccda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
> @@ -0,0 +1,49 @@
> +GPIO via CREG (Control REGisers) driver

REGisters?

Bindings don't describe drivers.

> +
> +This is is single-register MMIO GPIO driver to control such strangely mapped 
> +outputs:
> +
> +31            11        8         7        5         0   < bit number
> +|              |        |         |        |         |
> +[   not used   | gpio-1 | shift-1 | gpio-0 | shift-0 ]   < 32 bit MMIO register
> +                   ^                  ^
> +                   |                  |
> +                   |           write 0x2 == set output to "1" (on)
> +                   |           write 0x3 == set output to "0" (off)
> +                   |
> +            write 0x1 == set output to "1" (on)
> +            write 0x4 == set output to "0" (off)

What kind of crazy h/w designer designed this?

> +Required properties:
> +- compatible : "snps,creg-gpio"
> +- reg : Exactly one register range with length 0x4.
> +- #gpio-cells : Should be one - the pin number.
> +- gpio-controller : Marks the device node as a GPIO controller.
> +- snps,ngpios: Number of GPIO pins.
> +- snps,bit-per-line: Number of bits per each gpio line (see picture).
> +  Array the size of "snps,ngpios"
> +- snps,shift: Shift (in bits) of the each GPIO field from the previous one in
> +  register (see picture). Array the size of "snps,ngpios"
> +- snps,on-val: Value should be set in corresponding field to set
> +  output to "1" (see picture). Array the size of "snps,ngpios"
> +- snps,off-val: Value should be set in corresponding field to set
> +  output to "0" (see picture). Array the size of "snps,ngpios"

Convince me we need to parameterize all this. We try to avoid describing 
h/w like this.

> +
> +Optional properties:
> +- snps,default-val: default output field values. Array the size of "snps,ngpios"
> +
> +Example (see picture):
> +
> +gpio: gpio@f00014b0 {
> +	compatible = "snps,creg-gpio";
> +	reg = <0xf00014b0 0x4>;
> +	gpio-controller;
> +	#gpio-cells = <1>;
> +	snps,ngpios = <2>;
> +	snps,shift = <5 1>;
> +	snps,bit-per-line = <2 3>;
> +	snps,on-val = <2 1>;
> +	snps,off-val = <3 4>;
> +	snps,default-val = <2 1>;
> +};
> -- 
> 2.14.4
> 
