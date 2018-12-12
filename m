Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84933C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FB52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="aYYcbAmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FB52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeLLRr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:47:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39322 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeLLRr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:47:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so14189517lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T62NArK+cE6Vpw+OuBYIwmYSmizpgY+nNlXVJTamzBs=;
        b=aYYcbAmqSiOpWUjse6yog6IPOAdTDWmEVn+uR3h0oo0GYkPrOGLX0mXkqxr3uFhfM4
         VP4QNOiwGmb7QdAd+LO05OJhp1MUSmqlHawnL0klJLGuYDkusot9wDx6Jdd3jFBP9EJ5
         KsyEXs12akP6gPUhleEcAQxeAsEz4is2OrfJvWCf7uvaECNLgtfXKVjTzYYX9QlOf3LP
         Ie+CEWqh86l5346W4/PYyMuFE7x2ppRzipwB9VDbvlbEMzI1KMw+yR2qS2h/DHeFkXze
         9SWRiax+J5oBax8h2Imwt0+Fvnwi6mne/A4xE4rVLehSPBvFkq1ySCzld9i7vONGLNIW
         KPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T62NArK+cE6Vpw+OuBYIwmYSmizpgY+nNlXVJTamzBs=;
        b=KOlt4Uydyi01I1BppTuDQTiHYSsynK8zXpFuVmHw62stVYgYW73GJGg+LFwhwjX0Dp
         bVJwyJ09uPJ5kM1P6QGqLT4SbDH9qLMP5M1dvrnWlCOds2fsg5Ela19Aw43CcfiyjjOJ
         7vqrJQ46w2F8ExuV3IYTA5X9xRuJ6sWxN04HS9plUPEZLt1S8NUVzer9qO76uTiu4VLS
         s5A5SZrQNCcn+qYjERPULvn0dTSjVtljC1kjM5xBE+y3aW2pvrCoscWWkPghv16n2exg
         uKDhSAxi603zS6cziiGCZWos/OH3kMjU3zWSkTuWZ3XGMg/SBeNy2b8OZ8qk/+UXgLjm
         IjNg==
X-Gm-Message-State: AA+aEWaizwGzHQPILJJTcOu4xuCEDANHGqJbEedg7Nn73NcNcmmZnQ3D
        heEdqN8jaxln4u93Sh1cPTE4kA==
X-Google-Smtp-Source: AFSGD/WGQ19s8Vy8xLrgr5+9ldz8QXvb8VMk746RUZ9tFn4awNw4Z0xG0SXMMczzWr7+ULENX74IYQ==
X-Received: by 2002:a19:8d01:: with SMTP id p1mr11573167lfd.149.1544636876123;
        Wed, 12 Dec 2018 09:47:56 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.85.181])
        by smtp.gmail.com with ESMTPSA id z15-v6sm3725538ljb.9.2018.12.12.09.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 09:47:55 -0800 (PST)
Subject: Re: [PATCH v3 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b7082295-51b6-110f-d29b-734c90861f8a@cogentembedded.com>
Date:   Wed, 12 Dec 2018 20:47:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2018 02:13 PM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..a191f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,38 @@
> +Renesas R-Car Gen3 RPC controller Device Tree Bindings
> +------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,r8a77995-rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "rpc_regs" and "dirmap"
> +- interrupts: interrupt line connected to the RPC controller

   Required prop but it's missing in your example below...

> +- clock-names: should contain "clk_rpc"
> +- clocks: should contain 1 entries for the module's clock
> +- rpc-mode: should contain "rpc-spi-flash" for rpc spi mode or
> +			   "rpc-hyperflash" for rpc hyerflash mode.
> +
> +Example:
> +
> +	rpc: rpc@ee200000 {
> +		compatible = "renesas,r8a77995-rpc";
> +		reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
> +		reg-names = "rpc_regs", "dirmap";
> +		clocks = <&cpg CPG_MOD 917>;
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		clock-names = "clk_rpc";
> +		rpc-mode = "rpc-spi-flash";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
[...]

MBR, Sergei
