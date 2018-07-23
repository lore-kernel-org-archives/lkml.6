Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C16ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21DB204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="btLqPI8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21DB204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbeGWV5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:57:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34589 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388062AbeGWV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:57:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so1720292ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ag13Hxd1fU6WAqw3mb13Z+Lzy1zd2bB7BQ2hFWTn+Y0=;
        b=btLqPI8zO0XNpLZXWJkCVZm1LJh4+ul5bQZltovC1Au0tcrQLhTEKpOR2bq8G+Gdf4
         kbj6iiZmdiujrEAYEZhQbO1g4tZKXf0KOlnGCjlbboXtWgEnkTi0iVIe29A5JRVfIETl
         cNnOE/tDFfDD6AVhhzRskZ9JyBPb/vMNj3ePe+stzb4ufWsrbBEyE17GN+TcRPTV33sX
         4tldelgrwdjagVlMCBotBx+pERzdamR8r1HeBkNNF4kln2CBs9VAf5oFD1tFhwvl4cor
         zLhwqm2Cr3ZYAJjk2jxvF9dNeUYVZnFDa4h2sgSc4dL3y1FRAlCNMlMPNSZawbxJ9vPH
         g/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ag13Hxd1fU6WAqw3mb13Z+Lzy1zd2bB7BQ2hFWTn+Y0=;
        b=em4QjDMSxe2G+eGGCsajOAV2X8NaRBojZMol4XcacyoP6zbw8nyN0RX6jv81SDPKH7
         t3+f9auE3j05uacvfHtHKLa4VN7u/uo+uvpbBEqUt9jx1eWlYSgBbjppyzakgn9AOF0R
         qQ0WnPkolCTakt+hUx58rXsx1wkYP8eQlZSUffAC5QMqOL57tQXhWrHPvXLt1nBrNQna
         FVXGGZLUA/D6DtZxiMKhACmQBxcdgsCz5kNcqrPWWXbS9VwFlu/PtE2+mVs2fvEJEl6x
         6gV6BiFT6M2RsyWKvsDRLzCppXYPiynsQmxwfBCJvuWGyzh66EKSdMJ6kw1nE+2mtnFL
         lqJw==
X-Gm-Message-State: AOUpUlGD1YD88k/tLUYQSfbUFa5+FQJKwI7CbOt1uScptT9k1fNWU2pO
        v9ZQ+DR5k4FelZkF8CYSdv9y1w==
X-Google-Smtp-Source: AAOMgpf9y3tfZn7u19azwdLpL7uy4R1XlCv/jOh81dLlNHWLbo430zqw3xe6ZQtre8OnHOrMZ0/aCg==
X-Received: by 2002:a2e:259:: with SMTP id 86-v6mr10437678ljc.107.1532379251725;
        Mon, 23 Jul 2018 13:54:11 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id h9-v6sm1549236lfc.47.2018.07.23.13.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:54:10 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:54:10 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] i2c: sh_mobile: use core to detect 'no zero length
 read' quirk
Message-ID: <20180723205410.GI1432@bigcity.dyn.berto.se>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-13-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180723202617.15230-13-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2018-07-23 22:26:16 +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
>  drivers/i2c/busses/i2c-sh_mobile.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 5fda4188a9e5..9c7f6f8ceb22 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -613,11 +613,6 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
>  static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
>  		    bool do_init)
>  {
> -	if (usr_msg->len == 0 && (usr_msg->flags & I2C_M_RD)) {
> -		dev_err(pd->dev, "Unsupported zero length i2c read\n");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	if (do_init) {
>  		/* Initialize channel registers */
>  		iic_wr(pd, ICCR, ICCR_SCP);
> @@ -758,6 +753,10 @@ static const struct i2c_algorithm sh_mobile_i2c_algorithm = {
>  	.master_xfer	= sh_mobile_i2c_xfer,
>  };
>  
> +static const struct i2c_adapter_quirks sh_mobile_i2c_quirks = {
> +	.flags = I2C_AQ_NO_ZERO_LEN_READ,
> +};
> +
>  /*
>   * r8a7740 chip has lasting errata on I2C I/O pad reset.
>   * this is work-around for it.
> @@ -925,6 +924,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
>  
>  	adap->owner = THIS_MODULE;
>  	adap->algo = &sh_mobile_i2c_algorithm;
> +	adap->quirks = &sh_mobile_i2c_quirks;
>  	adap->dev.parent = &dev->dev;
>  	adap->retries = 5;
>  	adap->nr = dev->id;
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas Söderlund
