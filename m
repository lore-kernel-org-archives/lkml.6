Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B8C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538D82081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXRIHmUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538D82081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLJA5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:57:49 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36494 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeLJA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:57:48 -0500
Received: by mail-pf1-f176.google.com with SMTP id b85so4535314pfc.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 16:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q7/lCL9FJdyhz/T1CmCRiZjq32YE0nsxJB+Y/sBlV3g=;
        b=ZXRIHmUQ5TiGwj3GnTIu3I6rlLVW++ahpF2g0aGsK/0vHZMAwGPNlltIxQLNzhcfEw
         AD5anQSWRvtsakjUzd9A7muAP68PZK7ggIds88hHmE8+iiskHhWN+NMmzGjGLWSNuFkW
         1089qZdBXaa7vQf+T3D+oRhtovmZh4eOiyMMfNzPqTHkoczEU+EaM0WXWcambTwxixY/
         3Kr8/TkpnwvscB4OLn1RpjeQorKeKUJrvrioqBux/J7T18zQL+kSBdwYS/diR4f0cMP5
         aD0u1oVo6hnGxMojiaJkc5gDYqCdSt2G724VAUg4BnvMpkDV1ODpfsGaigwQ0wc5bgYc
         GXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q7/lCL9FJdyhz/T1CmCRiZjq32YE0nsxJB+Y/sBlV3g=;
        b=FErNvGJg1V0CBy5eZl06bMLUP3OIMdeIxSWNTLVS1hXcGPTp3F+w4c005l+RLKRWlV
         ctZNsAP8zaE8BkB19wnYJpu9moxVkWWrjeolnZuE2uPPTw0ymdJPQLdcySW70Mv5mT5U
         kRYIFqq4WC2s1Pi+bhXkSiMLwUsgb2NphtTqyAJjFS0kbBPhjFDo5cZsbxpc+Km41hSo
         RsWYC67tLUdTnIxA0ZFbiiYq1TX9rhLMR3LwVYOQZm5Le+loiqtcrODer99DEQIh+o42
         qeW6H5Nphz2Ql/91MZFQIdrHvshJVgsDRcQlCxpVJwBhMZc7Ob7v5M660mANLyiLv/W8
         QMeQ==
X-Gm-Message-State: AA+aEWY0UzNkqda6TKdnR5AY29Bv4Drm7+PifRFwRqIsqMv6VRcnj6zk
        eTc5/tByX8Yyvgmgnlcto5I=
X-Google-Smtp-Source: AFSGD/WDmNx03wI15bjO6ktwaefn1HmxQPZgsfhy3p6kvJjJJ0fqXA5ufseYgubDmTKVKFZzj1wYEw==
X-Received: by 2002:a62:7892:: with SMTP id t140mr10370777pfc.237.1544403466252;
        Sun, 09 Dec 2018 16:57:46 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id k137sm17297319pfd.56.2018.12.09.16.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 16:57:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: Should this_cpu_read() be volatile?
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181208105220.GF5289@hirez.programming.kicks-ass.net>
Date:   Sun, 9 Dec 2018 16:57:43 -0800
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DE00B41-835C-4E68-B192-2A3C7ACB4392@gmail.com>
References: <20181203161352.GP10377@bombadil.infradead.org>
 <4F09425C-C9AB-452F-899C-3CF3D4B737E1@gmail.com>
 <20181203224920.GQ10377@bombadil.infradead.org>
 <C377D9EF-A0F4-4142-8145-6942DC29A353@gmail.com>
 <EB579DAE-B25F-4869-8529-8586DF4AECFF@gmail.com>
 <20181206102559.GG13538@hirez.programming.kicks-ass.net>
 <55B665E1-3F64-4D87-B779-D1B4AFE719A9@gmail.com>
 <20181207084550.GA2237@hirez.programming.kicks-ass.net>
 <C29C792A-3F47-482D-B0D8-99EABEDF8882@gmail.com>
 <C064896E-268A-4462-8D51-E43C1CF10104@gmail.com>
 <20181208105220.GF5289@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 8, 2018, at 2:52 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Dec 07, 2018 at 04:40:52PM -0800, Nadav Amit wrote:
>=20
>>> I'm actually having difficulty finding the this_cpu_read() in any of =
the
>>> functions you mention, so I cannot make any concrete suggestions =
other
>>> than pointing at the alternative functions available.
>>=20
>>=20
>> So I got deeper into the code to understand a couple of differences. =
In the
>> case of select_idle_sibling(), the patch (Peter=E2=80=99s) increase =
the function
>> code size by 123 bytes (over the baseline of 986). The per-cpu =
variable is
>> called through the following call chain:
>>=20
>> 	select_idle_sibling()
>> 	=3D> select_idle_cpu()
>> 	=3D> local_clock()
>> 	=3D> raw_smp_processor_id()
>>=20
>> And results in 2 more calls to sched_clock_cpu(), as the compiler =
assumes
>> the processor id changes in between (which obviously wouldn=E2=80=99t =
happen).
>=20
> That is the thing with raw_smp_processor_id(), it is allowed to be =
used
> in preemptible context, and there it _obviously_ can change between
> subsequent invocations.
>=20
> So again, this change is actually good.
>=20
> If we want to fix select_idle_cpu(), we should maybe not use
> local_clock() there but use sched_clock_cpu() with a stable argument,
> this code runs with IRQs disabled and therefore the CPU number is =
stable
> for us here.
>=20
>> There may be more changes around, which I didn=E2=80=99t fully =
analyze. But
>> the very least reading the processor id should not get =
=E2=80=9Cvolatile=E2=80=9D.
>>=20
>> As for finish_task_switch(), the impact is only few bytes, but still
>> unnecessary. It appears that with your patch preempt_count() causes =
multiple
>> reads of __preempt_count in this code:
>>=20
>>       if (WARN_ONCE(preempt_count() !=3D 2*PREEMPT_DISABLE_OFFSET,
>>                     "corrupted preempt_count: %s/%d/0x%x\n",
>>                     current->comm, current->pid, preempt_count()))
>>               preempt_count_set(FORK_PREEMPT_COUNT);
>=20
> My patch proposed here:
>=20
>  https://marc.info/?l=3Dlinux-mm&m=3D154409548410209
>=20
> would actually fix that one I think, preempt_count() uses
> raw_cpu_read_4() which will loose the volatile with that patch.

Sorry for the spam from yesterday. That what happens when I try to write
emails on my phone while I=E2=80=99m distracted.

I tested the patch you referenced, and it certainly improves the =
situation
for reads, but there are still small and big issues lying around.

The biggest one is that (I think) smp_processor_id() should apparently =
use
__this_cpu_read(). Anyhow, when preemption checks are on, it is =
validated
that smp_processor_id() is not used while preemption is enabled, and =
IRQs
are not supposed to change its value. Otherwise the generated code of =
many
functions is affected.

There are all kind of other smaller issues, such as set_irq_regs() and
get_irq_regs(), which should run with disabled interrupts. They affect =
the
generated code in do_IRQ() and others.

But beyond that, there are so many places in the code that use
this_cpu_read() while IRQs are guaranteed to be disabled. For example
arch/x86/mm/tlb.c is full with this_cpu_read/write() and almost(?) all
should be running with interrupts disabled. Having said that, in my =
build
only flush_tlb_func_common() was affected.

