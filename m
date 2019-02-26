Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7843621850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKQxnJ/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfBZRSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:18:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37281 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbfBZRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:18:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so6518704pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOLLQFuNWZNcLbvoTKuul2PBnwLCZZV2yl5Rkby6ik0=;
        b=jKQxnJ/2x4dghTfRCCMI3Ml+fWRz4qrTqCcicLGZ011UNcos0yKVjUpXrkbq1VSVeW
         thw1sbzK7pCfkew2gQKrUI4Um5IJtqCZYZl1rRF7/8YMUzhpPVGNh8aOoaGrih+yhLcy
         LCoJSquWccU9cGAkJnes4V09W4/XvNYzxNcibfJSCuI99Gg6RPHY5pmjvUZ1DuZqFDit
         ziJwyd/cyIJEi3eTWqcjGCyQMJaZAOTApXtCDMV5IOpvOaGfw5zzajED6bFcBJNSmM3I
         YcDKPQPB7vjE9vMtguW2z7/5cxVHfa+F/TkDtfCUR0jZU+bpcDyeyF4vkjHEHWHZXTfm
         OCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOLLQFuNWZNcLbvoTKuul2PBnwLCZZV2yl5Rkby6ik0=;
        b=qX4IUxWyee0/I/cPiNW0P0xsMGIrmu1/rl/nkudeK3lKfbqNBy3G3/8fkBUaV5w9jA
         V6kG2fl7rGc/8t9qoxbHQhuAaaOkoqshbOPCshlr3fhEMpvAdMzPlFrQ2Pswmwem7Ran
         xNcFje3J2Tn7PhqRIJsz3jt8bUOCXUPRZapWdDAFAlxPIlwNeOOMZzfydFXUD7MNGxiC
         /gn1pt2kvqCRgTGODrqqY81GHZZWWTDect1TBMLn1uP1u5coCV4UlsSLmyf3HnFBZbvB
         dZow3SklzMm4tAwajMDTRmxPDylkqyhkVO+AbTrEPIh0Mt+e14Y7IShPJc1eHH53gMb2
         /V9w==
X-Gm-Message-State: AHQUAubbYWuZcMss3XR9uKFXne4i26LNfV6vUclYvBbFB3yxIyjhdc1G
        RosoMvLljXh/pwmedbYKfmfweRf2BcPk44w4V3K+OQ==
X-Google-Smtp-Source: AHgI3IaXslkW65Krggxq02hHR+yQdwUvqf+Fm8usmvuxZoEAwJCPo0+6iEl0097nd7G7eW84XOO0Y0ABXCeIR1f9/5I=
X-Received: by 2002:a63:d80b:: with SMTP id b11mr25226432pgh.168.1551201516864;
 Tue, 26 Feb 2019 09:18:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com> <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
In-Reply-To: <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 26 Feb 2019 18:18:25 +0100
Message-ID: <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > The following testing approaches has been taken to find potential issues
> > with user pointer untagging:
> >
> > 1. Static testing (with sparse [3] and separately with a custom static
> >    analyzer based on Clang) to track casts of __user pointers to integer
> >    types to find places where untagging needs to be done.
>
> First of all, it's really cool that you took this approach.  Sounds like
> there was a lot of systematic work to fix up the sites in the existing
> codebase.
>
> But, isn't this a _bit_ fragile going forward?  Folks can't just "make
> sparse" to find issues with missing untags.

Yes, this static approach can only be used as a hint to find some
places where untagging is needed, but certainly not all.

> This seems like something
> where we would ideally add an __tagged annotation (or something) to the
> source tree and then have sparse rules that can look for missed untags.

This has been suggested before, search for __untagged here [1].
However there are many places in the kernel where a __user pointer is
casted into unsigned long and passed further. I'm not sure if it's
possible apply a __tagged/__untagged kind of attribute to non-pointer
types, is it?

[1] https://patchwork.kernel.org/patch/10581535/
