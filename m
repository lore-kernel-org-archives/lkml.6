Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0521C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A1E2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A1E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbeKFVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:02:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59510 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbeKFVCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:02:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82838A78;
        Tue,  6 Nov 2018 03:37:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CEAA3F5CF;
        Tue,  6 Nov 2018 03:37:26 -0800 (PST)
Date:   Tue, 6 Nov 2018 11:37:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Palmer Dabbelt <palmer@sifive.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Damien.LeMoal@wdc.com,
        alankao@andestech.com, zong@andestech.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, atish.patra@wdc.com,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
Message-ID: <20181106113723.j5k5f7ovehiupyid@lakrids.cambridge.arm.com>
References: <mhng-799bd6f4-e4af-481e-90d8-bdc0e30f2530@palmer-si-x1c4>
 <9e77989d6b868d914bc328401cd64557@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e77989d6b868d914bc328401cd64557@mailhost.ics.forth.gr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 12:03:17PM +0200, Nick Kossifidis wrote:
> Στις 2018-11-05 21:38, Palmer Dabbelt έγραψε:
> > On Fri, 02 Nov 2018 06:09:39 PDT (-0700), robh+dt@kernel.org wrote:
> > > On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com>
> > > wrote:
> > > > 
> > > > Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
> > > > But it doesn't need a separate thread node for defining SMT systems.
> > > > Multiple cpu phandle properties can be parsed to identify the sibling
> > > > hardware threads. Moreover, we do not have cluster concept in RISC-V.
> > > > So package is a better word choice than cluster for RISC-V.
> > > 
> > > There was a proposal to add package info for ARM recently. Not sure
> > > what happened to that, but we don't need 2 different ways.
> > > 
> > > There's never going to be clusters for RISC-V? What prevents that?
> > > Seems shortsighted to me.
> > > 
> > > > 
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >  .../devicetree/bindings/riscv/topology.txt         | 154
> > > > +++++++++++++++++++++
> > > >  1 file changed, 154 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/riscv/topology.txt
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/riscv/topology.txt
> > > > b/Documentation/devicetree/bindings/riscv/topology.txt
> > > > new file mode 100644
> > > > index 00000000..96039ed3
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/riscv/topology.txt
> > > > @@ -0,0 +1,154 @@
> > > > +===========================================
> > > > +RISC-V cpu topology binding description
> > > > +===========================================
> > > > +
> > > > +===========================================
> > > > +1 - Introduction
> > > > +===========================================
> > > > +
> > > > +In a RISC-V system, the hierarchy of CPUs can be defined
> > > > through following nodes that
> > > > +are used to describe the layout of physical CPUs in the system:
> > > > +
> > > > +- packages
> > > > +- core
> > > > +
> > > > +The cpu nodes (bindings defined in [1]) represent the devices that
> > > > +correspond to physical CPUs and are to be mapped to the
> > > > hierarchy levels.
> > > > +Simultaneous multi-threading (SMT) systems can also represent
> > > > their topology
> > > > +by defining multiple cpu phandles inside core node. The details
> > > > are explained
> > > > +in paragraph 3.
> > > 
> > > I don't see a reason to do this differently than ARM. That said, I
> > > don't think the thread part is in use on ARM, so it could possibly be
> > > changed.
> > > 
> > > > +
> > > > +The remainder of this document provides the topology bindings
> > > > for ARM, based
> > > 
> > > for ARM?
> > > 
> > > > +on the Devicetree Specification, available from:
> > > > +
> > > > +https://www.devicetree.org/specifications/
> > > > +
> > > > +If not stated otherwise, whenever a reference to a cpu node
> > > > phandle is made its
> > > > +value must point to a cpu node compliant with the cpu node
> > > > bindings as
> > > > +documented in [1].
> > > > +A topology description containing phandles to cpu nodes that
> > > > are not compliant
> > > > +with bindings standardized in [1] is therefore considered invalid.
> > > > +
> > > > +This cpu topology binding description is mostly based on the
> > > > topology defined
> > > > +in ARM [2].
> > > > +===========================================
> > > > +2 - cpu-topology node
> > > 
> > > cpu-map. Why change this?
> > > 
> > > What I would like to see is the ARM topology binding reworked to be
> > > common or some good reasons why it doesn't work for RISC-V as-is.
> > 
> > I think it would be great if CPU topologies were not a RISC-V specific
> > thing.  We don't really do anything different than anyone else, so
> > it'd be great if we could all share the same spec and code.  Looking
> > quickly at the ARM cpu-map bindings, I don't see any reason why we
> > can't just use the same thing on RISC-V -- it's not quite how I'd do
> > it, but I don't think the differences are worth having another
> > implementation.  Mechanically I'm not sure how to do this: should
> > there just be a "Documentation/devicetree/bindings/cpu-map.txt"?
> > 
> > If everyone is OK with that then I vote we just go ahead and
> > genericise the ARM "cpu-map" stuff for CPU topology.  Sharing the
> > implementation looks fairly straight-forward as well.
> > 
> 
> Please check this out...
> https://lkml.org/lkml/2018/11/3/99
> 
> It's also non arch-dependent and it can handle the scheduler's capabilities
> better than cpu-map.

Could you elaborate on what this does better than cpu-map? I'd be
curious to see if we could/should augment cpu-map to cater for those
details.

Generally, we deliberately avoid placing software abstractions in the DT
(e.g. scheduler domains), because the design of these abstractions are
specific to a given software stack rather than the hardware, and even in
the context of that specific software stack these abstractions change
over time.

Placing software abstractions in the DT may seem simpler initially, but
longer term it ends up requiring translation anyway as abstractions
change, and typically it involves placing some policy in the DT, which
restricts the ability of software to do something better.

Having some translation between the DT and the Linux-internal
abstraction is how we expect things to work generally, and allows for a
more natural representation in the DT (which may be more or less
powerful than the current Linux abstraction).

Thanks,
Mark.
