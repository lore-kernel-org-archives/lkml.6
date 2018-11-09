Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09CEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9FF2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGFB+4mB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9FF2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeKIVEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbeKIVEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:04:46 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E46F2081C;
        Fri,  9 Nov 2018 11:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541762675;
        bh=6uJ31AiR7ElrihkWNfJCQJxP7hpu3OD6aCLHGXRe0zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGFB+4mBDgHp2FSbromo+LB/ZLz1zbiA/DzIEvK52Ien/pTDTn00ZhelArw4vtFXl
         xfLTmSIRWsFQS+BfT5rm4JS5x/C9ekyeB5N5ZksQUo4XWD85SeOCO3S9IBPChjtNQd
         MzHiGXUxaQEyRdhrAo6xMzUTMv4ilUlswmOZRmX8=
Date:   Fri, 9 Nov 2018 03:24:34 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, devel@driverdev.osuosl.org,
        sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/android/binder.c: Remove duplicate header
Message-ID: <20181109112434.GA29324@kroah.com>
References: <20181109041425.GA2950@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109041425.GA2950@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:44:25AM +0530, Brajeswar Ghosh wrote:
> Remove binder_trace.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  drivers/android/binder.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cb30a524d16d..719f35a5c04b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5852,6 +5852,5 @@ static int __init binder_init(void)
>  device_initcall(binder_init);
>  
>  #define CREATE_TRACE_POINTS
> -#include "binder_trace.h"
>  
>  MODULE_LICENSE("GPL v2");

Are you sure about this?  Did you test the tracepoint functionality
after removing that line?  I think you just broke it :(

thanks,

greg k-h
