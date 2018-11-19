Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B685C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B54120851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/E6/fuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B54120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeKTJOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:14:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39202 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeKTJOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:14:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so27585895ljh.6;
        Mon, 19 Nov 2018 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jDKJ3iTR9VGA2l/oUzE+EGpNLTvuwITe6L8L7IA1M/k=;
        b=U/E6/fujoWZ+sA4cWHTpNV7WJtSZsqLbi5cPP/vMiF0tOkNNbSTlvfvuhv+nN/Codw
         CVQ0TdsWDZQ/CK9OO6TbpKMsllf2p9d5zT9Gbw4iLe5QTws5mz7NMoZiE5UX+gehWNIa
         cVignqkJypekIOcAvJRSSMwePQo/77uhFINJaqmeC6ZLQg44JvFLTypm4vxl+8Y9Ph5G
         zGoQdWTUetjE+H5FRq8f7POKGApF7GyqvAqFLHqW4g6oLC6rD1SmYKtIUuXZ5QeP00gR
         KSleQzBL2RW/ufJjM/mTAb1an0sDy+3WX2TxM2fryeEjYXbkBbvKFxpnCArVofJLQ0WZ
         OZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDKJ3iTR9VGA2l/oUzE+EGpNLTvuwITe6L8L7IA1M/k=;
        b=l9+30ai07YLQTIeDyAW18Fq1fb2BQM7mUgSjo8sVws/ZjmQlb1M7TERiSNEHrrzybL
         iqp+r592amV46ceCN0y8rfCY22C+U7T26gCqOUtS++8KJZJiMNuQXqUWFV64C13odyRK
         xKKkw5+w4qK+70sqiWX3t6fs6W2dgszh0BtovCT+alzGISw+WDG1tZRXMhkxQ0zNawst
         vfNu0SdRU2RqvDoyS9JtBaD46PwkAhDy1SIKA21do4qxnxfGdUbRab5s7/Cis9MwRbqV
         A2DFHxikLwB8JZHVcGGyWjAXo0bmT5XGVALb9EtWtpyxXQ8xCWLjkprYWNZOcN92/oAa
         3iFw==
X-Gm-Message-State: AGRZ1gJmX+fVCPx6NC18HwoBMcVENmK9ZlLSsO2BdAwMRpht1SvgBbmn
        Edo7+R+u5IN4wCtLIFeef4xCFqtn
X-Google-Smtp-Source: AJdET5fSNaSJny6Od6/7JvT7r8OGYU0S0GtZOHyG9kTKhi9npMSwgm5jh+Y3i4qZKQLElggjfM+vlA==
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr12259402ljk.76.1542667730711;
        Mon, 19 Nov 2018 14:48:50 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id s20sm5687790lfb.51.2018.11.19.14.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 14:48:49 -0800 (PST)
Subject: Re: [PATCH v1 0/4] EMC fixes for Tegra30+
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
 <d1f577d8-a944-35b6-89b3-ce4eafdd4808@gmail.com>
 <f0045dbb-c19a-cd5e-2e78-4b68ccc2342d@nvidia.com>
 <6f4eb4a5-e257-4faa-c5fb-12ffe1f5b3aa@gmail.com>
 <17936f29-a19f-da3b-c1b0-10128f03058f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a1860eef-3017-cfa0-0c32-dab1a8a07f85@gmail.com>
Date:   Tue, 20 Nov 2018 01:48:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <17936f29-a19f-da3b-c1b0-10128f03058f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 0:26, Jon Hunter wrote:
> 
> On 19/11/2018 17:05, Dmitry Osipenko wrote:
>> On 19.11.2018 18:42, Jon Hunter wrote:
>>>
>>> On 18/11/2018 22:06, Dmitry Osipenko wrote:
>>>> On 30.08.2018 21:54, Dmitry Osipenko wrote:
>>>>> Hello,
>>>>>
>>>>> This patch series fixes couple bugs in the memory self-refresh code.
>>>>> The EMC / MC state is properly restored after patches being applied,
>>>>> please review.
>>>>>
>>>>> Dmitry Osipenko (4):
>>>>>   ARM: tegra: Fix missed EMC registers latching on resume from LP1 on
>>>>>     Tegra30+
>>>>>   ARM: tegra: Fix DRAM refresh-interval clobbering on resume from LP1 on
>>>>>     Tegra30
>>>>>   ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+
>>>>>   ARM: tegra: Clear EMC interrupts on resume from LP1 on Tegra30+
>>>>>
>>>>>  arch/arm/mach-tegra/iomap.h         |  9 ++++++++
>>>>>  arch/arm/mach-tegra/sleep-tegra30.S | 32 +++++++++++++++++++++++++++--
>>>>>  2 files changed, 39 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> Hello Jon,
>>>>
>>>> Could you please test these patches using your testing setup? Will be awesome if you could give t-b/r-b to the series, then there should be a better chance that Thierry could apply it eventually ;)
>>>
>>> Yes I will give them a test and let you know.
>>
>> Thank you!
> 
> No problem. The tests all passed and so I don't see any issues. I have a
> couple comments.

Very nice, thank you very much!
