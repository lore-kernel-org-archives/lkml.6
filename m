Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D4CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056652075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpR4FYBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056652075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeIEV6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:58:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37863 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIEV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:58:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so3829251pfd.4;
        Wed, 05 Sep 2018 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GtAM97m0Y5Vts3HAPtWNbS2j4N3pDeKI1QeziYT+6ZA=;
        b=mpR4FYBEfAJEUyzmVaVxdbDTVgt/IJIIHwWTiYTTnTYLhRKix65FaFRGP87184KoGp
         b33XgfY3tUQ9LIi0g5FQoFtUVNLDHeAlx/xQagB00dPDeksoXFiZwYggY7884Ud8IoO9
         kcQLD7KXt5DpfALW+SZA1JS1Kj2R6A4/BAuxQHkxMqL3udN56v4Oc/r1PddMYlBRw3kq
         tXElfiNtBKLCy2MjZIPVpDz/rVRyLb46/jEhxmpcLJmxiQqcAyIXiM/Ojtf/e54hqXHS
         GYV/gPYc6ooqW5HQHjQFB/7T3odScN40C0/PbxhCjdnVPM2CSAUYjtMjezqkXQn8dfw5
         oOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GtAM97m0Y5Vts3HAPtWNbS2j4N3pDeKI1QeziYT+6ZA=;
        b=G/+JUn9JB/s0KzsvG+F2BpE9aRuTrNz9oaxr238Y/2NbyvJdTmPge+TXfba8klvWZW
         vcA6thWSj56AXJi5HnqzE6GEWNf/nEGVD+hTYOlo3CxiFHVisMqJkp0flcKGTZHCor1k
         omyqqa3MTRvMQHuc7M5qXcnMAk4mGAUzEMkhrnfZHc02XrOgxph06X4TxzOKCWCqnZ+0
         WxpCJCxqz/3+6mA7jl+a55KAHd1cWJ17SV3sehhQSsp/eKkhRF5Ed9N8SzaqBY/1nreE
         MUkpOlOupnVltSV28EnDxoPfPFjqiseTeOL5KU8w2xcp3lbxhciqemj6TiKPYv5Qv4ds
         6dPw==
X-Gm-Message-State: APzg51BluudOgIvZB24Akx/MwZ/DfSw+6ca/H/GXelLDKDZ1V3YAq4OR
        /Bmxw4gdV48JhoUkV/mfT7w=
X-Google-Smtp-Source: ANB0VdZzLHK66i9AS76841+4a2EsFyFnu4mOjiuNL2J5gt2yDTqYMhnTtC9po7jcExnWXJJLr6pxJg==
X-Received: by 2002:aa7:84c2:: with SMTP id x2-v6mr41798833pfn.220.1536168423361;
        Wed, 05 Sep 2018 10:27:03 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id j16-v6sm4445801pfk.125.2018.09.05.10.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 10:27:02 -0700 (PDT)
Date:   Wed, 5 Sep 2018 10:27:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, marco.franchi@nxp.com,
        fabio.estevam@nxp.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] input: egalax_ts: add system wakeup support
Message-ID: <20180905172700.GA257188@dtor-ws>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Sep 05, 2018 at 05:26:46PM +0800, Anson Huang wrote:
> This patch adds wakeup function support for egalax touch
> screen, if "wakeup-source" is added to device tree's egalax
> touch screen node, the wakeup function will be enabled, and
> egalax touch screen will be able to wakeup system from suspend.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/input/touchscreen/egalax_ts.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
> index 80e69bb..74984ed 100644
> --- a/drivers/input/touchscreen/egalax_ts.c
> +++ b/drivers/input/touchscreen/egalax_ts.c
> @@ -164,6 +164,7 @@ static int egalax_firmware_version(struct i2c_client *client)
>  static int egalax_ts_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> +	struct device_node *np = client->dev.of_node;
>  	struct egalax_ts *ts;
>  	struct input_dev *input_dev;
>  	int error;
> @@ -224,6 +225,9 @@ static int egalax_ts_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	if (of_property_read_bool(np, "wakeup-source"))
> +		device_init_wakeup(&client->dev, true);

This is done in i2c core, there is no need to do it in the driver.

> +
>  	return 0;
>  }
>  
> @@ -241,6 +245,9 @@ static int __maybe_unused egalax_ts_suspend(struct device *dev)
>  	struct i2c_client *client = to_i2c_client(dev);
>  	int ret;
>  
> +	if (device_may_wakeup(dev))
> +		return enable_irq_wake(client->irq);
> +
>  	ret = i2c_master_send(client, suspend_cmd, MAX_I2C_DATA_LEN);
>  	return ret > 0 ? 0 : ret;
>  }
> @@ -249,6 +256,9 @@ static int __maybe_unused egalax_ts_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  
> +	if (device_may_wakeup(dev))
> +		return 0;

This will end up with unbalanced enable_irq_wake() from suspend.

> +
>  	return egalax_wake_up_device(client);
>  }
>  
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
