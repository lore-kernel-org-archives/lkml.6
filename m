Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15A0C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E2E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hddZ6nKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E2E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJaBKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:10:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15842 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeJaBKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:10:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd883bb0005>; Tue, 30 Oct 2018 09:15:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Oct 2018 09:16:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Oct 2018 09:16:08 -0700
Received: from [10.21.24.173] (10.21.24.173) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 30 Oct
 2018 16:16:04 +0000
Subject: Re: [PATCH 4/9] mailbox: tegra-hsp: Add support for shared mailboxes
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-5-thierry.reding@gmail.com>
 <bfc78c91-73f1-4f64-9196-5268a73b5c42@nvidia.com>
 <20181029103937.GB26393@ulmo>
 <9dfa7669-9401-a55c-8959-8d31cf193ca7@nvidia.com>
 <20181029131614.GA14616@ulmo>
From:   Pekka Pessi <ppessi@nvidia.com>
Message-ID: <c2ebc2aa-bf71-59fa-44a1-eaf5d479b2d5@nvidia.com>
Date:   Tue, 30 Oct 2018 18:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029131614.GA14616@ulmo>
X-Originating-IP: [10.21.24.173]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540916156; bh=u+Qr6C7f0ooyDkky1SzCXLrvxhEKK0aI1rCUeOPWnv4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=hddZ6nKke6txTdGILwX7/OFwHThJAybG3UD9nlK78advXc/yD+c8srZGAoRvEvqz6
         a5Pl874Z3p5rAZZHxr4IglQaL50DtWyzmdcRSRcvLaIIdlp2GHbT2f/VXmBk9RUsMx
         OVWioXWz8wK0a9KMch4CsrIm9gZLF26R6PH8nroYGmso9YLyTqcYmzd9X+5ECo4IhZ
         sVx2dzgTZOMiE4ss1JMYVt7vI/4c2bbVTQhksYilEO6kEqmq+CIzSUwowvmE+iAMav
         tydq1eA0SdJM5F/RBVfdcL304iPzLGcSE8SABl/YxryXMjKFshRnqDgVzdXOqYwbej
         IsYjcFD1E1dzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess it being an example doesn't make it strictly a recommendation, bu=
t
> I wonder if we should avoid giving examples that use mappings which we
> discourage.

Well, yes, that is example for top0 =E2=80=93 but I agree, giving examples =
that=20
do not make much sense is not very productive.

> So currently
> we list all available interrupts in DT and then we could pick just the
> first. But what if somebody else already picked the first and "owns" it

We have rather static hardware allocation in device trees, if an another=20
VM instance or another aux cpu owns interrupt, we just remove it from=20
the DTS or DTSI.=C2=A0 So the native Linux would see all the possible=20
interrupts (that are not used by SPE or RCE, for instance), but a=20
virtualized one would see only one.

> For mailboxes that the CCPLEX writes to, we can reconfigure them as
> producers by disabling the FULL interrupt and enabling the EMPTY
> interrupt instead. We can do that the first time somebody calls the
> mbox_send_message() on the mailbox.

The problem here is "disabling the FULL interrupt". The main problem are=20
the mailbox-specific IE registers, they are not really shared, but the=20
consumer owns the full_ie and producer empty_ie. We can not enable or=20
disable interrupts without interfering with the interrupt settings of=20
the remote end, when the interrupt is enabled, we either modify=20
full_ie/empty_ie register or run with a risk that it has incorrect value.

Can we just leave the mbox channel without interrupts? How the consumer=20
indicates that it is interested in receiving messages? mbox_peek_data()?

--Pekka



On 10/29/2018 03:16 PM, Thierry Reding wrote:
> On Mon, Oct 29, 2018 at 02:25:42PM +0200, Pekka Pessi wrote:
>> Hi Thierry,
>>
>>  From the 0/9:
>>> Are you aware of any others that we need to take into account?
>> We would like to use upstream driver for RCE (and probably AON and SCE)
>> mailbox handling, too. Eventually.
>>> This is a bit
>>> of a problem because the mailbox driver doesn't really know anything
>>> about the direction when it starts up, so how would it make the decisio=
n
>>> about how to program the registers?
>> I'm afraid that information must be stored in the device tree.
>>> What's somewhat surprising is that you're saying that both FULL and
>>> EMPTY interrupts should be handled by the same shared interrupt. That's
>>> the opposite of what the recommended programming sequence is that the
>>> TRM specifies.
>> Which TRM you mean? Something here?
>>
>> https://p4viewer.nvidia.com/get///hw/ar/doc/Tech_Pubs/Xavier/TRM/
>>
>> I browsed through he Xavier_TRM_DP09253001v1.pdf HSP section and I could=
 not
>> find any recommendations? But see below.
> I'm referring to Xavier_TRM_Public.pdf in that location. If you look at
> page 4422, "Shared Interrupts Configuration", the example has aggregated
> EMPTY and FULL interrupts on shared interrupts 0 and 1, respectively. I
> guess it being an example doesn't make it strictly a recommendation, but
> I wonder if we should avoid giving examples that use mappings which we
> discourage.
>
>>> Why is it better to handle both FULL and EMPTY interrupts
>>> with the same shared interrupt?
>> Only top0 has 8 interrupts, rest of the HSP blocks have only 4 (or 5 in =
case
>> of top1) interrupts per HSP available through LIC. Hogging two of them m=
eans
>> that only two VMs can access a HSP.
> Virtualization isn't something that we're very concerned about upstream,
> but I'll take that under consideration.
>
>>> Would it be safe to clear all of the IE registers to 0 on driver probe?
>> Nope, the driver should clear only the IE register for the shared interr=
upt
>> that the driver uses. Other IEs are used by other entities.
> Right, that makes sense. But within that IE register it can consider all
> bits fair game, right? One thing I wonder, though, is whether there
> should be some external mechanism to set the shared interrupt to use. If
> we go purely by convention we'll eventually get this wrong. So currently
> we list all available interrupts in DT and then we could pick just the
> first. But what if somebody else already picked the first and "owns" it?
>
> I'm not sure we have any practical mechanism to rewrite the DTB, but
> perhaps something to keep in mind if ever we need to support other
> entities down the road.
>
>>> If they are indeed separate
>>> for each processor, it should be fairly easy to keep track of the
>>> mailboxes used by the kernel and process only those.
>> Yes, that is what we should do. Again the directionality should be speci=
fied
>> in DT.
> Currently we encode the shared mailboxes in DT like this:
>
> 	mboxes =3D <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
> 		 <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
> 	mbox-names =3D "rx", "tx";
>
> I suppose we could change that to something like:
>
> 	mboxes =3D <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM (0 << 31 | 0)>,
> 		 <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM (1 << 31 | 0)>;
>
> Where the MSB of the mailbox index would indicate the direction. We
> could maybe add some eye-candy to make it easier to read:
>
> 	mboxes =3D <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM TEGRA_HSP_MBOX_SM_RX(0)>,
> 		 <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM TEGRA_HSP_MBOX_SM_TX(1)>;
>
> That said, I wonder if perhaps it is safe to treat all mailboxes as
> consumers by default and omit and direction in DT. If a mailbox is used
> as consumer, then the CCPLEX is only interested in FULL interrupts, so
> we enable those. The entity that shares the mailbox will write data to
> it and is only interested in the EMPTY interrupt, which we don't touch
> from the CCPLEX.
>
> For mailboxes that the CCPLEX writes to, we can reconfigure them as
> producers by disabling the FULL interrupt and enabling the EMPTY
> interrupt instead. We can do that the first time somebody calls the
> mbox_send_message() on the mailbox.
>
> Do you see any problems with that approach?
>
>>> I'm not entirely clear on what the advantages are of using the per-
>>> mailbox registers, or how they are supposed to be used. The existing
>>> documentation doesn't really explain how these are supposed to be used
>>> either, so I was mostly just going by trial and error.
>> On virtualized configs, multiple VMs can use same HSP block but each VM =
must
>> use its own interrupt. Because all the IE registers are on the same 64 K=
B
>> page, the writes to the page are trapped by hypervisor, which means that
>> enabling or disabling an interrupt via the shared IE register is pretty
>> heavy operation. The per-mailbox IE registers are on a page accessed fre=
ely
>> by the IE, no need to trap.
> Do the per-mailbox IE registers act as a second level enable, then? The
> HSP driver would still have to set the IE register to aggregate FULL and
> EMPTY interrupts as needed, but could then use the per-mailbox IE
> registers to actually enable and disable (that is, unmask and mask) the
> interrupts?
>
>> If a VM uses only one empty mailbox interrupt, using a dedicated "shared=
"
>> interrupt and disabling that in GIC could be a lighter operation, we use=
d to
>> do that in Parker.
> Okay, that seems like it would somewhat complicate things and we don't
> really support VM uses yet, so I think it best to leave that out for
> now.
>
> Thierry
>
>> On 10/29/2018 12:39 PM, Thierry Reding wrote:
>>> On Mon, Oct 29, 2018 at 12:04:22PM +0200, Pekka Pessi wrote:
>>>> Hi Thierry,
>>>>
>>>> There is typically one entity (aux cpu or a VM running on CCPLEX) owni=
ng the
>>>> "empty" or producer side of mailbox (iow, waking up on empty) and anot=
her
>>>> entity owning the "full" or consumer side of mailbox (waking up on ful=
l). An
>>>> entity should not muck with the interrupts used by the opposite side.
>>> Okay, that explains some of my observations. I was initially trying to
>>> program interrupt enables for both FULL and EMPTY interrupts for all
>>> mailboxes, but then I'd usually get timeouts because the consumer wasn'=
t
>>> responding (i.e. the SPE wasn't getting FULL interrupts for the CCPLEX'=
s
>>> TX mailbox).
>>>
>>> If I understand correctly, you're saying that the CPU should only be
>>> using the EMPTY interrupts for it's TX mailbox (while leaving the FULL
>>> interrupts completely untouched) and only the FULL interrupt for it's
>>> RX mailbox (while leaving the EMPTY interrupts untouched). This is a bi=
t
>>> of a problem because the mailbox driver doesn't really know anything
>>> about the direction when it starts up, so how would it make the decisio=
n
>>> about how to program the registers?
>>>
>>>> One entity typically owns one shared interrupt only.=C2=A0 For the
>>>> BPMP/SCE/RCE/SPE HSP blocks the shared interrupt 0 is owned by the aux=
iliary
>>>> processor itself, the shared interrupts 1..4 are connected to LIC and =
are
>>>> available to other entities. The convention is to go through the inter=
rupts
>>>> 0..4 and then using the first available shared interrupt for both full=
 and
>>>> empty.
>>> That partially matches another of my observations. It seems like we
>>> can't use the shared interrupt 0 at all on at least the AON HSP. That's
>>> fine because that HSP instance contains the TX mailbox for TCU and by
>>> the current convention in the HSP driver, shared interrupt 0 would be
>>> aggregating the FULL interrupts, which according to the above we don't
>>> need for TX mailboxes.
>>>
>>> What's somewhat surprising is that you're saying that both FULL and
>>> EMPTY interrupts should be handled by the same shared interrupt. That's
>>> the opposite of what the recommended programming sequence is that the
>>> TRM specifies. Why is it better to handle both FULL and EMPTY interrupt=
s
>>> with the same shared interrupt?
>>>
>>>> The interrupt functions should use a mask for mailboxes owned by kerne=
l (in
>>>> essence what the IE register should be for the HSP shared interrupt ow=
ned by
>>>> the kernel) and serve only those mailboxes owned by kernel. Note that =
there
>>>> is no reset for HSP in Xavier, and the IE register contents may be sta=
le.
>>> Would it be safe to clear all of the IE registers to 0 on driver probe?
>>> I seem to remember trying to do that and getting similar behaviour to
>>> what I describe above, namely that interrupts on the SPE weren't workin=
g
>>> anymore. I concluded that the IE register must be shared between the
>>> various processors, even though that's somewhat suprising given that
>>> there is no way to synchronize accesses to those registers, so their
>>> programming would be somewhat up to chance.
>>>
>>> Do you know any more about these registers? If they are indeed separate
>>> for each processor, it should be fairly easy to keep track of the
>>> mailboxes used by the kernel and process only those. Again I don't know
>>> how exactly to distinguish between TX and RX mailboxes because they all
>>> start out the same and only their use defines which direction they go.
>>> Currently this works because we program them as consumers by default.
>>> That means we enable the FULL interrupts but keep EMPTY interrupts
>>> disabled until a message in transmitted on the mailbox, at which point
>>> we enable the EMPTY interrupt. I suppose at that point we should also
>>> disable the FULL interrupt, given the above discussion.
>>>
>>>> And lastly, if we want to support only Xavier and later, perhaps we sh=
ould
>>>> be more clear in the bindings? There are no mailbox-specific interrupt
>>>> enable registers available on Parker and your design relies on them.
>>> That was certainly not the intention. I thought I had seen the per-
>>> mailbox interrupt enable registers also in Tegra186 documentation, but
>>> after double-checking they're indeed not there. I don't think the drive=
r
>>> currently "relies" on them because it uses them in addition to the
>>> HSP_IE registers. I suppose that accessing them might cause aborts on
>>> Tegra186 if they don't exist, though.
>>>
>>> I'm not entirely clear on what the advantages are of using the per-
>>> mailbox registers, or how they are supposed to be used. The existing
>>> documentation doesn't really explain how these are supposed to be used
>>> either, so I was mostly just going by trial and error.
>>>
>>> Do you know anything more on how to use these registers? I can easily
>>> make them Tegra194 specific in the code, but if they're aren't any clea=
r
>>> advantages, it might just be easier to stick with HSP_IE programming
>>> only.
>>>
>>> Thierry

