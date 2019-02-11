Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8792BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FD520863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N+v7LreT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbfBKTCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:02:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45803 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBKTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:02:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so5350578pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+4TfL/o8ePF0fI2rvClWd5kU9XAo5kGOyfgSfeCu4R4=;
        b=N+v7LreTPw8gE1xv4G41vgn5iaVikZDofR5Bg6lzAKfr8xutniUnq5QWpN8ufNMjkI
         7D1J4ll9qbhPsjoUFXI6zc22/qahNaxYe8bhILwgc0PDsuECOUVtsyyXI8BWuoxUyFju
         OUI3LOZR/v/by9cYctqbnDs9P3SbmITfn4RdG0pee2mivStr2gtQxPYnN3YpQUGC/MgZ
         1SAHcpKB5OSBLVunX+2XrwhCVIHJ1Mfk3FJ3EnvWegA6jwWM9RyLxpx9yLBfCWXL2rHx
         9n4CGJ7po/mYbwI3oLn22TdCLZeCbsbd7cKZX8NkP6kf8tgIrp9ItvFYsi+EQxoEJqp4
         VIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+4TfL/o8ePF0fI2rvClWd5kU9XAo5kGOyfgSfeCu4R4=;
        b=EPP/PkHUtqKiSLcDF1k+zDnJ2t86iyygGBGz3ZNjHInDCYfID5eaE0beOCVLytyN6x
         /wYzlJ8QaCq7i9prB47bb1IWKUpQ8E7peaw2bbMfLNBrPA312VBFkuVJZLyd4LroBDk4
         qLHW88oQxrrqriXcY9k5WByh/Wpw00hglXIsV7vv1B3LwOcEUEkzK1izEo774o+N7yp+
         6WCo52JObEPR69g2fy5aYA7q1id9fAwueMnHFYTuzBi7OoiBsR8fez/8a3L8pWjoxuLa
         jFZbk9U/QLOVtOwgmXfd51bsezxBjev5ucrB3RJuzFTOj5d0rcw36dd5Fw1YqSWj3zKI
         7Xrg==
X-Gm-Message-State: AHQUAuYlEIkMVJ6fN4lJHMicu9dNwzFZXsfjSQNnEMaXluTxLbMFMnb5
        aF9mSA4Wdr8q74Pb8OWnclJQJA==
X-Google-Smtp-Source: AHgI3IbGUnYqq0gjNt56H6AiHggXnwVA1VyjwryXcIj6PKK6X7AOB8w35z8IOEfLIrQ9KeiEQchmCg==
X-Received: by 2002:a63:9f19:: with SMTP id g25mr30120186pge.327.1549911751541;
        Mon, 11 Feb 2019 11:02:31 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e24sm15371893pfi.153.2019.02.11.11.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:02:30 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:02:30 -0800 (PST)
X-Google-Original-Date: Mon, 11 Feb 2019 10:29:52 PST (-0800)
Subject:     Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
In-Reply-To: <CAEn-LTqx8CQ7kY3kRKWFoAkSSu_FNoZkd9JnNYDNLAYX1kLHSA@mail.gmail.com>
CC:     atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>,
        Damien.LeMoal@wdc.com, aou@eecs.berkeley.edu, jason@lakedaemon.net,
        alankao@andestech.com, dmitriy@oss-tech.org, anup@brainfault.org,
        daniel.lezcano@linaro.org, me@packi.ch,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, schwab@suse.de,
        linux-riscv@lists.infradead.org, tglx@linutronix.de,
        zongbox@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-baffacaa-599b-4c89-a5a0-e0c85ddb6d44@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Feb 2019 20:26:07 PST (-0800), david.abdurachmanov@gmail.com wrote:
> On Sat, Feb 9, 2019 at 12:03 AM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> On 2/8/19 1:11 AM, Christoph Hellwig wrote:
>> >> +     * We don't support running Linux on hertergenous ISA systems.
>> >> +     * But first "okay" processor might not be the boot cpu.
>> >> +     * Check the ISA of boot cpu.
>> >
>> > Please use up your available 80 characters per line in comments.
>> >
>> I will fix it.
>>
>> >> +            /*
>> >> +             * All "okay" hart should have same isa. We don't know how to
>> >> +             * handle if they don't. Throw a warning for now.
>> >> +             */
>> >> +            if (elf_hwcap && temp_hwcap != elf_hwcap)
>> >> +                    pr_warn("isa mismatch: 0x%lx != 0x%lx\n",
>> >> +                            elf_hwcap, temp_hwcap);
>> >> +
>> >> +            if (hartid == boot_cpu_hartid)
>> >> +                    boot_hwcap = temp_hwcap;
>> >> +            elf_hwcap = temp_hwcap;
>> >
>> > So we always set elf_hwcap to the capabilities of the previous cpu.
>> >
>> >> +            temp_hwcap = 0;
>> >
>> > I think tmp_hwcap should be declared and initialized inside the outer loop
>> > instead having to manually reset it like this.
>> >
>> >> +    }
>> >>
>> >> +    elf_hwcap = boot_hwcap;
>> >
>> > And then reset it here to the boot cpu.
>> >
>> > Shoudn't we only report the features supported by all cores?  Otherwise
>> > we'll still have problems if the boot cpu supports a feature, but not
>> > others.
>> >
>>
>> Hmm. The other side of the argument is boot cpu does have a feature that
>> is not supported by other hart that didn't even boot.
>> The user space may execute something based on boot cpu capability but
>> that won't be enabled.
>>
>> At least, in this way we know that we are compatible completely with
>> boot cpu capabilities. Thoughts ?
>
> There is one example on the market, e.g., Samsung Exynos 9810.
>
> Mongoose 3 (big cores) only support ARMv8.0, while Cortex-A55
> (little ones) support ARMv8.2 (and that brings atomics support).
> I think, it's the only ARM SOC that supports different ISA extensions
> between cores on the same package.
>
> Kernel scheduler doesn't know that big cores are missing atomics
> support or that applications needs it and moves the thread
> resulting in illegal instruction.
>
> E.g., see Golang issue: https://github.com/golang/go/issues/28431
>
> I also recall Jon Masters (Computer Architect at Red Hat) advocating
> against having cores with mismatched capabilities on the server market.
>
> It just causes more problems down the line.

IMO the best bet is to only put extensions in HWCAP that are supported by all 
the harts that userspace will be scheduled on.
