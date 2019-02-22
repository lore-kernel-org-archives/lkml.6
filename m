Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE057C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3A9206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EKghYf3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBVTze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:55:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33672 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfBVTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:55:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so1585940pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1ESzouTd9aSWneyfe8zSKSWmCjsDjjoGvrPNjmnih9s=;
        b=EKghYf3/ECMuQqiCphtTOBJR0bxnF42l29yQRcAy3OEWv6isIeIRgokWGvaAP8owCF
         f8ifYTA9dT4HUJbgauSO2vrSha1Tsd9PQ5I+veAtM1coa9GFz2S0cwo4YTyHEmlHLN2t
         7waBoUwWqs9XgbXHWRk9shroCL7o/4PKDvYFAPIdLVOMr9wSp/6eHZTxr1UBZDQUiEaw
         bC8quQvt5hekrUMsO6grwDKo2sBYWGwnb2T3nSHHndPa07KTDvn7/KwrPE11uYczMoZY
         EGGtYD+hhlywwuyKEXY/wMM8eRReroQvlgvQHHbWQ3aiRLv31qh8LCWWP9yLMFyEF5Ch
         HCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1ESzouTd9aSWneyfe8zSKSWmCjsDjjoGvrPNjmnih9s=;
        b=c8UI69XkHl3eHiR4+HAIrhSLc+08CCRzMWrThdZ3KYI5NhaUept2EicGXKZpLyyQVA
         xaV9ZRlY0ho61S7HuR3K/lZYdcQWYYeNeBYn4ST0VA29tjYrWsTf6ai+iXJKOu033v/O
         l1qNuaCxMZsXqVS5PMveJPnfcuVzSgKsnW0BPVopvox+FRqVj8WJQ4yOmIwVCGYQuVWq
         HijJ5haiuUmZjp0Sc4vg+qUWSucoEFjD62ANslf14GSQ0AQt1gqQH9yAXwEVgMYNlMg/
         yKxl7HGdBq4+KnD+wUKerUM6lIuoh/3gzUanq+hMeKhptcD5pVwCNcOg72MuuFgGTPI0
         b0YQ==
X-Gm-Message-State: AHQUAubKf5ivfhSDSMvsTX/CwDrbyQnYQVoim6dyi0bpOzjcDt8JUpgl
        TeiCp5QkftO+aO4hWqO4ElYzjw==
X-Google-Smtp-Source: AHgI3IYbHALC35fkk9jFV0wILUOoh9ZLE6OTYm+HLspqMvl+XYJjh3BGaGC4gEb8XCBBBNl+w2lBIQ==
X-Received: by 2002:a63:c042:: with SMTP id z2mr5560103pgi.307.1550865332963;
        Fri, 22 Feb 2019 11:55:32 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:6592:abd7:9236:4c2f? ([2601:646:c200:7429:6592:abd7:9236:4c2f])
        by smtp.gmail.com with ESMTPSA id s12sm3094320pfm.120.2019.02.22.11.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:55:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access kernel memory that can fault
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
Date:   Fri, 22 Feb 2019 11:55:31 -0800
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E670A9A-699C-4B65-962F-CE1AEFD72974@amacapital.net>
References: <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com> <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org> <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org> <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com> <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com> <20190222143026.17d6f0f6@gandalf.local.home> <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 22, 2019, at 11:34 AM, Alexei Starovoitov <alexei.starovoitov@gmail=
.com> wrote:
>=20
>> On Fri, Feb 22, 2019 at 02:30:26PM -0500, Steven Rostedt wrote:
>> On Fri, 22 Feb 2019 11:27:05 -0800
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>=20
>>>> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
>>>>=20
>>>> Then we should still probably fix up "__probe_kernel_read()" to not
>>>> allow user accesses. The easiest way to do that is actually likely to
>>>> use the "unsafe_get_user()" functions *without* doing a
>>>> uaccess_begin(), which will mean that modern CPU's will simply fault
>>>> on a kernel access to user space. =20
>>>=20
>>> On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
>>> and users pass both user and kernel addresses into it and expect
>>> that the helper will actually try to read from that address.
>>>=20
>>> If __probe_kernel_read will suddenly start failing on all user addresses=

>>> it will break the expectations.
>>> How do we solve it in bpf_probe_read?
>>> Call probe_kernel_read and if that fails call unsafe_get_user byte-by-by=
te
>>> in the loop?
>>> That's doable, but people already complain that bpf_probe_read() is slow=

>>> and shows up in their perf report.
>>=20
>> We're changing kprobes to add a specific flag to say that we want to
>> differentiate between kernel or user reads. Can this be done with
>> bpf_probe_read()? If it's showing up in perf report, I doubt a single
>=20
> so you're saying you will break existing kprobe scripts?
> I don't think it's a good idea.
> It's not acceptable to break bpf_probe_read uapi.
>=20

If so, the uapi is wrong: a long-sized number does not reliably identify an a=
ddress if you don=E2=80=99t separately know whether it=E2=80=99s a user or k=
ernel address. s390x and 4G:4G x86_32 are the notable exceptions. I have lob=
bied for RISC-V and future x86_64 to join the crowd.  I don=E2=80=99t know w=
hether I=E2=80=99ll win this fight, but the uapi will probably have to chang=
e for at least s390x.

What to do about existing scripts is a different question.=
