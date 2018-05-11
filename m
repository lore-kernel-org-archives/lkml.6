Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEKSyT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:54:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43217 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbeEKSyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:54:16 -0400
Subject: Re: [PATCH] x86: pad assembly functions with INT3
To: David Laight <David.Laight@ACULAB.COM>,
        "'Alexey Dobriyan'" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <20180507213755.GA32406@avx2>
 <20fb84fd5eef4c45b2d38d0290235d5d@AcuMS.aculab.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <5c6762fe-5cbe-42ed-ac4e-a7144b8ef7ad@zytor.com>
Date: Fri, 11 May 2018 11:53:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20fb84fd5eef4c45b2d38d0290235d5d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/18 09:39, David Laight wrote:
> From: Alexey Dobriyan
>> Sent: 07 May 2018 22:38
>>
>> Use INT3 instead of NOP. All that padding between functions is
>> an illegal area, no legitimate code should jump into it.
>>
>> I've checked x86_64 allyesconfig disassembly, all changes looks sane:
>> INT3 is only used after RET or unconditional JMP.
> 
> I thought there was a performance penalty (on at least some cpu)
> depending on the number of and the actual instructions used for padding.
> 
> I believe that is why gcc generates a small number of very long 'nop'
> instructions when padding code.
> 

There is a performance penalty for using NOP instructions *in the
fallthrough case.*  In the case where the padding is never supposed to
be executed, which is what we're talking about here, it is irrelevant.

I thought I had filed a gcc enhancement request, but I can't find it
now, so I just filed this:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85751

	-hpa
