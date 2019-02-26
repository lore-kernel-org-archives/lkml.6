Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D86C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6DB21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAh95z1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfBZVAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:00:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35524 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfBZVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:00:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so6828878pfa.2;
        Tue, 26 Feb 2019 13:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GJ5c5CFLxCWYbBazJTIbcJc1pFOmediRIUvJ/eowSO4=;
        b=gAh95z1BMauRLjvOCwDXYxhxxqeT0GuFhitLyX/KIEjI3YdelmUSFDGVoz8idtxOif
         qqyHNu9RBFutJ2JjU78pGJaJwLJdO+ePtvtZwtTBJTlPol4xTdQh1B0mUrjlel6vL0M6
         Sc6faure+nJANxvcf2WYA9D73Hdhg1S72+d/gIA7NMv21f+Ha3HjluM/tmTeBrXrP0iY
         Z9bMWqynH7mI73ZDqGgwsxKmOBA+/W8IKCOgSI6V2jS2BjFu7b4pQiZnksI/MhX9NRl/
         SgyqjE0k/05I49FJolDcGB8l0Eb3bX8xXdBCEl60qWaexEoRzFjrPgRhh99wLNV3qHSg
         Y85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GJ5c5CFLxCWYbBazJTIbcJc1pFOmediRIUvJ/eowSO4=;
        b=B7W9oGJi1FNucoQcNmPCusmNWRwoO6+j4HY4lhJcEl37nRsBnXdvTlKhW5226XEOYG
         UYnHwb3voRxK8vje5uvQn8Dbi1EqsR1hhEC48wMUabpCOhwW4qJyjP2xFHWQKS9zgrLy
         xnOtK/HsW6fDUvXWu63qp6KPqo+xAEp8MNb9onld44YLO2mb7gMKijwSdTkxPX2fkdRE
         WbZGk2Rk18n5XBk/uX1YUGg0IBtqukXDDP7Md1gUS3a6yqb533GtSWLUKlLTD5bu/zze
         EeI7tflT44HW2rUUsKMGqapoQ1Gs0l9ZZPuaZigmbsaaiIMlgzN6gfHbhhJzT/RxNf/F
         JLwg==
X-Gm-Message-State: AHQUAuYcRX43spWCdXhAQRZbOzP1R3vQU4dIrCxEN4oRyTUfP47Q3piL
        YNZ5h0GBCXTwu+QiFBE+4d8=
X-Google-Smtp-Source: AHgI3IasXJr40V331K0dxuG4vi2by3c0gAxA1W2gomjOMKqavm1iqWW0CjNdILs+Mjj8RXnw2yompQ==
X-Received: by 2002:aa7:8743:: with SMTP id g3mr27451214pfo.109.1551214822129;
        Tue, 26 Feb 2019 13:00:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9sm21560783pfc.67.2019.02.26.13.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 13:00:21 -0800 (PST)
Date:   Tue, 26 Feb 2019 13:00:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sc520_wdt: Mark expected switch fall-through
Message-ID: <20190226210020.GB21115@roeck-us.net>
References: <20190226180114.GA13815@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226180114.GA13815@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:01:14PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/watchdog/sc520_wdt.c: In function ‘fop_ioctl’:
> drivers/watchdog/sc520_wdt.c:326:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    wdt_keepalive();
>    ^~~~~~~~~~~~~~~
> drivers/watchdog/sc520_wdt.c:329:2: note: here
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
>  drivers/watchdog/sc520_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
> index 6aadb56e7faa..403542f9ed8d 100644
> --- a/drivers/watchdog/sc520_wdt.c
> +++ b/drivers/watchdog/sc520_wdt.c
> @@ -324,8 +324,8 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  			return -EINVAL;
>  
>  		wdt_keepalive();
> -		/* Fall through */
>  	}
> +		/* Fall through */
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(timeout, p);
>  	default:
> -- 
> 2.20.1
> 
