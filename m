Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FDEC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C872170A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P9unB44V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C872170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeHHJAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:00:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65369 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeHHJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533710528; x=1565246528;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MCdDi/hDQMkRCwzec2oTbxJEAEtXU0+hcY2+p3/T8F8=;
  b=P9unB44VpRlAn9uldmHamjFQt2g5dWYDqS+t1h3DOfbKnEpcxgogCIG2
   rrxH3cO/V+BAfAOoFNJckItZYXYwuhKCKn932yBstjeINiYRY0NamiMwc
   gXGNQkFV0mZqWKl3RwWp3ixTIbin3jluBVe22pWJVCJxT+qr6joT0GSPY
   qdti+GlthfWFKaV26y2Id1KYc3TfNBj0RS+dHI7pGsljTwiFFvBMnN9dC
   1/+2Mzdfochaa/kf0qnuJyYOhpb0XZMshHVPVP94EzI6uinVXclpxt/d5
   +F3RouGWozQMANieTm6winleGFpuET26+oToiUh06CPAIUrymPNcZhuqN
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,456,1526313600"; 
   d="scan'208";a="190907019"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2018 14:42:07 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Aug 2018 23:29:46 -0700
Received: from ch8yk72.ad.shared (HELO [10.86.56.196]) ([10.86.56.196])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Aug 2018 23:42:07 -0700
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
 documentation
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <4ceba1c7-f385-a995-2037-12883cd963ff@wdc.com>
Date:   Tue, 7 Aug 2018 23:42:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/18 7:17 PM, Palmer Dabbelt wrote:
> On Mon, 06 Aug 2018 13:59:48 PDT (-0700), robh+dt@kernel.org wrote:
>> On Thu, Aug 2, 2018 at 4:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>>>
>>> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
>>>> From: Palmer Dabbelt <palmer@dabbelt.com>
>>>>
>>>> This patch adds documentation for the platform-level interrupt
>>>> controller (PLIC) found in all RISC-V systems.  This interrupt
>>>> controller routes interrupts from all the devices in the system to each
>>>> hart-local interrupt controller.
>>>>
>>>> Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
>>>> want to change how we're specifying holes in the hart list.
>>>>
>>>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>>>> [hch: various fixes and updates]
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>> ---
>>>>    .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
>>>>    1 file changed, 57 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>>>> new file mode 100644
>>>> index 000000000000..c756cd208a93
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>>>> @@ -0,0 +1,57 @@
>>>> +SiFive Platform-Level Interrupt Controller (PLIC)
>>>> +-------------------------------------------------
>>>> +
>>>> +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
>>>> +(PLIC) high-level specification in the RISC-V Privileged Architecture
>>>> +specification.  The PLIC connects all external interrupts in the system to all
>>>> +hart contexts in the system, via the external interrupt source in each hart.
>>>> +
>>>> +A hart context is a privilege mode in a hardware execution thread.  For example,
>>>> +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
>>>> +privilege modes per hart; machine mode and supervisor mode.
>>>> +
>>>> +Each interrupt can be enabled on per-context basis. Any context can claim
>>>> +a pending enabled interrupt and then release it once it has been handled.
>>>> +
>>>> +Each interrupt has a configurable priority. Higher priority interrupts are
>>>> +serviced first. Each context can specify a priority threshold. Interrupts
>>>> +with priority below this threshold will not cause the PLIC to raise its
>>>> +interrupt line leading to the context.
>>>> +
>>>> +While the PLIC supports both edge-triggered and level-triggered interrupts,
>>>> +interrupt handlers are oblivious to this distinction and therefore it is not
>>>> +specified in the PLIC device-tree binding.
>>>> +
>>>> +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
>>>> +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
>>>> +specific memory layout, which is documented in chapter 8 of the SiFive U5
>>>> +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
>>>> +
>>>> +Required properties:
>>>> +- compatible : "sifive,plic0"
> 
> I think there was a thread bouncing around somewhere where decided to pick the
> official name of the compatible string to be "sifive,plic-1.0".  The idea here
> is that the PLIC is compatible across all of SiFive's current implementations,
> but there's some limitations in the memory map that will probably cause us to
> spin a version 2 at some point so we want major version number.  The minor
> number is just in case we find some errata in the PLIC.
> 
>>>> +- #address-cells : should be <0>
>>>> +- #interrupt-cells : should be <1>
>>>> +- interrupt-controller : Identifies the node as an interrupt controller
>>>> +- reg : Should contain 1 register range (address and length)
>>>
>>> The one in the real device tree has two entries.
>>> reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;
>>>
>>> Is it intentional or just incorrect entry left over from earlier days?
>>
>>>> +             reg = <0xc000000 0x4000000>;
>>
>> Looks to me like one has #size-cells and #address-cells set to 2 and
>> the example is using 1.
> 
> Yes.  For some background on how this works: we have a hardware generator that
> has a tree-of-busses abstraction, and each device is attached to some point on
> that tree.  When a device gets attached to the bus, we also generate a device
> tree entry.  For whatever system I generated the example PLIC device tree entry
> from, it must have been attached to a bus with addresses of 32 bits or less,
> which resulted in #address-cells and #size-cells being 1.
> 

Thanks Palmer for the detailed explanation.

> Christoph has a HiFive Unleashed, which has a fu540-c000 on it, which is
> probably not what I generated as an example -- the fu540-c000 is a complicated
> configuration, when I mess around with the hardware I tend to use simple ones
> as I'm not really a hardware guy.  I suppose the bus that the PLIC is hanging
> off on the fu540-c000 has addresses wider than 32 bits.  This makes sense, as
> the machine has 8GiB of memory and the PLIC is on a bus that's closer to the
> core than the DRAM is, so it'd need at least enough address bits to fit 8GiB.
> 
> Is the inconsistency a problem?  I generally write device tree handling code to
> just respect whatever #*-fields says and don't consider that part of the
> specification of the binding.  I don't mind changing the example to have
> #size-fields and #address-fields to be 2, but since it's not wrong I also don't
> see any reason to change it.  We do have 32-bit devices with PLICs, and while
> they're not Linux-capable devices we're trying to adopt the Linux device tree
> bindings through the rest of the RISC-V software ecosystem as they tend to be
> pretty well thought out.
> 

Sounds good to me. IMHO, the inconsistencies and its reasoning are well 
documented which is good enough for now.

Regards,
Atish
