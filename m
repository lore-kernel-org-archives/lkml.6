Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFDEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613A520892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613A520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeKHGmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:42:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43570 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeKHGmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:42:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so22943455qkr.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 13:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/354RJktfWO3Xv0X4oRS/MwprSK52O+Iss7VIFmrPCA=;
        b=LGRkVcse5aoBczAa+8lGndK3GrC9Dq3O6X66dVVfMYZhBVGl0Blr2VKpwrMEl+h2wg
         RbCtnfolSTHTXfUzrxYLd3H2SUfhsT3J5Lwm4mL6pm9ayIz17QVqeJwBeERgL+upWQrz
         LrNo82XmDb6iBRqSXnHkqBLDfufBNwaDsRwXQbwlWDJ71Iku/dRW6gWre4O1Atz6/Neq
         shf01Oyh7PjQ0dvyXuleBxzsiYue/KIJx1d1owZUKOlxX63KR7eYToG3xQRX9XhhYieS
         onA2wUGSQB4h8UqwWqqkf6ObzERr5jq/bEeTr8EIN9GksX4WGX79UQ2OOV5eenbCJnyZ
         7FWA==
X-Gm-Message-State: AGRZ1gIyzmIyssthd89vTglPf6/78WPgaE2ezPOdLtfOSRH01NGrVhI5
        RgG5r5ZMpXXlTF8cyYmW8Ko36b6vDWDYFwD7X1M=
X-Google-Smtp-Source: AJdET5dWhffFHUu7ZBoRk2k1Xds+Ikbp4k6UXVNUOvLdhMLXUvvYGJXNGas97+IHnJoQZuTJ58TZ4WJzzzpen9pkmQM=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr1864644qvm.149.1541624998627;
 Wed, 07 Nov 2018 13:09:58 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a3JcztCSYBuu5ZJXaV83VNLv_1v3v-EKMR+tC1oOsQesw@mail.gmail.com>
 <mhng-3c26b2fb-0c11-42f2-9026-1113b200a7b2@palmer-si-x1c4> <CAEn-LTpQ5uTte2bBrEs3uLKtsckkKPUOP+jHw5k-DFAwGCS3WA@mail.gmail.com>
In-Reply-To: <CAEn-LTpQ5uTte2bBrEs3uLKtsckkKPUOP+jHw5k-DFAwGCS3WA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 22:09:39 +0100
Message-ID: <CAK8P3a30Dmq3vp-+=jvVu8VMe+GKc9dU=+ZF0rzhFiUq2NuJ_w@mail.gmail.com>
Subject: Re: [PATCH] riscv: add asm/unistd.h UAPI header
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 7:30 PM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
> On Wed, Nov 7, 2018 at 1:08 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> > On Mon, 05 Nov 2018 12:56:15 PST (-0800), Arnd Bergmann wrote:

> > The target is still the next glibc release (Feb 1st) for a stable RV32I ABI.
> > That's progressing well, with one last blocking issue related to some of our
> > floating-point emulation routines before we can submit the port.  This should
> > give us ample time to line up the ABIs correctly so everything works.
> >
> > So I think the correct answer here is to drop __ARCH_WANT_STAT64 from RISC-V.
> >
>
> Then if you agree I could do and send v2:
>
> +#ifdef __LP64__
> +#define __ARCH_WANT_NEW_STAT
> +#endif /* __LP64__ */

Looks good to me.

> Cannot use CONFIG_64BIT as in user space nothing defines it.
> Alternatively I could
> check for __riscv_xlen == 64.
>
> I found _LP64 and __LP64__ being used in kernel, incl. include/uapi/linux/rseq.h

I think older gcc versions were less consistent about those macros, which
is why I introduced __BITS_PER_LONG a long time ago. We now support
gcc-4.6 as the minimum, so using __LP64__ is reliable, and on RISC-V
we obviously have a much newer compiler anyway.

        Arnd
