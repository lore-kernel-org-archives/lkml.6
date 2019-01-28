Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3972147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exLkt2+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfA1SYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:24:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42358 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfA1SYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:24:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so8364750pfr.9;
        Mon, 28 Jan 2019 10:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1RA36miYBXMiHkO56Tit33gKqdto2/u99xV4L9uWAfk=;
        b=exLkt2+QdsKCYUS0eNKJWsLvkNdluZYWvhreWC58XcCj9An9yIsgWuLSYp3QoeTA45
         it3JMu6rnXQ8i142dbP5wfLXij2SzLPyn/7FMB9bly/I3FnPro7VuzEg8rNRaCmaw9Hj
         NETklKeqLYl2daDmygOwdgEaLA/kaiHnhP48Kb7VmGXlq2HKXgYopOQMfjbonF6fPiha
         J7X7DcT3y44nPPINLJYIULzrXoq0NQxNrzYvgWcWQLyoFa6ggPsmzPkx512LFOaCQQTb
         BoTAPMg3aS53UAw4LNFCazwI+pjPP0weoJJkTm7Hmd3rrPkU3n5z4p9yLoe9fELBETpp
         scdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1RA36miYBXMiHkO56Tit33gKqdto2/u99xV4L9uWAfk=;
        b=kPcXnVrAkWyj1fbjJuodjbEyp7Q66fbNE5/G3TW16HdHPVW93WgiJzwMbYAmjG6qP+
         ULKPBvbT8+QrixbYagUHhtyRWRI4uL0hCgANg8Qmw3tZTBf9qbJynrUROC5uGx9gRLvT
         korGuD6O3Ezg44YQEsLRCTqGDNVMUTeegjC+AaKrdVDHymTK+qRhyUmaB8Vku0FRDNWv
         OOaYmkXQiol9F1TNuutrJpsR14pxxNkletQZGXxoEgT2ZxNswzoZI5kZV42jWPmj8oq5
         vlb0+4MSnCVIPjM6vYySE5QghwQDtLxpsScUy9R7rKZotN/JFe+34WkWa52Z/QCenV4W
         nqMg==
X-Gm-Message-State: AJcUukfgiK3KxkXY4ABr5M6B4RH9UweFM3bQRJErYpZh2IARZQzhBojg
        kq6WE1YhGE9xqefLyy+dSMk=
X-Google-Smtp-Source: ALg8bN698DF8D2UtfKH2CEgdB++Ykpsu0DF0madLD5AuXilcVrIsdhEAGk24pEeNiYiEPClm7VBvOA==
X-Received: by 2002:a63:4e15:: with SMTP id c21mr20818287pgb.50.1548699848119;
        Mon, 28 Jan 2019 10:24:08 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r76sm47784775pfb.69.2019.01.28.10.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:24:07 -0800 (PST)
Date:   Mon, 28 Jan 2019 10:24:05 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 148/304] Input: rotary-encoder - don't log
 EPROBE_DEFER to kernel log
Message-ID: <20190128182405.GA30191@dtor-ws>
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-148-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128154341.47195-148-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Mon, Jan 28, 2019 at 10:41:05AM -0500, Sasha Levin wrote:
> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> [ Upstream commit 0832e93632c61987d504e251b927a2be769dd21a ]
> 
> When a driver fails to bind because a resource it still missing it's not
> helpful to report this as (usually) probing is repeated later.

I do not think that patch that merely suppresses a harmless warning in
dmesg belongs in stable.

> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/input/misc/rotary_encoder.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index 30ec77ad32c6..d748897bf5e9 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -240,8 +240,10 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>  
>  	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
>  	if (IS_ERR(encoder->gpios)) {
> -		dev_err(dev, "unable to get gpios\n");
> -		return PTR_ERR(encoder->gpios);
> +		err = PTR_ERR(encoder->gpios);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(dev, "unable to get gpios: %d\n", err);
> +		return err;
>  	}
>  	if (encoder->gpios->ndescs < 2) {
>  		dev_err(dev, "not enough gpios found\n");
> -- 
> 2.19.1
> 

Thanks.

-- 
Dmitry
