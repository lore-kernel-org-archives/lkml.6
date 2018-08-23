Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10BBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879C4208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phau4Dik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879C4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeHWEXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:23:12 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39395 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeHWEXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:23:11 -0400
Received: by mail-oi0-f65.google.com with SMTP id c190-v6so6424267oig.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Zfeh/7ZYgfMNgZA9AlNRZU03af4gwNJS9F4XB6chF8=;
        b=phau4Dik+U/nSHa9l4qHwvU/ZPofv0dfOs9b4aDLVaKlNArpmzB/6cMe1L3mh2bqUI
         G9jrC0hVvanYlnK0O1yVbui/bFXT9vafDkAYpRwoFtGwuehNeu983AYn0pBgxmWHtP1W
         Va/xHCMVBWxyVIuhvoUnc0uW++aziD/2eZ61le3gv6xGH8213XBjUmKVucUPMlM5u1Cw
         Hz2YxnbeTUz5rWOmdG4tLPPUqFnf6p7MpjEf2ppxnDVFfbE2heo7ltNNmBx3yvDnGu3k
         GPz+2qZiec5yNIM9plYaaCT7YEoGRSJL1vbzrBFtkST8XDTBORruRY9oP1n+N/1i4V1J
         hwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Zfeh/7ZYgfMNgZA9AlNRZU03af4gwNJS9F4XB6chF8=;
        b=Y9pvgHyCycYNkrqYEfrNVfVruwhoOaUGtzED7CBmw+Ql4gXJVuID+fmRdINRQX1Noq
         jd20/jVzE2y4e5+XgVNm4errZsEvum5wWV1DGFROI3w7FDLeTBy7Bzuq1WeFOiJokiDn
         +/q0bWIMLPQdM+yf+/HaXyuG9vsncmXV6BNhyqnInP1Uwmz4ZvW8sFVJ9wdqKBYwMMj6
         rjVoE1aGr684Gd882GXbjz5wBbFtuYPxSuOWoFmwMJ5fpeTH7MbfC6QpG/0w45BI+6Rw
         wQ/krC8k+H4sMaYfG0VVppghHIfSiFedPZ5pVtf3d5IMLvumcCUH1jldt/gFayBP9Een
         tNfg==
X-Gm-Message-State: APzg51Cy/lqVITWmxs+0cUPy6ICkEJ5W9nx/ZLXbaPaOA5fndAoIVJzz
        Itg+lVfdjWbzrNckJxrn2R5i+zjD9Vlgt5SR3Gya+w==
X-Google-Smtp-Source: ANB0VdY9nJ8K7sXNJ59DeaQvzSaeU/Gbem/SQVDRDijbY2jEtsYOTMpaHw0tTu4PlK0DL1Ivq4zgh+RgngC+slUCCjk=
X-Received: by 2002:aca:e504:: with SMTP id c4-v6mr5997610oih.246.1534985765410;
 Wed, 22 Aug 2018 17:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180807012257.20157-1-jannh@google.com> <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
 <CAG48ez0c0L+WyfjDcfx=3wDwOQDOSJM-2JSVUBoWJCaKDVEfbw@mail.gmail.com> <CALCETrU6gUBiTkpAUKh97y2R1cSftbMcfSTnSYxhZFRKf7vGWQ@mail.gmail.com>
In-Reply-To: <CALCETrU6gUBiTkpAUKh97y2R1cSftbMcfSTnSYxhZFRKf7vGWQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 23 Aug 2018 02:55:39 +0200
Message-ID: <CAG48ez3fyav-cw-PP+45UwZLy6RjoDAwVgbpziKTj-pnB3zrYg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86: WARN() when uaccess helpers fault on kernel addresses
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 2:28 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Wed, Aug 22, 2018 at 4:53 PM, Jann Horn <jannh@google.com> wrote:
> > On Tue, Aug 7, 2018 at 4:55 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >> > On Aug 6, 2018, at 6:22 PM, Jann Horn <jannh@google.com> wrote:
> >> > There have been multiple kernel vulnerabilities that permitted userspace to
> >> > pass completely unchecked pointers through to userspace accessors:
> >> >
> >> > - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
> >> >  access_ok() checks")
> >> > - the sg/bsg read/write APIs
> >> > - the infiniband read/write APIs
> >> >
> >> > These don't happen all that often, but when they do happen, it is hard to
> >> > test for them properly; and it is probably also hard to discover them with
> >> > fuzzing. Even when an unmapped kernel address is supplied to such buggy
> >> > code, it just returns -EFAULT instead of doing a proper BUG() or at least
> >> > WARN().
> >> >
> >> > This patch attempts to make such misbehaving code a bit more visible by
> >> > WARN()ing in the pagefault handler code when a userspace accessor causes
> >> > #PF on a kernel address and the current context isn't whitelisted.
> >>
> >> I like this a lot, and, in fact, I once wrote a patch to do something similar. It was before the fancy extable code, though, so it was a mess.  Here are some thoughts:
> >>
> >> - It should be three patches. One patch to add the _UA annotations, one to improve the info passes to the handlers, and one to change behavior.
> >>
> >> - You should pass the vector, the error code, and the address to the handler.
> >
> > I'm polishing the patch a bit, and I've noticed that to plumb the
> > error code and address through properly, I might need significantly
> > more code churn because of kprobes - I want to make sure I'm not going
> > down the completely wrong path here.
> >
> > I'm extending fixup_exception() to take two extra args "unsigned long
> > error_code, unsigned long fault_addr". Most callers of
> > fixup_exception() are fairly straightforward, but
> > kprobe_fault_handler() has a dozen callchains from different exception
> > handlers, and most of them are coming via notify_die().
>
> KILL IT WITH FIRE!!!!!!!!
>
> More seriously, kill kprobe_exceptions_notify() and just fold the
> contents into do_general_protection().  This notifier chain crap is
> incomprehensible.  I would love to see notify_die() removed entirely,
> and crap like this is just more reason to want it gone.

This isn't just do_general_protection() though, that's just one
example. As far as I can tell, similar stuff happens everywhere where
notify_die() is used - #DF, #BR, #BP, #MF and so on.

> > I think there's also some inconsistency between #PF and #GP in the
> > ordering of error handling:
>
> It's probably a bug.  It's also probably irrelevant, but maybe not.

Depends on what people do in their ->fault_handler hooks, I guess.
Yeah, probably doesn't matter.
