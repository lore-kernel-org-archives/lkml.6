Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93689C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9C620882
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948552;
	bh=zByrNPN2V2fQ9qMhJstVaTOvVN5sWzSseu7yMSvnljM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O/2zIta6RE3UGkWo005CuhU/gE94bBtG/j6wVGybU+11CN/Qws9IMgOZGXfCGBOUN
	 JcxVrpUP7FZbn+XKdbWjtc3c1jaHWZI7folXe97n9iAwoFIeghoTKcsSwlMNUoAdIY
	 Rdc61oGqXpeWrDbPZbM7aLenSZ0akXTqJwYUQkqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbeL0WJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:09:11 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52084 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbeL0WJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:09:09 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so26251857ite.1;
        Thu, 27 Dec 2018 14:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2ZjfZha2uDoYBpSDCAZu8yTreOdNaRPpM3WOoiacdw=;
        b=IhgktlN6N+ygWRlLViUCKDcH/hC20nY2zigBzwLpvdxkNr+3Fo7hlngHh/XxGMRUkU
         tOsaSeWW11ixegvY/dhlU2LBXdWOnvhcFSkzyhEdFVFpmjEmCPtJEV7DRX45R6D6nDiY
         yZLBNed2TuuvO7zMB5psNEGmHo1a4X1JotMd1pLvsuQp/ea1o3G0xLnqGs75XxX7zO5r
         aFP0VXqHQRx4ZavSD1QdTT7J5H49lRqQeBa8e+jDm6aVPAlZyRw23K/YqKcHongympBD
         IiAr8veo4Y2qjyxUwslmKvBY/82lSkB3p6NTrSbliuh+KheoCpQzx8sN1M6YVhCmVn1i
         BOBw==
X-Gm-Message-State: AA+aEWZ61rw+aOQ/1UpuqwbE4GcL30NQFWGCo2n00RaO0YO7YDz39/5C
        LbwJUOLn2qVdF1A8ixW2D9TlGCY=
X-Google-Smtp-Source: AFSGD/WKyXgNIL/5HZwFM6AqatrUjH1FRad+dRfOLMCaelaT95BP9DbsEO9dL393oo8xCsPHyIRQfw==
X-Received: by 2002:a02:b70c:: with SMTP id g12mr16228757jam.60.1545948548150;
        Thu, 27 Dec 2018 14:09:08 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id w3sm349102ior.28.2018.12.27.14.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 14:09:07 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:09:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Schaeckeler <schaecsn@gmx.net>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org,
        Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: Re: [PATCH 2/2] dt-bindings: edac: Aspeed AST2500
Message-ID: <20181227220906.GA14320@bogus>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-3-git-send-email-schaecsn@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545026517-64069-3-git-send-email-schaecsn@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:01:57PM -0800, Stefan Schaeckeler wrote:
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> Add support for the Aspeed AST2500 SoC EDAC driver.
> 
> Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> ---
>  .../bindings/edac/aspeed-sdram-edac.txt       | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> new file mode 100644
> index 000000000000..57ba852883c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> @@ -0,0 +1,34 @@
> +Aspeed AST2500 SoC EDAC device driver

Bindings are for h/w, not drivers

> +
> +The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
> +correction check).
> +
> +The memory controller supports SECDED (single bit error correction, double bit
> +error detection) and single bit error auto scrubbing by reserving 8 bits for
> +every 64 bit word (effectively reducing available memory to 8/9).
> +
> +First, ECC must be configured in u-boot. Then, this driver will expose error
> +counters via the edac kernel framework.

Please reword this to not be u-boot or kernel specific.

Maybe this node is enabled in the bootloader or the OS can just read the 
registers to see if ECC is enabled. The latter is more future proof if 
you need to access the DDR ctrl registers for other reasons.

> +
> +A note on memory organization in ECC mode: every 512 bytes are followed by 64
> +bytes of ECC codes. 

That sounds strange. Normally, the memory would be 72-bits wide to hold 
the ECC byte for each 64-bit chunk. It would be inefficient to access 
the ECC byte in a discontiguous location. In any case, none of this is 
really important for the binding.

> The address remapping is done in hardware and is fully
> +transparent to firmware and software. Because of this, ECC mode must be
> +configured in u-boot as part of the memory initialization as one can not switch
> +from one mode to another when executing in memory.
> +
> +
> +
> +Required properties:
> +- compatible: should be "aspeed,ast2500-sdram-edac"
> +- reg:        sdram controller register set should be <0x1e6e0000 0x174>
> +- interrupts: should be AVIC interrupt #0
> +
> +
> +Example:
> +
> +	edac: sdram@1e6e0000 {
> +		compatible = "aspeed,ast2500-sdram-edac";
> +		reg = <0x1e6e0000 0x174>;
> +		interrupts = <0>;
> +		status = "okay";

Don't show status in examples.

> +	};
> -- 
> 2.19.1
> 
