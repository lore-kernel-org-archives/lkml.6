Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FB92173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDQpjAqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfAGUAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:00:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33981 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfAGUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:00:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so697130pfg.1;
        Mon, 07 Jan 2019 12:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dyAAmo+SdP6b9BCxbSfF/WAv+K+v61wfTshKHpb/g/8=;
        b=LDQpjAqOKEqvSRLuG824dIjbxd33yJF3zz/iDqbw47Yo03dnISCZsD0b8fCORfr44X
         wU3S8RZrKnbMT5SJD86IRwHvenTSk04eRM6sI/HbuDUZbxCoPyOy7IiOV5m/FXYSVLfw
         eclSLakztwdZZvfoPnPvQKv8g1bAxdOYwKayFVkDafyFRvnWUlAmPwtNV9UQqOjy74zZ
         z/GVAwbL18v4DA3hR78MdGd8VkLjnDtHVOK+wnbY2IEmjH/3vNTvGpC1Vv/LPvGF45SB
         y/S02B/XSDF2F5aZwM+d/+O57rOB7wXQ1Ct3u6mCRvipE0SA2KZxH9X3AuOz4U+rLrLL
         8VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dyAAmo+SdP6b9BCxbSfF/WAv+K+v61wfTshKHpb/g/8=;
        b=efWhrbw20uv8gbT+zrUgKqvlntew+DbuQ5Jr9Avoei29yoUpplXMX05lQYjFre8OS4
         LS2JGMscJfW/ezQpdKRuWx97AnYnUWRm9b/+JqLL9C4Ty9CPzA0DUJ9HRW8i05L1xLcR
         W9/fmDeEe5o0M8p94IQuoIZjncPpvQdNqOaz6JZKI9jGKElb5dir6DAeYes8sWy6MGJF
         WU7l5R2OEGUykIoZeeE3setbiINqMpbidtHy5ty7cdpj3BaVSonqCszVfcXWudBfat5Z
         dUdZooBQ1Ob5RRvvJd0dldnl6hv3XBm9r3HxneixBgKeNQvSs7yt8ULq5F+Gpdry4ZWm
         fSYw==
X-Gm-Message-State: AJcUukd93ZlcDj3exLeJUOIggt6Dm+h3XP+qCIfiOT5FjycL2/7XT+yE
        9d+wTdPyMhKrJk9hUXSB/Vw=
X-Google-Smtp-Source: ALg8bN4UKxW9LRaE/YlvlAOygcJHCkQG/DL0EFo02luz6m03LUDkKF82KBH2S6loTAQOeM+b/rON7A==
X-Received: by 2002:a63:2109:: with SMTP id h9mr12094433pgh.277.1546891229118;
        Mon, 07 Jan 2019 12:00:29 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i72sm100067640pfe.181.2019.01.07.12.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 12:00:28 -0800 (PST)
Date:   Mon, 7 Jan 2019 12:00:26 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Michael Hennerich <michael.hennerich@analog.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] Input: touchscreen: Fix a missing check on
 regmap_bulk_read
Message-ID: <20190107200026.GD141497@dtor-ws>
References: <20190106181727.11815-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106181727.11815-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 12:17:27PM -0600, Aditya Pakki wrote:
> regmap_bulk_read() can return a non zero value on failure. The fix
> checks if the function call succeeded before calling mod_timer. The
> issue was identified by a static analysis tool.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ad7879.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 6fa714c587b4..8c908572c1f2 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -246,11 +246,14 @@ static void ad7879_timer(struct timer_list *t)
>  static irqreturn_t ad7879_irq(int irq, void *handle)
>  {
>  	struct ad7879 *ts = handle;
> +	int error;
>  
> -	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
> -			 ts->conversion_data, AD7879_NR_SENSE);
> -
> -	if (!ad7879_report(ts))
> +	error = regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
> +					ts->conversion_data, AD7879_NR_SENSE);
> +	if (error)
> +		dev_err_ratelimited(ts->dev, "failed to read %#02x: %d\n",
> +					AD7879_REG_XPLUS, error);
> +	else if (!ad7879_report(ts))
>  		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
>  
>  	return IRQ_HANDLED;
> -- 
> 2.17.1
> 

-- 
Dmitry
