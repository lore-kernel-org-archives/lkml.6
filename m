Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D5C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354F9204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS6khBw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354F9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJXTMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:12:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35972 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:12:35 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so5976205itd.1;
        Wed, 24 Oct 2018 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FgNH7x+HdWoLNCbXpAubZjrLmkp3dLcitNiZp2XiluI=;
        b=HS6khBw0K0mJrLDUCtVd8TM5xBa0pxB2DyADvqGaTLn/2K9oZQFJY0jkkkth8cmdw+
         eJVpQfxt6cS8K4V/dq/bAkj3WLwO7RYEzrC6KGdAVRGcj3tBPZ+E7R3yQe//zxtRPXnN
         nwdEfgC7kS9zesXFSsx9p0UYJmoKVJ0Aufv7kCiS87H9Z984fn8Di9pBJFdqJ5dWHpvs
         /TTynacu8bSEXfOxq3jg+nGPfairSHZFqsd482f/+U3H73PVP+433aAaStHaDUi5tKI6
         6+0d9ADjci98mP1eefywU6KI3dNkAo246KyXfp/ZQ0GX3bwEtgkx5hNG1gHDDlPnh0rW
         TVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FgNH7x+HdWoLNCbXpAubZjrLmkp3dLcitNiZp2XiluI=;
        b=bd9Jpqw9p5qWNiCl3ZHIVtNiWqmN311Hh1p1B+2PKbeAXSVsUFC86CUYaGSGKpXXJD
         mUdBc+sRla7ET3JFrip4GXWjdLqZ5NnqwbnWzNUZ5PIHI44yHJdM70HkU5snTkrYhW+f
         JN2WqhWInqb3oQWuYKhrBf3MvWZsziPOLDFg8TczH8zXWuDa24BSWUuGbPRHHTwkhTw4
         HWg/nrvBTF7aW6tZ/K+53BLLkmw906WhH69lr49On3EVXZIJUpqxahuXLS377DYqoSPz
         1iAGxn90DHREvepXUlYB7oUmwPnSLyp1xDohqC8m/xhUUwHi6JPMvvaD33QlvUvWqWAB
         /+7g==
X-Gm-Message-State: AGRZ1gIPwy+RT4R3LfY1wNK4WXJkrBTquXn4FwYRdbZK3OWSxs8Z3OZg
        LlZ2Cp8VCMfUF13x85G/1LdCSdIS
X-Google-Smtp-Source: AJdET5eyKlV6sTarToIIzfY+9yq9EffoJM2SlCGLMm0mo44miuXewYMFgKx1g4uMLL2Hj6RYu5L6YQ==
X-Received: by 2002:a02:4c2:: with SMTP id 185-v6mr1351721jab.48.1540377898759;
        Wed, 24 Oct 2018 03:44:58 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id x7sm2021112itj.14.2018.10.24.03.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:44:58 -0700 (PDT)
Subject: Re: [PATCH v1] soc/tegra: pmc: Drop locking from
 tegra_powergate_is_powered()
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021183614.454-1-digetx@gmail.com>
 <4c318e6b-4841-dd52-d61d-1106c5f8afbc@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <11fc94af-efe2-e571-3163-efdaa91f34fc@gmail.com>
Date:   Wed, 24 Oct 2018 13:44:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4c318e6b-4841-dd52-d61d-1106c5f8afbc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 1:20 PM, Jon Hunter wrote:
> 
> On 21/10/2018 19:36, Dmitry Osipenko wrote:
>> This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y
>> and machine (Tegra30) booted with SMP=n or all secondary CPU's are put
>> offline. Locking isn't needed because it protects atomic operation.
>>
>> # echo 0 | tee /sys/devices/system/cpu/cpu[1-3]/online
>>
>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
>> in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
>> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.18.0-next-20180821-00180-gc3ebb6544e44-dirty #823
>> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> [<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
>> [<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
>> [<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
>> [<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
>> [<c0151ea0>] (__might_sleep) from [<c0bec2b8>] (mutex_lock+0x2c/0x70)
>> [<c0bec2b8>] (mutex_lock) from [<c0589844>] (tegra_powergate_is_powered+0x44/0xa8)
>> [<c0589844>] (tegra_powergate_is_powered) from [<c0581a60>] (tegra30_cpu_rail_off_ready+0x30/0x74)
>> [<c0581a60>] (tegra30_cpu_rail_off_ready) from [<c0122244>] (tegra30_idle_lp2+0xa0/0x108)
>> [<c0122244>] (tegra30_idle_lp2) from [<c0853438>] (cpuidle_enter_state+0x140/0x540)
>> [<c0853438>] (cpuidle_enter_state) from [<c08538a4>] (cpuidle_enter+0x40/0x4c)
>> [<c08538a4>] (cpuidle_enter) from [<c01595e0>] (call_cpuidle+0x30/0x48)
>> [<c01595e0>] (call_cpuidle) from [<c01599f8>] (do_idle+0x238/0x28c)
>> [<c01599f8>] (do_idle) from [<c0159d28>] (cpu_startup_entry+0x28/0x2c)
>> [<c0159d28>] (cpu_startup_entry) from [<c0be76c8>] (rest_init+0xd8/0xdc)
>> [<c0be76c8>] (rest_init) from [<c1200f50>] (start_kernel+0x41c/0x430)
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/soc/tegra/pmc.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 1fa840e3d930..1714cd818d69 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -543,9 +543,7 @@ int tegra_powergate_is_powered(unsigned int id)
>>  	if (!tegra_powergate_is_valid(id))
>>  		return -EINVAL;
>>  
>> -	mutex_lock(&pmc->powergates_lock);
>>  	status = tegra_powergate_state(id);
>> -	mutex_unlock(&pmc->powergates_lock);
>>  
>>  	return status;
> 
> Can we just ...
> 
> 	return tegra_powergate_state(id);

We can, but it is not necessary. Feel free to adjust the code as you wish while applying ;) I deliberately left the 'status' variable because I think that makes code a bit more expressive.
