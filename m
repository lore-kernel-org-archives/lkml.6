Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C105C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6362086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564233;
	bh=/AMXk41S2ZZ0E2VDM4S48TFxNG7ffF6XfR40/HANBcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kupRpt7sBviTKowZNgimOup7aTfZijK+ar160iuKU7XgevktAxDZ4kI1fdLt7USOP
	 +/zhTbd28QT98N7RAC8lQGSf65mJyUroSzaa+qD3pd43BUx0CslP8td/+gKabOh9OP
	 ToxnmCgT5/9tfYsIOJQ2IZwnTNFWXy8pp/qVUc2g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6362086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeLKVhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:37:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46242 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:37:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so15544492otm.13;
        Tue, 11 Dec 2018 13:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PepBXr+qANNJfFZ6zQcKph6OwyVGdNYika4wYLc3n/Y=;
        b=br59yK5x0l3qCcVfV16FOqJm7A2JgC5uinHcoA+62rEL/hCZ0dXC0w7LCZsb/8qUl8
         NWJZ/PGHZ6EfPHBsUVZtJuCyza4iEZVQq4Eb6FvtyzUDP4QTQNfnxfP0fX3SrAnzR09I
         qqlai3dM9/Ao2YI+GJSrxzE8y6xXCg/WEvLCDIEs7RNhmqL3wOu9FWDtvrIfs8WgtxcY
         VhQJRiUg82zn5tOaeZlZ0YuRplEJGLELKUPiMGbXcnXx0ogXKkUER/IbYw/ArO00pLrz
         gq2Ai4cvYfc2KldsvvaCQn6VYmdHFRMzZnGvYomP2nKYx5ld/0NAna00kQEMiX3WRaUQ
         pn3A==
X-Gm-Message-State: AA+aEWap5346dq4OAKnxvir4WlFBBJK/T7vljStBh0mgLZhGRVpP80Ix
        /AcjPaKclY82xZEsA3/GsQ==
X-Google-Smtp-Source: AFSGD/XndeJWS+oy4Guvpj36jnU2qGNnRVkZFhMHEbH4IX7mqLr5mir3A9PSNGupVqM+q0GZ81/79Q==
X-Received: by 2002:a9d:67ce:: with SMTP id c14mr11669567otn.341.1544564230975;
        Tue, 11 Dec 2018 13:37:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m89sm8110357otc.35.2018.12.11.13.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:37:10 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:37:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     zoro <long17.cool@163.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: define vendor prefix for whwave, Inc.
Message-ID: <20181211213708.GA15257@bogus>
References: <1542968084-3982-1-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542968084-3982-1-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 06:14:42PM +0800, zoro wrote:
> Introduce vendor prefix for whwave, Inc.
> for SD3078 rtc device.
> 
> Signed-off-by: zoro <long17.cool@163.com>

Need a full name.

> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8..7d2e9b01 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -423,6 +423,7 @@ vot	Vision Optical Technology Co., Ltd.
>  wd	Western Digital Corp.
>  wetek	WeTek Electronics, limited.
>  wexler	Wexler
> +whwave	Shenzhen whwave Electronics crop

crop or Corp?

>  wi2wi	Wi2Wi, Inc.
>  winbond Winbond Electronics corp.
>  winstar	Winstar Display Corp.
> -- 
> 1.7.9.5
> 
> 
