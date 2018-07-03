Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A399AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0E923F00
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU9g+gZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0E923F00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbeGCQDN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:03:13 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41603 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933748AbeGCQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:03:07 -0400
Received: by mail-lf0-f68.google.com with SMTP id y127-v6so2037618lfc.8;
        Tue, 03 Jul 2018 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vEumC2BQuG0lqBduoy1lhlFfOkbvAiGGy0QEKqZY2TU=;
        b=MU9g+gZwMEK3T7t7J1GvNFKGWAl3nkQfY6qC/bEgLdbaCtaebqKrRCAQbf9fTQsJGz
         F8W5sBfBZnej/l9N/j+LvQ/8h4W9+7ax9XE+eMgD2AiJ3V0Q1Xwu0p7oGLkb0BfUqjis
         qO3NCeNVLJ0HWg+JywDs/9XdVgRPpjnX62NMZ+Y9scUDcnMUltwIYpkVJadYp/WzVez0
         QwghOmZPiKORKKNwtwL99CTiSg8Z8x4XyVvLaJH0BgCnnaWgiDMuojRRWDYlRtkm62Ci
         lNDC1YlN6YlbhQmp+rXVCsxZU3vajCvGBFG/jiNBZRTqaDLXV5iKt6Jle+K51vAAcW1P
         RoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vEumC2BQuG0lqBduoy1lhlFfOkbvAiGGy0QEKqZY2TU=;
        b=lqwDwWXb9WQTltShJeUN+j0814GxV8TdWCNWvMHE3I/FtzI/E+QEgGEcdPA6KboePB
         EbtJHeu2TRBgb33FXWC9KoEpQEaXS2SwOuAlo9gw1QyB9mW6tC+IvOY6ajVQLQab0bes
         iTiFCeLtEyQM0l90KtvYMA84K2NN7S0VhXexLMEQkDV4ZyQfqfmmz7diAAXhMDU3zFcU
         Qeh6O3QfAq4ATPZUWy17zLHrNT4pz5BexXiqNDH+LqMLDvb0NTCwt5DcHRABqMBDlhzp
         94FAU+/BRQCRenwssZH41AYvRGWbRlPaPEPNdZ4umyf9j5P6x1c8n/T29v4c7F7vu3yN
         ky6A==
X-Gm-Message-State: APt69E2HgK6GXzvXuQflI0Fmynwqh9FD9nW2f5SUTh6VmaDet5ydXVsV
        wXWuXhoWZOhk3MdhNKY49m0ozFXuzXpmv8XKlxw=
X-Google-Smtp-Source: AAOMgpeHvAWnda4l7kJyiH4mxWGe7rjXI4s2fjXylMPM0HSk9ElfiJRh0QpLg1ZGVq8aJh7U3JlSMUa/ZsO2+7Og2/M=
X-Received: by 2002:a19:cb44:: with SMTP id b65-v6mr6593446lfg.12.1530633785410;
 Tue, 03 Jul 2018 09:03:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 09:03:04 -0700 (PDT)
In-Reply-To: <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Jul 2018 18:03:04 +0200
X-Google-Sender-Auth: TYPDr86i-HMHRypduEdciG77o8w
Message-ID: <CAK8P3a0v2Dq7-FhSmo5sKrU6JZ2kyqX2zveL-CN3PqVSQRmckg@mail.gmail.com>
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 7:30 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

> +choice
> +       prompt "CPU MODEL"
> +       default CPU_CK610
> +
> +config CPU_CK610
> +       bool "CSKY CPU ck610"
> +       select CPU_NEED_TLBSYNC
> +       select CPU_NEED_SOFTALIGN
> +       select CPU_NO_USER_BKPT
> +
> +config CPU_CK810
> +       bool "CSKY CPU ck810"
> +       select CPU_HAS_HILO
> +       select CPU_NEED_TLBSYNC
> +
> +config CPU_CK807
> +       bool "CSKY CPU ck807"
> +       select CPU_HAS_HILO
> +
> +config CPU_CK860
> +       bool "CSKY CPU ck860"
> +       select CPU_HAS_TLBI
> +       select CPU_HAS_CACHEV2
> +       select CPU_HAS_LDSTEX
> +endchoice

It looks like the CK8xx CPUs are basically compatible, so it would
be nice to have a way to configure a kernel that can run on all
of them, picking a safe default for options that depend on a
particular CPU. E.g. when only CK860 supports SMP, you might
start out by making SMP "depend on !(CPU_CK807 || CPU_CK810)",
as an alternative to implementing a way for an SMP-enabled kernel
to run on non-SMP CPUs (arm has that, but it's probably too complex
for your needs).

Similarly, you can set L1_CACHE_BYTES to the largest possible
size, and make things like CPU_TLB_SIZE dynamically detected.

> +menu "C-SKY Debug Options"
> +config CSKY_DEBUG_INFO
> +       bool "Compile the kernel with debug info, just add -g"
> +       depends on !DEBUG_INFO
> +       help
> +         DEBUG_INFO and COMPILE_TEST is conflict, so we provide
> +         another way to support -g.
> +         Some drivers eg: DW_MMC need COMPILE_TEST for new cpu
> +         arch :(

Just send a patch to change those dependencies, there is no reason
not to apply those. Generally speaking, the kernel should not contain
workarounds for particular (mis-)features of the kernel, when you can
just change those.

> diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> new file mode 100644
> index 0000000..5de6519
> --- /dev/null
> +++ b/arch/csky/include/asm/Kbuild
> @@ -0,0 +1,72 @@
> +generic-y += asm-offsets.h
> +generic-y += atomic.h

The asm-generic version of atomic.h is a bit inefficient,
you might want to provide an optimized version for your
architecture.

> +generic-y += auxvec.h

You should not need asm/auxvec.h or uapi/asm/auxvec.h

> +generic-y += bitsperlong.h
> +generic-y += bug.h

providing your own bug.h might be helpful too.
Have a look

> +generic-y += bugs.h
> +generic-y += clkdev.h
> +generic-y += cputime.h

asm-generic/cputime.h no loinger exists

> +generic-y += kvm_para.h

Do you support KVM?

> +generic-y += sizes.h

Deprecated and should not be needed

          Arnd
