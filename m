Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8110AC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3D720652
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551036925;
	bh=Z4fFhJayjI+pWMaIH9gqLO/UBhQv5xQdBO9pJne0bXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Apf59jlxc/QOWl0Ujakwp2E5LHa8185kCmkVNdVJ0vNg6sqnZBxpEW3awjLta9BRE
	 BRpGSRgxcAgof6VsW6OH3O8dwd6zD841UvAPWEBiwGuQiZR9VVkmVN/nR5031ONDeU
	 sbm3RUhzj/mDSAUo/YAog9I/RHQYz03Up5lvm88Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfBXTfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBXTfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:35:23 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACBAE20989
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551036922;
        bh=Z4fFhJayjI+pWMaIH9gqLO/UBhQv5xQdBO9pJne0bXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1HuXWcIMR0ll9ZyKRv/UfTYbrjIn1Onwx2s52Mn97LR8uDMYzezNriAhmF2xrvqF
         Po4cquAXMqlDdFOO5CLBMcK1agw2anH8h92UHbGfQNWRgJLSyqxTYCMiYexKj3SZjU
         9ZRRFzSxoMWITrt0AeJCiTfvyAcLCcdpWncx1khc=
Received: by mail-wm1-f44.google.com with SMTP id x10so6111558wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 11:35:21 -0800 (PST)
X-Gm-Message-State: AHQUAuaMGdrfUdSn/adyDXz60knjiPiSxvbdW41QHnSEmz08G26MET+h
        /J3bpZp4NFVWqcG26v7oH4/NY6kcZDfBhwMkOwdmzw==
X-Google-Smtp-Source: AHgI3Ib+fwHZCkZEujoKcNWZ7EMTRdiYrRdwgkDsy+I84m2xp5lc3uDHq+cU4U3tDNHSqD61ihrZRhvJ5w7FMrBsDDg=
X-Received: by 2002:a1c:a885:: with SMTP id r127mr9086487wme.74.1551036920000;
 Sun, 24 Feb 2019 11:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <20190222143026.17d6f0f6@gandalf.local.home> <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
 <9E670A9A-699C-4B65-962F-CE1AEFD72974@amacapital.net> <CAG48ez2tVwzhKPu1tvK+E52jUCq5vTwjssrtMaGuCO=kMpSXGw@mail.gmail.com>
 <0ED6836E-3432-4E1C-BABC-BEA6BDD36287@vmware.com> <CAG48ez10RH2YhQ0wnEDOpKoGjrociq+zK0En6Aq06Yg9W3o5aQ@mail.gmail.com>
 <7701651F-F10E-4212-925E-1CB77C5D3E69@vmware.com> <A7232EDD-C53C-4B7D-AD02-4A480F40538B@vmware.com>
 <CAG48ez1Dm04kg2x3O=OOmBFFBSDr+RmnhBYChcwYv5zLbPGudQ@mail.gmail.com>
 <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com> <7E4E5362-4C13-40FA-B5A8-F88D3E60827F@vmware.com>
In-Reply-To: <7E4E5362-4C13-40FA-B5A8-F88D3E60827F@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 24 Feb 2019 11:35:08 -0800
X-Gmail-Original-Message-ID: <CALCETrWJ0RUxpDw=Th3JBUGBhwFKHzELS+oOwjekSDwYjqMGzA@mail.gmail.com>
Message-ID: <CALCETrWJ0RUxpDw=Th3JBUGBhwFKHzELS+oOwjekSDwYjqMGzA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 12:30 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Feb 22, 2019, at 3:59 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Feb 22, 2019 at 3:02 PM Jann Horn <jannh@google.com> wrote:
> >> On Fri, Feb 22, 2019 at 11:39 PM Nadav Amit <namit@vmware.com> wrote:
> >>>> On Feb 22, 2019, at 2:21 PM, Nadav Amit <namit@vmware.com> wrote:
> >>>>
> >>>>> On Feb 22, 2019, at 2:17 PM, Jann Horn <jannh@google.com> wrote:
> >>>>>
> >>>>> On Fri, Feb 22, 2019 at 11:08 PM Nadav Amit <namit@vmware.com> wrot=
e:
> >>>>>>> On Feb 22, 2019, at 1:43 PM, Jann Horn <jannh@google.com> wrote:
> >>>>>>>
> >>>>>>> (adding some people from the text_poke series to the thread, remo=
ving stable@)
> >>>>>>>
> >>>>>>> On Fri, Feb 22, 2019 at 8:55 PM Andy Lutomirski <luto@amacapital.=
net> wrote:
> >>>>>>>>> On Feb 22, 2019, at 11:34 AM, Alexei Starovoitov <alexei.starov=
oitov@gmail.com> wrote:
> >>>>>>>>>> On Fri, Feb 22, 2019 at 02:30:26PM -0500, Steven Rostedt wrote=
:
> >>>>>>>>>> On Fri, 22 Feb 2019 11:27:05 -0800
> >>>>>>>>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>>> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wro=
te:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Then we should still probably fix up "__probe_kernel_read()"=
 to not
> >>>>>>>>>>>> allow user accesses. The easiest way to do that is actually =
likely to
> >>>>>>>>>>>> use the "unsafe_get_user()" functions *without* doing a
> >>>>>>>>>>>> uaccess_begin(), which will mean that modern CPU's will simp=
ly fault
> >>>>>>>>>>>> on a kernel access to user space.
> >>>>>>>>>>>
> >>>>>>>>>>> On bpf side the bpf_probe_read() helper just calls probe_kern=
el_read()
> >>>>>>>>>>> and users pass both user and kernel addresses into it and exp=
ect
> >>>>>>>>>>> that the helper will actually try to read from that address.
> >>>>>>>>>>>
> >>>>>>>>>>> If __probe_kernel_read will suddenly start failing on all use=
r addresses
> >>>>>>>>>>> it will break the expectations.
> >>>>>>>>>>> How do we solve it in bpf_probe_read?
> >>>>>>>>>>> Call probe_kernel_read and if that fails call unsafe_get_user=
 byte-by-byte
> >>>>>>>>>>> in the loop?
> >>>>>>>>>>> That's doable, but people already complain that bpf_probe_rea=
d() is slow
> >>>>>>>>>>> and shows up in their perf report.
> >>>>>>>>>>
> >>>>>>>>>> We're changing kprobes to add a specific flag to say that we w=
ant to
> >>>>>>>>>> differentiate between kernel or user reads. Can this be done w=
ith
> >>>>>>>>>> bpf_probe_read()? If it's showing up in perf report, I doubt a=
 single
> >>>>>>>>>
> >>>>>>>>> so you're saying you will break existing kprobe scripts?
> >>>>>>>>> I don't think it's a good idea.
> >>>>>>>>> It's not acceptable to break bpf_probe_read uapi.
> >>>>>>>>
> >>>>>>>> If so, the uapi is wrong: a long-sized number does not reliably =
identify an address if you don=E2=80=99t separately know whether it=E2=80=
=99s a user or kernel address. s390x and 4G:4G x86_32 are the notable excep=
tions. I have lobbied for RISC-V and future x86_64 to join the crowd.  I do=
n=E2=80=99t know whether I=E2=80=99ll win this fight, but the uapi will pro=
bably have to change for at least s390x.
> >>>>>>>>
> >>>>>>>> What to do about existing scripts is a different question.
> >>>>>>>
> >>>>>>> This lack of logical separation between user and kernel addresses
> >>>>>>> might interact interestingly with the text_poke series, specifica=
lly
> >>>>>>> "[PATCH v3 05/20] x86/alternative: Initialize temporary mm for
> >>>>>>> patching" (https://na01.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-6-rick.p.edgecom=
be%40intel.com%2F&amp;data=3D02%7C01%7Cnamit%40vmware.com%7Cbab53e52cc5c4ac=
4419008d69921d1f1%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636864767879=
731941&amp;sdata=3D2tqD7udTCfNbcNLcj5SFpZt8WwK5NwtgaWMKm1Ye1EE%3D&amp;reser=
ved=3D0)
> >>>>>>> and "[PATCH v3 06/20] x86/alternative: Use temporary mm for text
> >>>>>>> poking" (https://na01.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-7-rick.p.edgecombe=
%40intel.com%2F&amp;data=3D02%7C01%7Cnamit%40vmware.com%7Cbab53e52cc5c4ac44=
19008d69921d1f1%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C63686476787973=
1941&amp;sdata=3D7%2BLShgLKnra6xzSkxdJrCclCacfdE5IdczwScW83nuE%3D&amp;reser=
ved=3D0),
> >>>>>>> right? If someone manages to get a tracing BPF program to trigger=
 in a
> >>>>>>> task that has switched to the patching mm, could they use
> >>>>>>> bpf_probe_write_user() - which uses probe_kernel_write() after
> >>>>>>> checking that KERNEL_DS isn't active and that access_ok() passes =
- to
> >>>>>>> overwrite kernel text that is mapped writable in the patching mm?
> >>>>>>
> >>>>>> Yes, this is a good point. I guess text_poke() should be defined w=
ith
> >>>>>> =E2=80=9C__kprobes=E2=80=9D and open-code memcpy.
> >>>>>>
> >>>>>> Does it sound reasonable?
> >>>>>
> >>>>> Doesn't __text_poke() as implemented in the proposed patch use a
> >>>>> couple other kernel functions, too? Like switch_mm_irqs_off() and
> >>>>> pte_clear() (which can be a call into a separate function on paravi=
rt
> >>>>> kernels)?
> >>>>
> >>>> I will move the pte_clear() to be done after the poking mm was unloa=
ded.
> >>>> Give me a few minutes to send a sketch of what I think should be don=
e.
> >>>
> >>> Err.. You are right, I don=E2=80=99t see an easy way of preventing a =
kprobe from
> >>> being set on switch_mm_irqs_off(), and open-coding this monster is to=
o ugly.
> >>>
> >>> The reasonable solution seems to me as taking all the relevant pieces=
 of
> >>> code (and data) that might be used during text-poking and encapsulati=
ng them, so they
> >>> will be set in a memory area which cannot be kprobe'd. This can also =
be
> >>> useful to write-protect data structures of code that calls text_poke(=
),
> >>> e.g., static-keys. It can also protect data on that stack that is use=
d
> >>> during text_poke() from being overwritten from another core.
> >>>
> >>> This solution is somewhat similar to Igor Stoppa=E2=80=99s idea of us=
ing =E2=80=9Cenclaves=E2=80=9D
> >>> when doing write-rarely operations.
> >>>
> >>> Right now, I think that text_poke() will keep being susceptible to su=
ch
> >>> an attack, unless you have a better suggestion.
> >>
> >> A relatively simple approach might be to teach BPF not to run kprobe
> >> programs and such in contexts where current->mm isn't the active mm?
> >> Maybe using nmi_uaccess_okay(), or something like that? It looks like
> >> perf_callchain_user() also already uses that. Except that a lot of
> >> this code is x86-specific...
> >
> > This sounds like exactly the right solution.  If you're running from
> > some unknown context (like NMI or tracing), then you should check
> > nmi_uaccess_okay().  I think we should just promote that to be a
> > non-arch-specific function (that returns true by default) and check it
> > the relevant bpf_probe_xyz() functions.
>
> I can do that, but notice that switch_mm_irqs_off() writes to
> cpu_tlbstate.loaded_mm before it actually writes to CR3. So there are sti=
ll
> a couple of instructions (and the load_new_mm_cr3()) in between that a
> kprobe can be set on, no?

But you can't mark then as no-nmi :)  See the comment in
nmi_uaccess_ok() -- the code is intended to work correctly during this
window.
