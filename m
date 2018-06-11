Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 94BE6C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F180208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo1gmsv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F180208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754258AbeFKWg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:36:56 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36848 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeFKWgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:36:53 -0400
Received: by mail-qk0-f194.google.com with SMTP id a195-v6so13975197qkg.3;
        Mon, 11 Jun 2018 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73ahWO3pezv4xnJqd30LTE7g+eeJWF3+p3XL97ScRuU=;
        b=uo1gmsv9zK6FIK0CdRX40wW6vLdB1FGhMpd1mO04+O7WZSDwhb6Yof80jZ3TSyjucB
         vrPnm9RWlLF9aUEouSaU+ZgbrGM87vAmKFw7J9ea7C/ehv1KMNgB+9/oRZtYaFabPIa5
         uJalT05djozCmTqJ9vOdN0TjNfkvbBAp05sExYJypxCQtKpmPah0W7RkrtFYby4sXmAX
         O0i+bHIzg3IHiGnR878lerAp9WrzEGStGtpoi/q1V2cvp1kFDKMpmwuJzdaugJ59/1rd
         Kg+ggEiCxj65ICcbXDDMF9bV91wvDakOkiTvf7y5aSgFs/fgV6iFR9RMpeekkwDZnNy8
         M6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=73ahWO3pezv4xnJqd30LTE7g+eeJWF3+p3XL97ScRuU=;
        b=UblxBxRnGlh+0JHslOQNjh0NzGmG0pPpiApSUDpZf1KDN5JyYKg7D5wiqcMmDtznc8
         7jJ1iaKmMPmVFW7JWka93urG2qgS+AyT+4VWRd3Rfw20lLa19jWFATjg7Uuknz1HhSlg
         RTKqrWb5FxGSvWcGTmv4MXGO7bWsVZoYPgkzmEtqd2gYDUFGRd1+Mi1UXdlkafnG7oz9
         ep6npCNBFhjVwRKxzJMzPSoaN9x+hbMCbRGeIsBeBKFtsyZiSlAQKo5XDByfINQk7PbC
         P7/vHpkMjCyJnrHwvBeuvoYg7cGcQ4rXYqGYrBVXzfVRAi4Eodut/0Zgsd7NuZFJmKI1
         X4bA==
X-Gm-Message-State: APt69E1/ABCyCwvbGvU3Nh0WsfwyfU4n68dzBW7mQObTwdyttyHqr0yR
        eTJf7fwalp0lSh8Lf04q5Ps=
X-Google-Smtp-Source: ADUXVKL4LPhy6Hb8uc2ZR/pToITY7xSn9UZXZFxRORgJav8dhQa8yjnfrVO6eQ9V1KJPdq82mT/WTA==
X-Received: by 2002:a37:b8c4:: with SMTP id i187-v6mr1052616qkf.412.1528756612769;
        Mon, 11 Jun 2018 15:36:52 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id k30-v6sm23157795qtc.31.2018.06.11.15.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 15:36:51 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
To:     Ray Jui <ray.jui@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com>
Date:   Mon, 11 Jun 2018 15:36:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 02:58 PM, Ray Jui wrote:
> Change the PCIe INTx mapping to model the 4 INTx interrupts in the
> IRQ domain of the iProc PCIe controller itself
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 699fdf9..6de21ef 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -254,9 +254,14 @@
>  			compatible = "brcm,iproc-pcie";
>  			reg = <0x18012000 0x1000>;
>  
> +			interrupt-controller;
>  			#interrupt-cells = <1>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie0 1>,
> +					<0 0 0 2 &pcie0 2>,
> +					<0 0 0 3 &pcie0 3>,
> +					<0 0 0 4 &pcie0 4>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;

You would want to fix those IRQ_TYPE_NONE values as well because since
commit 83a86fbb5b56b5eed8a476cc3fe214077d7c4f49 ("irqchip/gic: Loudly
complain about the use of IRQ_TYPE_NONE") this is going to create some
nice warnings on boot.

I am about to send fixes for NSP and HR2 since that's what I have access
to at the moment, but it would be good if you could send updates to the
Cygnus and NS2 DTS files?

Thanks

>  
>  			linux,pci-domain = <0>;
>  
> @@ -289,9 +294,14 @@
>  			compatible = "brcm,iproc-pcie";
>  			reg = <0x18013000 0x1000>;
>  
> +			interrupt-controller;
>  			#interrupt-cells = <1>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie1 1>,
> +					<0 0 0 2 &pcie1 2>,
> +					<0 0 0 3 &pcie1 3>,
> +					<0 0 0 4 &pcie1 4>;
> +			interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>  
>  			linux,pci-domain = <1>;
>  
> 


-- 
Florian
