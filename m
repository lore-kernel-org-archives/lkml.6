Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E0ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47BD21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWF7aKf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47BD21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeJSVmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:42:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34450 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSVmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:42:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id f78-v6so10735557pfe.1;
        Fri, 19 Oct 2018 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CFqO1/IduWU4GIBCGoMA8gKfBBnT/oCbeA7hbYjbu1s=;
        b=VWF7aKf3U5CS48lqHeZhyPqOJCuUEfJ6oJgZQNhl47j4qSZk43B4YSHzr8cqCk7EHj
         61FtvaOxYBV9Sc0Jp/nYyWoNHgn4NRL7jdTKBVn9gy5ZVK0YfpZ82m+AuxmQfgNh0Hfs
         e0WYnJNeIdit9Si/pVS6v3awHpCM5UrX3DT7jsm3pS8BqAWWCgK0+6RC4ERgCTCDTFTx
         vbdaaAK5XWUsygQmzLHtDq/zi1nWBbDTy0eENo87zCw8U5/OaDMnv0f+YR/i1R9XLhL1
         6madXCnxJ2c2NGT5HsUHdTJEYm6IWbEZocXRLKjNwHkRVfbXrX9tk9IS3h0msp+zSWN5
         9G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CFqO1/IduWU4GIBCGoMA8gKfBBnT/oCbeA7hbYjbu1s=;
        b=YQxN8fprzjztHHpGfMWib4HL4ZTwM1NNRtQPrLLQWuSuIrm/IWHiVWKQo8DUELTafx
         u2oJ8dn4fX0Qj4Jj/18dtIqMZrXBUSjZZ+xn/cn0cmEhgIv++ov7Qne6Z4MUyCCSRVhg
         ZhTjygF/m5eU318YysQRpORcz6EjwNeaQavT5XhdZCkx2KciY9diTBC6CtrHf1doWypp
         a1p0P8/v7ST71ZvC2Hk0Z86MxdLaz+qETjMRlm6efCsAZVduhKAuNRZE3jH80do75m4T
         zrof0eOoglmxyYcdAiQISSVEmp4et/S1V/MXuC6B5j/apavCxbQQTMacIgtOkh1pDCwR
         0GBQ==
X-Gm-Message-State: ABuFfogO6bBImknIk39KtpuxrMB8gb9wRHLy1JY5BAvQV3+bw5AjsRmf
        hki2iDB4DhQk9XBPvFaQuhtRTqb4
X-Google-Smtp-Source: ACcGV61N+RP2I93yWbnistNf1WmvDXx2jLdNRFciFIpWC0DuOaOi/LxnRWY61SHN9nNKeZJJ89o0tw==
X-Received: by 2002:a63:4e4e:: with SMTP id o14-v6mr33353421pgl.181.1539956157033;
        Fri, 19 Oct 2018 06:35:57 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm35931679pfa.176.2018.10.19.06.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 06:35:56 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] soc/tegra: pmc: Turn powergates_lock into spinlock
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830183635.4474-1-digetx@gmail.com>
 <7369869e-e58f-3760-d428-b00fb9cd28d9@nvidia.com>
 <57c3b1a6-0a60-613e-a4e7-5d66c199b860@gmail.com>
 <cf5b7db9-5109-a9c6-3352-068d205c1b98@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ac646a41-a00a-a216-ff0b-1932ae378130@gmail.com>
Date:   Fri, 19 Oct 2018 16:35:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cf5b7db9-5109-a9c6-3352-068d205c1b98@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/18 3:17 PM, Jon Hunter wrote:
> 
> On 15/10/2018 14:52, Dmitry Osipenko wrote:
>> On 10/15/18 3:52 PM, Jon Hunter wrote:
>>>
>>> On 30/08/18 19:36, Dmitry Osipenko wrote:
>>>> This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y
>>>> and machine (Tegra30) booted with SMP=n or all secondary CPU's are put
>>>> offline.
>>>>
>>>>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
>>>>  in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
>>>>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.18.0-next-20180821-00180-gc3ebb6544e44-dirty #823
>>>>  Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>>>  [<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
>>>>  [<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
>>>>  [<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
>>>>  [<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
>>>>  [<c0151ea0>] (__might_sleep) from [<c0bec2b8>] (mutex_lock+0x2c/0x70)
>>>>  [<c0bec2b8>] (mutex_lock) from [<c0589844>] (tegra_powergate_is_powered+0x44/0xa8)
>>>>  [<c0589844>] (tegra_powergate_is_powered) from [<c0581a60>] (tegra30_cpu_rail_off_ready+0x30/0x74)
>>>>  [<c0581a60>] (tegra30_cpu_rail_off_ready) from [<c0122244>] (tegra30_idle_lp2+0xa0/0x108)
>>>>  [<c0122244>] (tegra30_idle_lp2) from [<c0853438>] (cpuidle_enter_state+0x140/0x540)
>>>>  [<c0853438>] (cpuidle_enter_state) from [<c08538a4>] (cpuidle_enter+0x40/0x4c)
>>>>  [<c08538a4>] (cpuidle_enter) from [<c01595e0>] (call_cpuidle+0x30/0x48)
>>>>  [<c01595e0>] (call_cpuidle) from [<c01599f8>] (do_idle+0x238/0x28c)
>>>>  [<c01599f8>] (do_idle) from [<c0159d28>] (cpu_startup_entry+0x28/0x2c)
>>>>  [<c0159d28>] (cpu_startup_entry) from [<c0be76c8>] (rest_init+0xd8/0xdc)
>>>>  [<c0be76c8>] (rest_init) from [<c1200f50>] (start_kernel+0x41c/0x430)
>>>
>>> Given the above, rather than converting to a spinlock I wonder if we are
>>> just better off dropping the mutex completely from
>>> tegra_powergate_is_powered()? Otherwise ...
>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/soc/tegra/pmc.c | 36 ++++++++++++++++++------------------
>>>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>>> index 2d6f3fcf3211..d6bc9f66f1cd 100644
>>>> --- a/drivers/soc/tegra/pmc.c
>>>> +++ b/drivers/soc/tegra/pmc.c
>>>> @@ -186,7 +186,7 @@ struct tegra_pmc_soc {
>>>>   * @lp0_vec_phys: physical base address of the LP0 warm boot code
>>>>   * @lp0_vec_size: size of the LP0 warm boot code
>>>>   * @powergates_available: Bitmap of available power gates
>>>> - * @powergates_lock: mutex for power gate register access
>>>> + * @powergates_lock: lock for power gate register access
>>>>   */
>>>>  struct tegra_pmc {
>>>>  	struct device *dev;
>>>> @@ -215,7 +215,7 @@ struct tegra_pmc {
>>>>  	u32 lp0_vec_size;
>>>>  	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
>>>>  
>>>> -	struct mutex powergates_lock;
>>>> +	spinlock_t powergates_lock;
>>>>  };
>>>>  
>>>>  static struct tegra_pmc *pmc = &(struct tegra_pmc) {
>>>> @@ -288,10 +288,10 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
>>>>  	if (id == TEGRA_POWERGATE_3D && pmc->soc->has_gpu_clamps)
>>>>  		return -EINVAL;
>>>>  
>>>> -	mutex_lock(&pmc->powergates_lock);
>>>> +	spin_lock(&pmc->powergates_lock);
>>>>  
>>>>  	if (tegra_powergate_state(id) == new_state) {
>>>> -		mutex_unlock(&pmc->powergates_lock);
>>>> +		spin_unlock(&pmc->powergates_lock);
>>>>  		return 0;
>>>>  	}
>>>>  
>>>> @@ -300,7 +300,7 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
>>>>  	err = readx_poll_timeout(tegra_powergate_state, id, status,
>>>>  				 status == new_state, 10, 100000);
>>>>  
>>>> -	mutex_unlock(&pmc->powergates_lock);
>>>> +	spin_unlock(&pmc->powergates_lock);
>>>
>>> ... the above readx_poll_timeout needs to be converted to the atomic
>>> version. Furthermore, the above 100ms timeout is probably not suited to
>>> spinlock.
>>
>> It's converted in the second patch. Seems mutex indeed could be dropped from tegra_powergate_is_powered, at least for now I can't recall why decided to keep the locking. Thank you for the review, I'll try to drop the mutex and come back with v2 if it will be fine.
> 
> Sorry if you were waiting for my response, but yes sounds good to me.

I was just a bit busy lately, but thank you very much for the attention. Sorry if you were waiting for the update of the patch, very likely that I'll update this and some of the other patches around Monday.
