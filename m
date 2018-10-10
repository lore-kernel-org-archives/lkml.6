Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72815C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A47F21550
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRRCQbLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A47F21550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJJHzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:55:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35759 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeJJHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:55:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so1641690pgb.2;
        Tue, 09 Oct 2018 17:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJ+84DBgLCFMg95PiXPfRB/decEWuZOwuM7HO76FbA4=;
        b=BRRCQbLhJzNn6N76cN3IGvxD3HhE3E+IpKpFJ2RdStMHuLHYSSFGR3nq8hmY0frs9d
         iiOrV4srh3md1aZvZh+u9dA6eOK2dueQy13clbRP5w3HuA0stwwDWa8YdUXsOW7i0l18
         +ruK8ju5dWfBCnVpnZ86113PsJ6ZKBMahPkjk3PiBCfrRKgA+kcab7I0XCXGOrli4rgU
         7LOTSIT8ZhFnrMZutvz8T+IMNK+cjliX+wdZDieBYYrL4BcTNzdqSiCnQ1iBHlZ82dTi
         dBdjIx8Ps5pslW9mL1SzBEnfTyjp/rNgD22KKg1QEMRDSdM9+jEbck4bqDUsqVsM32n5
         18mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJ+84DBgLCFMg95PiXPfRB/decEWuZOwuM7HO76FbA4=;
        b=IyXrD/J0gc+vP2NNR1z1xkNtt+vaJWVdNclGBOAPvwBFyfpb+uGNboBMH0rNQtOFfQ
         OJRBDrDQGlJJdYN7QePLv2YFRonpvu/EmoqfJ6EPxuvSGGzgZm7kLKlKCbkuiN/56hHF
         3cRaFH/8i1umh6Ymm4rocjj0MXu8LrCIDi2ORiqIoyivR5DJfm7ctgmGpI+zUnaXynuX
         oH7vqwvSM5RY0k1Ej0G9jAYl4kgoOx3ODb4z/WrNwjAP8DvfERkfqGnxxLc/k2aSl6jT
         ozoLR6SSmnG99rJdn0Uo1UT/+0etjbUuZ6L5Yd9V9+EsnvkbrmLqNgGyhV7/0bjyGYHX
         8mUA==
X-Gm-Message-State: ABuFfojP7ABNpLO7omB6Qj/zFOXej96z2dd7vvH6PlpyR5YsZBLZenVR
        JCz56npIpXWvri88d5w+bxM=
X-Google-Smtp-Source: ACcGV60l3hfnL87lAiVtas8zeRf/J+HBDUoECsrFmkIlQxtaRvqY//2vRoIplgvxDRiFGBhttOS7BQ==
X-Received: by 2002:a63:9855:: with SMTP id l21-v6mr27779104pgo.162.1539131785604;
        Tue, 09 Oct 2018 17:36:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f81-v6sm40979126pfh.46.2018.10.09.17.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 17:36:24 -0700 (PDT)
Date:   Tue, 9 Oct 2018 17:36:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (tmp421) make const array 'names' static
Message-ID: <20181010003623.GA21661@roeck-us.net>
References: <20181009121157.21656-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009121157.21656-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 01:11:57PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The const array 'names' can be made static, saves populating it on
> the stack and will make it read-only.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/tmp421.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index e36399213324..8844c9565d2a 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -226,8 +226,10 @@ static int tmp421_detect(struct i2c_client *client,
>  {
>  	enum chips kind;
>  	struct i2c_adapter *adapter = client->adapter;
> -	const char * const names[] = { "TMP421", "TMP422", "TMP423",
> -				       "TMP441", "TMP442" };
> +	static const char * const names[] = {
> +		"TMP421", "TMP422", "TMP423",
> +		"TMP441", "TMP442"
> +	};
>  	int addr = client->addr;
>  	u8 reg;
>  
