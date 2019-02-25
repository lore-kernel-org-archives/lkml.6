Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DB1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B802083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131602;
	bh=EyM7YRTb7A0+OJbIfRPE7bwYoXJCKTatqMt3uvV1qyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nFMScYxlBB4Cn2t90Fb93j2yEtKfhYggfgynhUMqzJ8tA+MN/bz2aX0eFO62AJBio
	 Z+PyPpQLhX3EZXcXu8jTUtrELfXhPso4pnncYIRv25KJyYU+dcTiWODpv3nZN1mGx8
	 AUxUoxZ4INjgvLNm7YtbWlamBQCb1j7ervUCUx90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfBYVxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:53:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44029 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfBYVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:53:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so9263052ota.10;
        Mon, 25 Feb 2019 13:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K4O527tzsm7XShHitjpGIEg9NcMvgTVnB6//0AW12Qc=;
        b=qdv3s04b2O2iLcvmB8XTu1RUH8dW2aZ6bjl8gYIT7/VBvzYNTrwW3hoiEDy55PQt7b
         rByK4MPJIUh4tFTkWL0NgM+BBQtPfEfrKhRwEF9/+yS57VQ+Lsdu3u0NBetapky8KN62
         W7P5IyjE7kS6lQwo5bAEDYcP/i4oIcFp9YEbTXsoVl6SagqOh3d2rWdfCT/hRF7LXQTO
         3A2/xNl81wTrT1x2eMHtU6Akfw0THEZzIudNnsKgN8QobQppQ8Gk0mF7xe6m05mrRuEn
         zu9HM8Qm4OqzZeOKGL6dz5hMV+QcgkmpLgQvpZoj3JXd6cUrkZmiuC1FlZ4soe7Y4Hb3
         1Y/Q==
X-Gm-Message-State: AHQUAuZUP9kbHqOFFaBoX5VKUO6TY/w1Uj7RYuJFF0vJRLbFik/gXVEF
        6wdJHxTHSWmI3cqdMMqB7HUg4F8=
X-Google-Smtp-Source: AHgI3IazMEr9NIvqdl6K2q3JiAHNoCnl3tfL40a+aLbs1PzRf8qTLi5Im2kXwDxcozvmTJVBhus6Og==
X-Received: by 2002:a9d:714c:: with SMTP id y12mr12935408otj.114.1551131598069;
        Mon, 25 Feb 2019 13:53:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w125sm4505574oiw.10.2019.02.25.13.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 13:53:17 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:53:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: Add
 status-gpios property
Message-ID: <20190225215316.GA10117@bogus>
References: <20190205190316.19296-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205190316.19296-1-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 08:03:15PM +0100, Artur Rojek wrote:
> Add documentation for the "status-gpios" property.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  .../devicetree/bindings/power/supply/gpio-charger.txt         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> index adbb5dc5b6e9..b98a05a4973c 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> @@ -14,12 +14,16 @@ Required properties :
>       usb-cdp (USB charging downstream port)
>       usb-aca (USB accessory charger adapter)
>  
> +Optional properties:
> + - status-gpios: GPIO indicating the charger status

So when it is asserted it has 'status'? What does status mean?

> +
>  Example:
>  
>  	usb_charger: charger {
>  		compatible = "gpio-charger";
>  		charger-type = "usb-sdp";
>  		gpios = <&gpf0 2 0 0 0>;
> +		status-gpios = <&gpf0 3 0 0 0>;

Humm, not sure what the thinking for 'gpios' was, but it's wrong and you 
just copied it. If we follow the normal cell encoding with 2 cells, this 
means the property takes 3 gpios (though the last 2 are marked not 
present with 0).

Rob
