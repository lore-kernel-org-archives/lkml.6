Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444C3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A792154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A792154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeI0FNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:13:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40022 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeI0FNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:13:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id j68-v6so560687oib.7;
        Wed, 26 Sep 2018 15:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xd5IYFfZpQHlcXedjaYwGPXG6qLNGSP4Z6hvMqjI7c8=;
        b=EuBmlH8s4M6VS4oIzrdo0YTaCEVK/zuvmtyhs7tB5LOL2L9l3iyO5PGsKXxlctzTht
         18kHw+VXNx/kuS6Gl7wqvOIE+c8lSCmvfxTXSr8UkalPyF3Z4rOg8kwOyZLqNlkTZeKS
         fNg7G+B33ghlIg7FpJttzhpbGeNEwsW2xc+bs1wkKcKosyWtiaaPJ7QtaIwuwCR2Jo0A
         TL2Nr0HmrPL8Ft1vU253kyMGLAkXwgdxE1nh6b4e4ORRmWWKJnu1RZYw4kPy2J8nTSyt
         hk4OlDJcdcIqcBghTMVWnRfW7UBdPk4rz8RxnSogyz3SdZZPkI7i9UPChDZh7ZEJ4TpV
         Z23Q==
X-Gm-Message-State: ABuFfojnmOEVDWOEnkt4omUAAs2sJNFiid27NBEKtPjsauzx9hZ0/Ifl
        o7TiBRPVc1sB6bXVkrcePw==
X-Google-Smtp-Source: ACcGV602F7DfzAJa4b7FqK6BLUTvJmaF0+fJEO+uU1vk0xUD78ayye/hz7ZHeDGxr6K4QEkmkNgLeQ==
X-Received: by 2002:aca:f558:: with SMTP id t85-v6mr1996180oih.299.1538002675322;
        Wed, 26 Sep 2018 15:57:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b125-v6sm120038oia.38.2018.09.26.15.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:57:54 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:57:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
Message-ID: <20180926225754.GA20472@bogus>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
 <1537363669-25991-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537363669-25991-2-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 03:27:43PM +0200, Amelie Delaunay wrote:
> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/mfd/stmfx.txt | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stmfx.txt b/Documentation/devicetree/bindings/mfd/stmfx.txt
> new file mode 100644
> index 0000000..21cf798
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stmfx.txt
> @@ -0,0 +1,28 @@
> +STMicroelectonics Multi-Function eXpander (STMFX) Core bindings
> +
> +ST Multi-Function eXpander (STMFX) is a slave controller using I2C for
> +communication with the main MCU. Its main features are GPIO expansion, main
> +MCU IDD measurement (IDD is the amount of current that flows through VDD) and
> +resistive touchscreen controller.
> +
> +Required properties:
> +- compatible: should be "st,stmfx-0300".
> +- reg: I2C slave address of the device.
> +- interrupt-parent: phandle of the STMFX parent interrupt controller.

Drop this. It is implied and could be in the parent.

> +- interrutps: interrupt specifier triggered by MFX_IRQ_OUT signal.

typo

> +
> +Optional properties:
> +- drive-open-drain: configure MFX_IRQ_OUT as open drain.
> +- vdd-supply: phandle of the regulator supplying STMFX.
> +
> +Example:
> +
> +	stmfx: stmfx@42 {
> +		compatible = "st,stmfx-0300";
> +		reg = <0x42>;
> +		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-parent = <&gpioi>;
> +		vdd-supply = <&v3v3>;
> +	};
> +
> +Please refer to ../pinctrl/pinctrl-stmfx.txt for STMFX GPIO expander function bindings.
> -- 
> 2.7.4
> 
