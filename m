Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52730ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199642150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guEq1lof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199642150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeJQTr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:47:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41765 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJQTr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:47:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id q39-v6so19538812lfi.8;
        Wed, 17 Oct 2018 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cfSG1buupXCJHF8jEHW3x2+z7RFJydFSFEVUQlA+auM=;
        b=guEq1lofLc+hLXvba6ZyXOb3a7J1se9Opg0WAFrkiC75OIc3+YcpBlfKefwgXu8z8F
         TsJ4M7fvuoDd/5LjSQYA9y3sVZ6vPcMmTU/+reUygSPMh2iVAHP7JA/D5AnvvKG8XxaT
         NLlB3VM9O7wXDrrItAP2rcm6EZVMVNYPxIYinxm09vftGolf8tOAqhC7Ys8yJx0huQ4/
         /2MyB6iK5BSzOAQg2GCF9GgI00CPEF8gV5yhsiQzZQasGZ7ABNfnAGce6mXkZ5eSkoq8
         i/G1V3a5qlbaMiEEYwNZs7yXA2Yzf/bALtvivIaZGYXSsxG0ToLopcKSz+b367201HJN
         9EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cfSG1buupXCJHF8jEHW3x2+z7RFJydFSFEVUQlA+auM=;
        b=l1etdYtXR9NryRZnx240WywvMrV73kd8wK3foJJBLbHZqMP5mcwn9w6RyUSvOXJ6Bg
         3td6fginHvt1wzoB9Z6rJ5cy8mKzJEdFWD5Im5PS1VdzUJFXMEbPAOYnwlh4+1lWh+HK
         yNmHw3evChUc2BQAvbwsVRlNsEe2NcKDhRWmOcsuXpLMzIyfDS0K9YyDgUW2AMD7/epi
         4vG7Z805EUaRZHvdLocMheSDrkh4JcEBfRJyLKFREnvQLJvfE3j99nweG3B7le1oLHWP
         xVy30AA0aTHJ2QFAGfJzgRG/1XawpLCtG+Ors6ghmPoOGCmrj6J7Q+a3Ha2EaJjnkV5k
         24/A==
X-Gm-Message-State: ABuFfojeV6SQ6Q0aVUXwfJvY+oKrzq1F6JNhKSloz3H3eyZj+9knxLZi
        OlFOV10TEeQM1U3kDXwAGD6EzvBf
X-Google-Smtp-Source: ACcGV62hAcBCGzD8qXv1fpPXpAuIu3Uv6PMwFEQMAI2WkddnfT1SlTCF72cgXfddlKpz76D9Log6pw==
X-Received: by 2002:a19:a686:: with SMTP id p128-v6mr14905522lfe.42.1539777155232;
        Wed, 17 Oct 2018 04:52:35 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id k18-v6sm3922402ljk.58.2018.10.17.04.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 04:52:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for PLLs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830184210.5369-1-digetx@gmail.com>
 <20180830184210.5369-2-digetx@gmail.com>
 <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
 <909e2a52-4116-9ee7-db23-8ea1dfffade0@gmail.com>
Message-ID: <2e877ee7-2977-496b-5073-772256c76191@gmail.com>
Date:   Wed, 17 Oct 2018 14:52:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <909e2a52-4116-9ee7-db23-8ea1dfffade0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/18 12:45 PM, Dmitry Osipenko wrote:
> On 8/31/18 12:29 PM, Peter De Schrijver wrote:
>> On Thu, Aug 30, 2018 at 09:42:10PM +0300, Dmitry Osipenko wrote:
>>> Currently all PLL's on Tegra20 use a hardcoded delay despite of having
>>> a lock-status bit. The lock-status polling was disabled ~7 years ago
>>> because PLLE was failing to lock and was a suspicion that other PLLs
>>> might be faulty too. Other PLLs are okay, hence enable the lock-status
>>> polling for them. This reduces delay of any operation that require PLL
>>> to lock.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>
>>> Changelog:
>>>
>>> v2:	Don't enable polling for PLLE as it known to not being able to lock.
>>>
>>
>> This isn't correct. The lock bit of PLLE can declare lock too early, but the
>> PLL itself does lock.
> 
> Indeed, it locks but can't be polled for the lock-status as it doesn't have the
> lock-status bit.

Actually it has lock-status bit. Not sure how I managed to miss it before.
