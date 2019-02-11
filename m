Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D87AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497A421773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IIfOezWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfBKVgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:36:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36065 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfBKVgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:36:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so177769pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fs2joAK0y9U2nanZE4aHcmKCwBJbNzSo5xDzf8iGRPA=;
        b=IIfOezWwDfoeAkMnrRLkeYuImGEuQZVAUeNQQFXWiUNc3WY2ThdrBtbzd3EdUb4e0+
         WuoZ4G5jtrVaYis0Vu9s6DMm74jvr0/RO6+c57BQci7NC50+wjgLFUIWDWJk2n2ZiRay
         Xuix5PpMmW4psZuxjnK61SRhT/CxjhMS+loV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fs2joAK0y9U2nanZE4aHcmKCwBJbNzSo5xDzf8iGRPA=;
        b=e0xXGINZGmm6R7N5ESzIo003T+rKYhtjLWBp7uYoRFZ4Eii2cZaq8DTeSXE9GqYvPy
         QC1lZiI2Zylq1CjOaM3dmZtminPcx7B1C/YTvcMVQQjryP5TIYHD6ThJeFTJm0nD01WD
         hdl9Q6r8hzWHeE8kUoeuBduRt0TMyhLhxL70you0VVEi28JGaFbkh0MJ32EPJwdqY971
         JkdwaRtu2J2ElMXfMC/ADSUfEIMhFOoJLU9lVYxeq1MXZW87LJMzElqiJY0sFbn/4Vex
         n06OVDAZS9B+CCIapkzrFivGsiNJY9ySMf7PX5Bohe6eEwExjy15mkU8rRdtbFyGJwq/
         tDpg==
X-Gm-Message-State: AHQUAuYj73jIdsdGxhNYueRdSTLwDtwwYKV7bQB0PM2Ye9s9VnwOi2HB
        U5mCOE9z1IH0sim7ZeVf9rnj9Q==
X-Google-Smtp-Source: AHgI3IYqxYuKhyBWekN86Lpf6bhz+Diu1O3SF9XdCYiLdh5STGcmStO9cMhRa3yNPDwPbWR04DDD+w==
X-Received: by 2002:a62:5003:: with SMTP id e3mr354492pfb.23.1549920963992;
        Mon, 11 Feb 2019 13:36:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 23sm4979515pfn.134.2019.02.11.13.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 13:36:03 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:36:02 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
Subject: Re: [PATCH v2 2/2] drivers: devfreq: change deferred work into
 delayed
Message-ID: <20190211213602.GQ117604@google.com>
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063@eucas1p2.samsung.com>
 <1549899005-7760-3-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549899005-7760-3-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Mon, Feb 11, 2019 at 04:30:05PM +0100, Lukasz Luba wrote:
> This patch changes deferred work to delayed work, which is now not missed
> when timer is put on CPU that entered idle state.
> The devfreq framework governor was not called, thus changing the device's
> frequency did not happen.
> Benchmarks for stressing Dynamic Memory Controller show x2 (in edge cases
> even x5) performance boost with this patch when 'simpleondemand_governor'
> is responsible for monitoring the device load and frequency changes.
> 
> With this patch, the delayed work is done no mater CPUs' idle.
> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
> intervals should benefit from it.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 882e717..c200b3c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -400,7 +400,7 @@ static void devfreq_monitor(struct work_struct *work)
>   */
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {
> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>  	if (devfreq->profile->polling_ms)
>  		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));

I'd suggest to swap the order of the patches in this series.

Why, you may ask, if the end product is the same? This patch ([2/2])
fixes an actual problem, while IIUC [1/2] is just an improvement, the
fix doesn't really depend on it. If -stable wants to integrate the
fix, they also need to pick the improvement (or resolve a conflict),
which might not be desired.

Otherwise this looks sane to me:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
