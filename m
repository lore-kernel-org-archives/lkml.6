Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648DFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136D820894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNKFhx9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136D820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbeGZNnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:43:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53458 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbeGZNnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:43:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so1783973wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 05:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vnzg/uiA3k6rO781938fn/q/XkEEKQ5Auf8o4/VfG+0=;
        b=iNKFhx9G5JyaT5fvgPqfpI+fWs781Xl3lnyAthveCCruFNvVFuI5MJnU5WupatK7P/
         rIzoVdsXOpk7yqw1D9fYQDIcBqt5szz+cWiN6PnV9TEyU1VlfR4dB7viI0dcHtmbY4DK
         zZsLkVBkcxn5finxshVlmg4EBU02lOR2QzDcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vnzg/uiA3k6rO781938fn/q/XkEEKQ5Auf8o4/VfG+0=;
        b=k1PtQ0jg2drNLNNu6excCF9vjhRRBbo01vc0m0vHW7XJ3+W7C3bsMzUBH78Iqv/QCQ
         iihv2+82Y+TGCFhNADv3aC1RyrmnyV7P9amDqVlYe6gFlaWl4dfYQNjV6D2SkbPshD3z
         XeTzYFVX3KTIayHVvFm2q8jyW3vGtV9Op+t0IJ/NWf+s1vvYIAvUnhkqvivqgm8e8v4m
         8CyjculEK4f6uA5EEUlVfTj86O+VuVPJGNLdZiQHaPVJpLBDFqL3ViHPVYZbKNp7YPSi
         4TXNCN3uzUCrXF28kdH2LmpsGQPVYuUkw1t+wtZ8+UQsLSuPOZsbxHwbESFvhKniWn7Y
         d9Wg==
X-Gm-Message-State: AOUpUlErTaH55asmiknVT/X7hn+IgV9uQr6rYWE3uPmVIMarctG8VoN/
        fbnmFll80dcMWNLmxL9OGCwEFw==
X-Google-Smtp-Source: AAOMgpdgruM0Nvw3pjI7JiEC3FECmeG/kMkWe+Biq3gc+6s23WW54bi5+5pycSKZyw9xHmJYnMVmuQ==
X-Received: by 2002:a1c:3f08:: with SMTP id m8-v6mr1541002wma.88.1532607988306;
        Thu, 26 Jul 2018 05:26:28 -0700 (PDT)
Received: from [100.125.208.68] (193.84.136.77.rev.sfr.net. [77.136.84.193])
        by smtp.gmail.com with ESMTPSA id q70-v6sm2791965wmd.39.2018.07.26.05.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 05:26:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RT] rtc: Disable RTC_DRV_EFI on RT
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180726121504.ba35z3j3wsesryy3@linutronix.de>
Date:   Thu, 26 Jul 2018 14:26:25 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5052E25B-9942-40C1-BD53-86E3D7014557@linaro.org>
References: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de> <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com> <20180726121504.ba35z3j3wsesryy3@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 26 Jul 2018, at 14:15, Sebastian Andrzej Siewior <bigeasy@linutronix.de=
> wrote:
>=20
>> On 2018-07-26 11:15:52 [+0200], Ard Biesheuvel wrote:
>> On 26 July 2018 at 11:04, Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>>> Based on measurements the EFI functions get_variable /
>>> get_next_variable take up to 2us. The functions get_time, set_time take
>>> around 10ms. Those 10ms are too much. Even one ms would be too much.
>>=20
>> You cannot extrapolate from these numbers. If the lack of worst case
>> guarantees on an EFI system is a problem for -rt, the only meaningful
>> course of action is to disable EFI runtime services entirely.
>=20
> Oh boy. I disable EFI entirely because then the bootloader won't boot
> due to missing efi-stub. But I could disable the runtime-wrappers if
> that is what you meant. Patch below.
>=20

What i mean is whatever you end up with if you pass efi=3Dnoruntime to the k=
ernel.

But as i mentioned before, you may also lose the ability to reboot/shut down=
 your system this way. Can you please double check?

>> I think SetVariable() may be even worse than GetTime(), given that NOR
>> flash updates may involve erasing blocks.
>=20
> Here we go. "Read" can be triggered from userland via sysfs / efivars.
> "Write" is (currently) limited to pstore?
>=20

No you can also write to variables via efivarfs and sysfs.

>>> The funny part is that EFI is invoked with enabled interrupts.
>>> According to my tracing I see the interrupt almost 10ms later which
>>> indicates that EFI is disabling interrupts while doing its thing.
>>=20
>> Yes, and this is also highly implementation specific. Basing this kind
>> of policy on a single implementation is not very wise imo.
>=20
> even if interrupts were not disabled then there would be no context
> switch on exit from interrupt path due to the preempt-disable part. So
> no improvement.
>=20
>>> This was observed on "EFI v2.60 by SoftIron Overdrive 1000". I don't say=

>>> that every EFI implementation does this but given that it has to access a=

>>> slow bus like I2C/SPI it is expected.
>>>=20
>>> Disable EFI's RTC driver on RT.
>>>=20
>>=20
>> Other calls to GetTime() would still be permitted in this case, so
>> this seems like a partial solution (although no other calls seem to
>> exist atm)
>=20
> I *assumed* pstore would use the SetVariable during warning/bug. The
> pstore thingy might be useful. Not sure.
>=20
> ------ >8
>=20
> Subject: [PATCH RT] arm64: Disable EFI runtime services on RT
>=20
> Based on meassurements the EFI functions get_variable /
> get_next_variable take up to 2us which looks okay.
> The functions get_time, set_time take around 10ms. Those 10ms are too
> much. Even one ms would be too much.
> Ard mentioned that SetVariable might even trigger larger latencies if
> the firware will erase flash blocks on NOR.
>=20
> The time-functions are used by efi-rtc and can be triggered during
> runtimed (either via explicit read/write or ntp sync).
>=20
> The variable write could be used by pstore.
> These functions can be disabled without much of a loss. The poweroff /
> reboot hooks will be provided by PSCI.
>=20
> Disable EFI's runtime wrappers.
>=20
> This was observed on "EFI v2.60 by SoftIron Overdrive 1000".
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/arm64/Kconfig                 | 2 +-
> drivers/firmware/efi/arm-runtime.c | 2 ++
> 2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 111db4e44fcf..68adcb0f4de6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1250,7 +1250,7 @@ config EFI
>    select LIBFDT
>    select UCS2_STRING
>    select EFI_PARAMS_FROM_FDT
> -    select EFI_RUNTIME_WRAPPERS
> +    select EFI_RUNTIME_WRAPPERS if !PREEMPT_RT_BASE
>    select EFI_STUB
>    select EFI_ARMSTUB
>    default y
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm=
-runtime.c
> index 5889cbea60b8..3e96db10c034 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -140,8 +140,10 @@ static int __init arm_enable_runtime_services(void)
>    }
>=20
>    /* Set up runtime services function pointers */
> +#ifdef CONFIG_EFI_RUNTIME_WRAPPERS
>    efi_native_runtime_setup();
>    set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> +#endif
>=20
>    return 0;
> }
> --=20
> 2.18.0
>=20
