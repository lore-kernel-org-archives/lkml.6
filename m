Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC866C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A31720842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh9F+6FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A31720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbeG0T7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:59:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35370 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbeG0T7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:59:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so3709674pgv.2;
        Fri, 27 Jul 2018 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/LeTUjB5qfIk6EUKmpDYuf2DYuV8D9xPUegVt7HgIY=;
        b=jh9F+6FIntRZHhwW6ZoQGiAHeJCL9mbWQ/RXNq0JMfzUphPd70nogH4bWwbKKFijAK
         nTtaAlzKQv2llL4CpCZnk/gcuUnXqN+eGyJBdhUT0yg1N7PTwkYtdMWfsJVzxhhl90dj
         Xn7xzk/owNpHuhwxaL54kpDoQlUEkrmNAKRouKmf0KmZq+7cO+RiRWr7yxrfEUIkL16R
         9Hi06EPBUjsDxHDqYtHSseFRjgqFxrj5+kvTWqFt2EH/vUf6h39n/NOzfX51KXLOyKn2
         baR3magbGlEcvAbZGk3Kb5Zrc1nkJpaJSu6cE7pVXEDPdX4yHvAYyGqhmYmDENBvtEvM
         taeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/LeTUjB5qfIk6EUKmpDYuf2DYuV8D9xPUegVt7HgIY=;
        b=bBKN0oDntyzhFAelDN4TV6nrPwspuLVkLm9Y1X8yTMVGWB1d7HToTxFOarKg0s5Sol
         n8RpOm1dkBqqft3hi49sOkmrkYkodR8rUKgAUBTM9zrpGdgordJCb3Sesh5qOyFatzsG
         T0BhlWwCf8Vy2QCBFGjpIAQ0/7bOBlJjIaimYLwPA2ImdJSZMQhfFt8rCYXSk9bTssY/
         7nYeMjlgT2Pul/MHE+O+sZoUIbUitfD1oEQ4pVqIHBpGtuYMLmQctNVHILbjoXi2QbYY
         itFuC/WzwaE55h37VT6iASSbu8eoMcsUqRaTmcVlGj8J9jYA+QOcZPEn560vLbE81Ijy
         wdFg==
X-Gm-Message-State: AOUpUlEWK+lIlqBlYYNI6JByBMkTt/qCMdtG+F3HeOcc3KrYVoP8+cKN
        +NBprMXnyXo08cVDI1WjeGwv8ucs
X-Google-Smtp-Source: AAOMgpfiRmfiKBK8SJlJ5jie3t87MMRmfQU7xxGPozcnwvDekAWCxmadC61bpPeMBv0yAFy98JM9Yw==
X-Received: by 2002:a63:5350:: with SMTP id t16-v6mr7048057pgl.196.1532716558267;
        Fri, 27 Jul 2018 11:35:58 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id n9-v6sm8974770pfg.21.2018.07.27.11.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:35:57 -0700 (PDT)
Date:   Fri, 27 Jul 2018 11:35:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Henk.Vergonet@gmail.com, usbb2k-api-dev@nongnu.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: misc: yealink: Replace GFP_ATOMIC with GFP_KERNEL
 in usb_probe()
Message-ID: <20180727183555.GE72640@dtor-ws>
References: <20180727022007.883-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727022007.883-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:20:07AM +0800, Jia-Ju Bai wrote:
> usb_probe() is never called in atomic context.
> It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/yealink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
> index f0c9bf87b4e3..1365cd94ed9b 100644
> --- a/drivers/input/misc/yealink.c
> +++ b/drivers/input/misc/yealink.c
> @@ -894,12 +894,12 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  
>  	/* allocate usb buffers */
>  	yld->irq_data = usb_alloc_coherent(udev, USB_PKT_LEN,
> -					   GFP_ATOMIC, &yld->irq_dma);
> +					   GFP_KERNEL, &yld->irq_dma);
>  	if (yld->irq_data == NULL)
>  		return usb_cleanup(yld, -ENOMEM);
>  
>  	yld->ctl_data = usb_alloc_coherent(udev, USB_PKT_LEN,
> -					   GFP_ATOMIC, &yld->ctl_dma);
> +					   GFP_KERNEL, &yld->ctl_dma);
>  	if (!yld->ctl_data)
>  		return usb_cleanup(yld, -ENOMEM);
>  
> -- 
> 2.17.0
> 

-- 
Dmitry
