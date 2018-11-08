Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6209FECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101232081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101232081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeKIAac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:30:32 -0500
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:20793 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKIAac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:30:32 -0500
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wA8EqX7T005288;
        Thu, 8 Nov 2018 16:52:35 +0200 (EET)
X-AuditID: 8b5b9d4d-903ff70000000e62-d1-5be44db052f8
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id E1.DB.03682.0BD44EB5; Thu,  8 Nov 2018 16:52:32 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wA8EqUhc031162;
        Thu, 8 Nov 2018 16:52:30 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 08 Nov 2018 16:52:30 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Mark Rutland <mark.rutland@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, alankao@andestech.com, zong@andestech.com,
        anup@brainfault.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Organization: FORTH
In-Reply-To: <20181107122803.GA8433@e107155-lin>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
 <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
 <20181106162051.w7fyweuxrl7ujzuz@lakrids.cambridge.arm.com>
 <abcae019e6ae749b17ecb0c721fd3177@mailhost.ics.forth.gr>
 <20181107122803.GA8433@e107155-lin>
Message-ID: <d04779705c47b59b94300365e805dbd3@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsXSHc2orLvR90m0wfFrbBbblqxmtWj58I7V
        YtGK7ywWre3fmCzmHznHanF6wiImi8u75gCVfG5hs1h6/SKTRfO7c+wWmycsYLVo3XuE3WL5
        qR0sFps3TWW2eL6yl82B32PP6VnMHmvmrWH0mPr7DIvHw02XmDw2r9Dy2LSqk83j3blz7B6b
        l9R7XGq+zu7xeZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujOsbjzIWHE6umHyitIFxj28XIyeH
        hICJxKL7z1i7GLk4hAQOM0qcWLiUEcI5yCjx4+0NRogqU4nZezvBbF4BQYmTM5+wgNjMAhYS
        U6/sZ4Sw5SWat85mBrFZBFQlHjb1sYHYbAKaEvMvHQSrFxFQl1hydgvYAmaBecwS0/dsYQVJ
        CAvoSTRtuAlm8wsIS3y6exHM5hQwkNjUMZ8Z4qL/TBIN57ayQ1zhInFr9gk2iOtUJD78fgAW
        FxVQlnhxYjrrBEahWUiOnYXk2FlIjl3AyLyKUSCxzFgvM7lYLy2/qCRDL71oEyM4Luf67mA8
        t8D+EKMAB6MSD6+E4uNoIdbEsuLK3EOMEhzMSiK8m3SeRAvxpiRWVqUW5ccXleakFh9ilOZg
        URLnPfwiPEhIID2xJDU7NbUgtQgmy8TBKdXAuC09rOjfo8Pr9n+TNXQ4+Wiqmvbl/Xs+/62x
        m7rdccKrw1fPxZdKb1/uKeTLIP3lXtLpkz5vD6h0PF5r5mV/6k54nn723zfOvXtWvJNuZVM2
        yV45XbLvrH/f0f59eTtuL1Q7LTL7o1vMeX5x501Nx368s3q04/1Sl4aV2U/uNupNm3DhKN82
        +ZVKLMUZiYZazEXFiQAJJshIxwIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2018-11-07 14:28, Sudeep Holla έγραψε:
> On Wed, Nov 07, 2018 at 04:31:34AM +0200, Nick Kossifidis wrote:
> [...]
> 
>> 
>> Mark and Sudeep thanks a lot for your feedback, I guess you convinced 
>> me
>> that having a device tree binding for the scheduler is not a correct
>> approach.
>> 
> 
> Thanks :)
> 
>> It's not a device after all and I agree that the device tree shouldn't
>> become an OS configuration file. Regarding multiple levels of shared
>> resources my point is that since cpu-map doesn't contain any 
>> information of
>> what is shared among the cluster/core members it's not easy to do any
>> further translation. Last time I checked the arm code that uses 
>> cpu-map, it
>> only defines one domain for SMT, one for MC and then everything else 
>> is
>> ignored. No matter how many clusters have been defined, anything above 
>> the
>> core level is the same (and then I guess you started talking about 
>> adding
>> "packages" on the representation side).
>> 
> 
> Correct.
> 
>> The reason I proposed to have a binding for the scheduler directly is 
>> not
>> only because it's simpler and closer to what really happens in the 
>> code, it
>> also makes more sense to me than the combination of cpu-map with all 
>> the
>> related mappings e.g. for numa or caches or power domains etc.
>> 
> 
> Again you are just looking at it with Linux kernel perspective.
> 
>> However you are right we could definitely augment cpu-map to include 
>> support
>> for what I'm saying and clean things up, and since you are open about
>> improving it here is a proposal that I hope you find interesting: At 
>> first
>> let's get rid of the <thread> nodes, they don't make sense:
>> 
>> thread0 {
>>  cpu = <&CPU0>;
>> };
>> 
> 
> Do you have any strong reasons to do so ?
> Since it's already there for some time, I believe we can't remove it 
> for
> backward compatibility reasons.
> 
>> A thread node can't have more than one cpu entry and any properties
>> should be on the cpu node itself, so it doesn't / can't add any
>> more information. We could just have an array of cpu nodes on the
>> <core> node, it's much cleaner this way.
>> 
>> core0 {
>>  members = <&CPU0>, <&CPU1>;
>> };
>> 
> 
> I agree, but we have kernel code using it(arm64/kernel/topology.c). 
> It's
> too late to remove it. But we can always keep to optional if we move 
> the
> ARM64 binding as generic to start with and mandate it for only ARM64.
> 

That's my point as well, if we are going to define something to be used
by everybody and in this case, at least for RISC-V, there is no need to
carry this from the ARM64 binding. It shouldn't be that hard to fix this
in the future for ARM64 as well, we may give the new mapping another 
name,
maybe cpu-map2 or cpu-topology to slowly move to the new one. Changing 
the
dts files shouldn't be this hard, we can provide a script for it. We can
even contain some compatibility code that also understands <thread> 
nodes
and e.g. merges them together on a core node.

>> Then let's allow the cluster and core nodes to accept attributes that 
>> are
>> common for the cpus they contain. Right now this is considered 
>> invalid.
>> 
> 
> Yes, we have discussed in the past and decided not to. I am fine if we
> need to change it, but assuming the topology implies other information
> could be wrong. On ARM platforms we have learnt it, so we kept any
> information away from topology. I assume same with RISC-V, different
> vendors implement in different ways, so it's better to consider those
> factors.
> 
>> For power domains we have a generic binding described on
>> Documentation/devicetree/bindings/power/power_domain.txt
>> which basically says that we need to put power-domains = <power domain
>> specifiers> attribute on each of the cpu nodes.
>> 
> 
> OK, but what's wrong with that. I gives full flexibility.
> 
>> The same happens with the capacity binding specified for arm on
>> Documentation/devicetree/bindings/arm/cpu-capacity.txt
>> which says we should add the capacity-dmips-mhz on each of the cpu 
>> nodes.
>> 
> 
> Ditto, we may need this for our single cluster DSU systems.
> 
>> The same also happens with the generic numa binding on
>> Documentation/devicetree/bindings/numa.txt
>> which says we should add the nuna-node-id on each of the cpu nodes.
>> 
> 
> Yes, but again what's the problem ?
> 

There is no problem with the above bindings, the problem is that we have
to put them on each cpu node which is messy. We could instead put them
(optionally) on the various groupings used on cpu-map. This would allow
cpu-map to be more specific of what is shared across the members of each
group (core/cluster/whatever).

As I wrote on my answer to Mark previously, the bindings for infering
the cache topology, numa topology, power domain topology etc are already
there, they are in the devicet tree spec and provide very specific
informations we can use. Much "stronger" hints of what's going on at
the hw level. The cpu-map doesn't provide such information, it just
provides a view of how the various harts/threads are "packed" on the 
chip,
not what they share inside each level of "packing". It's useful because
it saves people from having to define a bunch of cache nodes and 
describe
the cache hierarchy on the device tree using the standard spec.

So since cpu-map is there for convenience let's make it more convenient 
!
What I'm saying is that cpu-map could be a more compact way of using the
existing bindings for adding properties on groups of harts instead of
putting them on each hart individually. It will simplify the 
representation
and may also optimize the implementation a bit (we may get the 
information
we need faster). I don't see any other reason for using cpu-map on 
RISC-V
or for making it global across archs.

>> We could allow for these attributes to exist on cluster and core nodes
>> as well so that we can represent their properties better. It shouldn't
>> be a big deal and it can be done in a backwards-compatible way (if we
>> don't find them on the cpu node, climb up the topology hierarchy until
>> we find them / not find them at all). All I'm saying is that I prefer 
>> this:
>> 
> 
> [...]
> 
>> 
>> cluster0 {
>>  cluster0 {
>>   core0 {
>>    power-domains = <&pdc 0>;
>>    numa-node-id = <0>;
>>    capacity-dmips-mhz = <578>;
>>    members = <&cpu0>, <&cpu1>;
>>   }
>>  };
>>  cluster1 {
>>   capacity-dmips-mhz = <1024>;
>>   core0 {
>>    power-domains = <&pdc 1>;
>>    numa-node-id = <1>;
>>    members = <&cpu2>;
>>   };
>>   core1 {
>>    power-domains = <&pdc 2>;
>>    numa-node-id = <2>;
>>    members = <&cpu3>;
>>   };
>>  };
>> }
>> 
> 
> Why are you so keen on optimising the representation ?
> If you are worried about large systems, generate one instead of
> handcrafted.
> 

I don't see a reason not to try to optimize it, since we are talking
about a binding to be used by RISC-V and potentially everybody, I think
it makes sens to improve upon what we already have.

>> When it comes to shared resources, the standard dt mappings we have 
>> are for
>> caches and are on the device spec standard (coming from power pc's 
>> ePAPR
>> standard I think). The below comes from HiFive unleashed's device tree
>> (U540Config.dts) that follows the spec:
>> 
> 
> I don't understand what you are trying to explain, ePAPR does specify
> per CPU entries.
> 
> [...]
> 

I'm saying we could allow moving these properties on the groupings of 
cpu-map
to simplify the representation and possibly optimize the implementation. 
This
way I believe cpu-map will be much more useful than it is now.

>> Note that the cache-controller node that's common between the 4 cores 
>> can
>> exist anywhere BUT the cluster node ! However it's a property of the
>> cluster.
>> A quick search through the tree got me r8a77980.dtsi that defines the 
>> cache
>> on the cpus node and I'm sure there are other similar cases. Wouldn't 
>> this
>> be better ?
>> 
>> cluster0 {
>>  core0 {
>>   cache-controller@2010000 {
>>    cache-block-size = <64>;
>>    cache-level = <2>;
>>    cache-sets = <2048>;
>>    cache-size = <2097152>;
>>    cache-unified;
>>    compatible = "sifive,ccache0", "cache";
>>    ...
>>   };
>>   members = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> 
> Not a good idea IMO.
> 

Where in your opinion should this cache node go ? On the first example 
from
a production dts it goes to the SoC node and on another production dts 
it goes
to the cpus/ node. I think it makes more sense to go to the core node or 
the
cluster node, depending on how it's shared. It makes it also easier
for the implementation to understand the levels of shared caches and 
creating
cpu masks.

>> We could even remove next-level-cache from the cpu nodes and infer it 
>> from
>> the  topology (search the topology upwards until we get a node that's
>> "cache"-compatible), we can again make this backwards-compatible.
>> 
> 
> Why are you assuming that they *have* to be so aligned with topology ?
> How do you deal with different kind of systems ?
> 

It depends on how you define topology. I believe that the cache 
hierarchy is
a much "stronger" definition of the CPU topology than grouping 
harts/threads
on classes like "core", "socket", "packet" etc that don't provide any 
information
of what's going on inside the hardware. You can think of the question 
the other
way around, why are you assuming that the current topology as specified 
on
cpu-map is aligned with how the harts and cores share their "resources" 
?
Because that's what's going on at the implementation side of cpu-map.

>> 
>> Finally from the examples above I'd like to stress out that the 
>> distinction
>> between a cluster and a core doesn't make much sense and it also makes 
>> the
>> representation more complicated. To begin with, how would you call the 
>> setup
>> on HiFive Unleashed ? A cluster of 4 cores that share the same L3 
>> cache ?
>> One core with 4 harts that share the same L3 cache ? We could 
>> represent it
>> like this instead:
>> 
> 
> Just represent each physical cache and get the list of CPUs sharing it.
> Doesn't matter what it is: cluster or cluster of clusters or cluster of
> harts, blah, blah. It really doesn't matter.
> 

I totally agree with you, but in this case what's the reason of having
cpu-map ? We can infer the topology from what we already have, at least
cpu-map adds some convenience (but if we go all the way down the 
"convinience"
path we'll end up on something like my initial approach which was as we
both agree now, wrong).

>> 
>> We could e.g. keep only cluster nodes and allow them to contain either 
>> an
>> array of harts or other cluster sub-nodes + optionally a set of 
>> attributes,
>> common to the members/sub-nodes of the cluster. This way we'll get in 
>> the
>> first example:
>> 
> 
> All these fancy new ideas you are proposing are good if vendors follow
> some things religiously, but I really doubt if that's true. So just
> have maximum flexibility so that we can represent maximum number of
> systems without having to redefine the bindings again and again for the
> same thing.
> 
> So instead of finding ways to optimise, you should really come up with
> list of shortcomings in the existing bindings so that we cover more
> platforms with generic bindings. IMO you are too concerned on 
> optimisation
> of DT representation which may defeat the purpose of generic bindings.
> 

I get your point, but if that's the case, isn't cpu-map an optimization 
over
the generic bindings for cpu nodes anyway ? As for the flexibility, what 
I'm
saying is to allow the flexibility of adding the properties that we 
would
otherwise add to cpu nodes, on the groups we use on cpu-map. Optionaly 
so that
we are also backwards compatible. I see this as more flexible, not less
flexible. The same goes for removing the distinction between "core",
"cluster" etc, having specific names for each of the topology levels is 
IMHO
less flexible than using abstract names.

Also what's the point of defining a binding if vendors don't follow it ?
I think it would be easier for the vendors to just use what's there 
instead
of defining a new binding and writing the code for it. On the other hand
you are probably more experienced on this than I am, I haven't dealt 
with
various different vendors and their different ways.

Regards,
Nick

