Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A9FC46472
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B92217C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="akPuHJSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B92217C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeHEJ3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:29:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38588 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeHEJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:29:33 -0400
Received: by mail-it0-f66.google.com with SMTP id v71-v6so14076275itb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EIF20Yxq5hRyS5R3NOUjYQYl7NDR/6KnUlo/fxRG6nM=;
        b=akPuHJSNwBFJ/u0QuAoFS+r4r6u7suFEx44F8erpBTICSvVZRZbO097wS60FjowCKX
         xuD/CWZ9WpexcxCaCKkkq6HiIJNpSPmlS0xNFBo60NRxO5XyGnDvzeV4FuheEqsAvER5
         Q7KTFL2lW1A67Ywn6S+q7VTX+v3Rq+U2c/N5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EIF20Yxq5hRyS5R3NOUjYQYl7NDR/6KnUlo/fxRG6nM=;
        b=KFiDLwmbWpXvICcj/xWz3stxGffxXwvaj3qEZsMKl1ojb/5Zz3cZBHe6o8XKk9vRWk
         fnYg5frjwO05yzwkYvGYKq6c6rQOlbJmrSjwPXGXSwJILMRAfoFegNVhxRAjyyiE8sip
         EJ3UEJbMhRLZBh12Xr0sFwlyEEH6KYG9fx4Vlwrh9E1ZKnQcP6sSPABNlFQdJEaDoFrY
         yioVziCzIjpgZUjZd8F/iZPndWIhOKqXcuKNDBzy6lk8I5N0PU4JsvXJcB9W1nOdpblb
         FiYXfXVH3D/NzmNbJUaQs28gtUW9rabyFU8KyAGU52LPe2xUDMlqt57/kmQjJkbxoFl/
         +OQQ==
X-Gm-Message-State: AOUpUlGoeNkDRYfzNVYhOBvViy7ykzbHK2HiGTvBrKoXkH0WxxLf7lRK
        YLRI35UsuX908wk9I7mm3V0lle4f/jXk+yGPZWf5Bg==
X-Google-Smtp-Source: AAOMgpcXKjUu+xKthP9icTaMI4xlyDlhmy9joT08aKQhi/1ylHUtmeH4eS/7WPtKqWOGpbKVfPiMfoJ+/nryJPComlU=
X-Received: by 2002:a24:5242:: with SMTP id d63-v6mr11694411itb.138.1533453957479;
 Sun, 05 Aug 2018 00:25:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 00:25:56 -0700 (PDT)
In-Reply-To: <20180805032119.20485-1-jlee@suse.com>
References: <20180805032119.20485-1-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 5 Aug 2018 09:25:56 +0200
Message-ID: <CAKv+Gu81vEGNggcWv1NyPJsMeK0HRi_DanH2+Z_4metoNG=txA@mail.gmail.com>
Subject: Re: [PATCH 0/6][RFC] Add EFI secure key to key retention service
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chun,yi,

On 5 August 2018 at 05:21, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> When secure boot is enabled, only signed EFI binary can access
> EFI boot service variable before ExitBootService. Which means that
> the EFI boot service variable is secure.
>

No it, isn't, and this is a very dangerous assumption to make.

'Secure' means different things to different people. 'Secure boot' is
a misnomer, since it is too vague: it should be called 'authenticated
boot', and the catch is that authentication using public-key crypto
does not involve secrets at all. The UEFI variable store was not
designed with confidentiality in mind, and assuming [given the
reputation of EFI on the implementation side] that you can use it to
keep secrets is rather unwise imho.

> This patch set add functions to EFI boot stub to generate a 512-bit
> random number that it can be used as a root key for encryption and
> authentication. This root key will be kept in EFI boot service variable.
> EFI boot stub will read and transfer ERK (efi root key) to kernel.
>
> At runtime, the ERK can be used to encrypted/authentication other
> random number to generate EFI secure key. The EFI secure key can be
> a new master key type for encrypted key. It's useful for hibernation
> or evm.
>
> Here is the proof of concept for using EFI secure key in hibernation:
>   https://github.com/joeyli/linux-s4sign/commit/6311e97038974bc5de8121769fb4d34470009566
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Ryan Chen <yu.chen.surf@gmail.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
>
> Lee, Chun-Yi (6):
>   x86/KASLR: make getting random long number function public
>   efi: the function transfers status to string
>   efi: generate efi root key in EFI boot stub
>   key: add EFI secure key type
>   key: add EFI secure key as a master key type
>   key: enforce the secure boot checking when loading efi root key
>
>  Documentation/admin-guide/kernel-parameters.txt |   6 +
>  arch/x86/boot/compressed/Makefile               |   1 +
>  arch/x86/boot/compressed/cpuflags.c             |   2 +-
>  arch/x86/boot/compressed/eboot.c                |   2 +
>  arch/x86/boot/compressed/efi_root_key.c         | 212 +++++++
>  arch/x86/boot/compressed/kaslr.c                |  21 -
>  arch/x86/boot/compressed/misc.c                 |  17 +
>  arch/x86/boot/compressed/misc.h                 |  12 +-
>  arch/x86/include/asm/efi.h                      |  13 +
>  arch/x86/include/uapi/asm/bootparam.h           |   1 +
>  arch/x86/kernel/setup.c                         |   3 +
>  arch/x86/lib/kaslr.c                            |  61 +-
>  arch/x86/lib/random.c                           |  68 +++
>  drivers/firmware/efi/Kconfig                    |  31 +
>  drivers/firmware/efi/Makefile                   |   1 +
>  drivers/firmware/efi/efi-secure-key.c           | 748 ++++++++++++++++++++++++
>  include/keys/efi-type.h                         |  57 ++
>  include/linux/efi.h                             |  40 ++
>  include/linux/kernel.h                          |   3 +-
>  kernel/panic.c                                  |   1 +
>  security/keys/encrypted-keys/encrypted.c        |  10 +
>  21 files changed, 1226 insertions(+), 84 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/efi_root_key.c
>  create mode 100644 arch/x86/lib/random.c
>  create mode 100644 drivers/firmware/efi/efi-secure-key.c
>  create mode 100644 include/keys/efi-type.h
>
> --
> 2.13.6
>
