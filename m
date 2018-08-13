Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83DFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E51E21709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGCgqwkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E51E21709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeHMQwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeHMQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:52:38 -0400
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF01621782;
        Mon, 13 Aug 2018 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534169410;
        bh=fZVdoBukmtAmikGC0Cw/ErWramdv7zFTfFk08i6krQA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QGCgqwkMpkFgKhkfuhN/Qfdtr17B2V6mR37il4iT0acymUDYFdVHXxB8AY8BjZxu0
         k5DoaAGoO8lJlT+U0cvz/tKbB2DUb9aat5+aZ8IDaMxHZ6vshYBGmmdZhcweQG9hnM
         6g9pwFRFd/4x43kOTPat9ikFUouVVhTqzdLrYZpQ=
Received: by mail-qt0-f173.google.com with SMTP id t5-v6so17483543qtn.3;
        Mon, 13 Aug 2018 07:10:10 -0700 (PDT)
X-Gm-Message-State: AOUpUlGnNz37UxD6Ci1EOCoAUbUHFDLHn3HL+st3qdHdRbQl20/j75tE
        dIP3+pNqO79Orzbw+wgZuAdBrsPGWsDGx9s/Xg==
X-Google-Smtp-Source: AA+uWPzL5VgQ51N4+DXQhsPenrtKXaZ8tsEZFAz06kzvnYsnJBmfP0yONpEYepNyI+9KbWC8Pki7GUo+HErFVL0GKug=
X-Received: by 2002:ac8:96b:: with SMTP id z40-v6mr17009831qth.362.1534169409773;
 Mon, 13 Aug 2018 07:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqLpM=UG_9aL8CquhP8SajVav5in7RJRDk9tDd=QrTdVFw@mail.gmail.com>
 <mhng-d9abab59-2b3e-48a7-a28f-84f820964baa@palmer-si-x1c4>
In-Reply-To: <mhng-d9abab59-2b3e-48a7-a28f-84f820964baa@palmer-si-x1c4>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Aug 2018 08:09:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJAguba1YVQUzXRGL2zkPm2dTib5p=gMq6Ea3jpH6RaQ@mail.gmail.com>
Message-ID: <CAL_JsqKJAguba1YVQUzXRGL2zkPm2dTib5p=gMq6Ea3jpH6RaQ@mail.gmail.com>
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

On Fri, Aug 10, 2018 at 2:09 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 10 Aug 2018 09:57:03 PDT (-0700), robh+dt@kernel.org wrote:
> > On Thu, Aug 9, 2018 at 12:29 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> On Wed, 08 Aug 2018 16:32:07 PDT (-0700), robh+dt@kernel.org wrote:
> >> > On Wed, Aug 8, 2018 at 1:38 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >> >>
> >> >> On Wed, 08 Aug 2018 07:16:14 PDT (-0700), robh+dt@kernel.org wrote:
> >> >> > On Tue, Aug 7, 2018 at 8:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >> >> >>
> >> >> >> On Mon, 06 Aug 2018 13:59:48 PDT (-0700), robh+dt@kernel.org wrote:
> >> >> >> > On Thu, Aug 2, 2018 at 4:08 PM Atish Patra <atish.patra@wdc.com> wrote:
> >> >> >> >>
> >> >> >> >> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
> >> >> >> >> > From: Palmer Dabbelt <palmer@dabbelt.com>
> >> >> >> >> >
> >> >> >> >> > This patch adds documentation for the platform-level interrupt
> >> >> >> >> > controller (PLIC) found in all RISC-V systems.  This interrupt
> >> >> >> >> > controller routes interrupts from all the devices in the system to each
> >> >> >> >> > hart-local interrupt controller.
> >> >> >> >> >
> >> >> >> >> > Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
> >> >> >> >> > want to change how we're specifying holes in the hart list.
> >> >> >> >> >
> >> >> >> >> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> >> >> >> >> > [hch: various fixes and updates]
> >> >> >> >> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> >> >> >> > ---
> >> >> >> >> >   .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
> >> >> >> >> >   1 file changed, 57 insertions(+)
> >> >> >> >> >   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> >> >> >> >> >
> >> >> >> >> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> >> >> >> >> > new file mode 100644
> >> >> >> >> > index 000000000000..c756cd208a93
> >> >> >> >> > --- /dev/null
> >> >> >> >> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> >> >> >> >> > @@ -0,0 +1,57 @@
> >> >> >> >> > +SiFive Platform-Level Interrupt Controller (PLIC)
> >> >> >> >> > +-------------------------------------------------
> >> >> >> >> > +
> >> >> >> >> > +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
> >> >> >> >> > +(PLIC) high-level specification in the RISC-V Privileged Architecture
> >> >> >> >> > +specification.  The PLIC connects all external interrupts in the system to all
> >> >> >> >> > +hart contexts in the system, via the external interrupt source in each hart.
> >> >> >> >> > +
> >> >> >> >> > +A hart context is a privilege mode in a hardware execution thread.  For example,
> >> >> >> >> > +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
> >> >> >> >> > +privilege modes per hart; machine mode and supervisor mode.
> >> >> >> >> > +
> >> >> >> >> > +Each interrupt can be enabled on per-context basis. Any context can claim
> >> >> >> >> > +a pending enabled interrupt and then release it once it has been handled.
> >> >> >> >> > +
> >> >> >> >> > +Each interrupt has a configurable priority. Higher priority interrupts are
> >> >> >> >> > +serviced first. Each context can specify a priority threshold. Interrupts
> >> >> >> >> > +with priority below this threshold will not cause the PLIC to raise its
> >> >> >> >> > +interrupt line leading to the context.
> >> >> >> >> > +
> >> >> >> >> > +While the PLIC supports both edge-triggered and level-triggered interrupts,
> >> >> >> >> > +interrupt handlers are oblivious to this distinction and therefore it is not
> >> >> >> >> > +specified in the PLIC device-tree binding.
> >> >> >> >> > +
> >> >> >> >> > +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> >> >> >> >> > +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
> >> >> >> >> > +specific memory layout, which is documented in chapter 8 of the SiFive U5
> >> >> >> >> > +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> >> >> >> >> > +
> >> >> >> >> > +Required properties:
> >> >> >> >> > +- compatible : "sifive,plic0"
> >> >> >>
> >> >> >> I think there was a thread bouncing around somewhere where decided to pick the
> >> >> >> official name of the compatible string to be "sifive,plic-1.0".  The idea here
> >> >> >> is that the PLIC is compatible across all of SiFive's current implementations,
> >> >> >> but there's some limitations in the memory map that will probably cause us to
> >> >> >> spin a version 2 at some point so we want major version number.  The minor
> >> >> >> number is just in case we find some errata in the PLIC.
> >> >> >
> >> >> > Is 1.0 an actual version number corresponding to an exact, revision
> >> >> > controlled version of the IP or just something you made up? Looks like
> >> >> > the latter to me and I'm not a fan of s/w folks making up version
> >> >> > numbers for h/w. Standard naming convention is <vendor>,<soc>-<block>
> >> >> > unless you have good reason to deviate (IP for FPGAs where version
> >> >> > numbers are exposed to customers is one example).
> >> >>
> >> >> The hardware versioning scheme calls it "riscv,plic0", which is what we were
> >> >> originally using.  This PLIC isn't actually defined as a RISC-V spec, so we
> >> >> wanted to change it to a "sifive,*" name instead.  Since we were going to
> >> >> change the compat string anyway, I thought we'd just introduce a minor number
> >> >> to be safe.  Since "0.0" is an awkward number, I figured "1.0" would be saner.
> >> >
> >> > So I guess to answer my question, you are just making up version
> >> > numbers. Unless you are doing the IP verilog too, don't do that.
> >>
> >> Well, in this case my proposal would be that we change the hardware team's
> >> versioning scheme to match whatever we decide on the versioning scheme should
> >> be as a part of this discussion.  I proposed accepting whatever versioning
> >> scheme is decided upon hereto the hardware team before discussing changing the
> >> naming scheme and they agreed to do so.
> >>
> >> So we're really in the drivers' seat here.
> >
> > Okay. So you could have something like x.y.z versioning where a change
> > in X is change in register layout and/or major functional change, Y is
> > backwards compatible changes (i.e. superset of functionality), Z is
> > not s/w visible changes (though trusting that Z changes are really not
> > s/w visible makes me nervous). If you have a version register, then
> > the compatible string only needs to be specific enough to read that
> > register.
> >
> > And if I can have anything I ask for, then any configuration option
> > needs to be s/w readable too. Things like FIFO sizes, number of
> > channels, etc. Sometimes these are DT properties, but generally the
> > preference is to make these implied by the compatible. There's no set
> > rule though. The problem with properties is they work well if you know
> > up front to have them, but often something is fixed and implied and
> > then becomes variable when a new version of the block is created.
> >
> > Think of it this way, DT is a work-around for non-discoverable h/w.
> > The best solution is making the h/w more discoverable. If you look at
> > the ARM Primecell aka amba_bus drivers, we don't actually match on the
> > device compatible string (e.g. arm,pl011). Only "arm,primecell" is
> > used and then we match with standard ID registers from there. We only
> > need DT to discover where those blocks are, not what they are or what
> > version they are (and of course other things like clocks, regulators,
> > etc.).
>
> Ya, good, that's generally been my model for it.  In the PLIC there isn't a
> whole lot in terms of configuration options to probe dynamically, as the
> register layout is fixed (determined by the device tree compat string) and the
> interrupt routings are fixed (determined by interrupt-parent and reg).  There's
> some amount of scheme for probing these, but since the routings aren't
> discoverable without the device tree they're not really useful in practice.
>
> Our more modern blocks are becoming larger in scope, and these tend to have
> their options determined by software.  For example, SiFive's CLIC proposal (a
> proposal for a new RISC-V core-local interrupt controller) has many runtime
> discoverable properties, with pretty much only the base address being specified
> in the device tree -- here's an example of a binding
>
>                 L1: interrupt-controller@2000000 {
>                         compatible = "riscv,clic0";
>                         interrupts-extended = <&L2 3 &L2 7 &L2 11>;
>                         reg = <0x2000000 0x1000000>;
>                         reg-names = "control";
>                 };
>
> I don't want to go too far down the CLIC path, though, as there's still a lot
> of work to be done there :)
>
> > So what your compatible string(s) need to look like depend on all the
> > above. It can be very generic if you can identify the block, version,
> > and capabilities in a standard way.
>
> For now I think the best bet is to go with "sifive,plic-1.0.0" as well as
> "sifive,fu540-c000-plic".  That way we've got plenty of room to avoid painting
> ourselves into a corner later.  In the interest of getting people a system they
> can start testing, I'm going to go ahead and bring the PLIC driver into my
> for-next branch with the "sifive,plic-1.0.0" binding.  I don't want to just
> unilaterally kill the discussion, but I figure we can always submit a fixup
> driver patch later if I'm wrong and we're not on the same page now.

Okay.

> I've also gone ahead and opened a PR against the RTL generator, but I'll wait
> on the bindings to be officially accepted before merging that:
>
>     https://github.com/freechipsproject/rocket-chip/pull/1575
>
> I'm assuming the bindings will go in through your tree?

No, they generally go thru the arch or subsystem trees with the code
that uses them (unless there isn't any and I'll take them).

Rob
