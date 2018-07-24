Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE46C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995E520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDlWcMov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995E520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbeGXL3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:29:35 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46390 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeGXL3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:29:35 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so6525248oie.13;
        Tue, 24 Jul 2018 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ox6aVdBVbokt/3gtI01+QVy08l1wXId0Wt2fQrRKEmQ=;
        b=MDlWcMovIwWzDgr/68JuU+L4Y6Vjn3N5hAIvS1dAsEmYR5JakXIMWU91hmMP+pW2+8
         QX068ejFeeIOIh35pPpOHmEKoy0T19+dUE22zV8DY/mk2uzDr5R6xHrnlcf3GDwrdaNP
         fIMMEUaVEMs0iurfHnIJINhyKT/Skrd4QEn5nJ2fmtetzAyDqkJ5JIRjD0kwverSHs9T
         9kTtBNdhTcF5NQFmyA3jv+OEGcQ8tEwYpkz8FAwxvl+AeqtVpF2zqlaKcOajHGsjrkAz
         yn08KxKye5BIURZQNsC4Nnx2/+GA6LYT1FHSwXaxYzSxultbu/EOgXPa5Vi1lqL4M1Uu
         XUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ox6aVdBVbokt/3gtI01+QVy08l1wXId0Wt2fQrRKEmQ=;
        b=nzaRq8Ta6VK+W7KO49Z2VfAtPlPUIepre88v/DumFS89nHzZnnPGJXg/D/X22pgHKe
         +mpdw8YxYxXX8Dk4EvNpYBnjpxGZqTX8hV9j7gKPrCDl+bTv2kzlTQad3cXojMa1xN7i
         rb8EHIrvUu6WStWzszutuxdjGbhdxHwqobtUiStRvH77VGjoE6kKbeff8UFWDcIW9Mm3
         oYNVwPiLXtx8isAI+WajPWtIC1jAv8msC0W4/1qpLXzEFqcOlcJB56tC/qiNx/GfSAF3
         7EBDTbqL5AbqAAGy9Q23BViPTvK6TgaJpOy0bf+WpEufJ2G1GMuzz1O5IUHGTCgqpvX5
         QhRw==
X-Gm-Message-State: AOUpUlH02dPlmx+kmhgAkVWNcAqWNDkTrxV4g2MViU3lCC4IyNMp/nDL
        rSWNPgXAZsmE8if0SQweexshZ0bt/nABH39R8AE=
X-Google-Smtp-Source: AAOMgpdL0PqUVEXjo/QJYreHB/cqeRgCM4C6GQcEL8wrNg6ofJ0UcYNajKnWBlb9DaJZYxvAsosUVYItIwbb/hJ6JwI=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr2738005oib.116.1532427828370;
 Tue, 24 Jul 2018 03:23:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 03:23:48
 -0700 (PDT)
In-Reply-To: <20180724102102.GI19324@arm.com>
References: <20180724094957.1967541-1-arnd@arndb.de> <CAJZ5v0jMtWDZePW=mu_cO2PjHVGp1hQThSveq9+=2aNozESENQ@mail.gmail.com>
 <20180724102102.GI19324@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jul 2018 12:23:48 +0200
X-Google-Sender-Auth: yywfpsgNd2rehXiL0lQPzjq4qr0
Message-ID: <CAJZ5v0h1zGHrMo6HLtSMWE4kM9YK-3QvgHnBaRrEpMHAJrrMtg@mail.gmail.com>
Subject: Re: [PATCH] [SUBMITTED 20180724] arm64: fix ACPI dependencies
To:     Will Deacon <will.deacon@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 12:21 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 24, 2018 at 11:54:25AM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jul 24, 2018 at 11:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Kconfig reports a warning on x86 builds after the ARM64 dependency
>> > was added.
>> >
>> > drivers/acpi/Kconfig:6:error: recursive dependency detected!
>> > drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
>> >
>> > This rephrases the dependency to keep the ARM64 details out of the
>> > shared Kconfig file, so Kconfig no longer gets confused by it.
>> >
>> > For consistency, all three architectures that support ACPI now
>> > select ARCH_SUPPORTS_ACPI in exactly the configuration in which
>> > they allow it. We still need the 'default x86', as each one
>> > wants a different default: default-y on x86, default-n on arm64,
>> > and always-y on ia64.
>> >
>> > Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> > v2: use 'select ARCH_SUPPORTS_ACPI' for all three.
>>
>> LGTM
>>
>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Same here:
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Would it be ok if I take this via the arm64 tree, since that's where the
> warning was introduced?

Yes, it would, from the ACPI side.
