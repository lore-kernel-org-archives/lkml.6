Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37005C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE91F218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545336076;
	bh=Kjplz9ZA7IwbwZHSPBvUNwVv/Uf7CYkybDnHHIWpqjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rkjR0oT7vxYUYZGA4PerSCXmVvGXeOdyuvs2DRwKzIEY9cjpFU7EQ9B1IS3mc2+1E
	 udLr7Y2e1FJrFpKwl6I2h02LyPbLvOYwKBseNDXSD3b86Xw+3QMGLrZtLDkeLj4rbc
	 R9O0SCnZF3RssBfdKyBQRbQFbUIFX0CaCDgtT5e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbeLTUBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:01:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39197 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLTUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:01:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so2902988oia.6;
        Thu, 20 Dec 2018 12:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t3MrXUDVNap07upDxL0l4FILJcfu7jgTbXMFe35+0rg=;
        b=pctNTt3IaoXKmNK9KNKsiSh7zuJMivEQaW/zbIT0hTBIEXsIOlarD2lQLjgNW1kReo
         QVLc1BTsOwFGTE5TCnaxW0bcqPnpwH2kyCTmwYFIpcT8xSbNNIb6oco4hMFTlKy1dJo6
         8sHkT3L4nwNjcC+paf+vpA5Nie/1wXJf5kcwJYpA+fkttHYTDrtrSR94Hh9dubHmDp0x
         JYD8FpLn47WiCOr2ubYqrkyyZeD1OlDfhdaAHlXzy/7bFXfLCDrqHv2pv/kULWf3QVTB
         7flvBmUzERg+xz6UL0Ph7qXeVxRTaSxGD7nKuQOFgHREedfFWycJqA+W6gipZsisf2Fb
         eBvg==
X-Gm-Message-State: AA+aEWbKBG9dYwz17lzVyS0DhKuzJFGx1CuFfBZlfnzljhPQRnJe3Jrs
        0aNlVlUMbZEGElhw5mvM5A==
X-Google-Smtp-Source: AFSGD/X5CCL8SSYoWWflQ55l4RxdiwlY0diYXSD+FaEmPPTqVlSzWQrw+U1GU9oMvzBD5tHZmLpR1A==
X-Received: by 2002:aca:4b4f:: with SMTP id y76mr99969oia.88.1545336073491;
        Thu, 20 Dec 2018 12:01:13 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id t2sm10484374otl.4.2018.12.20.12.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:01:12 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:01:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, balbi@kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD controller.
Message-ID: <20181220200111.GA27998@bogus>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-2-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544445555-17325-2-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 12:39:14PM +0000, Pawel Laszczak wrote:
> This patch aim at documenting USB related dt-bindings for the
> Cadence USBSS-DRD controller.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  .../devicetree/bindings/usb/cdns3-usb.txt     | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> new file mode 100644
> index 000000000000..ae4a255f0b10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt

cdns-usb3.txt?

> @@ -0,0 +1,31 @@
> +Binding for the Cadence USBSS-DRD controller
> +
> +Required properties:
> +  - reg: Physical base address and size of the controller's register areas.
> +	 Controller has 3 different regions:
> +	 region 1 - HOST registers area
> +	 region 2 - DEVICE registers area
> +	 region 3 - OTG/DRD registers area
> +  - compatible: Should contain: "cdns,usb3"

Only 1 version of the IP block?

> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
> +		Driver supports only single interrupt line.
> +                This single interrupt is shared between Device,
> +		host and OTG/DRD part of driver.
> +
> +Optional propertiesi:

typo

> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
> +                   "full-speed"; refer to usb/generic.txt
> + - dr_mode: Should be one of "host", "peripheral" or "otg".
> + - phys: reference to the USB PHY
> + - phy-names: name of the USB PHY, should be "cdns3,usbphy"

Don't need -names when there is only one.

> +
> +
> +Example:
> +	usb@f3000000 {
> +		compatible = "cdns,usb3";
> +		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0xf3000000 0x10000	//memory area for HOST registers
> +			0xf3010000 0x10000	//memory area for DEVICE registers
> +			0xf3020000 0x10000>;	//memory area for OTG/DRD registers
> +	};
> +
> -- 
> 2.17.1
> 
