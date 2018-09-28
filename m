Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89114C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2F320657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvx3Vlk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2F320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeI2GZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:25:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36586 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2GZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:25:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so2006472pgv.3;
        Fri, 28 Sep 2018 16:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1UVCtdWpRywT+tTV8ofT9lSBXceGn2XnP4KgMTNJK6U=;
        b=Mvx3Vlk33rvSTPjoL8cR1wEZc9cw22rqad3lRCO/aLiJBJQ/AK88fsvacQF9tppzOf
         jCwKMr7uf6UXczdwn1I4Sya99fOPb+w6RWY6j3zeppDzCRFZ5JQVf8ye9jkHF7Q/M4zM
         /QMc08krcsaEcCmjYyQ7sqXwsecMvC39gYhP4WdiN80NJ/1m3F3wv1fDNRZqHNaZCoTR
         Kx+L0vqkq/E6VqFuVW4K+uI6aNFqwSlfNnJRaBsO6Mc34ulPZS0J368uqxA6YsvFWw0X
         ROzgJrQHMpQn99gDaQYtoibQfikLN4CAPjoeR6VN4GwArRt8ttPbh/kKdHl+Kn3Ol7/s
         WOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1UVCtdWpRywT+tTV8ofT9lSBXceGn2XnP4KgMTNJK6U=;
        b=JDHw0XCy26scf0Q0IOy3RLIWWLxcBd9u0zSKuES75Ez2ADTTkZQeMzDXWvoEcZFgh1
         pYBp2wuvwT0cUrYZxavFl38TnW1PLZGQe5quzpuJ5Hdvok8kiumma5ueK0r3w6AYVj8G
         KHzDpd+Z0a1k8xjRT/wVYOgxgxHNetOLqvxoTZlhyrAWxIJhh50ntt5L8oHzhTvXawoc
         aL4o9yZhpVEkRDfm9e4tq1uqAO5lpO1f0egsqR96PJf9ScmVmO72ELuWRHZNvi847lwd
         z9lraKj7BpQ9FoW3eRdi3TNQj4H03O7UyCsp2Eem2/WD8hvfC3BM0gkOJBBxS3P/6uDY
         NkJQ==
X-Gm-Message-State: ABuFfoiaDYXGqEVCpdPGuvx6NuLiYHoAnyrvAMHzEY/W5i65WmJ2v5Rg
        Byp+wkNN+d9TVLourbt4dkAsUxHNY6I=
X-Google-Smtp-Source: ACcGV61XcRnHQ3BOzE8A1npkNZ6/HcURJTokaefJy//0Y7u7BsL31FQYAbAYVGCWwHzwAMVioRd4vA==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr826368plq.77.1538179159103;
        Fri, 28 Sep 2018 16:59:19 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t69-v6sm10727702pgd.43.2018.09.28.16.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 16:59:18 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:59:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] input: sun4i-lradc: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180928235916.GA182370@dtor-ws>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-23-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-23-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:52:24PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/sun4i-lradc-keys.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
> index a37c172452e6..57272df34cd5 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -185,19 +185,19 @@ static int sun4i_lradc_load_dt_keymap(struct device *dev,
>  
>  		error = of_property_read_u32(pp, "channel", &channel);
>  		if (error || channel != 0) {
> -			dev_err(dev, "%s: Inval channel prop\n", pp->name);
> +			dev_err(dev, "%pOFn: Inval channel prop\n", pp);
>  			return -EINVAL;
>  		}
>  
>  		error = of_property_read_u32(pp, "voltage", &map->voltage);
>  		if (error) {
> -			dev_err(dev, "%s: Inval voltage prop\n", pp->name);
> +			dev_err(dev, "%pOFn: Inval voltage prop\n", pp);
>  			return -EINVAL;
>  		}
>  
>  		error = of_property_read_u32(pp, "linux,code", &map->keycode);
>  		if (error) {
> -			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
> +			dev_err(dev, "%pOFn: Inval linux,code prop\n", pp);
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
> 

-- 
Dmitry
