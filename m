Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD75C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A332521532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTLK4uCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A332521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeGDP1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:27:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43505 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeGDP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:27:34 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so11388566oib.10;
        Wed, 04 Jul 2018 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BxsPkYL62ZDz/2HDnESzvsWy4G+/uIQtZHfogE66V3k=;
        b=oTLK4uCxA9ySp7O6+kLtTqPJkIm0Pc60uzwcxF/kcgrreEaTN8QFET7EnV27zMvVLU
         tN6/FxCLviI6t/sPCgc2kYpd5GcZlPgvkSosDIp0faUhrabuLL6b2SldgJBKlyaGSi3o
         yeScdq0fnUbUHWZ4dDdTXEeeHl/fn+qA8Kek7IYi1WJ6K020UPkrq3Drxq9OxC/HTMrw
         p9aVXUXV58Rn2reZmAT//5JuhHgIJ30uotsu/XcxubD5LSYN957vL3x36cdNzwdbw8iO
         nGp7DPA36iKY+/MH1Uinz7EiNxG6B6JqIYBK2fg07Y72W5BVXfMmUUZ/pTRlMWM9nI29
         oy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxsPkYL62ZDz/2HDnESzvsWy4G+/uIQtZHfogE66V3k=;
        b=YCg1EknKghCmjLewci0jLcsnUMGg7y+bPYLbM4VfYTKzMvq76lOzQduPA7ZRXB5es4
         WZy2EsQddN6SzBIcEK6Zxq28ASWmKeGhj+YxZxrmVqxBaEssDngRYE+8IwGhJlZYwBcu
         G9EYhLBhTBcTBDbMGl+TOen1xBfoPgEs7Evv4fzZ20hdjDTbhZusfX4NuRBZF6pvdUQP
         220qBw36qpBSeZRpJ1toxS7pXe47efK6xjq+6ueAR+Ob2qzuI5doLJTgpoDzYjHkVyA3
         nkdJReeQFnnPZSvmxL+FYX2e/gAB/HW3zT58Bo+3x+6PffvkIH67N5965s/n2FuU5tcB
         I0Gg==
X-Gm-Message-State: APt69E0otWB50W/ZYJTs3qfmuQgM2zWl7VekYhpMj1a7i2XRpLQNvqCG
        s0su2aUrSeQ+KyHUEqk1UQbl786Q
X-Google-Smtp-Source: AAOMgpc4v4OqA/dMcmBaH0CNBSlMVCTLoYkWHHiqwVnN2EeC2qRDOpo4k5YkoeTNsK2qFoDpW0eK8A==
X-Received: by 2002:a54:4399:: with SMTP id u25-v6mr2484823oiv.187.1530718053842;
        Wed, 04 Jul 2018 08:27:33 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id e128-v6sm1398465oic.9.2018.07.04.08.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 08:27:32 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:27:26 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] MAINTAINERS: Add file patterns for serio device tree
 bindings
Message-ID: <20180704152726.uastaefdyzhlbhau@penguin>
References: <20180622100818.29420-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622100818.29420-1-geert@linux-m68k.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:08:18PM +0200, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Since nobody else did I'll pick it up, thank you Geert.

> ---
> v3:
>   - Update for next-20180622,
> 
> v2:
>   - Add Acked-by.
> 
> Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/serio/":
> 
> -Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:3/3=100%,authored:1/3=33%)
> -Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:1/3=33%)
> -Dmitry Torokhov <dmitry.torokhov@gmail.com> (commit_signer:1/3=33%)
> -Danilo Krummrich <danilokrummrich@dk-develop.de> (commit_signer:1/3=33%,authored:1/3=33%)
> -Linus Walleij <linus.walleij@linaro.org> (commit_signer:1/3=33%)
> -Mathieu Malaterre <malat@debian.org> (authored:1/3=33%)
> +Dmitry Torokhov <dmitry.torokhov@gmail.com> (maintainer:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...)
> +Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> +Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> +linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...)
>  devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  linux-kernel@vger.kernel.org (open list)
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 464d91879df89fce..df246daab5a27af2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7100,6 +7100,7 @@ F:	include/uapi/linux/input.h
>  F:	include/uapi/linux/input-event-codes.h
>  F:	include/linux/input/
>  F:	Documentation/devicetree/bindings/input/
> +F:	Documentation/devicetree/bindings/serio/
>  F:	Documentation/input/
>  
>  INPUT MULTITOUCH (MT) PROTOCOL
> -- 
> 2.17.1
> 

-- 
Dmitry
