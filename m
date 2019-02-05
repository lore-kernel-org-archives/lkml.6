Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F82EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F382083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agq6/Qtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfBESHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:07:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36411 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfBESHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:07:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so1835123pfc.3;
        Tue, 05 Feb 2019 10:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wt6hD0eCAsQc4zllEHco38QshoC/JGJZy0TCdJssmfw=;
        b=agq6/QtwmmkAXDskC28UNcbL5Fxc1bnNqlyTnkFGBn9ZI0aCO6X2gOY3n+11+Fd3xQ
         ZCIcb94t2Id7gSw4ynEV7VshZgI/jPJWAeHqBQEZuT9BfI/XqPZsMDepQ9eUB7Mdi+g/
         RM1sH2bSKhfVs3ACt5hvApfA/qDl9i+7FBNqlcjo8dD+scn5X3wZK9OUWADqqBNIltt6
         iqK/PAjTjlPATbPsBQcQ4Rvn+JyRVnAI2DiAZL9RJqgpA5SbZR9Xxp2US49rvhypMTcL
         TAPo3qyCq+fmn79g4d87Xv0RwQwrnLfdo2ZdiQn8YW6sgJhTYf6HV3tfc9L5XYsGbFO0
         5Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wt6hD0eCAsQc4zllEHco38QshoC/JGJZy0TCdJssmfw=;
        b=K8kNgCi5Mu/43vA322hpNt3TXiR9RmERNLJG1tCCySLrlyOMTHVsSIvzr877WVnG46
         uJ7GcdmonbUAV/SwtHRvl7/6mLayxOztcsr8yJjDZRTBdM5lv49MoUGX/gXapW9rRe9D
         MWTTrkzAYzq9EmvdEj46zsVGfa688AtewK45YdDZR9ba9qP5kYGZOu/R1YAC2LXb+IRH
         nTTpsFuiL0ibyuHTo0xxo56HEnByfltPpR9QCWZYZd0vr63GHM5H3ovCC7vdoRryFnFI
         Gmxqx02Ma//A1DcrzYkabLgaoG7wP8X3QM5xqMbKLc2vxnIhuL6WkylATKvZ0KhGHDdS
         Bvmw==
X-Gm-Message-State: AHQUAuZ0+Mv4Rjvv9cqlu7qndESoO9NOn77NoTJTiW8tC6grmBjAX0D+
        LCvrCZwP0mXZbn5ZS/d3IMXYWrQMAFY+Bfsku3s=
X-Google-Smtp-Source: AHgI3IYFkfvhtIrk33sRo7b9gtE/dS/+jmA9iK2iLTZyZbxBsHKu8m2viB8otmjg5+RvNsrf6fOtRNf32sO2+Y6oft8=
X-Received: by 2002:a63:20e:: with SMTP id 14mr5664042pgc.161.1549390021843;
 Tue, 05 Feb 2019 10:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 20:06:50 +0200
Message-ID: <CAHp75VeFBnQzv4dacZ0GPUwPYUmzFJvLC1qwVy8DqkST=b=hgw@mail.gmail.com>
Subject: Re: [PATCH 00/10] ICL support and other enhancements for PMC Core
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

On Fri, Feb 1, 2019 at 9:32 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> This patch series provides Icelake support for PMC Core driver and while
> doing so it introduces the Icelake Mobile to intel-family.h as per the
> CPUID from below Coreboot link
> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
> and provides some fixes and enhancements to the driver.
>

I have applied first 5 patches (fixes) to my review and testing queue, thanks!

I'll wait for the next version next week, based on what would be
promoted to our for-next branch and addressed comments from reviewers.

> This series:
>  -adds ICL U/Y CPUID to intel-family.h
>  -enable PMC driver for ICL.
>  -introduce a new "package cstate show" feature
>  -fixes a customer issue related to S0ix on latest HP laptops.
>  -fixes some minor bugs
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
