Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6134AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EB420881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8WLr+F0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EB420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJOUUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:20:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36404 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:20:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id d4-v6so13957177lfa.3;
        Mon, 15 Oct 2018 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A52edW9Mv8otwfDK+/EggKbshMMHNGURXTfbMPVz1Pk=;
        b=p8WLr+F0ZLMASUHsM9ojmD4joousvpjjptffab5qPVZoLFpRZZUEX03RJEGURWzxvd
         IsucQqu/gtSXiXP7N1lBaxgqNH88T44a0rkyX2UPXW46SpIGV2QapqlVWMj+QUk4WYat
         PC7frgxIRLc74xffJhGY86Sfs28Y3sYpgcRFVtZ0+T6JoJ8VDLhmi+TRuFo9Mz6CcSr/
         AZj6A6Dh7r5kautvnQuCQgPb0Vi+Xamry4zvVdN1qUhWLnMxmaCIuMLZp/Njgb1RAhMB
         kyUnr88Kt1Z7DhaPJJV9QUJtrmrItsaZ9bRWrAQI3k6UMF3fnniQOfkrTX93SBVvMf4O
         2QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A52edW9Mv8otwfDK+/EggKbshMMHNGURXTfbMPVz1Pk=;
        b=B84zjufvVQWFUamtBrhB9UmUa7UEq9r/dj3E3PvtOvFOJXs4WunIpBTqPzW0cYsIfC
         fWcJfpV+NqBTfpW/uXeBB+X2W3Z1XW+O1CVk3IoVnb2HLRvoRFgcoDfc0dylSkRkL1hL
         HDioRqi2j+vyrsrn1lwpXsoeouqv1/fFAZFlm1KbWUcTOJa0b4pOVFjzSuWHKRtu689f
         dWNHe5rWl+vuVFFSfCr/UuZ3N0dfd7pYVPuZmJk+Hwf4pDKCAsmTOVHplD2gBn2ittmB
         /wakve3L3h8QP4n7GTzciMdZXlkA9Kdn5lJxhd0/dCfHrpFkWiIiZ6PGEmR1D6Ckgh/d
         YqkA==
X-Gm-Message-State: ABuFfoggVb66iXVcfcYP1Gf1pMd2b86iaWFFoaMeHf8VAlkmZe/5CvWl
        rPeThkZfv/U5uIbIV6RmcbtrDw3r
X-Google-Smtp-Source: ACcGV62ylTe/AQBv4S/7LNyia+z4MgzX5scYR4tAr3+5f1ncavM2w0ZgL+AEn2MMu5VB64mh0Qr0Gw==
X-Received: by 2002:a19:2095:: with SMTP id g143-v6mr4144982lfg.62.1539606901741;
        Mon, 15 Oct 2018 05:35:01 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id l14-v6sm2401037ljc.68.2018.10.15.05.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 05:35:01 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Support Trusted Foundations firmware on Tegra30
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180830180421.6415-1-digetx@gmail.com>
Message-ID: <91e4af24-7be7-2dbc-577b-56a852cc21ff@gmail.com>
Date:   Mon, 15 Oct 2018 15:34:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 9:04 PM, Dmitry Osipenko wrote:
> Hello,
> 
> All consumer-grade Tegra30 devices, like Nexus 7 tablet; Ouya console and
> others, use Trusted Foundations firmware that doesn't allow CPU to access
> secure registers directly from the Linux kernel, these accesses shall be
> done via the firmware calls. This patch-series adds a full-featured support
> of the Trusted Foundations firmware that opens the door for supporting of
> various Tegra30-based devices in the upstream Linux kernel.
> 
> Changelog:
> 
> v3:	- Implemented suspend-resume support.
> 
> 	- Reworked arm/firmware/trusted_foundations.c a tad. Now cache
> 	  is getting properly initialized, cache enabling / disabling is
> 	  supported.
> 
> v2:
> 	- The "Don't apply CPU erratas in insecure mode" patch got some
> 	  cleanup, in particular resolved the messiness in
> 	  __tegra_cpu_reset_handler_data.
> 
> 	- Added a comment to tf_cache_write_sec(), justifying the warning
> 	  message.
> 
> Dmitry Osipenko (8):
>   ARM: trusted_foundations: Implement L2 cache initialization callback
>   ARM: trusted_foundations: Make prepare_idle call to take mode argument
>   ARM: trusted_foundations: Provide information about whether firmware
>     is registered
>   ARM: tegra: Setup L2 cache using Trusted Foundations firmware
>   ARM: tegra: Don't apply CPU erratas in insecure mode
>   ARM: tegra: Always boot CPU in ARM-mode
>   ARM: tegra: Support L2 cache maintenance done via firmware
>   ARM: tegra: Add firmware calls required for suspend-resume
> 
>  arch/arm/firmware/trusted_foundations.c    | 80 +++++++++++++++++++++-
>  arch/arm/include/asm/firmware.h            |  2 +-
>  arch/arm/include/asm/trusted_foundations.h | 13 ++++
>  arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +-
>  arch/arm/mach-tegra/pm.c                   | 43 ++++++++++++
>  arch/arm/mach-tegra/reset-handler.S        | 66 ++++++++++++++----
>  arch/arm/mach-tegra/reset.c                |  3 +
>  arch/arm/mach-tegra/reset.h                |  9 ++-
>  arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
>  arch/arm/mach-tegra/sleep.S                |  4 ++
>  arch/arm/mach-tegra/tegra.c                | 10 +++
>  11 files changed, 216 insertions(+), 21 deletions(-)
> 

ping
