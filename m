Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA394C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54E620855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MhJlCtZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfBLQjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:39:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45983 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbfBLQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:39:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so3379856wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IStfnyEVlH5Lp4IQrqe3VAO+3M2GQyPHOtszOIzoekc=;
        b=MhJlCtZr+1abLtw0LVMWjPUH6XcN01ehUH/FL++z+m39HIBPf3kHz8v2MapsEzkxN/
         Mffatk75H0CbCRaEs3xvY4tX1jhfHLDiSE43Su9GYZ1Z4lFhp0zZOlwedznnqTCQcsY5
         U5Z5kTWEGBfFVsbfTNqdi3RP/uB+DexJdS27iHwg2mKeeIt8Za7yc2qSc7jNGWlZXZLs
         O+7l+h5jlYDkhehHAZxRSslz2dI7COkQVZDkWXyRYmFXoBEWhjWroS00Vty9HX+gFtZ4
         9AYnvkRF6XOOPeYtFTOGPVH5Gith3J5H3e0iJiGtcG5R+XAJn9k/2odT8mk63LWAfK7S
         Y+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IStfnyEVlH5Lp4IQrqe3VAO+3M2GQyPHOtszOIzoekc=;
        b=csFSIj/ph6gcui4lkbRnCu6N23E27Hcztmj+zo5mzGZK6UODVxRwKlMVOhWq5Naifs
         bRtMNom7nsHhFbo0sCoZKg2OaQfiF3XDDjHt9MSbLih/N9gbVByb1LOigu7FSgVkaYbd
         esX1zBScf567wqgITmNovuKT+PIPGWNtN8rN6SBaliHcj7sSrN7BVwYQF1pLFbgdkwqF
         r2tVwzq8FeDnV6fZy1sbUvjSWus/joyVwugcqrFy8Y3eRZR+O11XrmGIvSd/hHSB7BvT
         Ue43ax1ufq11vR3DF+9qO0w7V3muGnalfqbamy61F3KgT0uuixLgh6VEK1+oRUZgFNrv
         0XWQ==
X-Gm-Message-State: AHQUAubdaIjQtE/LJBwXsTQn+zVxuUFWft35zq7/MEMGX4e2QQnJ3hc0
        VBHFqR2ujTOgfClc7Hze1qY8ow==
X-Google-Smtp-Source: AHgI3Ia2D3oaJZb4N1cuvUBM5daLiB2g+GOg08d5PKD+rscN36mKriUl12+FhPURBe/PtW936DwhJQ==
X-Received: by 2002:adf:e342:: with SMTP id n2mr3469339wrj.60.1549989548010;
        Tue, 12 Feb 2019 08:39:08 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id n2sm8906534wrq.58.2019.02.12.08.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:39:07 -0800 (PST)
Date:   Tue, 12 Feb 2019 17:39:04 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        khilman@baylibre.com
Subject: Re: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Message-ID: <20190212163904.GA14668@Red>
References: <20190212153932.28371-1-Eugeniy.Paltsev@synopsys.com>
 <20190212153932.28371-2-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212153932.28371-2-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:39:31PM +0300, Eugeniy Paltsev wrote:
> Handle U-boot arguments paranoidly:
>  * don't allow to pass unknown tag.
>  * try to use external device tree blob only if corresponding tag
>    (TAG_DTB) is set.
>  * check that magic number is correct.
>  * don't check uboot_tag if kernel build with no ARC_UBOOT_SUPPORT.
> 
> NOTE:
> If U-boot args are invalid we skip them and try to use embedded device
> tree blob. We can't panic on invalid U-boot args as we really pass
> invalid args due to bug in U-boot code.
> This happens if we don't provide external DTB to U-boot and
> don't set 'bootargs' U-boot environment variable (which is default
> case at least for HSDK board) In that case we will pass
> {r0 = 1 (bootargs in r2); r1 = 0; r2 = 0;} to linux which is invalid.
> 
> NOTE:
> We can safely check U-boot magic value (0x0) in linux passed via
> r1 register as U-boot pass it from the beginning.
> 
> While I'm at it refactor U-boot arguments handling code.
> 

Hello

I have tried to test this serie, but this patch does not apply anymore on current next tree.
It conflicts with "ARC: boot: robustify u-boot arg referencing".

Regards
