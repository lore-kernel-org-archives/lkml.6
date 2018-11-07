Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2257C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFE920827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFE920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbeKGMCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:02:10 -0500
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:19861 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbeKGMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:02:10 -0500
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wA72VbKa067746;
        Wed, 7 Nov 2018 04:31:39 +0200 (EET)
X-AuditID: 8b5b9d4d-91bff70000000e62-66-5be24e87b883
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id DC.89.03682.78E42EB5; Wed,  7 Nov 2018 04:31:35 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wA72VYBk028294;
        Wed, 7 Nov 2018 04:31:34 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 07 Nov 2018 04:31:34 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, alankao@andestech.com, zong@andestech.com,
        anup@brainfault.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Organization: FORTH
In-Reply-To: <20181106162051.w7fyweuxrl7ujzuz@lakrids.cambridge.arm.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
 <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
 <20181106162051.w7fyweuxrl7ujzuz@lakrids.cambridge.arm.com>
Message-ID: <abcae019e6ae749b17ecb0c721fd3177@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXSHc2orNvh9yjaYM0aSYttS1azWrR8eMdq
        sWjFdxaL1vZvTBbzj5xjtTg9YRGTxeVdc9gstn1uYbNYev0ik0Xzu3PsFpsnLGC1aN17hN1i
        +akdLBabN01ltni+spfNgd9jz+lZzB5r5q1h9Jj6+wyLx8NNl5g8Nq/Q8ti0qpPN4925c+we
        m5fUe1xqvs7u8XmTnEf7gW6mAO4oLpuU1JzMstQifbsEroz1B96wFdyPq9h8dw5zA+Nb9y5G
        Tg4JAROJJU+msncxcnEICRxhlPg68RIbhHOQUWJt00F2iCpTidl7OxlBbF4BQYmTM5+wgNjM
        AhYSU6/sZ4Sw5SWat85mBrFZBFQlFsw/ygpiswloSsy/dBCsXkTAR+LA/P+MIAuYBd4xSexa
        PJUNJCEsoCfRtOEmWAO/gLDEp7sXwWxOAQ+Jw98bWCAumsckcePYZGaIK1wkJvX2sUJcpyLx
        4fcDsEtFBZQlXpyYzjqBUWgWkmNnITl2FpJjFzAyr2IUSCwz1stMLtZLyy8qydBLL9rECI7M
        ub47GM8tsD/EKMDBqMTDe5P9UbQQa2JZcWXuIUYJDmYlEd7Tqx9GC/GmJFZWpRblxxeV5qQW
        H2KU5mBREuc9/CI8SEggPbEkNTs1tSC1CCbLxMEp1cC4e1fChmPPmM6GPEjne/1237F3Cl+n
        zL7//oPpDJfKQA/2mYWspU2RHvLvOGU0TlsxPP6zLsbSI3mXkPP0n5lFhy3zLpV++VgjsMRA
        4KGP8/49z7/MPZVz/u+bqtyL7Sz5PozPK15Eu8yWVJJ+f77Df6um+bUwOUELIaMClY4JEm/m
        BfmdV+lWYinOSDTUYi4qTgQAwX39NsgCAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2018-11-06 18:20, Mark Rutland έγραψε:
> On Tue, Nov 06, 2018 at 05:26:01PM +0200, Nick Kossifidis wrote:
>> Στις 2018-11-06 16:13, Sudeep Holla έγραψε:
>> > On Fri, Nov 02, 2018 at 08:58:39PM +0200, Nick Kossifidis wrote:
>> > > Στις 2018-11-02 01:04, Atish Patra έγραψε:
>> > > > This patch series adds the cpu topology for RISC-V. It contains
>> > > > both the DT binding and actual source code. It has been tested on
>> > > > QEMU & Unleashed board.
>> > > >
>> > > > The idea is based on cpu-map in ARM with changes related to how
>> > > > we define SMT systems. The reason for adopting a similar approach
>> > > > to ARM as I feel it provides a very clear way of defining the
>> > > > topology compared to parsing cache nodes to figure out which cpus
>> > > > share the same package or core.  I am open to any other idea to
>> > > > implement cpu-topology as well.
>> > >
>> > > I was also about to start a discussion about CPU topology on RISC-V
>> > > after the last swtools group meeting. The goal is to provide the
>> > > scheduler with hints on how to distribute tasks more efficiently
>> > > between harts, by populating the scheduling domain topology levels
>> > > (https://elixir.bootlin.com/linux/v4.19/ident/sched_domain_topology_level).
>> > > What we want to do is define cpu groups and assign them to
>> > > scheduling domains with the appropriate SD_ flags
>> > > (https://github.com/torvalds/linux/blob/master/include/linux/sched/topology.h#L16).
>> >
>> > OK are we defining a CPU topology binding for Linux scheduler ?
>> > NACK for all the approaches that assumes any knowledge of OS scheduler.
>> 
>> Is there any standard regarding CPU topology on the device tree spec ?
>> As far as I know there is none. We are talking about a Linux-specific
>> Device Tree binding so I don't see why defining a binding for the
>> Linux scheduler is out of scope.
> 
> Speaking as a DT binding maintainer, please avoid OS-specific DT
> bindings wherever possible.
> 
> While DT bindings live in the kernel tree, they are not intended to be
> Linux-specific, and other OSs (e.g. FreeBSD, zephyr) are aiming to
> support the same bindings.
> 
> In general, targeting a specific OS is a bad idea, because the
> implementation details of that OS change over time, or the bindings end
> up being tailored to one specific use-case. Exposing details to the OS
> such that the OS can make decisions at runtime is typically better.
> 
>> Do you have cpu-map on other OSes as well ?
> 
> There is nothing OS-specific about cpu-map, and it may be of use to
> other OSs.
> 
>> > > So the cores that belong to a scheduling domain may share:
>> > > CPU capacity (SD_SHARE_CPUCAPACITY / SD_ASYM_CPUCAPACITY)
>> > > Package resources -e.g. caches, units etc- (SD_SHARE_PKG_RESOURCES)
>> > > Power domain (SD_SHARE_POWERDOMAIN)
>> > >
>> >
>> > Too Linux kernel/scheduler specific to be part of $subject
>> 
>> All lists on the cc list are Linux specific, again I don't see your
>> point here are we talking about defining a standard CPU topology
>> scheme for the device tree spec or a Linux-specific CPU topology
>> binding such as cpu-map ?
> 
> The cpu-map binding is not intended to be Linux specific, and avoids
> Linux-specific terminology.
> 
> While the cpu-map binding documentation is in the Linux source tree, 
> the
> binding itseld is not intended to be Linux-specific, and it 
> deliberately
> avoids Linux implementation details.
> 
>> Even on this case your point is not valid, the information of two
>> harts sharing a common power domain or having the same or not
>> capacity/max frequency (or maybe capabilities/extensions in the
>> future), is not Linux specific. I just used the Linux specific macros
>> used by the Linux scheduler to point out the code path.  Even on other
>> OSes we still need a way to include this information on the CPU
>> topology, and currently cpu-map doesn't. Also the Linux implementation
>> of cpu-map ignores multiple levels of shared resources, we only get
>> one level for SMT and one level for MC last time I checked.
> 
> Given clusters can be nested, as in the very first example, I don't see
> what prevents multiple levels of shared resources.
> 
> Can you please given an example of the topology your considering? Does
> that share some resources across clusters at some level?
> 
> We are certainly open to improving the cpu-map binding.
> 
> Thanks,
> Mark.

Mark and Sundeep thanks a lot for your feedback, I guess you convinced 
me
that having a device tree binding for the scheduler is not a correct 
approach.
It's not a device after all and I agree that the device tree shouldn't 
become
an OS configuration file. Regarding multiple levels of shared resources 
my point
is that since cpu-map doesn't contain any information of what is shared 
among
the cluster/core members it's not easy to do any further translation. 
Last time
I checked the arm code that uses cpu-map, it only defines one domain for 
SMT, one
for MC and then everything else is ignored. No matter how many clusters 
have been
defined, anything above the core level is the same (and then I guess you 
started
talking about adding "packages" on the representation side).

The reason I proposed to have a binding for the scheduler directly is 
not only
because it's simpler and closer to what really happens in the code, it 
also makes
more sense to me than the combination of cpu-map with all the related 
mappings e.g.
for numa or caches or power domains etc.

However you are right we could definitely augment cpu-map to include 
support for
what I'm saying and clean things up, and since you are open about 
improving it
here is a proposal that I hope you find interesting:

At first let's get rid of the <thread> nodes, they don't make sense:

thread0 {
  cpu = <&CPU0>;
};

A thread node can't have more than one cpu entry and any properties
should be on the cpu node itself, so it doesn't / can't add any
more information. We could just have an array of cpu nodes on the
<core> node, it's much cleaner this way.

core0 {
  members = <&CPU0>, <&CPU1>;
};

Then let's allow the cluster and core nodes to accept attributes that 
are
common for the cpus they contain. Right now this is considered invalid.

For power domains we have a generic binding described on
Documentation/devicetree/bindings/power/power_domain.txt
which basically says that we need to put power-domains = <power domain 
specifiers>
attribute on each of the cpu nodes.

The same happens with the capacity binding specified for arm on
Documentation/devicetree/bindings/arm/cpu-capacity.txt
which says we should add the capacity-dmips-mhz on each of the cpu 
nodes.

The same also happens with the generic numa binding on
Documentation/devicetree/bindings/numa.txt
which says we should add the nuna-node-id on each of the cpu nodes.

We could allow for these attributes to exist on cluster and core nodes
as well so that we can represent their properties better. It shouldn't
be a big deal and it can be done in a backwards-compatible way (if we
don't find them on the cpu node, climb up the topology hierarchy until
we find them / not find them at all). All I'm saying is that I prefer 
this:

cpus {
  cpu@0 {
   ...
  };
  cpu@1 {
   ...
  };
  cpu@2 {
   ...
  };
  cpu@3 {
   ...
  };
};


cluster0 {
  cluster0 {
   core0 {
    power-domains = <&pdc 0>;
    numa-node-id = <0>;
    capacity-dmips-mhz = <578>;
    members = <&cpu0>, <&cpu1>;
   }
  };
  cluster1 {
   capacity-dmips-mhz = <1024>;
   core0 {
    power-domains = <&pdc 1>;
    numa-node-id = <1>;
    members = <&cpu2>;
   };
   core1 {
    power-domains = <&pdc 2>;
    numa-node-id = <2>;
    members = <&cpu3>;
   };
  };
}

over this:

cpus {
  cpu@0 {
   ...
   power-domains = <&pdc 0>;
   capacity-dmips-mhz = <578>;
   numa-node-id = <0>;
   ...
  };
  cpu@1 {
   ...
   power-domains = <&pdc 0>;
   capacity-dmips-mhz = <578>;
   numa-node-id = <0>;
   ...
  };
  cpu@2 {
   ...
   power-domains = <&pdc 1>;
   capacity-dmips-mhz = <1024>;
   numa-node-id = <1>;
   ...
  };
  cpu@3 {
   ...
   power-domains = <&pdc 2>;
   capacity-dmips-mhz = <1024>;
   numa-node-id = <2>;
   ...
  };
};


cluster0 {
  cluster0 {
   core0 {
    members = <&cpu0>, <&cpu1>;
   }
  };
  cluster1 {
   core0 {
    members = <&cpu2>;
   }
  };
  cluster2 {
   core0 {
    members = <&cpu3>;
   }
  };
}


When it comes to shared resources, the standard dt mappings we have are 
for
caches and are on the device spec standard (coming from power pc's ePAPR
standard I think). The below comes from HiFive unleashed's device tree
(U540Config.dts) that follows the spec:

cpus {
  cpu@1 {
   ...
   next-level-cache = <&L24 &L0>;
   ...
  };
  cpu@2 {
   ...
   next-level-cache = <&L24 &L0>;
   ...
  };
  cpu@3 {
   ...
   next-level-cache = <&L24 &L0>;
   ...
  };
  cpu@4 {
   ...
   next-level-cache = <&L24 &L0>;
   ...
  };
};

L2: soc {
  L0: cache-controller@2010000 {
   cache-block-size = <64>;
   cache-level = <2>;
   cache-sets = <2048>;
   cache-size = <2097152>;
   cache-unified;
   compatible = "sifive,ccache0", "cache";
   ...
  };
}

Note that the cache-controller node that's common between the 4 cores 
can
exist anywhere BUT the cluster node ! However it's a property of the 
cluster.
A quick search through the tree got me r8a77980.dtsi that defines the 
cache
on the cpus node and I'm sure there are other similar cases. Wouldn't 
this
be better ?

cluster0 {
  core0 {
   cache-controller@2010000 {
    cache-block-size = <64>;
    cache-level = <2>;
    cache-sets = <2048>;
    cache-size = <2097152>;
    cache-unified;
    compatible = "sifive,ccache0", "cache";
    ...
   };
   members = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
  };
};

We could even remove next-level-cache from the cpu nodes and infer it 
from the
topology (search the topology upwards until we get a node that's
"cache"-compatible), we can again make this backwards-compatible.


Finally from the examples above I'd like to stress out that the 
distinction
between a cluster and a core doesn't make much sense and it also makes 
the
representation more complicated. To begin with, how would you call the 
setup
on HiFive Unleashed ? A cluster of 4 cores that share the same L3 cache 
?
One core with 4 harts that share the same L3 cache ? We could represent 
it
like this instead:

cluster0 {
  cache-controller@2010000 {
   cache-block-size = <64>;
   cache-level = <2>;
   cache-sets = <2048>;
   cache-size = <2097152>;
   cache-unified;
   compatible = "sifive,ccache0", "cache";
   ...
  };
  core0 {
   members = <&cpu0>;
  };
  core1 {
   members = <&cpu1>;
  };
  core2 {
   members = <&cpu2>;
  };
  core3 {
   members = <&cpu3>;
  };
};

We could e.g. keep only cluster nodes and allow them to contain either 
an array
of harts or other cluster sub-nodes + optionally a set of attributes, 
common to
the members/sub-nodes of the cluster. This way we'll get in the first 
example:

cluster0 {
  cluster0 {
   power-domains = <&pdc 0>;
   numa-node-id = <0>;
   capacity-dmips-mhz = <578>;
   members = <&cpu0>, <&cpu1>;
  };
  cluster1 {
   capacity-dmips-mhz = <1024>;
   cluster0 {
    power-domains = <&pdc 1>;
    numa-node-id = <1>;
    members = <&cpu2>;
   };
   cluster1 {
    power-domains = <&pdc 2>;
    numa-node-id = <2>;
    members = <&cpu3>;
   };
  };
}

and in the second example:

cluster0 {
  cache-controller@2010000 {
   cache-block-size = <64>;
   cache-level = <2>;
   cache-sets = <2048>;
   cache-size = <2097152>;
   cache-unified;
   compatible = "sifive,ccache0", "cache";
   ...
  };
  members = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
};


Thank you for your time !

Regards,
Nick
