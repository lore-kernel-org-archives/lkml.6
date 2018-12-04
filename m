Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32431C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3B420878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LElqGA/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3B420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeLECEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:04:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33652 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLECEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:04:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so10682931wmh.0;
        Tue, 04 Dec 2018 18:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mOy+nKu5z+rsGfEFNwh16KQcrlf0QFH4TwKHmcs0Qgg=;
        b=LElqGA/lWbIDX9Oic9QmaHhfogWzxnK7Vmc1vyjPJ8aFJta/rfC7odb30j7KSO2IN5
         I9QerJYYVbYtPwF9llJ/425IT6cxvgIQYCgLMEcrYNwGFaCHlFUkE8lxANwWEDh+se4K
         xSCnGmx/9WOfEcFq8etgry90goBFp9if5Rwz72ImxuaURYLXjdE9JVYDlByY9Nvo7xW/
         4saHxqWNqG8LDhnCHN+qPb+nM/AkXDNZiu9sV++j3b2ezTvwcKXTAyel5Qvf/PWFGery
         eS000ZbzntAaappehQdaDNQYFa5PVdc+sCi/DcVSKkUI47xWN/vBIf9l4HYIwravnbzE
         1akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOy+nKu5z+rsGfEFNwh16KQcrlf0QFH4TwKHmcs0Qgg=;
        b=iEbUywbtJgjaXOWn4NvK43qWKcN8zjsfh7nLLQiClLdY39iRrhl+SVECQIizFzP58J
         7axVo/b6+VWzMpq/A49TaCIY9hegfLhjw6oKahK6EY1NepyUrBXfyXXy9etBxG1HBGyS
         s0JiHQIhrBPQ3oDykOsfPUC3TzsRGoelMHbp6SrXq0KoNsc3uzV3HyI76lyMvJ59NIvB
         0nGqhdAJFaQSykpDj0hU9guF8k9mlwjGD0NmFbj65C3Re+3NoVDo4BaAtG3FH18Rw2UY
         dVGu2i+dVZyzK8PvdPGwj4Hss6w7IgK879zGtOm4j4/NEoGf83d6KVWx4zv05OKzo/YO
         o+5Q==
X-Gm-Message-State: AA+aEWY5FWdP8eqscde0CRtkx8Tqp0DzJqFH1rkiM3RdXNjOhQZO6RN3
        CRgLecmja+xA8VyyBR8frvpE5tU2
X-Google-Smtp-Source: AFSGD/Xtuzj8pRLmuYRZhkWnfHHmggbFNk1lBKkDfrhxr+epaxvple2UsGWkiTkrt50ah/fkvQJj9g==
X-Received: by 2002:a1c:8acd:: with SMTP id m196mr5255848wmd.120.1543975469365;
        Tue, 04 Dec 2018 18:04:29 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id d4sm13811001wrp.89.2018.12.04.18.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 18:04:28 -0800 (PST)
Subject: Re: [PATCH v2 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-3-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <2e719883-4cfd-b456-b894-853e99515092@gmail.com>
Date:   Tue, 4 Dec 2018 19:19:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1543828720-18345-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 10:18 AM, Mason Yang wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC SPI controller.

RPC is SPI and HF controller, it is not a pure SPI controller.

How does this deal with the HF part ? Keep in mind the bindings are ABI
and it will be difficult to redo them later.

> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..c6c6d9c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,35 @@
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
> +- interrupts: interrupt line connected to the RPC SPI controller

Not a SPI controller.

> +- clock-names: should contain "clk_rpc"
> +- clocks: should contain 1 entries for the module's clock
> +
> +Example:
> +
> +	rpc: spi@ee200000 {
> +		compatible = "renesas,r8a77995-rpc";
> +		reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
> +		reg-names = "rpc_regs", "dirmap";
> +		clocks = <&cpg CPG_MOD 917>;
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		clock-names = "clk_rpc";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <1>;
> +		};
> +	};
> 


-- 
Best regards,
Marek Vasut
