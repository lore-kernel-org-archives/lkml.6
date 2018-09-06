Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E193C2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E193C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbeIFUEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:04:43 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42565 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeIFUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:04:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so12705035qto.9;
        Thu, 06 Sep 2018 08:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6cQpQ345DsLp02m4kjcmGxLJPLw08FXKuedqrSy6mg=;
        b=hbaCk8mRfU0d8fICXPzJWIdc8H6B2xGGBEXvatPVteCM3WdY+7j5HbmJp6WfPj7SKq
         0APVHw8VN6ASHvuaC6u8RPXJ82TQDDVxoSzNJW0TEOIijo7CaDKvKN+XX26bZN5In5Ia
         8B6MpIJ1I5LKRlDqcK3xPOFhCorUUylpWWWf01jct8y64EICVMT8s537wGucLMFtqZ+r
         cVbJRL5bEHUNSU3EZ8P0XvyLVVNuolZQ0WETKs38jOQJYKT9tNIDKmigFVKSAsTkluGr
         tIItUXdBJXI3tUPJdyTFs40W8GSiwXJNradk0zn8sUpDMuBHQxl/tMTNWywiL9OgI/nv
         y4ew==
X-Gm-Message-State: APzg51AchasQgptVTA2ve+pL+WNCqB9sU9KXel2bpLWOg2obaqOELON2
        O21/v7ZkFn3x5MJkAjXDhXdoU2IowlI5faBbczx/8xMU
X-Google-Smtp-Source: ANB0VdYgwSykMON5V6PMw3d2ey0a+2tVifZeUvCMVD/PihLN4tn0ZZhaJQPmtylLYf78JZQnsi6hfYuUuUg3q3ToEmU=
X-Received: by 2002:ac8:c9:: with SMTP id d9-v6mr2551797qtg.213.1536247721175;
 Thu, 06 Sep 2018 08:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-2-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 17:28:24 +0200
Message-ID: <CAK8P3a1JCnSPi+D+CozhqL0dS9WwXtONDHp4=Kg5kCHrpdYwrw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sparc: Move __IGNORE* entries to non uapi header
To:     Firoz Khan <firoz.khan@linaro.org>
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

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> +++ b/arch/sparc/include/uapi/asm/unistd.h
> @@ -15,12 +15,6 @@
>  #ifndef _UAPI_SPARC_UNISTD_H
>  #define _UAPI_SPARC_UNISTD_H
>
> -#ifndef __32bit_syscall_numbers__
> -#ifndef __arch64__
> -#define __32bit_syscall_numbers__
> -#endif
> -#endif

This is certainly required in the uapi header as of this patch,
without it all the numbers are wrong when you include the
file from user space.

I suppose it can be removed later once the header is replaced
with the two generated versions,

> -/* Bitmask values returned from kern_features system call.  */
> -#define KERN_FEATURE_MIXED_MODE_STACK  0x00000001

I'm fairly sure this also needs to remain in the uapi/asm/unistd.h header
as a start, so that user space can call the sys_kern_features() system
call and interpret its result when only the first patch is applied.

> -#ifdef __32bit_syscall_numbers__
> -/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
> - * it never had the plain ones and there is no value to adding those
> - * old versions into the syscall table.
> - */
> -#define __IGNORE_setresuid
> -#define __IGNORE_getresuid
> -#define __IGNORE_setresgid
> -#define __IGNORE_getresgid
> -#endif
> -
> -/* Sparc doesn't have protection keys. */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> -

This part is fine.

      Arnd
