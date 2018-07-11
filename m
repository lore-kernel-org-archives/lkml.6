Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA78C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67D020C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67D020C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbeGKU1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:27:09 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36532 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbeGKU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:27:09 -0400
Received: by mail-oi0-f67.google.com with SMTP id r16-v6so51663985oie.3;
        Wed, 11 Jul 2018 13:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+EcO42eHSwURW9BdVynOKP7dUTLiwsDpUzIa7BzcDg=;
        b=L+GBhMVR7+zlZSr8dfys0UMH3CQ1tWXZHPBFzelMCkAgN2lwBi0dWhXdZmCeEcJgKf
         u48toyxExguBzBDJXiverVs4TWU2ZjttCk3CdJOwuCSGU2+F9LuXYIQ73Lbf+zCQ5mYa
         YBH0BZ8gJKW66d6YO781gQjtnr3U0HEg5HnSho0BA27ANY5Mp6gjORltNlus8kzXUZmH
         pJJiuikcuR5a+AabUE1TT/IRBK2Gs8R+blTJNRQuKbt29wUg01Dn6QqymTQSiRDyRkLO
         BRSB+iHT+xqVbD4xwmsQDI9xKSC+sYwnAPGA6nj+HBRGZam0kwoHkHN3Btpd+6m+skTg
         pNpA==
X-Gm-Message-State: AOUpUlFyLImZRCbUx1F8ICxj0nY79LGOFIwOYp2289dKvRThYbO7HmI0
        wwc3eu1ZzaX7k8226ov5YQ==
X-Google-Smtp-Source: AAOMgpfWq0r9sZLEOa2XSD89X+mjSbVuSZZKcRqpVHA9/LgbZerJN1SUbMPbwGnJ7SFwsN7O5WPGBA==
X-Received: by 2002:aca:4e4d:: with SMTP id c74-v6mr167144oib.16.1531340469035;
        Wed, 11 Jul 2018 13:21:09 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h124-v6sm25049635oif.15.2018.07.11.13.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:21:08 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:21:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     mark.rutland@arm.com, arnd@arnd.de, gregkh@linuxfoundation.org,
        avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v1 1/2] dt-binding: bmc: Add NPCM7xx LPC BPC documentation
Message-ID: <20180711202107.GA29980@rob-hp-laptop>
References: <20180704091427.409971-1-tmaimon77@gmail.com>
 <20180704091427.409971-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704091427.409971-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:14:26PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM7xx BIOS Post Code (BPC).
> The NPCM7xx BPC monitoring two configurable I/O addresses
> written by the host on Low Pin Count (LPC) bus.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt    | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt b/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
> new file mode 100644
> index 000000000000..0832c9cbea32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
> @@ -0,0 +1,26 @@
> +Nuvoton NPCM7xx LPC BPC interface
> +
> +Nuvoton BMC NPCM7xx BIOS Post Code (BPC) monitoring two
> +configurable I/O addresses written by the host on the
> +Low Pin Count (LPC) bus, the capure data stored in 128-word FIFO.

s/capure/capture/

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>


> +
> +NPCM7xx BPC supports capture double words, when using capture
> +double word only I/O address 1 is monitored.
> +
> +Required properties for lpc_bpc node
> +- compatible	: "nuvoton,npcm750-lpc-bpc" for Poleg NPCM7XX.
> +- reg 			: specifies physical base address and size of the registers.
> +- interrupts	: contain the LPC BPC with flags for falling edge.
> +- monitor-ports : contain monitor I/O addresses, at least one monitor I/O
> +				  address required
> +
> +Optional property for lpc_bpc node
> +- bpc-en-dwcapture : enable capture double words support.
> +
> +Example:
> +	lpc_bpc: lpc-bpc@f0007040 {
> +		compatible = "nuvoton,npcm7xx-lpc-bpc";
> +		reg = <0xf0007040 0x14>;
> +		monitor-ports = <0x80>;
> +		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> -- 
> 2.14.1
> 
