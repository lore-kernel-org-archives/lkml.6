Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2132656-1518717500-2-9031718818422097197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518717500; b=CQATVHRG/fiuXqx+MvU8F1U6vDhcsgqzz780579M8oSLR+v
    S0lvdUoC29g0r9h8QLSNE3v+ERRfmpbLKovI4tIZL1ZuEXK+tFAb+TvNe4Lgmhxu
    ikOFcR2OKqEUXJzQsn3fsh/xPUTdO2iFBhrPjaJCcsooq++7oByLcro8jWyu2xgz
    9qVOqvYEAd8/2RngLn9B/TZ02ILJp8LrwapeW2/V83ciYwZkGHg2hGJlPpYGRR4N
    uW6TXdDG5YgBKgjTPrKUCHet7n1JWvYkJqMYxqdQE22UKgGPv59JQwspTUFfkNZJ
    lgLqLilbqvTm1RRTYv1o4T6sMyaA+khTWGTahFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518717500; bh=z5x3I1D3cw0RfrL1OOWZ3zA6k4gsjiGWdPsWxh
    vt3+c=; b=gs1z+uY2XupeGzbqIkQM++3VMHgK/QWIVM1f2KC/Fk1v5jG9bM4ufQ
    23bLboS1Y6v7+LJaFgDQbB8VnFQzuNBSxTzoUAoEm1cTtrzaD2AXE+b3PNmcPEA7
    w11ADjj7n1Hp+HC5rf8/I2ZXBo7/BmVuRyJh82mUXquThsCna4cgOcbOhBlW1jYI
    tOz414DF2we1vjcqHiN1MUzgCluUn5qFnIwultF8gtRne446u0PJIiE4mTcQy0n3
    0j/M/BfiDxKXLgO0Dxba9utJpdnYHw1G3wbWiZqpHkhgTZ2FlglKqq8ua88hzzlH
    bUbzPaLBDPZPoMhljz7hA3wXF8lFBSqw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kLYNGJ+j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=vNOOTUXV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CT2nKYob;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kLYNGJ+j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=vNOOTUXV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CT2nKYob;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031771AbeBOR6E (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 12:58:04 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34699 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034079AbeBOR6B (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 12:58:01 -0500
X-Google-Smtp-Source: AH8x224mXTfx3OQzHwyvtaXGEO/bivBrflzZIuah3pY4lUuhOl/ltiBgdCs2oqGWgI2jmZGlB1mX+QaCdBQCukSuRnA=
MIME-Version: 1.0
In-Reply-To: <20180215151710.1473117-2-arnd@arndb.de>
References: <20180215151710.1473117-1-arnd@arndb.de> <20180215151710.1473117-2-arnd@arndb.de>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Feb 2018 09:58:00 -0800
X-Google-Sender-Auth: xYqn-MN6OH54z0IdHwLd-G5lWHM
Message-ID: <CAGXu5jKH1N3nqmRLnRiieGS-YpXj+dptDAB65ZgBWx+Ey3mCdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [stable-4.9] x86: fix build warnign with 32-bit PAE
To: Arnd Bergmann <arnd@arndb.de>
Cc: "# 3.4.x" <stable@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 7:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I ran into a 4.9 build warning in randconfig testing, starting with the
> KAISER patches:
>
> arch/x86/kernel/ldt.c: In function 'alloc_ldt_struct':
> arch/x86/include/asm/pgtable_types.h:208:24: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>  #define __PAGE_KERNEL  (__PAGE_KERNEL_EXEC | _PAGE_NX)
>                         ^
> arch/x86/kernel/ldt.c:81:6: note: in expansion of macro '__PAGE_KERNEL'
>       __PAGE_KERNEL);
>       ^~~~~~~~~~~~~
>
> I originally ran into this last year when the patches were part of linux-next,
> and tried to work around it by using the proper 'pteval_t' types consistently,
> but that caused additional problems.
>
> This takes a much simpler approach, and makes the argument type of the dummy
> helper always 64-bit, which is wide enough for any page table layout and
> won't hurt since this call is just an empty stub anyway.
>
> Fixes: 8f0baadf2bea ("kaiser: merged update")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/kaiser.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/kaiser.h b/include/linux/kaiser.h
> index 58c55b1589d0..b56c19010480 100644
> --- a/include/linux/kaiser.h
> +++ b/include/linux/kaiser.h
> @@ -32,7 +32,7 @@ static inline void kaiser_init(void)
>  {
>  }
>  static inline int kaiser_add_mapping(unsigned long addr,
> -                                    unsigned long size, unsigned long flags)
> +                                    unsigned long size, u64 flags)
>  {
>         return 0;
>  }
> --
> 2.9.0
>

Acked-by: Kees Cook <keescook@chromium.org>

I assume this is needed for 4.4 as well...

-Kees

-- 
Kees Cook
Pixel Security
