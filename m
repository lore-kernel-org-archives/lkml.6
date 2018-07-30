Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C77C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199BD20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="WJUX5sAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199BD20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbeG3Xho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:37:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33830 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeG3Xho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:37:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so7964807pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HBCsCVae+BF+nuVLp/xK3snzjYAJeCrH7C7H7w3ttOQ=;
        b=WJUX5sAmzc5VsJIzklnhd9kaEw/42xLRwxRCgQop92mcIkRGBcXcnSONfpYMUHhH4M
         uk+E5nLJPw8CwL+LSJ3sgYVvqhcq1Ig8LRz9s6fhgWUwS2aUEEdkUCuLIK9MBeAGPMrk
         6X6bL1PRJj8bu1a67ogPqNygLg123PRoTJgfiQhGqSJkqE4gK1sGVS1kWGDfZ7XKQgYe
         QGl26Igw4+90MOFfbaAIOiHngNixR5XBY6GzMnjUDvlqvNV4RZ7gvfdY/sIXxYI3nQTw
         KjfrHY6UbUjTlHGHJOSmPv9j3iyQ1T3TV93AGN7tAYhTix3uSJ6Fc8RM5VwLCgUGOVX7
         nb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HBCsCVae+BF+nuVLp/xK3snzjYAJeCrH7C7H7w3ttOQ=;
        b=nuzB8OjmrWp9D8JdgS+Zlbr8JeaCzpVZc8H7d6t9SIXMcoAy9PWX8+sHVqnHxTANXk
         4Zc9OVklD9YdP5Tf0LeBGX+SeYm1ITbk1vUeZ3HXqnbtBuCwBqgfqtEXyFfLZ5dF4fMo
         sJwIcVXRrk/u8IpaWuPXkUTGi6fN1tUsbttjp5yMqSGkPTjZODrFlgyReYN+Eu6p9kfk
         9t/sIzh2gncH2cYN9YqzcdstN5nEmnx5wOmkmoZXojKHMJEScPaiqax48hxUM6yX0EMs
         AU4HseumxgP4YMjqZ/xPFu0ajKiPyRQ4PH2Ket2ST2IVWSualjNa6IqFFAWqiwFvURwv
         nzFA==
X-Gm-Message-State: AOUpUlGQf2QBxjYn43vHlPXE0QR5p9yqj/u/xJ9q1XBIW7gavWfQzFB+
        XIaQN1yhgVU1eC2oYWBxZo//FA==
X-Google-Smtp-Source: AAOMgpfZFdm7VithxePWMxSSPRmw6Jdvn/hFI/CrIKuayxiRBzLOg2C0CVW6miW552xpHqzrXnenRw==
X-Received: by 2002:a65:6551:: with SMTP id a17-v6mr17881647pgw.132.1532988043742;
        Mon, 30 Jul 2018 15:00:43 -0700 (PDT)
Received: from ?IPv6:2600:1010:b000:9cc9:ec6b:3393:cbdb:226f? ([2600:1010:b000:9cc9:ec6b:3393:cbdb:226f])
        by smtp.gmail.com with ESMTPSA id e126-v6sm25647864pfg.31.2018.07.30.15.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 15:00:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm refcounting
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <1532987170.28585.52.camel@surriel.com>
Date:   Mon, 30 Jul 2018 15:00:40 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <91F4157A-8004-46EC-AE04-F2F338B0D5BB@amacapital.net>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-11-riel@surriel.com> <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com> <20180729155452.37eddc11@imladris.surriel.com> <20180730095502.GG2494@hirez.programming.kicks-ass.net> <1532961011.28585.30.camel@surriel.com> <20180730162653.GM2494@hirez.programming.kicks-ass.net> <1532978146.28585.32.camel@surriel.com> <CALCETrXZPN6Lt55siHM__YW4jFfoy5w+Hd2aJtEi8qhsro6RMA@mail.gmail.com> <1532979368.28585.33.camel@surriel.com> <CALCETrXnG9nPzJKOtd=65BWeoTs2y=mVUAEvNGmFrD8fvg-EfQ@mail.gmail.com> <1532987170.28585.52.camel@surriel.com>
To:     Rik van Riel <riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 30, 2018, at 2:46 PM, Rik van Riel <riel@surriel.com> wrote:
>=20
>> On Mon, 2018-07-30 at 12:49 -0700, Andy Lutomirski wrote:
>>=20
>>=20
>> I think it's a big step in the right direction, but it still makes be
>> nervous.  I'd be more comfortable with it if you at least had a
>> functional set of patches that result in active_mm being gone,
>> because
>> that will mean that you actually audited the whole mess and fixed
>> anything that might rely on active_mm pointing somewhere or that
>> might
>> be putting a value you didn't take into account into active_mm.  IOW
>> I'm not totally thrilled by applying the patches as is if we're still
>> a bit unsure as to what might have gotten missed.
>>=20
>> I don't think it's at all necessary to redo the patches.
>>=20
>> Does that seem reasonable?
>=20
> Absolutely. I tried to keep ->active_mm very similar
> to before for exactly that reason.
>=20
> Lets go through all the places where it is used, in
> x86 and architecture independent code. I have not
> checked other architectures.
>=20
> It looks like we should be able to get rid of
> ->active_mm at some point, but a lot of it depends
> on other architecture maintainers.
>=20
>=20
> arch/x86/events/core.c:
> - get_segment_base: get current->active_mm->context.ldt,
>  this appears to be for TIF_IA32 user programs only, so
>  we should be able to use current->mm here

->mm sounds more correct anyway

>=20
> arch/x86/kernel/cpu/common.c:
> - current task's ->active_mm assigned in two places,
>  never read
>=20
> arch/x86/lib/insn-eval.c:
> - get_desc() gets current->active_mm->context.ldt, this
>  appears to be only for user space programs

Same as above

>=20
> arch/x86/mm/tlb.c:
> - this series adds two places where current->active_mm is
>  written, it is never read
>=20
> arch/x86/platform/efi/efi_64.c:
> - current->active_mm is set to efi_mm for a little bit,
>  with irqs disabled, and then changed back, with irqs still
>  disabled; we should be able to get rid of ->active_mm here
> - in the init code, ->active_mm is set to efi_mm as well,
>  presumably the kernel automatically switches that back on
>  the next context switch; this may be buggy, since preemption
>  is enabled and a GFP_KERNEL allocation is just a few lines
>  below

Ick. This should mostly go away soon =E2=80=94 most EFI code will move to a r=
eal thread.

>=20
> arch/x86/power/cpu.c:
> - fix_processor_context() calls load_mm_ldt(current->active_mm);,
>  we should be able to use cpu_tlbstate.loaded_mm instead

Agreed

>=20
> drivers/cpufreq/pmac32-cpufreq.c:
> - pmu_set_cpu_speed() restores current->active_mm - don't know if
>  anyone still cares about 32 bit PPC :)
>=20

I think we should only remove active_mm when the new #define is set. So this=
 doesn=E2=80=99t need to change.

> drivers/firmware/efi/arm-runtime.c:
> - efi_virtmap_unload switches back the pgd to current->active_mm
>  from &efi_mm; that mm could be stored elsewhere if we excised
>  ->active_mm everywhere

Ditto

IOW the active_mm refcounting may be genuinely useful for architectures that=
 are not able to efficiently shoot down remote lazy mm references in exit_mm=
ap(). I suspect that ARM64 may be in that category.
