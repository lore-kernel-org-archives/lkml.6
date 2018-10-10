Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE82EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864A22086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUUMu8I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864A22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJKAaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:30:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38877 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJKAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:30:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so2838866plr.5;
        Wed, 10 Oct 2018 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=17GpGz7Mq6toQSFaKTJ9yvKZv31EtEDLdwrUXXO8r5A=;
        b=qUUMu8I1B5ZnuP5eTukt3XbMSL+rV0OcBZJKN6m0DDyZU+ip1RDgRhBY819mtq0aKt
         dt/XJXosvP8iyV/rWBZXCLS1o1YF3Oxyuddf9UwfCBbmKjTMHW+3wqOWiF4h8Ky5BNFD
         SMzOBcGRs0kPGxRdFBa9WmLNO7Ee4dANmVjPUwXmSVodZlB5T/0ayzP/KnRVlsOVxVac
         vMLLOJld9Yyi13SoqEdNxpDMuYZmFeCvq5SiH3RVGg1PWUicnsx8ZLIdWJcMrt+OXmox
         Kli31cwbXoOAlcPSCdaOgrptjZvYEX19H5DoB16A1y3DjLAHvG3b68ptyuxIZQHqhGRU
         QNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=17GpGz7Mq6toQSFaKTJ9yvKZv31EtEDLdwrUXXO8r5A=;
        b=YAi5H2xP49oZb9wOnYMQ8rTzKAlFNxINpfrgFCW+YN/BJ5PeLS8cvN7AvlYrZTwiBK
         OP6UOlgRRbyAHa2oa6IvLEsBfbUrcmsGKhhD+dKjrwq/TpXl60mEuDbtXIyXzDFfe7Re
         N6eOjwo8rJ7qSKToZ0hgOaKZAoFNNZIAt6ndTuOt1eDqi1twUEcF8GhdgxZkJFavuZPP
         /dIoa8bW8e5WhCSpekpStTSwP+yIyctmLax8uMx7VyRcB5UPXsB8V7kMKaJ/SzOTlPLl
         1UhAErrb0jnzDB8Nxl1TTi29ihSGYvRcGz5NleCNy8Y6dXGuvyvI3SOzS6VEhGn/1+kz
         jyLw==
X-Gm-Message-State: ABuFfojAjITytCeSUZXSLfhejtb+pvFopw27w45WtIUYW5+w2SRCJHfM
        g8MaQKx6kmcrNPVMTiWFHfI=
X-Google-Smtp-Source: ACcGV63uT3dk2ynfPxqRV5CtJPaLwR/wQFtWca20Lzed7U7WNPZvm6qmvxTVN7nr4xua80FgdwmEwQ==
X-Received: by 2002:a17:902:7408:: with SMTP id g8-v6mr144584pll.221.1539191228990;
        Wed, 10 Oct 2018 10:07:08 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x13-v6sm20367567pge.13.2018.10.10.10.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:07:07 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:07:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Input: elants_i2c - Use DMA safe i2c when possible
Message-ID: <20181010170705.GB47260@dtor-ws>
References: <20181010165517.178545-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010165517.178545-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:55:17AM -0700, Stephen Boyd wrote:
> This irq handler is always reading bytes from the device into a
> kmalloced buffer, so it's safe to mark this transaction as DMA safe.
> This avoids bouncing the buffer when an i2c controller decides to use
> DMA for a transaction.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

No, the buffer is in kmalloc()ed memory, but it is not DMA safe, as it
it not guaranteed to be aligned on cache line size. If you want to do
DMA to it, you need to change:

struct elants_data {

	...
	u8 buf[MAX_PACKET_SIZE] ____cacheline_aligned;
};

i.e. mark it ____cacheline_aligned and move it to the very end (or mark
the next element in the structure cacheline aligned as well).

Otherwise DMA might smash nearby fileds in this structire.

> ---
>  drivers/input/touchscreen/elants_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index d21ca39b0fdb..be44abb8de33 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -863,7 +863,7 @@ static irqreturn_t elants_i2c_irq(int irq, void *_dev)
>  	int i;
>  	int len;
>  
> -	len = i2c_master_recv(client, ts->buf, sizeof(ts->buf));
> +	len = i2c_master_recv_dmasafe(client, ts->buf, sizeof(ts->buf));
>  	if (len < 0) {
>  		dev_err(&client->dev, "%s: failed to read data: %d\n",
>  			__func__, len);
> -- 
> Sent by a computer through tubes
> 

Thanks.

-- 
Dmitry
