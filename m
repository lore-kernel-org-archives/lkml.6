Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3CBC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796B52087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796B52087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeJETcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:32:32 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:60536 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeJETcc (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 5 Oct 2018 15:32:32 -0400
Received: from ziggy.stardust ([37.223.143.164])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 05 Oct 2018 14:33:57 +0200
Subject: Re: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
To:     Marc Zyngier <marc.zyngier@arm.com>, matthias.bgg@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de,
        jason@lakedaemon.net, robert.richter@cavium.com
Cc:     suzuki.poulose@arm.com, shankerd@codeaurora.org,
        xiexiuqi@huawei.com, Dave.Martin@arm.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180912095232.2110-1-matthias.bgg@kernel.org>
 <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
 <95733d12-ee1d-9874-16a7-c614cc0ce8cd@arm.com>
From:   Matthias Brugger <mbrugger@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mbrugger@suse.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRT9gkSARAApxtQ4zUMC512
 kZ+gCiySFcIF/mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8K
 RP6Abo35YqBx3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIA
 LC9lAsv9oa+2L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8zn
 f//Z4BxtlTw3SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+
 nrNRDs7B35y/J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYA
 Eg2NJnqaKg3SCJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmO
 Ad/wxGLJ0xmAye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifq
 v6hernMQXGxs+lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeB
 lqhtMoZ0kDw2C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxy
 AtL+L+Lh1Sni7w3HBk1EJvUAEQEAAcLBXwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8Qnd
 EACuN16mvivnWwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2
 jmcg6QytgqVum6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB
 +Fw7CArNtUtLlc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR
 1rQNZWjNCpB2Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7v
 ZB0uo9CzCSm3I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu4
 8UjmUSsTwWC3HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX
 50OP+/11ArV0cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGf
 XM8DY1aFdU79pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp
 3mlIFZ6fsEKIAN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHc
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <8ef6b381-e170-30de-ad0e-fae8ccf189e5@suse.com>
Date:   Fri, 5 Oct 2018 14:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <95733d12-ee1d-9874-16a7-c614cc0ce8cd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2018 12:55, Marc Zyngier wrote:
> Hi Matthias,
> 
> On 04/10/18 23:11, Matthias Brugger wrote:
>> Friendly reminder, if anyone has any comment on the patch :)
>>
>> On 9/12/18 11:52 AM, matthias.bgg@kernel.org wrote:
>>> From: Matthias Brugger <mbrugger@suse.com>
>>>
>>> Some hardware does not implement two-level page tables so that
>>> the amount of contigious memory needed by the baser is bigger
>>> then the zone order. This is a known problem on Cavium Thunderx
>>> with 4K page size.
>>>
>>> We fix this by adding an errata which allocates the memory early
>>> in the boot cycle, using the memblock allocator.
>>>
>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>> ---
>>>   arch/arm64/Kconfig               | 12 ++++++++
>>>   arch/arm64/include/asm/cpucaps.h |  3 +-
>>>   arch/arm64/kernel/cpu_errata.c   | 33 +++++++++++++++++++++
>>>   drivers/irqchip/irq-gic-v3-its.c | 50 ++++++++++++++++++++------------
>>>   4 files changed, 79 insertions(+), 19 deletions(-)
> 
> My only comment would be to state how much I dislike both the HW and the
> patch... ;-) The idea that we have some erratum that depends on the page size
> doesn't feel good at all.
> 

Well ugly HW needs ugly patches ;-)

>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 1b1a0e95c751..dfd9fe08f0b2 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -597,6 +597,18 @@ config QCOM_FALKOR_ERRATUM_E1041
>>>           If unsure, say Y.
>>>   +config CAVIUM_ALLOC_ITS_TABLE_EARLY
>>> +    bool "Cavium Thunderx: Allocate the its table early"
>>> +    default y
>>> +    depends on ARM64_4K_PAGES && FORCE_MAX_ZONEORDER < 13
> 
> Here's a though: Why don't we ensure that FORCE_MAX_ZONEORDER is such as we
> could always allocate the same amount of memory, no matter what the page size
> is? That, or bump FORCE_MAX_ZONEORDER to 13 if the kernel includes support for TX1.
> 

Bumping FORCE_MAX_ZONEORDER when TX1 is supported was proposed here:
https://patchwork.kernel.org/patch/6322281/

To bring in some more history, the CMA approach ended with this discussion:
https://patchwork.kernel.org/patch/9888041/

> Any of this of course requires buy-in from the arm64 maintainers, as this is
> quite a departure from the way things work so far.
> 

With my distribution head on, I would prefer a solution that does not change
FORCE_MAX_ZONEORDER. That's how I came to the idea providing a third solution to
the same problem :)

Regards,
Matthias
