Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2301C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E0A2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E0A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbeGVTbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:31:01 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:24278 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbeGVTbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:31:01 -0400
X-IronPort-AV: E=Sophos;i="5.51,390,1526342400"; 
   d="scan'208";a="76534345"
Subject: Re: [Xen-devel] [PATCH 1/2] x86/entry/64: Do not clear %rbx under Xen
To:     Andy Lutomirski <luto@kernel.org>,
        "M. Vefa Bicakci" <m.v.b@runbox.com>
CC:     Juergen Gross <jgross@suse.com>, Andi Kleen <ak@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@redhat.com>,
        stable <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20180721194909.23903-1-m.v.b@runbox.com>
 <CALCETrX435cC7Hi2aTLVrBecZEEeJ3_TgQnTwbObNrt9MKvFzg@mail.gmail.com>
 <b9ad156c-45e9-da80-9cf0-eabbe5a1bbf2@runbox.com>
 <CALCETrXsNxYP7-w-OoiNdJWspTKCsr0i01e6NiwFk1O5jL6grA@mail.gmail.com>
 <ce0cf39e-102e-8a33-6d46-492cd34e9506@runbox.com>
 <74f29b48-7522-c4f4-c2e7-d8e41fd88873@runbox.com>
 <CALCETrWbbLRM_0YTFaUx5V1FobwB6izD5ed9Xmf=wpdA0Lx2Tw@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.cooper3@citrix.com; prefer-encrypt=mutual; keydata=
 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
 6+ahAA==
Message-ID: <d3eabecb-5ab5-d89f-91aa-945d891de72f@citrix.com>
Date:   Sun, 22 Jul 2018 19:32:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWbbLRM_0YTFaUx5V1FobwB6izD5ed9Xmf=wpdA0Lx2Tw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/18 18:56, Andy Lutomirski wrote:
> On Sat, Jul 21, 2018 at 6:20 PM, M. Vefa Bicakci <m.v.b@runbox.com> wrote:
>> On 07/21/2018 07:37 PM, M. Vefa Bicakci wrote:
>>> On 07/21/2018 07:30 PM, Andy Lutomirski wrote:
>>>> On Sat, Jul 21, 2018 at 4:19 PM, M. Vefa Bicakci <m.v.b@runbox.com>
>>>> wrote:
>>>>> On 07/21/2018 05:45 PM, Andy Lutomirski wrote:
>>>>>>
>>>>>> On Sat, Jul 21, 2018 at 12:49 PM, M. Vefa Bicakci <m.v.b@runbox.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
>>>>>>> exceptions/interrupts, to reduce speculation attack surface")
>>>>>>> unintendedly
>>>>>>> broke Xen PV virtual machines by clearing the %rbx register at the end
>>>>>>> of
>>>>>>> xen_failsafe_callback before the latter jumps to error_exit.
>>>>>>> error_exit expects the %rbx register to be a flag indicating whether
>>>>>>> there should be a return to kernel mode.
>>>>>>>
>>>>>>> This commit makes sure that the %rbx register is not cleared by
>>>>>>> the PUSH_AND_CLEAR_REGS macro, when the macro in question is
>>>>>>> instantiated
>>>>>>> by xen_failsafe_callback, to avoid the issue.
>>>>>>
>>>>>>
>>>>>> Seems like a genuine problem, but:
>>>>>>
>>>>>>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>>>>>>> index c7449f377a77..96e8ff34129e 100644
>>>>>>> --- a/arch/x86/entry/entry_64.S
>>>>>>> +++ b/arch/x86/entry/entry_64.S
>>>>>>> @@ -1129,7 +1129,7 @@ ENTRY(xen_failsafe_callback)
>>>>>>>           addq    $0x30, %rsp
>>>>>>>           UNWIND_HINT_IRET_REGS
>>>>>>>           pushq   $-1 /* orig_ax = -1 => not a system call */
>>>>>>> -       PUSH_AND_CLEAR_REGS
>>>>>>> +       PUSH_AND_CLEAR_REGS clear_rbx=0
>>>>>>>           ENCODE_FRAME_POINTER
>>>>>>>           jmp     error_exit
>>>>>>
>>>>>>
>>>>>> The old code first set RBX to zero then, if frame pointers are on,
>>>>>> sets it to some special non-zero value, then crosses its fingers and
>>>>>> hopes for the best.  Your patched code just skips the zeroing part, so
>>>>>> RBX either contains the ENCODE_FRAME_POINTER result or is
>>>>>> uninitialized.
>>>>>>
>>>>>> How about actually initializing rbx to something sensible like, say, 1?
>>>>>
>>>>> Hello Andy,
>>>>>
>>>>> Thank you for the review! Apparently, I have not done my homework fully.
>>>>> I will test your suggestion and report back, most likely in a few hours.
>>>>>
>>>>> I have been testing with the next/linux-next tree's master branch
>>>>> (dated 20180720), and I noticed that ENCODE_FRAME_POINTER changes the
>>>>> frame pointer (i.e., RBP) register, as opposed to the RBX register,
>>>>> which the patch aims to avoid changing before jumping to error_exit.
>>>>> It is possible that I am missing something though -- I am not sure about
>>>>> the connection between the RBP and RBX registers.
>>>>
>>>> Sorry, brain fart on my part.
>>>
>>> No problem! :-)
>>>
>>>>> The change introduced by commit 3ac6d8c787b8 is in the excerpt below.
>>>>> Would
>>>>> it
>>>>> be valid to state that the original code had the same issue that you
>>>>> referred
>>>>> to (i.e., leaving the RBX register uninitialized)?
>>>>
>>>> Presumably.
>>>>
>>>> I would propose a rather different fix:
>>>>
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/pti&id=bb3d76b50c3bc78b67d79cf90d328f38a435c793
>>>>
>>>> Any chance you could test that and see if it fixes your problem?
>>>
>>> Of course; I will report back with the result in a few hours.
>>
>> Hello Andy,
>>
>> I confirm that the commit at [1] resolves the issue in question as well.
>>
>> To test, I first reverted my commit, applied your commit and verified that
>> the bug cannot be reproduced. Afterwards, I reverted your commit and
>> verified that the bug is reproducible.
>>
>> I am not sure about the best way to document the bug I encountered in your
>> commit message, but in case you plan to have your commit merged, please
>> feel free to add a "Reported-and-tested-by: M. Vefa Bicakci
>> <m.v.b@runbox.com>"
>> tag to the commit message, possibly with a link to this e-mail thread.
>>
>> Finally, as I had mentioned in my commit message, this bug exists in all
>> kernel versions 4.14 and greater, so it would be nice if you could
>> carbon-copy
>> "stable@vger.kernel.org" in the commit message as well.
>>
>> Thank you,
> I'm curious why the sigreturn_64 selftest didn't catch this bug.  Do
> you happen to know why?  The xen_failsafe_callback mechanism is a bit
> mysterious to me.

It is invoked whenever Xen suffers a fault when trying to load a guest
segment register.

In practice, it is used far more rarely with 64bit builds of Xen than it
used to be with 32bit builds.  This is because the only time we reload
guest data segments is in the vcpu context switch path.

More recent versions of Xen also don't have a fallback in the iret path,
due to what think was actually some overzealous cleanup.  As a result,
#GP gets delivered pointing at the target of the iret instruction.

Looking at the sigreturn tests, I'd expect the test to complain a lot,
not least because Xen doesn't have espfix64.

~Andrew
