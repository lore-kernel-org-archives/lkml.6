Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91060C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FE620645
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+/ONAEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FE620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLHAk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:40:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35976 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:40:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so2701806pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 16:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rdsRmF4WQnETxwYL1tK8P25bz6qzwmQ6m4WA7kOJymI=;
        b=J+/ONAEZV13neSlpK/mhKeG3jtuolcyex4VPvCAT3NhNagfAOgkFtvPDZ2n9x7JySD
         gWJn1R+I7X6UNlch+xreRV/ktsnLALNrZCRb68MrWpxruuqgN5MFz8jxPCwT+tnafZjq
         1acHQBdgWJ79tVHpG4fvWZYa4RZIZuNVWZ1MHWvoesPhFhHVwAPIAS3hFmMRaKGPyh6F
         AjSvX9KnD/m/p+9+RWHrRBqDQAcm5Os/zcHiop1O3Dq/dNKuvcp7LXkhA3BACrGrrAhM
         4Wgxbc/+gjUtDZdgi3O5gb6LkH4wFe1gAbFm7ygNrq+GWbmjwph9y2V6oyTrebjETFPC
         hp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rdsRmF4WQnETxwYL1tK8P25bz6qzwmQ6m4WA7kOJymI=;
        b=frpDHz31PcVI5v1aDe2fPK3faXJzZ39Tf2ME4w4IAVCW2mjnobuu2rtX3b7EgweAe7
         iWuV4UOFTLVIZDHcDCslZRAGf8khOaQWo6p2KlY9idFXoCy51UgOggT+t8YtV0+uk0Uk
         dm5OnUKP5NCN1MyjH8QBuM+qRKV7S/Jp85jQ/5RAn6G1WVBK5JW02oJueY7rKzdYfsTq
         zwhBPmwq4tGx1GWOeyPKfH4Y6kRmsLx3inMUJjxoNbPQ+Vjv1nSzLGPU6Dy6fMEB/T0v
         c9QnISk39nwmor+Kjf1PJ4hkgFD8bUzOseO3QSrb8v9yWFMfmZrhQoQhu7mok+rteeHb
         WEeg==
X-Gm-Message-State: AA+aEWbxd2oTRgGfpo32UgRdzABzfxAiIZbK3iOAEQL1lUkpWHGDlxE6
        TH59Ic+dv2rUyQLXDb8qGGs=
X-Google-Smtp-Source: AFSGD/WpcO1xXCAGI7AfFj4i9GCZ+idkbhi654kN0Id00ZYp1a6CuyrIblIiGwSBb1bsP9LjSoUx0A==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr3745849pgl.186.1544229655385;
        Fri, 07 Dec 2018 16:40:55 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id d11sm4501923pgi.25.2018.12.07.16.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 16:40:54 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Should this_cpu_read() be volatile?
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <C29C792A-3F47-482D-B0D8-99EABEDF8882@gmail.com>
Date:   Fri, 7 Dec 2018 16:40:52 -0800
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C064896E-268A-4462-8D51-E43C1CF10104@gmail.com>
References: <20181128140136.GG10377@bombadil.infradead.org>
 <3264149f-e01e-faa2-3bc8-8aa1c255e075@suse.cz>
 <20181203161352.GP10377@bombadil.infradead.org>
 <4F09425C-C9AB-452F-899C-3CF3D4B737E1@gmail.com>
 <20181203224920.GQ10377@bombadil.infradead.org>
 <C377D9EF-A0F4-4142-8145-6942DC29A353@gmail.com>
 <EB579DAE-B25F-4869-8529-8586DF4AECFF@gmail.com>
 <20181206102559.GG13538@hirez.programming.kicks-ass.net>
 <55B665E1-3F64-4D87-B779-D1B4AFE719A9@gmail.com>
 <20181207084550.GA2237@hirez.programming.kicks-ass.net>
 <C29C792A-3F47-482D-B0D8-99EABEDF8882@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend, changing title & adding lkml and some others ]

On Dec 7, 2018, at 3:12 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

[ We can start a new thread, since I have the tendency to hijack =
threads. ]

> On Dec 7, 2018, at 12:45 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Dec 06, 2018 at 09:26:24AM -0800, Nadav Amit wrote:
>>> On Dec 6, 2018, at 2:25 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> On Thu, Dec 06, 2018 at 12:28:26AM -0800, Nadav Amit wrote:
>>>> [ +Peter ]
>>>>=20

[snip]

>>>>=20
>>>> *But* there is one thing that may require some attention - patch
>>>> b59167ac7bafd ("x86/percpu: Fix this_cpu_read()=E2=80=9D) set =
ordering constraints
>>>> on the VM_ARGS() evaluation. And this patch also imposes, it =
appears,
>>>> (unnecessary) constraints on other pieces of code.
>>>>=20
>>>> These constraints are due to the addition of the volatile keyword =
for
>>>> this_cpu_read() by the patch. This affects at least 68 functions in =
my
>>>> kernel build, some of which are hot (I think), e.g., =
finish_task_switch(),
>>>> smp_x86_platform_ipi() and select_idle_sibling().
>>>>=20
>>>> Peter, perhaps the solution was too big of a hammer? Is it possible =
instead
>>>> to create a separate "this_cpu_read_once()=E2=80=9D with the =
volatile keyword? Such
>>>> a function can be used for native_sched_clock() and other seqlocks, =
etc.
>>>=20
>>> No. like the commit writes this_cpu_read() _must_ imply READ_ONCE(). =
If
>>> you want something else, use something else, there's plenty other
>>> options available.
>>>=20
>>> There's this_cpu_op_stable(), but also __this_cpu_read() and
>>> raw_this_cpu_read() (which currently don't differ from =
this_cpu_read()
>>> but could).
>>=20
>> Would setting the inline assembly memory operand both as input and =
output be
>> better than using the =E2=80=9Cvolatile=E2=80=9D?
>=20
> I don't know.. I'm forever befuddled by the exact semantics of gcc
> inline asm.
>=20
>> I think that If you do that, the compiler would should the =
this_cpu_read()
>> as something that changes the per-cpu-variable, which would make it =
invalid
>> to re-read the value. At the same time, it would not prevent =
reordering the
>> read with other stuff.
>=20
> So the thing is; as I wrote, the generic version of this_cpu_*() is:
>=20
> 	local_irq_save();
> 	__this_cpu_*();
> 	local_irq_restore();
>=20
> And per local_irq_{save,restore}() including compiler barriers that
> cannot be reordered around either.
>=20
> And per the principle of least surprise, I think our primitives should
> have similar semantics.

I guess so, but as you=E2=80=99ll see below, the end result is ugly.

> I'm actually having difficulty finding the this_cpu_read() in any of =
the
> functions you mention, so I cannot make any concrete suggestions other
> than pointing at the alternative functions available.


So I got deeper into the code to understand a couple of differences. In =
the
case of select_idle_sibling(), the patch (Peter=E2=80=99s) increase the =
function
code size by 123 bytes (over the baseline of 986). The per-cpu variable =
is
called through the following call chain:

	select_idle_sibling()
	=3D> select_idle_cpu()
	=3D> local_clock()
	=3D> raw_smp_processor_id()

And results in 2 more calls to sched_clock_cpu(), as the compiler =
assumes
the processor id changes in between (which obviously wouldn=E2=80=99t =
happen). There
may be more changes around, which I didn=E2=80=99t fully analyze. But =
the very least
reading the processor id should not get =E2=80=9Cvolatile=E2=80=9D.

As for finish_task_switch(), the impact is only few bytes, but still
unnecessary. It appears that with your patch preempt_count() causes =
multiple
reads of __preempt_count in this code:

       if (WARN_ONCE(preempt_count() !=3D 2*PREEMPT_DISABLE_OFFSET,
                     "corrupted preempt_count: %s/%d/0x%x\n",
                     current->comm, current->pid, preempt_count()))
               preempt_count_set(FORK_PREEMPT_COUNT);

Again, this is unwarranted, as the preemption count should not be =
changed in
any interrupt.


