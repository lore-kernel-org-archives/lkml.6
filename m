Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965741AbeBUPC3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:02:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:58009 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934232AbeBUPC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:02:27 -0500
Subject: Re: [PATCH 0/6] DISCONTIGMEM support for PPC32
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
 <20180221144240.pfu2run3pixt3pzo@latitude>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <a36983ec-5e97-e968-8143-1b2615ea55f8@c-s.fr>
Date: Wed, 21 Feb 2018 16:02:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221144240.pfu2run3pixt3pzo@latitude>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/02/2018 à 15:42, Jonathan Neuschäfer a écrit :
> Hi,
> 
> On Wed, Feb 21, 2018 at 08:06:10AM +0100, Christophe LEROY wrote:
>>
>>
>> Le 20/02/2018 à 17:14, Jonathan Neuschäfer a écrit :
>>> This patchset adds support for DISCONTIGMEM on 32-bit PowerPC. This is
>>> required to properly support the Nintendo Wii's memory layout, in which
>>> there are two blocks of RAM and MMIO in the middle.
>>>
>>> Previously, this memory layout was handled by code that joins the two
>>> RAM blocks into one, reserves the MMIO hole, and permits allocations of
>>> reserved memory in ioremap. This hack didn't work with resource-based
>>> allocation (as used for example in the GPIO driver for Wii[1]), however.
>>>
>>> After this patchset, users of the Wii can either select CONFIG_FLATMEM
>>> to get the old behaviour, or CONFIG_DISCONTIGMEM to get the new
>>> behaviour.
>>
>> My question might me stupid, as I don't know PCC64 in deep, but when looking
>> at page_is_ram() in arch/powerpc/mm/mem.c, I have the feeling the PPC64
>> implements ram by blocks. Isn't it what you are trying to achieve ? Wouldn't
>> it be feasible to map to what's done in PPC64 for PPC32 ?
> 
> Using page_is_ram in __ioremap_caller and the same memblock-based
> approach that's used on PPC64 on PPC32 *should* work, but I think due to
> the following line in initmem_init, it won't:
> 
> 	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, &memblock.memory, 0);

Can't we just fix that ?

Christophe

> 
> 
> Thanks,
> Jonathan Neuschäfer
> 
