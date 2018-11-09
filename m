Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB1C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31CE2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31CE2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeKINhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:37:08 -0500
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:26264 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKINhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:37:07 -0500
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wA93tWJM017440;
        Fri, 9 Nov 2018 05:55:34 +0200 (EET)
X-AuditID: 8b5b9d4d-91bff70000000e62-d6-5be505334562
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id 16.2C.03682.33505EB5; Fri,  9 Nov 2018 05:55:31 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wA93tTQB018040;
        Fri, 9 Nov 2018 05:55:29 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 09 Nov 2018 05:55:29 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, alankao@andestech.com, zong@andestech.com,
        anup@brainfault.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Organization: FORTH
In-Reply-To: <20181108155404.32ja7bbxu62nyytt@lakrids.cambridge.arm.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
 <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
 <20181106162051.w7fyweuxrl7ujzuz@lakrids.cambridge.arm.com>
 <abcae019e6ae749b17ecb0c721fd3177@mailhost.ics.forth.gr>
 <20181107120645.sc3wjgr2yakvxktl@lakrids.cambridge.arm.com>
 <b3a38a178699278c09a9c9ce6421ddd8@mailhost.ics.forth.gr>
 <20181108155404.32ja7bbxu62nyytt@lakrids.cambridge.arm.com>
Message-ID: <0b2ce6ab4fa804e2ce8cea5eca5b02da@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXSHc2orGvC+jTaYO8RJottS1azWrR8eMdq
        sWjFdxaL1vZvTBbzj5xjtTg9YRGTxeVdc9gstn1uYbNYev0ik0Xzu3PsFpsnLGC1aN17hN1i
        +akdLBabN01ltni+spfNgd9jz+lZzB5r5q1h9Jj6+wyLx8NNl5g8Nq/Q8ti0qpPN4925c+we
        m5fUe1xqvs7u8XmTnEf7gW6mAO4oLpuU1JzMstQifbsErowf96+yFbyOrjg27zFTA+MBjy5G
        Tg4JAROJ/3uuMHYxcnEICRxmlDjx4Ag7hHOQUWLmvn/MEFWmErP3djKC2LwCghInZz5hAbGZ
        BSwkpl7Zzwhhy0s0b50NVs8ioCpx5sQaNhCbTUBTYv6lg2D1IgLqEj27vrCALGAWmMcscbJv
        JViRsICeRNOGm6wgNr+AsMSnuxfBbE4BD4nN344yQ1w0gUWi9eZ+ZogrXCSmTdvHBnGdisSH
        3w/YQWxRAWWJFyems05gFJqF5NhZSI6dheTYBYzMqxgFEsuM9TKTi/XS8otKMvTSizYxgiNz
        ru8OxnML7A8xCnAwKvHwrmh4Ei3EmlhWXJl7iFGCg1lJhHfTP6AQb0piZVVqUX58UWlOavEh
        RmkOFiVx3sMvwoOEBNITS1KzU1MLUotgskwcnFINjHnNN0ovh0cX6IeFZKntr768LOCCQupd
        ja/3TROkHe2m82Txf3n55vrph5KFJ8XyOZ6I/p/a+vgs9+0A4xKThCkzw+apbNlzUuq81OZ6
        QS7puws3VbhJe+31CU/j+7GaY8EDziRRkzVhbwv/bLd15ZrDdvvQv5MLtly4xv8hLsNF7vpF
        4aV7apVYijMSDbWYi4oTATV1jbXIAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2018-11-08 17:54, Mark Rutland έγραψε:
> On Thu, Nov 08, 2018 at 03:45:36PM +0200, Nick Kossifidis wrote:
>> Στις 2018-11-07 14:06, Mark Rutland έγραψε:
>> > On Wed, Nov 07, 2018 at 04:31:34AM +0200, Nick Kossifidis wrote:
>> > > Mark and Sundeep thanks a lot for your feedback, I guess you convinced
>> > > me that having a device tree binding for the scheduler is not a
>> > > correct approach. It's not a device after all and I agree that the
>> > > device tree shouldn't become an OS configuration file.
>> >
>> > Good to hear.
>> >
>> > > Regarding multiple levels of shared resources my point is that since
>> > > cpu-map doesn't contain any information of what is shared among the
>> > > cluster/core members it's not easy to do any further translation. Last
>> > > time I checked the arm code that uses cpu-map, it only defines one
>> > > domain for SMT, one for MC and then everything else is ignored. No
>> > > matter how many clusters have been defined, anything above the core
>> > > level is the same (and then I guess you started talking about adding
>> > > "packages" on the representation side).
>> >
>> > While cpu-map doesn't contain that information today, we can *add* that
>> > information to the cpu-map binding if necessary.
>> >
>> > > The reason I proposed to have a binding for the scheduler directly is
>> > > not only because it's simpler and closer to what really happens in the
>> > > code, it also makes more sense to me than the combination of cpu-map
>> > > with all the related mappings e.g.  for numa or caches or power
>> > > domains etc.
>> > >
>> > > However you are right we could definitely augment cpu-map to include
>> > > support for what I'm saying and clean things up, and since you are
>> > > open about improving it here is a proposal that I hope you find
>> > > interesting:
>> > >
>> > > At first let's get rid of the <thread> nodes, they don't make sense:
>> > >
>> > > thread0 {
>> > >  cpu = <&CPU0>;
>> > > };
>> > >
>> > > A thread node can't have more than one cpu entry and any properties
>> > > should be on the cpu node itself, so it doesn't / can't add any
>> > > more information. We could just have an array of cpu nodes on the
>> > > <core> node, it's much cleaner this way.
>> > >
>> > > core0 {
>> > >  members = <&CPU0>, <&CPU1>;
>> > > };
>> >
>> > Hold on. Rather than reinventing things from first principles, can we
>> > please discuss what you want to *achieve*, i.e. what information you
>> > need?
>> >
>> > Having a node is not a significant cost, and there are reasons we may
>> > want thread nodes. For example, it means that we can always refer to any
>> > level of topology with a phandle, and we might want to describe
>> > thread-affine devices in future.
>> 
>> You can use the phandle of the cpu node, the thread node doesn't add
>> anything more than complexity to the representation.
> 
> That adds complexity elsewhere, because the phandle of a CPU node is 
> not
> a child of the cpu-map node, and you can't simply walk up the tree
> hierarchy to find parent nodes.
> 
> I see no reason to change this part of the binding. Given it's already
> out there, with existing parsing code, changing it only serves to add
> complexity to any common code which has to parse this.
> 
> Can we please drop the idea of dropping the thread node?
> 
>> > There are a tonne of existing bindings that are ugly, but re-inventing
>> > them for taste reasons alone is more costly to the ecosystem than simply
>> > using the existing bindings. We avoid re-inventing bindings unless there
>> > is a functional problem e.g. cases which they cannot possibly describe.
>> 
>> We are talking about using something for RISC-V and possibly common 
>> across
>> different archs and, I don't see why we should keep the ugliness of a
>> binding spec plus in this case the <trhead> node can't possibly 
>> describe
>> anything else than a cpu=<node> alias, it's redundant.
> 
> While it may be ugly, removing it only serves to add complexity for
> common parsing code, and removes flexibility that we may want in 
> future.
> Its presence does not cause any technical problem.
> 
> For better or worse we're all sharing the same codebase here. The 
> common
> case matters, as does the complexity of the codebase as a whole.
> 
> I realise it can be frustrating to have to use something you feel is
> sub-optimal, but putting up with a few nodes which you personally feel
> are redundant is of much lower cost to the ecosystem than having
> incompatible bindings where we could have one. If you put up with that,
> you can focus your efforts on more worthwhile technical exercises.
> 

The only reason I mentioned the issue with the <thread> node is because
you said that you are open for improving cpu-map. I don't think it's
such a big deal and even if we decide against it, it's not a big deal
to be backwards compatible with what's already there. I fully understand
what you say about the impact on the ecosystem and agree with you.

>> > > Then let's allow the cluster and core nodes to accept attributes
>> > > that are
>> > > common for the cpus they contain. Right now this is considered
>> > > invalid.
>> > >
>> > > For power domains we have a generic binding described on
>> > > Documentation/devicetree/bindings/power/power_domain.txt
>> > > which basically says that we need to put power-domains = <power domain
>> > > specifiers>
>> > > attribute on each of the cpu nodes.
>> >
>> > FWIW, given this is arguably topological, I'm not personally averse to
>> > describing this in the cpu-map, if that actually gains us more than the
>> > complexity require to support it.
>> >
>> > Given we don't do this for device power domains, I suspect that it's
>> > simpler to stick with the existing binding.
>> >
>> > > The same happens with the capacity binding specified for arm on
>> > > Documentation/devicetree/bindings/arm/cpu-capacity.txt
>> > > which says we should add the capacity-dmips-mhz on each of the cpu
>> > > nodes.
>> >
>> > The cpu-map was intended to expose topological dtails, and this isn't
>> > really a topological property. For example, Arm DynamIQ systems can have
>> > heterogeneous CPUs within clusters.
>> >
>> > I do not think it's worth moving this, tbh.
>> >
>> > > The same also happens with the generic numa binding on
>> > > Documentation/devicetree/bindings/numa.txt
>> > > which says we should add the nuna-node-id on each of the cpu nodes.
>> >
>> > Is there a strong gain from moving this?
>> >
>> > [...]
>> 
>> Right now with the device tree spec and the above bindings we can
>> use the information from cpu nodes to infer the cache topology,
>> the memory topology, the power domain topology etc.
>> 
>> We have of_find_next_cache_node and of_find_last_cache_level for 
>> example
>> that use "next-level-cache" and are used on powerpc (where this spec 
>> comes
>> from), that we can further build on top of them (since this is now 
>> part
>> of the  device tree spec anyway), to e.g. populate the levels of 
>> cache,
>> the levels of shared cache and finally create cpu masks for the 
>> different
>> cache sharing levels.
> 
> The cpu-map binding does not describe cache topology. I never suggested
> that it did.
> 

Sorry for the misunderstanding Mark !

On ARM the CPU topology is used for configuring the scheduling domain 
topology
(arch/arm/kernel/topology.c) and blindly sets the SD_SHARE_PKG_RESOURCES
and SD_SHARE_POWERDOMAIN flags for a core without taking into account 
the
cache hierarchy (hence validating that SD_SHARE_PKG_RESOURCES is 
correct)
or the power domains (but ok, I doubt it's possible to have two threads 
on
the same core that are powered independently). It also supports only two
scheduling domains, one for SMT and another one for MC (hence my 
comments
on multiple levels of shared resources not being supported).

Since according to the docs cpu-map is a binding common between ARM and 
ARM64
for describing the CPU topology, I assumed it was a part of that 
process.

Turns out it's only used on ARM64, where set_sched_topology() is not 
used for
configuring the scheduling domain topology (there is a commend there 
that
implies that you pass on the clusters to the scheduler that also led me 
to
believe the issue is also present there). So my assumption was wrong and
cpu-map has nothing to do with configuring the scheduler and the issues
I mentioned above.

>> This is standards-compliant, arch-independent (they are on of/base.c), 
>> and
>> it provides a concrete hint on CPU topology rather grouping harts to 
>> classes
>> like "core", "package", "socket", "cluster" etc that don't mean 
>> anything
>> specific and we assume to map to specific levels of cache sharing.
> 
> Please note that I have never suggested "package", and I'm not sure 
> what
> that's in response to.
> 

https://lkml.org/lkml/2018/11/7/918

[...]

>> In a sense it goes against your rule of "re-inventing them for taste
>> reasons alone is more costly to the ecosystem than simply using the
>> existing bindings", I fail to see anything else than "taste reasons"
>> when it comes to cpu-map, since there are existing bindings for
>> inferring the CPU topology already, they are just not that convenient.
> 
> If you believe that's the case, then you can perfectly use the existing
> cache and NUMA bindings, and not describe the cpu topology at all, no
> need to change cpu-map or come up with a new binding.
> 

The problem is that right now nobody is using the generic bindings
for configuring the scheduler domain topology. Only the numa bindings
are used as expected on ARM64. Since cpu-map is only there for 
representing
the cpu topology/layout, allowing them to exist there is obviously not 
the
right approach.

>> I'm proposing to add the option (not enforce) of adding those
>> attributes that are meant to be used on cpu nodes, on the various
>> groups/classes of the cpu-map, this way cpu-map will provide something
>> more meaningful and at least improve the representation side of
>> things. On the implementation side it might save us the burden of
>> infering the topology from parsing all cpu nodes each time. It's also
>> backwards compatible with what you already have, the only thing that's
>> not backwards compatible is the removal of the <thread> node, which I
>> don't think is such a big deal to fix.
> 
> Sorry, but as I have stated repeatedly, this complicates the common 
> code
> for what you admit is a matter of taste. I would rather maintain the
> simplicity of this binding and existing parsing code, and not
> potentially break other parsers, if the only cost is a few nodes which
> you personally consider to be redundant.
> 

[...]

>> So we agree, the "core" doesn't say anything useful regarding the
>> topology, why keep using this distinction on a binding for RISC-V and
>> possibly other archs (since we are also talking on an arch-independent
>> approach) ?
> 
> We keep it because the binding has already been finalised and is use in
> practice. The existing binding and parsing code is *sufficient* for 
> your
> needs. Personal taste and minor savings in the number of nodes in a DT
> are not compelling reasons to change this when the cost is complexity
> that we have to maintain *forever*.
> 

Totally fine with that, as I mentioned above I pointed these out since I
consider it an improvement. Forgive me if I gave you the impression that
was a deal-breaker or something.

Regards,
Nick
