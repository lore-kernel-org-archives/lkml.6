Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C93ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABCB2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABCB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJZGXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:23:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32906 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeJZGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:23:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id c25-v6so2711951oiy.0;
        Thu, 25 Oct 2018 14:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2XHRn0RNRmWhOHPZU8Vqp+yY/hK0PSVWmfVMKAeIH9M=;
        b=YcEK5TTz9pRnSJZZt7K2lRb9D/nYtyh70C+SF2eFPs9C+wiO/73Bn6lKLCsY/JBpuQ
         43Y+jOfUoPz85FYML7RHFGo5AxAPWdHU6YpOL6bqQiAGpzk9fFjWsmugg8ZOBeeFyGH9
         E8TZmuEBRYTD9+a31ne7jKmUDG9qgynSibLKR0jNi5TWSX9ksSdjZBntgzJRC/nSoZ8k
         4G3eiGCXOkpcJEU0gHmFNAcKjWw57BaYMP1tg4rdPxR8GvLBgDoYxzJwdHE2eIqe2M8n
         r8S5Bamie1W9EBRgwzPAuBAoMw9EUlhrLVohq0gaPqygZKtUyuPqUTcTkpxnd7kk3opT
         fZDQ==
X-Gm-Message-State: AGRZ1gKERA2IjM9nZeL1gB811JUlKF3o7gIUPcqQJvb1/teCI3l0yXH4
        q3qDBUlFxuwsVHXaZ6ljZQ==
X-Google-Smtp-Source: AJdET5fDsKkNIFDUUs2JAJhNILXT8N9thOsCqUzj1sgWNvCkm/lFcFgUq/p3LzLXxSZN+tXsVCdJ7g==
X-Received: by 2002:aca:6005:: with SMTP id u5-v6mr606965oib.201.1540504167242;
        Thu, 25 Oct 2018 14:49:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b185-v6sm2875471oia.12.2018.10.25.14.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:49:26 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:49:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     jiada_wang@mentor.com
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        horms@verge.net.au, magnus.damm@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH linux-next v1 2/4] clk: renesas: Add binding document for
 AVB Counter Clock
Message-ID: <20181025214925.GA5197@bogus>
References: <20181025072349.15173-1-jiada_wang@mentor.com>
 <20181025072349.15173-3-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181025072349.15173-3-jiada_wang@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 04:23:47PM +0900, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> Add device tree bindings for avb counter clock for Renesas
> R-Car Socs.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  .../bindings/clock/renesas,avb-clk.txt        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt b/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
> new file mode 100644
> index 000000000000..03bf50b5830c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
> @@ -0,0 +1,19 @@
> +* Renesas AVB Counter Clock
> +
> +The AVB Counter Clocks are provided by avb_counter8 Clock Generator,
> +avb_counter8 has dividers which operates with S0D1ϕ clock and has
> +8 output clocks.
> +
> +Required Properties:
> +  - compatible: Must be "renesas,clk-avb"

Should be SoC specific? 

If the h/w block is called "AVB Counter" then use "avb-counter" in the 
compatible string.

> +  - reg: Base address and length of the memory resource used by the AVB
> +  - #clock-cells: Must be 1
> +
> +Example
> +-------
> +
> +	clk_avb: avb-clock@ec5a011c {

clock-controller@...

> +		compatible = "renesas,clk-avb";
> +		reg = <0 0xec5a011c 0 0x24>;
> +		#clock-cells = <1>;
> +	};
> -- 
> 2.17.0
> 
