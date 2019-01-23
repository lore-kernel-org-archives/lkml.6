Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5533C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22D220870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBhTQFuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfAWOWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:22:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36476 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:22:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so1262648plo.3;
        Wed, 23 Jan 2019 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C/zXDivwg0d+BSZ//YR3ea6Vh5Zvd6zbuFHkEiwKEJE=;
        b=vBhTQFuOoGDH81E+eX5VUz43DBH5SsN/TpdMLHWPLYPjUSO773JVMEcTyie8+eB2MC
         btO3JCZBl7dbJx89n8ZZ9QTsTQj9IQmfXZ9ylPqEG09Onlk/DErVw2Q/lIb9zcHjepqJ
         3ed7ZJP1mmsWUHune8wHMMdVyQV1Rl/IOr7nvwY9qQh5S7cTQ2do3zyPobG0wlD8mwCu
         xHhc1nbd5QFX50Q0gRCDlvEcd1u06DS8psdJMW+oEWNveyeq9dcbzAtCVLxE8tABAz+e
         vsoi8mRLFozBXqfQ6OvR9pcoRaxeCgp7JxD3xKIMwQeseoqkQcmgJs1ghhUAuyEjtS9h
         +Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C/zXDivwg0d+BSZ//YR3ea6Vh5Zvd6zbuFHkEiwKEJE=;
        b=dSyZWXXH72nHgQb9JndeBYqg8mkMlMJIjIwoweH0FvJ4c8KrxPmyXrZPGh+xXrq9Nc
         lNeqnlKYXUTEPEXc9UpAs/HohlPmwnP/DB4G7D37xGLC+CUXl9AIMkLxVfq2poGtE5D6
         ol0tog/KhKAFQyVxHAqrstM3hipxkGuFUgLhMIac1Hwto8jFS2lhOG0i/nDOgpHGBiXm
         MwXKCGf3GLX6LR2t8NZYaK3by72b6Jzu3ZrsgBzOVLY2QvLkDnOx49TXb6LcTRtvouX9
         ofl1sX1G+YRUKJPev77bO6ymIn82LKWLHo/VzGGbwzZNd9idm5io4+GlinhxzCcNWDRr
         DJ4g==
X-Gm-Message-State: AJcUukc1oM4/QsKouxeK8LJDvUGdQeo8LHhhPln+6JTv91HABaGGKWC5
        19CgQtMxygY2T5/pnZsZLf0=
X-Google-Smtp-Source: ALg8bN5iSgzFTvJbS830nCqxoS7ib7XeCAFyhqrY4IZxYhZIhq3xLqSQ18sQI1A3G2rzmQs1xZE/+w==
X-Received: by 2002:a17:902:6113:: with SMTP id t19mr2337895plj.248.1548253342967;
        Wed, 23 Jan 2019 06:22:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9sm39633808pfc.92.2019.01.23.06.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:22:22 -0800 (PST)
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
 <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
 <25f46403-e78e-271b-c4d0-13b4623846b3@roeck-us.net>
 <864348fb-3d06-7b4b-cc82-17c96b7ce219@codeaurora.org>
 <20190122100854.nuepsz5ddbt4jda4@vireshk-i7>
 <57f73ea8-3be4-470c-1ef8-d870af605347@codeaurora.org>
 <20190123111630.s33rzxn7o3mr6kks@vireshk-i7>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b2ab31ef-6c95-186f-62b3-f1b04d2de945@roeck-us.net>
Date:   Wed, 23 Jan 2019 06:22:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123111630.s33rzxn7o3mr6kks@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 3:16 AM, Viresh Kumar wrote:
> On 22-01-19, 16:05, Rajendra Nayak wrote:
>> Seeing this now during remove
>>
>> [   34.008216] ------------[ cut here ]------------
>> [   34.012894] Device 'mss' does not have a release() function, it is broken and must be fixed. See Docum.
>> [   34.024143] WARNING: CPU: 6 PID: 1600 at drivers/base/core.c:922 device_release+0x84/0x98
>> [   34.032379] Modules linked in:
>> [   34.035477] CPU: 6 PID: 1600 Comm: sh Not tainted 5.0.0-rc1-00012-g0513915837c5-dirty #34
>> [   34.043724] Hardware name: Qualcomm Technologies, Inc. SDM845 MTP (DT)
>> [   34.050305] pstate: 60400005 (nZCv daif +PAN -UAO)
>> [   34.055141] pc : device_release+0x84/0x98
>> [   34.059186] lr : device_release+0x84/0x98
>> [   34.063229] sp : ffff0000183c3b40
>> [   34.066574] x29: ffff0000183c3b40 x28: ffff800174b55100
>> [   34.071930] x27: 0000000000000000 x26: 0000000000000000
>> [   34.077285] x25: 0000000056000000 x24: 0000000000000015
>> [   34.082640] x23: dead000000000100 x22: dead000000000200
>> [   34.087997] x21: 0000000000000000 x20: ffff0000112f9780
>> [   34.093352] x19: ffff0000112f9770 x18: ffff0000111dd6c8
>> [   34.098719] x17: 0000000000000000 x16: 0000000000000000
>> [   34.104072] x15: ffff0000983c3867 x14: 6966206562207473
>> [   34.109438] x13: 756d20646e61206e x12: 656b6f7262207369
>> [   34.114791] x11: 207469202c6e6f69 x10: 74636e7566202928
>> [   34.120147] x9 : 657361656c657220 x8 : 742e7463656a626f
>> [   34.125514] x7 : 6b2f6e6f69746174 x6 : 0000000000000149
>> [   34.130867] x5 : 0000000000000020 x4 : 000000000001c200
>> [   34.136223] x3 : 00000000ffffffff x2 : ffff0000111f5828
>> [   34.141579] x1 : bc1d8ed5415ab200 x0 : 0000000000000000
>> [   34.146936] Call trace:
>> [   34.149413]  device_release+0x84/0x98
>> [   34.153116]  kobject_put+0x98/0xe8
>> [   34.156551]  put_device+0x14/0x28
>> [   34.159899]  genpd_remove+0x108/0x190
>> [   34.163598]  of_genpd_remove_last+0xbc/0xf0
>> [   34.167828]  rpmhpd_remove+0x2c/0x48
>> [   34.171436]  platform_drv_remove+0x24/0x68
>> [   34.175574]  device_release_driver_internal+0x184/0x218
>> [   34.180845]  device_release_driver+0x14/0x20
>> [   34.185152]  unbind_store+0xec/0x138
>> [   34.188760]  drv_attr_store+0x20/0x30
>> [   34.192465]  sysfs_kf_write+0x48/0x58
>> [   34.196163]  kernfs_fop_write+0xcc/0x1c8
>> [   34.200129]  __vfs_write+0x34/0x170
>> [   34.203654]  vfs_write+0xa8/0x1b8
>> [   34.206998]  ksys_write+0x5c/0xc8
>> [   34.210345]  __arm64_sys_write+0x14/0x20
>> [   34.214318]  el0_svc_common+0xb4/0x118
>> [   34.218107]  el0_svc_handler+0x2c/0x80
>> [   34.221899]  el0_svc+0x8/0xc
>> [   34.224804] ---[ end trace 9cee1458d0b6c175 ]---
>> [   34.229490] ------------[ cut here ]------------
> 
> This shall fix it:
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 500de1dee967..8a44b1f356d0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1711,6 +1711,15 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
>          }
>   }
>   
> +static void genpd_device_release(struct device *dev)
> +{
> +}
> +

See Documentation/kobject.txt.

"One important point cannot be overstated: every kobject must have a
release() method, and the kobject must persist (in a consistent state)
until that method is called. If these constraints are not met, the code is
flawed. Note that the kernel will warn you if you forget to provide a
release() method.  Do not try to get rid of this warning by providing an
"empty" release function.

If all your cleanup function needs to do is call kfree(), then you must
create a wrapper function which uses container_of() to upcast to the correct
type (as shown in the example above) and then calls kfree() on the overall
structure."

Guenter

> +struct device_type genpd_device_type = {
> +       .name =         "genpd_device",
> +       .release =      genpd_device_release,
> +};
> +
>   /**
>    * pm_genpd_init - Initialize a generic I/O PM domain object.
>    * @genpd: PM domain object to initialize.
> @@ -1770,6 +1779,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                  pr_warn("%s : no governor for states\n", genpd->name);
>          }
>   
> +       genpd->dev.type = &genpd_device_type;
>          device_initialize(&genpd->dev);
>          dev_set_name(&genpd->dev, "%s", genpd->name);
>   
> 
> @Ulf: You fine with this ?
> 

