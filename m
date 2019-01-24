Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEEEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD0021872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIzut68e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfAXBy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:54:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46810 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfAXBy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:54:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so2129164pfe.13;
        Wed, 23 Jan 2019 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C/RWdEWtcXqv09yZfo3xaOYv9BJ0xoIdTiDIBYCMlGw=;
        b=sIzut68e0BuwC1nGt6/N0feI0fXI3nE7ha2LT5C/rC4CEb6bPhRsTHaD3anmK6/0VS
         2o557h2kcCNvNCLTufYGfTKvsIhXYOYh2jDuC8bytkrhEmLZbrMfxLg7h3p7XGIuZ9s0
         DFO4FUwSt/JsTP7iw3zvB2K18FrLLnb+hELWKNNIEOESLYQH7ZVw493+sC9tNtc4L+EG
         lS+eN8I1Avr7p5urF+ZMr+Wq7+mRgeahtg9wCwYsAjIb5JGJmEvj5k9s2Le2m5OzNBNb
         YrWXiy5KuCJWVDXUyTCUvWXfx8U9T2Gc0NA3dNMuAJBs5otqd3qnlEJ8lYnvpv8L36R/
         kIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C/RWdEWtcXqv09yZfo3xaOYv9BJ0xoIdTiDIBYCMlGw=;
        b=BET24BrwxYFbe48BV7LIVMYJJATzYRaiOOOvkISAdALpsjN770h/wIxLvUCJpmOMaz
         3Mgx4WIBBFSIgs9X5E1YjvICD/TLcdzx6ORIaRmwgCcsFUh3LBRySczSAPCrTWQLcpsX
         V7ddVKxA5J4//eJxHekLr2B0cg6ZqsKkdBj7y3Mb9/a3jOkviVtb9jeJA3mR3ZVpTWPs
         j6MYauIjhqTpFO0SukoQDm593d0DnJFveYX8UaaSdLeuyjKOGokbuZquq+axAK9ln7N9
         FHFNG09IpRILX0UKqE4SyKTJBbhoRWE13+J/BJeo0t7xOQ4FxhgObiyHaqxsbssx76lL
         hp2A==
X-Gm-Message-State: AJcUukdulzbpAQhqHk/KXLPmRe+Cya5LGSwX7e3lVmztsAxWXCkzI0UU
        +gi+EonMGhULkv5X6reJACA=
X-Google-Smtp-Source: ALg8bN58pXX3doc6MMonoUB5yQTOYfdlsmVuMgTEBDTormeKjtdpm3RmVx7b+kQ9RhNcgC7IivV5tg==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr4067744pgh.206.1548294867409;
        Wed, 23 Jan 2019 17:54:27 -0800 (PST)
Received: from [192.168.43.97] ([121.90.236.7])
        by smtp.gmail.com with ESMTPSA id f64sm65064896pfh.0.2019.01.23.17.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 17:54:26 -0800 (PST)
Subject: Re: [PATCH v7 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-3-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <ba02ea43-83ce-7e3c-6910-73f2e78f51cf@gmail.com>
Date:   Thu, 24 Jan 2019 02:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548227352-14910-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 8:09 AM, Mason Yang wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..305bd10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,46 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +--------------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback, i.e.,
> +		"renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc".
> +		"renesas,r8a7795-rpc"	(R-Car H3)
> +		"renesas,r8a7796-rpc"	(R-Car M3-W)
> +		"renesas,r8a77965-rpc"	(R-Car M3-N)
> +		"renesas,r8a77970-rpc"	(R-Car V3M)
> +		"renesas,r8a77980-rpc"	(R-Car V3H)
> +		"renesas,r8a77990-rpc"	(R-Car E3)
> +		"renesas,r8a77995-rpc"	(R-Car D3)

Was it tested on all of those SoCs and do we already handle all the
quirks of those ?

> +- reg: should contain three register areas:
> +	first for the base address of rpc-if registers,
> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +
> +	rpc: rpc@ee200000 {
> +		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +		      <0 0xee208000 0 0x100>;
> +		reg-names = "regs", "dirmap", "wbuf";
> +		clocks = <&cpg CPG_MOD 917>;
> +		clock-names = "rpc";
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <1>;

Is the bus width really 1 or is it 4 on the D3 ?

> +		};
> +	};
> 


-- 
Best regards,
Marek Vasut
