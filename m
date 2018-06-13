Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 99F47C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B46208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du+rJTxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B46208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935785AbeFMU5h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:57:37 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46149 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935524AbeFMU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:57:36 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so1836541pga.13;
        Wed, 13 Jun 2018 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LxbmLTpsQqjiDN5Skt3GmO+MLvidSMtZHgCmAZ9bNJg=;
        b=Du+rJTxE7ORG/HY7+aoHTRK1KTaKjAiomjh0bmecx+KHOYKyX4vb0UHQmfXuNJHlqj
         tY/U3yeyohuNgRWb+lW5AzfLJ2qIoXlI2aYv8h/Fff5weDPcp75O2NeMUg8l6ehRKRRf
         qpq78JOQESU4aiywMrlnrI+uBS0YMbkM53mgyhR3dx6+ycaa7zXLlz5BV2c7IJyrX3u+
         0+xRRTrtftVQIpFbesvXQuR8f8pMFPhibqkZPUu9xw8WF306oL13KZqU98i5u+/yExa8
         eDbOVt3pfSdnJ2ztqSAu/pL4q/iJKo8yXRg7lzuF3lvzhY4eBg+tTOyZfJzU/Y6OLO/U
         L25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LxbmLTpsQqjiDN5Skt3GmO+MLvidSMtZHgCmAZ9bNJg=;
        b=OKEvNbd9Rp4PaeNMzD3lho1CnnA3pprZNlZytga4UkjrAFSZlH/4qu/ghK3C1asz/t
         EEkmZgDwee8oWUYUmJLz7NAP8axAG28X0pa6/pKS+0aemrZWebMc73T1tpSefDjecPmR
         XpyamSjo9xr4i4m7SJQcFUjoiL42+z/ZGmjqcnkNLckZXOS8bkbZYTrfGHdv3WH9fxVI
         shdzzgLsmPe9XrzqFNnc6agPYIyjcFK1y0mdjcdLl2uc8TaP0niLtrsFb9gA4Ni0D5RE
         xZD+6zkdRk6WSeTRFqf+FI/IprBPWlbFVKrVp44NnWtjGLC9JwB8mkQIMadyRazvD767
         og/Q==
X-Gm-Message-State: APt69E0FQKmTTwVdrWgr+GhHohbkWbNvavkgKOZefRkeb0u1PX7wkQkr
        2+8B3d07lNoSWCk1jzQpFWI=
X-Google-Smtp-Source: ADUXVKI8AgV0IfArG8ianEJwxvG/xaALGFmrJzu1efCI8DAMB1c0xPi38XQ275DuOPQkZwFO3V04IA==
X-Received: by 2002:a63:5f54:: with SMTP id t81-v6mr5364604pgb.108.1528923455528;
        Wed, 13 Jun 2018 13:57:35 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id 15-v6sm6949128pfq.81.2018.06.13.13.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 13:57:34 -0700 (PDT)
Subject: Re: [PATCH v2] hv_netvsc: Add per-cpu ethtool stats for netvsc
To:     Yidong Ren <yidren@linuxonhyperv.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yidong Ren <yidren@microsoft.com>
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4c853799-44e0-ff33-3555-41982d601ebb@gmail.com>
Date:   Wed, 13 Jun 2018 13:57:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180613193608.444-1-yidren@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2018 12:36 PM, Yidong Ren wrote:
> From: Yidong Ren <yidren@microsoft.com>
> 
> This patch implements following ethtool stats fields for netvsc:
> cpu<n>_tx/rx_packets/bytes
> cpu<n>_vf_tx/rx_packets/bytes

...
>  
> +	pcpu_sum = alloc_percpu(struct netvsc_ethtool_pcpu_stats);
> +	netvsc_get_pcpu_stats(dev, pcpu_sum);
> +	for_each_present_cpu(cpu) {
> +		struct netvsc_ethtool_pcpu_stats *this_sum =
> +			per_cpu_ptr(pcpu_sum, cpu);
> +		for (j = 0; j < ARRAY_SIZE(pcpu_stats); j++)
> +			data[i++] = *(u64 *)((void *)this_sum
> +					     + pcpu_stats[j].offset);
> +	}
> +	free_percpu(pcpu_sum);
>


Using alloc_percpu() / free_percpu() for a short section of code makes no sense.

You actually want to allocate memory local to this cpu, possibly in one chunk,
not spread all over the places.

kvmalloc(nr_cpu_ids * sizeof(struct netvsc_ethtool_pcpu_stats))  should be really better,
since it would most of the time be satisfied by a single kmalloc()

