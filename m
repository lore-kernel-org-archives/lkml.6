Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9B420844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACr8KVKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfAVKI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:08:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34885 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfAVKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:08:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so11550182pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 02:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CHCyCZIFRFB7Zm8dpT3QW6zDFjOeos65+17FkEqBjRg=;
        b=ACr8KVKu7+EriSvD7wMbBPs2x1/vUqcoGV990m9N4vuArcPlLxo1yHoFMIWCyP8wFE
         YNd9RdataVWH0hzcjPzXtDD78UKNTfdB8DcXOwgGxT59AJIWUGOle1mAihHFuAxXRMJC
         vxDCmzLF2TCjnlwHuUuXFZh3Pf/9RVFwXVVbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CHCyCZIFRFB7Zm8dpT3QW6zDFjOeos65+17FkEqBjRg=;
        b=bZci40wDhQ2DmiGVEetGE9gZ16gR9hojpWfkFgG4sxPMSpldl3qlhIe+C9hP4D/IAw
         WphDgbRgv21GLfal4aMViZN+wwwktfdkumWYh+BBGuD8OtE2/Tz433HW6ELLtnq5/J+Z
         YScpL/YWb5y5Tl5fLMPLJUKZ+ko8YUWuizOIoHysEDCETaXHMpOenLHwKYvubb8BDvEB
         EP2APfM+sG/W3o6sBstqn4pXwOH085i0RgAKa4FMQ6O8L9zbaaRauBnHMhQUV21LCsLv
         INQ41R0r99Sc0DThYHfzCVQGQql8oerEHsVxcZ3vgD9CA9L0PN4VNg9vBtlGd1jWRRZd
         2lew==
X-Gm-Message-State: AJcUukefxIcyqJHoY7i/C0Ip5G7+cB0LEQDtGwtVxbSmGzPjyErnQ3V0
        T1nEW7kD5xP7TokyWwMEEr2NKQ==
X-Google-Smtp-Source: ALg8bN68LMJeNhNbdOWW+4RPdAo8ds2hqbL6OMNZCe4uv1UiLml4ELgxkD7ut+QK/aatd2cuzv2ZWA==
X-Received: by 2002:a65:6148:: with SMTP id o8mr31408665pgv.451.1548151737236;
        Tue, 22 Jan 2019 02:08:57 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 84sm37108958pfa.115.2019.01.22.02.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 02:08:56 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:38:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
Message-ID: <20190122100854.nuepsz5ddbt4jda4@vireshk-i7>
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
 <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
 <25f46403-e78e-271b-c4d0-13b4623846b3@roeck-us.net>
 <864348fb-3d06-7b4b-cc82-17c96b7ce219@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864348fb-3d06-7b4b-cc82-17c96b7ce219@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-19, 15:24, Rajendra Nayak wrote:
> I was doing some quick testing by adding the calls to of_genpd_remove_last() as
> suggested by Ulf for cleaning up the genpd registrations, and I run into this
> backtrace when the driver re-probes followed by a remove
> 
> [   59.204525] kobject ((____ptrval____)): tried to init an initialized object, something is seriously wr.
> [   59.214262] CPU: 3 PID: 1600 Comm: sh Not tainted 5.0.0-rc1-00012-g0513915837c5-dirty #32
> [   59.222500] Hardware name: Qualcomm Technologies, Inc. SDM845 MTP (DT)
> [   59.229081] Call trace:
> [   59.231574]  dump_backtrace+0x0/0x148
> [   59.235276]  show_stack+0x14/0x20
> [   59.238631]  dump_stack+0x8c/0xac
> [   59.241980]  kobject_init+0x8c/0xa0
> [   59.245506]  device_initialize+0x34/0xc8
> [   59.249474]  pm_genpd_init+0x170/0x260
> [   59.253261]  rpmhpd_probe+0x194/0x2b0
> [   59.256966]  platform_drv_probe+0x4c/0xa8
> [   59.261011]  really_probe+0x1e4/0x2c8
> [   59.264711]  driver_probe_device+0x58/0x10
> [   59.268927]  bind_store+0xdc/0x178
> [   59.272356]  drv_attr_store+0x20/0x30
> [   59.276061]  sysfs_kf_write+0x48/0x58
> [   59.279760]  kernfs_fop_write+0xcc/0x1c8
> [   59.283728]  __vfs_write+0x34/0x170
> [   59.287245]  vfs_write+0xa8/0x1b8
> [   59.290592]  ksys_write+0x5c/0xc8
> [   59.293941]  __arm64_sys_write+0x14/0x20
> [   59.297897]  el0_svc_common+0xb4/0x118
> [   59.301676]  el0_svc_handler+0x2c/0x80
> [   59.305455]  el0_svc+0x8/0xc
> 
> Viresh/Ulf, looks like we need some cleanup of whats done by device_initialize()
> in pm_genpd_init() to happen as part of the pm_genpd_remove()?

Yeah, we normally need to call put_device() for that. Maybe something like this:

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 500de1dee967..d5b984f042ec 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1812,6 +1812,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
        genpd_unlock(genpd);
        cancel_work_sync(&genpd->power_off_work);
        kfree(genpd->free);
+       put_device(&genpd->dev);
        pr_debug("%s: removed %s\n", __func__, genpd->name);
 
        return 0;

-- 
viresh
