Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A21ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D832087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="sm/exFzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D832087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeGMPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:37:32 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:55168 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbeGMPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:37:31 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2018 11:37:29 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C6BBA4C70A;
        Fri, 13 Jul 2018 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:in-reply-to:mime-version:user-agent
        :date:date:message-id:from:from:references:subject:subject
        :received:received:received; s=mta-01; t=1531494864; x=
        1533309265; bh=1w6cn30YX9MIoK2Chu6TH8NVy7j3yc8gp74rGcR3EN0=; b=s
        m/exFzON4N6kVuCut8HeK36qEpev4EmtZKrW18A1qaKKM+WnBiqeGsOyo3O9c6OJ
        IGOcfayxpcXRPe+sVwbFAnIhWmpX9Kr0dSrpqjci2jQJCptNNygRXJRDWeyY2G3m
        L8R5Wh25GJpy9wRfEK5NAj8ahmzP+ZSbKJmroq1CLQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BzLYQrUKQ8e0; Fri, 13 Jul 2018 18:14:24 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 784E749857;
        Fri, 13 Jul 2018 18:14:22 +0300 (MSK)
Received: from [172.17.14.168] (172.17.14.168) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 13
 Jul 2018 18:14:21 +0300
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
To:     Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <Eugene.Cho@dell.com>, <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, <stewart@linux.ibm.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
From:   Alexander Amelkin <a.amelkin@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=a.amelkin@yadro.com; prefer-encrypt=mutual; keydata=
 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
 dTYsE5wSxM06T2l/MILupCNZ7A==
Message-ID: <a521b9fc-4c10-06c1-fd73-5c64379538f6@yadro.com>
Date:   Fri, 13 Jul 2018 18:14:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="PWnsBJ4fBKFA5s63utchMKWHuSJz7aaGw"
X-Originating-IP: [172.17.14.168]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PWnsBJ4fBKFA5s63utchMKWHuSJz7aaGw
Content-Type: multipart/mixed; boundary="zomQLYF2IoQwriKKqWgOrLLlRK83HPLyN";
 protected-headers="v1"
From: Alexander Amelkin <a.amelkin@yadro.com>
To: Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eugene.Cho@dell.com,
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 stewart@linux.ibm.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Message-ID: <a521b9fc-4c10-06c1-fd73-5c64379538f6@yadro.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
In-Reply-To: <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>

--zomQLYF2IoQwriKKqWgOrLLlRK83HPLyN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Andrew, Ben, first of all let me thank you for bringing in this set of
patches.

=46rom the discussion it looks to me like Rob is not familiar with
specifics of BMC-managed servers and tries to apply to them the rules
that have proven to be good for workstations and laptops.

As someone using /dev/mem these days to configure those registers in
BMCs, I'm all for this patch set as it will make BMC configuration less
obscure. Writing 1 or 0 to a named node is way clearer than writing some
magic value at some magic offset in /dev/mem. I like the idea of having
it all configurable via DT as it allows for only having exported the
nodes that are actually needed, thus reducing, as you have said, the
foot-gun.

So far I do not have any objections or constructive comments to the
architecture of the proposed patches.

So I'm writing this to support your position in this discussion and to
let Rob and other reviewers know that this feature is actually needed.

With best regards,
Alexander Amelkin

13.07.2018 09:31, Andrew Jeffery wrote:
> Hi Rob, Ben,
>
> I've replied to you both inline below, hopefully it's clear enough from=
 the context.
>
> On Fri, 13 Jul 2018, at 10:25, Benjamin Herrenschmidt wrote:
>> On Thu, 2018-07-12 at 09:11 -0600, Rob Herring wrote:
>>> On Wed, Jul 11, 2018 at 6:54 PM Andrew Jeffery <andrew@aj.id.au> wrot=
e:
>>>> Hi Rob,
>>>>
>>>> Thanks for the response.
>>>>
>>>> On Thu, 12 Jul 2018, at 05:34, Rob Herring wrote:
>>>>> On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
>>>>>> Baseboard Management Controllers (BMCs) are embedded SoCs that exi=
st to
>>>>>> provide remote management of (primarily) server platforms. BMCs ar=
e
>>>>>> often tightly coupled to the platform in terms of behaviour and pr=
ovide
>>>>>> many hardware features integral to booting and running the host sy=
stem.
>>>>>>
>>>>>> Some of these hardware features are simple, for example scratch
>>>>>> registers provided by the BMC that are exposed to both the host an=
d the
>>>>>> BMC. In other cases there's a single bit switch to enable or disab=
le
>>>>>> some of the provided functionality.
>>>>>>
>>>>>> The documentation defines bindings for fields in registers that do=
 not
>>>>>> integrate well into other driver models yet must be described to a=
llow
>>>>>> the BMC kernel to assume control of these features.
>>>>> So we'll get a new binding when that happens? That will break
>>>>> compatibility.
>>>> Can you please expand on this? I'm not following.
>>> If we have a subsystem in the future, then there would likely be an
>>> associated binding which would be different. So if you update the DT,=

>>> then old kernels won't work with it.
>> What kind of "subsystem" ? There is almost no way there could be one
>> for that sort of BMC tunables. We've look at several BMC chips out
>> there and requirements from several vendors, BIOS and system
>> manufacturers and it's all over the place.
> Right - This is the fundamental principle backing these patches: There =
will never be a coherent subsystem catering to any of what we want to des=
cribe with these bindings.
>
>>>> I feel like this is an argument of tradition. Maybe people have
>>>> been dissuaded from doing so when they don't have a reasonable use-
>>>> case? I'm not saying that what I'm proposing is unquestionably
>>>> reasonable, but I don't want to dismiss it out of hand.
> ...
>>> It comes up with system controller type blocks too that just have a
>>> bunch of random registers.=20
> This matches the situation at hand.
>
>>> Those change in every SoC and not in any
>>> controlled or ordered way that would make describing the individual
>>> sub-functions in DT worthwhile.
> "Not worthwhile" is what I'm pushing back against for our use cases. I =
think they are narrow and limited enough to make it worthwhile.
>
> Obviously we want to avoid describing these things *badly* - you mentio=
ned the clock bindings - so I'm happy to hash out what the right represen=
tation should be. But I struggle to think the solution is not describing =
some of our hardware features at all.
>
>> So what's the alternative ? Because without something like what we
>> propose, what's going to happen is /dev/mem ... that's what people do
>> today.
> Yep. And I've outlined in the cover letter what I think are the advanta=
ges of what I'm proposing over /dev/mem. It's not an incredible gain, but=
 has several of nice-to-have properties.
>
>>>>> A node per register bit doesn't scale.
>>>> It isn't meant to scale in terms of a single system. Using it
>>>> extensively is very likely wrong. Separately, register-bit-led does
>>>> pretty much the same thing. Doesn't the scale argument apply there?
>>>> Who is to stop me from attaching an insane number of LEDs to a
>>>> system?
>>> Review.
>>>
>>> If you look, register-bit-led is rarely used outside of some ARM, Ltd=
=2E
>>> boards. It's simply quite rare to have MMIO register bits that have a=

>>> fixed function of LED control.
>> Well, same here, we hope to review what goes upstream to make it
>> reasonable. Otherwise it doens't matter. If a random vendor, let's say=

>> IBM, chose to chip a system where they put an insane amount of cruft i=
n
>> there, it will only affect those systems's BMC and the userspace stack=

>> on it.
>>
>> Thankfully that stack is OpenBMC and IBM is aiming at having their
>> device-tree's upstream, thus reviewed, thus it won't happen.
>>
>> *Anything* can be abused. The point here is that we have a number,
>> thankfully rather small, maybe a dozen or two, of tunables that are
>> quite specific to a combination (system vendor, bmc vendor, system
>> model) which control a few HW features that essentially do *NOT* fit i=
n
>> a subsystem.
> Exactly. I tried to head off the abuse vector by requiring that uses be=
 listed in the bindings document, and thus enforce some level of review. =
It might not be the most effective approach at the end of the day, but at=
 least it is something.
>
>> For everything that does, we have created proper drivers (and are doin=
g
>> more).
>>
>>
>>>> Obviously if there are lots of systems using it sparingly and
>>>> legitimately then maybe there's a scale issue, but isn't that just
>>>> a reality of different hardware designs? Whoever is implementing
>>>> support for the system is going to have to describe the hardware
>>>> one way or another.
>>>>
>>>>> Maybe this should be modelled using GPIO binding? There's a line th=
ere
>>>>> too as whether the signals are "general purpose" or not.
>>>> I don't think so, mainly because some of the things it is intended t=
o be used for are not GPIOs. For instance, take the DAC mux I've describe=
d in the patch. It doesn't directly influence anything external to the So=
C (i.e. it's certainly not a traditional GPIO in any sense). However, it =
does *indirectly* influence the SoC's behaviour by muxing the DAC interna=
lly between:
>>>>
>>>> 0. VGA device exposed on the host PCIe bus
>>>> 1. The "Graphics CRT" controller
>>>> 2. VGA port A
>>>> 3. VGA port B
>>> And this mux control is fixed in the SoC design?
>> This specific family of SoC (Aspeed) support those 4 configurations.
>> How they need to be configured at runtime depends on the combination o=
f
>> system vendor and system model, along with in some cases the need to
>> switch it at runtime.
>>
>> This is just one example. Another one is the handful of scratch
>> registers that need to be populated with the "right" values for the
>> host system BIOS, VGA BIOS and VGA driver. (The host bits access them
>> via LPC IO space).
>>
>> The host system BIOS will read some basic config info there before its=

>> IPMI stack is up (and some BIOSes already rely on that). The VGA BIOS
>> will get some strapping info and panel info. The VGA driver (which is
>> already upstream, has been for a long time) will look for other things=

>> in some of these guys, such as connector configuration.
>>
>> Andrew, if it helps, we could put together a list of what we typically=

>> need on an OpenPower system today. That would give people like Rob a
>> better idea of what this is all about.
> It's primarily what I've outlined at the bottom of the bindings documen=
t, though the use cases aren't provided there as they are a bit out-of-sc=
ope. So the SuperIO and VGA scratch registers, plus the DAC mux. A bunch =
of tunable things.
>
> OpenPOWER platforms make use of the SuperIO scratch registers to convey=
 configuration information from the BMC to the host. Information provided=
 includes low-level control of the host firmware initialisation process, =
UART and logging configuration, and the strategy for handling errors (cra=
sh vs log). This is all an "arbitrary" contract between the BMC userspace=
 and the host firmware, i.e. different platforms/firmware could lay out t=
he same information in different ways or communicate entirely different i=
nformation altogether. The BMC kernel shouldn't care about any of it, oth=
er than provide sensible access to the hardware.
>
> Again on OpenPOWER systems using the ASPEED BMC SoCs running OpenBMC, t=
he BMC uses the VGA scratch registers to sense initialisation of the host=
 graphics driver in the host's boot process. When the BMC userspace detec=
ts the host VGA driver is up we switch the DAC mux from the BMC CRT devic=
e to the host VGA device so that the host is now driving the VGA output. =
Non-OpenPOWER OpenBMC configurations may do something entirely different,=
 or not do anything at all with the hardware, so as above, it's not reall=
y the job of the BMC kernel to be involved in any of this, other than to =
provide sensible access to userspace.
>
> There are a number of other switches that control the availability of A=
SPEED BMC hardware features to the host system that also don't fit any pa=
rticular subsystem and so will use these bindings, but our (OpenPOWER/Ope=
nBMC) current uses are what's described above.
>
> Dell also suggested they had some use-cases that aligned with the inten=
t of the bindings, but I don't know what they had in mind. Eugene (on Cc)=
 can elaborate.
>
>>>> Maybe this could be modelled by pinmux, but then we still need some
>>>> way to expose the mux functions to userspace for selection
>>>> (userspace needs to transition arbitrarily between at least options
>>>> 0 and 1 at runtime), at which point we haven't achieved much beyond
>>>> adding a whole heap of infrastructure in the chain.
>>>>
>>>> Given 0 and 1, maybe exposing attributes in relevant drivers would
>>>> be reasonable, except 0 isn't exposed on the SoC's internal bus so
>>>> there is no driver on the BMC-side to do so. Taking into account 2
>>>> and 3 are also purely hardware paths further dashes the idea, as
>>>> the configuration doesn't really "belong" to the Graphics CRT
>>>> device more than it belongs anywhere else, except for the fact that
>>>> there isn't anywhere else to expose it.
>>>>
>>>> Further, the BMC's kernel can't make the decision as to when to
>>>> switch the mux as it knows nothing of the host's state. The BMC
>>>> userspace is controlling the host's boot state and so *does* know
>>>> when to flip the switch. Finally, the mux is in separate IP to the
>>>> CRT or VGA blocks: It lives in the System Control Unit.
>>>>
>>>> My current point of view is the DAC mux field is effectively its
>>>> own device, and we need to control it from userspace, so we need
>>>> some way to describe it (i.e. not ignore it) in order for its
>>>> capability to be exposed.
>>>>
>>>> I'm fully aware what I'm proposing isn't awesome as it's not
>>>> providing any real abstraction, but the problem(s) at hand also
>>>> seem to defy abstraction, and in order to avoid a plethora of
>>>> bespoke bindings I thought it was reasonable to define something
>>>> generic.
>>>>
>>>> All-in-all I appreciate the suggestion, but assuming you agree with
>>>> my reasoning above do you have thoughts on other alternatives?
>>> Seems the controls are more fixed than I first thought. All the data
>>> you have here could simply be within a driver.=20
> Rob: A driver for what though? One unique to this particular mux? That =
feels overly specific when we can generalise the concept to cover a wider=
 range of use-cases.
>
>>> Help me understand what
>>> functions are fixed (in the SoC) and which ones vary by board. Only
>>> what's changing per board really needs to go into DT.
> I think this last sentence identifies a difference in our starting poin=
ts, so I'd like to explore that. Blocks of functionality might move aroun=
d inside the SoC as well, so don't we need a way to describe those functi=
ons appropriately? And from there describe how the SoC integrates the fun=
ctions, and then describe how a board integrates the SoC? This all compos=
es, and the problem at the end of the day comes down to what we want to v=
iew as a point of abstraction, right?
>
> It seems ideal to me that the metadata about hardware features resides =
in the description of the relevant system (DT, for a function, a SoC or a=
 board), otherwise don't we wind up with crazy, unfocused, monolithic dri=
vers for things like system controllers? (There's MFD/syscon, but having =
used it previously I'm still grappling with the benefit over some of the =
weirdness it injects into devicetree - maybe I did it wrong.) Or alternat=
ively, a generic driver that's choc full of platform-specific data coveri=
ng the platforms that require it? The driver that implements the behaviou=
r of the bindings described here turns out quite focused (even if the fir=
st attempt was a bit of a basket case, hopefully the second is better (so=
rry Greg)).
>
>> Most of these things is specific to a given board or may even need to
>> be changed at runtime.
> *snip*...
>
>> Talking of which: Andrew, did you put "default values" in your binding=

>> ? That would be a nice way to deal with system specific immutables, so=

>> that userspace doesn't even have to care.
> Yes, I described a `default-value`property for RW fields, and `default-=
set` and `default-clear`properties for write-1-set/write-1-clear fields f=
or exactly this purpose.
>
>> So to clarify once and for all, *anything* that fits in a subsystem,
>> we're putting in one. All the random board control is all GPIOs and
>> that's fine as well. For some things that require a bit of fiddly usag=
e
>> like the "MBOX" logic between BIOS and BMC we are also doing a
>> dedicated driver.
> (As an aside, the "MBOX" functionality is slightly different from the s=
cratch registers in that it has configurable interrupts each way (BMC-to-=
Host and Host-to-BMC) - as such it can be used to implement a dynamic pro=
tocol and so deserves its own driver. This is in contrast to the dumb scr=
atch registers we're describing with these bindings which have no such in=
terrupts.)
>
>> But there's a few stragglers here, and they tend to be so
>> board/system/BIOS specific that it's not sustainable to create/change
>> random drivers all the time just for exposing those few tunables.
>>
> Yes, this is my feeling too.
>
> Cheers,
>
> Andrew



--zomQLYF2IoQwriKKqWgOrLLlRK83HPLyN--

--PWnsBJ4fBKFA5s63utchMKWHuSJz7aaGw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbSMHNAAoJEOiTWHtbdBeNjl8P/jgL6aby47LNJiTua8s1k2Qq
2iBqgKcKXgTUp0fKgazqIkldjWvQP/UOQA83CUUit5LbQAitRZdh2EcPjKKFYwKV
fDNQc5MHr40+RLo9Dyy+hY2RPR8FJozSPHT6wOc9robDJswIg4PhrgBhQKokQPiU
+4q8j6iMucH+AZuzPaTcbuwdkf3cSq3Bab+TZAvoCmKuo0gOBxtz0KNRXXb/Zabv
Of9nPkkZ5nfDVGOow7fFrePTY0pN9XsaCW/0gSygT+KOzPvdWqpyuRnTMIYdzdDA
teiY1OBxpvXVtEhxexqR7u3nMG6k3477r7c77bqAvB7GJWprzq+1lHBiYVO5vADh
LRb6L4n/KA0IQT3s+BsWNXHCrL7c1hQ6ZuuBSwHmx7g5pahNKk5iiPOGcZ9OkI+V
AYhSoXbA0ELYtzxbKRT6/oA+ppjF2ezRn7krKXQN0aQsQK/1W0VkVPWQjEBXO/tu
R5MrTiS8xmXakWY/TWC6f9NpABfk8/B467+ARFRvWDz2X7XxOI6QBXE2wHO5YYgI
IRpU6nCEO/uuyYOaUfApnUzlMK8yBkTqdipy93lV94y6kDuGE81YMbS0Sifbx81/
T5R7KOP6HYTVn7vVIFx0tV+CyluE1SJQ79rJ6LIv904q5nArx9g2cuK5jS2KgJNk
VrRJv8/GkMWXsGcbRKCe
=8BH/
-----END PGP SIGNATURE-----

--PWnsBJ4fBKFA5s63utchMKWHuSJz7aaGw--
