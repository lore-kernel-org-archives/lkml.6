Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1730BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C21206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlkYiNkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAOAmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:42:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43841 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfAOAmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:42:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so415223plb.10;
        Mon, 14 Jan 2019 16:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Siayggi2yHTLNKyVgxd6Cw++xWFsxfY4GIGBFVsloGE=;
        b=dlkYiNkv20xZaaEMVVqgHfrCrX2g8jhnqMnsfSgVbraKT+QtXbpyf+eUcCwDYCsnSb
         xFVmHwAlRyGog1M2EHyjvZc+rd/c9NpofxzLGjWB94VFNKVvHCodnC4vrr1NgPBeqT+j
         XxAJ6kP+XxDijx+QYJgTX/cA6uXba1NNNL+YvT2uyhLXSMPmy7kubmyA0jWgiMDZBlvK
         rmiTMFvIChW61SPJ5W7Cb6Bk7VJGz2OYCvYdHJWUM+oAg4kx6P57o+OAa76CjpyOh5Ps
         +cEYCmZWfiXKnMsmD1xjb38y+xbJNzPS1fP1BE7WtgXNU8nrmlOgaMSAkJyWok/0j0KJ
         2eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Siayggi2yHTLNKyVgxd6Cw++xWFsxfY4GIGBFVsloGE=;
        b=bsLi92mJuzFGx8cvZaidK7tYo0HTkitY1hlbDdm8bfRKr9fJkU6V4G49JSlvMDxd2z
         mEkXkX4Vi4XiAbjy4beg/xbS2IiR0f1CFYZOZzuY7LdURJWGlrkno9zRzq3sSdc8kWLd
         kYwFZ1QG2M9iz37sym5xxziLmw3ZDmjqT8eEpGKgj6WbYPst9xcq0lFqpGwkOcorhs6r
         FTSxRu7WRiy0SrIyPH4/Wfabw3VyGdAzcRtoIdB7Np1P5RXy/oTHidD2kLqL1AlxZczy
         vD1hLzrZC31M3AD3wVSOR2AXtA+usgpVXgmlk3iwQPbPJuXaEh1LRGgzz5IaIa0jkPz1
         YBQA==
X-Gm-Message-State: AJcUukePup0te64kPM6o2aZjuyA4mQ3ZcoNH6W1aJdUWc9GtRPacEYnW
        57m9Qte7o1Gua24b+IXh4As=
X-Google-Smtp-Source: ALg8bN5/g2GfLnTnjMmMjuSN+OeH1DUb/Y9GTo/I6wULSkhpcg8JwxHbvuvS5Ib6VJC95LB+7sO0zw==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr1228588plg.250.1547512955605;
        Mon, 14 Jan 2019 16:42:35 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m3sm2001949pfi.102.2019.01.14.16.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:42:34 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:42:32 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] Input: atmel_mxt_ts: Wait for device be ready for
 communication
Message-ID: <20190115004232.GK117329@dtor-ws>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
 <20181214151214.5391-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214151214.5391-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 04:12:13PM +0100, Paweł Chmiel wrote:
> According to documentation, device isn't ready for communication,
> until firmware asserts the CHG line. Add missing wait for this.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Fix checkpatch issues
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 55a107fc1b73..e8949c6ceafa 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -202,6 +202,7 @@ enum t100_type {
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> +#define MXT_POWERON_DELAY	150	/* msec */
>  
>  /* Command to unlock bootloader */
>  #define MXT_UNLOCK_CMD_MSB	0xaa
> @@ -3070,6 +3071,16 @@ static int mxt_regulator_enable(struct mxt_data *data)
>  		msleep(MXT_REGULATOR_DELAY);
>  		gpiod_set_value(data->reset_gpio, 1);
>  		msleep(MXT_RESET_INVALID_CHG);
> +
> +retry_wait:
> +		reinit_completion(&data->bl_completion);
> +		data->in_bootloader = true;

I think you would want to reinit the ocmpletion and set the flag before
releasing reset line and sleeping, otherwise if interrupt fires too
early you'll be spinning for extra time.

I'd also really want to hear from Nick on this change.

> +		error = mxt_wait_for_completion(data, &data->bl_completion,
> +						MXT_POWERON_DELAY);
> +		if (error == -EINTR)
> +			goto retry_wait;
> +
> +		data->in_bootloader = false;
>  	}
>  
>  	return 0;
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
