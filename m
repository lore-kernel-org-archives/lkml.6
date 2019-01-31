Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1383DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CF9218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm4uQQFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfAaSPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:15:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34344 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaSPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:15:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so3091577lfc.1;
        Thu, 31 Jan 2019 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f/oMRGD9sNchOOH3zynxhxInyyavQrcFdTpKC/79gJM=;
        b=Mm4uQQFb1g9meLS7rRPOhS/NN5+vnnKcYJv2Qk2ibeVgh+bW7zRrLTDiPu/TKRIzWn
         LltHzIT+iRZCQSs9dIDi4ninc3JXrmcRdDUjei6X9O1/TSsdoUtewlynkOpnhGRldx6u
         HJ5J27ClVbnWpQ66ZykvP3lSLS/f886CdqqaIkLot0w9uiG06r4nHweo+LAxRxp/weOT
         v/wBccgaJZUDuCTEYsWFJulyE266Ihnkycl4XxtN3S8El2jbWbgeVJNnphMd00JN0GId
         zNZUPIUbR0rMlrfv/9IOk7UauXYvvjudyZf+VfcZyU3C6ItV4LvmTIxw2P0fye+8IKSt
         lgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/oMRGD9sNchOOH3zynxhxInyyavQrcFdTpKC/79gJM=;
        b=B+AezmpytgTK83Vzqusje2PmhW16zooh+tv8bpflya70bJj7f8nxij9CsITrEnGqi9
         MGeRF36T3QeNLjH7wtQapXBMIK6UcW0y/b8/TNSE8URaYoD1zxpywOYaOeDz2m44jeXA
         RHobUCh+EUP4hEANkuM5GcRFsJ5ytm1vTjQvabUq6s+Zp2Ra0qk/OsHLg7rNC1qkqGjO
         T2sqZ1ZZkYoQSezNA/nNvBIKk1W/p0DTO06XTLTAG2n8DUzedqU9ADHCzf1XCbPqXZ09
         /XWzTQrZIrq4rnPu7AhVO84l/8LYo8RFr0kRid9mdzZsjCNG28F5jk6Ixf3DFmVyW3Bw
         +QcQ==
X-Gm-Message-State: AJcUukc4xcunSPMnqGynXurw9R61RnPu/3mLM5SUk8jbDmOpuCqXXfed
        dLlqqRYBO/rEK3McIs7jpjufqqi/
X-Google-Smtp-Source: ALg8bN6m4bJdbQnv1Jy244oVgfQNjtFuaJVx4IslYIVzymYtGPHwbYbiru6NXedKm2W+42vBLqfp9g==
X-Received: by 2002:a19:2106:: with SMTP id h6mr27596567lfh.29.1548958517337;
        Thu, 31 Jan 2019 10:15:17 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t23sm948406lfl.59.2019.01.31.10.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:15:16 -0800 (PST)
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <20190131120640.GF23438@ulmo>
 <0e832fa6-f143-7b24-2685-b88a55e77e51@gmail.com>
 <20190131144344.GP23438@ulmo>
 <bdb5ab9f-b047-6b9e-696a-8d6ef4065c77@gmail.com>
 <6c2909cb-f31c-921d-8449-79ec77c02d9b@gmail.com>
 <48135b67-eed7-9a9d-de3e-e400e8ef8176@gmail.com>
Message-ID: <7ddf46a8-ae98-c567-6d3d-8155989effb5@gmail.com>
Date:   Thu, 31 Jan 2019 21:15:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <48135b67-eed7-9a9d-de3e-e400e8ef8176@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 21:08, Dmitry Osipenko пишет:
> 31.01.2019 19:55, Dmitry Osipenko пишет:
> +config I2C_TEGRA_DMA_SUPPORT
> +	bool "NVIDIA Tegra internal I2C controller DMA support"
> +	depends on I2C_TEGRA
> +	depends on TEGRA20_APB_DMA && ARCH_TEGRA_2x_SOC
> +	depends on TEGRA20_APB_DMA && ARCH_TEGRA_3x_SOC
> +	depends on TEGRA20_APB_DMA && ARCH_TEGRA_114_SOC
> +	depends on TEGRA20_APB_DMA && ARCH_TEGRA_124_SOC
> +	depends on TEGRA20_APB_DMA && ARCH_TEGRA_210_SOC
> +	help
> +	  If you say yes to this option, DMA engine integration support will
> +	  be included for the I2C controller embedded in NVIDIA Tegra SOCs
> +

Actually, seems should be like that:

config I2C_TEGRA_DMA_SUPPORT
	bool "NVIDIA Tegra internal I2C controller DMA support"
	depends on I2C_TEGRA
	depends on (TEGRA20_APB_DMA && ARCH_TEGRA_2x_SOC) || \
		   (TEGRA20_APB_DMA && ARCH_TEGRA_3x_SOC) || \
		   (TEGRA20_APB_DMA && ARCH_TEGRA_114_SOC) || \
		   (TEGRA20_APB_DMA && ARCH_TEGRA_124_SOC) || \
		   (TEGRA20_APB_DMA && ARCH_TEGRA_210_SOC)
	help
	  If you say yes to this option, DMA engine integration support will
	  be included for the I2C controller embedded in NVIDIA Tegra SOCs 

But you got the idea.
