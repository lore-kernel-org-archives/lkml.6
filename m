Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B35C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DE520C01
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeqTKkEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeLZUBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:01:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41306 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeLZUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:01:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so7867720plm.8;
        Wed, 26 Dec 2018 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HWtoAToLMcEYno0PZpxmdEQ9iMNDBE5TLoToRlPydgs=;
        b=XeqTKkEd65SyOW8djkbHgg8ipRnpt4B2e+XrtcYUnc9/70CLwZ5JHW2i2x8AzVnrzv
         YolEb1NNy6aDWVMwmuGGrQuBvnnDp53RzRkOlbsddoJ8NYLoOkAClK/Di1rVMGEPJyWA
         xlsqP7OgKFIzublLo1Zxir5Ep4PWk/+5u6AVVBbHamrZid7UIzDIrYYUOfNmjHBOAXKD
         S3v2BtwLYUpmjSx6t7uNW5zByGG5sMj0a8Gl+SGAEz88mjHxgI5sUapi9I9j5iCequAd
         HNrS4cIUhcccAvaooftNUvABJp0fQnAYvFYnynVt+XvO/LZ71vnqUikhS061U/j30Azn
         CNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWtoAToLMcEYno0PZpxmdEQ9iMNDBE5TLoToRlPydgs=;
        b=LqJDvA6aar5oTRUNtAiHEDwXZ616xrMZ3r1L4IBke49gJ8gx9QB857SQ2P52Yhe386
         v+hsG++M9u/o/9pd6Jn+50d6hEGHovaXTj/AREa+uXEkrer0Os6NWrXunEHWG9jk5NHh
         Q8boheE6vIZjGPB2b2n8l+Ygjy7jRqGyKLLAxnUhmdWLlb00+8UmThxfwqUZCUnR9IwV
         5sGMv6oDuTzXIKTViDvCEXzBiD0nJ2V/ONChmeNHJZk1WZuB4Kf7pKh8HD91VgGHPzoA
         7FcXey+TT3xjAX6Y3g7bTY0xx9ofgwY6aXpj8Kly/r9cU3tdV862MNfx6fL1lw4jIeJS
         xtPw==
X-Gm-Message-State: AJcUukfa0Lm4CIcY9E8EwGKBJOncaId8hoPzIpCxJArG2PWrdUDWoBxb
        MoLSMN1j/8xrPm3u/ScFCspFbTS+
X-Google-Smtp-Source: ALg8bN4yR1VIBeJeQ+IR3nwdmg1OxJEWo6WqQS+KQcV+h1VNRyDxlk1+jjDWSRcUxtPE6RzT34QCnQ==
X-Received: by 2002:a17:902:292b:: with SMTP id g40mr21216311plb.82.1545854459338;
        Wed, 26 Dec 2018 12:00:59 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r4sm74169866pgn.54.2018.12.26.12.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 12:00:58 -0800 (PST)
Date:   Wed, 26 Dec 2018 12:00:56 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] touchscreen: elants: fix a missing check of return
 values
Message-ID: <20181226200056.GB5999@dtor-ws>
References: <20181225043616.66032-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225043616.66032-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 24, 2018 at 10:36:13PM -0600, Kangjie Lu wrote:
> elants_i2c_send() may fail, let's check its return values. The fix does
> the check and reports an error message upon the failure.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index f2cb23121833..8ccba4ccee37 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -245,8 +245,22 @@ static int elants_i2c_calibrate(struct elants_data *ts)
>  	ts->state = ELAN_WAIT_RECALIBRATION;
>  	reinit_completion(&ts->cmd_done);
>  
> -	elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
> -	elants_i2c_send(client, rek, sizeof(rek));
> +	error = elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
> +	if (error) {
> +		dev_err(&client->dev,
> +				"error in sending the w_flashkey command for calibration: %d\n",
> +				error);
> +		enable_irq(client->irq);
> +		return error;
> +	}
> +  error = elants_i2c_send(client, rek, sizeof(rek));

Messed up formatting.

> +	if (error) {
> +		dev_err(&client->dev,
> +				"error in sending the rek command for calibration: %d\n",
> +				error);
> +		enable_irq(client->irq);
> +		return error;

This also leaves the touchscreen in ELAN_WAIT_RECALIBRATION state. I
think all in all I'd rather leave the code as it was.

> +	}
>  
>  	enable_irq(client->irq);
>  
> -- 
> 2.17.2 (Apple Git-113)
> 

Thanks.

-- 
Dmitry
