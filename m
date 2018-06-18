Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EBDC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91928208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sagWuCYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91928208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbeFRPSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:18:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44984 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbeFRPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:18:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id p23-v6so13556505lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z+LEQQ8JBL0DS0DQ7G0AfJwPosJOoq+uRJ+HTKeifj0=;
        b=sagWuCYjv3/1ebtUO4BGpMGzUdDC5iSpflYX2GvF89nuPBlEzEYB698Ovr7lc9zE5H
         +fMxqb07Z7TDBf00Wc7gZSzy1a/ukQ/f8fPHVMa4zw7/XgsO+vjyxnmWsz65uhCQN6Mv
         EhZrsCw4BSTuyvPSeNAoHpRtFL1vUmR9tZ8NuSuvmr6XTw1+Ngjc6JflSrDvl81JtyJO
         2fIaa5oLm9Drskok+pDyZILAD1zwXck+eoaPkFNwlKP+zWw9ajGbcDVAqcf7jq2M0LWA
         GunCCSL9/WV6Mrp0/KsuPJhdFoye/6spdsSZgr1TKoPJEJ8YusVXx9nQ7BijDeeXlNIQ
         eO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z+LEQQ8JBL0DS0DQ7G0AfJwPosJOoq+uRJ+HTKeifj0=;
        b=DBq+JQnVVJNm3DOxCjE24xUAZ07ySJ/741R2XDVKcdXt6fITnwa7sS/pyNNIwUcEnK
         HHTNgQisPGnc3RVnrUVyiSxt4TEaX2qyBMSz0WAPgZ4wL8qODDNL1BGy3sEY5oy8kG/Q
         RCYauyAD3Az2jd1M8wVufYhEITWXqzk6edoQwNzvZzh5mSGSaDoBa+FkmVTD7CclI8Ax
         +DhaeoUK5yP7NxoyyTwcQiuC8E7Mq6/W/gurKT6egFMVrz80LmKuXDft9AnAMjSVK55X
         jDcfllt64x6cOU5qHN3oAw7Wi1q0iE68O/uUH7GaloFroZ75tU0C8x3iEUU0rYgFIzPD
         /rwg==
X-Gm-Message-State: APt69E2ds1wU/WBHVA0JyXUh1W+WJTieRRB9JXjyHLIzslal+cSs9Vnp
        6fZt8JVz7VOoJxxbEtSzNPw=
X-Google-Smtp-Source: ADUXVKK3e6brRPMgcsMxHDb5gfbhgR91EbtBP2EuYLM8Bqov2wpqgRKKAaZf63PBLUJEI0dOUbGsXw==
X-Received: by 2002:a2e:1710:: with SMTP id l16-v6mr8994684lje.74.1529335087274;
        Mon, 18 Jun 2018 08:18:07 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id t6-v6sm2731516lje.18.2018.06.18.08.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 08:18:06 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id E38E2460859; Mon, 18 Jun 2018 18:18:05 +0300 (MSK)
Date:   Mon, 18 Jun 2018 18:18:05 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, y2038@lists.linaro.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysinfo: remove get_monotonic_boottime()
Message-ID: <20180618151805.GC1998@uranus.lan>
References: <20180618150114.849216-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618150114.849216-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 05:00:38PM +0200, Arnd Bergmann wrote:
> get_monotonic_boottime() is deprecated because it uses the
> old 'timespec' structure. This replaces one of the last callers
> with a call to ktime_get_boottime.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/sys.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index ccaeffa2171b..24f838da8ca1 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2574,11 +2574,11 @@ static int do_sysinfo(struct sysinfo *info)
>  {
>  	unsigned long mem_total, sav_total;
>  	unsigned int mem_unit, bitcount;
> -	struct timespec tp;
> +	struct timespec64 tp;
>  
>  	memset(info, 0, sizeof(struct sysinfo));
>  
> -	get_monotonic_boottime(&tp);
> +	ktime_get_boottime_ts64(&tp);
>  	info->uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
>  
>  	get_avenrun(info->loads, 0, SI_LOAD_SHIFT - FSHIFT);

The change is pretty obvious. Looks ok to me (though I missed
the moment when timespec became old ;)

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
