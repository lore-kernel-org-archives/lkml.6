Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /+mQEs3nGFsyTAAAmS7hNA
	; Thu, 07 Jun 2018 08:08:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 95FB8607F7; Thu,  7 Jun 2018 08:08:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAyeyDSd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8D85E605A2;
	Thu,  7 Jun 2018 08:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D85E605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeFGIID (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:08:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36413 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeFGIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:07:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so16971417wma.1;
        Thu, 07 Jun 2018 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AtVf7NGnYqYJIpSzPaGDjhPzEsbFR/7ozk+r3NbC0dk=;
        b=UAyeyDSd5ZN94MJjIQt1gXR7R3xlm2JKsLctWsx37wRShsx9LFPehCsDDV7v+OVV7w
         PQFCRi0HDHSwVw76THl0paDDvh6QdCYtVUvUXhnXgeyyV5rpDy+lTRYzKc/akoP5S7aw
         JqFf3h++FzVs/5Owkxjrps2DIZXFUSIz3ASZd0yiajBWkSE2xm+xWdr8TztwZpdGTjj3
         h8+kHYa4TyIpYSwQi2nTf0NNwF7in35k34UhDLAym7MGfQ8GNOFknEQMeWnXLvdWtMQJ
         7MKoJ7pbePsYHcD36Oh5cgr4FYB886Sp4SYGfOXJV6OxitNrjekmx5ysFCxL/WLIQ0FD
         SBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AtVf7NGnYqYJIpSzPaGDjhPzEsbFR/7ozk+r3NbC0dk=;
        b=q/u4JRxmOwdq4K6XQoJNOmnfSC18bRb/arZ5X3N5UI3lbYdUp1+F+cD60p8AMHENhq
         shgHE9bK9da7BZtuNp+eU+27etaWIG3ghWS9+ymS78jm7slBaa2ap9LDB5lpMVaDgVmf
         c+PTl9xNrpSSoc/qVlk1FdKGuNN0I0I4qEMcCqdxyQ0RG4RKn2kuA2GUZQFgxaSnVPDU
         HTSgObopbeHK7vbDpNvZBtiAEEPLYBoJxdgE1qTcvMxUyjsGHlmcQQ7Cfh8CBg8dJgUJ
         VOkBNiX6RfJs4jbM1nP9A7MYr7ez3FrnP3N7gxZpC3SQjaZ7PPqMan+eqipNFCKuof6Z
         R+Yg==
X-Gm-Message-State: APt69E1TVA+bEMyf0YHJ0O4ivfhIpHqrezWmMSB1OT8NdyNWNc+oX+PU
        r1LdqVWySNWt5WbjOnw5fDvtjs3a
X-Google-Smtp-Source: ADUXVKJ5i0aQADqhY9te/hnqRFGZs+BbXS8pUMPNfBFwRALyhEzVQSNmH68CqVqZBzYWhCPparhG/Q==
X-Received: by 2002:a1c:1286:: with SMTP id 128-v6mr848139wms.9.1528358876051;
        Thu, 07 Jun 2018 01:07:56 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id p189-v6sm1000225wmg.18.2018.06.07.01.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 01:07:55 -0700 (PDT)
Subject: Re: [PATCH v5 01/14] mfd: da9063: Replace regmap_add_irq_chip with
 devm counterpart
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Message-ID: <019675f0-13ff-d381-87d1-891316cbfd83@gmail.com>
Date: Thu, 7 Jun 2018 10:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 11:59 AM, Marek Vasut wrote:
> Use devm_regmap_add_irq_chip() instead of plain regmap_add_irq_chip(),
> which removes the need for da9063_irq_exit() altogether and also
> fixes a bug in da9063_device_init() where the da9063_irq_exit() was
> not called in a failpath.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org

So it's just this one patch that's missing AB/RB and the series should
be good?

> ---
> V5: New patch
> ---
>  drivers/mfd/da9063-core.c       | 1 -
>  drivers/mfd/da9063-irq.c        | 8 ++------
>  include/linux/mfd/da9063/core.h | 1 -
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index 6c2870d4e754..2647bb371d86 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -238,7 +238,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  void da9063_device_exit(struct da9063 *da9063)
>  {
>  	mfd_remove_devices(da9063->dev);
> -	da9063_irq_exit(da9063);
>  }
>  
>  MODULE_DESCRIPTION("PMIC driver for Dialog DA9063");
> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
> index 207bbfe55449..da6ceb41f0d1 100644
> --- a/drivers/mfd/da9063-irq.c
> +++ b/drivers/mfd/da9063-irq.c
> @@ -170,7 +170,8 @@ int da9063_irq_init(struct da9063 *da9063)
>  		return -EINVAL;
>  	}
>  
> -	ret = regmap_add_irq_chip(da9063->regmap, da9063->chip_irq,
> +	ret = devm_regmap_add_irq_chip(da9063->dev, da9063->regmap,
> +			da9063->chip_irq,
>  			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
>  			da9063->irq_base, &da9063_irq_chip,
>  			&da9063->regmap_irq);
> @@ -182,8 +183,3 @@ int da9063_irq_init(struct da9063 *da9063)
>  
>  	return 0;
>  }
> -
> -void da9063_irq_exit(struct da9063 *da9063)
> -{
> -	regmap_del_irq_chip(da9063->chip_irq, da9063->regmap_irq);
> -}
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> index f3ae65db4c86..9ab7049977aa 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -95,6 +95,5 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq);
>  int da9063_irq_init(struct da9063 *da9063);
>  
>  void da9063_device_exit(struct da9063 *da9063);
> -void da9063_irq_exit(struct da9063 *da9063);
>  
>  #endif /* __MFD_DA9063_CORE_H__ */
> 


-- 
Best regards,
Marek Vasut
