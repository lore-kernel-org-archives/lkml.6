Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2759B20863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fCeSipX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2759B20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440550AbeKXDVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:21:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36918 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440517AbeKXDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:21:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so9104156lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3xrEEUbHwKw2xJRMNjlf1Bgxy87ZXsSAJY1K9y7IBc=;
        b=fCeSipX1LZaY1oBv/rcSHCsmT5Xatt45+mDPzeOLQboYdNDU0lwkF+2vo2pOxvgh14
         pwSpSpK9ca8gYmWzUwy6DfrDvcLIe0UykxlDD33zaOBkuoYn75RIUyL8rRRc/01v5dYr
         WuSe/lxO/tels0bF05hv556UcJT5ZH28xRsog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3xrEEUbHwKw2xJRMNjlf1Bgxy87ZXsSAJY1K9y7IBc=;
        b=RbIHLxI2ZIwu/Y3PDdY4/v35UXpKLQWimVdQ3JMDJB35SW9dF7uGGh/T59Er5uqguj
         qqcsPGgVOKvtjfjH4EfcqzHHv7P0VDZn2us2Q5RyBZAUJrjwdLLqPTZEyxt+M8HRi7iK
         V5lw1s3gwFfWoePN6C28V+M77ugn5EpIm7aBwL3ih6wpflP6KZKVWvv5gf1Y30QtK/Py
         ujXZK51l710K14eTXWoMm+AA23uz2ZD3uUeQMxCUsGCn+da1f++X1DGkEDcUpJofb/bZ
         FukaK36shmDa5Ccz7Gq29bzMonSY7wqMsvfeG0HGopwfrNoj0yUChV4elafn8Plc/uok
         3Q7Q==
X-Gm-Message-State: AGRZ1gKJIwMjhvhyElnO9QO1Sgn0MK8SQ00p7dVBEhVslX6VzLHZSXXU
        Tsn3yRjZr32eZUnW2OkGXBei+lqE7Dzu+Q==
X-Google-Smtp-Source: AJdET5fN74cTMpWiusbpJwZ0lnmz0zvUdtzvMkglvBWfFoTgllaUN8onrszKymYOblDHz6yFhigk/w==
X-Received: by 2002:a19:c801:: with SMTP id y1mr9400157lff.53.1542990980008;
        Fri, 23 Nov 2018 08:36:20 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e5-v6sm5580049ljj.91.2018.11.23.08.36.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 08:36:18 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id v5so9080153lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:36:18 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr10250691lfc.124.1542990977654;
 Fri, 23 Nov 2018 08:36:17 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
 <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com> <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
In-Reply-To: <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Nov 2018 08:36:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
Message-ID: <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     David.Laight@aculab.com
Cc:     Andrew Lutomirski <luto@kernel.org>, dvlasenk@redhat.com,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 2:12 AM David Laight <David.Laight@aculab.com> wrote:
>
> I've just patched my driver and redone the test on a 4.13 (ubuntu) kernel.
> Calling memcpy_fromio(kernel_buffer, PCIe_address, length)
> generates a lot of single byte TLP.

I just tested it too - it turns out that the __inline_memcpy() code
never triggers, and "memcpy_toio()" just generates a memcpy.

So that code seems entirely dead.

And, in fact, the codebase I looked at was the historical one, because
I had been going back and looking at the history. The modern tree
*does* have the "__inline_memcpy()" function I pointed at, but it's
not actually hooked up to anything!

This actually has been broken for _ages_. The breakage goes back to
2010, and commit 6175ddf06b61 ("x86: Clean up mem*io functions"), and
it seems nobody really ever noticed - or thought that it was ok.

That commit claims that iomem has no special significance on x86, but
that really really isn't true, exactly because the access size does
matter.

And as mentioned, the generic memory copy routines are not at all
appropriate, and that has nothing to do with ERMS. Our "do it by hand"
memory copy routine does things like this:

.Lless_16bytes:
        cmpl $8,        %edx
        jb   .Lless_8bytes
        /*
         * Move data from 8 bytes to 15 bytes.
         */
        movq 0*8(%rsi), %r8
        movq -1*8(%rsi, %rdx),  %r9
        movq %r8,       0*8(%rdi)
        movq %r9,       -1*8(%rdi, %rdx)
        retq

and note how for a 8-byte copy, it will do *two* reads of the same 8
bytes, and *two* writes of the same 8 byte destination. That's
perfectly ok for regular memory, and it means that the code can handle
an arbitrary 8-15 byte copy without any conditionals or loop counts,
but it is *not* ok for iomem.

Of course, in practice it all just happens to work in almost all
situations (because a lot of iomem devices simply won't care), and
manual access to iomem is basically extremely rare these days anyway,
but it's definitely entirely and utterly broken.

End result: we *used* to do this right. For the last eight years our
"memcpy_{to,from}io()" has been entirely broken, and apparently even
the people who noticed oddities like David, never reported it as
breakage but instead just worked around it in drivers.

Ho humm.

Let me write a generic routine in lib/iomap_copy.c (which already does
the "user specifies chunk size" cases), and hook it up for x86.

David, are you using a bus analyzer or something to do your testing?
I'll have a trial patch for you asap.

               Linus
