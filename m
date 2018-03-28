Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2729766-1522256410-2-7592408047829576379
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522256410; b=bYmHS66AbmU/E6+jG2WrDsBHvMq3TDdgDlRPbIonsFge+OG
    4kHfQp7GTJxV0OufYPHPKm3vvMbET0wcFAAgoEOF8xY6PDe7REkOpfYsxjQzRtec
    pZL29g++M16R7yi6mSxUD+6fXDH5YUYNbxiws14XdnsA33SvoCJqSqUAaGXEcs35
    fYShAj1/CzmO4IBo/deguJGJ2J7Zp6reui7FdEeOWZTGEYWEzugnvDu4CycV1+tR
    PnaOK88u+4rGntsB097ZiBTKgw88BRyXI8QJbylwzGGtGLCvzl/i1raJ7DKJfaWg
    9d4oB+MR6XP0WNFw+KDdCrQeKvwbhj5jpT+VbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1522256410; bh=CPdPM3LwLxcdA+gSh17Fed0Qb7oAnHOLZ9fJvX
    Ce/YY=; b=hZ9kbCh51vZtkagpGEAQ4hV3PNxCibT014BG1XpNrGAVG7tGTFYLGt
    op/vETfN1Sc3vNX9D1Qr3bomacnUipdFqaYEWJ4l7rp2qZlhjb8V2ADiqxL1aWkx
    ni9zZVB1oNvycHX0gN3A0V+BULZPOE7jPVM3k42tMGJdQ2CmtzhfTekP5rm9YE5v
    It7AlyCn6FGOfAxQG4GojPXQbUA8izOw3cK1sqR6Cg+41PAgUaEvRg8nND11Z6xw
    eeHEWLA628pPrghwdqyp+cdcXb69fNsTZxUYiQkZsg472uKPBtEy6L6ysKk44uA9
    Pcny3JE2whNSHKLniO8t7EnXO2fXYAlQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=gr6pMACa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=iGsYH/qg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OJrS4i4x;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=gr6pMACa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=iGsYH/qg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OJrS4i4x;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBrYmQE1gbeuZlTuvXNFNxFawH3uwWQ43irimsmTQ0e4auzAYl9JHk1qY102sTXQ57QCEJ9mawNtgJeZbTXgJmrgr9aTqSMMBCE07kTM1nUJ26ZkC+FJ
    LU9LP2CK3uxM/Hz0QHOkXYyFazxQ5jJuvvBixcbcpM/tMA8Kv6ue4b15l5l8BeIEh6G3+mpuZ7UgzzJDrNybM6YVhol5at7XbgrqbL8u674ipgz1p8ehvp4h
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=dYKwY61XRkWUM7whKowA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeC1RAI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 13:00:08 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40296 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeC1RAH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 13:00:07 -0400
X-Google-Smtp-Source: AIpwx496S8sj1SOZ917G/QQ7MCp9mNOzUKOPYUfnNfv84pzpZs+rWjwsbWGfkxMlHsdIkTDNIbZ9v8KOGQcNDcg6nEs=
MIME-Version: 1.0
In-Reply-To: <20180328152115.GB1991@saruman>
References: <1522226933-29317-1-git-send-email-chenhc@lemote.com> <20180328152115.GB1991@saruman>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 10:00:05 -0700
X-Google-Sender-Auth: CiAUwqRpYRkqCJ4B_OZoSVGmCAU
Message-ID: <CAGXu5j+p9fy=fVkBtyXUNH6tmCfraWdZTJCqiRHvyO3vxNxzng@mail.gmail.com>
Subject: Re: [PATCH V4 Resend] ZBOOT: fix stack protector in compressed boot phase
To: James Hogan <jhogan@kernel.org>
Cc: Huacai Chen <chenhc@lemote.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 8:21 AM, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Mar 28, 2018 at 04:48:53PM +0800, Huacai Chen wrote:
>> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
>> index fdf99e9..81df904 100644
>> --- a/arch/mips/boot/compressed/decompress.c
>> +++ b/arch/mips/boot/compressed/decompress.c
>> @@ -76,12 +76,7 @@ void error(char *x)
>>  #include "../../../../lib/decompress_unxz.c"
>>  #endif
>>
>> -unsigned long __stack_chk_guard;
>> -
>> -void __stack_chk_guard_setup(void)
>> -{
>> -     __stack_chk_guard = 0x000a0dff;
>> -}
>> +const unsigned long __stack_chk_guard = 0x000a0dff;
>>
>>  void __stack_chk_fail(void)
>>  {
>> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>>  {
>>       unsigned long zimage_start, zimage_size;
>>
>> -     __stack_chk_guard_setup();
>> -
>>       zimage_start = (unsigned long)(&__image_begin);
>>       zimage_size = (unsigned long)(&__image_end) -
>>           (unsigned long)(&__image_begin);
>
> This looks good to me, though I've Cc'd Kees as apparently the original
> author from commit 8779657d29c0 ("stackprotector: Introduce

I wonder what changed in the compiler -- I regularly boot
stack-protected ARM images. Regardless, this is fine. :)

> CONFIG_CC_STACKPROTECTOR_STRONG") in case there was a particular reason
> this wasn't done in the first place.

I think I was copying from other places? It's been long enough that I
don't remember, actually. :)

> Acked-by: James Hogan <jhogan@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

> (Happy to apply with acks from Kees and ARM, SH maintainers if nobody
> else does).

That'd be fine by me, FWIW. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
