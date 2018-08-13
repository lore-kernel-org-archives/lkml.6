Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D052174D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D052174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbeHNBix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:38:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33486 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:38:53 -0400
Received: by mail-it0-f68.google.com with SMTP id d16-v6so12919901itj.0;
        Mon, 13 Aug 2018 15:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o4BqkkNGuBqDv2OcE+XTgaBXOVMATOrkE0XdxZQWwNI=;
        b=AG7jkmmIr13sxGb4t53U4vykR2xrRdxQE2SyVuJA18I/6syEYdFr1hRplR923FqMrx
         NMXeFszx0MiEKBdIzXK5ciMTVJPxo98HmrpWkl1GdXyt13Nz8IrbtZ1Rw8D8yzLP0mlP
         72SfJORHIe3WfiWnymXV0UyFfOXR40LFDABlJ8PeF+jQq/Cu+cuXRW3gpub2JjbB0CtA
         ZwncqcaPWvTaZSqTN7YjJmot+6FL224c9zJPEiFyGirSKQW38TE/hDy85ADwkbnIvfiv
         BH4pn92lhKxr+xu8UT68OJ0BE4TlQwQmKuRLVUHRv8lWPCy36wtlBPvugMqm0e4jENt8
         VxAw==
X-Gm-Message-State: AOUpUlEicnKk/E8mKR8P8H6I1WgbrCYq372KtaQgM70fLOHfoxWrG9jE
        xUjQHlgpM/6ji6QHZGyRjg==
X-Google-Smtp-Source: AA+uWPxfRaOl+qbGdnqOiLvoTmbct4G3Oa7te2tf4FQ3FLTA5smLMATLJj9mMvWuwrn43LfLpSgk1Q==
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr12020528itf.121.1534200874681;
        Mon, 13 Aug 2018 15:54:34 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z1-v6sm6981981itb.7.2018.08.13.15.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 15:54:34 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:54:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 3/4] dt-bindings: net: phy: mscc: vsc8531: fix missing
 "/bits/ 8" in example
Message-ID: <20180813225433.GA13768@rob-hp-laptop>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
 <20180730130236.3837-3-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730130236.3837-3-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:02:35PM +0200, Quentin Schulz wrote:
> The "vsc8531,led-N-mode" property is read as a u8 in the driver and
> there aren't a lot of modes anyway.
> 
> Without the "/bits/ 8" in front of the value of the property, the
> value is stored as an u32 resulting in of_read_property_u8 to always
> return 0.

Humm, I thought this would return an error if the size was wrong, but 
there must have been some reason otherwise.

> Fix the example so that people using the property can actually use it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Really, the driver should be changed to use u32 if that's what's already 
in use.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> index 664d9d0543fc..4c7d1d384df0 100644
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> @@ -63,6 +63,6 @@ Example:
>                  compatible = "ethernet-phy-id0007.0570";
>                  vsc8531,vddmac		= <3300>;
>                  vsc8531,edge-slowdown	= <7>;
> -                vsc8531,led-0-mode	= <LINK_1000_ACTIVITY>;
> -                vsc8531,led-1-mode	= <LINK_100_ACTIVITY>;
> +                vsc8531,led-0-mode	= /bits/ 8 <LINK_1000_ACTIVITY>;
> +                vsc8531,led-1-mode	= /bits/ 8 <LINK_100_ACTIVITY>;
>          };
> -- 
> 2.17.1
> 
