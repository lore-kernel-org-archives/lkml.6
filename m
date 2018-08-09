Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D263AC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6288221B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="CKdaN4Ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6288221B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeHIIwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:52:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40766 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeHIIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:52:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so2108842plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6W3fgKWv/OZ6eM+1It2ywkjstTKa1/4jMH+EVIQISvU=;
        b=CKdaN4Ks1/LjnmiYo9Nze4o1dOSBdpDGZWfpm4KA2WOMoXR20bv569oFiR0P7sSdVg
         OAVMLrHv7mF5xWi/bef6jTFwwHVgre4PbAgb91WTkPdbyY9g4irGuETLA44Tx5Q1h5Nl
         j53zQTM5kBy8WWxcHyxhnCKnEkNH9/LAAWXIUMK6oJ86CD1E9ltIHz1oZByynhDZoRh4
         uMtn25bL8MuMS2DFlCFdLz/V0YUecVkQxEwezSNsBCE/zQwZ8TmOhtZytK+cZW89HiBb
         YEyhlMGdusrUpRvYoH52PGQx5bfB5zzpFvuGCfZnylBBfpW7LKn5AvYF6i8u1KKHO6/y
         yLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6W3fgKWv/OZ6eM+1It2ywkjstTKa1/4jMH+EVIQISvU=;
        b=mqcgJ5t6SHuu/QeSRBuKrWPZZ2a1QS4nEb1vfPnr11mt1onbxF/mDJwfhs0S2Rlof3
         tvm9TXTmNaLb4pFjj8LHPE+DNdCQTB2HWCj8IQH5TIRBjzoTJMVXwwhdXkl79T5uFCew
         YTmla/fa8IcRHlMM5TEjK93AZpvJCeKotAjJj4tXAJnWF+ZOh72NBoltnT9g5dMnHIRZ
         gIxaruJj+/xFJ57g1kNBR/d6C23IqvyQxuU2qn15zBczqvKesPUK9LEK5ZmkTx8hxmW6
         nRmCJShvXkIt1JJnpO6y1+lQWsVdA/5FuLZukakqJfcQx6WAHGVBpIha/Iwxn1iurJL8
         3IcQ==
X-Gm-Message-State: AOUpUlFIg6lfqkR7Bq7/KGWhlqRqASaLAK20yA31u2Zs/128uS/y9yuq
        QNIjfDCQZz/L4h5XQsLFXcw8jw==
X-Google-Smtp-Source: AA+uWPzmwc/2Ev3TnaPZHBG9UpPFSfgBjBROa+yWJtjj6xSkR0vQ2Y//0iB6cnAqvpLJkmjr91EsnQ==
X-Received: by 2002:a17:902:e005:: with SMTP id ca5-v6mr836802plb.224.1533796158393;
        Wed, 08 Aug 2018 23:29:18 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id e190-v6sm17197821pfc.81.2018.08.08.23.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 23:29:17 -0700 (PDT)
Date:   Wed, 08 Aug 2018 23:29:17 -0700 (PDT)
X-Google-Original-Date: Wed, 08 Aug 2018 23:01:04 PDT (-0700)
Subject:     Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC documentation
In-Reply-To: <CAL_JsqKVTGcJP=AJR+6h1Brv8MW9xjD=v2__Xtegkd-+Hnua7g@mail.gmail.com>
CC:     atish.patra@wdc.com, Christoph Hellwig <hch@lst.de>,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-cfa17eb2-3548-48ee-9216-74a3607a3091@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Aug 2018 16:32:07 PDT (-0700), robh+dt@kernel.org wrote:
> On Wed, Aug 8, 2018 at 1:38 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 08 Aug 2018 07:16:14 PDT (-0700), robh+dt@kernel.org wrote:
>> > On Tue, Aug 7, 2018 at 8:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >>
>> >> On Mon, 06 Aug 2018 13:59:48 PDT (-0700), robh+dt@kernel.org wrote:
>> >> > On Thu, Aug 2, 2018 at 4:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>> >> >>
>> >> >> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
>> >> >> > From: Palmer Dabbelt <palmer@dabbelt.com>
>> >> >> >
>> >> >> > This patch adds documentation for the platform-level interrupt
>> >> >> > controller (PLIC) found in all RISC-V systems.  This interrupt
>> >> >> > controller routes interrupts from all the devices in the system to each
>> >> >> > hart-local interrupt controller.
>> >> >> >
>> >> >> > Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
>> >> >> > want to change how we're specifying holes in the hart list.
>> >> >> >
>> >> >> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> >> >> > [hch: various fixes and updates]
>> >> >> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> >> >> > ---
>> >> >> >   .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
>> >> >> >   1 file changed, 57 insertions(+)
>> >> >> >   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> >> >
>> >> >> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> >> > new file mode 100644
>> >> >> > index 000000000000..c756cd208a93
>> >> >> > --- /dev/null
>> >> >> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> >> > @@ -0,0 +1,57 @@
>> >> >> > +SiFive Platform-Level Interrupt Controller (PLIC)
>> >> >> > +-------------------------------------------------
>> >> >> > +
>> >> >> > +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
>> >> >> > +(PLIC) high-level specification in the RISC-V Privileged Architecture
>> >> >> > +specification.  The PLIC connects all external interrupts in the system to all
>> >> >> > +hart contexts in the system, via the external interrupt source in each hart.
>> >> >> > +
>> >> >> > +A hart context is a privilege mode in a hardware execution thread.  For example,
>> >> >> > +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
>> >> >> > +privilege modes per hart; machine mode and supervisor mode.
>> >> >> > +
>> >> >> > +Each interrupt can be enabled on per-context basis. Any context can claim
>> >> >> > +a pending enabled interrupt and then release it once it has been handled.
>> >> >> > +
>> >> >> > +Each interrupt has a configurable priority. Higher priority interrupts are
>> >> >> > +serviced first. Each context can specify a priority threshold. Interrupts
>> >> >> > +with priority below this threshold will not cause the PLIC to raise its
>> >> >> > +interrupt line leading to the context.
>> >> >> > +
>> >> >> > +While the PLIC supports both edge-triggered and level-triggered interrupts,
>> >> >> > +interrupt handlers are oblivious to this distinction and therefore it is not
>> >> >> > +specified in the PLIC device-tree binding.
>> >> >> > +
>> >> >> > +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
>> >> >> > +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
>> >> >> > +specific memory layout, which is documented in chapter 8 of the SiFive U5
>> >> >> > +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
>> >> >> > +
>> >> >> > +Required properties:
>> >> >> > +- compatible : "sifive,plic0"
>> >>
>> >> I think there was a thread bouncing around somewhere where decided to pick the
>> >> official name of the compatible string to be "sifive,plic-1.0".  The idea here
>> >> is that the PLIC is compatible across all of SiFive's current implementations,
>> >> but there's some limitations in the memory map that will probably cause us to
>> >> spin a version 2 at some point so we want major version number.  The minor
>> >> number is just in case we find some errata in the PLIC.
>> >
>> > Is 1.0 an actual version number corresponding to an exact, revision
>> > controlled version of the IP or just something you made up? Looks like
>> > the latter to me and I'm not a fan of s/w folks making up version
>> > numbers for h/w. Standard naming convention is <vendor>,<soc>-<block>
>> > unless you have good reason to deviate (IP for FPGAs where version
>> > numbers are exposed to customers is one example).
>>
>> The hardware versioning scheme calls it "riscv,plic0", which is what we were
>> originally using.  This PLIC isn't actually defined as a RISC-V spec, so we
>> wanted to change it to a "sifive,*" name instead.  Since we were going to
>> change the compat string anyway, I thought we'd just introduce a minor number
>> to be safe.  Since "0.0" is an awkward number, I figured "1.0" would be saner.
>
> So I guess to answer my question, you are just making up version
> numbers. Unless you are doing the IP verilog too, don't do that.

Well, in this case my proposal would be that we change the hardware team's 
versioning scheme to match whatever we decide on the versioning scheme should 
be as a part of this discussion.  I proposed accepting whatever versioning 
scheme is decided upon hereto the hardware team before discussing changing the 
naming scheme and they agreed to do so.

So we're really in the drivers' seat here.

> If you want to use just 'sifive,plic' then I'm fine with that. I've
> given you the potential problems with that and they will be your
> problems to deal with. Maybe you'll get lucky. Plus it won't be a
> problem for the 1st implementation.

I'd prefer to have some versioning scheme, that's why I'm talking so much about 
this :).  I really just want to learn how to get the right one, as I'm quite 
new to all this and we'll have many of these.

>> I don't have a concrete idea of when the minor number would be used in the
>> PLIC, but we do have a UART and I'd like to make a minor revision of that.
>> This might be too much detail, but essentially the UART consists of two parts:
>> a byte-wide FIFO that runs at the processor's clock, and then a bit-wide shift
>> register that ruts at the UART clock.  The shift register is driven by a simple
>> digital clock divider off the FIFO's clock, which means that whenever you
>> change the FIFO's clock speed (for power management or whatever) you also need
>> to change the clock divider to keep the UART's baud rate constant.
>>
>> As a result, if you change the clock while the UART is in the middle of
>> transmitting a byte then you get corruption.  There's a signal that says "the
>> UART TX queue is empty" that can be read from software, but that signal points
>> to the TX FIFO and doesn't account for the additional time to stream out the
>> contents of the shift register.  There are configurations of the baud rate, bus
>> latency, and clock speeds such that the "TX FIFO empty" poll can make it back
>> to the core and the core's write to the clock controller can materialize at
>> whatever magic makes the clocks change before the UART has serialized out every
>> bit in the shift register, which manifests as corruption.
>
> I've experienced some broken UART clocking like that in the past.
>
> That's a good example of why you may need SoC specific (or integration
> specific) compatible strings. A future design could clock the FIFO
> with a different clock that is fixed freq. A driver would distinguish
> this quirk with different compatible strings.

Ah, OK -- this has me a bit worried that I really fundamentally understand 
what's going on here.  In my model, if you have a UART that's missing the 
"actually done" signal then it's the same UART regardless of whether it's 
driver by a fixed or variable clock.  It's up to Linux to determine that this 
configuration doesn't require draining queues on clock changes (kind of an 
awkward example, as fixed clocks can't change), which we allow it to do by 
associating a clock with each UART.  This allows the UART driver to see the rest 
of the system, but in a manner rooted at the UART device as that's the part 
most likely to be relevant to the UART driver.

If the model is meant to be that "UART attached to a fixed clock" is different 
then "UART attached to a variable clock", then we must tag each device with the 
chip's fill name -- that's the only way to uniquely identify how the UART 
behaves in the context of the entire system.

My one worry is that there will be a lot of these.  I'm not even privy to any 
details about what's going on in RISC-V hardware land, but I can count a 
hundred today and they can all use the same driver.  There's then the 
additional headache that we'll never be able to publicly disclose most of these 
designs, which leaves all of those having unspecified behavior.

>> With the current UART hardware, which has a tentative compat string of
>> "sifive,uart0", we need to determine that the shift registers has drained in an
>> open-loop manner (ie, just wait for a bit).  This is ugly.  I'd like to spin a
>> minor version of the UART that just has an extra control bit made available to
>> software that tracks when the shift register drains, but since the drivers for
>> the old version would be compatible it seems like calling that "sifive,uart1"
>> is too big of a version jump.  Of course the Linux OF infrastructure assigns no
>> semantic meaning to compat strings so it doesn't matter here, but we use device
>> trees all over the place
>>
>> Thus, I thought that if we were going to change the naming scheme that we might
>> as well go put in a minor version number just to be safe.  Sorry if that's a
>> bit too much info... :)
>>
>> Of course, this is all open source RTL so you can just see what's going on
>> here in the PLIC
>>
>>     https://github.com/freechipsproject/rocket-chip/blob/384096a6a73f0e94d6f7bd4bc9cc422e0a213e88/src/main/scala/devices/tilelink/Plic.scala#L69
>>
>> and in the UART
>>
>>     https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L91
>>
>> We'll change the name generated by the hardware to match whatever's decided on
>> here, so there won't be a rift between the hardware and the software.
>
> What exactly gets generated by the hardware?

Sorry, by "generated by the hardware" I really meant "generated along with the 
hardware".  Essentially what happens is that whatever system collects the RTL 
blocks to be emitted also collects the device tree nodes to be emitted, thus 
ensuring they always match.  This is the ground truth for our device trees, and 
it's how we ensure the device tree always matches the RTL.  Whatever compatible 
string we agree on for the bindings will be reflected in this system, so the 
ground truth always matches the spec.

There's nothing we can do about what's already been shipped (ie, pre-spec 
hardware), and ensuring that RTL modifications that change software 
compatibility cause a change to the device tree node's compat string is 
something we at SiFive enforce by code review.

>> This actually brings up an issue with the standard naming scheme, which in this
>> cause would be something like "sifive,u540-c000-plic": the RTL is open source,
>> so anyone can go build a chip with it at any time.  I've been operating under
>> the impression that it will be impossible to maintain a central database of all
>> implementations, so the fallback name will be the defacto name that becomes the
>> interface.
>>
>> I'd be happy to put a "sifive,u540-c000-plic" in there (I'd called in
>> "sifive,u540-c000,plic" before, but that's just me not knowing the standard
>> naming scheme) just to make sure we have a specific name.  We at SiFive can
>> make sure we provide sane unique names for all our implementations, but I think
>> we also really need to hammer out what the general compat string is because I
>> don't think we can rely one everyone to do that.
>
> Propose something. If compatible strings can be traced back to exactly
> what versions of IP are used and there's a well defined process for
> setting version numbers, then I'm fine with using version numbers in
> compatible strings. Having version registers are helpful in that
> regard. And if there are configuration options in the IP, registers to
> read those too.
>
> Presumably folks (including SiFive?) fork and modify the opensource
> IP? Along the same lines as no one ships mainline kernels. Not sure
> how you deal with that if you only use versions.

We (and as far as I know, other vendors -- though I know little about anyone 
else' flow) ship RTL from the upstream blocks.  The blocks tend to just become 
stable enough that the only changes are bug fixes anyway, and as we approach 
tape out there are very few bugs.

The trend towards stability is particularly true of blocks like the PLIC that 
have been taped out multiple times, where pretty much all that changes is the 
interface to the generator.  There's a bunch of top-level stuff that's done out 
of tree, and we add our own special blocks in, but for the leaf blocks we 
generally match upstream closely.

Or at least that's what it looks like to me -- I don't do ECOs here, so maybe 
I'm just in the dark :)

>> There are devices that are very specific to a chip, and there we will have
>> chip-specific names for them -- for example the PRCI (power, reset, clock and
>> interrupt) block is different for pretty much every chip, so it'll be called
>> something like "sifive,u540-c000-prci" (or maybe "sifive,aloe-prci", depending
>> on whether we want to use engineering code names or marketing names in the
>> bindings, which is a debate for later).  I'm less worried about these, though,
>> as people building chips must pay a lot of attention to things like clock
>> muxing so they're unlikely to accidentally end up with one floating around.
>>
>> > And defining a version 2 when you find a quirk doesn't work. You've
>> > already shipped the DT. You need to be able to fix issues with just an
>> > OS update. This is why you are supposed to define a compatible string
>> > for each and every SoC (and use a fallback when they are "the
>> > same"TM).
>>
>> Yes, of course -- we actually put the DTB in ROM on the chips, so there's
>> really no option to change it aside from hacking up something nasty in the
>> bootloader.  We're doing this for the u540-c000 because we haven't standardized
>> the bindings.  There aren't that many u540-c000s in the wild so I'm OK
>> shouldering the burden of making everyone upload their bootloaders with
>> whatever workarounds are necessary to boot an upstream kernel.
>
> I've been there too.
>
>> I view that as just my punishment for not having properly discussed the
>> bindings before shipping hardware (and out of tree kernels), but that won't be
>> viable in the future.  I view this as just like any other ABI stabilization,
>> where it's not officially stable until we're upstream.  That's why I'd like to
>> get a good scheme for naming these in the future, as once this is in I'm
>> stuck with any mistakes forever.
>
> That's certainly reasonable and necessary. I'm just trying to make
> sure it's understood how compatible is supposed to work.

Yes, and thank you for spending so much time on this.  I really worry about 
getting these sort of interfaces well thought out, as I'm the one who is going 
to get burned by all the stupid mistakes I make :).

>> >> >> > +- #address-cells : should be <0>
>> >> >> > +- #interrupt-cells : should be <1>
>> >> >> > +- interrupt-controller : Identifies the node as an interrupt controller
>> >> >> > +- reg : Should contain 1 register range (address and length)
>> >> >>
>> >> >> The one in the real device tree has two entries.
>> >> >> reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;
>> >> >>
>> >> >> Is it intentional or just incorrect entry left over from earlier days?
>> >> >
>> >> >> > +             reg = <0xc000000 0x4000000>;
>> >> >
>> >> > Looks to me like one has #size-cells and #address-cells set to 2 and
>> >> > the example is using 1.
>> >>
>> >> Yes.  For some background on how this works: we have a hardware generator that
>> >> has a tree-of-busses abstraction, and each device is attached to some point on
>> >> that tree.  When a device gets attached to the bus, we also generate a device
>> >> tree entry.  For whatever system I generated the example PLIC device tree entry
>> >> from, it must have been attached to a bus with addresses of 32 bits or less,
>> >> which resulted in #address-cells and #size-cells being 1.
>> >>
>> >> Christoph has a HiFive Unleashed, which has a fu540-c000 on it, which is
>> >> probably not what I generated as an example -- the fu540-c000 is a complicated
>> >> configuration, when I mess around with the hardware I tend to use simple ones
>> >> as I'm not really a hardware guy.  I suppose the bus that the PLIC is hanging
>> >> off on the fu540-c000 has addresses wider than 32 bits.  This makes sense, as
>> >> the machine has 8GiB of memory and the PLIC is on a bus that's closer to the
>> >> core than the DRAM is, so it'd need at least enough address bits to fit 8GiB.
>> >>
>> >> Is the inconsistency a problem?  I generally write device tree handling code to
>> >> just respect whatever #*-fields says and don't consider that part of the
>> >> specification of the binding.  I don't mind changing the example to have
>> >> #size-fields and #address-fields to be 2, but since it's not wrong I also don't
>> >> see any reason to change it.  We do have 32-bit devices with PLICs, and while
>> >> they're not Linux-capable devices we're trying to adopt the Linux device tree
>> >> bindings through the rest of the RISC-V software ecosystem as they tend to be
>> >> pretty well thought out.
>> >
>> > The example is just an example and dts files can use either. For dts
>> > files though, you should use the smallest size necessary and utilize
>> > 'ranges'. Some folks seem to think a 64-bit chip needs 64-bit address
>> > and size everywhere. That's true at the top level typically, but
>> > individual buses often don't span more than 4GB of address space. But
>> > all that's out of scope of the example.
>>
>> OK, thanks.  I think we're doing this where it's possible -- we emit ranges for
>> busses, and I know that at least some of them (ie, the low-speed peripheral bus
>> that essentially always fits into a 32-bit physical address) ends up with
>> #{address,size}-cells=1.
>>
>> I'll try to keep this in mind as we start to submit more bindings.
>>
>> > There are no "Linux device tree bindings". There are DT bindings that
>> > happen to be hosting within the Linux tree for convenience.
>>
>> Ah, OK.  By "Linux device tree bindings" I meant the ones stored in
>> Documentation, which is what we considered the authoritative source and were
>> planning on adopting everywhere we use device tree (ie, fixing the rest of our
>> code as a result of the discussions we have submitting the bindings).  I'd
>> heard some people refer to these as Linux specific, but I'm glad they're not as
>> it means we won't be pushing upstream on getting everyone to agree on one set
>> of bindings.
>>
>> Does this mean I can submit bindings for devices that don't have a Linux
>> driver?
>
> Certainly. ARM Mali GPU bindings don't have an (upstream) driver.
>
> My main concern is if there is neither a driver nor a dts using a
> binding, how do we know if it is used or not at some time in the
> future.

Well, I guess my argument would be: why does this matter?  If it's in the spec 
then it's in the spec, and we're not breaking anything that's compatible so we 
can't change it.

Though in practice I think any bindings that make their way into the spec will 
have a driver make it into at least some open source repository or be 
demonstrably in some physical object, as otherwise why would you bother going 
through the effort of adding it to the spec?  The best way to solve this seems 
to be at the review level: we just ensure that the bindings that are accepted 
into the standard are real enough that they're actually useful.

>> How about devices where it doesn't even really make sense to ever have
>> a Linux driver?
>
> Yes.
>
> Rob
