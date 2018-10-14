Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E45C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2746520890
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2746520890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJODbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 23:31:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36051 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeJODbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 23:31:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so19283182qth.3;
        Sun, 14 Oct 2018 12:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi89fFNjq2DxTE+Ppo+G6rtDEmLNPUOvGaFtWbUTl/A=;
        b=VdZ0Kirl7jXeA/HstIf7iikJHdy3+EXjAgkuZP1k49+ycgVgoYfKBD64n+oJ6NHNtx
         N9paj+c31NQ6Q/rK7QgrZ5/sqtQrU08u3Xtaxif5ZovAEUhiiGgTZNZkAyK3+qDbOxr/
         Xiu3F0+VIcphVTujR1JWQNPDkc3geG+gj90ojBSZ3W79XO9ljTT44CtjLuo/hSHtWNhk
         QnmAVMIPuh6PaQVW9iDwTUD28hgc9pjBE+gI4HrLX6BAPz4/BSVHIilKXJKpeQGEtG6K
         33nHqNw9KW8vs/zKEICc1XyFcIJikCwIeh2sMiat/ofDGgVx9drE/ppty0wpgqOrCUGe
         oqrQ==
X-Gm-Message-State: ABuFfojhfMlhlZ6nNM82NHuDY+luC9vy0xovmeH7yRNmqmhXf0RaG/xX
        TeJVT2y58Ys5uNNdHLbqu/00tmvryBGbEP0C7wA=
X-Google-Smtp-Source: ACcGV60Nf0wfOyrysOwAcQQsm246PiIxS7QFi4FRfNoFsKEXmfo8dmUXcDbVD9OFla5Uos9t3iLfHLzj32lpQnAvG0U=
X-Received: by 2002:a0c:881c:: with SMTP id 28mr13917792qvl.40.1539546557452;
 Sun, 14 Oct 2018 12:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180516081910.10067-1-ynorov@caviumnetworks.com> <CALCETrVuabkb5ZQOSgQQTEq8CrS602NBpAkE2=4n982r1f5reQ@mail.gmail.com>
In-Reply-To: <CALCETrVuabkb5ZQOSgQQTEq8CrS602NBpAkE2=4n982r1f5reQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 14 Oct 2018 21:49:01 +0200
Message-ID: <CAK8P3a1Yhhv1TcQTcF0MinicGovgp_0g_sXqADe3fjVTtOK_aw@mail.gmail.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
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
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 9:36 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Wed, May 16, 2018 at 1:19 AM Yury Norov <ynorov@caviumnetworks.com> wrote:
> >
> > This series enables AARCH64 with ILP32 mode.
> >
> > As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> > option that is enabled for existing 32-bit architectures but disabled
> > for new arches (so 64-bit off_t userspace type is used by new userspace).
> > Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
>
> Second, ILP32 user code is highly unlikely
> to end up with the same struct layout as ILP64 code.  The latter seems
> like it should be solved entirely in userspace by adding a way to
> annotate a structure as being a kernel ABI structure and getting the
> toolchain to lay it out as if it were ILP64 even though the target is
> ILP32.

The syscall ABI could be almost completely abstracted in glibc, the
main issue is ioctl and a couple of related interfaces that pass data
structures (read() on /dev/input/*, mmap on /dev/snd/*
or raw sockets, fcntl).

The question whether a data type is laid out like a 64-bit architecture
would cannot be a property of the type in most of those cases,
because the same types are used elsewhere. Many ioctls just
take a pointer to a 'long' or similar, and then you have structures
like 'timespec' that are used both in syscall/ioctl ABI and in normal
user space code, but are required to be laid out differently there.
(timespec is a bad example because y2038 of course, but it
illustrates the point).

> 2. I think you should make a conscious decision as to whether the
> ILP32-ness of a syscall is a property of the task or of the syscall.
> On x86, x32-ness is a property of the syscall, but historically it
> also got rather entangled with the state of the task, and the result
> was a mess.  It looks like you're making it be a property of the task,
> which is fine, but you're making it impossible for very clever ILP32
> libraries to include little ILP64 stubs that do fancy things with full
> 64-bit syscalls.
>
> 3. Make very certain that you aren't exploitable by malicious
> processes that set the high bits in ILP32 syscall args.  x86 compat
> has issues like that in the past.

This point was actually the most important one for keeping the
aarch64 ilp32 interface as restricted as it is: it doesn't allow
anything that the normal aarch32/armv7 emulation doesn't
already provide.

        Arnd
