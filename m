Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F960C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420C720675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OryP7Cio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394518AbfBMT75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:59:57 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61262 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfBMT75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550087996; x=1581623996;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QpD3dBmdLNraB7mBIU31YrmXvC/z0J19nvCXFBllLiI=;
  b=OryP7CioQCJwLZ6vapr+BGhNFN6KQvJTTwaXkCHDQI5LVJX6VeZ5pVmI
   NEc7kdG5/0OhNi5SU0VXQzpZ1h8QYWv0PuhRpTMHsaTkLBRPi7p55lYJf
   RUx7ONf1N0A1bGURvVS9o5Rxp9HdVjrk2AtdDpY8RKOIq40jKssadMUbV
   vwfXUgN+8vEOmmR6G3fsG1iwXgE+uXnw+VLk7Ss+R5aCpasaJa2CawZfH
   HruDCGVWdDl/nWS2FHiobYfAnEeUCAFkUZAGN+iajYVvQizSdy99ytLbe
   bv+8g55D6T2D5BRR1cEv2NqLrcICfOLVtlLazFWqVytHsuwIpBlhu6nsD
   g==;
X-IronPort-AV: E=Sophos;i="5.58,366,1544457600"; 
   d="scan'208";a="206317894"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 03:59:56 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 13 Feb 2019 11:38:29 -0800
Received: from 1w4mj72.ad.shared (HELO [10.86.48.145]) ([10.86.48.145])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2019 11:59:56 -0800
Subject: Re: [v4 PATCH 8/8] RISC-V: Assign hwcap as per comman capabilities.
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
 <1549969812-22502-9-git-send-email-atish.patra@wdc.com>
 <20190212112534.GB28278@localhost>
 <61766631-42f4-ec25-3b5c-ae892da44ccb@wdc.com>
 <20190213084442.GD28278@localhost>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <e078563c-6da8-6a33-9a9e-1550504d7b1d@wdc.com>
Date:   Wed, 13 Feb 2019 11:59:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213084442.GD28278@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 12:44 AM, Johan Hovold wrote:
> On Tue, Feb 12, 2019 at 11:58:10AM -0800, Atish Patra wrote:
>> On 2/12/19 3:25 AM, Johan Hovold wrote:
>>> On Tue, Feb 12, 2019 at 03:10:12AM -0800, Atish Patra wrote:
>>>> Currently, we set hwcap based on first valid hart from DT. This may not
>>>> be correct always as that hart might not be current booting cpu or may
>>>> have a different capability.
>>>>
>>>> Set hwcap as the capabilities supported by all possible harts with "okay"
>>>> status.
>>>>
>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>> ---
>>>>    arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
>>>>    1 file changed, 22 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>>> index e7a4701f..a1e4fb34 100644
>>>> --- a/arch/riscv/kernel/cpufeature.c
>>>> +++ b/arch/riscv/kernel/cpufeature.c
>>>> @@ -20,6 +20,7 @@
>>>>    #include <linux/of.h>
>>>>    #include <asm/processor.h>
>>>>    #include <asm/hwcap.h>
>>>> +#include <asm/smp.h>
>>>>    
>>>>    unsigned long elf_hwcap __read_mostly;
>>>>    #ifdef CONFIG_FPU
>>>> @@ -42,28 +43,30 @@ void riscv_fill_hwcap(void)
>>>>    
>>>>    	elf_hwcap = 0;
>>>>    
>>>> -	/*
>>>> -	 * We don't support running Linux on hertergenous ISA systems.  For
>>>> -	 * now, we just check the ISA of the first "okay" processor.
>>>> -	 */
>>>>    	for_each_of_cpu_node(node) {
>>>> -		if (riscv_of_processor_hartid(node) >= 0)
>>>> -			break;
>>>> -	}
>>>> -	if (!node) {
>>>> -		pr_warn("Unable to find \"cpu\" devicetree entry\n");
>>>> -		return;
>>>> -	}
>>>> +		unsigned long this_hwcap = 0;
>>>>    
>>>> -	if (of_property_read_string(node, "riscv,isa", &isa)) {
>>>> -		pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>>>> -		of_node_put(node);
>>>> -		return;
>>>> -	}
>>>> -	of_node_put(node);
>>>> +		if (riscv_of_processor_hartid(node) < 0)
>>>> +			continue;
>>>>
>>
>>>> -	for (i = 0; i < strlen(isa); ++i)
>>>> -		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
>>>> +		if (of_property_read_string(node, "riscv,isa", &isa)) {
>>>> +			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>>>> +			return;
>>>
>>> Did you want "continue" here to continue processing the other harts?
>>
>> Hmm. If a cpu node doesn't have isa in DT, that means DT is wrong. A
>> "continue" here will let user space use other harts just with a warning
>> message?
>>
>> Returning here will not set elf_hwcap which forces the user to fix the
>> DT. I am not sure what should be the defined behavior in this case.
>>
>> Any thoughts ?
> 
> The problem is that the proposed code might still set elf_hwcap -- it
> all depends on the order of the hart nodes in dt (i.e. it will only be
> left unset if the first node is malformed).
> 
> For that reason, I'd say it's better to either bail out (hard or at
> least with elf_hwcap unset) or to continue processing the other nodes.
> 
> The former might break current systems with malformed dt, though.
> 
> And since the harts are expected to have the same ISA, continuing the
> processing while warning and ignoring the malformed node might be
> acceptable.
> 

ok. I will change it to continue unless somebody else has objection.

Thanks for the review.

Regards,
Atish
> Johan
> 

