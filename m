Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71846C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410C12173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZjKSfRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfAJHCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:02:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46609 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfAJHCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:02:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so4873266pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/SyfjbwGy/QygpYRjigRDd9BXY9IdRNQrb8Sp+1O7Y8=;
        b=UZjKSfRLRxgzPAj+oEH2DIYUMNrzymr9xCH0pZZmJq28w1qVfHTJgoI5HlEFedOhQi
         JxAzE/cl59lh+RX8u7jR3akEwyQRecEZYbUTdkP25a6buKS3KQTrN26HQ382ExU8qfbu
         /CuU5p9T7+RQW+Pk+M133x0vQbDlEAkpip420=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/SyfjbwGy/QygpYRjigRDd9BXY9IdRNQrb8Sp+1O7Y8=;
        b=N4bTPMlfyYIaLcq4TJQQmhenyCZrftaKflo5epHYpa+PJ3QSroFigrw8t+z2nyY0AG
         /5fUZtKUpnz9spA1BeqbaOtqwo1DCVLlVyiukFDgvR4amU7NBtNRn0zP2Ro1P2YOCUJQ
         zsgvqmRn5Uff3O/nZp6d/z1aKSuAAmxQ80PevOx1+4aLJJpY5Vyc4QC3fDd6K9i3qtNz
         17vvesVFoR63AVsajab0Bgq3ZcSVxIyWoidcwSnfL470JL39oIZoB0ysul47gHu0NSjI
         Lhc5VGTY1cFppz5OfhBHAeGWnakIPfsB73J6sCGZOS1ZW2tNV9HFimfQkethgvUd+Juc
         WfeA==
X-Gm-Message-State: AJcUukcATFN9epgHk6DaIJ+EANbjBUiGy4NGR1oZtu7UUdHT3dtCR3E+
        nRlgBSFLfc+UKrD+7EO/PcVuMA==
X-Google-Smtp-Source: ALg8bN67gw99RMCWWtK05E04VP1vNKlzv8yiUt6z4sDNWLwtopNrU18MAbpbaewIOWG4qNBHZgqq0w==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr8269770pgs.448.1547103731601;
        Wed, 09 Jan 2019 23:02:11 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id m19sm229740451pgn.35.2019.01.09.23.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 23:02:10 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:32:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Message-ID: <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-19, 21:05, Paweł Chmiel wrote:
> This commit enables cpufreq support for all s5pv210 devices.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
> index 951196bdf008..fd4f28aabda6 100644
> --- a/arch/arm/configs/s5pv210_defconfig
> +++ b/arch/arm/configs/s5pv210_defconfig
> @@ -11,6 +11,12 @@ CONFIG_ARCH_S5PV210=y
>  CONFIG_VMSPLIT_2G=y
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> +CONFIG_CPU_FREQ_GOV_USERSPACE=m
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

You don't want to use schedutil ? That is the default governor for
everyone now a days.

-- 
viresh
