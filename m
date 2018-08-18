Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE89C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D114E208D6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqUHamxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D114E208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeHRSTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:19:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45254 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:19:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so6067199edq.12;
        Sat, 18 Aug 2018 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dmzJ5soFYXtMqqBPqgL+UN1BXOakD3PCDE9ylaADD50=;
        b=AqUHamxAEejVTTZ4xCngCzBi+CmWxeJTGJyl12+Nmnj/5iHDnM5pNhijV8SAFhsC03
         CTNgdwJ0RdZkD6h7jIOlpMD2Bd3BJdSLelb/VLaEa7ZfqlkseHnABt28ef4Ty47Wxggx
         V2qWYMmbrbd2mcFzd0NU/+I8v9r6CvaC0Oz5aPQzj8slgsFWIqxlqsollZ3K1BDa396a
         Vd/C5r5icmKX8BUv/uYs4Riq6rgK4DwwASSUQNfYgUlLP89fg5WXjwujY7zHu0nIumLi
         mOFlFf4F9TZuH6m2YAg8GqD3OlNsmFoxMmV5MDJnUfpUkjhDe01lNraKVdHcLb3K8oEj
         HgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dmzJ5soFYXtMqqBPqgL+UN1BXOakD3PCDE9ylaADD50=;
        b=DgY0L2NcxQFGcTRG8Eth2vKRz3ms/n0iZjx4epMNRlcNnOLHoQQI7ce0gUqVA9eoTq
         P/8x6PF+877a4UeGqt5oH4PvOhkJgAmrbtr2fPVygdVLMOB60La2TvoakoBBXuHNP5cw
         gc77wTmDNmoGr8dJLI0agIqPTaIV4+icd06f2gAzJE7PaCSRgBfNu083ViUo8iel1JrG
         AUVI+Gue0wRaIhDkadrsukmStl7gck8qQdSb4XjO2YD2xo4XqKaitv+Im2pys1eWXnjk
         77AkNMoYD7Tuxywqjtpvy+mWPkaDNcbIv0sWPR7dZJYSWLICBFbkA2NoZD+MP1MHaTm2
         AwrQ==
X-Gm-Message-State: AOUpUlHxliYtqB/VUqVUpTvk8jq4Lh68ZeZaPhhyls4FNHLAfNrZwXfH
        yENvPkDQ7xjmipj7hXRw4AC8sdeB
X-Google-Smtp-Source: AA+uWPwWCLsKpguz3eoAXUK5AE2y0cKXanHlXjyDnVboAsUsAIxUGkr5l5RZTw10eK04OCsmgt5kNQ==
X-Received: by 2002:a50:8386:: with SMTP id 6-v6mr46630689edi.170.1534605058223;
        Sat, 18 Aug 2018 08:10:58 -0700 (PDT)
Received: from [192.168.2.145] (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.googlemail.com with ESMTPSA id h10-v6sm3392908edb.51.2018.08.18.08.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:10:57 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] gpu: host1x: Continue CDMA execution starting with
 a next job
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180807130713.1016-1-digetx@gmail.com>
 <20180807130713.1016-4-digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <38bac8a9-fce3-9c17-c000-74c52446f9e9@gmail.com>
Date:   Sat, 18 Aug 2018 18:10:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807130713.1016-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.2018 16:07, Dmitry Osipenko wrote:
> Currently gathers of a hung job are getting NOP'ed and a restarted CDMA
> executes the NOP'ed gathers. There shouldn't be a reason to not restart
> CDMA execution starting with a next job, avoiding the unnecessary churning
> with gathers NOP'ing.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/cdma.c       | 23 +++++++++++------------
>  drivers/gpu/host1x/hw/cdma_hw.c | 13 -------------
>  2 files changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index 6aa6fa1498e8..9e4f01c7f663 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c
> @@ -323,7 +323,7 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>  {
>  	struct host1x *host1x = cdma_to_host1x(cdma);
>  	u32 restart_addr, syncpt_incrs, syncpt_val;
> -	struct host1x_job *job;
> +	struct host1x_job *job, *next_job = NULL;
>  
>  	syncpt_val = host1x_syncpt_load(cdma->timeout.syncpt);
>  
> @@ -341,8 +341,13 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>  		__func__);
>  
>  	list_for_each_entry(job, &cdma->sync_queue, list) {
> -		if (syncpt_val < job->syncpt_end)
> +		if (syncpt_val < job->syncpt_end) {
> +
> +			if (!list_is_last(&job->list, &cdma->sync_queue))
> +				next_job = list_next_entry(job, list);
> +
>  			goto syncpt_incr;
> +		}
>  
>  		host1x_job_dump(dev, job);
>  	}
> @@ -355,17 +360,11 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>  	/*
>  	 * Increment with CPU the remaining syncpts of a partially executed job.
>  	 *
> -	 * Syncpt increments must be done inline with the pushbuffer from a
> -	 * GATHER buffer to maintain the order (slots are modified to be a
> -	 * GATHER of syncpt incrs).
> -	 *
> -	 * Note: save in restart_addr the location where the timed out buffer
> -	 * started in the PB, so we can start the refetch from there (with the
> -	 * modified NOP-ed PB slots). This lets things appear to have completed
> -	 * properly for this buffer and resources are freed.
> +	 * CDMA will continue execution starting with the next job or will get
> +	 * into idle state.
>  	 */
> -	if (job)
> -		restart_addr = job->first_get;
> +	if (next_job)
> +		restart_addr = next_job->first_get;
>  	else
>  		restart_addr = cdma->last_pos;
>  
> diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma_hw.c
> index ce320534cbed..bc203532ae6d 100644
> --- a/drivers/gpu/host1x/hw/cdma_hw.c
> +++ b/drivers/gpu/host1x/hw/cdma_hw.c
> @@ -40,7 +40,6 @@ static void cdma_timeout_cpu_incr(struct host1x_cdma *cdma, u32 getptr,
>  				u32 syncpt_incrs, u32 syncval, u32 nr_slots)
>  {
>  	struct host1x *host1x = cdma_to_host1x(cdma);

The *host1x is now unused and should be removed as well, I'll fix it in v3.
Mikko, could you take a look at the patches?
