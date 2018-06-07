Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RBENItzdGFtXcwAAmS7hNA
	; Thu, 07 Jun 2018 07:29:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 785756089E; Thu,  7 Jun 2018 07:29:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr+CT7kB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EC404605A2;
	Thu,  7 Jun 2018 07:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC404605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeFGH3w (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:29:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38804 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeFGH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:29:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id i83-v6so13062285lfh.5;
        Thu, 07 Jun 2018 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MMJkkfbHFVMO4mux7I6fdTYCyAMSRLXOxE+JF5t6sJ0=;
        b=Lr+CT7kBsOx1ZfdDATx2wkPbNLzv950gEtdsjk39vuwQMJZpBHlABgx/pWyg7NCapl
         PaIIe+fHLL+5ZtgaL352uTpdAlxIds4D9XwQupf1Hy+Ue7N5LlSDQdlZAi4+59gOxzfD
         y4dQQqE+S37v44i5su/XXz5wKNg1YwlQUp3w2IUjMS49ugPve9lCotndj6ID+98h75at
         q70KJmfFfuQsfpj883bOtzis8kblzX6FDiyrNLfeZWfqSHYkPIHXQaHng4c874WIDnbl
         rwJuHEooxodOLxcNBiwZ5Z9CLDr8TZXph/d6gj/DyQMFWVjkkKsDMPWwq0nljdOOF/Ve
         XfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MMJkkfbHFVMO4mux7I6fdTYCyAMSRLXOxE+JF5t6sJ0=;
        b=DgD1s3PiI1QegHJKcvp7aFwCeFactxTJAPbbcZHQzParz0ridSTS61wboyhebAVtYX
         MYvDCDlfLNG1fx/tk2+LpwJrw/es7vdavIuXA6RZxOKxtwvPFEassqzjDV714+ncNRqY
         9Ot2E4vZw8XnXo9qOpJIf/ORHiLVVacPmMlr1BoldgfgjCVk2HzFZ8nPFsOlHvnnJRV6
         9rlyKApbhHZwX+JsetFtPkAYk61ZsCl5qZAT/Nx4N02qWRKTvbTZEBWG3toDzGdgWE4d
         VAKss/jKTvPezbEtpN3V4/nbjN/WaJNo/KmMG6g/J09ftWoddmXaR0dXE7T5CcgfGIkS
         lo8Q==
X-Gm-Message-State: APt69E1i+bg2VWZTI/qoBlNsf2ZgkAaSAwIheSpQBAVIlmZTKoL4U4E2
        Ew/suUVR55lnmOQU5Noc7JszAal/
X-Google-Smtp-Source: ADUXVKIcFAek74gkN/mTudhzdX9HRLYmA/cK6dAUqrndv35Cj8j2o+S7Yqz6fVRA/0zjQUdoiKndCQ==
X-Received: by 2002:a2e:120b:: with SMTP id t11-v6mr609082lje.57.1528356588087;
        Thu, 07 Jun 2018 00:29:48 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id q66-v6sm2291353lfg.17.2018.06.07.00.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 00:29:47 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fQpMS-0008Iv-NM; Thu, 07 Jun 2018 09:29:33 +0200
Date: Thu, 7 Jun 2018 09:29:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
Message-ID: <20180607072932.GO13775@localhost>
References: <20180606134338.4645-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606134338.4645-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 02:43:38PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently saved_vals is being allocated and there is no check for
> failed allocation (which is more likely than normal when using
> GFP_ATOMIC).  Fix this by checking for a failed allocation and
> propagating this error return down the the caller chain.
> 
> Detected by CoverityScan, CID#1469841 ("Dereference null return value")
> Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 9c3c00515aa0..0905ee002041 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
>  
>  	mux_bytes = pcs->width / BITS_PER_BYTE;
>  
> -	if (!pcs->saved_vals)
> +	if (!pcs->saved_vals) {
>  		pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
> +		if (!pcs->saved_vals)
> +			return -ENOMEM;
> +	}
>  
>  	switch (pcs->width) {
>  	case 64:
> @@ -1649,8 +1652,13 @@ static int pinctrl_single_suspend(struct platform_device *pdev,
>  	if (!pcs)
>  		return -EINVAL;
>  
> -	if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
> -		pcs_save_context(pcs);
> +	if (pcs->flags & PCS_CONTEXT_LOSS_OFF) {
> +		int ret;
> +
> +		ret = pcs_save_context(pcs);
> +		if (ret < 0)
> +			return ret;
> +	}

This appears to be the right fix (along the lines of what the author may
have intended by having the helper return an int), but as a follow-up
patch, why not move the allocation to probe() instead?

Also this doesn't look like something that requires atomic allocation in
the first place, GFP_KERNEL should do for the legacy suspend callback.

>  	return pinctrl_force_sleep(pcs->pctl);
>  }

But for this fix, feel free to add:

Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan
