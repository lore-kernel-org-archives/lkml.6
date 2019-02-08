Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28AAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBE721924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svYxcveE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfBHHf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:35:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45084 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfBHHf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:35:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so1280859plm.12;
        Thu, 07 Feb 2019 23:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6xOlCJP9BiIAilDkxBEwX/lLlgFnZqX/CUuBUlXMnEU=;
        b=svYxcveEQuOcK+2Y9I0mOENnENx+GuNgqsrENDTK2fXwSw1yy9yyRu9pUUXTovjCzS
         j+kHd0OmWOlhahLbyetkLvH+3gqaAukQV3RLAfv9hjKpyppWcTm323ZUZCgJDbULIjL8
         AY+q704PkXJfwzpR0m/igH4wp9uKhP8vSfoYHBpUQXKexjQY/bAJ37DmNICTiA9ZzHRz
         /jDOONyuxxaoiDR0plZBJ+6OSZ6eRSgN6OnBEI7ICYtpkMmZ99ziCcoxATIlXgn4Lk6K
         nni+1wj4ZrYe+Xj96iJ+c0ySQAD+T/xP97fbpY2XjN3e+cg87fuQyJU5VdPp5/RVtYwD
         cLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6xOlCJP9BiIAilDkxBEwX/lLlgFnZqX/CUuBUlXMnEU=;
        b=VkKQaMq2sMhEgC2SJWn9CPb/uX1trMJ3289VcrE72d5gmMUEtYWHBv9+dawlq3EiZv
         kYhu9xIcFBVe79YlUOaMdKPvecQYl52TYg4fikcCP1UdEg0FO2clUWB4chwUclZTRDBM
         eXaQoM0j7U8J/DZXmlQSCP0Lr4seAWfAQKIzKaN9EuWokP56XGjHrGp/GYXgCr8DenW7
         rrn4hiuebTKV7KfBvfjbxJkzK106538pIRPeqOauZxkYlUQxQc+vu0dHt+WehbYSe0Lc
         cgxQSrjf7cPpeMqUyzSb6NvMw4R2q91hrOA0ANbWjKZNCVwXhETT18/WERgHqk0S6gDN
         1+nA==
X-Gm-Message-State: AHQUAuZpxNaxYO9bXUAbxYv7QKScPhf7uEibPWG4OedVAJb0CnhIYzuf
        pvKT9hn7h4J5UbU+aGatNeQ=
X-Google-Smtp-Source: AHgI3IYX3nIFpS4mr59LBCt7y62Cu0v0D9RYGGjnvmGQzUlAUczXPwoPhkplk7R/7u0tioXHsjj25g==
X-Received: by 2002:a17:902:296a:: with SMTP id g97mr21400955plb.317.1549611356777;
        Thu, 07 Feb 2019 23:35:56 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f12sm1359914pgo.13.2019.02.07.23.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 23:35:56 -0800 (PST)
Date:   Thu, 7 Feb 2019 23:35:54 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] input: keyboard: gpio-keys-polled: use input name from
 pdata if available
Message-ID: <20190208073554.GB31622@dtor-ws>
References: <1549559131-7423-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549559131-7423-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Thu, Feb 07, 2019 at 06:05:31PM +0100, Enrico Weigelt, metux IT consult wrote:
> Instead of hardcoding the input name to the driver name ('gpio-keys-polled'),
> allow the passing a name via platform data ('name' field was already present),
> but default to old behaviour in case of NULL.

I thought the world is moving away from platform data and towards
OF/ACPI systems. What device are you targeting with this change?

I would want to convert gpio-keys[-polled] to generic device properties
and away form platform data...

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/input/keyboard/gpio_keys_polled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index edc7262..3312186 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -272,7 +272,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>  
>  	input = poll_dev->input;
>  
> -	input->name = pdev->name;
> +	input->name = (pdata->name ? pdata->name : pdev->name);
>  	input->phys = DRV_NAME"/input0";
>  
>  	input->id.bustype = BUS_HOST;
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
