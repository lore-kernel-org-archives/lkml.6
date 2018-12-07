Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C178C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3226320892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFhvaXJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3226320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLGL3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:29:10 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51456 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:29:09 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so6382292itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 03:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ot6c88os2Gn6TzPw7vDz+A24xuzPne5JzOuN2I+iXs4=;
        b=MFhvaXJS6ddf5JyHcbeNRshml2CqrEFX+30Qcf6T0CFdNBtZ+UFoCP+QJgXFCTkhwi
         lUWMqJ4v39xxFG7WuFo3A2pzAZDpsrRWzEpq0JsRnYlk3HRr9/AcGJus5yeEEwV4szRk
         XN2hAiEV3gLipXh/z1WMCEfI1nZ6PAxDN1HFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ot6c88os2Gn6TzPw7vDz+A24xuzPne5JzOuN2I+iXs4=;
        b=ZZ4mb1UHUOSNiVgSU9auhzubrMeNvOB+earLqZBjkuBZakU4zHo3xe8j/tFNPVZilJ
         ytd5SDb9VfXVKwtztSKQj/Jx8Uokb6UijV2g4gsEdLEZFG3I6MT5vjI2sR9SB+5uknMi
         3ysGHTlrxuVaCWtOFbQao5tVroTTfiKVCvyL5w6hKt/kKLvgtRTQ2LNSQ4WT10Q1OK79
         4rngn35qQrs5JL4wff5TPl52q6tgZ/UQOxWq99vEyfgs27JRf5oig1scoEyFXa/6c8hh
         AlQ9EyJ/NT/enreUMKu7Bzbpf1Sl/lArjcEEZDZGQqyTUa7oN4ssb+QtQSGoS1pxyU/9
         qBjw==
X-Gm-Message-State: AA+aEWZJTlSCBQJJFy7TxkifZUHEmeUd4Y4n43k6HKY4O82CRe2I7/YN
        lzi2aPuicUil/ybWk1TQpcdCl26BZ42mclXYywMOGg==
X-Google-Smtp-Source: AFSGD/XSvbbs0ADm7usOLOed0BCtNUDIiA4NfG5Qc6vpMWQJH97M1Gez1BQkMBmHZc7f7ALrSGy/0ex8zBitlAjdnDQ=
X-Received: by 2002:a24:710:: with SMTP id f16mr1490200itf.121.1544182148356;
 Fri, 07 Dec 2018 03:29:08 -0800 (PST)
MIME-Version: 1.0
References: <1543517152-23969-1-git-send-email-cai@gmx.us> <20181206161633.36292-1-cai@gmx.us>
 <20181206175958.GS54495@arrakis.emea.arm.com> <CAKv+Gu97MU5kU878gF=KBLxQ5GjZatAbJ-LVdKv-QMgdPh3kZQ@mail.gmail.com>
 <1544119499.12945.48.camel@gmx.us>
In-Reply-To: <1544119499.12945.48.camel@gmx.us>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Dec 2018 12:28:57 +0100
Message-ID: <CAKv+Gu9ugNxoST=cc9utWNtoYFdPng0FgNfV-Mw0UWyJiKqOLw@mail.gmail.com>
Subject: Re: [RESEND PATCH] efi: let kmemleak ignore false positives
To:     Qian Cai <cai@gmx.us>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 19:05, Qian Cai <cai@gmx.us> wrote:
>
> On Thu, 2018-12-06 at 19:01 +0100, Ard Biesheuvel wrote:
> > On Thu, 6 Dec 2018 at 19:00, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Thu, Dec 06, 2018 at 11:16:33AM -0500, Qian Cai wrote:
> > > > unreferenced object 0xffff8096c1acf580 (size 128):
> > > >   comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
> > > >   hex dump (first 32 bytes):
> > > >     80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ................
> > > >     00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
> > > >   backtrace:
> > > >     [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
> > > >     [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
> > > >     [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
> > > >     [<00000000edf04e07>] its_cpu_init+0x104/0x150
> > > >     [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
> > > >     [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
> > > >     [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
> > > >     [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
> > > >     [<0000000015137d6a>] 0xffffffffffffffff
> > > >
> > > > efi_mem_reserve_persistent+0x50/0xf8:
> > > > kmalloc at include/linux/slab.h:546
> > > > (inlined by) efi_mem_reserve_persistent at drivers/firmware/efi/efi.c:979
> > > >
> > > > This line,
> > > >
> > > > rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
> > > >
> > > > Kmemleak has a known limitation that can only track pointers in the kernel
> > > > virtual space. Hence, it will report false positives due to "rsv" will
> > > > only
> > > > reference to other physical addresses,
> > > >
> > > > rsv->next = efi_memreserve_root->next;
> > > > efi_memreserve_root->next = __pa(rsv);
> > > >
> > > > Signed-off-by: Qian Cai <cai@gmx.us>
> > >
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>\
> >
> > I don't see the patch and I wasn't cc'ed
>
> That is strange. Please see,
>
> https://lore.kernel.org/lkml/1543517152-23969-1-git-send-email-cai@gmx.us/

OK, I found it in my spam folder, apologies for that.

This kmalloc() will be replaced in the next merge window by a call to
__get_free_page(). Does kmemleak still require the kmemleak_ignore()
for that case? Or is it only for kmalloc()?
