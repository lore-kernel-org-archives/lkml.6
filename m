Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C8A20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QffwvGbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C8A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbeG0T7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:59:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39514 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbeG0T7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:59:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id m1-v6so2663599plt.6;
        Fri, 27 Jul 2018 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnKY7L6Y5APaSKcFOuqVVIEIz5Bgr3TAg5jAzdkGJrY=;
        b=QffwvGbnTQvLX15oAh1fpkUwEyUuMQKBQyOqJ/lgOyaqkyldRyWK2LxwOx+fQMSFJh
         HLzM25Oh1rvyRxmUJKCUgGq+85qojrBsGstppPSMeibB2eM5PmKnOa8xHAu2PLzQ/OKf
         uwmbZhLfwUqkQI8SOC8fEztNso4RH2wd2+nVKtmKusd1F1g2rlUs61vvOLsFB7iTgzpv
         1WVdpIa522sd/XdedtXw0mvZL9btXeIbum0y1Eu72wP/FQcDqtzABjyxgza/zGK0aIBH
         I/3VSqMU5byq3DjCOdecAC52u6AGLWaAQfTlORPVO4C049VQWbkn2gPwbUL8OAXn7QOC
         QB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnKY7L6Y5APaSKcFOuqVVIEIz5Bgr3TAg5jAzdkGJrY=;
        b=swUNKEBDLD2oxM3Ym8mmjhHO5/57Lk/kn9STfMI/j7aIiEmX6Fmg3jZAH/KsaXUhnZ
         E9CUVrUVVZnJXA2ej0qRtQKxDMbpyFf5I0e8PAKcWGqXb/d5OWV7uv/rAXg41RznBaEq
         Z+7pIqR1K80Gtyx6SQEPodyHya76iozvNhtnRDp4IwFEsbLxnucy6z4bRfwk9cQwLYLH
         U3x3pgHvu8dXlKOpjNHblsLYE7xQfxtAFjcAfOFDN3pusYPa6uSHQTA5EWyBDnmvj4VR
         KPhuBm0EyyoloE9qRlSbpRizfvj/U/50hi0beqtSY8qyQzeT9OoFiBiIeQ0EiCDu1DDl
         BMgg==
X-Gm-Message-State: AOUpUlEuKQIt7Bxzwc1KJGjenCgt8xl8iOeuwtqoTGtedjM8fUtDwZS5
        /nMYSlNdahpIj9MsYdG/Fyk9L1Vj
X-Google-Smtp-Source: AAOMgpde83r9vfjBVdlw4Di6qJnL9wsVac4tRAxnAL3i6V/2/atVeemsDPKESfXzIydtYtI+MswLBQ==
X-Received: by 2002:a17:902:b785:: with SMTP id e5-v6mr7025253pls.339.1532716566442;
        Fri, 27 Jul 2018 11:36:06 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id e16-v6sm6217847pfn.46.2018.07.27.11.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:36:05 -0700 (PDT)
Date:   Fri, 27 Jul 2018 11:36:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     gustavo@embeddedor.com, arvind.yadav.cs@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: mouse: appletouch: Replace GFP_ATOMIC with
 GFP_KERNEL
Message-ID: <20180727183603.GF72640@dtor-ws>
References: <20180727022618.1007-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727022618.1007-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:26:18AM +0800, Jia-Ju Bai wrote:
> atp_open(), atp_recover() and atp_resume() are never 
> called in atomic context.
> They call usb_submit_urb() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/appletouch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index 032d27983b6c..f593ec96c95f 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -810,7 +810,7 @@ static int atp_open(struct input_dev *input)
>  {
>  	struct atp *dev = input_get_drvdata(input);
>  
> -	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
> +	if (usb_submit_urb(dev->urb, GFP_KERNEL))
>  		return -EIO;
>  
>  	dev->open = true;
> @@ -976,7 +976,7 @@ static int atp_recover(struct atp *dev)
>  	if (error)
>  		return error;
>  
> -	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
> +	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
>  		return -EIO;
>  
>  	return 0;
> @@ -994,7 +994,7 @@ static int atp_resume(struct usb_interface *iface)
>  {
>  	struct atp *dev = usb_get_intfdata(iface);
>  
> -	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
> +	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
>  		return -EIO;
>  
>  	return 0;
> -- 
> 2.17.0
> 

-- 
Dmitry
