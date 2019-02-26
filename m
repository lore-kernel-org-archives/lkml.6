Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32D921848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw5s3xw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfBZDIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:08:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46499 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBZDIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:08:54 -0500
Received: by mail-io1-f65.google.com with SMTP id k21so9329841ior.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 19:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrVuMGJ672M75OLe5IMZvP3xNwwtC0OfvA+VYUx4w/s=;
        b=Dw5s3xw9drkFLFHuHW73GWhnABEzlNGHOAjgZbydTCDtq1jUpZJJGucKYzxieDVQol
         JQ/2cUyk5Xq8w1b1hqn9UcQxk8LZLU3Wda7RV3rD3cU0ClN6PladenA+A4FIg/3NAYRf
         U4pQYUqx3kiQGgvbh+txBHfPs8bmsppq0wA8Vup26hEywkqIoM9bZU4N1ey1sXR0hGtT
         NucC2MYf6bed3+xQduaj3ThvAtmg/vNVXKtX3kwYLUmkhVdMSb/caHsPp/+I5Xf92hc6
         XqLhWtshSZjB6juyNIkYQbhG/gTPufIvqJnVddhI/KKcWimpK3huq0/LAfK/Vn/j1XeZ
         8o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrVuMGJ672M75OLe5IMZvP3xNwwtC0OfvA+VYUx4w/s=;
        b=macNwA1FGwtmvETvRx69R3wxrgDDEtH0KqltP4PV5ptb5SropXLA6k2fWLtPsHzaVJ
         vy3cBhsIcyrLfc2cni3HvIHyAIHT8/sab1oaHneRNijx0PFRklhU/YYi/VbJ/jhK/7Le
         Or7m+Rk2KAhP9Yrc3TKOTj3kOYsR9Ok8yy4KfAXjeTRxgaGuvulJQ/hmrJOqzlyUKhw/
         J/L76DO8Vgwkd8vrcaDgy+yyi4OS9bj/0uRQ8D+kbcMMOsYZf17tTCNLwOZRTZVbQqt7
         vXXBdaTXo5j+043si+IkjKGiuZ3b3bmMpWGYpnSAfgY/Wey2SqY5zvrQdSeCfaoh1Uqx
         Cc+Q==
X-Gm-Message-State: AHQUAuYXDzdm7h4gO0KgBctEbpWhX6/hI2pGBxxcFWUB9dPXJrXmk/MD
        b6u/AwxQHuSUp9m5Jj/EO3d2d18cgrcYExorIQ==
X-Google-Smtp-Source: AHgI3Ibti7CgyJmoTjyZSUVbTrYfbHjtNIV0k7yaJYaW1iAPEj95rlF2XHyLk2iZgxul9m6mr1iLs8aqrlDA8MXtGLI=
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr10449779iog.281.1551150533602;
 Mon, 25 Feb 2019 19:08:53 -0800 (PST)
MIME-Version: 1.0
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com> <20190225094522.GC26145@zn.tnic>
In-Reply-To: <20190225094522.GC26145@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 26 Feb 2019 11:08:42 +0800
Message-ID: <CAFgQCTtYp5mV0xmt4ZJbS0igBFe8S1ZbUnuTWE1-wj8CuHPJew@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved region
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 5:45 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 25, 2019 at 03:59:56PM +0800, Pingfan Liu wrote:
> > crashkernel=x@y option may fail to reserve the required memory region if
> > KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
> > skip the required region.
>
> Lemme see if I understand this correctly: supplying crashkernel=X@Y
> influences where KASLR would put the randomized kernel. And it should be

Yes, you get it.
> the other way around, IMHO. crashkernel= will have to "work" with KASLR
> to find a suitable range and if the reservation at Y fails, then we tell
> the user to try the more relaxed variant crashkernel=M.
>
I follow Baoquan's opinion. Due to the randomness caused by KASLR, a
user may be surprised to find crashkernel=x@y not working sometime. If
kernel can help them out of this corner automatically, then no need to
bother them with the message to use alternative method crashkernel=M.
Anyway it is a cheap method already used by other options like
hugepages and memmap in handle_mem_options().
If commitment, then do it without failure. Or just removing
crashkernel=x@y option on x86.

Thanks and regards,
Pingfan

> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
