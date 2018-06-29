Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD0C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E670A27CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQaFHepC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E670A27CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936216AbeF2ThI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:37:08 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32972 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeF2ThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:37:06 -0400
Received: by mail-qk0-f196.google.com with SMTP id c131-v6so5576452qkb.0;
        Fri, 29 Jun 2018 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G/bEj1tvjOwF6238T44mzMc+sN9xxfx7TWbTpS5SYus=;
        b=IQaFHepCdiXnApfKFRScTQc9xv37ifEXSpO6tlynBWkZ5esG+QSQN+kIGzhPhxnaLq
         U18xRXb/RVhMp+dHmNOM/rGyh4uEH7SGyfHgaNtFR4NiMcwDxAnireio20GnTuD33DIq
         IiND57act3aab0Un35Y+VjKgxi/t7/4uK7Q/r+nmfFBcWlxb05mU7fWVGMaI8SdyYPMR
         OVrOVHn0eMe8cMYmFpBDitoUjjCNTkuo1QOk9wo4CASe1Qw/yQ0DE0/l4pNuPZcFfxiH
         /9JK3FuqckYhHIae0slPhwAEBdAGY+HSHjjOsSZwAxHGYoRbgFQsc92eupyzAExk0yH1
         g1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G/bEj1tvjOwF6238T44mzMc+sN9xxfx7TWbTpS5SYus=;
        b=ErxVha//xFR5R19zcrg6kUrFH3YcYkj5eMsaFQLJh/Hw3IY1AYwe4XWv4nGUGt1LbX
         RqcdW84NhitepALJm/buRGcnuBr5MZPHvbQIjduhiu3uHrWRi/vJvGQARPtNBtlUq1th
         fBrjtscKyyHwdUMMrLRZ4CQmNaTx1Yu7ZBS+gvewOTzxIWSTsMxgKYZi3NE3RyA6P6LI
         8yYLC673DChno1i9o4T7/Wb5UAvaPidG1w5Lq6oDOkDVwVoIpJbW8UaGbthAszw5urKm
         wbd/aLpVArU+/imTKHVTjlBORmhHeOvRD5+CLOOypU9dLmmHaa8JtG3y2FR1beVLj0dT
         6yuA==
X-Gm-Message-State: APt69E0K5rh9c0Rj6sjrzquiO2NUzKyVkHpy9VzfdpcDL+P+C9Ud3FdI
        wE6CzgmOH25Zdo7LAQ4SKRD6FLoHJpw=
X-Google-Smtp-Source: AAOMgpc8ITsLjbJH/m4NiMX4uJEH1N6pMs2ql5pCJFvDeYj6SQukEABcKV9OadLiddBJBmkyBp1FDA==
X-Received: by 2002:ae9:de41:: with SMTP id s62-v6mr13460339qkf.145.1530301025344;
        Fri, 29 Jun 2018 12:37:05 -0700 (PDT)
Received: from [192.168.44.96] (88.sub-174-226-16.myvzw.com. [174.226.16.88])
        by smtp.gmail.com with ESMTPSA id l25-v6sm5999740qkk.49.2018.06.29.12.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 12:37:04 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
To:     Dmitry Osipenko <digetx@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20180619110027.16935-1-digetx@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <d99935be-797d-4676-c186-a045a590f01b@gmail.com>
Date:   Fri, 29 Jun 2018 15:37:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619110027.16935-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon,

I have tested these patches on the Ouya T3 device.
They work great to enable the L2 cache controller, however they do not 
respect explicitly disabling the L2 cache controller via the kernel 
config nor device tree.

With CONFIG_CACHE_L2X0 disabled, but CONFIG_TRUSTED_FOUNDATIONS enabled, 
the L2 cache controller is silently enabled and allows all four cores to 
boot.

One must also disable CONFIG_TRUSTED_FOUNDATIONS to stop the L2 cache 
controller from spinning up.

Tested-by: Peter Geis <pgwipeout@gmail.com>

On 06/19/2018 07:00 AM, Dmitry Osipenko wrote:
> Hello,
> 
> This series of patches brings initial support of Trusted Foundations to
> Tegra30, that is to the consumer-grade Tegra30 devices which do not allow
> to easily replace the proprietary bootloader. Support is initial because
> this series implements only a proper CPU boot-up (main + secondary cores)
> and a basic L2 cache maintenance that is done using the TF firmware.
> Suspend-resume support is missing yet as I couldn't get it to work
> (CPU hangs on resume from suspend after awhile and seems that is related
> to inappropriately done cache maintenance during of suspend-resume using
> the firmware), it is work-in-progress for now.
> 
> This patchset is partially based on the work done by Michał Mirosław [0].
> 
> [0] https://www.spinics.net/lists/linux-tegra/msg30368.html
> 
> Changelog:
> 
> v2:
> 	- The "Don't apply CPU erratas in insecure mode" patch got some
> 	  cleanup, in particular resolved the messiness in
> 	  __tegra_cpu_reset_handler_data.
> 
> 	- Added a comment to tf_cache_write_sec(), justifying the warning
> 	  message.
> 
> Dmitry Osipenko (5):
>    ARM: trusted_foundations: Implement L2 cache initialization callback
>    ARM: trusted_foundations: Provide information about whether firmware
>      is registered
>    ARM: tegra: Setup L2 cache using Trusted Foundations firmware
>    ARM: tegra: Don't apply CPU erratas in insecure mode
>    ARM: tegra: Always boot CPU in ARM-mode
> 
>   arch/arm/firmware/trusted_foundations.c    | 32 ++++++++++++++++++++++
>   arch/arm/include/asm/trusted_foundations.h |  7 +++++
>   arch/arm/mach-tegra/reset-handler.S        | 25 +++++++++--------
>   arch/arm/mach-tegra/reset.c                |  5 +++-
>   arch/arm/mach-tegra/reset.h                |  9 ++++--
>   arch/arm/mach-tegra/sleep-tegra20.S        |  4 +++
>   arch/arm/mach-tegra/tegra.c                | 15 ++++++++++
>   7 files changed, 82 insertions(+), 15 deletions(-)
> 
