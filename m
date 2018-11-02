Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A18C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DDD2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPdwoSnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DDD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeKCDhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:37:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46985 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCDhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:37:31 -0400
Received: by mail-io1-f68.google.com with SMTP id y22-v6so2005288ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ahMHxKGKYMjaGxqaMVpVzq2WKsWaxnbo1kxK4Oyu3Q=;
        b=HPdwoSnbb3151ydw3dRNtCWjVITmHiZRIwVhK8oNO0gveC0uxLZS60Z/liCg0H/eOZ
         mfSvl9fBeVs3NMNWMaKB3TbmlXUTVFrnrmePpmqbg92xjGPjZL/3Fw672VptpWk2arMp
         6N9O/L4IW8aSuNsI727n8TgHBuMaHBpTLPzow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ahMHxKGKYMjaGxqaMVpVzq2WKsWaxnbo1kxK4Oyu3Q=;
        b=LD3RQR550OQt83GKJZo6mo7rhjvkuWYW6EW+o8ZF86B8cT16omyxoXicZA4fAd1z2Y
         9A5iHQHA3/id3VMvTuRWfZRb/UOby61lDTvRTWAEvrfFvW79dcRqbY16Gag8sTwGRXEN
         GJs/3qlL6pwgU0V/XCKRKJxU8T8QaXk56UoJUdmO9Gru7b4dEXI4eGyW8oFhJwLvSTcc
         9eeZ0euphOdoex/eUprTegDLoWNlhL7V5lzR422bPKaKa1YK2xz1YSPWV8wB8X2ny8/w
         WZYtbY6gK6fT5nrvRBtzEuxVjA781kaD+oQXE/YwhJlRnQk1ggDEmDz3YP/xjWCpZERb
         oCbg==
X-Gm-Message-State: AGRZ1gIZZ4Ymw28g6zl9NDtj1LwkNfE93pOqii8c+LnMecgpuBhN5MVt
        08VzClG5+aAiXUA7Pl4/P3JZKGaeJ/eD8SBeQgTvlA==
X-Google-Smtp-Source: AJdET5e9Xpnua9ffSDzmVuz/hYmJFq/W71ltIN90A2THbvaKMELzmuUOsGMcYQEGa+5+zfLCsK2sHOC58LuExAU2i00=
X-Received: by 2002:a6b:5d18:: with SMTP id r24-v6mr9481662iob.170.1541183362061;
 Fri, 02 Nov 2018 11:29:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 11:29:21 -0700 (PDT)
In-Reply-To: <20181102174051.GH218059@arrakis.emea.arm.com>
References: <20181030113850.31150-1-anders.roxell@linaro.org>
 <DAC371D3-7D52-49D5-BA99-9B90389F3197@linaro.org> <CAKv+Gu_w1QaB_BEFgTHPUnMXwJGSsbT7wLYGazZDOAt7nNZNXw@mail.gmail.com>
 <20181102174051.GH218059@arrakis.emea.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 2 Nov 2018 19:29:21 +0100
Message-ID: <CAKv+Gu_Ktzh6T=h8A7g3Xjaw3=anXmwRR_f84reY-mmTYnWUFw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: kprobe: make page to RO mode when allocate it
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 November 2018 at 18:40, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Oct 30, 2018 at 11:10:51AM -0300, Ard Biesheuvel wrote:
>> On 30 October 2018 at 08:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >> On 30 Oct 2018, at 08:38, Anders Roxell <anders.roxell@linaro.org> wrote:
>> >>
>> >> Commit 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuable pages")
>> >> has successfully identified code that leaves a page with W+X
>> >> permissions.
>> >>
>> >> [    3.245140] arm64/mm: Found insecure W+X mapping at address (____ptrval____)/0xffff000000d90000
>> >> [    3.245771] WARNING: CPU: 0 PID: 1 at ../arch/arm64/mm/dump.c:232 note_page+0x410/0x420
>> >> [    3.246141] Modules linked in:
>> >> [    3.246653] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-next-20180928-00001-ge70ae259b853-dirty #62
>> >> [    3.247008] Hardware name: linux,dummy-virt (DT)
>> >> [    3.247347] pstate: 80000005 (Nzcv daif -PAN -UAO)
>> >> [    3.247623] pc : note_page+0x410/0x420
>> >> [    3.247898] lr : note_page+0x410/0x420
>> >> [    3.248071] sp : ffff00000804bcd0
>> >> [    3.248254] x29: ffff00000804bcd0 x28: ffff000009274000
>> >> [    3.248578] x27: ffff00000921a000 x26: ffff80007dfff000
>> >> [    3.248845] x25: ffff0000093f5000 x24: ffff000009526f6a
>> >> [    3.249109] x23: 0000000000000004 x22: ffff000000d91000
>> >> [    3.249396] x21: ffff000000d90000 x20: 0000000000000000
>> >> [    3.249661] x19: ffff00000804bde8 x18: 0000000000000400
>> >> [    3.249924] x17: 0000000000000000 x16: 0000000000000000
>> >> [    3.250271] x15: ffffffffffffffff x14: 295f5f5f5f6c6176
>> >> [    3.250594] x13: 7274705f5f5f5f28 x12: 2073736572646461
>> >> [    3.250941] x11: 20746120676e6970 x10: 70616d20582b5720
>> >> [    3.251252] x9 : 6572756365736e69 x8 : 3039643030303030
>> >> [    3.251519] x7 : 306666666678302f x6 : ffff0000095467b2
>> >> [    3.251802] x5 : 0000000000000000 x4 : 0000000000000000
>> >> [    3.252060] x3 : 0000000000000000 x2 : ffffffffffffffff
>> >> [    3.252323] x1 : 4d151327adc50b00 x0 : 0000000000000000
>> >> [    3.252664] Call trace:
>> >> [    3.252953]  note_page+0x410/0x420
>> >> [    3.253186]  walk_pgd+0x12c/0x238
>> >> [    3.253417]  ptdump_check_wx+0x68/0xf8
>> >> [    3.253637]  mark_rodata_ro+0x68/0x98
>> >> [    3.253847]  kernel_init+0x38/0x160
>> >> [    3.254103]  ret_from_fork+0x10/0x18
>> >>
>> >> kprobes allocates a writable executable page with module_alloc() in
>> >> order to store executable code.
>> >> Reworked to that when allocate a page it sets mode RO. Inspired by
>> >> commit 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()").
>> >>
>> >> Cc: Laura Abbott <labbott@redhat.com>
>> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> >> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
>> >> Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >
>> > Please remove these SOBs, Arnd and I provided input to this patch
>> > but you are the one sending it (sob does not assert authorship or
>> > anything like that, it just asserts that the code in the patch was
>> > made available under a compatible license)
>>
>> As Anders points out in a private communication, the Documentation/
>> explicitly requires signoffs for Co-developed-by credits. Perhaps we
>> should enhance that document to clarify that that does not mean you
>> can simply add signoffs on someone else's behalf.
>
> I think I'll rename co-developed-by with suggested-by to keep things
> simpler. Are you ok with this (or are you providing an explicit
> signed-off-by)?
>

Either is fine with me.
