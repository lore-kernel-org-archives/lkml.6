Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88681C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE3C20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE3C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeGYVKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:10:46 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34617 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbeGYVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:10:46 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so7345632ioj.1;
        Wed, 25 Jul 2018 12:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SKg6rV06V0lTYNlPN8MJq1T7lX7jMbiEBsfVo8gw/Ag=;
        b=UBkglX13rIqS//tROrnfnl4VnhWoBdBvIWEzYgmtUMIIj1wH5tyMN7UQAVlU1SwQXN
         EYP2+pj9Vee3Hnkkral8ts9YB3nOb7ZFY4uAa0zXfGAAhAWGuIlydXG71oO87CNuIkt7
         zc0wz0Ikp0FWBkfMOzIGJXW89HxJaamgRCd1QAjNOmuT3HojFiUn8zr4xqXY0ogotdWN
         iieU6L5IMT6oNuFmMxSz8pl0h5gqEEcZhCqKqpBMPvWtMLKU3WeUZr5dGiIFtX1sJ2bw
         Q+mDXHBKqOYcDf7B1xvZ5eHPKe92VryLN4byWcoL/Ws36IZGcKH8NahCSOY+sbJ1Fmpp
         FwmQ==
X-Gm-Message-State: AOUpUlHCz4XKMQW4D6M8keFV2IYPOivqz7OjhFU4E6ltyytbf+bQKS+m
        rDMSxm3hG8ejPqTMM8mQYQ==
X-Google-Smtp-Source: AAOMgpfG+gCtu1DbjKtLufe5+sEv63uLPjMi0uFqRavAY0EmR1DBQ0vWAeu10r+aoJdg/INBnMD8wQ==
X-Received: by 2002:a6b:2a05:: with SMTP id q5-v6mr18498890ioq.13.1532548654332;
        Wed, 25 Jul 2018 12:57:34 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z71-v6sm12403735ioz.34.2018.07.25.12.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:57:33 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:57:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vitor soares <Vitor.Soares@synopsys.com>
Cc:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, psroka@cadence.com, agolec@cadence.com,
        adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com,
        alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com,
        rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        Joao.Pinto@synopsys.com
Subject: Re: [PATCH 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C
 master bindings
Message-ID: <20180725195733.GA14450@rob-hp-laptop>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <1532120272-17157-3-git-send-email-soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532120272-17157-3-git-send-email-soares@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 09:57:51PM +0100, Vitor soares wrote:
> This patch document Synopsys DesignWare I3C master DT bindings.
> 
> Signed-off-by: Vitor soares <soares@synopsys.com>
> ---
>  .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> new file mode 100644
> index 0000000..7f5c8b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> @@ -0,0 +1,43 @@
> +Bindings for Synopsys DesignWare I3C master block
> +=================================================
> +
> +Required properties:
> +--------------------
> +- compatible: shall be "snps,dw-i3c-master"

Only one version and no version number?

... and an SoC specific compatible string.

> +- clocks: shall reference the core_clk
> +- clock-names: shall contain "core_clk"

"_clk" is redundant and *-names with a single entry is kind of 
pointless.

> +- interrupts: the interrupt line connected to this I3C master
> +- reg:  Offset and length of I3C master registers
> +
> +Mandatory properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- #address-cells: shall be set to 3
> +- #size-cells: shall be set to 0
> +
> +Optional properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- i2c-scl-hz
> +- i3c-scl-hz
> +
> +I3C device connected on the bus follow the generic description (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> +
> +Example:
> +
> +	i3c-master@0x2000 {

Drop the '0x'

> +		compatible = "snps,dw-i3c-master";
> +		#address-cells = <3>;
> +		#size-cells = <0>;
> +		reg = <0x02000 0x1000>;
> +		interrupts = <0>;
> +		clocks = <&i3cclk>;
> +		clock-names = "core_clk";
> +
> +		eeprom@0x57{
> +			compatible = "atmel,24c01";
> +			reg = < 0x57 0x80000010 0x0>;
> +			pagesize = <0x8>;
> +		};
> +	};
> -- 
> 2.7.4
> 
> 
