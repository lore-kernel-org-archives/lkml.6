Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C30C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB6420869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnu/WU8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB6420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeKSI1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:27:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41702 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeKSI1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:27:38 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so19951552lfj.8;
        Sun, 18 Nov 2018 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+5crFy8x4lLcQPdp4EC4QpQC09Uwsuwl44ZjaxhNCI=;
        b=hnu/WU8yin1OnK1GulKgcsc7XHunmdMgLSJ+5C2iIRUiq5M9lioBTOgtwV/NK5wFKM
         YPqZ4xCopvIcvbkwLJ82v0JhM6o0gqZ/puhg0S7fL7KKFBjVqg0QZip/Uv5jllZes1Vj
         +CIr1JSj+CvVA9dQo228zyyWkyIT+ESSBqXnNVAbKWgmrrbgwBZViTcvp9qKMWUONXqi
         VUCRoeW5JGUT3Cj1xGQ+Xr25HiJDktiAfd/grJFuFo5ivgrx1OSVGG3mGG1FLhsLZaoU
         odEaWa7KqSrpV6166CsYHkx2729yBMTSZ2awqa01YSJQztB1FAWkGo5Jkj6IBactCDST
         e6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+5crFy8x4lLcQPdp4EC4QpQC09Uwsuwl44ZjaxhNCI=;
        b=qNpmzN+THy9/UqGNFcoFlf9aQ9EQA2FKPhX2ba7hUf8nB9f1uYsKdXFpKwdc8zyV8A
         albIVvYlnfTHGND+ZWv8o9PKBGRRz5psCFpFEG6rPC4wyIsE/NMVOLXtjIMSnLdx5AQQ
         xBWeXZDTburqinBPMpEvlkoyeXLBsnjxAbFYAQxICzrn+PnBZcaiQ+RWB/tCPNyVyYu7
         XLWU6wiOqoM6BA1jq2AFJJNr5/5q138r0ltfyNLz6S+CbVF1auX90hLo67Ma6Z0E4bKH
         pqFevUhSVKTCqVhZ4++NrgIhEvr1BZFmaPUNSFWRo6tw09NgMAVgWA64gB4O4bY6ijJ1
         tBEw==
X-Gm-Message-State: AGRZ1gKYjVzk2G647hsJ4/5b2ISFxvFEsEvxNCV+PSLXtH8KA6izV++W
        eFFpl9yv83sOX6MDuNlvDtmoyyWh
X-Google-Smtp-Source: AJdET5cCQhBa4/O7NMOhPi0uVLAjKKilYR2TIKi76zIAlmXxzQMBOuImYWYBmH30/KQVtJTylwGxWA==
X-Received: by 2002:a19:c014:: with SMTP id q20mr2920630lff.16.1542578765454;
        Sun, 18 Nov 2018 14:06:05 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id q6sm3312070lfh.52.2018.11.18.14.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 14:06:04 -0800 (PST)
Subject: Re: [PATCH v1 0/4] EMC fixes for Tegra30+
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
Message-ID: <d1f577d8-a944-35b6-89b3-ce4eafdd4808@gmail.com>
Date:   Mon, 19 Nov 2018 01:06:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20180830185404.7224-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2018 21:54, Dmitry Osipenko wrote:
> Hello,
> 
> This patch series fixes couple bugs in the memory self-refresh code.
> The EMC / MC state is properly restored after patches being applied,
> please review.
> 
> Dmitry Osipenko (4):
>   ARM: tegra: Fix missed EMC registers latching on resume from LP1 on
>     Tegra30+
>   ARM: tegra: Fix DRAM refresh-interval clobbering on resume from LP1 on
>     Tegra30
>   ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+
>   ARM: tegra: Clear EMC interrupts on resume from LP1 on Tegra30+
> 
>  arch/arm/mach-tegra/iomap.h         |  9 ++++++++
>  arch/arm/mach-tegra/sleep-tegra30.S | 32 +++++++++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 2 deletions(-)
> 

Hello Jon,

Could you please test these patches using your testing setup? Will be awesome if you could give t-b/r-b to the series, then there should be a better chance that Thierry could apply it eventually ;)
