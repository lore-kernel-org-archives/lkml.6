Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13894C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAB821748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="bZShwEG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAB821748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeI1PXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:23:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42139 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeI1PXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:23:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id d7-v6so4382155lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hFnoZpquxzJVJoZ8aOionME8wOWzJWLdEfe0i9eoTsI=;
        b=bZShwEG/ggnyM/zBOGef9vULh1owTQ/mW6ykt3xk5VaWM1s1il3rPY7FSrULvs2fCy
         S03urpHwvflvIe9faZWxNTjDvtLgzwiNru0z0RYZ8aX2DulapXBNgK5QGZ9BY8OZ7J3c
         /72JfshK10tthYh2Kqxyoelmezl2TU/77IC4Qqpn8g5g30sXdE0Psi6wUJ1MA38znhaE
         vzAYgO5Ys5mSaKwXGjceCBSVF3MMynGLN+fUeNgjpEs5CLBc/V9hu2KvE4hHAor+fnEi
         xXyPQJotePxahOK1XU0VDiKVX2f23sPjoPsj25r0hLa2vZJTiYZ30kq9kqScvhh2+sz+
         +UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hFnoZpquxzJVJoZ8aOionME8wOWzJWLdEfe0i9eoTsI=;
        b=jX6do4A2XeotzeBqNhDhTF4XV6TdDVDkRMZl7cU75w4YPqiU5NDynLOTpC/UHPvk/B
         WFGVSuYshqBlhzvWSFUMOd7cVI4xHVwKrIo/5wN0TM9EpUWv10rc5yL2UrTIK1g/MffM
         Z1YQIVvQ9nScaIaoGAS9HYkOZqAxxrrNc1yKRmEEaNfdBVKLvdpogjRMgNXQOfjnfq6x
         JeAJU7f03KGtnw5TN94x1FDRCK/GDCSsRBSatUPrmbkfzkroXpODh5NpO/uIlqdIg5tY
         sdvJ6Oi0QKCEaGoLR3HwAOBDqW21/6MSIkgPxQM8FD0GLbkXviub233fbHgArBRHE6Mv
         YE4w==
X-Gm-Message-State: ABuFfog4Xz5JnGpirk3vmr4HfLjP8L7dCP1gn1mvel1SIJjyyq89QVd+
        YU1J1x+p1FZEdlpQRCa44RPp3g==
X-Google-Smtp-Source: ACcGV6078kaP3TLCmqifQK0dQLaf8RuzCWDcqHaHgNWWIuytjlXtyKl10paQ6r5gJoJIl+3Fv96Wiw==
X-Received: by 2002:a19:910c:: with SMTP id t12-v6mr7639811lfd.98.1538125254779;
        Fri, 28 Sep 2018 02:00:54 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id r83-v6sm929482lfi.60.2018.09.28.02.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 02:00:53 -0700 (PDT)
Date:   Fri, 28 Sep 2018 11:00:53 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: rcar_thermal: Prevent doing work after
 unbind
Message-ID: <20180928090053.GC24305@bigcity.dyn.berto.se>
References: <20180927113235.30354-1-geert+renesas@glider.be>
 <20180927113235.30354-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927113235.30354-3-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2018-09-27 13:32:34 +0200, Geert Uytterhoeven wrote:
> When testing bind/unbind on r8a7791/koelsch:
> 
>     WARNING: CPU: 1 PID: 697 at lib/debugobjects.c:329 debug_print_object+0x8c/0xb4
>     ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x10
> 
> This happens if the workqueue runs after the device has been unbound.
> Fix this by cancelling any queued work during remove.
> 
> Fixes: e0a5172e9eec7f0d ("thermal: rcar: add interrupt support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index ea132e122b174757..616ba2fccf410d3b 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -453,6 +453,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  
>  	rcar_thermal_for_each_priv(priv, common) {
>  		rcar_thermal_irq_disable(priv);
> +		cancel_delayed_work_sync(&priv->work);
>  		if (priv->chip->use_of_thermal)
>  			thermal_remove_hwmon_sysfs(priv->zone);
>  		else
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
