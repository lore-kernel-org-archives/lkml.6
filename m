Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5024DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DBC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3R57B3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DBC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407068AbeKTDab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:30:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45629 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405879AbeKTDab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:30:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so26761886ljd.12;
        Mon, 19 Nov 2018 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cupg+gyw0iedHiI+/lHKOVrFdg5sFLOvecYR9FI3IcI=;
        b=U3R57B3AzJbBE6BdbL0F7tcxSMFadDCAEdYStPVo6Fi2rt1HIHIB5ulCkLQufQ68E5
         SiIp2Q8m3Efz/8Mp5pbjxUMjuI+72emoHGaOGaFb+I8G1KQ1TVTJne2W/ZMbwN3JUHtg
         66qjtXpDFZAOMeFKaXPcIdG/sJdPj2RE4Y/zo+43QgFDOUzmVdmSdaD60CF1evVgPSTf
         BOyjpYrgYq1Eo0/dP04Q5ga0FJX/IsrO1XCWakhgf+2gCs05Cs0sNZA3ZqbOG8062La4
         BRI8H9eAtjJVUa5poQV/u2OtLcW92XipWAAFLReNA8BrVwq98Tw3TR1FoLnhDaM17EkU
         lhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cupg+gyw0iedHiI+/lHKOVrFdg5sFLOvecYR9FI3IcI=;
        b=ko114G1IFzA3DLION2ebazby8A9UWO5jpxwkxfDkbjYYo8MrqT7SUWv8tWlb4qR+ot
         OsVGYAcLJKZCPspaxVLvhAsj7C2y93HfcW2BGwilRBM99hzWPtPKWtipO8lGewfghiUf
         J8t9/p/ZTsFvARBn2fZaPUgFBGkj6dX0vlqkvhwD3dqEPMPjH3X8s7OnOn5dnmdOR+uC
         0NQaVXcEmKvUvnjucP6i97Er4etWkvYAoLGth0Z6+qeeGrpQDTfa5QXSX4jji3IIskum
         TNwk4Ch+RNT+FgBEB+QyYEZeITK5I0QsOOmygHXDNT6f7wJztMD1VaUFnZrE0XH/CqM8
         TwWw==
X-Gm-Message-State: AGRZ1gLPCX7PZRMkeCXTlha7AQ3UJjUqFSk93uT5Xs8KGMwpm1w7JvYF
        ycVJRDf67QDDwWrZ4P0FKm+hNJtJ
X-Google-Smtp-Source: AJdET5cddjPHxDfIerjfwd092xj4+0qi6G4burhcxcmwNFnklE0ieCd3qiLI5aZ7IFSZAGrcGATQ4A==
X-Received: by 2002:a2e:9603:: with SMTP id v3-v6mr9952343ljh.15.1542647171004;
        Mon, 19 Nov 2018 09:06:11 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id v10-v6sm6308405ljh.72.2018.11.19.09.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:06:09 -0800 (PST)
Subject: Re: [PATCH v1 0/4] EMC fixes for Tegra30+
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
 <d1f577d8-a944-35b6-89b3-ce4eafdd4808@gmail.com>
 <f0045dbb-c19a-cd5e-2e78-4b68ccc2342d@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6f4eb4a5-e257-4faa-c5fb-12ffe1f5b3aa@gmail.com>
Date:   Mon, 19 Nov 2018 20:05:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <f0045dbb-c19a-cd5e-2e78-4b68ccc2342d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2018 18:42, Jon Hunter wrote:
> 
> On 18/11/2018 22:06, Dmitry Osipenko wrote:
>> On 30.08.2018 21:54, Dmitry Osipenko wrote:
>>> Hello,
>>>
>>> This patch series fixes couple bugs in the memory self-refresh code.
>>> The EMC / MC state is properly restored after patches being applied,
>>> please review.
>>>
>>> Dmitry Osipenko (4):
>>>   ARM: tegra: Fix missed EMC registers latching on resume from LP1 on
>>>     Tegra30+
>>>   ARM: tegra: Fix DRAM refresh-interval clobbering on resume from LP1 on
>>>     Tegra30
>>>   ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+
>>>   ARM: tegra: Clear EMC interrupts on resume from LP1 on Tegra30+
>>>
>>>  arch/arm/mach-tegra/iomap.h         |  9 ++++++++
>>>  arch/arm/mach-tegra/sleep-tegra30.S | 32 +++++++++++++++++++++++++++--
>>>  2 files changed, 39 insertions(+), 2 deletions(-)
>>>
>>
>> Hello Jon,
>>
>> Could you please test these patches using your testing setup? Will be awesome if you could give t-b/r-b to the series, then there should be a better chance that Thierry could apply it eventually ;)
> 
> Yes I will give them a test and let you know.

Thank you!
