Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C2C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4EF2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hO1CfC7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4EF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeKFJed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:34:33 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55865 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeKFJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1541463133; x=1572999133;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8a1aL70reaGLohkAFR3PuOjUHcIqIcEdntS639e0iiE=;
  b=hO1CfC7NA2vmAruNVAodJ9XDPoOgYt6ogpSakrY0t47HZ4Rp8XxxclsU
   72+JUlt4BjX8/AteVwWG7x8/Zx0sMVuRCt3zTu7mEVDQLBP3OMiGmsSMa
   d20p/rMDecCYKuBt/N40himc6s832fy5IQn0r0+W8LtMt1jcSvENZB3jx
   eD6gfq5KdLyZCKn1iYUhLzUh3ec9vr4odV0r71BvHCHRJkCRU+Jem17+O
   XOy+Q2uVvW2nS86XCVp57WWk76g8342KyplVWEyky6rAtpJiSrCmfNYVT
   A7yBWkLyAHKK5CDijEFsnWMly1w89IcUNoQwl35m5TDOws4dJw6ienjEU
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,469,1534780800"; 
   d="scan'208";a="95274834"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2018 08:12:12 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 05 Nov 2018 15:55:50 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.69.187]) ([10.111.69.187])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Nov 2018 16:12:12 -0800
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        Zong Li <zong@andestech.com>
References: <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
 <mhng-799bd6f4-e4af-481e-90d8-bdc0e30f2530@palmer-si-x1c4>
 <CAL_JsqJOxdE=gD4MyKuL5XZ57Z6UdM4_SU4qs26BNz6YcqM76A@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <8b502dca-bf5f-50b8-e1b2-997c6e2ca260@wdc.com>
Date:   Mon, 5 Nov 2018 16:12:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJOxdE=gD4MyKuL5XZ57Z6UdM4_SU4qs26BNz6YcqM76A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 12:11 PM, Rob Herring wrote:
> On Mon, Nov 5, 2018 at 1:39 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Fri, 02 Nov 2018 06:09:39 PDT (-0700), robh+dt@kernel.org wrote:
>>> On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> wrote:
>>>>
>>>> Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
>>>> But it doesn't need a separate thread node for defining SMT systems.
>>>> Multiple cpu phandle properties can be parsed to identify the sibling
>>>> hardware threads. Moreover, we do not have cluster concept in RISC-V.
>>>> So package is a better word choice than cluster for RISC-V.
>>>
>>> There was a proposal to add package info for ARM recently. Not sure
>>> what happened to that, but we don't need 2 different ways.
>>>
>>> There's never going to be clusters for RISC-V? What prevents that?
>>> Seems shortsighted to me.
>>>
>>>>
>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>> ---
>>>>   .../devicetree/bindings/riscv/topology.txt         | 154 +++++++++++++++++++++
>>>>   1 file changed, 154 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/riscv/topology.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/riscv/topology.txt b/Documentation/devicetree/bindings/riscv/topology.txt
>>>> new file mode 100644
>>>> index 00000000..96039ed3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/riscv/topology.txt
>>>> @@ -0,0 +1,154 @@
>>>> +===========================================
>>>> +RISC-V cpu topology binding description
>>>> +===========================================
>>>> +
>>>> +===========================================
>>>> +1 - Introduction
>>>> +===========================================
>>>> +
>>>> +In a RISC-V system, the hierarchy of CPUs can be defined through following nodes that
>>>> +are used to describe the layout of physical CPUs in the system:
>>>> +
>>>> +- packages
>>>> +- core
>>>> +
>>>> +The cpu nodes (bindings defined in [1]) represent the devices that
>>>> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
>>>> +Simultaneous multi-threading (SMT) systems can also represent their topology
>>>> +by defining multiple cpu phandles inside core node. The details are explained
>>>> +in paragraph 3.
>>>
>>> I don't see a reason to do this differently than ARM. That said, I
>>> don't think the thread part is in use on ARM, so it could possibly be
>>> changed.
>>>
>>>> +
>>>> +The remainder of this document provides the topology bindings for ARM, based
>>>
>>> for ARM?
>>>
>>>> +on the Devicetree Specification, available from:
>>>> +
>>>> +https://www.devicetree.org/specifications/
>>>> +
>>>> +If not stated otherwise, whenever a reference to a cpu node phandle is made its
>>>> +value must point to a cpu node compliant with the cpu node bindings as
>>>> +documented in [1].
>>>> +A topology description containing phandles to cpu nodes that are not compliant
>>>> +with bindings standardized in [1] is therefore considered invalid.
>>>> +
>>>> +This cpu topology binding description is mostly based on the topology defined
>>>> +in ARM [2].
>>>> +===========================================
>>>> +2 - cpu-topology node
>>>
>>> cpu-map. Why change this?
>>>
>>> What I would like to see is the ARM topology binding reworked to be
>>> common or some good reasons why it doesn't work for RISC-V as-is.
>>
>> I think it would be great if CPU topologies were not a RISC-V specific thing.
>> We don't really do anything different than anyone else, so it'd be great if we
>> could all share the same spec and code.  Looking quickly at the ARM cpu-map
>> bindings, I don't see any reason why we can't just use the same thing on RISC-V
>> -- it's not quite how I'd do it, but I don't think the differences are worth
>> having another implementation.  Mechanically I'm not sure how to do this:
>> should there just be a "Documentation/devicetree/bindings/cpu-map.txt"?
> 
> Yes, but ".../bindings/cpu/cpu-topology.txt".
> 
> And if we need $arch extensions, they can be moved there. (Really, I'd
> like to get rid of /bindings/$arch/* except for maybe a few things.)
> 
>> If everyone is OK with that then I vote we just go ahead and genericise the ARM
>> "cpu-map" stuff for CPU topology.  Sharing the implementation looks fairly
>> straight-forward as well.
> 
+1 for a common code base. I am happy to take it up if nobody else has 
not already started working on it.

Is there a ARM hardware test farm that can be used to test such changes?

Regards,
Atish
