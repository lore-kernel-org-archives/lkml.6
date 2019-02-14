Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE48621B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gXYsCMMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438265AbfBNTHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:07:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36686 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBNTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:07:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so3643205plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RN08I6AKaVchZKykU9iAboTLsRwihOJdMxf//APS2CI=;
        b=gXYsCMMjeYfJAfCG7smMdj7Sewkb7Dq6P58Z/EMK3VD42X9pSPGrW3+/iGHS5pSG/O
         OZn0RwKIBZ1EBYDMatXmJzdEo/s8RhAAk+Zvgh4OzjGPYrZEv9ZxmmQQi6TOJe8W4W2Y
         WsQg8+bOG2J8z/1gYfQYtR3WE6oRJnvy7DONY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RN08I6AKaVchZKykU9iAboTLsRwihOJdMxf//APS2CI=;
        b=gcDLEfSzYX2yUiW/lyzV6vJIxYiWRvS2d7Cbtt73I1C+UbPE5Lsnaz+ftzMxc6pbCG
         nTIDFnimLcB9Y6P5DZAx7MS6jltq7w8zv918bM1jZ2A1GQ5mlM87K+jrbPEl2+4AW32A
         znyvNlKGLwu09EMS7Bd7myvBYOsqanulateNzdmEJrLunToUpnXhxgO19bkK/JqgM4Jr
         z2BkzadFSwDocJNTZlQ3pdyoM8J1xDuZA0mKrXA3Qxs2pe0475xaatayUMWH+OPGvqfp
         hnFFQqsCXW6+RgbSHFYWIUS00wFWItlJBDKU0Lzq3WocLYf+29AbkHYEYqu8eTPN34fz
         eEfw==
X-Gm-Message-State: AHQUAuZ/ecmiT4Rlvk/E/43WGW0GD7FQKg4BXsnPg7QuvkBH7s1UssY9
        iKfcPB86mPV+YR0tjDuIiMB3rQ==
X-Google-Smtp-Source: AHgI3IaQzfLXbYu0Waup8Ds4dBVoe65ojNDT6FiUOy1ZWELWQ2OJ8NmnTnF40MCgZNpE1SE7BTsn+w==
X-Received: by 2002:a17:902:5601:: with SMTP id h1mr5959711pli.160.1550171262651;
        Thu, 14 Feb 2019 11:07:42 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 184sm6182445pfe.106.2019.02.14.11.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 11:07:41 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:07:41 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
Message-ID: <20190214190741.GC117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <CGME20190214013154epcas1p31326fdc127b3a75d566426e4f785121b@epcas1p3.samsung.com>
 <20190214013042.254790-5-mka@chromium.org>
 <1771fe9e-c107-f133-7b39-f4d7dbb004c5@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1771fe9e-c107-f133-7b39-f4d7dbb004c5@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Thu, Feb 14, 2019 at 07:01:36PM +0100, Lukasz Luba wrote:
> Hi Matthias,
> 
> I have compiled and run your changes on Odroid xu3 and v5.0-rc6.
> There are kernel warnings because of mutex not held in function
> devfreq_monitor_[start|stop]() in use cases:
>   1) a few times during registration of new devices devfreq_add_device()
>   2) poking the device from sysfs

Thanks testing!

I messed up carrying over changes from my v4.19 device kernel
to the tree used for upstreaming :(

Do you still see warnings with the below patch?

Thanks

Matthias

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a42c37543c190..866fe711b43ca 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -440,7 +440,6 @@ static void devfreq_monitor_stop(struct devfreq *devfreq)

        mutex_lock(&devfreq->lock);
        devfreq->monitor_state = DEVFREQ_MONITOR_STOPPED;
-       mutex_unlock(&devfreq->lock);
 }

 /**
@@ -596,7 +595,9 @@ static int governor_start(struct devfreq *devfreq)
                return err;
        }

+       mutex_lock(&devfreq->lock);
        devfreq_monitor_start(devfreq);
+       mutex_unlock(&devfreq->lock);

        return 0;
 }
@@ -614,7 +615,9 @@ static int governor_stop(struct devfreq *devfreq)
                 "mutex must *not* be held by the caller\n"))
                return -EINVAL;

+       mutex_lock(&devfreq->lock);
        devfreq_monitor_stop(devfreq);
+       mutex_unlock(&devfreq->lock);

        err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_STOP, NULL);
        if (err) {
