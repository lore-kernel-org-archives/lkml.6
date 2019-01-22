Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702C7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CF5218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mpwTgCut";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ba6I72zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfAVJyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:54:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfAVJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:54:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BE9E46028D; Tue, 22 Jan 2019 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548150849;
        bh=SyiJy+n3OjaRZU0Dq1HEyr9W5DkvfpG1GSYIMqVC6nA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mpwTgCutBnjacpiVgyYCPEgguNL3qInkCjnHXJsIS3eGnzFbUYV+wPhkvyqwOXjd7
         lqBC/1WCex9Km/f1QMo8i2dqWtiH/wpdkT548RYcnF59BOR6yK5Tl97oHYkOVIHBWa
         ylDvH4IqAF1AxM1oYqDq8OZ4yI0N1YQZU4VTvID4=
Received: from [10.79.128.187] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AAD456028D;
        Tue, 22 Jan 2019 09:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548150848;
        bh=SyiJy+n3OjaRZU0Dq1HEyr9W5DkvfpG1GSYIMqVC6nA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ba6I72zXLtlz7Tm02b93Prq/kvAEGbm3p/axuml0u0numqVHEEXkN8UDZUvj1VtH4
         hS72MYYUXzFgq3FIjxx1jon7MVwV1mhOnCvF5bN8gqdTkiyVAf4mj3C3FmsHroFg5t
         FjaWrbSo7El4sZodNCi8kDgvCMup/rcTDF39Kmmo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AAD456028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
To:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
 <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
 <25f46403-e78e-271b-c4d0-13b4623846b3@roeck-us.net>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <864348fb-3d06-7b4b-cc82-17c96b7ce219@codeaurora.org>
Date:   Tue, 22 Jan 2019 15:24:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <25f46403-e78e-271b-c4d0-13b4623846b3@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Viresh and Ulf to this thread,

On 1/22/2019 10:38 AM, Guenter Roeck wrote:
> On 1/21/19 6:30 PM, Rajendra Nayak wrote:
>>
>>
>> On 1/18/2019 11:09 PM, Stephen Boyd wrote:
>>> Quoting Rajendra Nayak (2019-01-17 20:48:01)
>>>>   drivers/soc/qcom/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index a5d5167c3f16..1ee298f6bf17 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>> +++ b/drivers/soc/qcom/Kconfig
>>>> @@ -109,7 +109,7 @@ config QCOM_RPMHPD
>>>>   config QCOM_RPMPD
>>>>          bool "Qualcomm RPM Power domain driver"
>>>
>>> Just curious, does it need to be bool for some reason?
>>
>> Here's the link to the discussion around it on the v3 patchset of this series
>> https://lkml.org/lkml/2018/6/12/111
>>
> 
> I think you were missing the implication of "if possible", the implication
> being that the driver can now not be used in a multi-platform image, and that
> having a bool driver depend on tristate drivers doesn't make much if any sense.

Fair enough, I hadn't thought about the implications with multi platform builds,
I guess it makes sense to have these drivers as tristate then.

I was doing some quick testing by adding the calls to of_genpd_remove_last() as
suggested by Ulf for cleaning up the genpd registrations, and I run into this
backtrace when the driver re-probes followed by a remove

[   59.204525] kobject ((____ptrval____)): tried to init an initialized object, something is seriously wr.
[   59.214262] CPU: 3 PID: 1600 Comm: sh Not tainted 5.0.0-rc1-00012-g0513915837c5-dirty #32
[   59.222500] Hardware name: Qualcomm Technologies, Inc. SDM845 MTP (DT)
[   59.229081] Call trace:
[   59.231574]  dump_backtrace+0x0/0x148
[   59.235276]  show_stack+0x14/0x20
[   59.238631]  dump_stack+0x8c/0xac
[   59.241980]  kobject_init+0x8c/0xa0
[   59.245506]  device_initialize+0x34/0xc8
[   59.249474]  pm_genpd_init+0x170/0x260
[   59.253261]  rpmhpd_probe+0x194/0x2b0
[   59.256966]  platform_drv_probe+0x4c/0xa8
[   59.261011]  really_probe+0x1e4/0x2c8
[   59.264711]  driver_probe_device+0x58/0x10
[   59.268927]  bind_store+0xdc/0x178
[   59.272356]  drv_attr_store+0x20/0x30
[   59.276061]  sysfs_kf_write+0x48/0x58
[   59.279760]  kernfs_fop_write+0xcc/0x1c8
[   59.283728]  __vfs_write+0x34/0x170
[   59.287245]  vfs_write+0xa8/0x1b8
[   59.290592]  ksys_write+0x5c/0xc8
[   59.293941]  __arm64_sys_write+0x14/0x20
[   59.297897]  el0_svc_common+0xb4/0x118
[   59.301676]  el0_svc_handler+0x2c/0x80
[   59.305455]  el0_svc+0x8/0xc

Viresh/Ulf, looks like we need some cleanup of whats done by device_initialize()
in pm_genpd_init() to happen as part of the pm_genpd_remove()?

> 
> The argument in the exchange is odd - one can not remove any driver as long
> there are client drivers / devices attached to it. This is true for all
> drivers, not just for this one, and handled quite nicely by the driver core.
> Just run "lsmod" and try to remove a driver with any attached users.
> 
> Guenter

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
