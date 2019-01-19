Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05393C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9358F2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="t/VVmGyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfASKe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:34:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45539 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfASKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:34:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so17918227wrr.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 02:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkUmWDBjCMtfVKlV4ecOQV/Ujv3/pkXiRQoWHg8eKiI=;
        b=t/VVmGyK+9vB5Atv7O4bhKJCEAmlqnbInUcXPKuklH33fe3/T7hs5iUr7bJodB25eO
         9xlpqtK8R1DnhE9vbFLNnKXnro1kWh6xk0Z5Dwb2c2B+1yJNfYJIuJMECygN1MWylaCr
         u2D1vWep9fPaT92L5hDPzIE5neCrKmGIyoZehfy8MK/WD215qOt2B6AUflzQ5ap1L4AK
         Us2C8YnJp1obfvYim7a5VH2d/fg0DJJXW/6JLl0SBAxgU8r8o8cCa6OPkNJBlb+eOGxx
         XWsk/CNANv9eOzU+h1euPhLosmT8H2mNvch1FcT20juBlRp916tvuwdXx7Moh3H1g6Cj
         re5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkUmWDBjCMtfVKlV4ecOQV/Ujv3/pkXiRQoWHg8eKiI=;
        b=HYzFSW0w5aTSQT14qQqQQHmTAQRbJbvuHktBAo7nsvdLOwZoHDM0oBaokESHsCTLXa
         BE7gCtOJZKQ8t9lHe8F7nOqSXnGYxbPRIO1SJN6+cxfZdLTYpx6B8ixCfZFaLbYbEhet
         hxX2sr/AlhjtSjDUARofE/8bGU3FFjwrTbAx5Gu7NDuUM/56EgpKSF0YuI/EzZ83u1c1
         D37CiAM+vk2GGGX0Leg8UPlKBK7srZSP/tGqIfdB8Hw6McLqVIU99jemWRWkIGP1M4Tz
         YqVRImQmjrfVeTIc+3Bub5P2eNF3+SMiMjmV47YbesmswBripVFNCwxLGaG8Wtz54ry1
         e1nw==
X-Gm-Message-State: AJcUukcbMJ3rfHviEs0L48xfDN6TmAhA4GB8jSIwX4CE08v3yv+CWnhl
        9PO79Ct/fJZVi5F7joQMJm2Uzy3m7bbyzsifn1Qa9Q==
X-Google-Smtp-Source: ALg8bN495QBLZFYLzeE3tFxwmCxmy7a+HOh7IyNyajAK1Kb0tVz3w5uoDtFeuuRZ8UXzbbnyKjNp6kR2Tv+Cinkv//s=
X-Received: by 2002:adf:8506:: with SMTP id 6mr21021554wrh.128.1547894094415;
 Sat, 19 Jan 2019 02:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20190107161047.10516-1-anup@brainfault.org> <20190107161047.10516-2-anup@brainfault.org>
 <20190115134336.GB13216@infradead.org>
In-Reply-To: <20190115134336.GB13216@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 16:04:43 +0530
Message-ID: <CAAhSdy3+aVMyXdECYwTp6=T9DyenEg4Q2uEhmJtfUJDokFbRWg@mail.gmail.com>
Subject: Re: [PATCH 1/5] RISC-V: Move free_initrd_mem() to kernel/setup.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:13 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 07, 2019 at 09:40:43PM +0530, Anup Patel wrote:
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > We move free_initrd_mem() to kernel/setup.c so that all initrd
> > related functions are in one place.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>
> Looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Talking about free_initrd_mem - don't we need to call free_reserved_area
> to actually release the memory?

Yes, we should. Thanks for pointing.

I will include separate patch for it.

Thanks,
Anup
