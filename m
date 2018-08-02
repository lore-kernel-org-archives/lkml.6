Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41261C46467
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE94A21564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U+JsPDr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE94A21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbeHBUXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:23:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41301 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbeHBUXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:23:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so1597921pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=cvEQXyPfaRgWVW4mwIGGXzyBUsZJw8cVJojplx3/jcg=;
        b=U+JsPDr/ZNqAlimhcfN4voEVJi4MXHr2WdrTaNlM9wHTsSnxW9QWYwNVK0ZM9elmt0
         WRQqEZQiPLDimwr1pLR1/LhZsTJko2gruCatWSPvrmKg/TVyD3v8IQL+/TsvzyI8oq8t
         g0sV6Wv3T3DS9sXTu53qfSPUeXEfbklgEXjP6af4yaRoCPlxn9LIOLZbrr7EWx1tq9dd
         bXmmTHxHrNm14L6777gdwppL38sGLGsEHYfWpQ0KFbnY9DwduK7m+kCfQbTa/6QM1O5t
         U/AQe/SPExjXp6MXayIGL4sMsZpYbqbDQIJePD02Tpte+q4W6toQzKcyhKHVIpB0b1w+
         W+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=cvEQXyPfaRgWVW4mwIGGXzyBUsZJw8cVJojplx3/jcg=;
        b=BKG9BdSwhwiG+UbVltptQDpt6cgm/66aap8rlMD/PbOV7by/MzUTPmRrBTwtR28IBM
         G2BsXl6RUUTLT76HYT2f75b1HwtBYfrqYLMjF9Yq69c/ymyQAvnJfFEyJ4Hs4RDf42Id
         oO8cyIm7afDcIfYmX8ZYDHORnmMViY2P29Q5ZV+uwcwgGeAWvNzyhwh9HHxyIOl9hViP
         P3ojgAJKvRV7RGo6p/pnGR74Tf2SYGT9YG6kL8WrMClFT6jxRBKpNmpaecufan2mubqI
         3S21GdlEp/I4Xv7pdev17Gq/jHGYkDyNTgCj4pI/IyuKrh6ynpfFvv/RADHM2LaFLh0g
         b3hw==
X-Gm-Message-State: AOUpUlEDOgRXoArigD3O9Y9UbjYDaKTSinwjqUwDmb3cS97xbFMzti06
        pZL+Nao0pCY9IB/SULc1DIOdLw==
X-Google-Smtp-Source: AAOMgpeH7fURYHQAfb39YmY3/lJHH9P50P0KR4fkgYSobfvn6vHJfHB+5JxYixTTHKh9Q4/lH7ZAmg==
X-Received: by 2002:a63:65c2:: with SMTP id z185-v6mr568803pgb.276.1533234656470;
        Thu, 02 Aug 2018 11:30:56 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2570596pge.29.2018.08.02.11.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 11:30:55 -0700 (PDT)
Date:   Thu, 02 Aug 2018 11:30:55 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Aug 2018 11:30:28 PDT (-0700)
Subject:     Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
In-Reply-To: <20180625061950.GB23998@yury-thinkpad>
CC:     Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        szabolcs.nagy@arm.com, catalin.marinas@arm.com,
        heiko.carstens@de.ibm.com, philipp.tomsich@theobroma-systems.com,
        joseph@codesourcery.com, linux-arch@vger.kernel.org,
        sellcey@caviumnetworks.com, Prasun.Kapoor@caviumnetworks.com,
        schwab@suse.de, agraf@suse.de, geert@linux-m68k.org,
        bamv2005@gmail.com, Dave.Martin@arm.com, kilobyte@angband.pl,
        manuel.montezelo@gmail.com, james.hogan@imgtec.com,
        cmetcalf@mellanox.com, pinskia@gmail.com, linyongting@huawei.com,
        klimov.linux@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org,
        fweimer@redhat.com, linux-api@vger.kernel.org,
        Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org,
        james.morse@arm.com, ramana.gcc@googlemail.com,
        schwidefsky@de.ibm.com, davem@davemloft.net,
        christoph.muellner@theobroma-systems.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     ynorov@caviumnetworks.com
Message-ID: <mhng-96b7425f-3358-4b26-bd80-2a8957100f9a@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2018 23:19:50 PDT (-0700), ynorov@caviumnetworks.com wrote:
> On Mon, Jun 11, 2018 at 02:27:36PM +0300, Yury Norov wrote:
>> On Mon, Jun 11, 2018 at 09:48:02AM +0200, Arnd Bergmann wrote:
>> > On Sat, Jun 9, 2018 at 9:42 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>> > > On Fri, Jun 08, 2018 at 06:32:07PM +0100, Catalin Marinas wrote:
>> > >> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
>> > >> > diff --git a/arch/Kconfig b/arch/Kconfig
>> > >> > index 76c0b54443b1..ee079244dc3c 100644
>> > >> > --- a/arch/Kconfig
>> > >> > +++ b/arch/Kconfig
>> > >> > @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
>> > >> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
>> > >> >     bool
>> > >> >
>> > >> > +config ARCH_32BIT_OFF_T
>> > >> > +   bool
>> > >> > +   depends on !64BIT
>> > >> > +   help
>> > >> > +     All new 32-bit architectures should have 64-bit off_t type on
>> > >> > +     userspace side which corresponds to the loff_t kernel type. This
>> > >> > +     is the requirement for modern ABIs. Some existing architectures
>> > >> > +     already have 32-bit off_t. This option is enabled for all such
>> > >> > +     architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
>> > >> > +     h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
>> > >> > +     nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
>> > >> > +     unicore32, x86_32 and xtensa. This is the complete list. Any
>> > >> > +     new 32-bit architecture should declare 64-bit off_t type on user
>> > >> > +     side and so should not enable this option.
>> > >>
>> > >> Do you know if this is the case for riscv and nds32, merged in the
>> > >> meantime? If not, I suggest you drop this patch altogether and just
>> > >> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
>> > >> "all new 32-bit architectures should have 64-bit off_t".
>> > >
>> > > I wrote this patch at request of Arnd Bergmann. This is actually his
>> > > words that all new 32-bit architectures should have 64-bit off_t. So
>> > > I was surprized when riscv was merged with 32-bit off_t (and I didn't
>> > > follow nds32).
>> > >
>> > > If this rule is still in force, we'd better add new exceptions to this
>> > > patch. Otherwise, we can drop it.
>> > >
>> > > Arnd, could you please comment it?
>> >
>> > I completely forgot about it and had assumed that it was merged long
>> > ago, sorry about that.
>>
>> Hi Arnd,
>>
>> There are 3 patches like this in ILP32 series that change ABI for new
>> targets. I've submitted them in separated series:
>> https://lkml.org/lkml/2017/9/25/574
>>
>> They all seems to be acked by you. If you ready to upstream the
>> series, I can rebase it and add riscv32 and nds32 exceptions.
>>
>> If Palmer and riscv people will decide to follow new rules, we can
>> easily drop the exception.
>
> Ping?

Sorry to be a bit slow, but we just decided to skip this current glibc release 
for rv32i and instead focus on getting the 32-bit ABI nice and clean for the 
next release.  Thus we in RISC-V land are OK with taking these changes to the 
32-bit kernel ABI.
