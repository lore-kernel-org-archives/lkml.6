Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0FCC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5A622426
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="hwKPuBHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5A622426
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHJWk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:40:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45770 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeHJWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:40:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so4996361pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bGJhqzxfdFzPRXRxlsFp+uv3zZSsDOhCxUXbqwoEgTo=;
        b=hwKPuBHNazJhClnT+swj7o6OestfjbqBeTM5PlnUGlXpcQMrEe3a6L4vKmsEfSH0d9
         O31+Rj7X3JSrjxE25epXP+WTssv/2u2rnRTDYjIeshQHnVVcYzc/vB4xHjpP/pQgSASn
         QjqCAkUdDsYoq1trpAK+xNZkNBe0BOpWhHAlSiKdBJftG5OflXlSfZ1kRNSDuXeSSkGJ
         fi974LWY5z9jXAPzsz10SvTYrmRDt0vsAezownuTYJsK2kr9hnleiJEcISMyaPXJK45s
         yuGevzNqnp3MvirCVvhGKYLGAPPg6f1b5ja23NWfz8h9Pt8gmznHQJMKyh07W7J6Xg3t
         5wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bGJhqzxfdFzPRXRxlsFp+uv3zZSsDOhCxUXbqwoEgTo=;
        b=PeIkililPmtbUuSd5Hp9qvRat6jALnuEw7yqcnjJoshcrYZJYRSiDDSkzkYTe+E7id
         Sdli11t+9/qP8J5OW5QyoJcsR6h7t8UDjIeIsgUNNXLGzu+C+I9f15k9gTs5Oo1zZNYB
         wyq2g+LXAgk1Gc4L3moMgBwmHTP3XKupZ6Ui7IaF7buyhY1+/Qe8TDh+3SSVm9+L8xEw
         5mBETv5PAORq2bfIkiYktERaWgCok3BprGvwIJDd5eiv61nIZ11lzSJW6+/lhDFNvt7b
         J+8D4CZ7OQR4Wc3zKdmDgH8DHZqMELS6VxJjxulyxAJcUfWEsRi7GxhwJo/tTunzVp6g
         lWoA==
X-Gm-Message-State: AOUpUlE6q25l7I3Rdavz2XhOYfE2eZ7ocqXv7gaBo4mClClVTc4qHuDg
        od2uGa8OqgwBTJv8iEq23+mfng==
X-Google-Smtp-Source: AA+uWPxTYsl21JrE48okNrbZhLlJDemEvCWPH42y5Tggg3F2qwm2k3i6CNHMhrLtbg1jtm4Yq67uVQ==
X-Received: by 2002:a62:201b:: with SMTP id g27-v6mr8448861pfg.253.1533931745413;
        Fri, 10 Aug 2018 13:09:05 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g5-v6sm18247498pfc.77.2018.08.10.13.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 13:09:04 -0700 (PDT)
Date:   Fri, 10 Aug 2018 13:09:04 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 13:08:45 PDT (-0700)
Subject:     Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC documentation
In-Reply-To: <CAL_JsqLpM=UG_9aL8CquhP8SajVav5in7RJRDk9tDd=QrTdVFw@mail.gmail.com>
CC:     atish.patra@wdc.com, Christoph Hellwig <hch@lst.de>,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-d9abab59-2b3e-48a7-a28f-84f820964baa@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 09:57:03 PDT (-0700), robh+dt@kernel.org wrote:
> On Thu, Aug 9, 2018 at 12:29 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 08 Aug 2018 16:32:07 PDT (-0700), robh+dt@kernel.org wrote:
>> > On Wed, Aug 8, 2018 at 1:38 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >>
>> >> On Wed, 08 Aug 2018 07:16:14 PDT (-0700), robh+dt@kernel.org wrote:
>> >> > On Tue, Aug 7, 2018 at 8:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >> >>
>> >> >> On Mon, 06 Aug 2018 13:59:48 PDT (-0700), robh+dt@kernel.org wrote:
>> >> >> > On Thu, Aug 2, 2018 at 4:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>> >> >> >>
>> >> >> >> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
>> >> >> >> > From: Palmer Dabbelt <palmer@dabbelt.com>
>> >> >> >> >
>> >> >> >> > This patch adds documentation for the platform-level interrupt
>> >> >> >> > controller (PLIC) found in all RISC-V systems.  This interrupt
>> >> >> >> > controller routes interrupts from all the devices in the system to each
>> >> >> >> > hart-local interrupt controller.
>> >> >> >> >
>> >> >> >> > Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
>> >> >> >> > want to change how we're specifying holes in the hart list.
>> >> >> >> >
>> >> >> >> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> >> >> >> > [hch: various fixes and updates]
>> >> >> >> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> >> >> >> > ---
>> >> >> >> >   .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
>> >> >> >> >   1 file changed, 57 insertions(+)
>> >> >> >> >   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> >> >> >
>> >> >> >> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> >> >> > new file mode 100644
>> >> >> >> > index 000000000000..c756cd208a93
>> >> >> >> > --- /dev/null
>> >> >> >> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >> >> >> > @@ -0,0 +1,57 @@
>> >> >> >> > +SiFive Platform-Level Interrupt Controller (PLIC)
>> >> >> >> > +-------------------------------------------------
>> >> >> >> > +
>> >> >> >> > +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
>> >> >> >> > +(PLIC) high-level specification in the RISC-V Privileged Architecture
>> >> >> >> > +specification.  The PLIC connects all external interrupts in the system to all
>> >> >> >> > +hart contexts in the system, via the external interrupt source in each hart.
>> >> >> >> > +
>> >> >> >> > +A hart context is a privilege mode in a hardware execution thread.  For example,
>> >> >> >> > +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
>> >> >> >> > +privilege modes per hart; machine mode and supervisor mode.
>> >> >> >> > +
>> >> >> >> > +Each interrupt can be enabled on per-context basis. Any context can claim
>> >> >> >> > +a pending enabled interrupt and then release it once it has been handled.
>> >> >> >> > +
>> >> >> >> > +Each interrupt has a configurable priority. Higher priority interrupts are
>> >> >> >> > +serviced first. Each context can specify a priority threshold. Interrupts
>> >> >> >> > +with priority below this threshold will not cause the PLIC to raise its
>> >> >> >> > +interrupt line leading to the context.
>> >> >> >> > +
>> >> >> >> > +While the PLIC supports both edge-triggered and level-triggered interrupts,
>> >> >> >> > +interrupt handlers are oblivious to this distinction and therefore it is not
>> >> >> >> > +specified in the PLIC device-tree binding.
>> >> >> >> > +
>> >> >> >> > +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
>> >> >> >> > +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
>> >> >> >> > +specific memory layout, which is documented in chapter 8 of the SiFive U5
>> >> >> >> > +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
>> >> >> >> > +
>> >> >> >> > +Required properties:
>> >> >> >> > +- compatible : "sifive,plic0"
>> >> >>
>> >> >> I think there was a thread bouncing around somewhere where decided to pick the
>> >> >> official name of the compatible string to be "sifive,plic-1.0".  The idea here
>> >> >> is that the PLIC is compatible across all of SiFive's current implementations,
>> >> >> but there's some limitations in the memory map that will probably cause us to
>> >> >> spin a version 2 at some point so we want major version number.  The minor
>> >> >> number is just in case we find some errata in the PLIC.
>> >> >
>> >> > Is 1.0 an actual version number corresponding to an exact, revision
>> >> > controlled version of the IP or just something you made up? Looks like
>> >> > the latter to me and I'm not a fan of s/w folks making up version
>> >> > numbers for h/w. Standard naming convention is <vendor>,<soc>-<block>
>> >> > unless you have good reason to deviate (IP for FPGAs where version
>> >> > numbers are exposed to customers is one example).
>> >>
>> >> The hardware versioning scheme calls it "riscv,plic0", which is what we were
>> >> originally using.  This PLIC isn't actually defined as a RISC-V spec, so we
>> >> wanted to change it to a "sifive,*" name instead.  Since we were going to
>> >> change the compat string anyway, I thought we'd just introduce a minor number
>> >> to be safe.  Since "0.0" is an awkward number, I figured "1.0" would be saner.
>> >
>> > So I guess to answer my question, you are just making up version
>> > numbers. Unless you are doing the IP verilog too, don't do that.
>>
>> Well, in this case my proposal would be that we change the hardware team's
>> versioning scheme to match whatever we decide on the versioning scheme should
>> be as a part of this discussion.  I proposed accepting whatever versioning
>> scheme is decided upon hereto the hardware team before discussing changing the
>> naming scheme and they agreed to do so.
>>
>> So we're really in the drivers' seat here.
>
> Okay. So you could have something like x.y.z versioning where a change
> in X is change in register layout and/or major functional change, Y is
> backwards compatible changes (i.e. superset of functionality), Z is
> not s/w visible changes (though trusting that Z changes are really not
> s/w visible makes me nervous). If you have a version register, then
> the compatible string only needs to be specific enough to read that
> register.
>
> And if I can have anything I ask for, then any configuration option
> needs to be s/w readable too. Things like FIFO sizes, number of
> channels, etc. Sometimes these are DT properties, but generally the
> preference is to make these implied by the compatible. There's no set
> rule though. The problem with properties is they work well if you know
> up front to have them, but often something is fixed and implied and
> then becomes variable when a new version of the block is created.
>
> Think of it this way, DT is a work-around for non-discoverable h/w.
> The best solution is making the h/w more discoverable. If you look at
> the ARM Primecell aka amba_bus drivers, we don't actually match on the
> device compatible string (e.g. arm,pl011). Only "arm,primecell" is
> used and then we match with standard ID registers from there. We only
> need DT to discover where those blocks are, not what they are or what
> version they are (and of course other things like clocks, regulators,
> etc.).

Ya, good, that's generally been my model for it.  In the PLIC there isn't a 
whole lot in terms of configuration options to probe dynamically, as the 
register layout is fixed (determined by the device tree compat string) and the 
interrupt routings are fixed (determined by interrupt-parent and reg).  There's 
some amount of scheme for probing these, but since the routings aren't 
discoverable without the device tree they're not really useful in practice.

Our more modern blocks are becoming larger in scope, and these tend to have 
their options determined by software.  For example, SiFive's CLIC proposal (a 
proposal for a new RISC-V core-local interrupt controller) has many runtime 
discoverable properties, with pretty much only the base address being specified 
in the device tree -- here's an example of a binding

		L1: interrupt-controller@2000000 {
			compatible = "riscv,clic0";
			interrupts-extended = <&L2 3 &L2 7 &L2 11>;
			reg = <0x2000000 0x1000000>;
			reg-names = "control";
		};

I don't want to go too far down the CLIC path, though, as there's still a lot 
of work to be done there :)

> So what your compatible string(s) need to look like depend on all the
> above. It can be very generic if you can identify the block, version,
> and capabilities in a standard way.

For now I think the best bet is to go with "sifive,plic-1.0.0" as well as 
"sifive,fu540-c000-plic".  That way we've got plenty of room to avoid painting 
ourselves into a corner later.  In the interest of getting people a system they 
can start testing, I'm going to go ahead and bring the PLIC driver into my 
for-next branch with the "sifive,plic-1.0.0" binding.  I don't want to just 
unilaterally kill the discussion, but I figure we can always submit a fixup 
driver patch later if I'm wrong and we're not on the same page now.

I've also gone ahead and opened a PR against the RTL generator, but I'll wait 
on the bindings to be officially accepted before merging that:

    https://github.com/freechipsproject/rocket-chip/pull/1575

I'm assuming the bindings will go in through your tree?

>> > If you want to use just 'sifive,plic' then I'm fine with that. I've
>> > given you the potential problems with that and they will be your
>> > problems to deal with. Maybe you'll get lucky. Plus it won't be a
>> > problem for the 1st implementation.
>>
>> I'd prefer to have some versioning scheme, that's why I'm talking so much about
>> this :).  I really just want to learn how to get the right one, as I'm quite
>> new to all this and we'll have many of these.
>>
>> >> I don't have a concrete idea of when the minor number would be used in the
>> >> PLIC, but we do have a UART and I'd like to make a minor revision of that.
>> >> This might be too much detail, but essentially the UART consists of two parts:
>> >> a byte-wide FIFO that runs at the processor's clock, and then a bit-wide shift
>> >> register that ruts at the UART clock.  The shift register is driven by a simple
>> >> digital clock divider off the FIFO's clock, which means that whenever you
>> >> change the FIFO's clock speed (for power management or whatever) you also need
>> >> to change the clock divider to keep the UART's baud rate constant.
>> >>
>> >> As a result, if you change the clock while the UART is in the middle of
>> >> transmitting a byte then you get corruption.  There's a signal that says "the
>> >> UART TX queue is empty" that can be read from software, but that signal points
>> >> to the TX FIFO and doesn't account for the additional time to stream out the
>> >> contents of the shift register.  There are configurations of the baud rate, bus
>> >> latency, and clock speeds such that the "TX FIFO empty" poll can make it back
>> >> to the core and the core's write to the clock controller can materialize at
>> >> whatever magic makes the clocks change before the UART has serialized out every
>> >> bit in the shift register, which manifests as corruption.
>> >
>> > I've experienced some broken UART clocking like that in the past.
>> >
>> > That's a good example of why you may need SoC specific (or integration
>> > specific) compatible strings. A future design could clock the FIFO
>> > with a different clock that is fixed freq. A driver would distinguish
>> > this quirk with different compatible strings.
>>
>> Ah, OK -- this has me a bit worried that I really fundamentally understand
>> what's going on here.  In my model, if you have a UART that's missing the
>> "actually done" signal then it's the same UART regardless of whether it's
>> driver by a fixed or variable clock.  It's up to Linux to determine that this
>> configuration doesn't require draining queues on clock changes (kind of an
>> awkward example, as fixed clocks can't change), which we allow it to do by
>> associating a clock with each UART.  This allows the UART driver to see the rest
>> of the system, but in a manner rooted at the UART device as that's the part
>> most likely to be relevant to the UART driver.
>>
>> If the model is meant to be that "UART attached to a fixed clock" is different
>> then "UART attached to a variable clock", then we must tag each device with the
>> chip's fill name -- that's the only way to uniquely identify how the UART
>> behaves in the context of the entire system.
>
> Certainly you can do it either way in this example. I think it is
> simpler for the driver to just be told one way or the other rather
> than have to figure out details of the clock tree.
>
>> My one worry is that there will be a lot of these.  I'm not even privy to any
>> details about what's going on in RISC-V hardware land, but I can count a
>> hundred today and they can all use the same driver.  There's then the
>> additional headache that we'll never be able to publicly disclose most of these
>> designs, which leaves all of those having unspecified behavior.
>>
>> >> With the current UART hardware, which has a tentative compat string of
>> >> "sifive,uart0", we need to determine that the shift registers has drained in an
>> >> open-loop manner (ie, just wait for a bit).  This is ugly.  I'd like to spin a
>> >> minor version of the UART that just has an extra control bit made available to
>> >> software that tracks when the shift register drains, but since the drivers for
>> >> the old version would be compatible it seems like calling that "sifive,uart1"
>> >> is too big of a version jump.  Of course the Linux OF infrastructure assigns no
>> >> semantic meaning to compat strings so it doesn't matter here, but we use device
>> >> trees all over the place
>> >>
>> >> Thus, I thought that if we were going to change the naming scheme that we might
>> >> as well go put in a minor version number just to be safe.  Sorry if that's a
>> >> bit too much info... :)
>> >>
>> >> Of course, this is all open source RTL so you can just see what's going on
>> >> here in the PLIC
>> >>
>> >>     https://github.com/freechipsproject/rocket-chip/blob/384096a6a73f0e94d6f7bd4bc9cc422e0a213e88/src/main/scala/devices/tilelink/Plic.scala#L69
>> >>
>> >> and in the UART
>> >>
>> >>     https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L91
>> >>
>> >> We'll change the name generated by the hardware to match whatever's decided on
>> >> here, so there won't be a rift between the hardware and the software.
>> >
>> > What exactly gets generated by the hardware?
>>
>> Sorry, by "generated by the hardware" I really meant "generated along with the
>> hardware".  Essentially what happens is that whatever system collects the RTL
>> blocks to be emitted also collects the device tree nodes to be emitted, thus
>> ensuring they always match.  This is the ground truth for our device trees, and
>> it's how we ensure the device tree always matches the RTL.  Whatever compatible
>> string we agree on for the bindings will be reflected in this system, so the
>> ground truth always matches the spec.
>>
>> There's nothing we can do about what's already been shipped (ie, pre-spec
>> hardware), and ensuring that RTL modifications that change software
>> compatibility cause a change to the device tree node's compat string is
>> something we at SiFive enforce by code review.
>>
>> >> This actually brings up an issue with the standard naming scheme, which in this
>> >> cause would be something like "sifive,u540-c000-plic": the RTL is open source,
>> >> so anyone can go build a chip with it at any time.  I've been operating under
>> >> the impression that it will be impossible to maintain a central database of all
>> >> implementations, so the fallback name will be the defacto name that becomes the
>> >> interface.
>> >>
>> >> I'd be happy to put a "sifive,u540-c000-plic" in there (I'd called in
>> >> "sifive,u540-c000,plic" before, but that's just me not knowing the standard
>> >> naming scheme) just to make sure we have a specific name.  We at SiFive can
>> >> make sure we provide sane unique names for all our implementations, but I think
>> >> we also really need to hammer out what the general compat string is because I
>> >> don't think we can rely one everyone to do that.
>> >
>> > Propose something. If compatible strings can be traced back to exactly
>> > what versions of IP are used and there's a well defined process for
>> > setting version numbers, then I'm fine with using version numbers in
>> > compatible strings. Having version registers are helpful in that
>> > regard. And if there are configuration options in the IP, registers to
>> > read those too.
>> >
>> > Presumably folks (including SiFive?) fork and modify the opensource
>> > IP? Along the same lines as no one ships mainline kernels. Not sure
>> > how you deal with that if you only use versions.
>>
>> We (and as far as I know, other vendors -- though I know little about anyone
>> else' flow) ship RTL from the upstream blocks.  The blocks tend to just become
>> stable enough that the only changes are bug fixes anyway, and as we approach
>> tape out there are very few bugs.
>>
>> The trend towards stability is particularly true of blocks like the PLIC that
>> have been taped out multiple times, where pretty much all that changes is the
>> interface to the generator.  There's a bunch of top-level stuff that's done out
>> of tree, and we add our own special blocks in, but for the leaf blocks we
>> generally match upstream closely.
>>
>> Or at least that's what it looks like to me -- I don't do ECOs here, so maybe
>> I'm just in the dark :)
>
> Okay, that's good to know. I guess there's at least some motivation to
> not touch and break things you're going to set in stone (or Si
> really).
>
> [...]
>
>> >> > There are no "Linux device tree bindings". There are DT bindings that
>> >> > happen to be hosting within the Linux tree for convenience.
>> >>
>> >> Ah, OK.  By "Linux device tree bindings" I meant the ones stored in
>> >> Documentation, which is what we considered the authoritative source and were
>> >> planning on adopting everywhere we use device tree (ie, fixing the rest of our
>> >> code as a result of the discussions we have submitting the bindings).  I'd
>> >> heard some people refer to these as Linux specific, but I'm glad they're not as
>> >> it means we won't be pushing upstream on getting everyone to agree on one set
>> >> of bindings.
>> >>
>> >> Does this mean I can submit bindings for devices that don't have a Linux
>> >> driver?
>> >
>> > Certainly. ARM Mali GPU bindings don't have an (upstream) driver.
>> >
>> > My main concern is if there is neither a driver nor a dts using a
>> > binding, how do we know if it is used or not at some time in the
>> > future.
>>
>> Well, I guess my argument would be: why does this matter?  If it's in the spec
>> then it's in the spec, and we're not breaking anything that's compatible so we
>> can't change it.
>
> It is not always crystal clear what's valid or not in bindings and
> having an actual dts or client implementation can help. Or there's
> been times we've wanted to make incompatible changes (yes, it happens.
> :)) and looking at dts files and drivers is an indication whether or
> not we can get away with changes (it's only an incompatible change if
> someone notices).
>
> With anything, there's maintenance and refactorings that happen from
> time to time. For example, I'm working on moving DT bindings to
> json-schema[1]. It's easier if there aren't obsolete things we're
> carrying.

Make sense -- I'll just try to make sure we avoid doing anything stupid here so 
it's not a headache :)
