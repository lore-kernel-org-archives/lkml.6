Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3325C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385A72178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bakuhatsu-net.20150623.gappssmtp.com header.i=@bakuhatsu-net.20150623.gappssmtp.com header.b="RNsqrcqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385A72178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bakuhatsu.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeHCWmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:42:39 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39676 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbeHCWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:42:39 -0400
Received: by mail-ua0-f194.google.com with SMTP id g18-v6so5827557uam.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bakuhatsu-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3GAte+VHZuimmSqbW+3EP51sIl8W8cJPDRDrANge5GM=;
        b=RNsqrcqT3dFj6/PlDdQ7X1JyDBMef/qtI1m6fxtkg+WU/Nx9la6Gz3RfFmQWIrx4DM
         BhlF6IWUs/PPvFYUJgJCed+Zt0RIWGj5Bs00grs5Y7J4f+i9Ha0ReeoccIo62RebCIJ8
         YGO9H2tNvhb25BGb5ByGGkOTTKxklfuPdpLq4yl+vCmCCM+ckYe/nhiLgV7BKZTvX0YT
         aRNFOExX+6IWccSYInleWOSHjW50ijIRaLmFI9HOftYjdu+B8ceaRx9revJxuVVs3qvm
         ufJvuW/UKH0xRDLxzKvwHdY6ls97c09uUmBrjW4gRBITFpK/8w45bvcA8qxfZu5rE+q6
         tgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3GAte+VHZuimmSqbW+3EP51sIl8W8cJPDRDrANge5GM=;
        b=HCXCHshJmYiaEbqb5xDFcBPVVv9KPsNOKnr+lW+QwfXSg8Ua+dBCjfGssgIbiQz7iO
         Wvh7YOpqVrhLwWpYh9vbdPc3kmFxTuSmSgvum0seT39+QPHMz9RXJIocp942gOCXkIUx
         lCWKMEM/oeAzySdJf6P/yVfB/xeyvGJJsP1eSAamV+OxWURGp6y7AXodDH+u5Ra52srP
         qhFDfkrstuY4AjqjKRkkjgouyLm4KNeu1Ef1OVsUYqE6Jdi1K2KSBv3u1quhSeFZlnjD
         i/TYJuaXVjYf4fQPDITE9SK9a3OI2q9y/kc7sZPlH+leLmykZg8csZOJySuP+n3VMYqo
         YDIw==
X-Gm-Message-State: AOUpUlH+2SxsQEVm5LmxDYJojTJCWGZHkvDFMQHPPdhVIN6sXSuVSFmS
        Q3pW+8b5/6KwSjxEkKf1x3rSkCgMiqIWTN962VTq
X-Google-Smtp-Source: AAOMgpf7Uz7U9Wd85CmsTw0JuFCp9PtQU1DJBC6ET1oSUCKwwHLJbxk3dg+8PC2Ky9PguwaPGvbB7uBsSosaaUg2xfQ=
X-Received: by 2002:a1f:c102:: with SMTP id r2-v6mr3422593vkf.34.1533329085268;
 Fri, 03 Aug 2018 13:44:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2245:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 13:44:44 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com> <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
From:   Matt Sealey <neko@bakuhatsu.net>
Date:   Fri, 3 Aug 2018 15:44:44 -0500
Message-ID: <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 August 2018 at 13:25, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Fri, 3 Aug 2018, Ard Biesheuvel wrote:
>
>> Are we still talking about overlapping unaligned accesses here? Or do
>> you see other failures as well?
>
> Yes - it is caused by overlapping unaligned accesses inside memcpy. When I
> put "dmb sy" between the overlapping accesses in
> glibc/sysdeps/aarch64/memcpy.S, this program doesn't detect any memory
> corruption.

It is a symptom of generating reorderable accesses inside memcpy. It's nothing
to do with alignment, per se (see below). A dmb sy just hides the symptoms.

What we're talking about here - yes, Ard, within certain amounts of
reason - is that
you cannot use PCI BAR memory as 'Normal' - certainly never cacheable memory,
but Normal NC isn't good either. That is that your CPU cannot post
writes or reads
towards PCI memory spaces unless it is dealing with it as Device memory or very
strictly controlled use of Normal Non-Cacheable.

I understand why the rest of the world likes to mark stuff as
'writecombine,' but
that's x86-ism, not an Arm memory type.

There is potential for accesses to the same slave from different
masters (or just
different AXI IDs, most cores rotate over 8 or 16 or so for Normal
memory to achieve)
to be reordered. PCIe has no idea what the source was, it will just
accept them in the order it receives them, and also it will be
strictly defined to
manage incoming AXI or ACE transactions (and barriers..) in a way that does
not violate the PCIe memory model - the worst case is deadlocks, the best case
is you see some very strange behavior.

In any case the original ordering of two Normal-NC transactions may
not make it to
the PCIe bridge in the first place which is probably why a DMB
resolves it - it will
force the core to issue them in order and it's likely unless there is
some hyper-complex
multi-pathing going on, they'll stay ordered. If you MUST preserve the
order between
two Normal memory accesses, a barrier is required. The same is true also of any
re-orderable device access.

>> > I tried to run it on system RAM mapped with the NC attribute and I didn't
>> > get any corruption - that suggests the the bug may be in the PCIE
>> > subsystem.

Pure fluke.

I'll give a simple explanation. The Arm Architecture defines
single-copy and multi-copy
atomic transactions. You can treat 'single-copy' to mean that that
transaction cannot
be made partial, or reordered within itself, i.e. it must modify
memory (if it is a store) in
a single swift effort and any future reads from that memory must
return the FULL result
of that write.

Multi-copy means it can be resized and reordered a bit. Will Deacon is
going to crucify
me for simplifying it, but.. let's proceed with a poor example:

STR X0,[X1] on a 32-bit bus cannot ever be single-copy atomic, because
you cannot
write 64-bits of data on a 32-bit bus in a single, unbreakable
transaction. This is because
from one bus cycle to the next, one half of the transaction will be in
a different place. Your
interconnect will have latched and buffered 32-bits and the CPU is
holding the other.

STP X0, X1, [X2] on a 64-bit bus can be single-copy atomic with
respect to the element
size. But it is on the whole multi-copy atomic - that is to say that
it can provide a single
transaction with multiple elements which are transmitted, and those
elements could be
messed with on the way down the pipe.

On a 128-bit bus, you might expect it to be single-copy atomic because
the entire
transaction can be fit into one single data beat, but *it is most
definitely not* according
to the architecture. The data from X0 and X1 may be required to be
stored at *X2 and
*(X2+8), but the architecture doesn't care which one is written first.
Neither does AMBA.

STP is only ever guaranteed to be single-copy atomic with regards to
the element size
(which is the X register in question). If you swap the data around,
and do STP X1, X0,
[X2] you may see a different result dependent on how the processor
decides to pull
data from the register file and in what order. Users of the old 32-bit
ARM STM instruction
will recall that it writes the register list in incrementing order,
lowest register number to
lowest address, so what is the solution for STP? Do you expect expect
X0 to be emitted
on the bus first or the data to be stored in *X2?

It's neither!

That means you can do an STP on one processor and an LDR of one of the 64-bit
words on another processor, and you may be able to see

a) None of the STP transaction
b) X2 is written with the value in X0, but X2+8 is not holding the value in X1
c) b, only reversed
d) What you expect

And this can change dependent on the resizers and bridges and QoS and paths
between a master interface and a slave interface, although a truly
single-copy atomic
transaction going through a downsizer to smaller than the transaction
size is a broken
system design, it may be allowable if the downsizer hazards addresses
to the granularity
of the larger bus size on the read and write channels and will stall
the read until the write
has committed at least to a buffer, or downstream of the downsizer, so
that it will return
on read the full breadth of the memory update.... that's down to the
system designer.
There are plenty of places things like this can happen - in cache
controllers, for
example, and merging store buffers (you may have a 256 bit or 512 bit
buffer, but
only a 128-bit memory interface).

memcpy() as a function nor the loads and stores it makes are not
single-copy atomic,
no transactions need to be with Normal memory, so that merged stores
and linefills
(if cacheable) can be done. Hence, your memcpy() is just randomly
chucking whatever
data it likes to the bus and they'll arrive in any old order,
'writecombine' semantics make
you think you'll only ever see one very large write with all the CPU
activity merged
together - also NOT true.

And the granularity of the hazarding in your system, from the CPU
store buffer to the
bus interface to the interconnect buffering to the PCIe bridge to the
PCIe EP is.. what?
Not the same all the way down, I'll bet you.

It is assuming that Intel writecombine semantics would apply, which to
be truthful are NO
different to the ones of a merging store buffer in an Arm processor
(Intel architecture states
that the writecombine buffer can be flushed at any time with any
amount of actual data,
it might not be the biggest burst you can imagine), but in practice it
tends to be in cache-line
sized chunks with strict incrementing order and subsequent writes due
to the extremely
large pipeline and queueing will be absorbed by the writecombine
buffer almost with
guarantee.

Links is broken. Even on Intel. If you overlap memory transactions and
expect them to be
gathered and reordered to produce nice, ordered non-overlapping
streaming transactions
you'll be sorely disappointed when they don't, which is what is
happening here. The fix is
use barriers - and don't rely on single-copy atomicity (which is the
only saving feature that
would not require you to use a barrier) since this is a situation
where absolutely none is
afforded.

It'd be easier to cross your fingers that the PCIe RC is has a
coherent master port (ACE-Lite
or something fancier) and can snoop into CPU caches. Then you can mark a memory
location in DRAM as Normal Inner/Outer Cacheable Writeback,
Inner/Outer Shareable,
Write-allocate, read-allocate, and you won't even notice your CPU
doing any memory
writes, but yes if you tell a graphics adapter that it's main
framebuffer is in DRAM it might
be a bit slower (to the speed of the PCIe link.. which may affect your
maximum resolution
in some really strange circumstances). If it cannot use a DRAM
framebuffer then I'd have to
wonder why not.. every PCI graphics card I ever used could take any
base address and
the magic of PCI bus mastering would handle it. This is no different
to how you'd use
DRAM as texture memory.. phenomenally slowly, but without having to
worry about any
ordering semantics (except you should flush your data cache to PoC at
the end of every
frame).

Ta,
Matt
