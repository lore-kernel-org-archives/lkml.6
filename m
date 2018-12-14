Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED87C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF82070D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7PvawGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeLNSMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:12:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38093 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbeLNSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:12:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so3042426pgc.5;
        Fri, 14 Dec 2018 10:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0NfSkUDkaIz6kox8lZ3YDeNMI8rr7GHOns/3m1Txag=;
        b=a7PvawGHKf0EpJThdVa2mKvInfIfWcQNp1McWSW7SusuyT2WIP2G/68NSPyw0ki1K7
         GPpNGmIlylZ/1jVqGy5LjWnXa+kWzTYzBmXDiE+Y3z+ONBjp/IOtkCx8JmH8ocMf8nA6
         Lw1vfx+71pxhgnmdrpt1MOXIzvSpnr/Ki4hKyTpRaJYIDWwcXgT+RGtOsnP81j1uE2yv
         U+eKweJHNWw+9CfNd+7CDPfk9iGDHgLXutdh6ov1hM+DEiYfrMS7JBXmbcnUUkVppnP7
         1MvN8ov9oxJpkgg8iIfq4kex8PMgqRQRVyu9p5DZYahWxLcUSrthzBqarHeFfy3miyF3
         opNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0NfSkUDkaIz6kox8lZ3YDeNMI8rr7GHOns/3m1Txag=;
        b=ecpyFPVVNjYTmXB/iVzVuDe8XapXYYpV30GBWAwL+lvPOvUn+9/70XeP3yD8yasYrL
         ZQsaUQe7hUoFWZYl6SBucunvdXyXmBmGpL7QDrXMwclcLAXAIQ+VttNTdGofzQX+4RMG
         8PxFpp5e1SFYHNkGDQICWI1oX4sqpUNxXnRmd9uok6jiONHQJzutBoJEzvDGNt95crGX
         ifx07kvdK5R6tVO6ShsjeOtahIj1ui+HQPy+2qTkQS2adyXbZuNym1xolmoKDlJXVVQu
         ilrsWm4L0ikLVc4M34ZwCIIFmLEj9hOm4xuOHiDZi5OotbNwDpRMr4tqZItMkJd+8+i9
         i4TA==
X-Gm-Message-State: AA+aEWaZUIQtwdVeZiHV3nvRcgjEH9r6+0KK2jLOK03N4cIRxLjhIiI5
        Top6WxNjoOQfEjkZD512S9Y=
X-Google-Smtp-Source: AFSGD/Vh8b+Xbw+IfvUrSI4kFxUjlzleCIW5dq/wkmpujigOUKjIDMOywRIrEx32+Ntp03otlCAsvQ==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr3713668pfg.235.1544811170650;
        Fri, 14 Dec 2018 10:12:50 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id v191sm10976336pgb.77.2018.12.14.10.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 10:12:50 -0800 (PST)
Date:   Fri, 14 Dec 2018 23:42:43 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     joe@perches.com, gregkh@linuxfoundation.org, apw@canonical.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        niklas.cassel@linaro.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: fix Co-Developed-by docs
Message-ID: <20181214181240.GA20094@himanshu-Vostro-3559>
References: <1544808928-20002-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544808928-20002-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544808928-20002-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 06:35:27PM +0100, Jorge Ramirez-Ortiz wrote:
> The accepted terminology will be Co-developed-by therefore losing the
> capital letter from now on.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Thanks. ACK!

Finally, the discussion converged at somepoint.

FYI, Cc Jonathan Cameron + IIO list.

>  Documentation/process/submitting-patches.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index c091710..30dc00a 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -510,7 +510,7 @@ tracking your trees, and to people trying to troubleshoot bugs in your
>  tree.
>  
>  
> -12) When to use Acked-by:, Cc:, and Co-Developed-by:
> +12) When to use Acked-by:, Cc:, and Co-developed-by:
>  -------------------------------------------------------
>  
>  The Signed-off-by: tag indicates that the signer was involved in the
> @@ -543,7 +543,7 @@ person it names - but it should indicate that this person was copied on the
>  patch.  This tag documents that potentially interested parties
>  have been included in the discussion.
>  
> -A Co-Developed-by: states that the patch was also created by another developer
> +A Co-developed-by: states that the patch was also created by another developer
>  along with the original author.  This is useful at times when multiple people
>  work on a single patch.  Note, this person also needs to have a Signed-off-by:
>  line in the patch as well.
> -- 
> 2.7.4
> 

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
