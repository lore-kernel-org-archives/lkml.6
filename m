Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E082AC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12EB2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="PvKcvCfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBGSHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:07:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33645 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:07:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so301239pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 10:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L86r24JDuPjR47MkXv1ZNTfyUZQ4g229bJnMVn5Dc5s=;
        b=PvKcvCfnajSm7ngmpFFhgP3n9poKwmIFufqp8Zza8wXgg22wldn1wrzfQUGDeOX3UZ
         Kvnjz21uV+MOw2LKWhonG2FnV7ETVpdnhEVoWM4NdL57GrPVBut6OulrARTVzw5ql3ms
         rHmYLG7YjlGb53Q6ZCn+ZSFFntcxwfUyas/9deGW47DFINDFVUE8EAT4x8fySpitmJZU
         12LAtATHU7eNrUipfAjfpf+nE2rQdJMseiKGfb4Mr3Uh2eYuIRKeqJdIsvVcP6L7jjMh
         sKTPfmAIMEsYlZyRX404oVStR7wIQq/ofGG1fYbeRjvQA4CKJ6AlTJ/YnKzIo82I/ykR
         JL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L86r24JDuPjR47MkXv1ZNTfyUZQ4g229bJnMVn5Dc5s=;
        b=XhILAIOE1mf3/zhwA1J8yvKyEWjPZM013Czw7eqacFP2m5dZCDGs53JosOXgo0XsXv
         szM7j+lXfkq5A1dS5WpuA0QMGKhq1/1zQfNgZYP5nde3hBcRQLTt/8uBB6+Uq/4/FYfe
         sEy+g37caWqrAtv/6EeXc+5DiWNsV00Oxtmw0HzeW/sXNJKWwyCUl5jSdUBefozgp0zx
         9XSkd1Jt5reuXHW/oEpK2LkNlgqgDM6FybmOTh3aMro4NAmIEvfVpDgrXGkQ9YWWorXz
         Isb33c7nuO6qlI4GPfVB54CsdPsPgavY7OqtQpu3rdgVcX9u2yhmpOGXCj9Tw5PB5NUB
         6f8g==
X-Gm-Message-State: AHQUAuZ0gNXln2wdCAahXV4Bmx82VEQSXOCx8en9AJwBJltrwF+AxRYY
        1dOObPEifYujN8++XF7P+DDwGw==
X-Google-Smtp-Source: AHgI3IYlvknSR1aFlAFJNw4SOV5R/qITpK+IGAuYOUrvnf2DdGopgD3GE7ioeofVtdQGK8bd+lpCzA==
X-Received: by 2002:a63:e711:: with SMTP id b17mr5529834pgi.363.1549562850723;
        Thu, 07 Feb 2019 10:07:30 -0800 (PST)
Received: from [192.168.0.178] (c-71-202-137-17.hsd1.ca.comcast.net. [71.202.137.17])
        by smtp.gmail.com with ESMTPSA id t3sm14347385pfa.50.2019.02.07.10.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:07:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT PULL] x86/mm changes for v4.21
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190207175720.GE32511@hirez.programming.kicks-ass.net>
Date:   Thu, 7 Feb 2019 10:07:28 -0800
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D8DF81C-3331-4105-8594-9600281010EF@amacapital.net>
References: <20181224231106.GA27438@gmail.com> <20190207001737.GA32096@agluck-desk> <20190207101846.GB32511@hirez.programming.kicks-ass.net> <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com> <20190207140131.GB32477@hirez.programming.kicks-ass.net> <20190207173600.GA15682@agluck-desk> <20190207175720.GE32511@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 7, 2019, at 9:57 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Thu, Feb 07, 2019 at 09:36:00AM -0800, Luck, Tony wrote:
>>> On Thu, Feb 07, 2019 at 03:01:31PM +0100, Peter Zijlstra wrote:
>>>> On Thu, Feb 07, 2019 at 11:50:52AM +0000, Linus Torvalds wrote:
>>>> If you re-generate the canonical address in __cpa_addr(), now we'll
>>>> actually have the real virtual address around for a lot of code-paths
>>>> (pte lookup etc), which was what people wanted to avoid in the first
>>>> place.
>>>=20
>>> Note that it's an 'unsigned long' address, not an actual pointer, and
>>> (afaict) non of the code paths use it as a pointer. This _should_ avoid
>>> the CPU from following said pointer and doing a deref on it.
>>=20
>> The type doesn't matter. You want to avoid having the
>> true value in the register as long as possible. Ideal
>> spot would be the instruction before the TLB is flushed.
>>=20
>> The speculative issue is that any branch you encounter
>> while you have the address in a register may be mispredicted.
>> You might also get a bogus hit in the branch target cache
>> and speculatively jump into the weeds. While there you
>> could find an instruction that loads using that register, and
>> even though it is speculative and the instruction won't
>> retire, a machine check log will be created in a bank (no
>> machine check is signalled).
>>=20
>> Once the TLB is updated, you are safe. A speculative
>> access to an uncached address will not load or log anything.
>=20
> Something like so then? AFAICT CLFLUSH will also #GP if feed it crap.
>=20
>=20
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 4f8972311a77..d3ae92ad72a6 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -230,6 +230,28 @@ static bool __cpa_pfn_in_highmap(unsigned long pfn)
>=20
> #endif
>=20
> +/*
> + * Machine check recovery code needs to change cache mode of poisoned
> + * pages to UC to avoid speculative access logging another error. But
> + * passing the address of the 1:1 mapping to set_memory_uc() is a fine
> + * way to encourage a speculative access. So we cheat and flip the top
> + * bit of the address. This works fine for the code that updates the
> + * page tables. But at the end of the process we need to flush the cache
> + * and the non-canonical address causes a #GP fault when used by the
> + * CLFLUSH instruction.
> + *
> + * But in the common case we already have a canonical address. This code
> + * will fix the top bit if needed and is a no-op otherwise.

Joining this thread late...

This is all IMO rather crazy.  How about we fiddle with CR0 to turn off the c=
ache, then fiddle with page tables, then turn caching on?  Or, heck, see if t=
here=E2=80=99s some chicken bit we can set to improve the situation while we=
=E2=80=99re in the MCE handler.

Also, since I don=E2=80=99t really want to dig into the code to answer this,=
 how exactly do we do a broadcast TLB flush from MCE context?  We=E2=80=99re=
 super-duper-atomic, and locks might be held on various CPUs.  Shouldn=E2=80=
=99t we be telling the cpa code to skip the flush and then just have the MCE=
 code do a full flush manually?  The MCE code has already taken over all CPU=
s on non-LMCE systems.

Or, better yet, get Intel to fix the hardware. A failed speculative access w=
hile already in MCE context should just be ignored.=
