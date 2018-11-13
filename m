Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ADE2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ADE2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeKMMJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:09:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33004 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeKMMJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:09:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so2288385pgu.0;
        Mon, 12 Nov 2018 18:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0k1KvGfZa++BuE4FxkF6SPUnLfEwM/WP/oJEeVVx5iw=;
        b=cinSSnCy64ehECRBlcdpRxoWGK3Dz0BMg08nIxjT6s3EULQf8NFP2tKnahhVzGZ9sa
         M83Ti5XHy2scK17BhP6L80ZeF6mI1IxBqkGqKJxZefgKdjrqODvPXW/dK80PSE5TV9E/
         e3HIcR4LMFZxrKp5iFvZVprp+xnUDJXZom5g6Q1j/ogHEgcuobCQiLUT9qfSTnsIccF8
         UskNTnkxyHWgBNjrHufbo8lr8ZNcQg46umFgF4l4AHq02QWx4Vwellb6IQXl+sKPGezD
         i9oDxXHymUFuE5/IiaUIlTrQLJHBzBNI+kK07IZ66SgJ6A5tBUbU1ty1DfObfWlmJs++
         q+3g==
X-Gm-Message-State: AGRZ1gLBp0/0Z2Q5kWBk6lw9WMbg+6F3OHBSp81rzSc313OzJagt1DW3
        d+IkGgDNk3eTqyJ9JdYnCw==
X-Google-Smtp-Source: AJdET5c7vgi7/hNqOyoUehyyhSvyrHqlmCUdfxah0ifVGNJ8pV03Z+dcASpMRw8umaZ8YfQjsceVrg==
X-Received: by 2002:a62:c60a:: with SMTP id m10-v6mr3299132pfg.15.1542075219177;
        Mon, 12 Nov 2018 18:13:39 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id q35sm2760348pgk.12.2018.11.12.18.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 18:13:38 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:13:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
Message-ID: <20181113021337.GA7237@bogus>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
 <20181112152342.6561-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112152342.6561-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:23:39PM +0100, Benjamin Gaignard wrote:
> Add bindings for STM32 hardware spinlock device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Linaro or ST? Please make the author email match.

> ---
> version 3 :
> - fix clock name in properties description
> version 2 :
> - change clock name from hwspinlock to hsem to be align with hardware
>   documentation
> 
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> new file mode 100644
> index 000000000000..adf4f000ea3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> @@ -0,0 +1,23 @@
> +STM32 Hardware Spinlock Device Binding
> +-------------------------------------
> +
> +Required properties :
> +- compatible : should be "st,stm32-hwspinlock".
> +- reg : the register address of hwspinlock.
> +- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
> +	hwlock, so the number of cells should be <1> here.
> +- clock-names : Must contain "hsem".
> +- clocks : Must contain a phandle entry for the clock in clock-names, see the
> +	common clock bindings.
> +
> +Please look at the generic hwlock binding for usage information for consumers,
> +"Documentation/devicetree/bindings/hwlock/hwlock.txt"
> +
> +Example of hwlock provider:
> +	hwspinlock@4c000000 {
> +		compatible = "st,stm32-hwspinlock";
> +		#hwlock-cells = <1>;
> +		reg = <0x4c000000 0x400>;
> +		clocks = <&rcc HSEM>;
> +		clock-names = "hsem";
> +	};
> -- 
> 2.15.0
> 
