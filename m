Return-Path: <kernel-hardening-return-12789-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/NafilXC5eGm4q+xBa+xrjuzdI/n/8oRXymZEGUw4HYK9LcPRhVzTf9NbWSV3MUkZIU3Yx
ARC-Seal: i=1; a=rsa-sha256; t=1522225377; cv=none;
        d=google.com; s=arc-20160816;
        b=rw8Gg0soa6kQotOvgO5BAsJksLsIxwZUuq/SzMho6YWcxrNltFfXrsw1yoTsA32Cq6
         dnWpSvVFVfbHiUy3vF7G1eX5+uJhv3Wq3vXyUFoT5EJIEyape5C0npIPeJvsN+sGMlnA
         N4fmGlyDLQ+UXDmV7Mxb1/+QYjbYTxm/BCOK1V9mK/UlbL0cRPeAT3eVhXbSHPLqECVS
         GUe8ZcyQgcsiB2FYd7xyKt2BGxOoPQ8sAEnB8bFcuOqNIyGgJntw025SugzHpPl2ulkF
         bBOAcjv7GVeSVdKZQ4ABD8LpE7uUlwGLjeleJJnlbTnhkPuCUaDkV839yWl20QiYkYeF
         MJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=CNlgUjiPC5cg6TnLUiQgQW2fmtT1276c3f03mLWi/7I=;
        b=ZrZe2YMxwOUoEfudtc/NhoF10Z6FV3ocPrYNfdDuXJbW8A19FfPEju/1Icwauwgzzh
         Hl/o+vx9gejmu728siNH0oLMwCnVqBAl4SyjK7Qk5Edh58Yu1mk3vBT8tLvHD2ISP7o4
         KJ4h4I5L1u0Ktwdpu9d7eteDZNVvBFK8ukOpi26j+3C2INaBnSq3mVVMGFp3oXf3432v
         yZPsFQQLZDwGF8b65V4dJELI+BERUPkMlrI35cGCZJP1sXMgqRxO7DEdJMww5xKQesZv
         nialU0oNFcsbxTS4qNHYfTV8uLo3nvbTpz1aIbgWphyH+LVhR+Iyi7IedHZ5P9fG0v8W
         8BNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12789-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12789-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12789-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12789-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 28 Mar 2018 10:22:34 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
    LKML <linux-kernel@vger.kernel.org>,
    Segher Boessenkool <segher@kernel.crashing.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v2] rslib: Remove VLAs by setting upper bound on nroots
In-Reply-To: <CAGXu5j+7cG+BQQLfxSm8xLPzF1de7_+fU-s0R5ZXjfD0jx4c8w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803281020390.3247@nanos.tec.linutronix.de>
References: <20180315225919.GA43806@beast> <20180316155950.35fda7c63ec59277ba504201@linux-foundation.org> <CAGXu5jLAqki8oE7AF9BEwLxKzpTOOPsT1imjdSAG_U44uGXJdQ@mail.gmail.com> <CAGXu5j+utmcN_ot-3NJ-8C0onnu8O-DOdbAxVoatzE9UcJ-O4A@mail.gmail.com>
 <20180327164532.796cdd043fece53cd9b56f8f@linux-foundation.org> <CAGXu5j+7cG+BQQLfxSm8xLPzF1de7_+fU-s0R5ZXjfD0jx4c8w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595046396754035881?=
X-GMAIL-MSGID: =?utf-8?q?1596168996965260766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Mar 2018, Kees Cook wrote:
> On Tue, Mar 27, 2018 at 4:45 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Mon, 26 Mar 2018 16:17:57 -0700 Kees Cook <keescook@chromium.org> wrote:
> >
> >> On Fri, Mar 16, 2018 at 11:25 PM, Kees Cook <keescook@chromium.org> wrote:
> >> > On Fri, Mar 16, 2018 at 3:59 PM, Andrew Morton
> >> > <akpm@linux-foundation.org> wrote:
> >> >> On Thu, 15 Mar 2018 15:59:19 -0700 Kees Cook <keescook@chromium.org> wrote:
> >> >>
> >> >>> Avoid stack VLAs[1] by always allocating the upper bound of stack space
> >> >>> needed. The existing users of rslib appear to max out at 24 roots[2],
> >> >>> so use that as the upper bound until we have a reason to change it.
> >> >>>
> >> >>> Alternative considered: make init_rs() a true caller-instance and
> >> >>> pre-allocate the workspaces. This would possibly need locking and
> >> >>> a refactoring of the returned structure.
> >> >>>
> >> >>> Using kmalloc in this path doesn't look great, especially since at
> >> >>> least one caller (pstore) is sensitive to allocations during rslib
> >> >>> usage (it expects to run it during an Oops, for example).
> >> >>
> >> >> Oh.
> >> >>
> >> >> Could we allocate the storage during init_rs(), attach it to `struct
> >> >> rs_control'?
> >> >
> >> > No, because they're modified during decode, and struct rs_control is
> >> > shared between users. :(
> >> >
> >> > Doing those changes is possible, but it requires a rather extensive
> >> > analysis of callers, etc.
> >> >
> >> > Hence, the 24 ultimately.
> >>
> >> Can this land in -mm, or does this need further discussion?
> >
> > Grumble.  That share-the-rs_control-if-there's-already-a-matching-one
> > thing looks like premature optimization to me :(

That was done back then in the days when the first NAND chips required Reed
solomon error correction and we were still running on rather small devices.

> > I guess if we put this storage into the rs_control (rather than on the
> > stack) then we'd have to worry about concurrent uses of it.  It looks
> > like all the other fields are immutable once it's set up so there might
> > be such users.  In fact, I suspect there are...
> 
> Exactly. :( This is the same conclusion tglx and I came to.

I think we can lift that and just let all users set up a new rs_control
from scratch. Takes some time to init the tables, but ....

Thanks,

	tglx
