Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4A1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8929520835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEtKg9kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8929520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeIAAjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:39:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43422 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIAAjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:39:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so5920090pgb.10;
        Fri, 31 Aug 2018 13:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ldiGGrYP80ooSTIetaruf2D6fGY92tqckOC8DqwUN08=;
        b=JEtKg9kB7bV41FClt5P/q4PnQuTbfebEcZhsBq46sOHxzwQ877Bx/shxDOQU2SY3RR
         KGCxFjBRPm5+xyfiu4pyNJv8kUAjR7U7Hkb9uZ9+c7gEoLwB6tEqduqjC1d7HpMHCRNM
         GfctW4Qg/uqfqMwq3fCB515lqGAiyJu6XuBPk+2Yhc9HBeJWgdR1+PYmjvTrBuuGwTO9
         PrGgGB/KgwHa/scCDqraAZsvrS1egDbNn/b6cJJWlt1tStze2TXWDQFkb4SPOKXf9zeD
         FF8/Ogkasu4N1R3v4uJmOVVeUWiUeuUF0ksdhpsv06IcfEFOziY+VosMKjAtVdtYqCHU
         gfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ldiGGrYP80ooSTIetaruf2D6fGY92tqckOC8DqwUN08=;
        b=RllOsS4LiC0HcQjwWrC3xgLg7K9Z3I2mQniRY2JVq4DnqnfzT4ELeMDswf7kwFQefh
         OJYDkycTP6L3HsAqBattrI0DLGh7tZLLzazTbDu78QA5mTxldMtLDBLBVVY9oyaBHfi2
         cPf4UKzzMNaa3jr+CpabYtewn7OLHdzzVcZT+qKEunQYzhzQhUZx3tkLsr+mx6WSNhRi
         yYZeJuIbZu0j1gcj03V5tQNonfzU/9vm4dmWN9YiIj9jBtXFhAYB4ongX0zh/ThFjF5P
         OXZAnBjtznUVaLEiJcimy9R7JuV268LkZLEWv0yDoU11p3Sdznwjv0Q0HrNuLqfS7pD9
         FZgQ==
X-Gm-Message-State: APzg51C67BrSD1clPM2FWVJ/eSmLHQnujVOk2kErDE0yX1v7dOLMtprQ
        a7GjFMcR1+gsh75PfqetiQw=
X-Google-Smtp-Source: ANB0VdaBpA0EFX5loZ9VFQFCM3GsWKbFWaiwX7yOm+9I0MPpHdJ/Y/hnI2lX2Aek+ahvT7+BV1XH8Q==
X-Received: by 2002:a65:5581:: with SMTP id j1-v6mr15623821pgs.203.1535747432704;
        Fri, 31 Aug 2018 13:30:32 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id g5-v6sm26841702pgn.73.2018.08.31.13.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:30:31 -0700 (PDT)
Date:   Fri, 31 Aug 2018 13:30:28 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        briannorris@chromium.org
Subject: Re: [PATCH v2 02/29] Documentation: nvmem: document lookup entries
Message-ID: <20180831203028.GC62862@ban.mtv.corp.google.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810080526.27207-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 10:04:59AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Describe the usage of nvmem cell lookup tables.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/nvmem/nvmem.txt | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
> index 8d8d8f58f96f..9d5e3ca2b4f3 100644
> --- a/Documentation/nvmem/nvmem.txt
> +++ b/Documentation/nvmem/nvmem.txt
> @@ -58,6 +58,34 @@ static int qfprom_probe(struct platform_device *pdev)
>  It is mandatory that the NVMEM provider has a regmap associated with its
>  struct device. Failure to do would return error code from nvmem_register().
>  
> +Additionally it is possible to create nvmem cell lookup entries and register
> +them with the nvmem framework from machine code as shown in the example below:

Maybe it's partially a lacking in the existing documentation, but what
does the "name" and the "nvmem_name" mean here? AFAICT, "nvmem_name" is
akin to a provider identifier; and "name" is a key to match with the
consumer. It feels like this should be in either the header / kerneldoc
or this file. Or maybe both.

Does this mean there can only be a single "mac-address" cell in the
system? I have systems where there are multiple MACs provided in flash
storage, and we need to map them to ethernet0 and ethernet1. Is that
supported here?

Brian

> +static struct nvmem_cell_lookup foobar_lookup = {
> +	.info = {
> +		.name = "mac-address",
> +		.offset = 0xd000,
> +		.bytes = ERH_ALEN,
> +	},
> +	.nvmem_name = "foobar",
> +};
> +
> +static void foobar_register(void)
> +{
> +	...
> +	nvmem_add_lookup_table(&foobar_lookup, 1);
> +	...
> +}
> +
> +A lookup entry table can be later removed if needed:
> +
> +static void foobar_fini(void)
> +{
> +	...
> +	nvmem_del_lookup_table(&foobar_lookup, 1);
> +	...
> +}
> +
>  NVMEM Consumers
>  +++++++++++++++
>  
> -- 
> 2.18.0
> 
