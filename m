Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B44FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1D120852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="KgiTh/+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1D120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935415AbeFRPGa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:06:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34994 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964788AbeFRPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:06:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id c22-v6so8330200pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7vjN77+/jno5qXEzAbHU4IedwkWZWvdSAvtUazi+EIg=;
        b=KgiTh/+p44//6+Jk9ICR80odAbqKftnhIjrH5Vola7ujb5x/Nx1xIEIBXyMFLrsrGT
         LGb5R87p9n7U45YeQCYPIY2L/OSOGQcYlZ/ERNrq+Ane21VUSWPerLvsRUF+FFcwawIl
         +Lh/uv+9r9T5h/kdDmfXF8sCZjmQTfnwU16goHdrAp6oob6Zu/qt1G8er6ZDnhj4lHks
         4mCdp8gZfbm7GvGGRIdfhQ65sKuQhgWVJiybuA8oB+Tj3btq6wDtGgKTHIpBWBdP87xs
         Z4GIjxIT4Hua/vkYGxzAf0/oO1HsniTrZFF+435GRlApy4f+nfpWIlKBoagavtcBSL2U
         0CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7vjN77+/jno5qXEzAbHU4IedwkWZWvdSAvtUazi+EIg=;
        b=XNDftmMsfCh3fRVqTHrCe81DCWNtfzDQJhJ/KOFw7Aak1iktDwdCJ02AiTHCDY1lN3
         2Nbr0mo8VQr3Da1bQIyXzFoikSmciCJJSJUTOViismbzuCoLxO96DXzHCupgoNKvI+aK
         9qYsfIdOONxsEHkENkM+oiihJ+0fHx/0dKRONdyakZGhMrou2S5B8TqsodPf0TPeX0u+
         us/tGHu2EUFz+ULqhZG1OCqVhdEK83s0+Qsa5HAkSfcngROM1a6mNxT+yOibhmPmssk8
         DvtRpGkxviAwZvrZaxHyFKCaI1FoDBvdgQKK/RjHcq7Xo1i0rtQYprOB30zJAlSYPM+l
         BrlA==
X-Gm-Message-State: APt69E1N0+OZdc/8f+1SPoflJWrErf/C1hQISHDjtbZRxlcCs0/qxUU2
        +ql3qdvyZgBDJj0qXqxGFbXKgs4aVII=
X-Google-Smtp-Source: ADUXVKI0Xi3EXMGSh5f6O18cSs1hDe+iUFxPe8G7gzG3MZG0Fgd8sUFwWI5CzheFlW5Ff882tUph9A==
X-Received: by 2002:a65:50cb:: with SMTP id s11-v6mr11120003pgp.384.1529334385909;
        Mon, 18 Jun 2018 08:06:25 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:06:25 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: RESEND arm+arm64+aarch32 vdso rewrite
Date:   Mon, 18 Jun 2018 08:05:46 -0700
Message-Id: <20180618150613.10322-1-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following 23 patches are rebased and resent, and represent a
rewrite of the arm and arm64 vDSO into C, adding support for arch32
(32-bit user space hosted 64-bit kernels) and into a common library
that other (arm, or non-arm) architectures may utilize.

[PATCH v5 01/12] arm: vdso: rename vdso_datapage variables
[PATCH v5 02/12] arm: vdso: add include file defining __get_datapage()
[PATCH v5 03/12] arm: vdso: inline assembler operations to compiler.h
[PATCH v5 04/12] arm: vdso: do calculations outside reader loops
[PATCH v6 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
[PATCH v5 06/12] arm: vdso: add support for clock_getres
[PATCH v5 07/12] arm: vdso: disable profiling
[PATCH v5 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
[PATCH v5 09/12] arm: vdso: move vgettimeofday.c to lib/vdso/
[PATCH v5 10/12] arm64: vdso: replace gettimeofday.S with global vgettimeofday.C
[PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
[PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
[PATCH] lib: vdso: add support for time
[PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
[PATCH v2 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
[PATCH v2 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
[PATCH] arm64: compat: Expose offset to registers in sigframes
[PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
[PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
[PATCH 3/6] arm64: Refactor vDSO init/setup
[PATCH v2 4/6] arm64: compat: Add a 32-bit vDSO
[PATCH 5/6] arm64: compat: 32-bit vDSO setup
[PATCH 6/6] arm64: Wire up and expose the new compat vDSO

This patch series' above has been applied to the latest Pixel phones
and resulted in a 0.4% battery improvement.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
