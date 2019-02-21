Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C326C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037C72070D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJgl6HiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfBUOZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:25:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34767 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUOZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:25:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id d15so7114034plr.1;
        Thu, 21 Feb 2019 06:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjUCZbW8bmkY+Q7OIqg4LCUzihch7VJW4qV9lxw5JH4=;
        b=WJgl6HiQr2nsUaTom4At8Rv8uL77Rw4vorK/d5D3kG53vtez4b4KwNQcUtX1yBqW6H
         DOjRQlfqhpA6t4EQuECyR9UF0P3SDGVqlkHH/xgC0A2KZelLvdoLLfZpULhYfcjsg9wx
         bbNLNVOeVfD69ZboaWJC/kiPkj596IqUHOxUQEfybwKDdNFrPKEPD3tSeNI1bThKmR1p
         FOsqDJTo/kkhRggC+9aGWkQxBx4qWd4sk6OPCIOFYxrOoLvSVLHyNNaOEQr9Qvy+bgKL
         FCx6oLKxXbN6F6JX7FJdbVocb6JNq0pkE8XeXY8NK/JFWt2zvijj1Pxzg8YLqfbnrWIi
         4OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjUCZbW8bmkY+Q7OIqg4LCUzihch7VJW4qV9lxw5JH4=;
        b=nipvFfdg3TWcRansyuVaDiPRTcy0gdvuN6CS8pQgnwq6NjwkHQEZeJDD7am8vquaNI
         1jXekySpGZZ13+CpX+9TMsl+vFOGAZe8Jm7EKkqapHeTEod+hLmtZV5fMZ1POIfo1K43
         Cawi8x3TNSJhDxPrk6EmNR4TQph/U2X/20U62fZXoHoo9pkq7qwdF/Y4DiCTGu85mQBU
         tjsp5VxZ9fsIS6BBqVG9Q8xWTPpVTQwXcpjHOlNkakoYYho5aCvAB8BLRH04/I5XulFO
         nPnJCw3HXL7S9Z/SfRnSDQfaLF6S6gYfcL/ZTJHKYLYd1m1Iz1CEHJrbg7mno0RopHS0
         lS6Q==
X-Gm-Message-State: AHQUAuaOExIGuFJpaOsjnREppxgAnYFcgLcGwZY9eEl43LUEE9DODJop
        zYa9OzLS+io2G3YdvDgL9P+l3gMifVBLMbR1PFM=
X-Google-Smtp-Source: AHgI3IYkHpJvwn+Zp7BT5M2Vq9+pzj4DLYEUzsg4/24OW9/hC874s84ItarR+Y1t74N2soIS9k3/6WBNkuU+GRrculY=
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr32539153plq.144.1550759121760;
 Thu, 21 Feb 2019 06:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20190214115712.19642-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20190214115712.19642-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 16:25:10 +0200
Message-ID: <CAHp75VcdBMVgDxuJKyiw5n9UZr7w0u+zz73GAUnRM6Y9C-=r0w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] ICL support and other enhancements for PMC Core
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 1:56 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Changes in v3:
>  * Dropped reference to coreboot project as suggested by Thomas and Boris.
>  * Rebased onto "for-next" branch of pdx86 tree and dropped previously
>    accepted five patches from v2 of this series since they are already
>    present there.
>  * Fixed checkpatch complains about 75 char limit for commit messages.
>
> Changes in v2:
>  * Addressed review comments from Thomas
>  * Added tags revieved
>  * Folded in SHA1 suggestions from Stephen Rothwell, though Andy might
>    want to fix it via rebasing
>  * Rebased and tested with Linux v5.0.0-rc6
>
> This series:
>  - Adds ICL U/Y CPUID to intel-family.h
>  - Enables PMC driver for ICL
>  - Introduces a new "package cstate show" feature
>  - Fixes a customer issue related to S0ix on latest HP laptops
>  - Fixes some minor bugs
>
>

Pushed to my review and testing queue, thanks!


> Rajneesh Bhardwaj (5):
>   x86/cpu: Add Icelake to Intel family
>   platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
>   platform/x86: intel_pmc_core: Add ICL platform support
>   platform/x86: intel_pmc_core: Add Package cstates residency info
>   platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown
>
>  arch/x86/include/asm/intel-family.h   |   2 +
>  drivers/platform/x86/intel_pmc_core.c | 144 ++++++++++++++++++++++----
>  drivers/platform/x86/intel_pmc_core.h |  10 ++
>  3 files changed, 135 insertions(+), 21 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
