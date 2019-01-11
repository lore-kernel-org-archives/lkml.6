Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2266C2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547202916;
	bh=/ex2WFCiEWBQ8ieaAA/frmCPrfxMZuIzCx0ZD5jOknw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tphZWH8a54qpgcV3pP35pfYwOX2ZDCLhyvpZq8/Zc9mSiQ4zNlRKWlzHx07C/vcdd
	 BPcURP6RsKyb/COlqXbRQiXNRTmvZc35mV6W3ZjdHF7eVDsGT7CxmXT+kj8KEKy2AN
	 BS8Ku1wvaworpb0TcwZF1mL8LKNA+6yXKDOOMMXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfAKKfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:35:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35178 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfAKKfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:35:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so12730828otj.2;
        Fri, 11 Jan 2019 02:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oZTLwB43REzaR6ZsWYQNqaM/kDEXb9ln+305udp67Q=;
        b=U7al70SLp+RwyCiv09WUaAhUaBWbgIbhqdP8FaPtdcO0VailtmzkeaRfPKqq8/788k
         ASpXEadLTNBbMHZhBMpr9a4BfRS2hOjCM1fh5CEQdcn+m4ykmJq5sJbAPJws/WD+n92n
         yKoP3eQNqmHRdekdeDvspNzTwVjmoQwRDygi3fZEbERkFQll26z1rBeesVtbA43lqU93
         U2y/q/J8gq/JgRv7k8qPi2cecQqEbKcpWyFEF6E9GJUsIkcS2X4OO2UpiYoDKnHXvmQH
         sr7Ok9pj03Uc2j2VlxxmLvaOjMT14ATBulSbEOZR99kqLuSYCKSI9AuSTvOSRy4faazQ
         vH4g==
X-Gm-Message-State: AJcUukeZlh6KbAUdYSZSUpJmh2OfnJaiDDrujYUYoIelcpKUWGGoF7tM
        xX0GP/F1/JzjsOvoKuLbDFmQvZ5yUg4xb4jtPeo=
X-Google-Smtp-Source: ALg8bN70udkXRHiTYbU8Tl5vOLYkL4X7crHRdashU/FQJdFAe80jY/2K/Cgt3ONPEPTSZ7Vf9nxxY48vW+X+C/iaBlY=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr9842527otl.343.1547202912593;
 Fri, 11 Jan 2019 02:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jan 2019 11:35:01 +0100
Message-ID: <CAJZ5v0hzUAYDxneYUNjcpvN5H+F+=fH1PnVcHP5TgLr-5Jc6YA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper macros
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 5:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> These macros are often used by the drivers and we have already a lot of
> duplication as ICPU() macro across them.
>
> Provide a generic x86 macro for users.
>
> This adds no driver data variants.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

If you want me to apply the series, I need an ACK for this one.

Alternatively, if you want to apply it yourself, please feel free to
add ACKs from me to the ACPI-related patches in it.

> ---
>  arch/x86/include/asm/intel-family.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 25b28760fada..afd70055a750 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -86,10 +86,16 @@
>         .family         = _family,                              \
>         .model          = _model,                               \
>         .feature        = X86_FEATURE_ANY,                      \
> -       .driver_data    = (kernel_ulong_t)&_driver_data         \
> +       .driver_data    = (kernel_ulong_t)_driver_data          \
>  }
>
>  #define INTEL_CPU_FAM6(_model, _driver_data)                   \
> -       INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
> +       INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, &_driver_data)
> +
> +#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)              \
> +       INTEL_CPU_FAM_ANY(_family, _model, 0)
> +
> +#define INTEL_CPU_FAM6_NODATA(_model)                          \
> +       INTEL_CPU_FAM_ANY_NODATA(6, INTEL_FAM6_##_model)
>
>  #endif /* _ASM_X86_INTEL_FAMILY_H */
> --
> 2.20.1
>
