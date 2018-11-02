Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D06C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749D72081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nMVF/ayN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749D72081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeKCFmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:42:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7957 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeKCFmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1541190872; x=1572726872;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pW4aDx5pzVmJiBqjnCTvIlhWDrIUp+KXcHKEyjPl4kk=;
  b=nMVF/ayNlVipyzki7CaBmYc2ckypGROeEsOLGkKh4hh1R2WgIcrf8s0Y
   uQvRbi5z/NUfv/J9oQ7jc8cbatro0EoBzA5Z1lzkmainWFMoxKhlb/dPO
   pYQH0WoFqjg7SocZpQeOX7PXaxjERE+mRpUFXC5ZVXCAzXvqgkYPrWCkv
   qn4e3ku/90D5vbHL2rp7qFvJc5aUkRLoWnzyxjsAZTpLE80ByDmlJS4Wr
   ioTWUrxTbQGXXXrnT7TPrO2iIuc/LjZuKa21wU9CLN3X3zBuloWFrly7t
   1lW7nEbljcNFbAnbOLuB5d8RnevFndXGrFXZBiRyndkN33kE5KGckW9aX
   A==;
X-IronPort-AV: E=Sophos;i="5.54,457,1534780800"; 
   d="scan'208";a="191156188"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2018 04:34:31 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Nov 2018 13:18:01 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.69.187]) ([10.111.69.187])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Nov 2018 13:34:07 -0700
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        Zong Li <zong@andestech.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <1541113468-22097-2-git-send-email-atish.patra@wdc.com>
 <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <954ec7be-f7ba-4e00-70fe-130cb4b84e61@wdc.com>
Date:   Fri, 2 Nov 2018 13:34:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 6:09 AM, Rob Herring wrote:
> On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
>> But it doesn't need a separate thread node for defining SMT systems.
>> Multiple cpu phandle properties can be parsed to identify the sibling
>> hardware threads. Moreover, we do not have cluster concept in RISC-V.
>> So package is a better word choice than cluster for RISC-V.
> 
> There was a proposal to add package info for ARM recently. Not sure
> what happened to that, but we don't need 2 different ways.
> 
> There's never going to be clusters for RISC-V? What prevents that?
> Seems shortsighted to me.
> 

Agreed. My intention was to keep it simple at first go.
If package node is added, that would work for us as well.

>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   .../devicetree/bindings/riscv/topology.txt         | 154 +++++++++++++++++++++
>>   1 file changed, 154 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/riscv/topology.txt
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/topology.txt b/Documentation/devicetree/bindings/riscv/topology.txt
>> new file mode 100644
>> index 00000000..96039ed3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/riscv/topology.txt
>> @@ -0,0 +1,154 @@
>> +===========================================
>> +RISC-V cpu topology binding description
>> +===========================================
>> +
>> +===========================================
>> +1 - Introduction
>> +===========================================
>> +
>> +In a RISC-V system, the hierarchy of CPUs can be defined through following nodes that
>> +are used to describe the layout of physical CPUs in the system:
>> +
>> +- packages
>> +- core
>> +
>> +The cpu nodes (bindings defined in [1]) represent the devices that
>> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
>> +Simultaneous multi-threading (SMT) systems can also represent their topology
>> +by defining multiple cpu phandles inside core node. The details are explained
>> +in paragraph 3.
> 
> I don't see a reason to do this differently than ARM. That said, I
> don't think the thread part is in use on ARM, so it could possibly be
> changed.
> 
>> +
>> +The remainder of this document provides the topology bindings for ARM, based
> 
> for ARM?
> 

Sorry for the typo.

>> +on the Devicetree Specification, available from:
>> +
>> +https://www.devicetree.org/specifications/
>> +
>> +If not stated otherwise, whenever a reference to a cpu node phandle is made its
>> +value must point to a cpu node compliant with the cpu node bindings as
>> +documented in [1].
>> +A topology description containing phandles to cpu nodes that are not compliant
>> +with bindings standardized in [1] is therefore considered invalid.
>> +
>> +This cpu topology binding description is mostly based on the topology defined
>> +in ARM [2].
>> +===========================================
>> +2 - cpu-topology node
> 
> cpu-map. Why change this?
> 
To my ears, it felt a better name. But I don't mind dropping it in favor 
of cpu-map if we are going to standardize cpu-map for both ARM & RISC-V.

> What I would like to see is the ARM topology binding reworked to be
> common or some good reasons why it doesn't work for RISC-V as-is.
> 

IMHO, ARM topology can be reworked and put it in a common place so that 
RISC-V can leverage that.

My intention for this RFC patch was to start the ball rolling on cpu 
topology in RISC-V and see if DT approach is fine with everybody. I 
would be happy to see ARM code to move it to a common code base where 
RISC-V can reuse it.


Regards,
Atish
> Rob
> 

