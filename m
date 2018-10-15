Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A8B208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfbVhEAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A8B208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeJPClY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:41:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42416 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeJPClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:41:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id c23so18181467otl.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SewQawAmj+EZqMjulO0LEqEqnYNfVyw1tR+CIzBPmsU=;
        b=dfbVhEADRohmWZmESrS8bCbWoqDzIvu951p2ue03E+/OMMSAPM4bAGxu/L0M1OdQvG
         0oWDp1c/vja681jNSVwyzeexeG8hc+aOjETI2eTnzHHVhuIgOEXtsqpTlFHbxTqr5Idf
         6sQ8B6FLNJ0KeTuCLgqeFDpYoVe02f/xPr6z0Hb+c9FhhMgqPhELI2CAVkUzSMeZOrdB
         yLf9eTXfbvOMUDE57pySkqo27F9AMOujSCXEdRKYYsyGW6caHUir/KLRapWjuI30o5lG
         m5dyS2bLr2hy5anOgPNlqIx4H4JC9ijo7UXouZ46dPq8udlQmY3I3f2V+YeKnVny553b
         tiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SewQawAmj+EZqMjulO0LEqEqnYNfVyw1tR+CIzBPmsU=;
        b=ClPJEXDHDczbOv1JloWq9sW6eSIeQbD2KNa67bCv0jt9ef6FiudvIjPcY1gISpFa7Q
         s0+uZQNk0Q2u4+kRdx17KzCEU8csnbvnW8pi0gdcri239krH6ytg+g02f9+bg4rBCuhA
         i/z6dsVNWA8YB6po/2/E59B7uthKyoWo7mzygkLffgNBV61LH30t9wU6KQdJsof71u80
         7wRjIA7/RxW5ORZ5rbTPt3tf7W5d/D2zGqYUuD9uWKx0VLVkks/J+p36sFqx/RC3n8tg
         1MXWAWaGzrE6IIKLPJF1X5Rsulb4iPlO2ip1axdjbMWqoeZ38NLUxyVl/l4LVXudorPh
         t9ig==
X-Gm-Message-State: ABuFfohHDx2z9P8LWf94wvy4sFLl1+iOBm9Chqdv747jvZekAFnH9qYb
        f9ifqbi+QpkLEuYM7SeXz9ThT9+4GlIr58xH33Gauw==
X-Google-Smtp-Source: ACcGV63SbbRA9sJwmsYPvJaHIFAL1+umr9aLy5g2ge9L/ybOlCmh4irSLcIX18tGZTTakQ1gq8xvxBYC2GejUzZKm+c=
X-Received: by 2002:a9d:5122:: with SMTP id c31mr1272290oth.255.1539629693303;
 Mon, 15 Oct 2018 11:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <CAG48ez2ZPhnxudqgU7nC2ORvLnS0Ja-qhLSE5WAY361jst7XNw@mail.gmail.com> <c5a09a04-b4f2-876b-af83-30f7e527497e@cisco.com>
In-Reply-To: <c5a09a04-b4f2-876b-af83-30f7e527497e@cisco.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Oct 2018 20:54:27 +0200
Message-ID: <CAG48ez2ZD=dovBApR07wi_DzYjJvEyO-Pm35eLv9AyXv1tcAFQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     enkechen@cisco.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com,
        mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        guro@fb.com, Marcos Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux@dominikbrodowski.net,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        yang.shi@linux.alibaba.com, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Victor Kamensky <kamensky@cisco.com>,
        xe-linux-external@cisco.com, sstrogin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 8:36 PM Enke Chen <enkechen@cisco.com> wrote:
> On 10/13/18 11:27 AM, Jann Horn wrote:
> > On Sat, Oct 13, 2018 at 2:33 AM Enke Chen <enkechen@cisco.com> wrote:
> >> For simplicity and consistency, this patch provides an implementation
> >> for signal-based fault notification prior to the coredump of a child
> >> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> >> be used by an application to express its interest and to specify the
> >> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> >> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
> >
> > Your suggested API looks vaguely similar to PR_SET_PDEATHSIG, but with
> > some important differences:
> >
> >  - You don't reset the signal on setuid execution.
[...]
> >
> > For both of these: Are these differences actually necessary, and if
> > so, can you provide a specific rationale? From a security perspective,
> > I would very much prefer it if this API had semantics closer to
> > PR_SET_PDEATHSIG.
>
[...]
>
> Regarding the impact of "setuid", this property "PR_SET_PREDUMP_SIG" has to
> do with the application/process whether the signal handler is set for receiving
> such a notification.  If it is set, the "uid" should not matter.

If an attacker's process first calls PR_SET_PREDUMP_SIG, then forks
off a child, then calls execve() on a setuid binary, the setuid binary
calls setuid(0), and the attacker-controlled child then crashes, the
privileged process will receive an unexpected signal that the attacker
wouldn't have been allowed to send otherwise. For similar reasons, the
parent death signal is reset when a setuid binary is executed:

void setup_new_exec(struct linux_binprm * bprm)
{
        /*
         * Once here, prepare_binrpm() will not be called any more, so
         * the final state of setuid/setgid/fscaps can be merged into the
         * secureexec flag.
         */
        bprm->secureexec |= bprm->cap_elevated;

        if (bprm->secureexec) {
                /* Make sure parent cannot signal privileged process. */
                current->pdeath_signal = 0;
[...]
        }
[...]
}

int commit_creds(struct cred *new)
{
[...]
        /* dumpability changes */
        if (!uid_eq(old->euid, new->euid) ||
            !gid_eq(old->egid, new->egid) ||
            !uid_eq(old->fsuid, new->fsuid) ||
            !gid_eq(old->fsgid, new->fsgid) ||
            !cred_cap_issubset(old, new)) {
                if (task->mm)
                        set_dumpable(task->mm, suid_dumpable);
                task->pdeath_signal = 0;
                smp_wmb();
        }
[...]
}

AppArmor and SELinux also do related changes:

static void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
{
[...]
        /* bail out if unconfined or not changing profile */
        if ((new_label->proxy == label->proxy) ||
            (unconfined(new_label)))
                return;

        aa_inherit_files(bprm->cred, current->files);

        current->pdeath_signal = 0;
[...]
}

static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
{
[...]
        new_tsec = bprm->cred->security;
        if (new_tsec->sid == new_tsec->osid)
                return;

        /* Close files for which the new task SID is not authorized. */
        flush_unauthorized_files(bprm->cred, current->files);

        /* Always clear parent death signal on SID transitions. */
        current->pdeath_signal = 0;
[...]
}

You should probably reset the coredump signal in the same places - or
even better, add a new helper for resetting the parent death signal,
and then add code for resetting the coredump signal in there.
