Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2651ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3D52086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gstTR8cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3D52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeGUXS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 19:18:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40498 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeGUXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 19:18:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id y200-v6so4005998lfd.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrKuTIMMg25n5Bq7wz8lgYOEENingMXIGNHZaIrAab4=;
        b=gstTR8cKokjM/zL178po2KLaPfOg3+nN3G2Ux/m6Q9wyo5sxZEBsOxRPvW5DiMtEsR
         B7l7tQR3Tel6YriMjKIfJMOO3U9/GqESSNKlS+uq5Tt1ogEfeiq9icGRmcR0htJmp9g8
         arwN1bnrtIDyYPBvAjPYwA2TfMvlVBP6QU0mAZdp+VH4ptCuUeRuh6bJlC2Zh7s0Xx0I
         sG1fqS6X+BEpg9OF5Xr61V/0U9ZDzbxffreIGcHqsck0+jeK4K61xCGzGQLSHMNI3hPm
         KFJS72JR/LeCxx7FDRtcgiNZUVIWrksSM1wugHC+x+IoEjpciH2/Y7vEVH5HtUIH4vzd
         a2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrKuTIMMg25n5Bq7wz8lgYOEENingMXIGNHZaIrAab4=;
        b=pfsMHhXHoEXJNtfbIcwRy0vee98SYNOZMJCGrlrMJ7apl+76ZO3wgBURNXEGPI4YuW
         g26Zj3bImtn9MbDWgC+zL94IbvAvcPJDOn22KgxKufEM7uvLZjEnE+Dl6JXfyAQWeDb+
         rncBQEmdekTZ06Du0xWAooDSGXFfWVTOMFUat5TLYTZTWHvYBPOWzWJlg61c1vDGszWE
         shpHj3HqQ3tVpq5eQ7ZOMIVmDyuC7UyWD4ChW2/epQ/Ha6TJolE1pKlNZCrt+Yo5bnTJ
         quW2idPxAzkFKDQhvnwHh2VTnT4lSxNj4Ml9SgIf3K0E9am5ey1tp28tRVZ1YVVrtIGb
         WB+A==
X-Gm-Message-State: AOUpUlEaClZuukbx9pYx5k4ZyNke8fRoj75Yw7F2wmfMhPyXEKH4YXaj
        KnGC7Ci9NQ4E0EYTfUYJS3LTN+Nl2PDwiQ==
X-Google-Smtp-Source: AAOMgpeOuibVcxDGemne4h0cy0jK+aqkmuRebU+zdmC66louA3jrHt9p9TxU1ZEev8k2IbtS7rN/0A==
X-Received: by 2002:a19:ef13:: with SMTP id n19-v6mr4321091lfh.48.1532211879176;
        Sat, 21 Jul 2018 15:24:39 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id o74-v6sm798458lfg.31.2018.07.21.15.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:24:37 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:24:30 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL 3/3] ARM: uniphier: UniPhier SoC updates for v4.19
Message-ID: <20180721212430.odjwcusbbihffo6l@localhost>
References: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:05:03AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Please pull UniPhier SoC changes for the v4.19 MW.
> 
> Thanks!
> 
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-soc-v4.19
> 
> for you to fetch changes up to ae93e694440a454609fa40725e16619c5a781768:
> 
>   ARM: uniphier: remove empty Makefile (2018-07-19 06:53:16 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC updates for v4.19
> 
> - enable ethernet and thermal drivers from multi_v7_defconfig
> 
> - select RESET_CONTROLLER
> 
> - remove empty arch/arm/mach-uniphier/Makefile
> 
> ----------------------------------------------------------------
> Kunihiko Hayashi (1):
>       ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE

I renormalied multi_v7_defconfig for 4.18-rc3, so please base your branch
on that to avoid conflicts.

Also, we separate out defconfig updates to branches on their own. I can
cherry-pick the branch apart but wanted to check with you before I do
so in case it messes up your workflow. If it does, send a fresh pull
request for SoC, and either one for the defconfig or just the patch and
we can apply it directly.


Thanks!

-Olof
