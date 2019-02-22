Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90443C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527102070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5ucNaia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfBVVoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:44:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40631 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfBVVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:44:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id v20so3131567otk.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TmTUsQ8XYUbIhhW4ZG6z7ZfoyslHkigDRwfEZjlBtWg=;
        b=E5ucNaiahbWOvWQnQxHVMiSiVOL490gB69EwrBwV4O08ZN/oqXuL+AdJRoMLN8X7xI
         Tv5XrAa+mZHstKQK1F7pDJTdRMlF8fbOqjwzu3iqkL6QjqFrnYdBzZdPfK/jZkkEgfxT
         RKh4yEbUFa5HdYYIKRiepIx0iRdZ5J1B6C1fvGjLTXABoOFlvJ25tCyP8CZ/KLMv3LDj
         ODbjhpun4kLZp2SUVTPLoydHPDFxHPnuLlLI/KOdjE5fzlohka+Sm8Fxmjhuiz9OktwC
         bN8/R4QcCziOA3rhRgjino34wGQYjodTmP6xgtfvpo6/RymMS2ibCdQZUSqOl8S4KHPj
         gBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TmTUsQ8XYUbIhhW4ZG6z7ZfoyslHkigDRwfEZjlBtWg=;
        b=Wq1ZkYfk8kWCGz3tIPpub3E4E+cIIOyh+SokGtWieuLkntx5BgrdiW2Bbi112WEEiN
         DlNEvXdbmBfJtzpc23QTuxO98xo6bKb+ZZSx5mXBlWLuls/ZLESti36xJbxDFENWYHYT
         oYLf89O5zPFz0Ktfy2gKpvjT5bN7sfFY5m5hy9WZLY/1s3zTLbQH1PCrXr4g+y8lT6ug
         TX7cusnlrJxifR18agRxdVXJQRE9UGsVOWBYAKkJJgELzgaJBykdzz60nJveo7JrfbVv
         qpK0JuzuvPVmsbDPNBKDbZ7xRtNlrGbkaOscK71har7nRP8E7/93hUdD3QOEQ+3m9Zk/
         DX7Q==
X-Gm-Message-State: AHQUAuanaJKLtmtRRVOxLblht6s8dZFMROyOP5b+2Ro7seXiDZ3Diq9U
        PPIgneMlB8ffcR7iHNuh57huIEyOFBAUC+RsARa1PpwPCbHnDw==
X-Google-Smtp-Source: AHgI3Ia2rqW+/h8CmfnoQj31NCoJyOFGNssBPyMJ5IrA4860J9GeGkF3FMQgFGe7T6j3DMn1A2Fr0VrGqo4XSCXAJWQ=
X-Received: by 2002:a9d:6c84:: with SMTP id c4mr4082257otr.242.1550871861197;
 Fri, 22 Feb 2019 13:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <20190222143026.17d6f0f6@gandalf.local.home> <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
 <9E670A9A-699C-4B65-962F-CE1AEFD72974@amacapital.net>
In-Reply-To: <9E670A9A-699C-4B65-962F-CE1AEFD72974@amacapital.net>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Feb 2019 22:43:54 +0100
Message-ID: <CAG48ez2tVwzhKPu1tvK+E52jUCq5vTwjssrtMaGuCO=kMpSXGw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        bpf@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding some people from the text_poke series to the thread, removing stabl=
e@)

On Fri, Feb 22, 2019 at 8:55 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> > On Feb 22, 2019, at 11:34 AM, Alexei Starovoitov <alexei.starovoitov@gm=
ail.com> wrote:
> >> On Fri, Feb 22, 2019 at 02:30:26PM -0500, Steven Rostedt wrote:
> >> On Fri, 22 Feb 2019 11:27:05 -0800
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >>
> >>>> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> >>>>
> >>>> Then we should still probably fix up "__probe_kernel_read()" to not
> >>>> allow user accesses. The easiest way to do that is actually likely t=
o
> >>>> use the "unsafe_get_user()" functions *without* doing a
> >>>> uaccess_begin(), which will mean that modern CPU's will simply fault
> >>>> on a kernel access to user space.
> >>>
> >>> On bpf side the bpf_probe_read() helper just calls probe_kernel_read(=
)
> >>> and users pass both user and kernel addresses into it and expect
> >>> that the helper will actually try to read from that address.
> >>>
> >>> If __probe_kernel_read will suddenly start failing on all user addres=
ses
> >>> it will break the expectations.
> >>> How do we solve it in bpf_probe_read?
> >>> Call probe_kernel_read and if that fails call unsafe_get_user byte-by=
-byte
> >>> in the loop?
> >>> That's doable, but people already complain that bpf_probe_read() is s=
low
> >>> and shows up in their perf report.
> >>
> >> We're changing kprobes to add a specific flag to say that we want to
> >> differentiate between kernel or user reads. Can this be done with
> >> bpf_probe_read()? If it's showing up in perf report, I doubt a single
> >
> > so you're saying you will break existing kprobe scripts?
> > I don't think it's a good idea.
> > It's not acceptable to break bpf_probe_read uapi.
> >
>
> If so, the uapi is wrong: a long-sized number does not reliably identify =
an address if you don=E2=80=99t separately know whether it=E2=80=99s a user=
 or kernel address. s390x and 4G:4G x86_32 are the notable exceptions. I ha=
ve lobbied for RISC-V and future x86_64 to join the crowd.  I don=E2=80=99t=
 know whether I=E2=80=99ll win this fight, but the uapi will probably have =
to change for at least s390x.
>
> What to do about existing scripts is a different question.

This lack of logical separation between user and kernel addresses
might interact interestingly with the text_poke series, specifically
"[PATCH v3 05/20] x86/alternative: Initialize temporary mm for
patching" (https://lore.kernel.org/lkml/20190221234451.17632-6-rick.p.edgec=
ombe@intel.com/)
and "[PATCH v3 06/20] x86/alternative: Use temporary mm for text
poking" (https://lore.kernel.org/lkml/20190221234451.17632-7-rick.p.edgecom=
be@intel.com/),
right? If someone manages to get a tracing BPF program to trigger in a
task that has switched to the patching mm, could they use
bpf_probe_write_user() - which uses probe_kernel_write() after
checking that KERNEL_DS isn't active and that access_ok() passes - to
overwrite kernel text that is mapped writable in the patching mm?
