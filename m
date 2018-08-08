Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F32DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B54A219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="be8zAq1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B54A219C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeHHQgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbeHHQgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:36:20 -0400
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com [209.85.220.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3551C219F5;
        Wed,  8 Aug 2018 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533737787;
        bh=aHsuB5xwzUsrQfr+z33L3+p/kOe0YFzK75MM1iFVOqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=be8zAq1uq6LT10DsolwUTmslggArJYY7HjSseIBaaisfijcwRsAFq2A38l6sgFTXz
         29twjW5HH9EwPLC3XRATacWBYYLXsztqLqtIc7nXxEnE8Pf7+SzlLYHKKoxS8bPZNp
         eme1TctTrmjp1M3XaUR3DuPaQeL2rgkAZZhVGVng=
Received: by mail-qk0-f174.google.com with SMTP id b66-v6so1622302qkj.1;
        Wed, 08 Aug 2018 07:16:27 -0700 (PDT)
X-Gm-Message-State: AOUpUlE0/PeMdeu/DGxqkTA+j66rX/O/HG1gHJCtBBcZD+5jqAk/aNYU
        5i5aGCOCt7ZHGGKUgsBqTQAzr4CPHGGTVpA+xA==
X-Google-Smtp-Source: AA+uWPyIiT6Qj5kIb+qT+B/AP0laNmfNf+YieM18j+Mh8LFFFC8t4+FABb9at1I45Wfwy1VdwlMrwefuofccPwP1QjY=
X-Received: by 2002:ae9:c112:: with SMTP id z18-v6mr2555387qki.96.1533737786326;
 Wed, 08 Aug 2018 07:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com>
 <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4>
In-Reply-To: <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Aug 2018 08:16:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPFSQYH3p6a0VoCr-VAzf_98H7N3fNJ+4+DquS8WcjUQ@mail.gmail.com>
Message-ID: <CAL_JsqKPFSQYH3p6a0VoCr-VAzf_98H7N3fNJ+4+DquS8WcjUQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC documentation
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     atish.patra@wdc.com, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 8:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 06 Aug 2018 13:59:48 PDT (-0700), robh+dt@kernel.org wrote:
> > On Thu, Aug 2, 2018 at 4:08 PM Atish Patra <atish.patra@wdc.com> wrote:
> >>
> >> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
> >> > From: Palmer Dabbelt <palmer@dabbelt.com>
> >> >
> >> > This patch adds documentation for the platform-level interrupt
> >> > controller (PLIC) found in all RISC-V systems.  This interrupt
> >> > controller routes interrupts from all the devices in the system to each
> >> > hart-local interrupt controller.
> >> >
> >> > Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
> >> > want to change how we're specifying holes in the hart list.
> >> >
> >> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> >> > [hch: various fixes and updates]
> >> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> > ---
> >> >   .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
> >> >   1 file changed, 57 insertions(+)
> >> >   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> >> > new file mode 100644
> >> > index 000000000000..c756cd208a93
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> >> > @@ -0,0 +1,57 @@
> >> > +SiFive Platform-Level Interrupt Controller (PLIC)
> >> > +-------------------------------------------------
> >> > +
> >> > +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
> >> > +(PLIC) high-level specification in the RISC-V Privileged Architecture
> >> > +specification.  The PLIC connects all external interrupts in the system to all
> >> > +hart contexts in the system, via the external interrupt source in each hart.
> >> > +
> >> > +A hart context is a privilege mode in a hardware execution thread.  For example,
> >> > +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
> >> > +privilege modes per hart; machine mode and supervisor mode.
> >> > +
> >> > +Each interrupt can be enabled on per-context basis. Any context can claim
> >> > +a pending enabled interrupt and then release it once it has been handled.
> >> > +
> >> > +Each interrupt has a configurable priority. Higher priority interrupts are
> >> > +serviced first. Each context can specify a priority threshold. Interrupts
> >> > +with priority below this threshold will not cause the PLIC to raise its
> >> > +interrupt line leading to the context.
> >> > +
> >> > +While the PLIC supports both edge-triggered and level-triggered interrupts,
> >> > +interrupt handlers are oblivious to this distinction and therefore it is not
> >> > +specified in the PLIC device-tree binding.
> >> > +
> >> > +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> >> > +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
> >> > +specific memory layout, which is documented in chapter 8 of the SiFive U5
> >> > +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> >> > +
> >> > +Required properties:
> >> > +- compatible : "sifive,plic0"
>
> I think there was a thread bouncing around somewhere where decided to pick the
> official name of the compatible string to be "sifive,plic-1.0".  The idea here
> is that the PLIC is compatible across all of SiFive's current implementations,
> but there's some limitations in the memory map that will probably cause us to
> spin a version 2 at some point so we want major version number.  The minor
> number is just in case we find some errata in the PLIC.

Is 1.0 an actual version number corresponding to an exact, revision
controlled version of the IP or just something you made up? Looks like
the latter to me and I'm not a fan of s/w folks making up version
numbers for h/w. Standard naming convention is <vendor>,<soc>-<block>
unless you have good reason to deviate (IP for FPGAs where version
numbers are exposed to customers is one example).

And defining a version 2 when you find a quirk doesn't work. You've
already shipped the DT. You need to be able to fix issues with just an
OS update. This is why you are supposed to define a compatible string
for each and every SoC (and use a fallback when they are "the
same"TM).

> >> > +- #address-cells : should be <0>
> >> > +- #interrupt-cells : should be <1>
> >> > +- interrupt-controller : Identifies the node as an interrupt controller
> >> > +- reg : Should contain 1 register range (address and length)
> >>
> >> The one in the real device tree has two entries.
> >> reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;
> >>
> >> Is it intentional or just incorrect entry left over from earlier days?
> >
> >> > +             reg = <0xc000000 0x4000000>;
> >
> > Looks to me like one has #size-cells and #address-cells set to 2 and
> > the example is using 1.
>
> Yes.  For some background on how this works: we have a hardware generator that
> has a tree-of-busses abstraction, and each device is attached to some point on
> that tree.  When a device gets attached to the bus, we also generate a device
> tree entry.  For whatever system I generated the example PLIC device tree entry
> from, it must have been attached to a bus with addresses of 32 bits or less,
> which resulted in #address-cells and #size-cells being 1.
>
> Christoph has a HiFive Unleashed, which has a fu540-c000 on it, which is
> probably not what I generated as an example -- the fu540-c000 is a complicated
> configuration, when I mess around with the hardware I tend to use simple ones
> as I'm not really a hardware guy.  I suppose the bus that the PLIC is hanging
> off on the fu540-c000 has addresses wider than 32 bits.  This makes sense, as
> the machine has 8GiB of memory and the PLIC is on a bus that's closer to the
> core than the DRAM is, so it'd need at least enough address bits to fit 8GiB.
>
> Is the inconsistency a problem?  I generally write device tree handling code to
> just respect whatever #*-fields says and don't consider that part of the
> specification of the binding.  I don't mind changing the example to have
> #size-fields and #address-fields to be 2, but since it's not wrong I also don't
> see any reason to change it.  We do have 32-bit devices with PLICs, and while
> they're not Linux-capable devices we're trying to adopt the Linux device tree
> bindings through the rest of the RISC-V software ecosystem as they tend to be
> pretty well thought out.

The example is just an example and dts files can use either. For dts
files though, you should use the smallest size necessary and utilize
'ranges'. Some folks seem to think a 64-bit chip needs 64-bit address
and size everywhere. That's true at the top level typically, but
individual buses often don't span more than 4GB of address space. But
all that's out of scope of the example.

There are no "Linux device tree bindings". There are DT bindings that
happen to be hosting within the Linux tree for convenience.

Rob
