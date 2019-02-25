Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13786C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC41D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVFYCP50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfBYE3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:29:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41814 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfBYE3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 23:29:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so3853716plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 20:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KWbWGTi5tHb6cmq9IznZT7SeUjiAOg830SMnYdOj7uc=;
        b=bVFYCP50PkWgrR9VqclOQcFW/NABe8gsTw4DDrIMC/2ypUVfc5MKvrjopu73q0wMzC
         Fx4CLHiZLXXGhZxqUQv2rsb8x/aPRcMMpqGijxtBbNav/qB+VaYFM5Po6TYBpQeF6v3Z
         3AN7sRUU9LZKgUTafRTzgSrvJ5MvdEQQb0DcFqw+UHhyHzoKmD5YcrJMlEwtPdUnrzar
         /AtzVUzD/XK0chdW63yePg5zZLDSXfL1mussXNGFC8BIZyrrvo8060/LVbSbgF+mGHZj
         1kLnokK1nIcZU9qFZgJZAqWUd+mZ5uQY9t4bsAg98nP3XkYB+UPq6fy6z4NGO4YVeN1L
         zUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KWbWGTi5tHb6cmq9IznZT7SeUjiAOg830SMnYdOj7uc=;
        b=qAdF0pVwIRt3BA3AgmfGMuoNnho2uIwMs3sjC3Zrtv7IBuul+D+LmmIiC29TOWY4dm
         ozgD+R9gIGFnBNRJlAw0X96RRZaQjyTv/9SR4iChnbn7on8aBnDkFNuUOvVLenN982P3
         8iKUsnrr/QI94x68IzpXrf+8AWaZm2emE+voLkD2OzBEQtAMGyW7B97wEyK6dTL/oLq9
         2WmXAu48QXrg1CRtLeAYn/M+8/A3pBWDT2rTt/Ygf6EEDBrIuVHX8YDur5rEGY6H0Zsw
         PA1kc84ud14SGqVK7zZJR1Bn4SakLQFJgJb6/8GcKpL6lP3S2yJKaA66f+4P9LEMoOcP
         fbuQ==
X-Gm-Message-State: AHQUAuZjPsoBKmcu+ko/KjCox8JXMW1pj6tjAVlqoX9x7t/ZLnXAL176
        gImgkGCdhbDcTaqXeSm/ahTNoA==
X-Google-Smtp-Source: AHgI3IZxMTma/p6weHVt3VXm6ibtrP/psN+Q2ngbJ9K+reISoNwz49+RLntDnxj/8fsz+RYEksVBBA==
X-Received: by 2002:a17:902:64:: with SMTP id 91mr18745132pla.229.1551068986348;
        Sun, 24 Feb 2019 20:29:46 -0800 (PST)
Received: from localhost ([122.167.168.92])
        by smtp.gmail.com with ESMTPSA id h79sm18526929pfj.186.2019.02.24.20.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 20:29:44 -0800 (PST)
Date:   Mon, 25 Feb 2019 09:59:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        kernel-janitors@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] cpufreq: ap806: add missing of_node_put after
 of_device_is_available
Message-ID: <20190225042941.wypmh4kikcgmebn3@vireshk-i7>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-11-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550928043-14889-11-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-19, 14:20, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
> 
> e = f(...);
> ... when != of_node_put(e)
>     when != x = e
>     when != e = x
>     when any
> if (<+...of_device_is_available(e)...+>) {
>   ... when != of_node_put(e)
> (
>   return e;
> |
> + of_node_put(e);
>   return ...;
> )
> }
> // </smpl>
> 
> Fixes: f525a670533d9 ("cpufreq: ap806: add cpufreq driver for Armada 8K")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff -u -p a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
> --- a/drivers/cpufreq/armada-8k-cpufreq.c
> +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> @@ -128,8 +128,10 @@ static int __init armada_8k_cpufreq_init
>  	struct cpumask cpus;
>  
>  	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
> -	if (!node || !of_device_is_available(node))
> +	if (!node || !of_device_is_available(node)) {
> +		of_node_put(node);
>  		return -ENODEV;
> +	}
>  
>  	nb_cpus = num_possible_cpus();
>  	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);

Applied. Thanks.

-- 
viresh
