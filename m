Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A20C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02AE222D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGGNe2M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392322AbfBMPdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:33:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44895 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbfBMPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:33:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so1312747plq.11;
        Wed, 13 Feb 2019 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcmksHWGwSDXOrKAmTNKeWMLBrZoin/0R2U8zaZjtfM=;
        b=QGGNe2M8ZpVaRZDHTuxtVY/7HkJzKR/ECoksK7XhNo/3cZbRTIelasU8jZAXhSv9rJ
         6d+o+n8kIQ+bbegsurMol1BtY+LDVkXcBJncgWdmqmbDQMMkGLhZn3dMKkEF5kM7YJza
         hjFL1UpD/muK6uBB8yyFZvz3AmpwYCRc46gRqSoKGMQ76mAe5c4S6JnH4HEko/O1V7fv
         gyuu/9lNjapNQTRkiS02Ep8SBOmRWvLKRk2u8Ge30rsFlMnnyHrnsFMx9Lsq1Vbx2vLU
         viy8xv+pnz0Vd1D6iPiy0cPq6EUTF715VMZver8TwIVD4meKGPHgWAxk0Nj0FxS7bR9Z
         q/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcmksHWGwSDXOrKAmTNKeWMLBrZoin/0R2U8zaZjtfM=;
        b=IWh8yOZR48GIAgSqFC2MsnThKjOZwIBNsR9caXHQPPCROo67FXPsUnx9UStf+6uWI8
         orpqIMaHaS3aSgHkOcR/Q58uIlz1L71SYkOeIarimXSBqPchrm2vak4CWCo8qJCSGx5F
         dii3Bg8l9yqukmKADwcKa7z81HGjOJGLVTp+qAxxRIXSrWzSEhOY9ofhndryD5couijG
         Zj3Mja6NbLJKiM8plg4iTZHn1BtCHt6EoFGh2sdDX4RaPfgPxygiIsXYAFrNy81O99yb
         C5KWKI09yJrUjwQemng9wKXaxC2oC8twgRzcZ0mqkAi35Cp1HwfuKbP8G9xXo2QhNLBU
         FmEw==
X-Gm-Message-State: AHQUAubJN792V70qB9/Cw3JT1zRimlS9oJpCFON7RMqvX+gKx5vqEas5
        uriMWJOL4vVq9p77tjMvtSdS4ovR3hMDBxgIGCU=
X-Google-Smtp-Source: AHgI3IZV1S4T7d5TzqSTun50KB7H4nd1C+uQyhoxoqisLCvJhTjtr/CQCrATuELnddE26UvJ9nRqKV3f9uXyd+DAjLU=
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr1150750plb.12.1550071991664;
 Wed, 13 Feb 2019 07:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Feb 2019 17:33:00 +0200
Message-ID: <CAHp75VeTwjbdjAXPZfB5B7oataarjG0epV1SzokdYnCj8xcPhA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ICL support and other enhancements for PMC Core
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

On Wed, Feb 13, 2019 at 5:08 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> This patch series provides Icelake support for PMC Core driver and while
> doing so it introduces the Icelake Mobile to intel-family.h as per the
> CPUID from below Coreboot link
> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
> and provides some fixes and enhancements to the driver.

It's not applicable to my tree.

> Changes in v2:
>  * Addressed review comments from Thomas
>  * Added tags revieved
>  * Folded in SHA1 suggestions from Stephen Rothwell, though Andy might want to
>    fix it via rebasing
>  * Rebased and tested with Linux v5.0.0-rc6
>
> This series:
>  - Adds ICL U/Y CPUID to intel-family.h
>  - Enables PMC driver for ICL
>  - Introduces a new "package cstate show" feature
>  - Fixes a customer issue related to S0ix on latest HP laptops
>  - Fixes some minor bugs
>
> Rajneesh Bhardwaj (10):
>   platform/x86: intel_pmc_core: Handle CFL regmap properly
>   platform/x86: intel_pmc_core: Fix PCH IP sts reading
>   platform/x86: intel_pmc_core: Fix PCH IP name
>   platform/x86: intel_pmc_core: Fix file permissions for ltr_show
>   platform/x86: intel_pmc_core: Include Reserved IP for LTR
>   x86/cpu: Add Icelake to Intel family
>   platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
>   platform/x86: intel_pmc_core: Add ICL platform support
>   platform/x86: intel_pmc_core: Add Package cstates residency info
>   platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown
>
>  arch/x86/include/asm/intel-family.h   |   2 +
>  drivers/platform/x86/intel_pmc_core.c | 155 +++++++++++++++++++++-----
>  drivers/platform/x86/intel_pmc_core.h |  14 ++-
>  3 files changed, 145 insertions(+), 26 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
