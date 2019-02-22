Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808EE206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550879987;
	bh=9i+fJSxsvcPyl/bBZMHaPEm87EOWZnstOzHq8t/v/dU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LgW8+/2KtvanQas1LyP4L+RKFIXK9teXgQ5Q/gPh8LnxMugGWq5uPjdQXRE1VN3gH
	 21Q/U7tuTOKUzaVKm3VMAHYLNURbm83/oBn43SFCq68gUlu6NACBs/5mg7Pbxp0zrr
	 rYzxWh1Xzsv7BU2RjWHBhxv5B/Ah5X3k5KaCSwzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBVX7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfBVX7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:59:45 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F442207E0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550879983;
        bh=9i+fJSxsvcPyl/bBZMHaPEm87EOWZnstOzHq8t/v/dU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b16IPUjawWvGWMAUYmMUB1yAlaFNvRbb90XzWZFqdwhgTiL2ZpI4+aV1KChNi0+Ai
         cRM4Z3sjLyngjhOhLqoTsxCpCekQrdZI3r7wJwiHsr5r9z+k7IZgaIbTffkEb3xBYu
         t3DHdPN0b9FwbRpiVQg3PuonASCPdBnvdyHDNcAI=
Received: by mail-wm1-f51.google.com with SMTP id x7so3407953wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:59:43 -0800 (PST)
X-Gm-Message-State: AHQUAuZRK8bFvwAK09+gzS35RJSZJVMIL4QvpK0aK9YxvClkIyJleKCa
        FGLxoNDXUNS8qXvqIG9iq/krTMll8AgG7cFsAIunCQ==
X-Google-Smtp-Source: AHgI3IY/2RuuziBD5iwcfnfHWKN0CD+c8mR/evLt7Rx2yZacXRVyE8gRqqovVGmMRWfmU9urKfwfWhx6DSp8FuiaYiI=
X-Received: by 2002:a1c:a885:: with SMTP id r127mr4245848wme.74.1550879982079;
 Fri, 22 Feb 2019 15:59:42 -0800 (PST)
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
In-Reply-To: <CAG48ez1Dm04kg2x3O=OOmBFFBSDr+RmnhBYChcwYv5zLbPGudQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Feb 2019 15:59:30 -0800
X-Gmail-Original-Message-ID: <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com>
Message-ID: <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Jann Horn <jannh@google.com>
Cc:     Nadav Amit <namit@vmware.com>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 3:02 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Feb 22, 2019 at 11:39 PM Nadav Amit <namit@vmware.com> wrote:
> > > On Feb 22, 2019, at 2:21 PM, Nadav Amit <namit@vmware.com> wrote:
> > >
> > >> On Feb 22, 2019, at 2:17 PM, Jann Horn <jannh@google.com> wrote:
> > >>
> > >> On Fri, Feb 22, 2019 at 11:08 PM Nadav Amit <namit@vmware.com> wrote=
:
> > >>>> On Feb 22, 2019, at 1:43 PM, Jann Horn <jannh@google.com> wrote:
> > >>>>
> > >>>> (adding some people from the text_poke series to the thread, remov=
ing stable@)
> > >>>>
> > >>>> On Fri, Feb 22, 2019 at 8:55 PM Andy Lutomirski <luto@amacapital.n=
et> wrote:
> > >>>>>> On Feb 22, 2019, at 11:34 AM, Alexei Starovoitov <alexei.starovo=
itov@gmail.com> wrote:
> > >>>>>>> On Fri, Feb 22, 2019 at 02:30:26PM -0500, Steven Rostedt wrote:
> > >>>>>>> On Fri, 22 Feb 2019 11:27:05 -0800
> > >>>>>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >>>>>>>
> > >>>>>>>>> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrot=
e:
> > >>>>>>>>>
> > >>>>>>>>> Then we should still probably fix up "__probe_kernel_read()" =
to not
> > >>>>>>>>> allow user accesses. The easiest way to do that is actually l=
ikely to
> > >>>>>>>>> use the "unsafe_get_user()" functions *without* doing a
> > >>>>>>>>> uaccess_begin(), which will mean that modern CPU's will simpl=
y fault
> > >>>>>>>>> on a kernel access to user space.
> > >>>>>>>>
> > >>>>>>>> On bpf side the bpf_probe_read() helper just calls probe_kerne=
l_read()
> > >>>>>>>> and users pass both user and kernel addresses into it and expe=
ct
> > >>>>>>>> that the helper will actually try to read from that address.
> > >>>>>>>>
> > >>>>>>>> If __probe_kernel_read will suddenly start failing on all user=
 addresses
> > >>>>>>>> it will break the expectations.
> > >>>>>>>> How do we solve it in bpf_probe_read?
> > >>>>>>>> Call probe_kernel_read and if that fails call unsafe_get_user =
byte-by-byte
> > >>>>>>>> in the loop?
> > >>>>>>>> That's doable, but people already complain that bpf_probe_read=
() is slow
> > >>>>>>>> and shows up in their perf report.
> > >>>>>>>
> > >>>>>>> We're changing kprobes to add a specific flag to say that we wa=
nt to
> > >>>>>>> differentiate between kernel or user reads. Can this be done wi=
th
> > >>>>>>> bpf_probe_read()? If it's showing up in perf report, I doubt a =
single
> > >>>>>>
> > >>>>>> so you're saying you will break existing kprobe scripts?
> > >>>>>> I don't think it's a good idea.
> > >>>>>> It's not acceptable to break bpf_probe_read uapi.
> > >>>>>
> > >>>>> If so, the uapi is wrong: a long-sized number does not reliably i=
dentify an address if you don=E2=80=99t separately know whether it=E2=80=99=
s a user or kernel address. s390x and 4G:4G x86_32 are the notable exceptio=
ns. I have lobbied for RISC-V and future x86_64 to join the crowd.  I don=
=E2=80=99t know whether I=E2=80=99ll win this fight, but the uapi will prob=
ably have to change for at least s390x.
> > >>>>>
> > >>>>> What to do about existing scripts is a different question.
> > >>>>
> > >>>> This lack of logical separation between user and kernel addresses
> > >>>> might interact interestingly with the text_poke series, specifical=
ly
> > >>>> "[PATCH v3 05/20] x86/alternative: Initialize temporary mm for
> > >>>> patching" (https://na01.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-6-rick.p.edgecomb=
e%40intel.com%2F&amp;data=3D02%7C01%7Cnamit%40vmware.com%7Cf2513009ef734ecd=
6b0d08d69913a5ae%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C6368647070208=
21793&amp;sdata=3DHAbnDcrBne64JyPuVUMKmM7nQk67F%2BFvjuXEn8TmHeo%3D&amp;rese=
rved=3D0)
> > >>>> and "[PATCH v3 06/20] x86/alternative: Use temporary mm for text
> > >>>> poking" (https://na01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-7-rick.p.edgecombe%=
40intel.com%2F&amp;data=3D02%7C01%7Cnamit%40vmware.com%7Cf2513009ef734ecd6b=
0d08d69913a5ae%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636864707020821=
793&amp;sdata=3DvNRIMKtFDy%2F3z5FlTwDiJY6VGEV%2FMHgQPTdFSFtCo4s%3D&amp;rese=
rved=3D0),
> > >>>> right? If someone manages to get a tracing BPF program to trigger =
in a
> > >>>> task that has switched to the patching mm, could they use
> > >>>> bpf_probe_write_user() - which uses probe_kernel_write() after
> > >>>> checking that KERNEL_DS isn't active and that access_ok() passes -=
 to
> > >>>> overwrite kernel text that is mapped writable in the patching mm?
> > >>>
> > >>> Yes, this is a good point. I guess text_poke() should be defined wi=
th
> > >>> =E2=80=9C__kprobes=E2=80=9D and open-code memcpy.
> > >>>
> > >>> Does it sound reasonable?
> > >>
> > >> Doesn't __text_poke() as implemented in the proposed patch use a
> > >> couple other kernel functions, too? Like switch_mm_irqs_off() and
> > >> pte_clear() (which can be a call into a separate function on paravir=
t
> > >> kernels)?
> > >
> > > I will move the pte_clear() to be done after the poking mm was unload=
ed.
> > > Give me a few minutes to send a sketch of what I think should be done=
.
> >
> > Err.. You are right, I don=E2=80=99t see an easy way of preventing a kp=
robe from
> > being set on switch_mm_irqs_off(), and open-coding this monster is too =
ugly.
> >
> > The reasonable solution seems to me as taking all the relevant pieces o=
f
> > code (and data) that might be used during text-poking and encapsulating=
 them, so they
> > will be set in a memory area which cannot be kprobe'd. This can also be
> > useful to write-protect data structures of code that calls text_poke(),
> > e.g., static-keys. It can also protect data on that stack that is used
> > during text_poke() from being overwritten from another core.
> >
> > This solution is somewhat similar to Igor Stoppa=E2=80=99s idea of usin=
g =E2=80=9Cenclaves=E2=80=9D
> > when doing write-rarely operations.
> >
> > Right now, I think that text_poke() will keep being susceptible to such
> > an attack, unless you have a better suggestion.
>
> A relatively simple approach might be to teach BPF not to run kprobe
> programs and such in contexts where current->mm isn't the active mm?
> Maybe using nmi_uaccess_okay(), or something like that? It looks like
> perf_callchain_user() also already uses that. Except that a lot of
> this code is x86-specific...

This sounds like exactly the right solution.  If you're running from
some unknown context (like NMI or tracing), then you should check
nmi_uaccess_okay().  I think we should just promote that to be a
non-arch-specific function (that returns true by default) and check it
the relevant bpf_probe_xyz() functions.

Alexei, does that seem reasonable?
