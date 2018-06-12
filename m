Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0645DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00DC208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="pP46h51S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00DC208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeFLKLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:11:17 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34476 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeFLKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:11:14 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so35117985lfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UI+XqWZ4n8sigZuaALnjT5i0YxPNoao9KFDIICJlphQ=;
        b=pP46h51SzH0+5n69C36EFd26Ohp8iEi92pnPIFN9yUnfB4FU57riBeL6e9yR8pMsUZ
         59GFm+sTqKvuFvHDMtI7J0oB8pqjst5i1TlD0l4WmP4IpiIIWhpsm4TP01vv5dtANXgO
         2W6oZqzV6EfLA/lnll9JxATCi9KfHbdd9wL3k0gJ2Ihrf3ivROfBzqniBliYPN8BxXsU
         QEvw+KRk0bOGQ5YFrwnrL3b5Ij74sBe70P0/rcm2u4272m4x9tYz2RYWrsWFfsKDsSwu
         UK04uDixWVsQQFUIlO3FeZpik9xNuvjk836jnqek0lvb1lGupymjCbehDI/mPNw/3Qts
         rZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UI+XqWZ4n8sigZuaALnjT5i0YxPNoao9KFDIICJlphQ=;
        b=n70dZgVa/U+V/wrPqfuD+ggFnFrq+wYOwrQAI/H1NqDmSq14zoJHUwUYhZC3ka+yw7
         b0Qc9vMhej7+ypOJO0Eel6eN/Yv1ZUePE9EbSQbYUpelqdV/Jdq14OW9yxrvAx5eLRMZ
         NxiOI/hOl21oKK+TOyKQlIh0TEYj/YhSeeNY624OREk5pWkYRcFMrW2jo3ic+l7lhGtq
         bMH3RyTDs2A1lMCYbUTLds981pr6iY2iE95sICAXX/qO9W+nCfrGMtMtma87H1777Z1A
         wR3o18wB2hoFpf62Zo19T5jo6ZWkPjrTkhn2b+KOaNkc6UPDOjacBdAY1rvTI2t/FNTO
         6lLQ==
X-Gm-Message-State: APt69E0PVO3L+WWybb1L5h3VcUumnauIOTXeM/3qW3H4UpeANlaV+oOM
        esWqjN+F3xf2aA+Zqfb1pLMZbJvU6yQ=
X-Google-Smtp-Source: ADUXVKKbhmInUoxEDvAkkD1lencqhfpjmxINFuNeLmPKi6ZYaaqCqQVt2jbviz2UMrnNl/Os1f/q9g==
X-Received: by 2002:a2e:4811:: with SMTP id v17-v6mr1868261lja.39.1528798272678;
        Tue, 12 Jun 2018 03:11:12 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.81.249])
        by smtp.gmail.com with ESMTPSA id 66-v6sm136321ljz.28.2018.06.12.03.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:11:11 -0700 (PDT)
Subject: Re: [PATCH] isdn/i4l: add error handling for try_module_get
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        Kees Cook <keescook@chromium.org>,
        Annie Cherkaev <annie.cherk@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiten Thakkar <jitenmt@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1528778635-41763-1-git-send-email-jiazhouyang09@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5a6a774c-156e-3e13-eda8-ed6c81722888@cogentembedded.com>
Date:   Tue, 12 Jun 2018 13:11:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528778635-41763-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/2018 7:43 AM, Zhouyang Jia wrote:

> When try_module_get fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling try_module_get.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>   drivers/isdn/i4l/isdn_common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
> index 7c6f3f5..7e52851 100644
> --- a/drivers/isdn/i4l/isdn_common.c
> +++ b/drivers/isdn/i4l/isdn_common.c
> @@ -71,7 +71,8 @@ static int isdn_add_channels(isdn_driver_t *d, int drvidx, int n, int adding);
>   static inline void
>   isdn_lock_driver(isdn_driver_t *drv)
>   {
> -	try_module_get(drv->interface->owner);
> +	if (!try_module_get(drv->interface->owner))
> +		printk(KERN_WARNING "isdn_lock_driver: cannot get module\n");

    Do you call this error handling code? :-)
    And BTW we have pr_warn() for that.

>   	drv->locks++;
>   }
>   

MBR, Sergei
