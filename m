Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAC3C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746BF2150E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/FJoKYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746BF2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIWC3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:29:44 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38892 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeIWC3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:29:44 -0400
Received: by mail-it1-f196.google.com with SMTP id p129-v6so6093803ite.3;
        Sat, 22 Sep 2018 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mXaUNm8GtMFIYQ3CNWiH7wgfTU4sP1q3uTBCV9jU37A=;
        b=X/FJoKYzfk9NXHgDJTRPwluScMZn3P9OnDIJmCKmWX0P+6ifRsF2i1LDWzWNk4sYda
         gKX9bhpe+uoNlmTyH8K16d/m/ka8Rh6YAhcaEcTv892mGqCGb4qjvsQ/szqK2tmSAvQw
         yC7yZAtathzYyC4DbpIH10QfVwl9xu/prR7tHIIV/djBx+iB7DJx7WvZGvlZ/StfljCI
         GIUDE7+1lcQAeSQMI93Ci1P/a5ueJOC2fe6ZwZyYrwm4MNsbBMV7KBvtqGYJVdQ53gyN
         JJMH55mucPuCj1VyLQj8Wt3jCeXKSTxKSkRTXYbkk5e3OpiIcf8e2eKG3iDoUF0D1h8n
         MVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mXaUNm8GtMFIYQ3CNWiH7wgfTU4sP1q3uTBCV9jU37A=;
        b=snCitZVapNODFdiOJiDatfXW0LUnRya3Z0t17Ga5EfwkP4QuKWAw/qACXLMi1f2FGU
         BUCoIzbmiOvHh4EcPW7eD4/vhS37d6RFIzTWjh49OtLjTUEJHyWOHGukev38S69kX+6B
         GzoSkyUvkl69/7LM35bIBCA/9rRyEeA7uC9SDkdjTKHYsdXgtIU2JWfyDriwYXIRvCZF
         aiZEapd83Gt5vew+eTETtVIxUIX3wFG5wMgw6fawSmXh40fs5vMenMQ56tXZHfyDxEt3
         ap+OlebLD7gf5xUGLBWSO+ixDjF5N1WqUbhfmSrqDSJytBCGVNpPYOEZG19qCF0RLQN4
         GmZw==
X-Gm-Message-State: APzg51DBJHKKguW262C7QizH6JMyu1P57Tp0LpwxoIIqBH/8u2jLl9fw
        jWM1uJkZln6SSa8OvM/HgA==
X-Google-Smtp-Source: ACcGV62h0CyZX6oYzA+HitLRLSNlEQU74FOuITx/9+3v4v00gXNL2yIsYpxGXF/7OnDcQ5wzhOxN8g==
X-Received: by 2002:a24:ed84:: with SMTP id r126-v6mr2846831ith.58.1537648492671;
        Sat, 22 Sep 2018 13:34:52 -0700 (PDT)
Received: from r (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id i129-v6sm4056691ita.12.2018.09.22.13.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 13:34:51 -0700 (PDT)
Date:   Sat, 22 Sep 2018 16:34:49 -0400
From:   r yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180922203449.GA20818@r>
References: <20180922195922.24791-1-decatf@gmail.com>
 <20180922195922.24791-2-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922195922.24791-2-decatf@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 03:59:22PM -0400, ryang wrote:
> Add device tree support for ROHM BH1750 series ambient light sensors.
> 
> Signed-off-by: ryang <decatf@gmail.com>
> ---
> Changes in v2:
>      - Export module device table
> 
>  drivers/iio/light/bh1750.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index c3a481452b67..ffe2e6d9c2e4 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -307,9 +307,20 @@ static const struct i2c_device_id bh1750_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, bh1750_id);
>  
> +static const struct of_device_id bh1750_of_match[] = {
> +	{ .compatible = "rohm,bh1710", },
> +	{ .compatible = "rohm,bh1715", },
> +	{ .compatible = "rohm,bh1721", },
> +	{ .compatible = "rohm,bh1750", },
> +	{ .compatible = "rohm,bh1751", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bh1750_of_match);
> +
>  static struct i2c_driver bh1750_driver = {
>  	.driver = {
>  		.name = "bh1750",
> +		.of_match_table = of_match_ptr(bh1750_of_match),

Jonathan,

Don't take this patch. I realized that of_match_ptr is NULL when _not_
using CONFIG_OF. So that macro shouldn't be used. Apologies for the bit
of mess. I'll send a V3 shortly.

>  		.pm = &bh1750_pm_ops,
>  	},
>  	.probe = bh1750_probe,
> -- 
> 2.17.1
> 
