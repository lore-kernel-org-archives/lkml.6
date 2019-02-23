Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C17C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569C920651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BXGnY8ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfBWAJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:09:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33188 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfBWAJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:09:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id z7so2843858lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 16:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfPdBRc9tHlVx4731kzoTxYm9oHOsR9CfjKri/wmKro=;
        b=BXGnY8uguxJoyc8/1beXM666q65BcuL7j71qhPOZoQUyrJTsEoBKigunyokVuT5Sla
         4ZSIiA9wLPQk8l0PVwcbkAN6IHjqJgRLEWbiMC6B1kscR3ZELS9Pz/ujsOgRDUjwp2jT
         E29kxlYkUCPPjzT/j1SLuTWgPw6Jk+sZ74gY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfPdBRc9tHlVx4731kzoTxYm9oHOsR9CfjKri/wmKro=;
        b=lHoojhowMQAv8VMphLeC54G4Ga/QhSA4rmKXGL1T8mASg4rx0T6pY5ra0AmALOMj1I
         8ttKcAy4bFQwkpDgB7n+whlu/HXzaTvfooRZwy4OK6YL5h1V1GktMsBM6h2MPQ9hVWSm
         wZLOV1VMkjI0J36zM0Mx1Fd2euMzg+xVEFUW3eN8oTPA56K/flNcg+8Ovz46os8X1MZs
         g8RrlOf/sJ3tq9pwzMYOtq2dI0tFWH3QqoJehtndFJDG2E3+5pQ9r8rT2D7XXuPiM7u6
         Y7PTlhk61i+07fWw7EKithSRa0DpxRcEeqMoO5DkxAKiqSKdWtVpO+QFfkKPJxJauBPt
         8Rlg==
X-Gm-Message-State: AHQUAuZQUGcdFyxuY6g/qckd8cb8hwwJr+khS05c5WwvIuWRtnfkrRBJ
        jyzKMuIRPZAALEIIL7WBciNLq3f0uVQ=
X-Google-Smtp-Source: AHgI3IY83Pp9vlkqdGx9dv7u6U8vls41eNN106ADPgU7l/Vl7UAp5Eo9oPRXVuDFsY8OfcamqS9B5g==
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr3722904ljk.169.1550880558946;
        Fri, 22 Feb 2019 16:09:18 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id p22sm828381ljb.93.2019.02.22.16.09.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:09:16 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id l5so3055192lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 16:09:16 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr3689553lji.125.1550880555567;
 Fri, 22 Feb 2019 16:09:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net> <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
 <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com> <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 16:08:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whu_iwv4TQP5Xd62bTfWW-uswVecUbFeiSCuTWnH1xgPg@mail.gmail.com>
Message-ID: <CAHk-=whu_iwv4TQP5Xd62bTfWW-uswVecUbFeiSCuTWnH1xgPg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 3:56 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> It will preserve existing bpf_probe_read() behavior on x86.

... but that's the worst possible situation.

It appears that people haven't understood that kernel and user
addresses are distinct, and may have written programs that are
fundamentally buggy.

And we _want_ to make it clear that they are buggy on x86-64, exactly
because x86-64 is the one that gets the most testing - by far.

So if x86-64 continues working for buggy programs, then that only
means that those bugs never get fixed.

It would be much better to try to get those things fixed, and make the
x86-64 implementation stricter, exactly so that people end up
_realizing_ that they can't just think "a pointer is a pointer, and
the context doesn't matter".

From a pure functional safety standpoint, I thought bpf already knew
what kind of a pointer it had?

                   Linus
