Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE2D2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE2D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeLDWmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:42:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42814 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:42:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so15806050oiw.9;
        Tue, 04 Dec 2018 14:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sfr36HrxhHVw9f8HvrebOpbNQ52taodGbinnnAtmJUI=;
        b=SNYqcksd0ZU8izHk02r6pJUu/GaeubhIAWHzXpkGMmpMtQCgm184sxIZiQS9NQi3m1
         l3J5SENp78hwsUaRm10ZjZkGncvs3sQxCRiWXuWltIpiXp0nl1+3485TjeXFMBqZIwAg
         AEheBkyHbytL1KfZ9Fo+nCshJ3x5+tDwLA97Ms+LofUuYlAipPfz6zShqy77kYgIfA2U
         VYUcERLumHoH4xB9PRXjXORvvUJZ4cZfGgRJhN7m31Oj+67SHaEsrnkRMlQx0//VOITQ
         U6DfzTTzKc67oqoww8AtJUTz7I5jLJw3bbGlQHF1/dNnP+pSlyr2Lm+k0X9H83NOmyko
         Rl0w==
X-Gm-Message-State: AA+aEWYJVRqMo2hO5Kti/UQi7foC/7B+EFmD6FBYK7KgaQ7Lgui8E3lj
        9pAUxBYL1Hb1dZAznvCd8g==
X-Google-Smtp-Source: AFSGD/X1aFmNWQzmSBKfnDIbXg4mx+s6HHC1Zrh+lcuXc2nLmhy+b8TgkZVMjErkES5y2pMk9FPxsw==
X-Received: by 2002:aca:1e17:: with SMTP id m23mr14119496oic.332.1543963320303;
        Tue, 04 Dec 2018 14:42:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j33sm14907502ota.32.2018.12.04.14.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 14:41:59 -0800 (PST)
Date:   Tue, 4 Dec 2018 16:41:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [RFC PATCH v2 03/15] dt-bindings: add binding for USBSS-DRD
 controller.
Message-ID: <20181204224158.GA29726@bogus>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-4-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542535751-16079-4-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:08:59AM +0000, Pawel Laszczak wrote:
> Thsi patch aim at documenting USB related dt-bindings for the

typo

> Cadence USBSS-DRD controller.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  .../devicetree/bindings/usb/cdns3-usb.txt       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> new file mode 100644
> index 000000000000..f9e953f32d47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> @@ -0,0 +1,17 @@
> +Binding for the Cadence USBSS-DRD controller
> +
> +Required properties:
> +  - reg: Physical base address and size of the controller's register area.

1 or 3 regions? If 3, what is each one and the order?

> +  - compatible: Should contain: "cdns,usb3"

Only one version and one set of bugs?

> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.

How many interrupts?

> +
> +
> +Example:
> +	cdns3@f3000000 {

usb@...

> +		compatible = "cdns,usb3";
> +		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0xf3000000 0x10000	//memory area for OTG/DRD registers
> +			0xf3010000 0x10000	//memory area for HOST registers
> +			0xf3020000 0x10000>;	//memory area for Device registers
> +	};
> +
> -- 
> 2.17.1
> 
