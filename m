Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D111C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C283E20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YayVZZsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C283E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeKFGRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:17:49 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45361 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeKFGRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:17:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so231878qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8d4NEiGrNkVi8cUcqMimSdQ7N/AwNLqD624fNDd2IK0=;
        b=YayVZZsLIF4xtmlVvlHtSytY4oOLL5cMFW668Wq0oDBxkcJOrDKGnIctr8zXyX9j8s
         009wbHuD2WxfzUHXibkSdOt5abd6Fc0O1kkCgq2bbEH/qtW6VjvL/G0B19/15mhV8Lcu
         sRQekWv7+avY/Xpz7Q2G2/Pe9ur74hGM83BXhczI+mUroVNltasJDnSwcHL5kX8XOq1/
         qWwOcZ3ZagwkaKtc3IDtkUVEvGcuzGkpBNl+EeH71ryD2d1nYNf5ymLiAqEhnIf5KKmz
         6c6vAH7G6No21KPowmdE7u7U9nuFzx6Qi2T8T1jy9Phoc/2uXKMxdRyvt28oVf2sXPIb
         S/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8d4NEiGrNkVi8cUcqMimSdQ7N/AwNLqD624fNDd2IK0=;
        b=JS9IGBKsTL7mKlwAqCYwGFmewvf97KDSll5yHvIvrwR15+1//+mrhuvpwbgJlsxqZb
         pXaQDCLlCafubTZpRr5/wJiIKEVBANSaAyDZn4JKpdyHB44exmUSJpCnltAgLUimzoa6
         gvzlDq3M7bBOYMXq8r7/304zWa3Aj1NkP35bjB44eH2J/m+9v1YR1qicjjMAyzYp9I84
         wP/clLZ74lsyoRy1AGZ2aLMcVVMLIbICMQ7/L0jkO94T23uvg29gqjrhndUyS2vJvmNR
         RipIZZORq4OkMO1PkBH87+hQusAGlM/OMJuxU7Zhuyno8EsU9VoarsRgO5l5XGdi6y0G
         XfjQ==
X-Gm-Message-State: AGRZ1gL3syFa/Hxpls/ZYZSvBCSbnHZzQP7LroIAyNedKrk+O9avHM3g
        9dXEPph3/0slP+X3rl2/w0J921vDfjVDSD9MLLJ6Rg==
X-Google-Smtp-Source: AJdET5fJ0Mz29/8KinlPNPpCOqxGWwbqgBLp0Ws4W2FQbrfpS6yPh62k5qoBzb30e3nduZxSdOjS/GoO0Dm4SZwHKx0=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr23780816qvj.161.1541451375901;
 Mon, 05 Nov 2018 12:56:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 12:56:15 -0800 (PST)
In-Reply-To: <20181105142602.25750-1-david.abdurachmanov@gmail.com>
References: <20181105142602.25750-1-david.abdurachmanov@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 21:56:15 +0100
X-Google-Sender-Auth: GswIWNI4QiZGtCzUUGclOt-oTnA
Message-ID: <CAK8P3a3JcztCSYBuu5ZJXaV83VNLv_1v3v-EKMR+tC1oOsQesw@mail.gmail.com>
Subject: Re: [PATCH] riscv: add asm/unistd.h UAPI header
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, David Abdurachmanov <david.abdurachmanov@gmail.com> wrote:
> Marcin Juszkiewicz reported issues while generating syscall table for riscv
> using 4.20-rc1. The patch refactors our unistd.h files to match some other
> architectures.
>
> - Add asm/unistd.h UAPI header, which has __ARCH_WANT_NEW_STAT
> - Remove asm/syscalls.h UAPI header and merge to asm/unistd.h
> - Adjust kernel asm/unistd.h
>
> So now asm/unistd.h UAPI header should show all syscalls for riscv.
>
> Before this, Makefile simply put `#include <asm-generic/unistd.h>` into
> generated asm/unistd.h UAPI header thus user didn't see:
>
> - __NR_riscv_flush_icache
> - __NR_newfstatat
> - __NR_fstat
>
> which are supported by riscv kernel.
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Thanks for addressing this, your patch correctly fixes riscv64, and
I should have noticed the mistake when I originally merged the
broken patch.

However, looking closer I found another problem with the original
patch that your fix does not address:

__ARCH_WANT_NEW_STAT should only be set on 64-bit
architectures.

For a 32-bit architecture, we only want __ARCH_WANT_STAT64 if
any. For 64-bit architectures with compat mode, we still need to
set __ARCH_WANT_STAT64 from the non-uapi file so we get
the syscall implementation.

If we don't care about the riscv32 ABI changing yet, we can
decide to leave out __ARCH_WANT_STAT64 here, and require
glibc to implement it using statx() like any new architecture.
stat64 is not y2038 safe, and statx replaces it because of that.

> Fixes: 67314ec7b025

That line should be formatted as

Fixes: 67314ec7b025 ("RISC-V: Request newstat syscalls")
