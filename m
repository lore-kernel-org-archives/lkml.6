Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E9420836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn3oIpgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbfBRQIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:08:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33916 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbfBRQIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:08:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so1786703plr.1;
        Mon, 18 Feb 2019 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JumpSt0dL1WAbMiw7u9AE61xMOnp85xHD1RTwl+/+mI=;
        b=hn3oIpgYjjPgLNtlFrzujhrmZb9v+Z2ugTsEZOxTcrABTvRjjsjFS4+JT13qvYlX5h
         CpJioeqEtHw6Id8V34MCwvpjebHvbwFVYyUHZj5SUs2aFYShjfxgO8YagEgWYpPZ2zeV
         R6JJ6bQD3fcY1/EnbAbFSAHPOhmR0I+LzUbsDk/FOpabeC4Pvj695yxbCwmLtrlD9nx+
         ajybhrpo472UmtkIW360wYq0+CeO8EuYjzyee9yCnXday3RPhgq7RrMgWmL0LGIKOHxk
         oTS8WSs4735fmUwTpcxXS9gWSru0ReqyplP5Pjtm00wfNt9buZuGhyH318T5vQ0y9PqJ
         fWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JumpSt0dL1WAbMiw7u9AE61xMOnp85xHD1RTwl+/+mI=;
        b=otMPQdn2XvZutg9Bjg+cVXbyZr2GmXnRdGRhpvu6XkJZaEM39wX80ppO1RQmxpY0Bj
         uj+AtLsaJyRq6XXulC/WWbELM1GV0nLfhk2M3XFWIyiPN/xirs0eYwb2535RpE5uDtM5
         hBCTFic9APGjF3R0FGSx2GP4VEap3NEUXiFDJMJQKI+XJcGc0Zdv+lunRYRHH3Yo4fDp
         MLCGJrRx9yLuQJoaGTuVixPWgXzi2vjIo7SykMLpAYc8r8L4UvusKW4L6HAZeXjTPF4m
         /WDWe4J9o0T1s7CjP14yhPRVYRdqrHiiLYpySDiFMD0AxSeoheLDqlj3FEkGriOrhJwA
         ++xw==
X-Gm-Message-State: AHQUAuYAM7eYZJ4V7VTN6MA4aNKjOK5R0qdcqeW7d/YS9H04Qpj3xZt+
        RpQ+IzdxGeyjNG+j8yFP12MD9Zh6
X-Google-Smtp-Source: AHgI3IZeJNpuGKoidT4K4qsUVwzaYp1rmiL7qxu/3j1IXkYZazHbhIZj96R0f1Vc8nyqbCSvbUTZzw==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr26265953plb.55.1550506124304;
        Mon, 18 Feb 2019 08:08:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e26sm16798857pfi.70.2019.02.18.08.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:08:43 -0800 (PST)
Subject: Re: [PATCH] watchdog: sc1200: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Zwane Mwaikambo <zwanem@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190214202008.GA15525@embeddedor>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <92afc448-e0c1-eaa4-8728-45af328e5163@roeck-us.net>
Date:   Mon, 18 Feb 2019 08:08:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214202008.GA15525@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 12:20 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/watchdog/sc1200wdt.c: In function ‘sc1200wdt_ioctl’:
> drivers/watchdog/sc1200wdt.c:241:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     sc1200wdt_write_data(WDTO, timeout);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/watchdog/sc1200wdt.c:244:2: note: here
>    case WDIOC_GETTIMEOUT:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sc1200wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
> index 8e4e2fc13f87..e035a4d4b299 100644
> --- a/drivers/watchdog/sc1200wdt.c
> +++ b/drivers/watchdog/sc1200wdt.c
> @@ -239,7 +239,7 @@ static long sc1200wdt_ioctl(struct file *file, unsigned int cmd,
>   			return -EINVAL;
>   		timeout = new_timeout;
>   		sc1200wdt_write_data(WDTO, timeout);
> -		/* fall through and return the new timeout */
> +		/* fall through - and return the new timeout */
>   
>   	case WDIOC_GETTIMEOUT:
>   		return put_user(timeout * 60, p);
> 

