Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeEQN1k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:27:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21185 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbeEQN1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:27:39 -0400
Subject: Re: [PATCH v2 2/2] powerpc/32be: use stmw/lmw for registers
 save/restore in asm
To: Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <7fbae252f24ec4d30f52f57a549901fa3f799f8f.1523984745.git.christophe.leroy@c-s.fr>
 <a94e38e1dbe0c38ce5b363fac29ab6e65fd9985a.1523984745.git.christophe.leroy@c-s.fr>
 <87zi0ymqj6.fsf@concordia.ellerman.id.au>
 <20180517131550.GR17342@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <74ce3f30-6c06-e884-f1ea-1539edbf1a74@c-s.fr>
Date: Thu, 17 May 2018 15:27:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517131550.GR17342@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/05/2018 à 15:15, Segher Boessenkool a écrit :
> On Thu, May 17, 2018 at 10:10:21PM +1000, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> arch/powerpc/Makefile activates -mmultiple on BE PPC32 configs
>>> in order to use multiple word instructions in functions entry/exit
>>
>> True, though that could be a lot simpler because the MULTIPLEWORD value
>> is only used for PPC32, which is always big endian. I'll send a patch
>> for that.
> 
> Do you mean in the kernel?  Many 32-bit processors can do LE, and many
> do not implement multiple or string insns in LE mode.
> 
>>> The patch does the same for the asm parts, for consistency
>>>
>>> On processors like the 8xx on which insn fetching is pretty slow,
>>> this speeds up registers save/restore
>>
>> OK. I've always heard that they should be avoided, but that's coming
>> from 64-bit land.
>>
>> I guess we've been enabling this for all 32-bit targets for ever so it
>> must be a reasonable option.
> 
> On 603, load multiple (and string) are one cycle slower than doing all the
> loads separately, and store is essentially the same as separate stores.
> On 7xx and 7xxx both loads and stores are one cycle slower as multiple
> than as separate insns.

That's in theory when the instructions are already in the cache.

But loading several instructions into the cache takes time.

Christophe

> 
> load/store multiple are nice for saving/storing registers.
> 
> 
> Segher
> 
