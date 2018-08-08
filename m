Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E9CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7984A217A6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="GHI0foZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7984A217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeHHV7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:59:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40529 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeHHV7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:59:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so1625647pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TKE5RwMvZ2YO2qejMMAAZRfHz66NjscAbEEHgr/tqFA=;
        b=GHI0foZ1iI7eoWDIT6D1IKbh21U0TZGBaRTtL+zI23O0kqOfnaqsTL0o6GlbbKFcqT
         S4z74FuUScu/5c0QQuJ+kjLYeta0pH2FdS53oF+3KLHolbgcozuNQHzjVROmUR4z4/bV
         s74dRuZ0TuLPpsG+7ErmeeQQH3E2rQ1Hv8FVVjA6N+o7nt4RMka+aBjlyrENGl6K+xEd
         IaOUq+MJjORR8m61N9Q8JqkWDdHVEj4QB2r0W9r50hYhY+yfAFtMALAYDQsuzGacV9OG
         qIuIGQq0UOcM/fL7eB7bJwXA9M0AdpPhaBCbazJovf7eWgTMK8gdlmKGYg3h3mp9Otg1
         BpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TKE5RwMvZ2YO2qejMMAAZRfHz66NjscAbEEHgr/tqFA=;
        b=BjagdmFX02Vp1vffTg25kjZ0Ump8NEttjnH2idFLvFMh0sGIwJxOlciF8kl7w+arTX
         O6OsF7CCqYBEMxy3nBjNdIuJj8OgMNkmW+2RyAEA6c8NudsoTKaud7IzCkTdC1IpdO7j
         XZd7w6I6F0xVJlBs50mnlXaVwcYqvvtYc2cqw64fSWLZF5QGrN1u2UUVtrmvPZK4LDme
         wGNmWz/WFLIlMjQQBAJ5OUoBU6eID4AxARaGn9F/H9ZhH4TZYdzQoyqgSo+1JRfl2YRD
         v8QJkYW9S/gO50rSWpwsuF/sLzQtUY5EB6ViKDssCZ3YnPRPV15m9Lg2Q7Pbnxq5nXjB
         bJ2w==
X-Gm-Message-State: AOUpUlGXMAiYnN/+tqkFiBvtqwf6Jo+cqDoFGk38yCriOG2KtdYuWtgJ
        lrpuUq6yYV4S3MMalqiLKcEe+Q==
X-Google-Smtp-Source: AA+uWPzPM+qs04sWypppiEpbuUUJeGrvelRAVV9nxrbIOSKF58wxkoAnnlib66p4lY4rXwS+c9CNFw==
X-Received: by 2002:a62:249c:: with SMTP id k28-v6mr4341417pfk.195.1533757091729;
        Wed, 08 Aug 2018 12:38:11 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i20-v6sm8922962pfj.82.2018.08.08.12.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 12:38:09 -0700 (PDT)
Date:   Wed, 08 Aug 2018 12:38:09 -0700 (PDT)
X-Google-Original-Date: Wed, 08 Aug 2018 12:19:13 PDT (-0700)
Subject:     Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC documentation
In-Reply-To: <CAL_JsqKPFSQYH3p6a0VoCr-VAzf_98H7N3fNJ+4+DquS8WcjUQ@mail.gmail.com>
CC:     atish.patra@wdc.com, Christoph Hellwig <hch@lst.de>,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-463e6ce3-921c-4cf3-a76e-06a369b280d4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Aug 2018 07:16:14 PDT (-0700), robh+dt@kernel.org wrote:
> On Tue, Aug 7, 2018 at 8:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Mon, 06 Aug 2018 13:59:48 PDT (-0700), robh+dt@kernel.org wrote:
>> > On Thu, Aug 2, 2018 at 4:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>> >>
>> >> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
>> >> > From: Palmer Dabbelt <palmer@dabbelt.com>
>> >> >
>> >> > This patch adds documentation for the platform-level interrupt
>> >> > controller (PLIC) found in all RISC-V systems.  This interrupt
>> >> > controller routes interrupts from all the devices in the system to each
>> >> > hart-local interrupt controller.
>> >> >
>> >> > Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
>> >> > want to change how we're specifying holes in the hart list.
>> >> >
>> >> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> >> > [hch: various fixes and updates]
>> >> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> >> > ---
>> >> >   .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
>> >> >   1 file changed, 57 insertions(+)
>> >> >   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> >
>> >> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> > new file mode 100644
>> >> > index 000000000000..c756cd208a93
>> >> > --- /dev/null
>> >> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> > @@ -0,0 +1,57 @@
>> >> > +SiFive Platform-Level Interrupt Controller (PLIC)
>> >> > +-------------------------------------------------
>> >> > +
>> >> > +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
>> >> > +(PLIC) high-level specification in the RISC-V Privileged Architecture
>> >> > +specification.  The PLIC connects all external interrupts in the system to all
>> >> > +hart contexts in the system, via the external interrupt source in each hart.
>> >> > +
>> >> > +A hart context is a privilege mode in a hardware execution thread.  For example,
>> >> > +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
>> >> > +privilege modes per hart; machine mode and supervisor mode.
>> >> > +
>> >> > +Each interrupt can be enabled on per-context basis. Any context can claim
>> >> > +a pending enabled interrupt and then release it once it has been handled.
>> >> > +
>> >> > +Each interrupt has a configurable priority. Higher priority interrupts are
>> >> > +serviced first. Each context can specify a priority threshold. Interrupts
>> >> > +with priority below this threshold will not cause the PLIC to raise its
>> >> > +interrupt line leading to the context.
>> >> > +
>> >> > +While the PLIC supports both edge-triggered and level-triggered interrupts,
>> >> > +interrupt handlers are oblivious to this distinction and therefore it is not
>> >> > +specified in the PLIC device-tree binding.
>> >> > +
>> >> > +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
>> >> > +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
>> >> > +specific memory layout, which is documented in chapter 8 of the SiFive U5
>> >> > +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
>> >> > +
>> >> > +Required properties:
>> >> > +- compatible : "sifive,plic0"
>>
>> I think there was a thread bouncing around somewhere where decided to pick the
>> official name of the compatible string to be "sifive,plic-1.0".  The idea here
>> is that the PLIC is compatible across all of SiFive's current implementations,
>> but there's some limitations in the memory map that will probably cause us to
>> spin a version 2 at some point so we want major version number.  The minor
>> number is just in case we find some errata in the PLIC.
>
> Is 1.0 an actual version number corresponding to an exact, revision
> controlled version of the IP or just something you made up? Looks like
> the latter to me and I'm not a fan of s/w folks making up version
> numbers for h/w. Standard naming convention is <vendor>,<soc>-<block>
> unless you have good reason to deviate (IP for FPGAs where version
> numbers are exposed to customers is one example).

The hardware versioning scheme calls it "riscv,plic0", which is what we were 
originally using.  This PLIC isn't actually defined as a RISC-V spec, so we 
wanted to change it to a "sifive,*" name instead.  Since we were going to 
change the compat string anyway, I thought we'd just introduce a minor number 
to be safe.  Since "0.0" is an awkward number, I figured "1.0" would be saner.

I don't have a concrete idea of when the minor number would be used in the 
PLIC, but we do have a UART and I'd like to make a minor revision of that.  
This might be too much detail, but essentially the UART consists of two parts: 
a byte-wide FIFO that runs at the processor's clock, and then a bit-wide shift 
register that ruts at the UART clock.  The shift register is driven by a simple 
digital clock divider off the FIFO's clock, which means that whenever you 
change the FIFO's clock speed (for power management or whatever) you also need 
to change the clock divider to keep the UART's baud rate constant.

As a result, if you change the clock while the UART is in the middle of 
transmitting a byte then you get corruption.  There's a signal that says "the 
UART TX queue is empty" that can be read from software, but that signal points 
to the TX FIFO and doesn't account for the additional time to stream out the 
contents of the shift register.  There are configurations of the baud rate, bus 
latency, and clock speeds such that the "TX FIFO empty" poll can make it back 
to the core and the core's write to the clock controller can materialize at 
whatever magic makes the clocks change before the UART has serialized out every 
bit in the shift register, which manifests as corruption.

With the current UART hardware, which has a tentative compat string of 
"sifive,uart0", we need to determine that the shift registers has drained in an 
open-loop manner (ie, just wait for a bit).  This is ugly.  I'd like to spin a 
minor version of the UART that just has an extra control bit made available to 
software that tracks when the shift register drains, but since the drivers for 
the old version would be compatible it seems like calling that "sifive,uart1" 
is too big of a version jump.  Of course the Linux OF infrastructure assigns no 
semantic meaning to compat strings so it doesn't matter here, but we use device 
trees all over the place 

Thus, I thought that if we were going to change the naming scheme that we might 
as well go put in a minor version number just to be safe.  Sorry if that's a 
bit too much info... :)

Of course, this is all open source RTL so you can just see what's going on 
here in the PLIC

    https://github.com/freechipsproject/rocket-chip/blob/384096a6a73f0e94d6f7bd4bc9cc422e0a213e88/src/main/scala/devices/tilelink/Plic.scala#L69

and in the UART

    https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L91

We'll change the name generated by the hardware to match whatever's decided on 
here, so there won't be a rift between the hardware and the software.

This actually brings up an issue with the standard naming scheme, which in this 
cause would be something like "sifive,u540-c000-plic": the RTL is open source, 
so anyone can go build a chip with it at any time.  I've been operating under 
the impression that it will be impossible to maintain a central database of all 
implementations, so the fallback name will be the defacto name that becomes the 
interface.

I'd be happy to put a "sifive,u540-c000-plic" in there (I'd called in 
"sifive,u540-c000,plic" before, but that's just me not knowing the standard 
naming scheme) just to make sure we have a specific name.  We at SiFive can 
make sure we provide sane unique names for all our implementations, but I think 
we also really need to hammer out what the general compat string is because I 
don't think we can rely one everyone to do that.

There are devices that are very specific to a chip, and there we will have 
chip-specific names for them -- for example the PRCI (power, reset, clock and 
interrupt) block is different for pretty much every chip, so it'll be called 
something like "sifive,u540-c000-prci" (or maybe "sifive,aloe-prci", depending 
on whether we want to use engineering code names or marketing names in the 
bindings, which is a debate for later).  I'm less worried about these, though, 
as people building chips must pay a lot of attention to things like clock 
muxing so they're unlikely to accidentally end up with one floating around.

> And defining a version 2 when you find a quirk doesn't work. You've
> already shipped the DT. You need to be able to fix issues with just an
> OS update. This is why you are supposed to define a compatible string
> for each and every SoC (and use a fallback when they are "the
> same"TM).

Yes, of course -- we actually put the DTB in ROM on the chips, so there's 
really no option to change it aside from hacking up something nasty in the 
bootloader.  We're doing this for the u540-c000 because we haven't standardized 
the bindings.  There aren't that many u540-c000s in the wild so I'm OK 
shouldering the burden of making everyone upload their bootloaders with 
whatever workarounds are necessary to boot an upstream kernel.

I view that as just my punishment for not having properly discussed the 
bindings before shipping hardware (and out of tree kernels), but that won't be 
viable in the future.  I view this as just like any other ABI stabilization, 
where it's not officially stable until we're upstream.  That's why I'd like to 
get a good scheme for naming these in the future, as once this is in I'm 
stuck with any mistakes forever.

>> >> > +- #address-cells : should be <0>
>> >> > +- #interrupt-cells : should be <1>
>> >> > +- interrupt-controller : Identifies the node as an interrupt controller
>> >> > +- reg : Should contain 1 register range (address and length)
>> >>
>> >> The one in the real device tree has two entries.
>> >> reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;
>> >>
>> >> Is it intentional or just incorrect entry left over from earlier days?
>> >
>> >> > +             reg = <0xc000000 0x4000000>;
>> >
>> > Looks to me like one has #size-cells and #address-cells set to 2 and
>> > the example is using 1.
>>
>> Yes.  For some background on how this works: we have a hardware generator that
>> has a tree-of-busses abstraction, and each device is attached to some point on
>> that tree.  When a device gets attached to the bus, we also generate a device
>> tree entry.  For whatever system I generated the example PLIC device tree entry
>> from, it must have been attached to a bus with addresses of 32 bits or less,
>> which resulted in #address-cells and #size-cells being 1.
>>
>> Christoph has a HiFive Unleashed, which has a fu540-c000 on it, which is
>> probably not what I generated as an example -- the fu540-c000 is a complicated
>> configuration, when I mess around with the hardware I tend to use simple ones
>> as I'm not really a hardware guy.  I suppose the bus that the PLIC is hanging
>> off on the fu540-c000 has addresses wider than 32 bits.  This makes sense, as
>> the machine has 8GiB of memory and the PLIC is on a bus that's closer to the
>> core than the DRAM is, so it'd need at least enough address bits to fit 8GiB.
>>
>> Is the inconsistency a problem?  I generally write device tree handling code to
>> just respect whatever #*-fields says and don't consider that part of the
>> specification of the binding.  I don't mind changing the example to have
>> #size-fields and #address-fields to be 2, but since it's not wrong I also don't
>> see any reason to change it.  We do have 32-bit devices with PLICs, and while
>> they're not Linux-capable devices we're trying to adopt the Linux device tree
>> bindings through the rest of the RISC-V software ecosystem as they tend to be
>> pretty well thought out.
>
> The example is just an example and dts files can use either. For dts
> files though, you should use the smallest size necessary and utilize
> 'ranges'. Some folks seem to think a 64-bit chip needs 64-bit address
> and size everywhere. That's true at the top level typically, but
> individual buses often don't span more than 4GB of address space. But
> all that's out of scope of the example.

OK, thanks.  I think we're doing this where it's possible -- we emit ranges for 
busses, and I know that at least some of them (ie, the low-speed peripheral bus 
that essentially always fits into a 32-bit physical address) ends up with 
#{address,size}-cells=1.

I'll try to keep this in mind as we start to submit more bindings.

> There are no "Linux device tree bindings". There are DT bindings that
> happen to be hosting within the Linux tree for convenience.

Ah, OK.  By "Linux device tree bindings" I meant the ones stored in 
Documentation, which is what we considered the authoritative source and were 
planning on adopting everywhere we use device tree (ie, fixing the rest of our 
code as a result of the discussions we have submitting the bindings).  I'd 
heard some people refer to these as Linux specific, but I'm glad they're not as 
it means we won't be pushing upstream on getting everyone to agree on one set 
of bindings.

Does this mean I can submit bindings for devices that don't have a Linux 
driver?  How about devices where it doesn't even really make sense to ever have 
a Linux driver?
