Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7125AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB8021567
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhepF3+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB8021567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeHYGGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 02:06:36 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:33380 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHYGGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 02:06:36 -0400
Received: by mail-pl1-f174.google.com with SMTP id 60-v6so1813704ple.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 19:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=l/2s2t3rtE37tt0LycqUWsfX9GphsseHJOzzA5vuQTI=;
        b=VhepF3+J3OGjX2UZpFCg9Di4y8D4puOcyIFnZFOa6a1S9FzBxZ639SIRp9ApbtNJEs
         hf5ScEMm8SYJpcjB2j+t5rLTigjOxsPgCuZH4nI0XZzbA6D1+aEFg79ZMzZ2mu8MI615
         UH1jve9Jxc6gVX7Ta1LsvhKf9NYxHNDPVTb2ACuP55HdcetKlQ9GU5c29QtaON364MXw
         VXbFCOh892F9RLnJLEuojK5QF4LM3a0Qsbhee31GWCH+t/33/ZKt8tfMj7ENrLrXc2eX
         gObvozue0U0VaVgULaxEpKjg13cEHO/gRspM+jpx45IdZkSQYXcfA+dIxpADVEx64G0V
         KvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=l/2s2t3rtE37tt0LycqUWsfX9GphsseHJOzzA5vuQTI=;
        b=r3T/6ws7mlAlDsm/smjAsO4ydLEFeLHrDLzcl5OPqdOLWCTtPDAo+P4QZs/7U7dfQY
         Y4pg5MU/jMu6eIuyKIBSjLfAcidTeiT2K7HgF+fQ9vgh4u2c156gRpw18oSt5HDBFmXm
         3DsvvZtQqfOtsesDvTfK6KCrggOCFt0e081L1acuBcJTC/C68o2Xsc5Y+PxMiH9BL3M6
         mel20qL3VWoU5mAe9hEZBj5QVqdBBm0NUwzCduMw3Dg+rGan63aNwgsDjmSFTStsqxt4
         P0Qtj6ShxiMTTI17HyuO2c+061FUbC/l2y/UYm7HEZ/CocbS6TldQpC0xvE3OAC/vAu5
         eEnw==
X-Gm-Message-State: APzg51AsDhkpb9Rzp2xSDSaSVMXw3lv3pccyLGZkoNl8nwNVWfbpOLfZ
        2ufYHgR4Ac30tkYhSACaeW0=
X-Google-Smtp-Source: ANB0VdbjkGlxOsyEzsvPiBSMkYbDB8BFcFJ7dn6nFPTlJ5zdncYYoFUmylKPsdOw0UEXqu4PfpnDDw==
X-Received: by 2002:a17:902:7613:: with SMTP id k19-v6mr3997897pll.317.1535164161098;
        Fri, 24 Aug 2018 19:29:21 -0700 (PDT)
Received: from [10.64.111.8] (c-98-234-136-180.hsd1.ca.comcast.net. [98.234.136.180])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17346388pfi.180.2018.08.24.19.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 19:29:20 -0700 (PDT)
Date:   Fri, 24 Aug 2018 19:29:02 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org> <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com> <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com> <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com> <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com> <20180823133958.GA1496@brain-police> <20180824084717.GK24124@hirez.programming.kicks-ass.net> <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com> <20180824180438.GS24124@hirez.programming.kicks-ass.net> <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com> <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com> <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com> <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: TLB flushes on fixmap changes
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   nadav.amit@gmail.com
Message-ID: <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 24, 2018 5:58:43 PM PDT, Linus Torvalds <torvalds@linux-foundati=
on=2Eorg> wrote:
>Adding a few people to the cc=2E
>
>On Fri, Aug 24, 2018 at 1:24 PM Nadav Amit <nadav=2Eamit@gmail=2Ecom>
>wrote:
>> >
>> > Can you actually find something that changes the fixmaps after boot
>> > (again, ignoring kmap)?
>>
>> At least the alternatives mechanism appears to do so=2E
>>
>> IIUC the following path is possible when adding a module:
>>
>>         jump_label_add_module()
>>         ->__jump_label_update()
>>         ->arch_jump_label_transform()
>>         ->__jump_label_transform()
>>         ->text_poke_bp()
>>         ->text_poke()
>>         ->set_fixmap()
>
>Yeah, that looks a bit iffy=2E
>
>But making the tlb flush global wouldn't help=2E  This is running on a
>local core, and if there are other CPU's that can do this at the same
>time, then they'd just fight about the same mapping=2E
>
>Honestly, I think it's ok just because I *hope* this is all serialized
>anyway (jump_label_lock? But what about other users of text_poke?)=2E

The users should hold text_mutex=2E

>
>But I'd be a lot happier about it if it either used an explicit lock
>to make sure, or used per-cpu fixmap entries=2E

My concern is that despite the lock, one core would do a speculative page =
walk and cache a translation that soon after would become stale=2E

>
>And the tlb flush is done *after* the address is used, which is bogus
>anyway=2E

It seems to me that it is intended to remove the mapping that might be a s=
ecurity issue=2E=C2=A0

But anyhow, set_fixmap and clear_fixmap perform a local TLB flush, (in __s=
et_pte_vaddr()) so locally things should be fine=2E

>
>> And a similar path can happen when static_key_enable/disable() is
>called=2E
>
>Same comments=2E
>
>How about replacing that
>
>        local_irq_save(flags);
>       =2E=2E=2E do critical things here =2E=2E=2E
>        local_irq_restore(flags);
>
>in text_poke() with
>
>        static DEFINE_SPINLOCK(poke_lock);
>
>        spin_lock_irqsave(&poke_lock, flags);
>       =2E=2E=2E do critical things here =2E=2E=2E
>        spin_unlock_irqrestore(&poke_lock, flags);
>
>and moving the local_flush_tlb() to after the set_fixmaps, but before
>the access through the virtual address=2E
>
>But changing things to do a global tlb flush would just be wrong=2E

As I noted, I think that locking and local flushes as they are right now a=
re fine (besides the redundant flush)=2E

My concern is merely that speculative page walks on other cores would cach=
e stale entries=2E



--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
