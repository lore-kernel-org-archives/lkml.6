Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3546DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D8220825
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D8220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeKRCCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:02:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39936 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRCCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:02:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id t3-v6so4208047oie.7;
        Sat, 17 Nov 2018 07:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=he5om3JNz3/2R3lpejAsnp5FAo6lFogASW5U734ntHc=;
        b=SEn6GArnP4hOWtTlbCE7LPMKY94cQVwJqm0cml/OKJaTBkc7AJYei5Fx/QZ7J4f1L1
         iiDqZ7R5p0MJxTRDjNgNcHShVqj+CZ4dkce2PaG2gmS6D0PolIIRUDFlTqkWFxt1zDdo
         eG0GuvBwBLx1irEHqFHQ5a5G9A1AZ+6QQhkeFLJB/VjodGgp484fjgi3oYhBLQHoQVu0
         Q4fAdYPLNDFizzpZgfO2myo28bbo7WovZcuryjdb/KrUvz/ATNVT+36kdZJ66KTAy6gn
         4ym7tuEx6cQ1vr/mw4ObvTAEy2Je6TPyvxYQl3YoqfsMZ9X0QfkqpEdzot5pg3BFyYeY
         ITIA==
X-Gm-Message-State: AGRZ1gJEPwAP2WsBjL2AaGTC83keSR8QFEobbuf1W8LJUtAmrxXa/I3V
        iyLQYHphf+Wdvwxf4ycu8L7rTQU=
X-Google-Smtp-Source: AJdET5ffJqyHhR5GokUJtNL9FhOEQVRjij60KIyrT1338LRbQwTValmx4niCnr1yoGJ6LgndB6Z9AQ==
X-Received: by 2002:aca:ac56:: with SMTP id v83mr3261702oie.265.1542469534053;
        Sat, 17 Nov 2018 07:45:34 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id u12sm18500172otf.61.2018.11.17.07.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 07:45:33 -0800 (PST)
Date:   Sat, 17 Nov 2018 09:45:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 12/25] of: net: kill of_get_nvmem_mac_address()
Message-ID: <20181117154531.GA7306@bogus>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181113140133.17385-13-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113140133.17385-13-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 15:01:20 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We've switched all users to nvmem_get_mac_address(). Remove the now
> dead code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/of/of_net.c    | 39 ---------------------------------------
>  include/linux/of_net.h |  6 ------
>  2 files changed, 45 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
