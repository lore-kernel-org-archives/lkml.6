Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0254AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5320647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="V4+W1Due"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E5320647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeH3F7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:59:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43391 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeH3F7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:59:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so3138421pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HULBVotVOo0DZmUXncZVse/XA7ThG5sRyVqOWnGOofw=;
        b=V4+W1DuexbtZ/SwFiuTd+3MwTud4dxvyiDjeD8pA3LOM/FU/e/v47XhxtgzbMxJsaX
         ERbFjVZc5jLtbm+OfO0I5nxbN6OwLOl3mHr89Xg8ovDf33rcfGvzp0scVfgV192EpboL
         H28+0RL4t+tW/y9IAccqgEacSQ4RVMU7R1dXN6ysYOlC/U2TPd9YKwmTPcOfAxJGqa9D
         Ei7k/QaDEcxNE/qzsh7aSH8fKMH505tYCV6zoZGThvycIg0GIMk/pTNEt3eqTEqm1jWn
         2WR+IV9nOEHsuGKrooJSOOT8DT23mxFKLA7xCuR6vNMe0AR74ABsatugZuNqVHk3bnN9
         j0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HULBVotVOo0DZmUXncZVse/XA7ThG5sRyVqOWnGOofw=;
        b=rCRzgmcyfPkuA0AF/y6vLlqg5L+INMvhXR1h0TsjyokKQ4OpXuF86XmHb3gNIe/XNX
         hWReehhSwnrJ9Beo1866kM4NVPaVoA3wNkOy57/9iUISThxPRi8QkYJEdnoS8OI5iVmE
         ONgacqjbMhq9BWm85otiT8hLQcSuFN5AnvmeaQFWJJBPnqEy8e6LHcB84GfmpEl9sLgd
         Ns1ieoyqrmjkmG7jx8L5ixwOkIvJycODW1WBFJJgTbsxs6SWe21b/auZXmradeKWoT1N
         onieZ8N9ttqEM48PDIM8DJeHsXpSKYFo7+CC/0Ma203vT38+xsZ8j8F8ow6k/YaPu0Ui
         JsQQ==
X-Gm-Message-State: APzg51DOYYyMKIVA/i4NKm84mpoviqw+UmNp0VRbx0JzJIBB7KmVqBhZ
        uA3lMvSzeZ6LuhtOAh8xUOaW9Q==
X-Google-Smtp-Source: ANB0VdbRqeHuW/UBmKUXn7Z6mX2Peg+BCzoYVN6eyhfjWMZ+PdWxK/9viydj8H4kF13MtQd/LkRJIw==
X-Received: by 2002:a62:2b50:: with SMTP id r77-v6mr8273748pfr.51.1535594396073;
        Wed, 29 Aug 2018 18:59:56 -0700 (PDT)
Received: from ?IPv6:2600:1010:b05a:7d28:c160:33fb:c0e2:e5ad? ([2600:1010:b05a:7d28:c160:33fb:c0e2:e5ad])
        by smtp.gmail.com with ESMTPSA id z5-v6sm7380664pfh.83.2018.08.29.18.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:59:55 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180830103859.ac309b71c53d267da2f6e9f8@kernel.org>
Date:   Wed, 29 Aug 2018 18:59:52 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEEC1254-F6CA-4E08-AAFC-CFABE5FE51B3@amacapital.net>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-3-namit@vmware.com> <20180829184925.64caee4dadf705080373f84f@kernel.org> <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com> <20180830103859.ac309b71c53d267da2f6e9f8@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 29, 2018, at 6:38 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:=

>=20
> On Wed, 29 Aug 2018 08:41:00 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
>=20
>>> On Wed, Aug 29, 2018 at 2:49 AM, Masami Hiramatsu <mhiramat@kernel.org> w=
rote:
>>> On Wed, 29 Aug 2018 01:11:43 -0700
>>> Nadav Amit <namit@vmware.com> wrote:
>>>=20
>>>> From: Andy Lutomirski <luto@kernel.org>
>>>>=20
>>>> Sometimes we want to set a temporary page-table entries (PTEs) in one o=
f
>>>> the cores, without allowing other cores to use - even speculatively -
>>>> these mappings. There are two benefits for doing so:
>>>>=20
>>>> (1) Security: if sensitive PTEs are set, temporary mm prevents their us=
e
>>>> in other cores. This hardens the security as it prevents exploding a
>>>> dangling pointer to overwrite sensitive data using the sensitive PTE.
>>>>=20
>>>> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
>>>> remote page-tables.
>>>>=20
>>>> To do so a temporary mm_struct can be used. Mappings which are private
>>>> for this mm can be set in the userspace part of the address-space.
>>>> During the whole time in which the temporary mm is loaded, interrupts
>>>> must be disabled.
>>>>=20
>>>> The first use-case for temporary PTEs, which will follow, is for poking=

>>>> the kernel text.
>>>>=20
>>>> [ Commit message was written by Nadav ]
>>>>=20
>>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>> ---
>>>> arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
>>>> 1 file changed, 20 insertions(+)
>>>>=20
>>>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/=
mmu_context.h
>>>> index eeeb9289c764..96afc8c0cf15 100644
>>>> --- a/arch/x86/include/asm/mmu_context.h
>>>> +++ b/arch/x86/include/asm/mmu_context.h
>>>> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast=
(void)
>>>>      return cr3;
>>>> }
>>>>=20
>>>> +typedef struct {
>>>> +     struct mm_struct *prev;
>>>> +} temporary_mm_state_t;
>>>> +
>>>> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *=
mm)
>>>> +{
>>>> +     temporary_mm_state_t state;
>>>> +
>>>> +     lockdep_assert_irqs_disabled();
>>>> +     state.prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
>>>> +     switch_mm_irqs_off(NULL, mm, current);
>>>> +     return state;
>>>> +}
>>>=20
>>> Hmm, why don't we return mm_struct *prev directly?
>>=20
>> I did it this way to make it easier to add future debugging stuff
>> later. Also, when I first wrote this, I stashed the old CR3 instead
>> of the old mm_struct, and it seemed like callers should be insulated
>> from details like this.
>=20
> Hmm, I see. But in that case, we should call it "struct temporary_mm"
> and explicitly allocate (and pass) it, since we can not return the
> data structure from stack.

Why not?

> If we can combine it with new mm, it will
> be more encapsulated e.g.
>=20
> struct temporary_mm {
>    struct mm_struct *mm;
>    struct mm_struct *prev;
> };
>=20
> static struct temporary_mm poking_tmp_mm;
>=20
> poking_init()
> {
>    if (init_temporary_mm(&tmp_mm, &init_mm))
>        goto error;
>    ...
> }
>=20
> text_poke_safe()
> {
>    ...
>    use_temporary_mm(&tmp_mm);
>    ...
>    unuse_temporary_mm(&tmp_mm);
> }
>=20
> Any thought?

That seems more complicated for not very much gain.

