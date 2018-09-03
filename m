Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6816EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9C920868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIEKXTo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9C920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeICSrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:47:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47082 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICSrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:47:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id j7-v6so430586qkd.13;
        Mon, 03 Sep 2018 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIz3ru3BIoAJgmBeNcPV1BqkrrZ5jlFDgUli4Ftuweg=;
        b=fIEKXTo08YLd+EEzNtGN/tI6K7KPNJVfCvPCNkdXJdnE+shEAYV8EeVKSB5vm6ib7R
         wNo1j1JWDNh30d2JWJ9OwSvqR+XR3/wXAXd2TLfymgNlZMIQwVSWIwoFbCjfdDE4fBWf
         RM9qw64rWt084/VDz1KkhQoKZTlnWJPoslAWhkNVQtKP1GJEc67xf5rVrnJzLxSadSLE
         rhl5kUprofTMHi/1Xv2wugTi5aarzmP1ifOihWUvXJZpZkak6fTKT0hEjg8CVWv4Fevn
         JryqtCIdKF/4S0+UkaQdgWE4iXjCm6aw4lDwTZvqvf4DovJ0OuMoQskmRSJjci0FwAIZ
         iYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIz3ru3BIoAJgmBeNcPV1BqkrrZ5jlFDgUli4Ftuweg=;
        b=GIXpWip5zWIc9FmVf8Yx1sX/juvQoWmh+DdFYnfoR50Ghc/Z5cp7ECOrZuKG6WaP0F
         gmUVyyHIvxkeskiMm7eZwdN0FQkMj+Z/ZYmfqDj1WaKo5IsRhW6UJH059sUDB4UDDJKh
         gzJJuwaZwhUxcN6PVXu0VQjeC1kpCm4S2WYaDsh+4glH80Po6uLRhvMPrXjCnmxVJmgy
         JS+qCkKU3JIH5s0ZoiiNd4/bvEov6NfG4ou3ALtuLT3wh8W2XY9woCFYl4y5ar4rFqar
         aSoLNrufeR1ur1ooIMz3zfUSzCq2QrCwCNyUDn7CcwuGqKuJMeTnO/avlLo0OP8DtQjZ
         dqGw==
X-Gm-Message-State: APzg51CTztD2N9TdafzuA1YANrJC8iD3pMo1Kp/oTjZymenXgi/9mDuY
        bb23airo5Cqt/H8NlCWb9CFSeRVZX/agYuIf+3o=
X-Google-Smtp-Source: ANB0VdZjymbQp1PPgDeyxdra/wgKau57XDi+XRijZ+n0klJUcGVzY3Vry93Jb7qVblPtjykWMshX7hGOFLNlPgqeCAg=
X-Received: by 2002:a37:d992:: with SMTP id q18-v6mr25231794qkl.101.1535984815111;
 Mon, 03 Sep 2018 07:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-7-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-7-jarkko.sakkinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Sep 2018 17:26:43 +0300
Message-ID: <CAHp75VeN7QoftgkqP-L6JRZi=MRpQkVioBLP7VDLwH=rpnEp_w@mail.gmail.com>
Subject: Re: [PATCH v13 06/13] x86/sgx: Detect Intel SGX
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        suresh.b.siddha@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, serge.ayoun@intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:57 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Intel(R) SGX is a set of CPU instructions that can be used by applications
> to set aside private regions of code and data. The code outside the enclave
> is disallowed to access the memory inside the enclave by the CPU access
> control.
>
> Add a check for SGX to arch/x86 and a new config option, INTEL_SGX_CORE.
> Expose a boolean variable 'sgx_enabled' to query whether or not the SGX
> support is available.

> +       prompt "Intel SGX core functionality"
> +       def_bool n

Default 'default' is 'n'. Perhaps changing prompt to bool will make it
one line less.

> +#include <asm/sgx.h>
> +#include <asm/sgx_pr.h>

Don't we put linux/* followed by asm/* ?

> +#include <linux/freezer.h>
> +#include <linux/highmem.h>
> +#include <linux/kthread.h>
> +#include <linux/ratelimit.h>
> +#include <linux/sched/signal.h>
> +#include <linux/slab.h>

-- 
With Best Regards,
Andy Shevchenko
