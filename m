Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E399BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B209620684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B209620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJDTqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:46:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37630 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeJDTqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:46:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B88D207C4; Thu,  4 Oct 2018 14:53:41 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1E312207C4;
        Thu,  4 Oct 2018 14:53:31 +0200 (CEST)
Date:   Thu, 4 Oct 2018 14:53:31 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: m41t80: fix fall-through annotation
Message-ID: <20181004125331.GR4088@piout.net>
References: <20181004123528.GA27013@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004123528.GA27013@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/10/2018 14:35:28+0200, Gustavo A. R. Silva wrote:
> Replace "Fall" with a proper "Fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 

Can we agree that this is absolutely not a fix? I don't wan't to have
that needlessly backport on gazillion stable kernel.

> Addresses-Coverity-ID: 1373875 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-m41t80.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index ad03e2f..a3fb235 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -745,7 +745,7 @@ static int wdt_ioctl(struct file *file, unsigned int cmd,
>  			return -EINVAL;
>  		wdt_margin = new_margin;
>  		wdt_ping();
> -		/* Fall */
> +		/* Fall through */
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(wdt_margin, (int __user *)arg);
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
