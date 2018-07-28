Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B489BC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 12:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D15E20873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQtziXdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D15E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeG1N3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 09:29:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33394 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeG1N3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 09:29:40 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15-v6so7755453qtp.0;
        Sat, 28 Jul 2018 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hY9DWyyVD/YMEXbHukgIMrMW0ByhD0ZWNgtktya1LIE=;
        b=GQtziXdSqBKAGvYFDDE1vmyVggFIf5HsDj8s7/i6Dl7+K4ud84KDcFz5r3YpI8sZD5
         S0Tu4WgIUsNVr0B9Cz/fiie5ImTjoKJNn708O0OYUVa+RQF7/ugp9O9ym0EYxLg7AavX
         8pTXYaWE5f/WvrL4I9A8xQYJi8u0uk+cemStEkjkmEgv3+UcYtMsYpvTf92c/IciuxOU
         niyg6xmoSM8Uftyqj9wi+XCzOrIbuq2JNLsEjYBnPEpILfupoc1lPXpLfp/TBy46lTbz
         Qk0u/B0SlYghvsSjzAGgO0ovmusObnu7x/3MCJNoVQZ1w5oha/4pFmRwQImRIPOItCTU
         pG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hY9DWyyVD/YMEXbHukgIMrMW0ByhD0ZWNgtktya1LIE=;
        b=oUghJrDwLELH7vOmp6T7+GETMjhzM1n/e2pwaBlnoBR+YeUk/D6KxKFHCZffn2zxG+
         J1T1P+wz08C3yr9Glic9Ihx61IEJcKDcqCKJ775UZq3fiGXsDY/sBn2q251+DuCZa2wH
         b1sStSlZrxxQQULCcpuqpep6GIsW79UFVlPivw/AZXnbKYLY+IzSU3sHeHAZn+CzsHal
         v/shCv9EB/6+eXTyxEYDotgaUrO2BP/5qv0YpRnnzZGib4EZJ5rLA8K0e5VywRF+9Pyq
         G3flH9gcgfRYmVtUiza7wKpIP54WaOxE8E2KvmWw9IoAesKnlxwDudcom37mI3WTS0o1
         qYGA==
X-Gm-Message-State: AOUpUlHwVtYLwZsVKQ6vjV1osHUtcbqgRC+FVXrzXRkeRdxO7/iQ2YST
        Gtno+qZrZ5Pil2MgraX00F8LjQa5cUcIeQ==
X-Google-Smtp-Source: AAOMgpdDpis0Aczxs6LrIAeZi5ZI/ydC/O3Y4isADYj9OuLaRGA1JuLa/dt2pd4UrJycnZ2pIUDbvA==
X-Received: by 2002:ac8:6647:: with SMTP id j7-v6mr9554672qtp.231.1532779400934;
        Sat, 28 Jul 2018 05:03:20 -0700 (PDT)
Received: from ?IPv6:2601:153:601:7d2a::1005? ([2601:153:601:7d2a::1005])
        by smtp.gmail.com with ESMTPSA id p64-v6sm4956461qkl.30.2018.07.28.05.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 05:03:20 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, marcel.ziswiler@toradex.com,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
References: <20180712073904.4705-1-stefan@agner.ch>
 <4098188.Bd2NGYzoJE@dimapc>
 <CAMdYzYpawoCQ_08aJr0XUNxY8C=K95gkgMbZNetcw1vrmDgpig@mail.gmail.com>
 <7096174.4n8ysn5QrL@dimapc>
Message-ID: <73510426-3b7e-cc7c-39db-4058bc6a4c22@gmail.com>
Date:   Sat, 28 Jul 2018 08:03:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7096174.4n8ysn5QrL@dimapc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2018 6:13 AM, Dmitry Osipenko wrote:
> On Friday, 27 July 2018 23:19:53 MSK Peter Geis wrote:
>> Kingston KE4CN3K6A.
>> Though I am pretty sure I've figured out the instability.
>> Brought it in to work and hooked it to a scope.
>> Couldn't find clock, but cmd and all eight bits are running at 1.2 volts.
>> Repeated the results with the bootloader, the original kernel, and my
>> mainline.
>> Also noticed that even on the slowest slew rate there is significant
>> ringing and overshoot of .15 volts.
> 
> Okay, but eMMC is working fine with the original kernel, isn't it?
> 
> 
Correct, at roughly double the speed of the mainline kernel.
According to the mmc spec, in high voltage mode it should have 2.7-3.3 
volts in, and the minimum signal voltage should be .75 of that, which 
equates to a minimum voltage of over 2 volts.
For low voltage mode, it should be 1.8 volts in, with the signals being 
between .3 and .7 volts.
Signal voltage of 1.3 volts is .75 of 1.8, which means we have low 
voltage in, but high voltage signaling.
This is even with HS-200 or DDR-1.8 assigned in the controller mode, so 
for some reason we aren't switching modes.
The original kernel was running in SDR 25 signaling, but didn't try to 
switch either.

Digging through the old code and the TRM, there are three ideas stuck in 
my head.
The original pinmux driver had settings such as low voltage divider and 
two values for each pull direction.
The pinmux driver is io resetting specifically the pads we are using, 
dumping any values the bootloader had set.
Is it possible the tap configuration is not working?
