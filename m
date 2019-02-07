Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D28FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FC22175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn4MDZfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBGWbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:31:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35870 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfBGWbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:31:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so666994plo.3;
        Thu, 07 Feb 2019 14:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lLWIC17cmUwaSZQxGmkgq+akE9QuEgTMWwUqEZhdOfo=;
        b=nn4MDZfodsLMuN2V89LFBGLPJjNSOF8V3icw0dG6OPVkijpccGCmtudvcbDK1+Labw
         1zMcGL1bVqLdpLv1YU/uUV6aWAOFmPig4RkUX51GFY6mIQBBRPpbsWu7pIPe0js9mg1U
         FXHeN/34UPQu9ldaixf9gf5q0K6NBYTxWegCrJZ+l5wLiTsGf4Uq2baMVZ9QkacbTTEL
         A2vdjxY7wHjejTM+q745szYEZbz1Q5o1m7APGVa+EKos44V4ALSMv5jqlOJYBSq400E0
         JqRF7bE1Kl63GdNO/Ib3r3Wy9fg/vkk4GPwNfvRQyFlsIGanQd1cjCle4YfM62xqeod2
         K4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lLWIC17cmUwaSZQxGmkgq+akE9QuEgTMWwUqEZhdOfo=;
        b=nPKzVWmkx+36spd3mB4uNLJlAKwEdRpjSE1lfRw8k2MgfCH2HYsMjum32p3g7fSaRT
         sYD3iYio4FnhzmaC3WHfgFVuSV4Gw7yX+/ve7lBNtimu+InCoySjDCnOcLtAz/Tv/+r5
         cCR0hkfnmBZ3WbLVetehiWe0dlg0mvqMMHxDW666J5QuqdbWrHYvHbdhWrJoRrftnfza
         C+4fIMGge4QWwkprxT5puGtE5P4pEl9APoCHhtE0uBUQW5XnIneyKx9D9A+zqZUeBoOh
         luqIzI4ILJFtXjZCG2UkQAMH2dRf7ek1R6WCjrCOX+NL+C2SgZ9fMnpV36/RO4eWL/8c
         gULw==
X-Gm-Message-State: AHQUAuZ03oQzl/Ws18c+DHzVo4IziaFbSzZmXnA02DG86QNrKjnE/o5+
        /6b7meK3kZFTzWYzleit3zuJTGY6
X-Google-Smtp-Source: AHgI3IZm9zDgPgxnum/WL+NupAmxDIDr5nsJWur30/sy5+3Ni9psekHEZDW/Ecj9fPftbyDGU1yVGQ==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr18716812plq.195.1549578682950;
        Thu, 07 Feb 2019 14:31:22 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w185sm173849pfb.135.2019.02.07.14.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 14:31:22 -0800 (PST)
Date:   Thu, 7 Feb 2019 14:31:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
Message-ID: <20190207223120.GA30023@dtor-ws>
References: <20190207222740.GA38612@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207222740.GA38612@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:27:40PM -0800, Dmitry Torokhov wrote:
> To ensure that TX work is not running after serio port has been torn down,
> let's flush it when closing the port.
> 
> Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/serio/ps2-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
> index c62cceb97bb1..9e1dbde2e15b 100644
> --- a/drivers/input/serio/ps2-gpio.c
> +++ b/drivers/input/serio/ps2-gpio.c
> @@ -76,6 +76,7 @@ static void ps2_gpio_close(struct serio *serio)
>  {
>  	struct ps2_gpio_data *drvdata = serio->port_data;
>  
> +	flush_work(&drvdata->tx_work.work);

Ah, we have flush_delayed_work() now, I'll change it before committing
once we agree on the patch in principle.

>  	disable_irq(drvdata->irq);
>  }
>  
> -- 
> 2.20.1.611.gfbb209baf1-goog
> 
> 
> -- 
> Dmitry

-- 
Dmitry
