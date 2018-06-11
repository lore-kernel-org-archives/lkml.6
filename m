Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BhUDJDspHluhEwAAmS7hNA
	; Mon, 11 Jun 2018 07:48:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7734E607BB; Mon, 11 Jun 2018 07:48:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhU8qF4O"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C4143602FC;
	Mon, 11 Jun 2018 07:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4143602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbeFKHsJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:48:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43595 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754006AbeFKHsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:48:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id n15-v6so29020263lfn.10;
        Mon, 11 Jun 2018 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Rzp1dSYL8ni2PE4y20+h5RWuQuksPR8PB20WytsYboE=;
        b=JhU8qF4OEnrQpV08f3OGPvZ0VAMiDgcLkLvSLzkfl1HIMFJ+0Hm9STO4bMvPTvGX76
         kB2neGoCTFPIb/ecaSFCkCZwN0CFLu2kq9CfOrZAvhviy4Ot0YSpZkv0E39rz65ZWj2t
         YHWOgHZwswQYQZbhCchplaFjrVXHGdFgsPZz8gkCSCK9GiMm1fVmFBe5xfZ7okNNkGmg
         y1imjZwYixaB9SoyZQ9bQ/LgvghB9wwtGUvHZj9VqJBDNcPXP2cFxnCCfhllcdqt4OHG
         DHeYdNm9o+AOI0Eoeu6ZeeA35jEPQvbECWAcu75jkaMHEWMo/G7R3gvQX1Rpeh5hTtPQ
         5dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Rzp1dSYL8ni2PE4y20+h5RWuQuksPR8PB20WytsYboE=;
        b=GMWB3PRrVQgSWjeK86UcNGH3KhInMXZhh0QBFhEH4mzylDLe0uV+TCz21StTulyMOy
         M9iulv8IGdSw7a6FicAOXurGq1tA7N9vS80++k7u7MNcEz+MFWE4DPeu+yTkE43SuvRu
         kLZ0TRJLuelmMYjVc7I78WVG6qllb00XrKhvp85PVAkQ6ry8HWx6IgRLYN43uexAUqNp
         nQJNqMeE8XQnQ2F18GF4Q8VBziv6QVDqUXayf4HewqCuq+e9UehtQDw8+m5EDuwfjJvH
         6qfqYRRSdixX/y5tTa2yGJE6dSSteU8Q8LGE/WvbNMC+/kcIPCCVnQuAVK7UWd63bhoC
         UUFA==
X-Gm-Message-State: APt69E2RNjHEYJlo6bV65lbXOIHYXqwkGKfna+n8GGie2Mvo0EnhKb8H
        1LHGPSwfnAOxHGmuYy+wgZMXQb9JyBcJpNzKl0w=
X-Google-Smtp-Source: ADUXVKIwx5xKJ019sp+KYBsSWOu0xc1vY65s1XFdDMg/+TZJGMZrPuu89EimIu8nL3zEO+1r3WnAnxJFBHDfm+ek3Ws=
X-Received: by 2002:a2e:5453:: with SMTP id y19-v6mr10302309ljd.11.1528703283779;
 Mon, 11 Jun 2018 00:48:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 00:48:02
 -0700 (PDT)
In-Reply-To: <20180609074227.GA6810@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-5-ynorov@caviumnetworks.com> <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
 <20180609074227.GA6810@yury-thinkpad>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Jun 2018 09:48:02 +0200
X-Google-Sender-Auth: xuQjuSuRPXF2lPaqecQszCuPNVA
Message-ID: <CAK8P3a16ByPtCwKbdLQRDRni3qV9DXLNYZ9QJUH6uHaZYHr34g@mail.gmail.com>
Subject: Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 9:42 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> On Fri, Jun 08, 2018 at 06:32:07PM +0100, Catalin Marinas wrote:
>> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
>> > diff --git a/arch/Kconfig b/arch/Kconfig
>> > index 76c0b54443b1..ee079244dc3c 100644
>> > --- a/arch/Kconfig
>> > +++ b/arch/Kconfig
>> > @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
>> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
>> >     bool
>> >
>> > +config ARCH_32BIT_OFF_T
>> > +   bool
>> > +   depends on !64BIT
>> > +   help
>> > +     All new 32-bit architectures should have 64-bit off_t type on
>> > +     userspace side which corresponds to the loff_t kernel type. This
>> > +     is the requirement for modern ABIs. Some existing architectures
>> > +     already have 32-bit off_t. This option is enabled for all such
>> > +     architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
>> > +     h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
>> > +     nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
>> > +     unicore32, x86_32 and xtensa. This is the complete list. Any
>> > +     new 32-bit architecture should declare 64-bit off_t type on user
>> > +     side and so should not enable this option.
>>
>> Do you know if this is the case for riscv and nds32, merged in the
>> meantime? If not, I suggest you drop this patch altogether and just
>> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
>> "all new 32-bit architectures should have 64-bit off_t".
>
> I wrote this patch at request of Arnd Bergmann. This is actually his
> words that all new 32-bit architectures should have 64-bit off_t. So
> I was surprized when riscv was merged with 32-bit off_t (and I didn't
> follow nds32).
>
> If this rule is still in force, we'd better add new exceptions to this
> patch. Otherwise, we can drop it.
>
> Arnd, could you please comment it?

I completely forgot about it and had assumed that it was merged long
ago, sorry about that.

        Arnd
