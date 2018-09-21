Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD1ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118972086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gER0GhId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118972086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbeIUKR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:17:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33045 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388770AbeIUKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:17:27 -0400
Received: by mail-io1-f67.google.com with SMTP id r196-v6so10974317iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 21:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6AbShs0QR8rjlZojeQDCrptWulzxwuMysCC75u0Bsnc=;
        b=gER0GhIdbyh96URTg6/xW0CwEiPB5dpHeal8pdxaCSkrnLbh9Db270LjjvQxF8EVK6
         QniSJ0VtThFFw5CNJAnsYQE4zO0lSihJ+cQ5nVFSrCuywCnmZOWBepRel5MNWLkc5AeY
         sO/3mvzxLek+RDfpgkeVl874NAnFK9LqL6g/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6AbShs0QR8rjlZojeQDCrptWulzxwuMysCC75u0Bsnc=;
        b=hJmmkwW+dr+S/2IIyLGDCITbEoFoOTWIxIxZJ2BjwUqQxNCn195hT1ArC7y3gFrUQv
         Y7pEo8tCXfSn7M2ARkO7WGoS/1di79gCk2r07svb2OrOLnpn7X2Me9UuOI9Z/Auo/mty
         PUW9CUk7hodpHdXdzgG8SUl0MFOlt/rEM/TTyA7KML70v8zXuZ+Tj8+iPe6TMgr+C2eI
         seBbc0/znmNT6ZJlm6w7y4gt+mbVLbHDDfupGCREfwmdbhxWsc3cDAfqXPWhEUDfhv14
         ipEWc8gL4Hn/d5J0Q4ovxHY86CwSb5UoZL5Qh7qgXHuJXf5VkRbGuqHjk1zNsMDsBH5l
         CXEw==
X-Gm-Message-State: APzg51A1oN7sr5mZzlr5DhcqaLC2wHD+Jy00f+4lc/n1LFwVRG/DYvrf
        fPNATVNYA7Vdb2b/JJFO6oujS/ishUT0r/KxrOEoeg==
X-Google-Smtp-Source: ANB0Vda3VnUy3rGgTK0GNnvbCl0EonsEvtjT+iJzlVz3THrk8UZd9O9zF7uyaLv2o3EehbE1BTAM2tunJEZSOmv5umw=
X-Received: by 2002:a6b:ba86:: with SMTP id k128-v6mr34692615iof.170.1537504226877;
 Thu, 20 Sep 2018 21:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 21:30:26
 -0700 (PDT)
In-Reply-To: <CAHmME9rF=FfOf-_EOB-BeT-BM=B9Q9YzFAoUimaPiM2RKb5sGA@mail.gmail.com>
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
 <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
 <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com>
 <20180921031255.GB11109@lunn.ch> <8FA361E3-FBCB-469E-88DC-F4085BD91175@amacapital.net>
 <CAHmME9rF=FfOf-_EOB-BeT-BM=B9Q9YzFAoUimaPiM2RKb5sGA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 20 Sep 2018 21:30:26 -0700
Message-ID: <CAKv+Gu-sciHeWVij8hWGF78HV_CLddMv7Xdf1GRSY+6B2yt48A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 September 2018 at 21:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Andy,
>
> On Fri, Sep 21, 2018 at 5:23 AM Andy Lutomirski <luto@amacapital.net> wro=
te:
>> At the risk on suggesting something awful: on x86_64, since we turn pree=
mption off for simd, it wouldn=E2=80=99t be *completely* insane to do the c=
rypto on the irq stack. It would look like:
>>
>> kernel_fpu_call(func, arg);
>>
>> And this helper would disable preemption, enable FPU, switch to the irq =
stack, call func(arg), disable FPU, enable preemption, and return. And we c=
an have large IRQ stacks.
>>
>> I refuse to touch this with a ten-foot pole until the lazy FPU restore p=
atches land.
>
> Haha. That's fun, and maybe we'll do that at some point, but I have
> some other reasons too for being on a workqueue now.
>

Kernel mode crypto is callable from any context, and SIMD can be used
in softirq context on arm64 (and on x86, even from hardirq context
IIRC if the interrupt is taken from userland), in which case we'd
already be on the irq stack.

>>
>> All that being said, why are these frames so large?  It sounds like some=
thing may be spilling that ought not to.
>
> They're not. Well, they're not anymore. I had a silly thing before
> like "u8 buffer[1 << 12]" in some debugging code, which is what
> prompted the ccflag-y addition. I cleaned up the mistakes like that
> and frames are now reasonable everywhere. Non-issue.
>

Did any of the fuzzing/testing you mention in the cover letter occur
on the kernel versions of these algorithms?
