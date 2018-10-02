Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DFFC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95FB204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="Fp9zlxnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95FB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=linux-watchdog.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJBSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:40:19 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:48906 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJBSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:40:19 -0400
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 3FA74406E1; Tue,  2 Oct 2018 13:35:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 3FA74406E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1538480116;
        bh=6D00COcLsxtq6E5vxCcIbwQc9qUhMrqAk+F2vVHmTvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fp9zlxnZiZnM2308/JnCgbqD+EfGR/OQEWjXLC0my37dcmEi7qt1cJLxyGZB3FgZF
         Xd5KSgFPQ/Y9DqU0T6cYvLMc2fIEUKGNMURC34f2QHPO0IxLXhKONMd+LkRvLeSPUI
         WN1oijsjjfxS66xlV5ojUIL0tFv4awlVSjUTSiVg=
Date:   Tue, 2 Oct 2018 13:35:16 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: w83627hf_wdt: Support NCT6796D, NCT6797D,
 NCT6798D
Message-ID: <20181002113516.GA8957@www.linux-watchdog.org>
References: <1537710851-11017-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537710851-11017-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 06:54:11AM -0700, Guenter Roeck wrote:

> The watchdog controller on NCT6796D, NCT6797D, and NCT6798D is compatible
> with the wtachdog controller on other Nuvoton chips.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Wim Van Sebroeck <wim@linux-watchdog.org>

> ---
>  drivers/watchdog/w83627hf_wdt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index 7817836bff55..4b9365d4de7a 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -50,7 +50,7 @@ static int cr_wdt_csr;		/* WDT control & status register */
>  enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>  	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
>  	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
> -	     nct6795, nct6102 };
> +	     nct6795, nct6796, nct6102 };
>  
>  static int timeout;			/* in seconds */
>  module_param(timeout, int, 0);
> @@ -100,6 +100,7 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>  #define NCT6792_ID		0xc9
>  #define NCT6793_ID		0xd1
>  #define NCT6795_ID		0xd3
> +#define NCT6796_ID		0xd4	/* also NCT9697D, NCT9698D */
>  
>  #define W83627HF_WDT_TIMEOUT	0xf6
>  #define W83697HF_WDT_TIMEOUT	0xf4
> @@ -209,6 +210,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>  	case nct6792:
>  	case nct6793:
>  	case nct6795:
> +	case nct6796:
>  	case nct6102:
>  		/*
>  		 * These chips have a fixed WDTO# output pin (W83627UHG),
> @@ -407,6 +409,9 @@ static int wdt_find(int addr)
>  	case NCT6795_ID:
>  		ret = nct6795;
>  		break;
> +	case NCT6796_ID:
> +		ret = nct6796;
> +		break;
>  	case NCT6102_ID:
>  		ret = nct6102;
>  		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
> @@ -450,6 +455,7 @@ static int __init wdt_init(void)
>  		"NCT6792",
>  		"NCT6793",
>  		"NCT6795",
> +		"NCT6796",
>  		"NCT6102",
>  	};
>  
> -- 
> 2.7.4
> 
