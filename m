Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741FDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E9C205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 17:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JWcCdRNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfBXR1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 12:27:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41080 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 12:27:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id e27so5141468lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYTWdbjZ3A1zFDFPffXQpscA05BEYxIop49QnwMiAiA=;
        b=JWcCdRNAwpEbvcWwPptyBDAbxCWMciZx+nrE1sAk9b1pEaiI7b+lafUXtkrZDMkNV2
         qDwGZGgL6TIWq27mfmTYobD/Y+Q6/5GkQ6F+AIBLOFYa0sMEjlBTXHHxLO3jQ/ThRW4y
         rJOkmPdMjKoa5UGZ0uEIS/SxFjmPpeIN45iC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYTWdbjZ3A1zFDFPffXQpscA05BEYxIop49QnwMiAiA=;
        b=eebKS4rXnzgX+vBGog12k6SQ/MSzcxjtLGdVCxCZ6J+5C1zZw8YSALVdhz85HFfGGs
         nCCd1VqN81QWXobo//AibZK3YYk8MMVtP560XNHk2CkEia3cxspwdLa85AxS5E2AuknX
         e3mOqP/SuNEmUVGf6RH5hxQmlvwh34GGptrCNEKTWOhhb4xY8lLlQmsmaC2c2ETXtwG5
         QMAvG9c9+wF69eiXYfWK9EzRPsVAunhWYg5HhuWO7gnXjQkKQDSFhYQ/CDtRnemV/v9s
         ka7ZNRfDrMdkeIRGODemNm21UxPvcpo5GGslFct8Sg1pJ+HnbXX++P25YnQXw7pSn1cs
         PZhg==
X-Gm-Message-State: AHQUAuYgMKacHmbkEW5I8l6/gOaZIYETMcek3tI1Q4JFEgWCH5ZqnP17
        emwzI3qwRMOfdrRFFFzdHl/Y4ECfkoo=
X-Google-Smtp-Source: AHgI3IZz1SYLF1rL6wQSIahI3r/KzMSU+1w3rpp0kNq4za0CGw/DLT0xwmvh1pHxXAyhG4YRAH/olg==
X-Received: by 2002:a19:f607:: with SMTP id x7mr8115958lfe.47.1551029224476;
        Sun, 24 Feb 2019 09:27:04 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q15sm1939526lje.89.2019.02.24.09.27.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 09:27:03 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id d24so5150223ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 09:27:02 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr7668379lji.125.1551029221940;
 Sun, 24 Feb 2019 09:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215171539.4682f0b4@gandalf.local.home>
 <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net> <20190215191949.04604191@gandalf.local.home>
 <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190223124746.d021973004c7c892c3b3fde1@kernel.org> <20190223194421.725a03fd@oasis.local.home>
 <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com> <20190225001757.519f40cd088c05fdd00a9397@kernel.org>
In-Reply-To: <20190225001757.519f40cd088c05fdd00a9397@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Feb 2019 09:26:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjBD+MQfWP2Q4Zp8FP4HR4MdPACw1=iMbDZANdiBwXDAQ@mail.gmail.com>
Message-ID: <CAHk-=wjBD+MQfWP2Q4Zp8FP4HR4MdPACw1=iMbDZANdiBwXDAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 7:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Sat, 23 Feb 2019 20:38:03 -0800
> Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Can we just get rid of this might_sleep()?  access_ok() doesn't sleep
> > as far as I know.
>
> Hmm, which might_sleep() would you pointed? What I talked was a
> WARN_ON_ONCE(!in_task()) in access_ok() on x86 (only!), and in_task() just
> checks preempt_count.

So the in_task() check does kind of make sense. Using "access_ok()"
outside of task context is certainly an odd thing, for several
reasons. The main one being simply that outside of task context, the
whole "which task" question is open, and you don't know if the task is
the active one, and so it's not clear if whatever task you interrupt
might have done "set_fs()" or not.

So PeterZ isn't wrong:

> I guess PeterZ assumed that access_ok() is used only with user space access
> APIs (e.g. copy_from_user) which can cause page-fault and locks mm (and might
> sleep :)), but now we are trying to use access_ok() with new functions which
> disables page-fault and just return -EFAULT.

.. but in this case, if we do it all *within* code that saves and
restores the user access flag with get_fs/set_fs, access_ok() would be
ok and it doesn't have the above issue.

So access_ok() in _general_ is absolutely not safe to do from
interrupts, but within the context of probing user memory from a
tracing event it just happens to be ok.

It would be lovely to have a special macro for this, and keep the
warning for the general case, but because this is a "every
architecture needs to build their own" it's probably too painful.

PeterZ, do you remember the particular use case that triggered that
commit 7c4788950ba5 ("x86/uaccess, sched/preempt: Verify access_ok()
context")?

                    Linus
