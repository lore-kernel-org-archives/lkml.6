Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26AAC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755AD208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755AD208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeKODFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:05:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42312 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeKODFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:05:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D67DE20D73; Wed, 14 Nov 2018 18:01:10 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id AF8512072A;
        Wed, 14 Nov 2018 18:01:10 +0100 (CET)
Date:   Wed, 14 Nov 2018 18:01:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: max8997: Fix the returned value in case of error in
 'max8997_rtc_read_alarm()'
Message-ID: <20181114170110.GZ29768@piout.net>
References: <20181114165025.2293-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114165025.2293-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2018 17:50:25+0100, Christophe JAILLET wrote:
> In case of error, we return 0.
> This is spurious and not consistent with the other functions of the driver.
> Commit 22652ba72453 has modified more than what is said in the commit
> message and error should be propagated.
> 
> Fixes: 22652ba72453 ("rtc: stop validating rtc_time in .read_time")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure that the Fixes tag is the right one.
> It is related, but not 100% accurate IMHO.

Well, as you note, this make your commit message wrong 22652ba72453
didn't modified more than what it said and the behavior stayed exactly
the same as the previous one. Can you reword?

> ---
>  drivers/rtc/rtc-max8997.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
> index 08c661a332ec..20e50d9fdf88 100644
> --- a/drivers/rtc/rtc-max8997.c
> +++ b/drivers/rtc/rtc-max8997.c
> @@ -215,7 +215,7 @@ static int max8997_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  out:
>  	mutex_unlock(&info->lock);
> -	return 0;
> +	return ret;
>  }
>  
>  static int max8997_rtc_stop_alarm(struct max8997_rtc_info *info)
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
