Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F1C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B642146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550090961;
	bh=wl/z2gTZAnFpZtz1U2rBxyEX3Jc+b1kItyxZEoQd65Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jHgRIM6p5jRRanOCZyPWHhvzDRuXjVrhpxF0p1VCE16ICmisd5K28QPztHN6+fOfu
	 Yw4Gv7+QviP+B3T1JtBDB2UbQBuR2lqO2/OhGHZPxgbuvoin2XXeSGQUFVnbdGzUGD
	 50aGRwsvUUaw4ulXQRxEf9s0GUGFrAuZl3dC2Rp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbfBMUtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:49:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36813 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfBMUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:49:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so6744326otk.3;
        Wed, 13 Feb 2019 12:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z8xBaIj/rE8Nn8G6IbVonYg6f7O5W/CmrGWHHmKjSFg=;
        b=cB7SIGnnlaGN+oBxpQoiUi4PwtmmmkmleHu9IcANbYZ8VOje+7JVesoF7BMywxfYmS
         1xKRa+MmGD8hes8X88/2JGMFnp+Q8zZ19jGg+1D9SmJeLsgn3Qor+sOSHX/nQ1Z9BXjh
         P2xk4DkDXdgE3xFrDFVwx6C0x5HrhX++gNgU9ttVnBWTIM3hkVFHBz63TSLs7TtC3f3a
         qR3H9dvQKVHAQ7mG8j/Nvg7lxeFmXiJSib+OP0LjaZmIj+IHrB7Umg0oWDzSVx0qYhUf
         1m+whcLedYPr6ii+m8Ns5ewHGd2EIpR8eHYMUkMcn/NJDvO/wPS3q4awtNb26JtDRmLS
         fGiw==
X-Gm-Message-State: AHQUAuZ9YlyiS0ooRWUq2uL37LD7nkbLukINvCoxScNCjHrrwLk/hgOR
        2LJXiFGCIVHtEet8wYuwBQ==
X-Google-Smtp-Source: AHgI3IasXIgtplKDzf6wmmNaePKPwbc6M7Aiai337M2lhUQkE9R09xz24XWgMHOZGtv27FGiLm8z9w==
X-Received: by 2002:a9d:53cb:: with SMTP id i11mr37456oth.79.1550090958340;
        Wed, 13 Feb 2019 12:49:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f25sm158361otp.8.2019.02.13.12.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:49:17 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:49:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 03/11] dt-bindings: leds: add DT bindings for max77650
Message-ID: <20190213204917.GA8192@bogus>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213134335.10838-4-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 14:43:27 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the LEDs module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
