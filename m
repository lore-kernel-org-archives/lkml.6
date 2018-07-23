Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F43ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAF020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="ejq8dMXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAF020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbeGWVrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:47:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43354 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbeGWVrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:47:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so1685261ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zT/aNVdRalolKI5HF1lQ0LXAv/wZ+Yr3HVAQanpBEOk=;
        b=ejq8dMXCq+pKYczk93neLeEcQrDPpkuucK6sypM0hdtthvjx0+9lpvagD7fMk0kDYH
         3lF7+cH5KNkr8s1E8QbWDmZS3rrcBD34fQOSu/Ulu+dGjvCF177bVtLe7zD6uIy/FLxo
         ki/74liLHc9TE9MOcl6XYPmUG0LXS3XTfmHDtuQVR3PkimOJCBFJHvw7tYPko7lc9GU0
         Fu7QmElckXpDP4uPhaKgobGrE8v5B/BILwTu/dIr0MXVAIncqR6wCgx+vVqtlfad+Hkp
         5Pg8fVlpmj2In+lvxW369KFifQOh1gozFpsskqYR5fS8Ogs10G1UKkbqelKvyVIb/7jY
         S7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zT/aNVdRalolKI5HF1lQ0LXAv/wZ+Yr3HVAQanpBEOk=;
        b=G8aVkZ2spAd1I8hlghqxX56xKBZg6mWVGQpqGCoIBvJEOalO7nppe0jfgH9gRjZ+nl
         aF+0BDv7sKG1OWf2e8PwZUD6o50yt9nGmcSozjjDtlF2aOlsGyF3iSjM8laNWdp3+cIW
         sxmkUpH88QBNy64bCGfi+ye9blTZXmdkyARxelzn+PeCah91P1NBBxi/YumAsskH9/Tn
         p0wn1yybngtPKE080ONlkz5rolZuPUCDF67zEjib7BSwSOa9h15D+i/3pH+1WvJhZKIR
         yd+Ic+U9uaSJFOtLhQhlPy22vCXTQHwxOAXL7/Fxddz37gftSanw1xCNV9EX870bVduP
         hYoA==
X-Gm-Message-State: AOUpUlHzhrxGMgRynzs/iRcXiyWpa6bDEdDrOuDhCrCwy/46+0mDBuEg
        BBgvLcQPNVApzdXZEWmE329c4A==
X-Google-Smtp-Source: AAOMgpdKnoZGoh77Xm65EL6kHxW4EWKOy4KXRu6dik7k1beq8/lTUJzm68QcULyDAwvmb1Ag3924xw==
X-Received: by 2002:a2e:84c6:: with SMTP id q6-v6mr10520916ljh.65.1532378660448;
        Mon, 23 Jul 2018 13:44:20 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id z90-v6sm1962025ljb.59.2018.07.23.13.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:44:19 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:44:18 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] i2c: quirks: add zero length checks
Message-ID: <20180723204418.GG1432@bigcity.dyn.berto.se>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180723202617.15230-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thanks for your patch.

On 2018-07-23 22:26:05 +0200, Wolfram Sang wrote:
> Some adapters do not support a message length of 0. Add this as a quirk
> so drivers don't have to open code it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Only build tested.

Was this not tested when you also tested i2c-rcar and i2c-sh_mobile 
drivers? In any case I think this change make much sens.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
>  drivers/i2c/i2c-core-base.c | 6 ++++++
>  include/linux/i2c.h         | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 02d6f27b19e4..a26b3e9cc441 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1839,9 +1839,15 @@ static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  		if (msgs[i].flags & I2C_M_RD) {
>  			if (do_len_check && i2c_quirk_exceeded(len, q->max_read_len))
>  				return i2c_quirk_error(adap, &msgs[i], "msg too long");
> +
> +			if (q->flags & I2C_AQ_NO_ZERO_LEN_READ && len == 0)
> +				return i2c_quirk_error(adap, &msgs[i], "no zero length");
>  		} else {
>  			if (do_len_check && i2c_quirk_exceeded(len, q->max_write_len))
>  				return i2c_quirk_error(adap, &msgs[i], "msg too long");
> +
> +			if (q->flags & I2C_AQ_NO_ZERO_LEN_WRITE && len == 0)
> +				return i2c_quirk_error(adap, &msgs[i], "no zero length");
>  		}
>  	}
>  
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index bc8d42f8544f..2a98d0886d2e 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -661,6 +661,10 @@ struct i2c_adapter_quirks {
>  					 I2C_AQ_COMB_READ_SECOND | I2C_AQ_COMB_SAME_ADDR)
>  /* clock stretching is not supported */
>  #define I2C_AQ_NO_CLK_STRETCH		BIT(4)
> +/* message cannot have length of 0 */
> +#define I2C_AQ_NO_ZERO_LEN_READ		BIT(5)
> +#define I2C_AQ_NO_ZERO_LEN_WRITE	BIT(6)
> +#define I2C_AQ_NO_ZERO_LEN		(I2C_AQ_NO_ZERO_LEN_READ | I2C_AQ_NO_ZERO_LEN_WRITE)
>  
>  /*
>   * i2c_adapter is the structure used to identify a physical i2c bus along
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas Söderlund
