Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4957C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C8220671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n77UOqe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C8220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeGZSRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:17:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42314 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732155AbeGZSRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:17:31 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so1083910plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmnWOZ1efiqBKisZHMzrxSCLgxDZKsszTmOZXMdGtLg=;
        b=n77UOqe7McKHqkz3C1f4DV4+IZcVidsBGDDkLqNWyaFwV9h+C3GwSYmAPWlwSxlPqB
         STRrEeBpne3+5KqybLL/bi1S4FiN0UVzG0R+j3eIFn+S2m+wj5Y09evJfU62ac0bNYRC
         NIIndn8ZzrYEeQxCPIKT4VVzauYTmJgq8T3ajqPpZLjar2zplCXp5pJWr7PM2f2iH0ES
         +10cE5oiswy5n6Rqjm+Bpqe8ce6nDZV2de6hABBxQXKRU1cfX6ZgQeQd4b13E/RhXOYI
         geJpR85CokqkeNdsLJ8Lnnx4HwbUfJkrsILFjm1T29pR6Qhlx4ey6+u/9rplhlWt5LoE
         p4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmnWOZ1efiqBKisZHMzrxSCLgxDZKsszTmOZXMdGtLg=;
        b=fBWyfZJ3TveqDhVUPv0hTkRjfsvaSy59tUayvsh8FZzWH73TDoYJRXtbLFSqxm6thv
         7paEq0l53NiGuPMNTaOeh1zXDU+iIJPHCjCwL7JZZEj274/iZ3rCOqe0awIvKKtvv3/z
         r/qQ1w6uv77Qvp015NoBxDG6mGiEwmF+p0hMiiH0026kMeV5D0KL1T3979GBdrEKkQU3
         8+Ow7rfy+DRiIzXAisfCC/J0WIyrrvucMihmmJ9bnW40ijWGvvlwjc9+SqxHWL8r/WjU
         cmr6wemOFC4xRNVYc3VRTcpHYWEMUUx+zZnNqxtrVQyYTZFitwQmPruauzxv8L121VhX
         CqxA==
X-Gm-Message-State: AOUpUlH6oPPza+k97RCy88Redv/1Pf8ABDv52k0IJNpcRq6BiQpPbsLw
        RqFqHXBGkT5XXuN/2/X4oMiV7Dn9NQKU8iZtvqmeZ4xwqaudtw==
X-Google-Smtp-Source: AAOMgpeFelnkPhPwqt7YGWzbZoChObWLAlq8j+aL/gr3pYt2onMF1Qx+VGgVpq2lyiCmef/jBagt2t3xXhYLL6SsrT4=
X-Received: by 2002:a17:902:708b:: with SMTP id z11-v6mr2641736plk.262.1532624389736;
 Thu, 26 Jul 2018 09:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180725202238.165314-1-salyzyn@android.com> <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com> <20180726112245.3c1bf91d@gandalf.local.home>
 <CAKwvOdknFPpyQx17EbixnydJukuX4kH8=xVTS_9qnsERKCoPkQ@mail.gmail.com> <20180726123719.0db9dca0@gandalf.local.home>
In-Reply-To: <20180726123719.0db9dca0@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Jul 2018 09:59:38 -0700
Message-ID: <CAKwvOdk26WrqF7Ni0DP+KYEp7LCtfhTemG5RBYFwR02_VRc=6Q@mail.gmail.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     rostedt@goodmis.org
Cc:     salyzyn@android.com, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 9:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 26 Jul 2018 09:32:07 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > On Thu, Jul 26, 2018 at 8:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Thu, 26 Jul 2018 08:14:08 -0700
> > > Mark Salyzyn <salyzyn@android.com> wrote:
> > >
> > > > Thank you Steve, much appreciated feedback, I have asked the security
> > > > developers to keep this in mind and come up with a correct fix.
> > > >
> > > > The correct fix that meets your guidelines would _not_ be suitable for
> > > > stable due to the invasiveness it sounds, only for the latest will such
> > > > a rework make sense. As such, the fix proposed in this patch is the only
> > > > one that meets the bar for stable patch simplicity, and merely(!) needs
> > > > to state that if the fix is taken, perf and trace are broken.
> > > >
> > > > Posting this patch publicly on the lists, that may never be applied, may
> > > > be the limit of our responsibility for a fix to stable kernel releases,
> > > > to be optionally applied by vendors concerned with this CVE criteria?
> > > >
> > >
> > > The patch breaks the code it touches. It makes it useless.
> >
> > Doesn't that depend on kptr_restrict, or would it be broken if
> > kptr_restrict was set to 0?
>
> Is that what governs the output of kallsyms?

From my workstation:

$ cat /proc/kallsyms

prints a bunch of zero'd out addresses, while

$ sudo !!

prints out actual addresses.  Looking at kernel/kallsyms.c, it seems
that there's no use of %pK, but kallsyms_show_value() switches on
kptr_restrict (and additional values):

/*
 * We show kallsyms information even to normal users if we've enabled
 * kernel profiling and are explicitly not paranoid (so kptr_restrict
 * is clear, and sysctl_perf_event_paranoid isn't set).
 *
 * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
 * block even that).
 */
int kallsyms_show_value(void)
{
        switch (kptr_restrict) {
        case 0:
                if (kallsyms_for_perf())
                        return 1;
        /* fallthrough */
        case 1:
                if (has_capability_noaudit(current, CAP_SYSLOG))
                        return 1;
        /* fallthrough */
        default:
                return 0;
        }
}


-- 
Thanks,
~Nick Desaulniers
