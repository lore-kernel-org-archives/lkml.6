Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCD3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE87E2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAVMyKEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE87E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeJKHfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:35:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43812 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:35:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id 80-v6so3256458pgh.10;
        Wed, 10 Oct 2018 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmvqpHe2ph1DP2H+beOKbjfMguTjkiAc9IpPo/oKCUo=;
        b=sAVMyKEgrYD4XUPdZm18wU6Jmex2CT+QZblZ98CCjr5F85UMRhqrvYAc8+bSH4dIad
         og7DzyurNHdiGHzZ+Ztabx71s9BTjShoP+rIegrbU5vH/W7UeAqj0iiS9HfeOevJeJOg
         Y0nSSgLBzoxV9omyAlrlmRvNvaUx7WxLOKiSsfyvxVbRIiF15/zrpXQvFq2ik9UtSRpR
         FI8METRBZ5yAm506YQk+mpLDHNUvoNHaZncg08dgyVgnRt8Qbzq53HGG7+wFFb003ZXT
         IbsrnreiOXQxqtSqVerd5dnf6VkQYDjpeJ2J99gb2huqXREAms84zQae0ji/PbCITOKg
         Rgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmvqpHe2ph1DP2H+beOKbjfMguTjkiAc9IpPo/oKCUo=;
        b=XGMaxaJkkUOuoyOjExxDNq/5m5hxAm5JYKKRp+A4BMIrX9YZJwlnlexBfBUeg2EOU3
         gSm2ATDINmrL6zacX6DiSrlB6yKgzvAfaVELrQKE0XMprDPck387amuHL1ZxUkxKbpO+
         tljiDT53PAwVKoASefVqhrYGYryPbUkdGgIWjAqB9D7gjjrDDOZuA3xpbKAk1BXuADoQ
         HZCUGEHqBqNaNrsIg4+KSpZ788rKk1o7x7xdMDor7TG626V9lr+sx8h5KfOZs8WIGFpD
         T5E9YWKgKzb0oUrko94ZyYSZ1nlJx7jo6gAU1O7v+4aG3TNANUoJccYox33Ln1oNT51Q
         M97A==
X-Gm-Message-State: ABuFfoievjk5v1KBcOlyTcbnqfpF9hRVbd0h2GAgLNwsvJ4RFwVloFk/
        ytcdEC8sxGK0rNcSjGgITUQ=
X-Google-Smtp-Source: ACcGV60ODuCmFUIHx0s/Mk4hTW7tyRXSsBfXwEb2Kzfnxdq1j1Oy9S/2PJj+KRypecFwbosvQrWgqg==
X-Received: by 2002:a63:ef0b:: with SMTP id u11-v6mr31621844pgh.283.1539216678558;
        Wed, 10 Oct 2018 17:11:18 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k72-v6sm26706352pfj.63.2018.10.10.17.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:11:17 -0700 (PDT)
Date:   Wed, 10 Oct 2018 17:11:14 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] Input: elants_i2c - Use DMA safe i2c when possible
Message-ID: <20181011001114.GA173303@dtor-ws>
References: <20181010200017.255874-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010200017.255874-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:00:17PM -0700, Stephen Boyd wrote:
> This irq handler is always reading bytes from the device into a
> kmalloced buffer, so it's safe to mark this transaction as DMA safe.
> This avoids bouncing the buffer when an i2c controller decides to use
> DMA for a transaction.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Changed patch description a bit (now that we are actually making the
buffer DMA-safe) and applied, thank you.

> ---
> 
> Changes from v1:
>  * Moved buf to end of structure to keep it cacheline aligned and DMA
>    safe
> 
>  drivers/input/touchscreen/elants_i2c.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index d21ca39b0fdb..f2cb23121833 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -147,10 +147,11 @@ struct elants_data {
>  	u8 cmd_resp[HEADER_SIZE];
>  	struct completion cmd_done;
>  
> -	u8 buf[MAX_PACKET_SIZE];
> -
>  	bool wake_irq_enabled;
>  	bool keep_power_in_suspend;
> +
> +	/* Must be last to be used for DMA operations */
> +	u8 buf[MAX_PACKET_SIZE] ____cacheline_aligned;
>  };
>  
>  static int elants_i2c_send(struct i2c_client *client,
> @@ -863,7 +864,7 @@ static irqreturn_t elants_i2c_irq(int irq, void *_dev)
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

-- 
Dmitry
