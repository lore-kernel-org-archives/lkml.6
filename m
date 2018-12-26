Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA99C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C50C2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsX2OGmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeLZTIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:08:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52772 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeLZTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:07:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so15154678wml.2;
        Wed, 26 Dec 2018 11:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALtQWJJu4IBpqbuXLkdpeeA6r1od8nvFyOKnNuiCE7M=;
        b=bsX2OGmd1+gLCNhqg3UXcK4i/kU9XRfEw/CfS/+FHH09UEFL/n8t7sO+Zap+2iI+x0
         3y93Esuzqvrf2x3GeYv1bDBv61WvQBYowQXhupBKWOtBJ4VEkAFmNWfBxuVwykjAaaEi
         cpzJsxeSH+kelv7Fw/VzMFX/nSD4s5qdrQEVJjv2yRmyfUgxJst7msesqU5PvV6rpflz
         4g9e+yX+TlB90bbSlz4eOh1/amSVK6VpzUa9pZTrfLAXLnpyozDVBn3RZPRyxxPzCCXz
         xi1UTL3RNWtYVd5WT1rAfxF5VUYPRMmocslpR0R2IzB2SMyCbJeW3LiKcZ5A/kk0a0wF
         rhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALtQWJJu4IBpqbuXLkdpeeA6r1od8nvFyOKnNuiCE7M=;
        b=rlLTOdPozc7mJQlWo2DoBzGHZ4aDgBJnPq2dbS2PSB+9Pk3LI5VU0Vz5T3nS2vtSYn
         boyG+Sv2QaZEvoW1mLpmXHVoh430unq6fDqRuAQXELT0rSXchqPGce/tIoTyo+lAM09x
         YLgAxgDbeBFAhnovTJKqnasQs32RdVzdIbAsJvM0GUTf7RMQDL6Ty00S/oEUMZLy1wTr
         x0UmnUo5lw//G/ebSSbk0nYo+gPIcGrO9ZZ3apYCq+GMMfEJtjzrl3J5wOrCCXY5zj8L
         58iJu0mZx3POE9QFMiMc/Q3qBYRPSVJDeDPCic4ZpPG6/vSiKY+AZ81boQyDyxfMIg2K
         sW2Q==
X-Gm-Message-State: AA+aEWbzjCUxWXfgr6PpQTln4rLPCehCQmLQ0+faDKBaD6wHzjG0txNB
        DdBV4d3XH7FSjdanNEVFb1U=
X-Google-Smtp-Source: ALg8bN7TY6RnBnIb/H4SPWRJQo4sgtvl5rDhUnCuw319+vhjW/cpESBdTN/6xcukLbpXVBa9I4CGpQ==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr18785453wmb.80.1545851273430;
        Wed, 26 Dec 2018 11:07:53 -0800 (PST)
Received: from [192.168.42.184] (cst-prg-83-217.cust.vodafone.cz. [46.135.83.217])
        by smtp.gmail.com with ESMTPSA id e9sm22044225wro.16.2018.12.26.11.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 11:07:52 -0800 (PST)
Subject: Re: [PATCH v4 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
 <1545634358-17485-3-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <13e662c5-7476-191c-35bb-c451ab900473@gmail.com>
Date:   Wed, 26 Dec 2018 20:07:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1545634358-17485-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/18 7:52 AM, Mason Yang wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..ba863d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC controller Device Tree Bindings
> +------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,r8a77995-rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "regs" and "dirmap"
> +- clock-names: should contain "rpc"
> +- clocks: should contain 1 entries for the module's clock
> +- renesas,rpc-mode: should contain "spi" for rpc spi mode or
> +			   	   "hyperflash" for rpc hyerflash mode.

We do not need special property to identify that the controller is in HF
mode, just attach CFI NOR node or JEDEC SPI NOR underneath it.

-- 
Best regards,
Marek Vasut
