Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230CC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4D520827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4D520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbeKFT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:29:59 -0500
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:11314 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbeKFT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:29:59 -0500
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wA6A3Kkv051876;
        Tue, 6 Nov 2018 12:03:22 +0200 (EET)
X-AuditID: 8b5b9d4d-91bff70000000e62-72-5be166e76bcb
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id A4.A8.03682.7E661EB5; Tue,  6 Nov 2018 12:03:19 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wA6A3HlQ008115;
        Tue, 6 Nov 2018 12:03:17 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 06 Nov 2018 12:03:17 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Damien.LeMoal@wdc.com,
        alankao@andestech.com, zong@andestech.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, atish.patra@wdc.com,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
Organization: FORTH
In-Reply-To: <mhng-799bd6f4-e4af-481e-90d8-bdc0e30f2530@palmer-si-x1c4>
References: <mhng-799bd6f4-e4af-481e-90d8-bdc0e30f2530@palmer-si-x1c4>
Message-ID: <9e77989d6b868d914bc328401cd64557@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsXSHc2orPs87WG0waIeM4ttS1azWrR8eMdq
        sWjFdxaL1vZvTBbzj5xjtTg9YRGTxeVdc9gstn1uYbNYev0ik8XmCQtYLVr3HmG32LxpKrPF
        85W9bA68HntOz2L2WDNvDaPH1N9nWDw2r9Dy2LSqk83j3blz7B6bl9R7XGq+zu7xeZOcR/uB
        bqYArigum5TUnMyy1CJ9uwSujGPv1zAXfFOsOLJ0FnMD4zHpLkZODgkBE4n9Z3axdDFycQgJ
        HGGUmHOljxnCOcgo8e37WzaIKlOJ2Xs7GUFsXgFBiZMzn7CA2MwCFhJTr+xnhLDlJZq3zmYG
        sVkEVCWmtvaBxdkENCXmXzoIVi8ioCZxqOkII8gCZoErTBKH9k8FSwgLuEl8uPkIrJlfQFji
        092LrCA2p4C7xK/zf8BqhIBqXt+/ydTFyAF0hIvE/QM6ELepSHz4/YAdxBYVUJZ4cWI66wRG
        oVlITp2F5NRZSE5dwMi8ilEgscxYLzO5WC8tv6gkQy+9aBMjOO7m+u5gPLfA/hCjAAejEg8v
        R8GDaCHWxLLiytxDjBIczEoivEpsQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8h1+EBwkJpCeW
        pGanphakFsFkmTg4pRoYzaqbDX9/9jb773f0tABHWsOOrEc8Tw2nlTr+vqj8zPP5TYfSDS/3
        unOc5es59eiNXJaRxTUPf9/mug+LJ+iefnI81yXvLtut+EtTjVR8H4ef6WRckmjZ0LU2NXXK
        NDYbeYkNW59yrXS7sWq6vpD8y43WhS+5T+qGrZb5JLpW8dL87ZeluWInKLEUZyQaajEXFScC
        ADT1tbO3AgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2018-11-05 21:38, Palmer Dabbelt έγραψε:
> On Fri, 02 Nov 2018 06:09:39 PDT (-0700), robh+dt@kernel.org wrote:
>> On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> 
>> wrote:
>>> 
>>> Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
>>> But it doesn't need a separate thread node for defining SMT systems.
>>> Multiple cpu phandle properties can be parsed to identify the sibling
>>> hardware threads. Moreover, we do not have cluster concept in RISC-V.
>>> So package is a better word choice than cluster for RISC-V.
>> 
>> There was a proposal to add package info for ARM recently. Not sure
>> what happened to that, but we don't need 2 different ways.
>> 
>> There's never going to be clusters for RISC-V? What prevents that?
>> Seems shortsighted to me.
>> 
>>> 
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>> ---
>>>  .../devicetree/bindings/riscv/topology.txt         | 154 
>>> +++++++++++++++++++++
>>>  1 file changed, 154 insertions(+)
>>>  create mode 100644 
>>> Documentation/devicetree/bindings/riscv/topology.txt
>>> 
>>> diff --git a/Documentation/devicetree/bindings/riscv/topology.txt 
>>> b/Documentation/devicetree/bindings/riscv/topology.txt
>>> new file mode 100644
>>> index 00000000..96039ed3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/riscv/topology.txt
>>> @@ -0,0 +1,154 @@
>>> +===========================================
>>> +RISC-V cpu topology binding description
>>> +===========================================
>>> +
>>> +===========================================
>>> +1 - Introduction
>>> +===========================================
>>> +
>>> +In a RISC-V system, the hierarchy of CPUs can be defined through 
>>> following nodes that
>>> +are used to describe the layout of physical CPUs in the system:
>>> +
>>> +- packages
>>> +- core
>>> +
>>> +The cpu nodes (bindings defined in [1]) represent the devices that
>>> +correspond to physical CPUs and are to be mapped to the hierarchy 
>>> levels.
>>> +Simultaneous multi-threading (SMT) systems can also represent their 
>>> topology
>>> +by defining multiple cpu phandles inside core node. The details are 
>>> explained
>>> +in paragraph 3.
>> 
>> I don't see a reason to do this differently than ARM. That said, I
>> don't think the thread part is in use on ARM, so it could possibly be
>> changed.
>> 
>>> +
>>> +The remainder of this document provides the topology bindings for 
>>> ARM, based
>> 
>> for ARM?
>> 
>>> +on the Devicetree Specification, available from:
>>> +
>>> +https://www.devicetree.org/specifications/
>>> +
>>> +If not stated otherwise, whenever a reference to a cpu node phandle 
>>> is made its
>>> +value must point to a cpu node compliant with the cpu node bindings 
>>> as
>>> +documented in [1].
>>> +A topology description containing phandles to cpu nodes that are not 
>>> compliant
>>> +with bindings standardized in [1] is therefore considered invalid.
>>> +
>>> +This cpu topology binding description is mostly based on the 
>>> topology defined
>>> +in ARM [2].
>>> +===========================================
>>> +2 - cpu-topology node
>> 
>> cpu-map. Why change this?
>> 
>> What I would like to see is the ARM topology binding reworked to be
>> common or some good reasons why it doesn't work for RISC-V as-is.
> 
> I think it would be great if CPU topologies were not a RISC-V specific
> thing.  We don't really do anything different than anyone else, so
> it'd be great if we could all share the same spec and code.  Looking
> quickly at the ARM cpu-map bindings, I don't see any reason why we
> can't just use the same thing on RISC-V -- it's not quite how I'd do
> it, but I don't think the differences are worth having another
> implementation.  Mechanically I'm not sure how to do this: should
> there just be a "Documentation/devicetree/bindings/cpu-map.txt"?
> 
> If everyone is OK with that then I vote we just go ahead and
> genericise the ARM "cpu-map" stuff for CPU topology.  Sharing the
> implementation looks fairly straight-forward as well.
> 

Please check this out...
https://lkml.org/lkml/2018/11/3/99

It's also non arch-dependent and it can handle the scheduler's 
capabilities
better than cpu-map.
