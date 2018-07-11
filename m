Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F8D208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtSNbOfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F8D208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeGKHW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:22:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39148 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeGKHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:22:56 -0400
Received: by mail-it0-f65.google.com with SMTP id p185-v6so2127034itp.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=toFz7VRiqQf4KXUugCiisC0Qqpk0R1ozgdLQe79wLi4=;
        b=gtSNbOfUXMUpsLhi4125J/Fpp2+GAmpi8yQzWYiZH/r7rgV4GTcnnCrZQ14tBkxWRo
         TPLiMUA8ikHYnGYljCX84k2djm6f1GipGvz3SrN01Ign/EZZVk6nzdnX6WbN6iXLuLB6
         wYFuQ711G6AZr4WUceM9+hWsfrj4JmXiIibF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=toFz7VRiqQf4KXUugCiisC0Qqpk0R1ozgdLQe79wLi4=;
        b=Tq3kIUkywpHVznAveE76/w35Dmzt7OKOrDRsKoac4+zko3K3zLf+aPz3WQs2icKFEC
         YelXWwCfVmTEwKTb3BXgY0GrCOtucQhVvgW1bsIWExUfuq1QP/pmLDs5ad139eyGl0KX
         RzXuR5iANlLNnYZ8lAOwPXthO2awfkAeSrbTXrvAupwxP7HrYayeIWJTn712BW4o1dLz
         XqlAioebpOcJEHOjsFPe4+K8mIYXwlggunbt1gvKv/1VCuVcsbE/c0IRtm9pZ/HcDibd
         77gxg//vFKXneQrmm8MzRggxw+/36117ZoEwnNz4bej60pt/I8M+EJTYkwAFIBXbKi0F
         3CnQ==
X-Gm-Message-State: APt69E0vUtR0J9E4t2Nnwsjbzsur1ie08pL51hTVmEOjTXPCcSlDqAPZ
        usE4SMrC5NUX7uZ/2K0LxCblvu3IUvZANq7hSg20tw==
X-Google-Smtp-Source: AAOMgpdK5lS9JCbyTGcmmrxMDB32XWCKbbL+1KeoZIKF4YIIrNHo3ZcoL2Zv8pXlx+kzpQbpU7x3sIUq3Tb5e9IfwUM=
X-Received: by 2002:a24:64d6:: with SMTP id t205-v6mr22096672itc.138.1531293604720;
 Wed, 11 Jul 2018 00:20:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 00:20:03
 -0700 (PDT)
In-Reply-To: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
References: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Jul 2018 09:20:03 +0200
Message-ID: <CAKv+Gu-PLsWZLPM-OfXHLGKs7PojRB4jFsyp+X_5OW6ryi7gRQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: neon: Fix function may_use_simd() return error status
To:     "Yandong.Zhao" <yandong77520@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        zhaoyd@thundersoft.com, zhaoxb@thundersoft.com,
        fanlc0801@thundersoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 July 2018 at 03:09, Yandong.Zhao <yandong77520@gmail.com> wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
>
> It does not matter if the caller of may_use_simd() migrates to
> another cpu after the call, but it is still important that the
> kernel_neon_busy percpu instance that is read matches the cpu the
> task is running on at the time of the read.
>
> This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
> may appear true if the caller migrates during the execution of
> raw_cpu_read() and the next task to be scheduled in on the initial
> cpu calls kernel_neon_begin().
>
> This patch replaces raw_cpu_read() with this_cpu_read() to protect
> against this race.
>
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>

I had a bit of trouble disentangling the per-cpu spaghetti to decide
whether this may trigger warnings when CONFIG_DEBUG_PREEMPT=y, but I
don't think so. So assuming this is *not* the case:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>  arch/arm64/include/asm/simd.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index fa8b3fe..784a8c2 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,7 +29,8 @@
>  static __must_check inline bool may_use_simd(void)
>  {
>         /*
> -        * The raw_cpu_read() is racy if called with preemption enabled.
> +        * The this_cpu_read() is racy if called with preemption enabled,
> +        * since the task may subsequently migrate to another CPU.
>          * This is not a bug: kernel_neon_busy is only set when
>          * preemption is disabled, so we cannot migrate to another CPU
>          * while it is set, nor can we migrate to a CPU where it is set.
> @@ -42,7 +43,7 @@ static __must_check inline bool may_use_simd(void)
>          * false.
>          */
>         return !in_irq() && !irqs_disabled() && !in_nmi() &&
> -               !raw_cpu_read(kernel_neon_busy);
> +               !this_cpu_read(kernel_neon_busy);
>  }
>
>  #else /* ! CONFIG_KERNEL_MODE_NEON */
> --
> 1.9.1
>
