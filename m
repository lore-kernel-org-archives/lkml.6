Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280AEECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54B3208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54B3208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeGPQBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:01:07 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34590 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeGPQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:01:07 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so75591768ois.1;
        Mon, 16 Jul 2018 08:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wl/hkASMuDEBUuX098udBNXtuOBN46mXEXqJr6BW3bQ=;
        b=hWwhWb4z/iwcot1dseZNYFwSgS8wq2EzNScRlXmghcKqw9CO4A1A+t+7OukJQiALk5
         F10V4KKMRd9Qxef05JWghmfqhkHVl7r+PQlgVkU+5QqDmzjKQ3+s63c9N72duSBhxowp
         Udj6UGJ2s3F5kF7wEM5K7qEh7F7hksnrIEUhiSrWngEUWx83DtqPQ3/XeGPYiZrF+N3X
         5ftbmW7IlDQbgyNE1u0RtM1jJEHMoljJBxak9q0G4prDziqt9ZRoB4koi9/Nh5tmGECE
         ON/sQWLz5ezq6D4gu+ynVUIK8Wp2fbnlyd/v9CCg2IyiYTJHxRJOPE03kgwBiFCVmyQc
         x/0A==
X-Gm-Message-State: AOUpUlEYSDbAltvPguMS58s79UpRCyXFN7AeasakPcyRulgrqDi8Ak9Z
        3eB6BOt7j2Z+BIAG2qYD9ABYBsg=
X-Google-Smtp-Source: AAOMgpeX9nxGgWhAiSjZbtvfUwVfJsYh4py/l/8EBFQBqB74MgZP6AnBG9Xz1L9ftu9UBlgn3y4UiQ==
X-Received: by 2002:aca:5583:: with SMTP id j125-v6mr19786056oib.2.1531755189761;
        Mon, 16 Jul 2018 08:33:09 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i204-v6sm24189743oia.41.2018.07.16.08.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:33:09 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:33:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
Message-ID: <20180716153308.GA13044@rob-hp-laptop>
References: <20180712034847.12878-1-benh@kernel.crashing.org>
 <20180712034847.12878-2-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712034847.12878-2-benh@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:48:43PM +1000, Benjamin Herrenschmidt wrote:
> This isn't per-se a real device, it's a pseudo-device that
> represents the use of the Aspeed built-in ColdFire to
> implement the FSI protocol by bitbanging the GPIOs instead
> of doing it from the ARM core.
> 
> Thus it's a drop-in replacement for the existing
> fsi-master-gpio pseudo-device for use on systems based
> on the Aspeed chips. It has most of the same properties,
> plus some more needed to operate the coprocessor.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> new file mode 100644
> index 000000000000..431bf8a423ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> @@ -0,0 +1,36 @@
> +Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
> +------------------------------------------------------------------------
> +
> +Required properties:
> + - compatible =
> +	"aspeed,ast2400-cf-fsi-master" for an AST2400 based system
> +   or
> +	"aspeed,ast2500-cf-fsi-master" for an AST2500 based system
> +
> + - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
> + - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
> + - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
> + - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
> + - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
> +                                          functions (eg, external FSI masters)
> + - memory-region = <phandle>;		: Reference to the reserved memory for
> +                                          the ColdFire. Must be 2M aligned on
> +					  AST2400 and 1M aligned on AST2500
> + - aspeed,sram = <phandle>;		: Reference to the SRAM node.
> + - aspeed,cvic = <phandle>;		: Reference to the CVIC node.
> +
> +Examples:
> +
> +    fsi-master {
> +        compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
> +
> +	clock-gpios = <&gpio 0>;
> +        data-gpios = <&gpio 1>;
> +        enable-gpios = <&gpio 2>;
> +        trans-gpios = <&gpio 3>;
> +        mux-gpios = <&gpio 4>;
> +
> +	memory-region = <&coldfire_memory>;
> +	sram = <&sram>;
> +	cvic = <&cvic>;

Need to update the example. With that,

Reviewed-by: Rob Herring <robh@kernel.org>
