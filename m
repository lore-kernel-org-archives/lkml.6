Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D868E20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nf0W3edE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k+6jl9Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D868E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeGXRnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:43:15 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34196 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:43:14 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so1765778ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7BoaocFlvYA47CWjuzT1cFj4ouWxckE4kDx1hGC1pj0=;
        b=nf0W3edEcCvjozeZjiMeELVksYsP+BgKcL/R4arjh7m+oCNWReAOeG7QJZ2Pqn16iR
         tdz8MPllHz+O8DtK2kG8MHcgRhxLvB+i2NM4t8GiwyVgIt4dAKAHJUNeL+6QiH4+2aud
         xjbcWMQcAZlQTGic5J7neO0NXZv7DlJRrzOUcHypSOy+uYGjahcvS4WH612Ra4YH50d5
         zQZIa+jntjDu1fMv/tPwbiWwZNmh5mLk5ZMjFV1MzpUAtv8/sUlxKqQd7Y+jJlLxVqLP
         bxRc/xY1tjIhEc7VsobKND3JorvvyZ5y/luYplR62anVVwxsS+ypocWCqhCs8JAgWJb2
         oobQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7BoaocFlvYA47CWjuzT1cFj4ouWxckE4kDx1hGC1pj0=;
        b=k+6jl9Qb7TDecmpIGC26n9j884v3WxC/e5KfWXabEsCEUYVyOBqpwEoLG6aAhaFwSI
         y2jA2eHWvbWVZx4+fR/MzWv7xfxaptmYPIxM/YexKwQtK/wjXlRhzF6Pdvd1M68E1Phl
         meC8FygLK4EvpVj4B799gZ7UsuJ/weLB9E+Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7BoaocFlvYA47CWjuzT1cFj4ouWxckE4kDx1hGC1pj0=;
        b=slmX7YMLLUOwqsSooz8Uq1Sq383WqrKruuzF02ExjHlqoM8AJgs3QQLspX5AN6g//p
         VpBM0GaQR+aLB8o0XSWSWbzOCEseHp9FHv2Z9Wov8E1c9ekZ504W1WJa3UsxKipi/yVz
         sHCefxOX54UxXXCSvev+wZrZz6q+A2PTRxy16R47Cj7ZnM3/9+pGCxGBtFKZFtWWqRwa
         34g9H063yw0dsPovX0I3MMZJPqBbeI5OUyKOvPdccpsGO2NRpBNaDU4mr61dyu3FaZ7g
         kj7DercLd29cNwDEUOHhA+hLmpau9L4bJedU947UgJmlRgWz9qDC854pxYhmxuDykA7v
         EZIQ==
X-Gm-Message-State: AOUpUlHIsc5iDiFrTqBNAIP73qKf3K/BgO9rbXdTNQ6Ci4n6Ol30iazO
        7JnVBXwJwz6oK2ZqsLtePmeiz18ptP4vl4wsWjmx8Q==
X-Google-Smtp-Source: AAOMgpcIBy6uYlniNGl2/9K+lhzdw8rdUQBBmUlVIDif1JjT/THoHVRW/8i+1X4TtE0Y4whRxahxLbFYWbKAE+ry7MU=
X-Received: by 2002:a81:8742:: with SMTP id x63-v6mr9305595ywf.129.1532450156293;
 Tue, 24 Jul 2018 09:35:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 09:35:55
 -0700 (PDT)
In-Reply-To: <ee7335aa-d536-7aef-a25e-224462e065b0@linux.com>
References: <20180720214154.2940-1-labbott@redhat.com> <20180720214154.2940-3-labbott@redhat.com>
 <ee7335aa-d536-7aef-a25e-224462e065b0@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 24 Jul 2018 09:35:55 -0700
X-Google-Sender-Auth: 1W8yZiPZetVanBeOtZLqLC-67cI
Message-ID: <CAGXu5jL3=o9U-pLcX7Abe-nUZ0VftpPcSR3Ho3-gBv-AnS_M1A@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] arm64: Add support for STACKLEAK gcc plugin
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 5:44 AM, Alexander Popov <alex.popov@linux.com> wrote:
> On 21.07.2018 00:41, Laura Abbott wrote:
>> This adds support for the STACKLEAK gcc plugin to arm64 by implementing
>> stackleak_check_alloca(), based heavily on the x86 version, and adding the
>> two helpers used by the stackleak common code: current_top_of_stack() and
>> on_thread_stack(). The stack erasure calls are made at syscall returns.
>> Additionally, this disables the plugin in hypervisor and EFI stub code,
>> which are out of scope for the protection.
>>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v3: Actual commit text courtesy of Kees. A comment explaining why we
>> panic
>> ---
>>  arch/arm64/Kconfig                    |  1 +
>>  arch/arm64/include/asm/processor.h    | 15 +++++++++++++++
>>  arch/arm64/kernel/entry.S             |  7 +++++++
>>  arch/arm64/kernel/process.c           | 22 ++++++++++++++++++++++
>>  arch/arm64/kvm/hyp/Makefile           |  3 ++-
>>  drivers/firmware/efi/libstub/Makefile |  3 ++-
>>  6 files changed, 49 insertions(+), 2 deletions(-)
>
> Laura, thanks for your work!
>
> I've reviewed and tested this patch on my LeMaker HiKey board (HiSilicon Kirin
> 620 SoC). The lkdtm tests for STACKLEAK work fine.
>
> Acked-by: Alexander Popov <alex.popov@linux.com>
>
> For testing I applied your patches above Kees' for-next/kspp:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-next/kspp
>
> I've had one trouble with building CONFIG_STACKLEAK_RUNTIME_DISABLE on arm64.
> Kees, could you please fold this into the 7th patch of the series?

Sure thing!

-Kees

>
> ---- >8 ----
>
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index f731c9a..03031f7a 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -16,6 +16,7 @@
>
>  #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
>  #include <linux/jump_label.h>
> +#include <linux/sysctl.h>
>
>  static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
>



-- 
Kees Cook
Pixel Security
