Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B629AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3601D2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rjf4sMVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3601D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeIRRZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:25:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46658 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeIRRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:25:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id j131-v6so623157ywc.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/aldVDZj9z2Yd95UlkwZPHy3lcAeyT9c+NA0CgjhlPU=;
        b=Rjf4sMVV3DbCqyYRL4g8IeVGkL+F9oftgfXPOrviRL3AEbgs4yxrbOCmb39DghqvUQ
         wSBv9Tv0mX1DYD0nBfRdTdzeEhXxS/Nv1/C+u6aMnATssBfvRj9CnjKuv6qlTYA56oCd
         y8JG/eXYA+0nIRsqgmKNiftutMNdLW6WRgrGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/aldVDZj9z2Yd95UlkwZPHy3lcAeyT9c+NA0CgjhlPU=;
        b=uD3fF7bNbYAr3iDvaDWUwzFidhVgxGgFhpbYpqWQ+fTINFUovcv6iq6fZMRDCGm4pd
         2X+laLzDS3ZPjZlR0IGfazcFtQNSsI5LLqOmx1VNZX45RcJSQVhT91D6r7hyhjaKx0Qg
         xgzzkurDclgd7E/fYfSTaHd78+Mv3+nu/9VF3wZen09MK2dAE4dnJnRtEnta7IvI/VH8
         Q1Y+ESXW3LsxuSQmbjmFx+bJjUWPsiI7rAYoso6a0mWH/GF07xSQDcqLixOSKFsr8fjk
         abzh6p6agKrvUr0R+11GpfGIVqeAymvwPkteHAm2UtIyS345u2V/7xB08HHIrdiBELvT
         yMyg==
X-Gm-Message-State: APzg51A9g8sY0KzQ2GNKnGgVuA2nFADchuHHIqEaMGdgRdNv3eaqK+ZX
        CB6dpZ/bqzjI3bxdAvbnWrFPYb1EuIw8Sxn9dxPjDw==
X-Google-Smtp-Source: ANB0VdZg9v1Xtk5H0ZfQ/Z+/g93xD34hlgLVAjVYxFPBlJ9oJWt4Pb0K2SzYmBJRHPsqXtnbfjow5N+rful/Rbd4DgU=
X-Received: by 2002:a81:21c1:: with SMTP id h184-v6mr7711317ywh.367.1537271588219;
 Tue, 18 Sep 2018 04:53:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 04:53:07
 -0700 (PDT)
In-Reply-To: <CAK8P3a1JCnSPi+D+CozhqL0dS9WwXtONDHp4=Kg5kCHrpdYwrw@mail.gmail.com>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a1JCnSPi+D+CozhqL0dS9WwXtONDHp4=Kg5kCHrpdYwrw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 17:23:07 +0530
Message-ID: <CALxhOngCL4DEcMD7NaxbUiksByzoxaaozzZGPmB0JFziFEWojw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sparc: Move __IGNORE* entries to non uapi header
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On 6 September 2018 at 20:58, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> +++ b/arch/sparc/include/uapi/asm/unistd.h
>> @@ -15,12 +15,6 @@
>>  #ifndef _UAPI_SPARC_UNISTD_H
>>  #define _UAPI_SPARC_UNISTD_H
>>
>> -#ifndef __32bit_syscall_numbers__
>> -#ifndef __arch64__
>> -#define __32bit_syscall_numbers__
>> -#endif
>> -#endif
>
> This is certainly required in the uapi header as of this patch,
> without it all the numbers are wrong when you include the
> file from user space.
>
> I suppose it can be removed later once the header is replaced
> with the two generated versions,

The script will generate 2 versions, ie, unistd_32.h and unistd_64.h.
Please give few more pointer here.

>
>> -/* Bitmask values returned from kern_features system call.  */
>> -#define KERN_FEATURE_MIXED_MODE_STACK  0x00000001
>
> I'm fairly sure this also needs to remain in the uapi/asm/unistd.h header
> as a start, so that user space can call the sys_kern_features() system
> call and interpret its result when only the first patch is applied.

Sure. I'll update in the next patch series. Thanks!

>
>> -#ifdef __32bit_syscall_numbers__
>> -/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
>> - * it never had the plain ones and there is no value to adding those
>> - * old versions into the syscall table.
>> - */
>> -#define __IGNORE_setresuid
>> -#define __IGNORE_getresuid
>> -#define __IGNORE_setresgid
>> -#define __IGNORE_getresgid
>> -#endif
>> -
>> -/* Sparc doesn't have protection keys. */
>> -#define __IGNORE_pkey_mprotect
>> -#define __IGNORE_pkey_alloc
>> -#define __IGNORE_pkey_free
>> -
>
> This part is fine.
>
>       Arnd
