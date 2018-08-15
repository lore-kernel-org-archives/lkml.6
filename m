Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E25C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364D921536
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364D921536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeHPBUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:20:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55005 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeHPBUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:20:14 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so3797490itb.4;
        Wed, 15 Aug 2018 15:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q8aaKb2FC2IMmTI0laW8Mfw6n4Hs0RqLYV4CjbQ00Y0=;
        b=PK7271FxGI1QMUZOtrCDxeDj/Lpz0cyyf83Pbvpr1Hv8sg8266rtZvAQdyopkMPOlW
         npna/rPep0lEvbJoan96I5fpFq9ERo46usGIIqs/8trvqfAtxxOs8QdbhZoRilXAKbyf
         nJRJ5ZuI2PT7DcBVuGsD6OjsZ+tpDsm6XQ+hi6nICtpxjlWvt3miZrR0lYIh9pFf0SRz
         5gmkZAHXb2/WKW+vNYCxreQZiVpuoQ3GAP+Keu5bCfEfKS1S8G4DBV5uLvTJpqn8+9kb
         ngXOtpPX+jlYougiDZfNjhdJtAYNy8lg0Lluogapa1e210oTTuT6vMoqHS9/DBthio3w
         3gVw==
X-Gm-Message-State: AOUpUlGOy++Qh7eUj0BCp0XMxEXNNeLxn0AU4uT5EOuoRBqAlib7/y8h
        3KxAcRMVguLwyNyv4QyiFw==
X-Google-Smtp-Source: AA+uWPxUyJhFr45iRAGBx2TUq6oek+I6RDn3VjKuJ0GfMbB4b/dWw5jbz4jjtX+10lw0kEh2fcb3cg==
X-Received: by 2002:a24:1a94:: with SMTP id 142-v6mr19096044iti.19.1534371965913;
        Wed, 15 Aug 2018 15:26:05 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b129-v6sm18981805ioa.75.2018.08.15.15.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 15:26:05 -0700 (PDT)
Date:   Wed, 15 Aug 2018 16:26:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org, heiko@sntech.de,
        devicetree@vger.kernel.org, Frank Wang <frank.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new
 rockchip,force-bvalid property.
Message-ID: <20180815222604.GB8193@rob-hp-laptop>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815095934.11205-5-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:59:34AM +0200, Enric Balletbo i Serra wrote:
> This property is used when the otg-id pin is not connected. When this
> property is set it forces to set the B-Device Session Valid bit when the
> port works as device and clears that bit when the port works as host.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> index 2d4808d3920b..55761f466c41 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> @@ -48,6 +48,11 @@ Optional properties:
>  		See ./phy-bindings.txt for details.
>   - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
>  			  Otherwise, use the bvalid register.
> + - rockchip,force-bvalid : boolean, set this to force the B-Device Session
> +			  Valid bit when the usb port is in device mode. This
> +			  is used when the otg-id pin is not connected.
> +			  Only supported in case of compatible being:
> +			  * "rockchip,rk3399-usb2phy"

Shouldn't you describe the property of the h/w that ID pin is not 
connected, rather than what you do with that information.

Is the pin not connected because it's a connector without ID pin? If so, 
that should be a property of the connector (or inferred from the 
connector compatible string).

Rob
