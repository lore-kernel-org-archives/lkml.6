Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeE2MVG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:21:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58734 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933583AbeE2MVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:21:02 -0400
Subject: Re: linux-next: manual merge of the irqchip tree with the arm-soc
 tree
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
References: <20180529155257.5ae48830@canb.auug.org.au>
 <1bedc0b7-21f9-1e15-a11c-3de06e81b5ba@st.com>
 <c306fbd9-21d9-5345-e820-52bc23d1b7c7@arm.com>
 <b01f3226-5bb8-071a-e825-73bec913ffa8@st.com>
 <2d647302-0be8-555b-8063-06b0d2d72772@arm.com>
 <b8fa6cc9-5d73-81a2-25b8-f0c858ef0c62@st.com>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <d1e7a14d-ea49-fc8e-a95c-2b4257096187@st.com>
Date: Tue, 29 May 2018 14:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b8fa6cc9-5d73-81a2-25b8-f0c858ef0c62@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 10:55 AM, Alexandre Torgue wrote:
> 
> 
> On 05/29/2018 10:39 AM, Marc Zyngier wrote:
>> On 29/05/18 09:16, Alexandre Torgue wrote:
>>> Hi Marc
>>>
>>> On 05/29/2018 09:47 AM, Marc Zyngier wrote:
>>>> On 29/05/18 08:41, Alexandre Torgue wrote:
>>>>> Hi Stephen
>>>>>
>>>>> On 05/29/2018 07:52 AM, Stephen Rothwell wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Today's linux-next merge of the irqchip tree got a conflict in:
>>>>>>
>>>>>>      arch/arm/boot/dts/stm32mp157c.dtsi
>>>>>>
>>>>>> between commit:
>>>>>>
>>>>>>      3c00436fdb20 ("ARM: dts: stm32: add USBPHYC support to 
>>>>>> stm32mp157c")
>>>>>>
>>>>>> from the arm-soc tree and commit:
>>>>>>
>>>>>>      5f0e9d2557d7 ("ARM: dts: stm32: Add exti support for 
>>>>>> stm32mp157c")
>>>>>>
>>>>>> from the irqchip tree.
>>>>>>
>>>>>> I fixed it up (see below) and can carry the fix as necessary. This
>>>>>> is now fixed as far as linux-next is concerned, but any non trivial
>>>>>> conflicts should be mentioned to your upstream maintainer when 
>>>>>> your tree
>>>>>> is submitted for merging.  You may also want to consider cooperating
>>>>>> with the maintainer of the conflicting tree to minimise any 
>>>>>> particularly
>>>>>> complex conflicts.
>>>>>>
>>>>>
>>>>> Thanks for the fix (I will reorder nodes in a future patch). My 
>>>>> opinion
>>>>> is that all STM32 DT patches should come through my STM32 tree. It 
>>>>> is my
>>>>> role to fix this kind of conflicts. I thought it was a common rule
>>>>> (driver patches go to sub-system maintainer tree and DT to the Machine
>>>>> maintainer). For incoming next-series which contain DT+driver 
>>>>> patches I
>>>>> will indicate clearly that I take DT patch. I'm right ?
>>>> Happy to oblige. Can you make sure you sync up with Ludovic and define
>>>> what you want to do?
>>>
>>> Sorry I don't understand your reply. I just say that for series
>>> containing DT patches + drivers patches, to my point of view it is more
>>> safe that driver patches are taken by sub-system maintainer (you in this
>>> case) and that I take DT patches in my tree.
>> And I'm happy to let you deal with these patches. I'm just asking you
>> sync with Ludovic to split the series on whichever boundary you wish to
>> enforce.
> ok
> 
>>
>>>> In the meantime, I'm dropping the series altogether.
>>>>
>>> Why? We could keep it as Stephen fixed the merge issue.
>> Well, you seem to have a strong opinion about who deals with what. I'll
>> let Ludovic repost what you and him decide should go via the irqchip 
>> tree.
> 
> It's not a "strong" opinion just my point of view and maybe not the good 
> one. I thought that's the way of working was like I explained. If you 
> prefer 2 series (one for driver patches and another one for DT patches) 
> I will be happy with that.
> 
> Ludovic, what is your opinion ?

Hi everybody

For this serie, I think we could keep like that with
Stephen fix. New stm32 irqchip will be integrated (thanks Marc)
with no conflict with usb (thanks Stephen).

For next series, we may split driver and DT to avoid misunderstanding.

BR
Ludo

> 
> Regards
> Alexandre
> 
>>
>> Thanks,
>>
>>     M.
>>
