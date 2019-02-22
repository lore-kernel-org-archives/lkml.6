Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09856C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C507620675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SL0/TkWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfBVWST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:18:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42820 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVWSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:18:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id i5so3180272oto.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NKBOUe4Z87PihIW/Oq4UnkWIjxrxPR2My4hzeBYqK5M=;
        b=SL0/TkWyaLtzfIMAmW9AR6Eu1ol+YLIgN3w9c02OwzXGC3pSG3JoPQvZmm7eV5eIgo
         JfBtoT/66tEX2M0xrpHurwqZdSxnL00bhQHyLR7Oc4bVyoTtbDRkYV29RLCy3JrcF0ml
         UjEuXaF5yKF7q+FwTksr4piig1wsn8Z0ENwT7Fp36CcOSV47/YmLZAEdzwcalFewwmNo
         iwBLdz1XvSiR4Nyu7zYC5YYFhlDdIJqb14jzbRGOpkdHdy29Xe+Z4qNu0HWVMSxO/WXV
         j2jx/fssigIfRJ9aJNnugcslwepqdH4DuiCpZp5jiSDS3FhKwJlekZo4QwIG5CKp3C0V
         2mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NKBOUe4Z87PihIW/Oq4UnkWIjxrxPR2My4hzeBYqK5M=;
        b=Z7AVPWo5plETJW2Cixmn88mg9NoTVhELvxRRNkXNsvxQaUSvgmO5hEsrkS312X+gOD
         mwlJMO5gtg4/qIcMWTjeQAQVx3LiAJgazC9AnF3/tlawKRtQapseWvdGxaD373a0N/0w
         RyMNG2dpz7zPUuiNuHB07INuQbBa9UeVEYoSC3/8tvzykXxGcRr/qenH1jtP8gGaGdti
         tKKmZNW8Z0a7Z62oHFD6E6hlVcFt3ZZJ9ir6Xggkh8gvxATLkZFuxPf6fJyJ3oRwk10u
         H18loVZtPY6YEbRna/oj2fZgh4GGVM1mygoZPFqd/kkbFQjs8uZMtYTu37qcFInA7TeL
         OhUA==
X-Gm-Message-State: AHQUAuYVfe6A2weQwg7uEc1lKnSfmDf+SMEXg3+AYHGw0+ELnupLh+n/
        w6nd0HfWGuBZto5Wjs/+sCTg6ASbElMgq3b3+TCxXw==
X-Google-Smtp-Source: AHgI3IZkqmh0Dhhx+55L61ufYQ5vSjwy/gJOpFZia9RuqDSRg/0guweCfX1mKfFYHYaAc7ywtsSUhO+xQetLRRu63nM=
X-Received: by 2002:a05:6830:14d6:: with SMTP id t22mr4297446otq.255.1550873897129;
 Fri, 22 Feb 2019 14:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <20190222143026.17d6f0f6@gandalf.local.home> <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
 <9E670A9A-699C-4B65-962F-CE1AEFD72974@amacapital.net> <CAG48ez2tVwzhKPu1tvK+E52jUCq5vTwjssrtMaGuCO=kMpSXGw@mail.gmail.com>
 <0ED6836E-3432-4E1C-BABC-BEA6BDD36287@vmware.com>
In-Reply-To: <0ED6836E-3432-4E1C-BABC-BEA6BDD36287@vmware.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Feb 2019 23:17:50 +0100
Message-ID: <CAG48ez10RH2YhQ0wnEDOpKoGjrociq+zK0En6Aq06Yg9W3o5aQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:08 PM Nadav Amit <namit@vmware.com> wrote:
> > On Feb 22, 2019, at 1:43 PM, Jann Horn <jannh@google.com> wrote:
> >
> > (adding some people from the text_poke series to the thread, removing s=
table@)
> >
> > On Fri, Feb 22, 2019 at 8:55 PM Andy Lutomirski <luto@amacapital.net> w=
rote:
> >>> On Feb 22, 2019, at 11:34 AM, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:
> >>>> On Fri, Feb 22, 2019 at 02:30:26PM -0500, Steven Rostedt wrote:
> >>>> On Fri, 22 Feb 2019 11:27:05 -0800
> >>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>>>> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> >>>>>>
> >>>>>> Then we should still probably fix up "__probe_kernel_read()" to no=
t
> >>>>>> allow user accesses. The easiest way to do that is actually likely=
 to
> >>>>>> use the "unsafe_get_user()" functions *without* doing a
> >>>>>> uaccess_begin(), which will mean that modern CPU's will simply fau=
lt
> >>>>>> on a kernel access to user space.
> >>>>>
> >>>>> On bpf side the bpf_probe_read() helper just calls probe_kernel_rea=
d()
> >>>>> and users pass both user and kernel addresses into it and expect
> >>>>> that the helper will actually try to read from that address.
> >>>>>
> >>>>> If __probe_kernel_read will suddenly start failing on all user addr=
esses
> >>>>> it will break the expectations.
> >>>>> How do we solve it in bpf_probe_read?
> >>>>> Call probe_kernel_read and if that fails call unsafe_get_user byte-=
by-byte
> >>>>> in the loop?
> >>>>> That's doable, but people already complain that bpf_probe_read() is=
 slow
> >>>>> and shows up in their perf report.
> >>>>
> >>>> We're changing kprobes to add a specific flag to say that we want to
> >>>> differentiate between kernel or user reads. Can this be done with
> >>>> bpf_probe_read()? If it's showing up in perf report, I doubt a singl=
e
> >>>
> >>> so you're saying you will break existing kprobe scripts?
> >>> I don't think it's a good idea.
> >>> It's not acceptable to break bpf_probe_read uapi.
> >>
> >> If so, the uapi is wrong: a long-sized number does not reliably identi=
fy an address if you don=E2=80=99t separately know whether it=E2=80=99s a u=
ser or kernel address. s390x and 4G:4G x86_32 are the notable exceptions. I=
 have lobbied for RISC-V and future x86_64 to join the crowd.  I don=E2=80=
=99t know whether I=E2=80=99ll win this fight, but the uapi will probably h=
ave to change for at least s390x.
> >>
> >> What to do about existing scripts is a different question.
> >
> > This lack of logical separation between user and kernel addresses
> > might interact interestingly with the text_poke series, specifically
> > "[PATCH v3 05/20] x86/alternative: Initialize temporary mm for
> > patching" (https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-6-rick.p.edgecombe%40i=
ntel.com%2F&amp;data=3D02%7C01%7Cnamit%40vmware.com%7Cd44d6f0765dd49b20db70=
8d6990ee7e8%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636864686717142892=
&amp;sdata=3DgVALdkEULEhj4iJNEWAGxyYWe2lxnHRdamW5ZA2A5RQ%3D&amp;reserved=3D=
0)
> > and "[PATCH v3 06/20] x86/alternative: Use temporary mm for text
> > poking" (https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-7-rick.p.edgecombe%40int=
el.com%2F&amp;data=3D02%7C01%7Cnamit%40vmware.com%7Cd44d6f0765dd49b20db708d=
6990ee7e8%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636864686717142892&a=
mp;sdata=3Dnu2J1FtJsZJmt53SKJz8C8ktWE9eycwdAA%2BiCi1TfCc%3D&amp;reserved=3D=
0),
> > right? If someone manages to get a tracing BPF program to trigger in a
> > task that has switched to the patching mm, could they use
> > bpf_probe_write_user() - which uses probe_kernel_write() after
> > checking that KERNEL_DS isn't active and that access_ok() passes - to
> > overwrite kernel text that is mapped writable in the patching mm?
>
> Yes, this is a good point. I guess text_poke() should be defined with
> =E2=80=9C__kprobes=E2=80=9D and open-code memcpy.
>
> Does it sound reasonable?

Doesn't __text_poke() as implemented in the proposed patch use a
couple other kernel functions, too? Like switch_mm_irqs_off() and
pte_clear() (which can be a call into a separate function on paravirt
kernels)?
