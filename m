Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626E6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16279214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3ih0iot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16279214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbeHPMJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:09:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41992 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeHPMJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:09:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so3463097wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QAwynADlPKYuP4aeifp7Ola9qHjzWIRt8Cy2YRNpqvE=;
        b=A3ih0iotjw5WB/ZWP4+RM/jkU+7CkA3E1+ZRP3dp6A9kk2tgqka8deceXqDnKfiUgx
         GulJj5R+JP1FEdOeShHsqL0/Qqm6p8maZeXjrRdN8XK8fVHnC2lmAufGx3TISjvoxKvB
         kOojCx/cwLzAfJKVYB5P2m3LGqtKdpCcqAzX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QAwynADlPKYuP4aeifp7Ola9qHjzWIRt8Cy2YRNpqvE=;
        b=fVQNgQAyvA+H4RH2U2Xd4BA4qr4JS7x6a/w9AapfWA5yQwYpy5Dr5I+KezFxRGoUUG
         9abfejVtUz9JwJM4I+cfKxwtsQrigCdHl84HzV87Bu8Lr/aN+1zc4GNeaObEOZgARd0Q
         uY+q2e3ZVOrCdpcQtJujUuL5fqVXFIzBpJzAWFwRzLk3vYqKvLg8N/wGoNFwAyfbY7tv
         OIdtShctzIPhqUd+kdw28Uf7tyhors3Wvk14dCVXxfn/TdYOdISSaNMvxEycDVlaE0O5
         pPuyyz1B/g5+8/KaKbBfrKUTLUWf9MwHn3ifRpj+ABmzYpsh4UMyENDoifEYA53IIBK6
         LyHg==
X-Gm-Message-State: AOUpUlHMwhk9kFhJ/NsHGxslFkz2FA0B+WyiWBv1CL7k5KPo6ferH/VI
        NuvZ8GLZLXDxTDeuqDFFO17se3F67KM=
X-Google-Smtp-Source: AA+uWPzcJMFF0SeRzchiR1BoLaqUZFxaXo4NFE7N34WVuH7XLrPXyBzlz9ZybIFhS/SA59VZwU/VTQ==
X-Received: by 2002:adf:e70a:: with SMTP id c10-v6mr1185432wrm.143.1534410734088;
        Thu, 16 Aug 2018 02:12:14 -0700 (PDT)
Received: from dell ([2.31.163.71])
        by smtp.gmail.com with ESMTPSA id 199-v6sm1693332wmp.37.2018.08.16.02.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 02:12:13 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:12:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: madera: Don't use regmap_read_poll_timeout to
 poll for BOOT_DONE
Message-ID: <20180816091211.GF10054@dell>
References: <20180807090813.15695-1-rf@opensource.cirrus.com>
 <20180807090813.15695-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807090813.15695-2-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018, Richard Fitzgerald wrote:

> While polling for BOOT_DONE the chip could NAK a read because it is
> still booting, which would terminate the regmap_read_poll_timeout()
> with an error.
> 
> Instead implement a polling loop that ignores read errors so we
> always poll until the chip signals boot or the loop times out.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> index 8cfea969b060..bc5545c53ee5 100644
> --- a/drivers/mfd/madera-core.c
> +++ b/drivers/mfd/madera-core.c
> @@ -132,33 +132,43 @@ const char *madera_name_from_type(enum madera_type type)
>  }
>  EXPORT_SYMBOL_GPL(madera_name_from_type);
>  
> -#define MADERA_BOOT_POLL_MAX_INTERVAL_US  5000
> -#define MADERA_BOOT_POLL_TIMEOUT_US	 25000
> +#define MADERA_BOOT_POLL_INTERVAL_USEC		5000
> +#define MADERA_BOOT_POLL_TIMEOUT_USEC		25000
>  
>  static int madera_wait_for_boot(struct madera *madera)
>  {
> -	unsigned int val;
> -	int ret;
> +	ktime_t timeout;
> +	unsigned int val = 0;
> +	int ret = 0;
>  
>  	/*
>  	 * We can't use an interrupt as we need to runtime resume to do so,
>  	 * so we poll the status bit. This won't race with the interrupt
>  	 * handler because it will be blocked on runtime resume.
> +	 * The chip could NAK a read request while it is booting so ignore
> +	 * errors from regmap_read.
>  	 */
> -	ret = regmap_read_poll_timeout(madera->regmap,
> -				       MADERA_IRQ1_RAW_STATUS_1,
> -				       val,
> -				       (val & MADERA_BOOT_DONE_STS1),
> -				       MADERA_BOOT_POLL_MAX_INTERVAL_US,
> -				       MADERA_BOOT_POLL_TIMEOUT_US);
> -
> -	if (ret)
> -		dev_err(madera->dev, "Polling BOOT_DONE_STS failed: %d\n", ret);
> +	regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
> +	if (val & MADERA_BOOT_DONE_STS1)
> +		goto done;

Move the usleep_range() invokation to after the regmap_read(), then
you can remove these 3 lines and have the same semantics.

> +	timeout = ktime_add_us(ktime_get(), MADERA_BOOT_POLL_TIMEOUT_USEC);
> +	do {
> +		usleep_range(MADERA_BOOT_POLL_INTERVAL_USEC / 2,
> +			     MADERA_BOOT_POLL_INTERVAL_USEC);
> +		regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
> +		if (val & MADERA_BOOT_DONE_STS1)
> +			goto done;
> +	} while (ktime_compare(ktime_get(), timeout) <= 0);
> +
> +	dev_err(madera->dev, "Polling BOOT_DONE_STS timed out\n");
> +	ret = -ETIMEDOUT;
>  
>  	/*
>  	 * BOOT_DONE defaults to unmasked on boot so we must ack it.
> -	 * Do this unconditionally to avoid interrupt storms.
> +	 * Do this even after a timeout to avoid interrupt storms.
>  	 */
> +done:
>  	regmap_write(madera->regmap, MADERA_IRQ1_STATUS_1,
>  		     MADERA_BOOT_DONE_EINT1);
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
