Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B08FC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302AE2064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302AE2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJODfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 23:35:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39704 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeJODfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 23:35:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id e22-v6so19303629qto.6;
        Sun, 14 Oct 2018 12:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doFYNN6dg8ppo+j0Zk07aanLk9qlmCb+R+JOhgmPces=;
        b=NOV0Ty2gUpYYkPOO1jS3ibCLHiiF+w7roqw5JM2WIr1E7tpHcKEICssxGljUIHlNMW
         1QmFytEeVbLiq6Okag4H1vNKiYRd5pGJeseB9Usd24DH6WMBL+/uEoOIZg0rDhgaZSUV
         vjK+t4flDMSvYG9Qz9KOtrU1I2lDaC+O72lMXDsIGjfgwbK8mE61ZoXSJ7Z/dy7hXc8a
         za4OAz66PkjhGrAA+Y+UPMR7mR7UXVlFaFhNVtDYu4BOUJ6WQ67mYf0n4LRIgnvLpScu
         +Opxm9UQNE5mUkemIBfc5FUS8+NN8VoAvtb2S2mAAJD2GRCaMomGFca8F0+6kGS/aW+Y
         8EvQ==
X-Gm-Message-State: ABuFfoiTcbcFTlJ8IEjJEqv3e8LFRacP8zQ0oUvE3GVaRpS0Kk2NF4YT
        BhASoqdb3AwPHTL0y3OQE7MAFBkVgv449T1e/iU=
X-Google-Smtp-Source: ACcGV62QbtpuaX/eixbfMELMPr+dxSrPH2IwBh2hGKi8FHx447B1/XjpDxeL7I6jyyytgzyVaVfFf/zOK4wXV/xg8Zk=
X-Received: by 2002:ac8:2bf0:: with SMTP id n45-v6mr13913853qtn.152.1539546818882;
 Sun, 14 Oct 2018 12:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad> <20181010141017.GA2881@asgard.redhat.com>
 <7aac1a08-8948-1a04-cbd3-fbc6a53f9ff0@arm.com> <20181013020731.GD21972@asgard.redhat.com>
In-Reply-To: <20181013020731.GD21972@asgard.redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 14 Oct 2018 21:53:22 +0200
Message-ID: <CAK8P3a1qUVoE0CYkCOU2N+-WkqMad15fFsakbwkpiiPPRFz-eA@mail.gmail.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Yury Norov <ynorov@caviumnetworks.com>, nd@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        David Miller <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        "Manuel A. Fernandez Montecelo" <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Pavel Machek <pavel@ucw.cz>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wookey <wookey@wookware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:07 AM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> On Wed, Oct 10, 2018 at 03:39:07PM +0100, Szabolcs Nagy wrote:
> > On 10/10/18 15:10, Eugene Syromiatnikov wrote:
> > >  * What's the reasoning behind capping syscall arguments to 32 bit? x32
> > >    and MIPS N32 do not have such a restriction (and do not need special
> > >    wrappers for syscalls that pass 64-bit values as a result, except
> > >    when they do,  as it is the case for preadv2 on x32); moreover, that
> > >    would lead to insurmountable difficulties for AArch64 ILP32 tracers
> > >    that try to trace LP64 tracees, as it would be impossible to pass
> > >    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.
> >
> > but that's necessarily the case for all ilp32 abis:
> > the userspace syscall function receives 32bit
> > arguments so even if the kernel abi takes 64bit
> > args you cannot use that from c code. (the libc
> > does not even know which args should be sign or
> > zero extended.)
>
> glibc's syscall() prototype has kernel_ulong_t as its arguments (more
> specifically, to __syscall_ulong_t, which is 64-bit wide on x32; it
> should also have kernel_long_t as its return type instead of long,
> but that's another story), so it works perfectly fine in case of x32.
>
> > process_vm_readv/writev is limited by the ilp32
> > iovec struct, not by the syscall arguments.
>
> Right, on x32/N32 this issue is worked around by the usage of the respective
> x86_64/N64 call, and it looks like another thing that is impossible
> with AArch64 ilp32.
>
> > ptrace is specified to take void* addr argument,
> > and void* is 32bit on all ilp32 targets.
> > so again on the c language level there is no
> > way around the 32bit limitation.
>
> Which is an issue.

I have no idea why you think this is a problem specific to aarch64-ilp32:
If we want to be able to debug 64-bit tasks from a 32-bit task on any
architecture that has compat mode, we should solve it once and
extend the ptrace interface to allow it on *all* of them. We certainly
don't need /more/ special cases for the x32 hack, there should really
be fewer of them.

      Arnd
