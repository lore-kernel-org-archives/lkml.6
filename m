Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeENLGK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:06:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49235 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeENLGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:06:08 -0400
Date: Mon, 14 May 2018 04:05:31 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <83866d054b27419c9d9dd97d9c66c3de@AcuMS.aculab.com>
References: <20180507213755.GA32406@avx2> <20fb84fd5eef4c45b2d38d0290235d5d@AcuMS.aculab.com> <5c6762fe-5cbe-42ed-ac4e-a7144b8ef7ad@zytor.com> <83866d054b27419c9d9dd97d9c66c3de@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] x86: pad assembly functions with INT3
To: David Laight <David.Laight@ACULAB.COM>,
        "'Alexey Dobriyan'" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
From: hpa@zytor.com
Message-ID: <D6F6643E-1206-4D87-B8ED-5FF17C15A0EF@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 14, 2018 2:04:38 AM PDT, David Laight <David.Laight@ACULAB.COM> wrote:
>From: H. Peter Anvin
>> Sent: 11 May 2018 19:54
>> 
>> On 05/10/18 09:39, David Laight wrote:
>> > From: Alexey Dobriyan
>> >> Sent: 07 May 2018 22:38
>> >>
>> >> Use INT3 instead of NOP. All that padding between functions is
>> >> an illegal area, no legitimate code should jump into it.
>> >>
>> >> I've checked x86_64 allyesconfig disassembly, all changes looks
>sane:
>> >> INT3 is only used after RET or unconditional JMP.
>> >
>> > I thought there was a performance penalty (on at least some cpu)
>> > depending on the number of and the actual instructions used for
>padding.
>> >
>> > I believe that is why gcc generates a small number of very long
>'nop'
>> > instructions when padding code.
>> >
>> 
>> There is a performance penalty for using NOP instructions *in the
>> fallthrough case.*  In the case where the padding is never supposed
>to
>> be executed, which is what we're talking about here, it is
>irrelevant.
>
>Not completely irrelevant, the instructions stream gets fetched and
>decoded
>beyond the jmp/ret at the end of the function.
>At some point the cpu will decode the jmp/ret and fetch/decode from the
>target address.
>I guess it won't try to speculatively execute the 'pad' instructions
>- but you can never really tell!
>
>	David

The CPU doesn't speculate down past an unconditional control transfer. Doing so would be idiotic.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
