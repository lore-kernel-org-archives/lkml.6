Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD3DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995C5208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9xpN1lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfAEHgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 02:36:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43550 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAEHgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 02:36:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so38390839wrs.10;
        Fri, 04 Jan 2019 23:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3zIzCd9FLMIPQDxVpJpe04QlX8YVQiLj5UEU4B+o1K8=;
        b=E9xpN1lYnKPO5j6HZ4eyt0Fn2bqXfe4/rJ5fpqvp4NFh+6rEkZq3s3+Uf08HOztiKs
         sH8jPMr5+nFRweftd+iMIusFfIjnpuyE+lXAkyT7+nzCBirmX5IA5XapTN9sZS7oSIWX
         +seuolWjEaoCYwwltxrprM/ydVEVdneCLuq6dW2DlnwYYczCZjtimHxy5B2o+mSxCyh5
         rSPV4tYhh59t3SI1eM1UWZDJdvA4Ivze4xy9JZ9TIRLb0+JEVVVNsZEtrQFW0Z3yKGix
         rRjd0epkS4TdsoDuGECqwPZr9uUjmUTE24SVeSnjRUAB2yprGni+LgAIJvnm+HUfG0Im
         rCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3zIzCd9FLMIPQDxVpJpe04QlX8YVQiLj5UEU4B+o1K8=;
        b=jWYYfbS2E0i4zkgTIwIdcREDM/IHgQBnqfN7CSYCCo98WExOuLM5qgSNKcZ9XFDVPk
         o4vyjFRHfmaf0JHrVFZV3VC0fA5dfy37/WVAk93/EEtt1ho7PftqxwUuHKKuX7gSGEnh
         gWygNtc+i0dRKSrgXXSJHX0My1BUIQ2hEctr6kR5ujsEtIn3pQmS7h+HRWsVjyzqHpKG
         ylGRqWVnuGK2fVDDcqQ4nJOOaMA5gVCBCTHyVuz5Wxdi3a6svIOL61ODNvRH3ZEpt83t
         oKYlV2juzAp6wpPcf1a7OZxZ6qqAiYyQkKeDpqphSZIkteGExC4ZW76X6DyBgqS28QLY
         misA==
X-Gm-Message-State: AJcUukdmY+hs+3BomzVOiCrH/LtgluQEEnE3yOXZdaEGu2paSB+gjCJV
        4W2ozykcz7LF5AKDvtMvswZsVHoTmfisWgnc
X-Google-Smtp-Source: ALg8bN5ghhSisNrdrmlvHCvf7653eV43E3e4kvsLv3x4yOKvb5W7w83NdPP4UQMOinzh/OOqztnmGg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr47511835wrj.118.1546673798087;
        Fri, 04 Jan 2019 23:36:38 -0800 (PST)
Received: from [10.8.8.190] ([89.238.186.237])
        by smtp.gmail.com with ESMTPSA id o5sm3784958wmg.25.2019.01.04.23.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 23:36:37 -0800 (PST)
Subject: Re: [PATCH RFC lora-next 1/4] net: lora: sx125x sx1301: correct style
 warnings
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     starnight@g.ncu.edu.tw, jiri@resnulli.us,
        linux-lpwan@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
 <20181219155616.9547-2-ben.whitten@lairdtech.com>
 <62a3e030-98eb-3e63-d193-092b319bd4b1@suse.de>
From:   Ben Whitten <ben.whitten@gmail.com>
Message-ID: <60a4e44a-fc63-4434-0986-1d63111623d1@gmail.com>
Date:   Sat, 5 Jan 2019 16:36:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <62a3e030-98eb-3e63-d193-092b319bd4b1@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 29/12/2018 09:05, Andreas Färber wrote:
> Hi Ben,
> 
> Am 19.12.18 um 16:56 schrieb Ben Whitten:
>> Checkpatch highlights some style issues which need to be addressed.
>>
>> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
>> ---
>>   drivers/net/lora/sx125x.c | 20 +++++++++------
>>   drivers/net/lora/sx1301.c | 52 ++++++++++++++++++++++-----------------
>>   drivers/net/lora/sx1301.h |  7 +++---
>>   3 files changed, 45 insertions(+), 34 deletions(-)
> 
> Thanks for splitting this off from the functional changes. This will
> need some more explanations and discussion. In particular the comment
> changes look wrong to me. Also please don't butcher code just because
> checkpatch.pl may warn about line length at this early stage.

Yeh they seemed odd but checkpatch doesn't like a /* on a line by its 
self it seems.

> 
> A good catch in there was the unsigned casts, which are no longer
> necessary since the regmap conversion, so we should just squash that
> into the earlier commits.
> 
> Note that I used to run checkpatch.pl as git commit hook:
> http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html
> But since some git update that started to break git rebase -i in case of
> false positives (with rebase stopping and on trying to continue commits
> unintentionally getting squashed), so I deactivated it again and don't
> manually check each commit I stage anymore, in favor of slowly
> completing implementations to a working point.

Good to know, I'll avoid running it for the time and drop this from the v2

Thanks!
Ben Whitten
