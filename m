Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B392FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F58A21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6wz+GXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfBZVA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:00:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45435 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfBZVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:00:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so6802319pfm.12;
        Tue, 26 Feb 2019 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/X4RJ/C5T7p5UgXB9JDhsvGYzBvMgGxd30DdiJnX1MA=;
        b=Y6wz+GXIOFp2YHYyQ5CV6cMeoyCcGlkrv/PEbAUOuNuDZ4WOXlzuJkdaGSWkhVkI2q
         QBuP3ErOgRP4IXzuNFnzNIlG8qPBaASZWbAjM+BjLuEgvfHD3Wy1Ro1YOk0UW0+NWnUw
         eKCIwcmgSv3KzZAd62DD0zjuBJztFwKS4h9HpXRfLqQJV9OOlB8kqZHWx9+WfaIP6yMC
         tyoSXwIBw7vf9/k6Nk1nr/6lf4Sbn4CowtGTi5hb9DxLReP+A45i/iSixzLJpTjZJud/
         NVz5iQEgAjislLMigDSTOc48vwzIgw79cNzxrNtTbEaMxhnwqoSnwcLUCh/L7n1rLI8O
         GiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/X4RJ/C5T7p5UgXB9JDhsvGYzBvMgGxd30DdiJnX1MA=;
        b=A2/TtULcEQA+gNCB1NFz5NPjPPT0y+8UO5nXc7NIFhK0nEQEew1i37A2fZJUROORXB
         I6VN+tLswla9p2PpXvM0ZVU4B5kYUz1HKOzq5pgnSCoBcUKlLF54RKhqbpu75ctGtg0p
         riYPAOFH+pOMG9f9R1XCKx5yKWrqWTlYMMMGXrGjmt44MmxEsfMJ3A0zcuVK8lZKvcuj
         Zwa8r/0WUW4fxbcmz5r/VOYN5qTOnZLp1sYmsGToe/SlH0hE3D7+bBBVKc5SWcR5yqCB
         8XhoLN3+nP4tTQsLdmHQgwTuAQx4uCvrvRxYOSU9ICSuCMRmunpXDBDSq+YTBPXA9FsI
         MjhA==
X-Gm-Message-State: AHQUAubeVaVxWJHWa3Iw14/uik/Y4KatWjMnFUzPrHeklPsCF2GUzltr
        2QRH8EPNW/KdwqpBR7gI1Sk=
X-Google-Smtp-Source: AHgI3IavqMma82lfPcsg5O5ADboZGTkQfnjk30HftGgj9D+xaXKOXYUuOrHUU5wlncUqowdeZwk51g==
X-Received: by 2002:a63:854a:: with SMTP id u71mr21917321pgd.141.1551214855761;
        Tue, 26 Feb 2019 13:00:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g185sm19856597pfc.174.2019.02.26.13.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 13:00:55 -0800 (PST)
Date:   Tue, 26 Feb 2019 13:00:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] watchdog: w83877f_wdt: Mark expected switch fall-through
Message-ID: <20190226210054.GC21115@roeck-us.net>
References: <20190226190743.GA18722@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226190743.GA18722@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 01:07:43PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/watchdog/w83877f_wdt.c: In function ‘fop_ioctl’:
> drivers/watchdog/w83877f_wdt.c:294:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    wdt_keepalive();
>    ^~~~~~~~~~~~~~~
> drivers/watchdog/w83877f_wdt.c:297:2: note: here
>   case WDIOC_GETTIMEOUT:
>   ^~~~
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
>  drivers/watchdog/w83877f_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
> index 05658ecc0aa4..db9b6488e388 100644
> --- a/drivers/watchdog/w83877f_wdt.c
> +++ b/drivers/watchdog/w83877f_wdt.c
> @@ -292,8 +292,8 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  		timeout = new_timeout;
>  		wdt_keepalive();
> -		/* Fall through */
>  	}
> +		/* Fall through */
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(timeout, p);
>  	default:
> -- 
> 2.21.0
> 
