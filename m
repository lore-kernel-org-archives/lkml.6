Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D392BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6806218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="D3w8BkUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeLaVev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:34:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45481 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeLaVeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:34:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so18830540lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f7ekWYqy5/KTumZqr5dhtGpNMgtrKB2/mXlF00ljUuw=;
        b=D3w8BkUZn/F3BSbpPqF5pOccBzomDqSYWsjuaHwVvxiwmMiuQncd8jW857YBjyuX+3
         fmX2KqDD8wGdYJI6g1dEPIyzQJWAYphqnyxfZ5dNKSWq1M2y1yGc58WglKtU9SAQ97+c
         UCs19wBt5NdwfQAuDnYbEcSzqvBu3eLaDczasK+/I0czAbnLd/eF0il8K8GxIQgQ19Ub
         VO9Vi5Pr/cdFrLHfYHfXkt0qRL7FbAazznBMbMrCeOglz/LnpUs7hlGBedBgG3pBT+hv
         V2RM5/hwuwSlVgQwq/K+zCoQa6b5mHroZhvcusBHSUJa5OqSMztXDK5/gkLUuYgwaTm7
         bc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7ekWYqy5/KTumZqr5dhtGpNMgtrKB2/mXlF00ljUuw=;
        b=BNmnBqQ8gIjEAHK75m+KHUYLboT6vYIybmkm4xz7sRprs236otgrc2/Lto/R2G52F1
         9yC86DhMzUq5xW4aj6zzpV8WmC3C8OvRA23nEr4zUr0nkoyGzl8WHpVle3gNE94Q1ByG
         Up7RrJ5JDJnBQm3v+bQ9Mgl/R9hy5eKYYQh6x4vF3iw1tz88qbsfC0YJavVRwoK9t80J
         cH3IxDvmbdMd0SPoRzuKiSw2UKsmw43NBDUstousIc/b/ew7hVPgavNMLo1P8/axMrR3
         XGVJzQv6G9UQ/OBmEW9FxbGmyoVzxLttBPozPmMVOtrauI3vPDnGxSmMlBbXhgLUD3SR
         oBcw==
X-Gm-Message-State: AA+aEWZWdJoshU2oedzrpF2D6bxGPALbsgUglBRgF3Im00LV+wzwlygO
        ZBepzNer/McEk98Ut6+G+TstW4mARTw=
X-Google-Smtp-Source: AFSGD/XiM4gr+YlIsFu1cLG0Jhz2Kwm2YOvsmLVfFJHX0FwP5IzmZ8meBbnrSwmxU+qmuufK/S5zOA==
X-Received: by 2002:a19:a086:: with SMTP id j128mr18090675lfe.93.1546292088168;
        Mon, 31 Dec 2018 13:34:48 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u11sm9509341lfb.85.2018.12.31.13.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 13:34:47 -0800 (PST)
Date:   Mon, 31 Dec 2018 13:10:50 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/2] ARM: dts: exynos: Second round for v4.21
Message-ID: <20181231211050.wlcmsppq44tbhf7n@localhost>
References: <20181218201003.12806-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218201003.12806-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:10:02PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:
> 
>   ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21-2
> 
> for you to fetch changes up to 8ac686d7dfed721102860ff2571e6b9f529ae81a:
> 
>   ARM: dts: exynos: Specify I2S assigned clocks in proper node (2018-12-13 21:56:07 +0100)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.21, part 2
> 
> 1. Add missing CPUs in cooling maps for Odroid X2 (missed in previous
>    round of fixups).
> 2. Fix clock configuration in audio subsystem on Odroid XU3/XU4.

Merged into next/late. Will try to merge this window, best-effort.


-Olof

