Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF60CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9058F20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKPz1KN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9058F20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeHVWvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:51:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42660 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHVWvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:51:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so2216397lff.9;
        Wed, 22 Aug 2018 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hO9GcebNeg4TfjrwuEkmxS7g2uIYqk1ZuBykH3/CcH8=;
        b=lKPz1KN+O8sLn3t8PUZ+3o4aHzrF5X5O62zueteH9foegZtEVGR0IjHsIvzzIu1cfx
         d3C1vAdqDZ9K4w5Lel6rDtQfgA4mZisPAHP7zxDe2iP62VBcqzL+S6PMHvhsVY2jixiW
         w4ZVC9RfkzGDtPYR/yTjIw7c++CPvwKbUsX9x0MEdse1T9mJLq7TbdS6JrViusrhwdGF
         qdhTsZkVthlYcYxEc/1SfUHXiGQobP0MjJT0MV64WJuErMz8H2zsziJaY/C9g8PO2fLV
         VTdBxOqlEkfqDonvhn62wd3ae6fCTrzhxWpKMC8Up5StT9v1kTdj2pT9jp+zdGuhLwA3
         xpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hO9GcebNeg4TfjrwuEkmxS7g2uIYqk1ZuBykH3/CcH8=;
        b=W/eVv5o0I/bPySaY5Ow99Myc+/xEGnMr2Sk4z2u9bvxN0DJOCiOGQ41Pl/PO5op6yc
         I/SntuCffREH+w7yaGXupg2AOb+T9Vjthl4IYCwdHe8uEiObkS8pQmLQ/L3MBINhpqp2
         kC/2bxow6K7yNE5KBxB4tXUiY6R8ytliVy7osTv8b4fABQwLhJ4xzVRelqixgl20Cua7
         AF22lkNSS74/pP6AiTZ9pUEMJuARI91e39OaYCzQ4npfxngGg+KzHjaNz56a+3a/aUSn
         QQ0W+1YnHoGJhhaPcG7QueoCdPYb0iIEgGmFBYt8WgnUcZiwqEuX6aZbjTomgpgmuc8U
         sPjg==
X-Gm-Message-State: APzg51AXnl5OMCq08ROx+mCEl8zwUbJp36VXzJclrCfRIQvUQD+A7dF2
        BtFIaA/jIwhOx6gtznVY5zY=
X-Google-Smtp-Source: ANB0VdaWhtP6/C90XhByY1ypjkLGLgezkdOpbU6sLUVr1Wr+cq2YiRmWeTGtzje1F0+h64lVYyBeAg==
X-Received: by 2002:a19:18d8:: with SMTP id 85-v6mr1187731lfy.133.1534965896732;
        Wed, 22 Aug 2018 12:24:56 -0700 (PDT)
Received: from gmail.com (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id b10-v6sm456947lfa.6.2018.08.22.12.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 12:24:55 -0700 (PDT)
Date:   Wed, 22 Aug 2018 21:25:18 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: dac: add bindings for ltc1660
Message-ID: <20180822192518.GA694@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
 <20180821193126.15733-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821193126.15733-2-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 09:31:25PM +0200, Marcus Folkesson wrote:
> LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
> with eight individual channels.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Rob, sorry I missed your tag.

Reviewed-by: Rob Herring <robh@kernel.org>

> ---
> 
> Notes:
>     v2:
>     	- rename file, ltc166x -> ltc1660
> 
>  .../devicetree/bindings/iio/dac/ltc1660.txt         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> new file mode 100644
> index 000000000000..c5b5f22d6c64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> @@ -0,0 +1,21 @@
> +* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
> +
> +Required properties:
> + - compatible: Must be one of the following:
> +		"lltc,ltc1660"
> +		"lltc,ltc1665"
> + - reg: SPI chip select number for the device
> + - vref-supply: Phandle to the voltage reference supply
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> +	 Max frequency for this chip is 5 MHz.
> +
> +Example:
> +dac@0 {
> +	compatible = "lltc,ltc1660";
> +	reg = <0>;
> +	spi-max-frequency = <5000000>;
> +	vref-supply = <&vref_reg>;
> +};
> -- 
> 2.11.0.rc2
> 
