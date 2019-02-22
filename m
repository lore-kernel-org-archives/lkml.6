Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E85C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD57206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpU5o/wY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfBVXDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:03:00 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39493 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfBVXDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:03:00 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so3283577otl.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VH7sUO3z274/3fYikuxdx8bVqVHCGGGqsjmArU7QSys=;
        b=ZpU5o/wYmuWtJ/O7fA9HFsqYKPhBMakcOuo/bXvVoPpmOQcqWqSjGi+Aj+TOROGjlG
         TvZupjJOirJELYb8LnoWuyNG5BWqzUO82yTzdWcHiH5r4YR3aRtWLY8YyNqVBaoOsxgK
         zCqV85f68pIG/CVP6ZIQUvifWnKAJCGqSJVqlsQJ22S4YwbfjRVb5S2hjDc9LK5FaVpq
         xg+zdZ/CxKiZFTk9tyVCpEr5R10ImQkeJgMJ+otdg6Fm7qdwsII7ABtMvVg0m+iNr47j
         FWKMku3HLXKKxlPMjp7xbg8CXQNPjcAwIZLjU621Kk3Ecm5utyZeZ5k+JtdfGw0I6lrE
         zMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VH7sUO3z274/3fYikuxdx8bVqVHCGGGqsjmArU7QSys=;
        b=Uey6cszpb9d4Vl2sfcG3OFUwaxiUyfrEoKCIYHCp6HoXxYKVzlMhfbR6eh1e/tOYp+
         cpr99xk+r6i87iTpE/xJt5h7xEB3Z0ar8WVd5kXFkswSpmOzOo2fh3Iz/cL9gDGS5l0y
         njFFuecIbQD3z5XfTXHhg4KFBEAb/GTKs51btUfg2mvTSC4vKCLMeMcvZr/SemuuyVNO
         QOchzYW1M49/WDLAFVEE+v8yLgivNwVouR1kDFqVr1nefx8TPYp4rj2qChEgaM3TEkfE
         0UBi7otlYg90kFLSpzu+QcPz7HmbWsxcykBdyvXpi43B99JiUG3uG5yHmk1ggZq+nzeq
         yETw==
X-Gm-Message-State: AHQUAuYZc4amjPmqvnfp8PlbkylLt8fh23u2a4S5vg58Ic/jpXVn7UhM
        PAXuQPC28oAvyn3pNP5FF5HZDOlHPxKpPEf6z7j3Tw==
X-Google-Smtp-Source: AHgI3IagGHnoZejMD3V/jVwyH06CWbX08nOlCQX5tIhNQg/iEvTU8FdWDXf+bswSbLUVfQZ2sr4p152E1VNXWG25sKQ=
X-Received: by 2002:a9d:6c84:: with SMTP id c4mr4263157otr.242.1550876578924;
 Fri, 22 Feb 2019 15:02:58 -0800 (PST)
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
In-Reply-To: <A7232EDD-C53C-4B7D-AD02-4A480F40538B@vmware.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 23 Feb 2019 00:02:31 +0100
Message-ID: <CAG48ez1Dm04kg2x3O=OOmBFFBSDr+RmnhBYChcwYv5zLbPGudQ@mail.gmail.com>
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:39 PM Nadav Amit <namit@vmware.com> wrote:
> > On Feb 22, 2019, at 2:21 PM, Nadav Amit <namit@vmware.com> wrote:
> >
> >> On Feb 22, 2019, at 2:17 PM, Jann Horn <jannh@google.com> wrote:
> >>
> >> On Fri, Feb 22, 2019 at 11:08 PM Nadav Amit <namit@vmware.com> wrote:
> >>>> On Feb 22, 2019, at 1:43 PM, Jann Horn <jannh@google.com> wrote:
> >>>>
> >>>> (adding some people from the text_poke series to the thread, removin=
g stable@)
> >>>>
> >>>> On Fri, Feb 22, 2019 at 8:55 PM Andy Lutomirski <luto@amacapital.net=
> wrote:
> >>>>>> On Feb 22, 2019, at 11:34 AM, Alexei Starovoitov <alexei.starovoit=
ov@gmail.com> wrote:
> >>>>>>> On Fri, Feb 22, 2019 at 02:30:26PM -0500, Steven Rostedt wrote:
> >>>>>>> On Fri, 22 Feb 2019 11:27:05 -0800
> >>>>>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >>>>>>>
> >>>>>>>>> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> >>>>>>>>>
> >>>>>>>>> Then we should still probably fix up "__probe_kernel_read()" to=
 not
> >>>>>>>>> allow user accesses. The easiest way to do that is actually lik=
ely to
> >>>>>>>>> use the "unsafe_get_user()" functions *without* doing a
> >>>>>>>>> uaccess_begin(), which will mean that modern CPU's will simply =
fault
> >>>>>>>>> on a kernel access to user space.
> >>>>>>>>
> >>>>>>>> On bpf side the bpf_probe_read() helper just calls probe_kernel_=
read()
> >>>>>>>> and users pass both user and kernel addresses into it and expect
> >>>>>>>> that the helper will actually try to read from that address.
> >>>>>>>>
> >>>>>>>> If __probe_kernel_read will suddenly start failing on all user a=
ddresses
> >>>>>>>> it will break the expectations.
> >>>>>>>> How do we solve it in bpf_probe_read?
> >>>>>>>> Call probe_kernel_read and if that fails call unsafe_get_user by=
te-by-byte
> >>>>>>>> in the loop?
> >>>>>>>> That's doable, but people already complain that bpf_probe_read()=
 is slow
> >>>>>>>> and shows up in their perf report.
> >>>>>>>
> >>>>>>> We're changing kprobes to add a specific flag to say that we want=
 to
> >>>>>>> differentiate between kernel or user reads. Can this be done with
> >>>>>>> bpf_probe_read()? If it's showing up in perf report, I doubt a si=
ngle
> >>>>>>
> >>>>>> so you're saying you will break existing kprobe scripts?
> >>>>>> I don't think it's a good idea.
> >>>>>> It's not acceptable to break bpf_probe_read uapi.
> >>>>>
> >>>>> If so, the uapi is wrong: a long-sized number does not reliably ide=
ntify an address if you don=E2=80=99t separately know whether it=E2=80=99s =
a user or kernel address. s390x and 4G:4G x86_32 are the notable exceptions=
. I have lobbied for RISC-V and future x86_64 to join the crowd.  I don=E2=
=80=99t know whether I=E2=80=99ll win this fight, but the uapi will probabl=
y have to change for at least s390x.
> >>>>>
> >>>>> What to do about existing scripts is a different question.
> >>>>
> >>>> This lack of logical separation between user and kernel addresses
> >>>> might interact interestingly with the text_poke series, specifically
> >>>> "[PATCH v3 05/20] x86/alternative: Initialize temporary mm for
> >>>> patching" (https://na01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-6-rick.p.edgecombe%=
40intel.com%2F&amp;data=3D02%7C01%7Cnamit%40vmware.com%7Cf2513009ef734ecd6b=
0d08d69913a5ae%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636864707020821=
793&amp;sdata=3DHAbnDcrBne64JyPuVUMKmM7nQk67F%2BFvjuXEn8TmHeo%3D&amp;reserv=
ed=3D0)
> >>>> and "[PATCH v3 06/20] x86/alternative: Use temporary mm for text
> >>>> poking" (https://na01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-7-rick.p.edgecombe%40=
intel.com%2F&amp;data=3D02%7C01%7Cnamit%40vmware.com%7Cf2513009ef734ecd6b0d=
08d69913a5ae%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C63686470702082179=
3&amp;sdata=3DvNRIMKtFDy%2F3z5FlTwDiJY6VGEV%2FMHgQPTdFSFtCo4s%3D&amp;reserv=
ed=3D0),
> >>>> right? If someone manages to get a tracing BPF program to trigger in=
 a
> >>>> task that has switched to the patching mm, could they use
> >>>> bpf_probe_write_user() - which uses probe_kernel_write() after
> >>>> checking that KERNEL_DS isn't active and that access_ok() passes - t=
o
> >>>> overwrite kernel text that is mapped writable in the patching mm?
> >>>
> >>> Yes, this is a good point. I guess text_poke() should be defined with
> >>> =E2=80=9C__kprobes=E2=80=9D and open-code memcpy.
> >>>
> >>> Does it sound reasonable?
> >>
> >> Doesn't __text_poke() as implemented in the proposed patch use a
> >> couple other kernel functions, too? Like switch_mm_irqs_off() and
> >> pte_clear() (which can be a call into a separate function on paravirt
> >> kernels)?
> >
> > I will move the pte_clear() to be done after the poking mm was unloaded=
.
> > Give me a few minutes to send a sketch of what I think should be done.
>
> Err.. You are right, I don=E2=80=99t see an easy way of preventing a kpro=
be from
> being set on switch_mm_irqs_off(), and open-coding this monster is too ug=
ly.
>
> The reasonable solution seems to me as taking all the relevant pieces of
> code (and data) that might be used during text-poking and encapsulating t=
hem, so they
> will be set in a memory area which cannot be kprobe'd. This can also be
> useful to write-protect data structures of code that calls text_poke(),
> e.g., static-keys. It can also protect data on that stack that is used
> during text_poke() from being overwritten from another core.
>
> This solution is somewhat similar to Igor Stoppa=E2=80=99s idea of using =
=E2=80=9Cenclaves=E2=80=9D
> when doing write-rarely operations.
>
> Right now, I think that text_poke() will keep being susceptible to such
> an attack, unless you have a better suggestion.

A relatively simple approach might be to teach BPF not to run kprobe
programs and such in contexts where current->mm isn't the active mm?
Maybe using nmi_uaccess_okay(), or something like that? It looks like
perf_callchain_user() also already uses that. Except that a lot of
this code is x86-specific...
