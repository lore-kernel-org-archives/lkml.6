Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E823C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED4721903
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQiQma1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBIE0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:26:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35953 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBIE0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 23:26:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so9458356otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 20:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZJDGOMdtOXRFRWAYeO/KPnzhNLntdqWpebs0iRo8YA=;
        b=VQiQma1l4XjIR6eEGYzmQfvOVEYwLgceJHo0bDOsEo1p6z5vRQGwFKhxpGhjlbyRrR
         HyLSsDt87agl/M6yKmMUGdaXQbzAwIrAjNtUJstv0ieTecrSia2QMV3ymJK+Wi6GTgpw
         2RrQWl3Zc2zQfy94Sk0ycwsaJnEWoxXwfBP5azefsYQVZXMf9e8lFBqy7PWXVjHF3yEj
         vo3OtaquHHe187nNaAdfhzTYQWt+5LQFlNsG9IKrSY0MEBGDcNQ1j82kEZJEbfY8m5du
         bEDU5gMmESUu+P7l6hGBqk/Ejy78DxtTFn/tv8cjKB9sqBoFm/xEyA4kljHabelzg4Ad
         H+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZJDGOMdtOXRFRWAYeO/KPnzhNLntdqWpebs0iRo8YA=;
        b=ILr89dlGm2Qd7u996ShoQxyRJVobBUF++ULK2ve4FZdIkrAN/3FFNX6UvxIZ5ByIIz
         XnnXsYuMGkPhZt9+vXP5q2BLwgK2f35r6TYHuZPUwyahVaJnd4bOuwAbh+N+g51usIYo
         LJdVoNMSdVTyGvlIc7uxc4jnFBuEu6eAIvD+CKhRPOYV3W/NkoWNyGU37hpzR+exy/jH
         n4rIqeSF6QsFrYT9opS/4vlzrguyXM/juEvj+tuOLjJkkKbA/UbcbecUR9r99I7SPutu
         lRXEkxCj5o03O2vl3R4NdMssO6bhX+C++IqbbwhpUbgcRFcD6Ek3acLFb6gQx6gTvFgP
         w2lg==
X-Gm-Message-State: AHQUAubSkkPd705ldqyghYDMdHWEI9bpCstQF/7kNY+QRdOIbEou1M9c
        15hhzVgWGNttWkz2jBb1Sr3hzno1Vo20zLgv4y4=
X-Google-Smtp-Source: AHgI3IbKMEU/Wcgm9oUmuK1GMSHmJdaqpMETuAn7dHhzWPQrK7BECwfAXT0yMi5hh2N30KuxUY+R7FX+l+sEFXxm2kc=
X-Received: by 2002:a9d:137:: with SMTP id 52mr16706091otu.307.1549686379154;
 Fri, 08 Feb 2019 20:26:19 -0800 (PST)
MIME-Version: 1.0
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
 <1549590681-24125-9-git-send-email-atish.patra@wdc.com> <20190208091133.GD16932@infradead.org>
 <8f5fd0c8-0320-00b1-4ddf-b1225be352c8@wdc.com>
In-Reply-To: <8f5fd0c8-0320-00b1-4ddf-b1225be352c8@wdc.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Sat, 9 Feb 2019 05:26:07 +0100
Message-ID: <CAEn-LTqx8CQ7kY3kRKWFoAkSSu_FNoZkd9JnNYDNLAYX1kLHSA@mail.gmail.com>
Subject: Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 12:03 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 2/8/19 1:11 AM, Christoph Hellwig wrote:
> >> +     * We don't support running Linux on hertergenous ISA systems.
> >> +     * But first "okay" processor might not be the boot cpu.
> >> +     * Check the ISA of boot cpu.
> >
> > Please use up your available 80 characters per line in comments.
> >
> I will fix it.
>
> >> +            /*
> >> +             * All "okay" hart should have same isa. We don't know how to
> >> +             * handle if they don't. Throw a warning for now.
> >> +             */
> >> +            if (elf_hwcap && temp_hwcap != elf_hwcap)
> >> +                    pr_warn("isa mismatch: 0x%lx != 0x%lx\n",
> >> +                            elf_hwcap, temp_hwcap);
> >> +
> >> +            if (hartid == boot_cpu_hartid)
> >> +                    boot_hwcap = temp_hwcap;
> >> +            elf_hwcap = temp_hwcap;
> >
> > So we always set elf_hwcap to the capabilities of the previous cpu.
> >
> >> +            temp_hwcap = 0;
> >
> > I think tmp_hwcap should be declared and initialized inside the outer loop
> > instead having to manually reset it like this.
> >
> >> +    }
> >>
> >> +    elf_hwcap = boot_hwcap;
> >
> > And then reset it here to the boot cpu.
> >
> > Shoudn't we only report the features supported by all cores?  Otherwise
> > we'll still have problems if the boot cpu supports a feature, but not
> > others.
> >
>
> Hmm. The other side of the argument is boot cpu does have a feature that
> is not supported by other hart that didn't even boot.
> The user space may execute something based on boot cpu capability but
> that won't be enabled.
>
> At least, in this way we know that we are compatible completely with
> boot cpu capabilities. Thoughts ?

There is one example on the market, e.g., Samsung Exynos 9810.

Mongoose 3 (big cores) only support ARMv8.0, while Cortex-A55
(little ones) support ARMv8.2 (and that brings atomics support).
I think, it's the only ARM SOC that supports different ISA extensions
between cores on the same package.

Kernel scheduler doesn't know that big cores are missing atomics
support or that applications needs it and moves the thread
resulting in illegal instruction.

E.g., see Golang issue: https://github.com/golang/go/issues/28431

I also recall Jon Masters (Computer Architect at Red Hat) advocating
against having cores with mismatched capabilities on the server market.

It just causes more problems down the line.

david
