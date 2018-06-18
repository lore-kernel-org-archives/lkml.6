Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED8BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCED02075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK0i924H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCED02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935389AbeFRVgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755344AbeFRVgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:36:49 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12BCC20836
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529357809;
        bh=1jSplhB13as+yVYL+UtbaI/8rA7cOqZI4ZN8XKeCtKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gK0i924HOTPaULp8AiK1WjrEGqI5d0WdaOIIRbWvVLtsqI+hqIkgkxhHEXHabF4oj
         EWS1svGCPsAiIEGrHunAQAk4FskXc1MNr9IngC9tE8wv83Y+gxOUFIC41iJVUe8wEq
         AYs9OJQlDBoHmmmc9EhoDRZOFYbON0jFrvESLnxQ=
Received: by mail-wm0-f45.google.com with SMTP id v131-v6so18271222wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:36:49 -0700 (PDT)
X-Gm-Message-State: APt69E1usvD8MM7OVeIvTpQMoj/L/lzhD2mEpsUsUmSCsp9msBB2XGxT
        Vb5VywiqTzcIAR8VwFnuBDQ4Pd9rXyvSzsd4SBJb4Q==
X-Google-Smtp-Source: ADUXVKLOceR65omKmWuQ4QgbvC6UFPw9byD7JCaLjv2O447fFTnZOJPuM+smxcHg13Ix2YkQMeyJlHBk6/GGPij0YR0=
X-Received: by 2002:a1c:f30f:: with SMTP id q15-v6mr9503253wmq.36.1529357807583;
 Mon, 18 Jun 2018 14:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-8-jarkko.sakkinen@linux.intel.com> <4fc3b6b0-6e4b-3d5f-4d54-2bf7539c7a17@intel.com>
In-Reply-To: <4fc3b6b0-6e4b-3d5f-4d54-2bf7539c7a17@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 14:36:35 -0700
X-Gmail-Original-Message-ID: <CALCETrU+s97soHtiC3p3hkdwqZhEMdjPyJByskb99a+Z8PZjpA@mail.gmail.com>
Message-ID: <CALCETrU+s97soHtiC3p3hkdwqZhEMdjPyJByskb99a+Z8PZjpA@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 07/13] x86, sgx: detect Intel SGX
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        npmccallum@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 8:11 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> > +config INTEL_SGX_CORE
> > +     prompt "Intel SGX core functionality
> > +     depends on X86_64 && CPU_SUP_INTEL
> > +     help
> > +     Intel Software Guard eXtensions (SGX) is a set of CPU instructions
> > +     that allows ring 3 applications to create enclaves; private regions
> > +     of memory that are protected, by hardware, from unauthorized access
> > +     and/or modification.
>
> That semicolon needs to be a colon.  The second half of that sentence is
> not a stand-alone statement.
>
> > +     This option enables kernel recognition of SGX, high-level management
> > +     of the Enclave Page Cache (EPC), tracking and writing of SGX Launch
> > +     Enclave Hash MSRs, and allows for virtualization of SGX via KVM. By
> > +     iteslf, this option does not provide SGX support to userspace.
> > +
> > +     For details, see Documentation/x86/intel_sgx.rst
> > +
> > +     If unsure, say N.
> > +
> >  config EFI
> >       bool "EFI runtime service support"
> >       depends on ACPI
> > diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> > new file mode 100644
> > index 000000000000..fa3e6e0eb8af
> > --- /dev/null
> > +++ b/arch/x86/include/asm/sgx.h
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +// Copyright(c) 2016-18 Intel Corporation.
> > +//
> > +// Authors:
> > +//
> > +// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > +// Suresh Siddha <suresh.b.siddha@intel.com>
> > +// Sean Christopherson <sean.j.christopherson@intel.com>
> > +
> > +#ifndef _ASM_X86_SGX_H
> > +#define _ASM_X86_SGX_H
> > +
> > +#include <linux/types.h>
> > +
> > +#define SGX_CPUID 0x12
>
> Hey, I just saw 0x12 as a magic, hard-coded number earlier in these
> patches.  It seems cruel to hard-code it, and then also have a #define
> that isn't used.
>
> > +enum sgx_cpuid {
> > +     SGX_CPUID_CAPABILITIES  = 0,
> > +     SGX_CPUID_ATTRIBUTES    = 1,
> > +     SGX_CPUID_EPC_BANKS     = 2,
> > +};
>
> These are cpuid *leaves*, right?  Please make this clear that these are
> hardware-defined values and not some kind of software construct.
>
> > +bool sgx_enabled __ro_after_init = false;
> > +EXPORT_SYMBOL(sgx_enabled);
> > +
> > +static __init bool sgx_is_enabled(void)
> > +{
> > +     unsigned long fc;
> > +
> > +     if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> > +             return false;
>
> Not necessary. CPUID does this part for you.

More to the point, if a non-Intel vendor chooses to support SGX, then
the driver should allow it.

>
> > +     if (!boot_cpu_has(X86_FEATURE_SGX))
> > +             return false;
> > +
> > +     if (!boot_cpu_has(X86_FEATURE_SGX1))
> > +             return false;
> > +
> > +     rdmsrl(MSR_IA32_FEATURE_CONTROL, fc);
> > +     if (!(fc & FEATURE_CONTROL_LOCKED))
> > +             return false;
> > +
> > +     if (!(fc & FEATURE_CONTROL_SGX_ENABLE))
> > +             return false;
>
> Comments, please.  Why would this happen?  What would it mean?

Let's add actual pr_info() statements to document this, like:

SGX: disabled by firmware
SGX: disabled because CPU does not support flexible launch control
SGX: disabled because firmware does not support flexible launch control
SGX: disabled because the phase of the moon is wrong
SGX: enabled; using SGX1
SGX: enabled, using SGX2

If the CPU doesn't support SGX at all, then I see no reason to print anything.

etc.

(Is the feature actually called flexible launch control?  I may have
made that up.)
