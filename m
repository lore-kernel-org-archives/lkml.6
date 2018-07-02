Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E47324530
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvzBalPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E47324530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754447AbeGBI7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:59:48 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42136 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGBI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:59:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so11412540lff.9;
        Mon, 02 Jul 2018 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vCSjayYSk6fN6FqqdVaQnovAcn5HysKrlKo1HJ5JHkQ=;
        b=RvzBalPgZmc8/c+vwBe3MXxizQ7Xeuw5rYqjGemr6go8YByNQ78jLy2bCXBiPtOFs7
         yKJ/ZaJUAWISkrm4OPWVZekBvScZDDiWpNniMD8Dxa8a+3U/XkrinN7NK6p+/Dvj/6sS
         +dsDYf2UoKzJOmGZ8qWTXZDaguixLzVy+WlyaB2AzaZBOycJNVV2N17pdw2NOkCov39J
         WTJaWlgnbGOVblBUHOncbrReDZqn0a12LqUaHyu3H2RpqcbKhyk9fdaXuFIQyqV8D90z
         D59L6zccSvG+HEnxqGTSLI98Th9l1wP0+WOuGFa7WsOzTQk6BwIG8BPBvD3NVPwtBNxH
         547g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCSjayYSk6fN6FqqdVaQnovAcn5HysKrlKo1HJ5JHkQ=;
        b=GgN8mafMs/OIWjdNiidWhHcH9Pt9OEJLuWTxCjvhcSzkQsA3t93C/GQ+tADJ+R4j4b
         +dr3qGPl2ZIO8cIOP8AobS8veYfrvmGEQRY1WcoKimCXlecoPlW0eAL608OqpMfSkREs
         EqclW7gJt4La2PDs4C/alC/auc5/IYPLIZDmr+big35Kmv9Oed2wZoOP1/JlS+HjP8pR
         Nx8bi8k/IJon0F836Ep4pOjICu0hTjjebgxVXer1x27W4nt9vUj/bKKsrHod3YC5ftAd
         t58LNnA/Gh25TFI0XejnNuAkNrMtkvaePfeTBIlO/2mfTdJVYtnjAVxkcB8ILC8M3bsl
         IbiA==
X-Gm-Message-State: APt69E0KhGToiatSvlIgJYWeLaFpxFlctfcQJ3kyUJ0KynpvohcVNrGe
        0zNK0NrWnSA2yBJZpcSTrKc=
X-Google-Smtp-Source: AAOMgpclgmpKD6R4pYh51mBD6iDfSoNog+72GJxXfl5HNScBCcwPOhow+c3ctxCz4f6HVaJ6T5ocng==
X-Received: by 2002:a19:c301:: with SMTP id t1-v6mr14181877lff.45.1530521982642;
        Mon, 02 Jul 2018 01:59:42 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id y5-v6sm3059668lfy.94.2018.07.02.01.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:59:41 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fZugH-00085S-OW; Mon, 02 Jul 2018 10:59:33 +0200
Date:   Mon, 2 Jul 2018 10:59:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Johan Hovold <johan@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH][next] gnss: make struct ubx_gserial_ops static
Message-ID: <20180702085933.GG9802@localhost>
References: <20180630112246.942-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630112246.942-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 12:22:46PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The structure ubx_gserial_ops is local to the source and does not need
> to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'ubx_gserial_ops' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This was reported by the kbuild test robot and an automated RFC patch
submitted was a while back.

I prefer this man-generated one with a proper commit message, so:

Acked-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/gnss/ubx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
> index 902b6854b7db..12568aebb7f6 100644
> --- a/drivers/gnss/ubx.c
> +++ b/drivers/gnss/ubx.c
> @@ -59,7 +59,7 @@ static int ubx_set_power(struct gnss_serial *gserial,
>  	return -EINVAL;
>  }
>  
> -const struct gnss_serial_ops ubx_gserial_ops = {
> +static const struct gnss_serial_ops ubx_gserial_ops = {
>  	.set_power = ubx_set_power,
>  };

Thanks,
Johan
