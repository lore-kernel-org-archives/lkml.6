Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D810C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DEA2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kcjejlR2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WjkwZZ7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfAVKfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:35:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfAVKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:35:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFBDA60712; Tue, 22 Jan 2019 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548153352;
        bh=bH84QNe22o3cu3+f0zBMUL3u5wNwkjesQ6bAEX8dssE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kcjejlR2vsXGx/PbjsBIo4QRUDWss/TMQuEuaRygrOCCsvVn9aBhBR8MaBJ4Yi1Ej
         fx+MTQmmQEtlss/L4m1WIPfePxEe3Ao/Bpqgy10ueHETqQdWBWe02pmBBBaWQ4rJaR
         uuQ4E6LzqSniQAWIGjCRKji20yAqfSg/gMKjmCD0=
Received: from [10.79.128.187] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6468F6034E;
        Tue, 22 Jan 2019 10:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548153351;
        bh=bH84QNe22o3cu3+f0zBMUL3u5wNwkjesQ6bAEX8dssE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WjkwZZ7ABKnHCX4BuXwAgIUQD1sR6HWXI4BtrX1MMitH1Ju6oc/mae1Yd6wJXTnaT
         asium5hS3EoYiwSYzbYtlK14BB09hCMdPl94Z9AK4QGW2TC7CzPm7SyCocms3vKOSQ
         5+MdPfyXysBUHOn0c8REjttUWHRbf4ICKFPXZ5QA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6468F6034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
 <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
 <25f46403-e78e-271b-c4d0-13b4623846b3@roeck-us.net>
 <864348fb-3d06-7b4b-cc82-17c96b7ce219@codeaurora.org>
 <20190122100854.nuepsz5ddbt4jda4@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <57f73ea8-3be4-470c-1ef8-d870af605347@codeaurora.org>
Date:   Tue, 22 Jan 2019 16:05:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122100854.nuepsz5ddbt4jda4@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/2019 3:38 PM, Viresh Kumar wrote:
> On 22-01-19, 15:24, Rajendra Nayak wrote:
>> I was doing some quick testing by adding the calls to of_genpd_remove_last() as
>> suggested by Ulf for cleaning up the genpd registrations, and I run into this
>> backtrace when the driver re-probes followed by a remove
>>
>> [   59.204525] kobject ((____ptrval____)): tried to init an initialized object, something is seriously wr.
>> [   59.214262] CPU: 3 PID: 1600 Comm: sh Not tainted 5.0.0-rc1-00012-g0513915837c5-dirty #32
>> [   59.222500] Hardware name: Qualcomm Technologies, Inc. SDM845 MTP (DT)
>> [   59.229081] Call trace:
>> [   59.231574]  dump_backtrace+0x0/0x148
>> [   59.235276]  show_stack+0x14/0x20
>> [   59.238631]  dump_stack+0x8c/0xac
>> [   59.241980]  kobject_init+0x8c/0xa0
>> [   59.245506]  device_initialize+0x34/0xc8
>> [   59.249474]  pm_genpd_init+0x170/0x260
>> [   59.253261]  rpmhpd_probe+0x194/0x2b0
>> [   59.256966]  platform_drv_probe+0x4c/0xa8
>> [   59.261011]  really_probe+0x1e4/0x2c8
>> [   59.264711]  driver_probe_device+0x58/0x10
>> [   59.268927]  bind_store+0xdc/0x178
>> [   59.272356]  drv_attr_store+0x20/0x30
>> [   59.276061]  sysfs_kf_write+0x48/0x58
>> [   59.279760]  kernfs_fop_write+0xcc/0x1c8
>> [   59.283728]  __vfs_write+0x34/0x170
>> [   59.287245]  vfs_write+0xa8/0x1b8
>> [   59.290592]  ksys_write+0x5c/0xc8
>> [   59.293941]  __arm64_sys_write+0x14/0x20
>> [   59.297897]  el0_svc_common+0xb4/0x118
>> [   59.301676]  el0_svc_handler+0x2c/0x80
>> [   59.305455]  el0_svc+0x8/0xc
>>
>> Viresh/Ulf, looks like we need some cleanup of whats done by device_initialize()
>> in pm_genpd_init() to happen as part of the pm_genpd_remove()?
> 
> Yeah, we normally need to call put_device() for that. Maybe something like this:
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 500de1dee967..d5b984f042ec 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1812,6 +1812,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>          genpd_unlock(genpd);
>          cancel_work_sync(&genpd->power_off_work);
>          kfree(genpd->free);
> +       put_device(&genpd->dev);
>          pr_debug("%s: removed %s\n", __func__, genpd->name);
>   
>          return 0;

Seeing this now during remove

[   34.008216] ------------[ cut here ]------------
[   34.012894] Device 'mss' does not have a release() function, it is broken and must be fixed. See Docum.
[   34.024143] WARNING: CPU: 6 PID: 1600 at drivers/base/core.c:922 device_release+0x84/0x98
[   34.032379] Modules linked in:
[   34.035477] CPU: 6 PID: 1600 Comm: sh Not tainted 5.0.0-rc1-00012-g0513915837c5-dirty #34
[   34.043724] Hardware name: Qualcomm Technologies, Inc. SDM845 MTP (DT)
[   34.050305] pstate: 60400005 (nZCv daif +PAN -UAO)
[   34.055141] pc : device_release+0x84/0x98
[   34.059186] lr : device_release+0x84/0x98
[   34.063229] sp : ffff0000183c3b40
[   34.066574] x29: ffff0000183c3b40 x28: ffff800174b55100
[   34.071930] x27: 0000000000000000 x26: 0000000000000000
[   34.077285] x25: 0000000056000000 x24: 0000000000000015
[   34.082640] x23: dead000000000100 x22: dead000000000200
[   34.087997] x21: 0000000000000000 x20: ffff0000112f9780
[   34.093352] x19: ffff0000112f9770 x18: ffff0000111dd6c8
[   34.098719] x17: 0000000000000000 x16: 0000000000000000
[   34.104072] x15: ffff0000983c3867 x14: 6966206562207473
[   34.109438] x13: 756d20646e61206e x12: 656b6f7262207369
[   34.114791] x11: 207469202c6e6f69 x10: 74636e7566202928
[   34.120147] x9 : 657361656c657220 x8 : 742e7463656a626f
[   34.125514] x7 : 6b2f6e6f69746174 x6 : 0000000000000149
[   34.130867] x5 : 0000000000000020 x4 : 000000000001c200
[   34.136223] x3 : 00000000ffffffff x2 : ffff0000111f5828
[   34.141579] x1 : bc1d8ed5415ab200 x0 : 0000000000000000
[   34.146936] Call trace:
[   34.149413]  device_release+0x84/0x98
[   34.153116]  kobject_put+0x98/0xe8
[   34.156551]  put_device+0x14/0x28
[   34.159899]  genpd_remove+0x108/0x190
[   34.163598]  of_genpd_remove_last+0xbc/0xf0
[   34.167828]  rpmhpd_remove+0x2c/0x48
[   34.171436]  platform_drv_remove+0x24/0x68
[   34.175574]  device_release_driver_internal+0x184/0x218
[   34.180845]  device_release_driver+0x14/0x20
[   34.185152]  unbind_store+0xec/0x138
[   34.188760]  drv_attr_store+0x20/0x30
[   34.192465]  sysfs_kf_write+0x48/0x58
[   34.196163]  kernfs_fop_write+0xcc/0x1c8
[   34.200129]  __vfs_write+0x34/0x170
[   34.203654]  vfs_write+0xa8/0x1b8
[   34.206998]  ksys_write+0x5c/0xc8
[   34.210345]  __arm64_sys_write+0x14/0x20
[   34.214318]  el0_svc_common+0xb4/0x118
[   34.218107]  el0_svc_handler+0x2c/0x80
[   34.221899]  el0_svc+0x8/0xc
[   34.224804] ---[ end trace 9cee1458d0b6c175 ]---
[   34.229490] ------------[ cut here ]------------

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
