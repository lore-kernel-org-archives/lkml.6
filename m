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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC31C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FDA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG+LuNA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FDA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJKAcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:32:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44454 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJKAcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:32:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id p25-v6so2822841pli.11;
        Wed, 10 Oct 2018 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MpB53qiALrrQbh7hdU4WgS0zkcNzQ3Z+7sUqL6DpFg8=;
        b=aG+LuNA7exG5bqk5yAe14dy2JTz6UoZcilKEm7X7ZyKMK6A4agJtOGl4bX9zgYRnTO
         PFVmwFYNCpM7C5sOmjqEOIuhZrnVjzfI+jQHoiVmle1gRSMfm7PbwwsaL0tymb6jthIh
         uKXDo2S0Isb+h1jFUikgD+OfV7tsqfOUMYOcQuJv2tRmy8D+89TysYztRCDeCSJ1uC9h
         UHhxa62GZhx+yRUAkl7NqeciZDLDJ3sDee6pvC/K1FpZPouUCPA80evBKb6kPpkstHkO
         brldF/Zk0Qg7NCGBxhpo0DwjORBy1M6gOKIQBfKrQGykhfB6jz+/j8Zp4q2OLWsVoa8t
         C7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MpB53qiALrrQbh7hdU4WgS0zkcNzQ3Z+7sUqL6DpFg8=;
        b=tcjfGlB8CP+AgeOekLqhoYEnjFRY/37UkqmmpIbqs5812+ie50JoXGbX5eSYk7bZaF
         CL+h6pfPxalxSweuOC382ghNAxUMekM5yuA4P187C3PF9Heuy21S4Ob+01TMmOBXPLyI
         ToFFOJWWr3XmqO9ODQCsjGbmR0g9SqBNQy/XsSAtuA5knXHQ1cpBamgkGBa8S9LccQzl
         Bxo/73fh6DW4GmTqlk5j+QX5UecwID5gqJc+Okp3LZgECdwfkfhY0WmexYS+HlUODy0F
         Yoigl2bA/JMYJ5wuWpzzzzEmNZ5VJ3mBiERRm/VscMkR/kx3zyloyKsdOdgxrDD9R3wl
         M48w==
X-Gm-Message-State: ABuFfog2ADLF0iMwvbM9TbjVvj04g6u1fAejnyWqE/9QKSPIgLAOoIj8
        VIuUq0vgHqPadEiR1zxg+hw=
X-Google-Smtp-Source: ACcGV61AAJHXX91jiYR+qqyFZN+4YwENHwnLETgt8vw1TUCKzqUpXyUeUHogbsjWNT2lC9NZmHUXYQ==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr32931425pld.168.1539191345042;
        Wed, 10 Oct 2018 10:09:05 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v38-v6sm50337744pgn.57.2018.10.10.10.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:09:04 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:09:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 7/8] Input: olpc_apsp: enable the SP clock
Message-ID: <20181010170901.GC47260@dtor-ws>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-8-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-8-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:25:03PM +0200, Lubomir Rintel wrote:
> Without the clock, the keyboard controller won't operate.
> Tested on an OLPC XO 1.75.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/input/serio/olpc_apsp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> index 8b19a47dfa46..fe9e19014e70 100644
> --- a/drivers/input/serio/olpc_apsp.c
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -23,6 +23,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/clk.h>
>  
>  /*
>   * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
> @@ -74,6 +75,7 @@ struct olpc_apsp {
>  	struct serio *kbio;
>  	struct serio *padio;
>  	void __iomem *base;
> +	struct clk *clk;
>  	int open_count;
>  	int irq;
>  };
> @@ -146,8 +148,13 @@ static int olpc_apsp_open(struct serio *port)
>  	struct olpc_apsp *priv = port->port_data;
>  	unsigned int tmp;
>  	unsigned long l;
> +	int error;
>  
>  	if (priv->open_count++ == 0) {
> +		error = clk_prepare_enable(priv->clk);
> +		if (error)
> +			return error;
> +
>  		l = readl(priv->base + COMMAND_FIFO_STATUS);
>  		if (!(l & CMD_STS_MASK)) {
>  			dev_err(priv->dev, "SP cannot accept commands.\n");

I think you need to disable clock here.

> @@ -171,6 +178,8 @@ static void olpc_apsp_close(struct serio *port)
>  		/* Disable interrupt 0 */
>  		tmp = readl(priv->base + PJ_INTERRUPT_MASK);
>  		writel(tmp | INT_0, priv->base + PJ_INTERRUPT_MASK);
> +
> +		clk_disable_unprepare(priv->clk);
>  	}
>  }
>  
> @@ -198,6 +207,10 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	if (priv->irq < 0)
>  		return priv->irq;
>  
> +	priv->clk = devm_clk_get(&pdev->dev, "sp");
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
>  	/* KEYBOARD */
>  	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
>  	if (!kb_serio)
> -- 
> 2.19.0
> 

-- 
Dmitry
