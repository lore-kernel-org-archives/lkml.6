Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC76FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BD420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nra4ahcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BD420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeKJBPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:15:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53148 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeKJBPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:15:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so2404460wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 07:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7bPd0KFtrx4upiwcWVI3jqwhe/7maSjWHYHWiZrJWQ=;
        b=Nra4ahcR4fKM1vZmpMJ/hk+z6yYlK7WsEd9YB5DkiynHYKS1oxk5I/DnTqzP+tL+Bs
         9L5VCBWmuTKOn3dV4/pxW8nSMfzN7xgZEtOtoC2kMDbzKyNFVwSBIUdY8fpjGaEICEIP
         RG/8AogjozI2R6UmfoBRdNX1Wap4JQYMLA+fPCmdIcDxW4RL7G8Mdwtv4WoOEatti975
         AFiXs07LS3PZ/CaQmwbP8mLUwODH77YLcQ+VqqJu3JCrLMDywBMYDbf8N1RyzmwAWDhJ
         RO373sscIFN8hEtKwAYTmhm1Ywn4Aroa84EqlKYVeL+Tx/yNJUlUR1+B84oYQbrGC+aX
         uqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7bPd0KFtrx4upiwcWVI3jqwhe/7maSjWHYHWiZrJWQ=;
        b=fC62eSvwVHUcwZnav/hP+mKk0cXD9aBn9abdvRssGnHIV3EBh9YN1R/KhWTBzYKBto
         ORak9FX6ZGbttxTYQLPni0W1L80FW4swFTg117sWsibV95OUKx8T35xUydSIC7Fe9LSF
         zVaO+4fOiD9DbLG3slxNVzBXhTvX8DbXvCKiw2Uo19fPoLFSI0gNoCRV/mw4BKBYqMCA
         D1Q/zh/7v+ZtymK0Kcxrlwisxc7W1FZQhvTZFqTRZkmRKQf9Z80GzDfGc8i2c49PzYOV
         ig5BlDnUT7TC3fTNeTBsLFp1teOI85AWQM3GPX58Fcq7xGRbAiwIHRNIZo/BtEvw4uDR
         7y8w==
X-Gm-Message-State: AGRZ1gIRxhxC7sDk8ENjz467JN+CEMw9GZGSg/YlL1ZcCXj7BgbnVnKm
        ktBQrhMIg4BNtlgO0825yYUWpXYKnWk40NVGLWo/Pg==
X-Google-Smtp-Source: AJdET5fA8rFIkP9qKC4lA3L/Yl8QaxgEScFR6g1AikS0AxKEJv7GNMS7eKzK7/1rXwZfv5OEFUUkYO2vQd37dsG2Y4A=
X-Received: by 2002:a1c:cf08:: with SMTP id f8-v6mr5091797wmg.56.1541777667644;
 Fri, 09 Nov 2018 07:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20181109150431.14147-1-bp@alien8.de> <20181109150431.14147-4-bp@alien8.de>
In-Reply-To: <20181109150431.14147-4-bp@alien8.de>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Fri, 9 Nov 2018 15:34:16 +0000
Message-ID: <CAK+_RLmV2rm=7zQ6BeJxUg0x1K7Kwv7AfHXmJ=YEV6xQuufbVA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/microcode: Add SPDX license identifiers
To:     bp@alien8.de
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, shli@kernel.org,
        thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

Ok, that's fine. I noticed these things when changing BFS code a
couple of days ago and wondered what they were --- now I know :)

Kind regards,
Tigran
On Fri, 9 Nov 2018 at 15:04, Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> ... and drop the GPL v2 license free text.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: "H Peter Anvin" <hpa@zytor.com>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Tigran Aivazian <aivazian.tigran@gmail.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c   | 4 +---
>  arch/x86/kernel/cpu/microcode/core.c  | 6 +-----
>  arch/x86/kernel/cpu/microcode/intel.c | 6 +-----
>  3 files changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 07b5fc00b188..a1b02f2f0697 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   *  AMD CPU Microcode Update Driver for Linux
>   *
> @@ -17,9 +18,6 @@
>   *
>   *  Author: Jacob Shin <jacob.shin@amd.com>
>   *  Fixes: Borislav Petkov <bp@suse.de>
> - *
> - *  Licensed under the terms of the GNU General Public
> - *  License version 2. See file COPYING for details.
>   */
>  #define pr_fmt(fmt) "microcode: " fmt
>
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 2637ff09d6a0..b126180c15db 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * CPU Microcode Update Driver for Linux
>   *
> @@ -12,11 +13,6 @@
>   *               (C) 2015 Borislav Petkov <bp@alien8.de>
>   *
>   * This driver allows to upgrade microcode on x86 processors.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
>   */
>
>  #define pr_fmt(fmt) "microcode: " fmt
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 16936a24795c..e199d3140be0 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Intel CPU Microcode Update Driver for Linux
>   *
> @@ -8,11 +9,6 @@
>   *
>   * Copyright (C) 2012 Fenghua Yu <fenghua.yu@intel.com>
>   *                   H Peter Anvin" <hpa@zytor.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
>   */
>
>  /*
> --
> 2.19.1
>
