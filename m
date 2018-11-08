Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B59AC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E5F20685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkg5ydbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E5F20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeKHUNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:13:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42328 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:13:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id n46so13437405otb.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIPOAKMwJeHPUZIv+fRJ7M0KKDeAFvDEIIu4jLul4ts=;
        b=Qkg5ydbDOPXjxWc2y9lflI940ZAqznNhW0Zwj7/SMbTmfKbRYLYb0vCU90yM06dmbb
         FpFlsJhOy14jvenujSV+9YUzk3OVUWNn/37WctUxAePQJnoEFaPed0jrjo8JFsm0l6vT
         jSICY09sGLdL/u9DFvIuAph7ZrxPyCZYxzNsvjYGH2uAZRbUDHWnFr7OtQE0cLRnp2pD
         KAfOI2zywl4K0HIDZQQ7vuXHI8qMMl4Zqykt/Gml26NunQusfQIq+ktTTE+rsEKtdpwY
         bqOUYu0inAc0zGbxQtsdBmiZIeqbSGCahKwXhrRTD42vFw7l1c7W4aL8dOZe6hE+HhCu
         6cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIPOAKMwJeHPUZIv+fRJ7M0KKDeAFvDEIIu4jLul4ts=;
        b=IUlDlqh6Tk9yk24x9E7Cn97p/av53KRKUZmCj7p+Qy1Ngc9fCQkLr5eCybzj/zQtau
         yVYw2JMDXWm2AgW3ye4vnTUY5els/+xB835/W0U+DJcspbJPiMlF/gAHjmHAKx5uRTvx
         Bnf0EhpcCZCTQESXdUG0mPxycPLZ2uYchhPi9oreI5sZ5UGA0vXygxT3S3mykfvROPRu
         ACBAOZ/2toleESfR2uSv0AP3zTfERcSDh1d2l8gybcYFdFQ4rR4e7Wnm3tkUyiJ8JHTs
         TjDcYIvyORe6A99jI9ZMI1El/2cjS53D2dmt8VBVdFoqUSqctmoWVU8/xOHBz2NhNWeR
         rfGg==
X-Gm-Message-State: AGRZ1gJ/XkJi6jzkv3AWZl5EcB/Db5Q2TiJBImNl0HqO55BlzMhqLjsK
        km17MCTWyuS99vIlH75fxc9OYPKnTYXHgeDtuKI=
X-Google-Smtp-Source: AJdET5ecBAYdZh/BBViixUSEzOUpNE/adi4HGCg8qjrX1rrQLGkj+J1CzIFzGaUzsfDxww+3QrEwvLSz2qa5grIUjOI=
X-Received: by 2002:a9d:2fac:: with SMTP id r41mr2256574otb.169.1541673513329;
 Thu, 08 Nov 2018 02:38:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a30Dmq3vp-+=jvVu8VMe+GKc9dU=+ZF0rzhFiUq2NuJ_w@mail.gmail.com>
 <mhng-23f94805-b961-4e68-a4c1-7d79b60bd925@palmer-si-x1c4>
In-Reply-To: <mhng-23f94805-b961-4e68-a4c1-7d79b60bd925@palmer-si-x1c4>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Thu, 8 Nov 2018 11:38:22 +0100
Message-ID: <CAEn-LTqCT-u0_QNdOSf3bLKYa5S2vz4T0X5yKmnS1AE4pDYOkg@mail.gmail.com>
Subject: Re: [PATCH] riscv: add asm/unistd.h UAPI header
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 3:10 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 07 Nov 2018 13:09:39 PST (-0800), Arnd Bergmann wrote:
> > On Wed, Nov 7, 2018 at 7:30 PM David Abdurachmanov
> > <david.abdurachmanov@gmail.com> wrote:
> >> On Wed, Nov 7, 2018 at 1:08 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >> > On Mon, 05 Nov 2018 12:56:15 PST (-0800), Arnd Bergmann wrote:
> >
> >> > The target is still the next glibc release (Feb 1st) for a stable RV32I ABI.
> >> > That's progressing well, with one last blocking issue related to some of our
> >> > floating-point emulation routines before we can submit the port.  This should
> >> > give us ample time to line up the ABIs correctly so everything works.
> >> >
> >> > So I think the correct answer here is to drop __ARCH_WANT_STAT64 from RISC-V.
> >> >
> >>
> >> Then if you agree I could do and send v2:
> >>
> >> +#ifdef __LP64__
> >> +#define __ARCH_WANT_NEW_STAT
> >> +#endif /* __LP64__ */
> >
> > Looks good to me.
>
> This is a bit pedantic, but I'm not sure what the right answer is here:
> "-march=rv64gc -mabi=ilp32d" will not define __LP64__, but will define
> "__riscv_xlen == 64".  I actually don't know enough about how an rv64gc/ilp32d
> ABI would work to answer this: would we have "long long" all over our syscalls?
>
> Probably not worth worrying about for now, as we'll have to go audit all of
> these if we ever end up with an ilp32 ABI.  So just go for it and we'll throw
> this on the pile to deal with later :)

GCC will not allow "-march=rv64gc -mabi=ilp32d":

    cc1: error: ABI requires -march=rv32

I see that arch/riscv/include/uapi/asm/elf.h already use __riscv_xlen so to be
consistent I will use it too (but I like __LP64__ more as it is well
known macro).

Looking at other UAPI headers I see that include/uapi/linux/rseq.h is using
__LP64__ macro. This header is installed on riscv.
