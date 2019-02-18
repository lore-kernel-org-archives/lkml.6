Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84196C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF20218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmkG70WD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfBRE7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:59:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37234 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfBRE7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:59:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id q3so762882pll.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 20:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tTLyDYY9MACTqPCtHen/lI1O+0OKAyoxoVlb//Txr7E=;
        b=gmkG70WDl/KqN+NxvA0Y4eP6wemPxBOe8v4Nuiz55FKW0Dzys9op33thu+Y5C+wV0V
         ajisAaCQlWAFm/ry7C+UnKi1Ah7Su4S5frmtl3q7KZQIP/RkcmDUdq+hsZFYKey1oMf8
         q5xC/EcJl4E/2RWTu0W3tEkg2R5Uisuz/IjVraI5fFXjRMkZnfFSQdXvaPuiG3R/DsqQ
         A9kdX/queZbur2dF8JoTP8M74v3Rx5n3d4nod/h+0T2H0OKw8wXs5wUfa1wcYu+gt32X
         jDLV53UDo0v9cKiS+tp5QX+Qx/kjrXxC+fu2+qAXErIGdi7+50X6796iL8egpp3j9mDN
         /8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTLyDYY9MACTqPCtHen/lI1O+0OKAyoxoVlb//Txr7E=;
        b=Wndokn9Pmwwm7UIgkTRbPjO+cW/Y2xyJ2EZl5Q8ddU9JnVjDZLiZtLpNJVquxnzZI9
         gmJFVbd4jJPfGnH4UMcI9QgZIwSCrcdAnGF5fXGxE0jdxGalNe/297j/s+hHuIjZEqUZ
         moHiNPb4TkSGi0aB/i1uUtgIzsQa83KxetyCA0ya+65hA+ik4E249xrb2m9LUHPVzYDo
         Xl0pNNqs0XfH9Y/6MPlZmq7eMvriobB9595gToGGAPF6hPLOFIEwVjpkPtsn/EqrtR1y
         k/yIgi2JLY1cw87+Wl42qyc59laTPoIP4VIoxs7HU9w9Y+7/xPH6Ax0po40EzWZ0JjYH
         AvnQ==
X-Gm-Message-State: AHQUAuYr95uht/72z4yFXDP08maRin6FXfF58xRqw1OCn/EfmncmQnBd
        d46QKSiLP7fUHmeLnmXV5KPM7w==
X-Google-Smtp-Source: AHgI3IaNnxY2xRpGFhKyE4a8/hCHSLvx+Fd0BIKZj8nmuyBe4fjfmsc5vVAfwE4olv3tOXHMHoRRjw==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr23563478plb.104.1550465977487;
        Sun, 17 Feb 2019 20:59:37 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id i74sm23402151pfi.33.2019.02.17.20.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 20:59:36 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:29:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernv: fix missing check of return value in
 init_powernv_pstates()
Message-ID: <20190218045934.5txhn3tumhm3wncn@vireshk-i7>
References: <20190216170623.12634-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216170623.12634-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-19, 12:06, Yangtao Li wrote:
> kmalloc() could fail, so insert a check of its return value. And
> if it fails, returns -ENOMEM.
> 
> And remove (struct pstate_idx_revmap_data *) to fix coccinelle WARNING
> by the way.
> 
> WARNING: casting value returned by memory allocation function to (struct
> pstate_idx_revmap_data *) is useless.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 7e7ad3879c4e..d2230812fa4b 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -244,6 +244,7 @@ static int init_powernv_pstates(void)
>  	u32 len_ids, len_freqs;
>  	u32 pstate_min, pstate_max, pstate_nominal;
>  	u32 pstate_turbo, pstate_ultra_turbo;
> +	int rc = -ENODEV;
>  
>  	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
>  	if (!power_mgt) {
> @@ -327,8 +328,11 @@ static int init_powernv_pstates(void)
>  		powernv_freqs[i].frequency = freq * 1000; /* kHz */
>  		powernv_freqs[i].driver_data = id & 0xFF;
>  
> -		revmap_data = (struct pstate_idx_revmap_data *)
> -			      kmalloc(sizeof(*revmap_data), GFP_KERNEL);
> +		revmap_data = kmalloc(sizeof(*revmap_data), GFP_KERNEL);
> +		if (!revmap_data) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
>  
>  		revmap_data->pstate_id = id & 0xFF;
>  		revmap_data->cpufreq_table_idx = i;
> @@ -357,7 +361,7 @@ static int init_powernv_pstates(void)
>  	return 0;
>  out:
>  	of_node_put(power_mgt);
> -	return -ENODEV;
> +	return rc;
>  }
>  
>  /* Returns the CPU frequency corresponding to the pstate_id. */

Applied. Thanks.

-- 
viresh
