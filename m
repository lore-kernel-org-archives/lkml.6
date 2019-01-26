Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003B0C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34CA21902
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHIj//tP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfAZB2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:28:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38607 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfAZB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:28:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so5333817plb.5;
        Fri, 25 Jan 2019 17:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aWviH/eVzJhNQJdE+Iu5XDsgDbK9WHfiAChh2DS0Lbk=;
        b=bHIj//tP2/P4EsPXfl1mZantJKvmNzYloNIPfGKBh9opc3R0J8Q5aj5VRBuYtMBs24
         swpAs44W1pAvRtEehEiliLqC+1xFZ/GFqjFEJptZqe1fv5X3Ry9ZhCLEOua5m419/+CI
         NYlT1i/BUbQYA9zxVs32WxP4BRv3LgHLNc98tjFASwQfiPDEcS9vNmxs9kJUs3oSua+i
         odmRCR5I/YMFDJ4vewnRUD3ND3vN0XkardeP7aRFz3VYP1SZf4+1rgeYKQZi5LAi9RUp
         u2XQT75TkPTj+N2jeXhkwjQ3BhHmIzAq9Ih4Lp1mWCFFEnR/a7p/tLxmEU11ExnGe61b
         Qk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aWviH/eVzJhNQJdE+Iu5XDsgDbK9WHfiAChh2DS0Lbk=;
        b=A3M+P7mVWxXXHhLfi9tAvtDPav28vxAGW7WMRBk0pWZ1VysJFHExUFN8mNDMnkFERk
         7yF6816sHbJKZPgsgQqY0hR2xKuY1xxoqjG7QzzPMxut9u8Hq5DSZoGvOweqPNq6Zi0P
         opGbsSIeTNxg566Lc2HMh4N3ojwAJhL5TrC0pYNpHFZZJHI6OKhc2+Jy9OgsnapfyRU2
         jx1onbMf4rRR5MAD8QbSDp71sD4xFseZZ44muHP+lgSho53PPfnnZGGbb7l97A8ByvAY
         wdLGZ0oBDA7YscZzt4MJYqIAHXFah1/voJqXpKLXXB0/LnBHX7GGbHmqFsvqBTs9ekw7
         26sA==
X-Gm-Message-State: AJcUukcx/Dec/UdrwJg5BIWZBvApZ/CX1BzCzKxWft9Hy1QW9ctgrFJc
        LHh7P+LkfdDZl/zY98RR2mo=
X-Google-Smtp-Source: ALg8bN7kJ1lDMBRcoNuNT3G3IH4rEzXBfsNglpuTPeXAd9+w2vW7yOCVRPvd8mWPJ5isFVd4s3wiUw==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6mr13284844plt.21.1548466085507;
        Fri, 25 Jan 2019 17:28:05 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r12sm27040856pgv.83.2019.01.25.17.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:28:04 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:28:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] input: dt-bindings: Add binding for bma150 sensor
Message-ID: <20190126012802.GD212026@dtor-ws>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 07:44:00PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Add device tree bindings for Bosch BMA150 Accelerometer Sensor
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../bindings/input/bosch,bma150.txt           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/bosch,bma150.txt b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> new file mode 100644
> index 000000000000..290c60e38c70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> @@ -0,0 +1,20 @@
> +* Bosch BMA150 Accelerometer Sensor
> +
> +Also works for the SMB380 and BMA023 accelerometers
> +
> +Required properties:
> +- compatible : Should be "bosch,bma150"
> +- reg : The I2C address of the sensor
> +
> +Optional properties:
> +- interrupt-parent : should be the phandle for the interrupt controller
> +- interrupts : Interrupt mapping for IRQ.  If not present device will be polled
> +
> +Example:
> +
> +bma150@38 {
> +	compatible = "bosch,bma150";
> +	reg = <0x38>;
> +	interrupt-parent = <&gph0>;
> +	interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;

Hmm, here you say that IRQ_TYPE_LEVEL_HIGH, so it is level interrupts,
but the driver overrides to rising edge unconditionally. Since you are
the first to add DT support please make separate patch to driver to drop
the ORQ trigger from request_theraded_irq() leaving only IRQF_ONESHOT.

Also please create patch removing platform data support as noone is
using it upstream.

What about the rest of config parameters from bma150_cfg? They should be
handled as device properties too.

Thanks.

-- 
Dmitry
