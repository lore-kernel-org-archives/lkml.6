Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1162152F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1162152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeI1SiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:38:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37069 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1SiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:38:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id n6-v6so6326937qtl.4;
        Fri, 28 Sep 2018 05:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WluYTs90xjs5O1/hXjNGnL38ko0c5Rf6MR8HSV7laLw=;
        b=I+Brv6C1CZPa62f4+S4osKWyZDqA7ku13giyICQbPzKM7gS6yaGJOlbDq+nPAJY62U
         G9pDdIRAMBYetwN9tlQ5OzW34TxOeU3/PqCl2Xu+5P0bK/9QkifVDwnSWAJl7bD/nweE
         AFoAlWE5vDwMDB+vVC5WmyQu5Kivjy7RiYhMEP/i1d1uQls7GutXe7h8K644RZ68D9w9
         8kT0gG6rFxwWTrofBz17CvWH5kBE5mm3LnGzq6Q8eF6VuGkyEdm0YoNkiwzLx4sR2rBl
         X5jp+jusrcOcJsQKPi1M4o9i2jZ3f7cFraIev6UYnK1RHntZk2owcO6UrK8G4xJdadw8
         vnWA==
X-Gm-Message-State: ABuFfoieswKdKhAY5WNYUWVMUJoC3WIVKvsBxnDUf5KRf7HPlMfg7hlf
        o2ZujvOSsmTqTJ0v8vCqjoXvO1hCnA6gaeLhtJ0=
X-Google-Smtp-Source: ACcGV60e8cShbNswLP5ERVDVT+wdtnxxL7Nb9YvTnrEmNOpqrV1UfUsv/zKAhkxhrNkS+B9IG2ukjr4Hh+IYfUACAtk=
X-Received: by 2002:aed:316b:: with SMTP id 98-v6mr12523155qtg.9.1538136882604;
 Fri, 28 Sep 2018 05:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org> <1538058267-3765-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538058267-3765-3-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Sep 2018 14:14:26 +0200
Message-ID: <CAK8P3a3ZOC-V0uOD6uD=Hg-AoN8mkJynD6ubpaTppevUvQ54qw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] parisc: add __NR_Linux_syscalls macro with __NR_syscalls
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 4:25 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> 1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually
>    by counting the no.of system calls. No need to update
>    __NR_Linux_syscalls until we either add a new system call
>    or delete an existing system call.
>
> 2. We can keep this feature it above mentioned script, that
>    will count the number of syscalls and keep it in a gener-
>    ated file. In this case we don't need to explicitly update
>    __NR_Linux_syscalls in asm/unistd.h file.
>
> The 2nd option will be the recommended one. For that, I moved
> the __NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/
> unistd.h. The macro __NR_syscalls also added for making the
> name convention same across all architecture. While __NR_sys-
> calls isn't strictly part of the uapi, having it as part of
> the generated header to simplifies the implementation. We also
> need to enclose this macro with #ifdef __KERNEL__ to avoid side
> effects.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/parisc/include/uapi/asm/unistd.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> index bb52e12..255c62a 100644
> --- a/arch/parisc/include/uapi/asm/unistd.h
> +++ b/arch/parisc/include/uapi/asm/unistd.h
> @@ -366,7 +366,11 @@
>  #define __NR_statx             (__NR_Linux + 349)
>  #define __NR_io_pgetevents     (__NR_Linux + 350)
>
> -#define __NR_Linux_syscalls    (__NR_io_pgetevents + 1)
> +#ifdef __KERNEL__
> +#define __NR_syscalls           351
> +#endif
> +
> +#define __NR_Linux_syscalls     __NR_syscalls
>

Hmm, now you have a __NR_Linux_syscalls macro that is defined in user
space to a another macro that is not visible there. How about moving
__NR_Linux_syscalls into arch/parisc/include/asm/unistd.h or
replacing its users with __NR_syscalls instead?

       Arnd
