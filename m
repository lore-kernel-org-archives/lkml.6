Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DE6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF3B20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="JMTlSb8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF3B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbeIFWqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:46:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33189 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeIFWqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:46:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so5646578pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fiQoHrV+7Um+tbW80DOpY3uk3dMlpV5qirAoZOITplQ=;
        b=JMTlSb8EXHoyL/gLlcyZgQA5uNCox8SAKAIDf/IrZYryYySaVNtg/1Ch00ZZpmr/7T
         Tu/X9xJxDHEd6AhAHqstnOvFspVj7OhBKVGzTgHW8k5XNSCKYRz25j2MZsxucWP4mcij
         jLJwpsSuqXW1dF+OIxjBOfiBnXBsb749JwkHfNYGnhmgeMPNWpfv2/VvnTERvPWyXb55
         kTVMqAS+Scpj7Of9Ic32nY4FPKxKkIq/KCNwdg+3+nPrVA45Ji7P5AxRvGA2IiaWXPa2
         nh3gCNiBGwdk2OjWV+il50hVI3ExIrIWEZYDBovQ94Ku8LGFwKFEuziC4MPj6DUOevoD
         grEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fiQoHrV+7Um+tbW80DOpY3uk3dMlpV5qirAoZOITplQ=;
        b=ce+NQqD3+HPF2WwxY8H9PeDQolVEDUsoG5d9CSpr1GnQEwa0pFzp8cuXntbx+8EzcA
         NwdCiXre9E/oWdT3AhqPjl7HOh7EU+B0QaOaj5zhKbbYhR5TULbUktrTsBlvu+kE6XgI
         HhEQK6CPNmR7EiMIuQz2wC/rCRs0p01AC0SSOEfHUQHZU+NOwRVP9cEkDHE9j7fwzG16
         nJheJdmoufOafuG6BxARl4+//kCzKbS1tlrJ2OEfmfMqAqNMoR9SR6khlQ3rdXvHiMRN
         6mx53HyfQYc1F2eWciVBzNaWfgDpbWVuN4z34P1O56/T1I1PDtGMCbw7SbMb/ATAdYqg
         iRcA==
X-Gm-Message-State: APzg51AdSM48jXKR7Mdsst/4ou8ZfYLCZejbXx/dDCFcGvdRlNZ3KE2M
        6ES0MXKWgyOVLFI9DjB0OVEa7w==
X-Google-Smtp-Source: ANB0VdaEEtWbzScFoy4Bo9GzcJw2PnmCsOHMg/6cT9XeT4RHLVlN0OYkS+eGOSxlYS22qZiee8XWWQ==
X-Received: by 2002:a62:d94:: with SMTP id 20-v6mr4211658pfn.202.1536257367015;
        Thu, 06 Sep 2018 11:09:27 -0700 (PDT)
Received: from ?IPv6:2600:1010:b06f:dac3:ac19:81ac:eb5a:b4f9? ([2600:1010:b06f:dac3:ac19:81ac:eb5a:b4f9])
        by smtp.gmail.com with ESMTPSA id 6-v6sm9778044pfs.58.2018.09.06.11.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 11:09:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
Date:   Thu, 6 Sep 2018 11:09:23 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
References: <20180902173224.30606-1-namit@vmware.com> <20180905185617.GC24082@hirez.programming.kicks-ass.net> <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com> <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com> <20180906081300.GF24082@hirez.programming.kicks-ass.net> <20180906101641.GG24142@hirez.programming.kicks-ass.net> <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com> <20180906171754.GJ24106@hirez.programming.kicks-ass.net> <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 6, 2018, at 10:58 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
> at 10:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>>> On Thu, Sep 06, 2018 at 05:01:25PM +0000, Nadav Amit wrote:
>>> In addition, there might be a couple of issues with your fix:
>>=20
>> It boots on my box ;-)
>>=20
>>> 1. __set_pte_vaddr() is not used exclusive by set_fixmap(). This means
>>> the warning might be wrong, but also means that these code patches (Xen=E2=
=80=99s
>>> set_pte_mfn(), CPU-entry-area setup) needs to be checked. And as you sai=
d
>>> before, someone might use this function for other purposes as well.
>>=20
>> CEA is fine, that actually needs it too.
>>=20
>> The one thing I missed out on earlier is the below chunk, that is no
>> longer needed now that cea_set_pte() actually does the right thing.
>>=20
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index b7b01d762d32..14ad97fa0749 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -293,12 +293,6 @@ static void ds_update_cea(void *cea, void *addr, siz=
e_t size, pgprot_t prot)
>> preempt_disable();
>> for (; msz < size; msz +=3D PAGE_SIZE, pa +=3D PAGE_SIZE, cea +=3D PAGE_S=
IZE)
>> cea_set_pte(cea, pa, prot);
>> -
>> - /*
>> -  * This is a cross-CPU update of the cpu_entry_area, we must shoot down=

>> -  * all TLB entries for it.
>> -  */
>> - flush_tlb_kernel_range(start, start + size);
>> preempt_enable();
>> }
>>=20
>> @@ -310,8 +304,6 @@ static void ds_clear_cea(void *cea, size_t size)
>> preempt_disable();
>> for (; msz < size; msz +=3D PAGE_SIZE, cea +=3D PAGE_SIZE)
>> cea_set_pte(cea, 0, PAGE_NONE);
>> -
>> - flush_tlb_kernel_range(start, start + size);
>> preempt_enable();
>> }
>>=20
>>=20
>>> 2. Printing the virtual address can break KASLR.
>>=20
>> Local KASLR is a myth.. but sure, we can fix the print.
>>=20
>>> 3. The WARN() can introduce some overhead since checking if IRQs are
>>> disabled takes considerably long time. Perhaps VM_WARN() or something is=

>>> better. I realize this code-path is not on the hot-path though...
>>=20
>> Yeah, if it triggers you have bigger problems. We can make it
>> WARN_ONCE() I suppose.
>>=20
>>> 4. I guess flush_tlb_kernel_range() should also have something like
>>> VM_WARN_ON(irqs_disabled()), just as an additional general sanity check.=

>>=20
>> It has, it's hidden in kernel/smp.c:smp_call_function_many().
>=20
> Right. Thanks.
>=20
>>=20
>>> Let me know if you want me to make these changes and include your patch i=
n
>>> the set.
>>=20
>> The set is no longer needed. text_poke() is fine and correct with this
>> one patch.
>=20
> It depends what security you want. Some may consider even the short
> time-window in which the kernel code is writable from other cores as
> insufficient for security.
>=20
> In addition, the set removes the need for remote TLB shootdowns that
> text_poke() - with this fix - requires.
>=20

I=E2=80=99m personally in favor of not needing a global broadcast flush to i=
nstall kprobes.=
