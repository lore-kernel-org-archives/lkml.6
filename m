Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72198C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E80A20665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547123114;
	bh=HYNhoc0GJOM1qSqIwfYgZDvAbtqiJavl73zwI0ehz+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MIZQveMjI+SF2wVR1A2XDnArK1uu3EpZSNsxqxnaeZrS+tplA0kQtRQfIW5w8eThu
	 STVPNlYbjvON7HrtO5vTzPevCRxqsZXV4EpjwMdF/+Q6Jleyk6HC1VYLwqr+KdlcLL
	 4mbyMx4OMlDb9vKNwYV2f1LqUsH6cmP7UaWsLuEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfAJMZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:25:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34121 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:25:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so8177786lfc.1;
        Thu, 10 Jan 2019 04:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qSovJCuzZts6dtBKRUP27331a+qq8qL97WZmBA4gUD8=;
        b=QFSCOQ/bg7d/e1WDSgfoxJRpvJcBWJEsHq7cPmFUWq0yW8W7O8/pBhOiBst9+gfurJ
         OFY76/EM/qn0qYR5qcguO+UGkY+j+d9j6R1ciuqgA+J4QRd+ZsKYPmnuVJ7TsYCWO9ub
         1rUh5DaH2Vi1nXa3FjaUCNAxdYtXWaeJoct6QazOYtuoFnHyVrBPiWRjtBHW6Dl75t0b
         /3MYdmmzx8R7HA6oi59wq2mTQBreOFvMH9fDGGgVbcH1CD+3M6s64KTXCbWu59JC5+8Z
         QePVSTq0pgactbjH2D7lk9TZk7MMgUWNkbujgZhKKihwCImzWQMuHITpocHHA/chEBMJ
         O7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSovJCuzZts6dtBKRUP27331a+qq8qL97WZmBA4gUD8=;
        b=SpDoMyGOrwKevdlol9vKnjKRsdeFXeFGOtaA+J1muzP1yeX+evsc8lnTBeDAogOYFl
         UGfWPu58DTHmFKFkHRMTYrXo8H1H0UldIoEH3LCD4CEPYkDLXiid+pR+LmZbuqOk5t8q
         bphsNt6M8OlYmw3NOhEO1iW6Kuj7qZVrSoetVV50i1Gt7G3oAma7LPHQaVet88otHopn
         jBwsK6R/kFxn8Y+VG1soEK78O5SxfnIxupuBn/tROI2avZ8E/zs9xV3fHkvf0BgsZddS
         VLkJAFrT+fdrlptgiTcGSXoa7uH91eQ7A1M4g9mY7agUoxARLzfJiPMG2qslXta2OU49
         EHkw==
X-Gm-Message-State: AJcUukdDCWvbsszTw1DP6+2PqNtqiQVsdHHjZLSFZoC6gfyJ8/EawoPX
        q6mdzs7f6R/QJ1VNwYlmQVY=
X-Google-Smtp-Source: ALg8bN4I+kp0KfdIaouhhIkfwQS+BKpoyXi8fUrU3kFW4d45e2ZsknuPCLkxJFc97KlxZIo0AU4Yhg==
X-Received: by 2002:a19:8d01:: with SMTP id p1mr5428437lfd.149.1547123109687;
        Thu, 10 Jan 2019 04:25:09 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x16sm13819667lff.26.2019.01.10.04.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:25:08 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghZOW-0002p2-Js; Thu, 10 Jan 2019 13:25:08 +0100
Date:   Thu, 10 Jan 2019 13:25:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 4/5] gnss: sirf: add a separate supply for a lna
Message-ID: <20190110122508.GD3430@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-5-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209195150.5192-5-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 08:51:49PM +0100, Andreas Kemnade wrote:
> Devices might have a separate lna between antenna output of the gps
> chip and the antenna which might have a separate supply.

Fix the s/antenna output/antenna input/ as per Nikolaus comment.

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
>  - handle lna also if there is no on-off gpio
>  - rebase on changed 2/5
> 
>  drivers/gnss/sirf.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

You also need to update the binding docs. As already discussed I think
adding this to the generic binding is appropriate (even if only sirf
implements it initially).

> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index c64369494afb..d339e8ef2508 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -36,6 +36,7 @@ struct sirf_data {
>  	struct serdev_device *serdev;
>  	speed_t	speed;
>  	struct regulator *vcc;
> +	struct regulator *lna;
>  	struct gpio_desc *on_off;
>  	struct gpio_desc *wakeup;
>  	int irq;
> @@ -282,21 +283,32 @@ static int sirf_set_active(struct sirf_data *data, bool active)
>  static int sirf_runtime_suspend(struct device *dev)
>  {
>  	struct sirf_data *data = dev_get_drvdata(dev);
> +	int ret = 0;

No need to initialise.

>  	if (!data->on_off)

Perhaps invert this test now too.

> -		return regulator_disable(data->vcc);
> +		ret = regulator_disable(data->vcc);
> +	else
> +		ret = sirf_set_active(data, false);
>  
> -	return sirf_set_active(data, false);
> +	if (ret)
> +		return ret;
> +
> +	return regulator_disable(data->lna);

You need to undo the above if this call fails.

>  }
>  
>  static int sirf_runtime_resume(struct device *dev)
>  {
>  	struct sirf_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_enable(data->lna);
> +	if (ret)
> +		return ret;
>  
>  	if (!data->on_off)
>  		return regulator_enable(data->vcc);
> -
> -	return sirf_set_active(data, true);
> +	else
> +		return sirf_set_active(data, true);

You must undo the changes here too on errors since we call this function
directly from probe in one case.

>  }
>  
>  static int __maybe_unused sirf_suspend(struct device *dev)
> @@ -384,6 +396,12 @@ static int sirf_probe(struct serdev_device *serdev)
>  		goto err_put_device;
>  	}
>  
> +	data->lna = devm_regulator_get(dev, "lna");
> +	if (IS_ERR(data->lna)) {
> +		ret = PTR_ERR(data->lna);
> +		goto err_put_device;
> +	}
> +
>  	data->on_off = devm_gpiod_get_optional(dev, "sirf,onoff",
>  			GPIOD_OUT_LOW);
>  	if (IS_ERR(data->on_off))

Johan
