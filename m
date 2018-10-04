Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C9AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF020877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0Ki5/uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EF020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJDSaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:30:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42771 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeJDSaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:30:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so8796686otl.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KzcfRJVjfm/7hB99V/0pkGWKg0SdOrG/6XvaOVun6w=;
        b=N0Ki5/uogNJlCQ7TLB/uormOjMsPc161tIUtGFfomBL+zUS8oYiysMUd9TOiMvDb1W
         xJF5xBxyIlwkKlGHV77pQaq8YWvyl6jYVD4HuVntjDQr+d8ckjSKcZJi7taH41jczqs9
         4yOc82zVybLe/JvhsibpPRqzvWalQyzVYfKdPoAqAqsCQeIC5xrh2U8Wd9M3UpDpYGmz
         iqKJH4LtySBkiyo69a/XPo9u3srMTS71wH5RBkZNxtTLGujxayucdnI0z+hvvuGUOUwB
         TBYOcK7pfj6G5NqKDkx4nSYL8XGFR+02iHcUTSJqlVJwwHzS48cT7ISPAIZxXmQpZcZk
         Uxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KzcfRJVjfm/7hB99V/0pkGWKg0SdOrG/6XvaOVun6w=;
        b=DgWLIfgwANqEdPNV1YYEdzD1Me+H92+d8qWgqMr9I4CfURuJx39tSlczYZ0mT6LcPY
         cIo5VjUWnE5s2CLJ3QIRZOvq9xj9+2ILzKWZQUW517de6Az5LpNZxxFifHZnR7evNDPf
         mEKOQGJJy/LAOn8+UfFD0u9SBimtvoDXnTlbNZ+STqkNbkWZ5SL3jUywyI+9/5Ny1L8f
         DPS1xCIFRbAB2hdi79VftBTRguQQJI5lSN2trvsjoqctOZYFp2I4hgKr1l8BYY+iz3qZ
         sKnu/EyVP2ZeISJfsOBarXBY/vJq4rwwH24YiT0PjReOZxS9QarenUkVYh/NUvwXCcl2
         YpKQ==
X-Gm-Message-State: ABuFfojvFD5RwqKA9/6jwjfSpaswJgrT64R3pDj1aUKGQvEC4GFbCiLD
        lUlk1Wg3GpS0S5LkDXVOtn2IHI9DSigCbvEBdgXqkA==
X-Google-Smtp-Source: ACcGV62ti/W+OiUCNstLSUwmzjkLqi6jSuLpS0l2AmuNT/sOpfTA/7cssOty5tkNo5WrXOG6VPv7W9YbaoY+C1oFUsQ=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr3214836oth.292.1538653037327;
 Thu, 04 Oct 2018 04:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-3-casey.schaufler@intel.com> <CAG48ez3_XJYCURiCurDeCousGguGUdPego30j5+UF8FebWxUtA@mail.gmail.com>
 <99FC4B6EFCEFD44486C35F4C281DC673214625EA@ORSMSX107.amr.corp.intel.com>
 <CAG48ez1+9Bfadu4y4TzPYJfFpLk+N8w7GdCE+xwNCM5TfQ8W8Q@mail.gmail.com> <nycvar.YFH.7.76.1810040942110.14430@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1810040942110.14430@cbobk.fhfr.pm>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 4 Oct 2018 13:36:50 +0200
Message-ID: <CAG48ez1OiAvqqtLXpBjxz-=9X+YdtR9iF7fA_pXhu2GfBt5osw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] Smack: Prepare for PTRACE_MODE_SCHED
To:     Jiri Kosina <jikos@kernel.org>,
        Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:47 AM Jiri Kosina <jikos@kernel.org> wrote:
> On Thu, 27 Sep 2018, Jann Horn wrote:
> > > Yes. Since the PTRACE_MODE_NOAUDIT was in PTRACE_MODE_IBPB in Jiri's
> > > previous patch set and not in PTRACE_MODE_SCHED in this one I assumed
> > > that there was a good reason for it.
> >
> > Jiri, was there a good reason for it, and if so, what was it?
>
> [ FWIW PTRACE_MODE_NOAUDIT being in PTRACE_MODE_IBPB goes back to original
>   Tim's pre-CRD patchset ]
>
> Well, we can't really call out into audit from scheduler code, and the
> previous versions of the patchsets didn't have PTRACE_MODE_SCHED, so it
> had to be included in PTRACE_MODE_IBPB in order to make sure we're not
> calling into audit from context switch code.
>
> Or did I misunderstand the question?

If I understand Casey correctly, he is saying that your patch
(https://lore.kernel.org/lkml/nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm/)
doesn't include PTRACE_MODE_NOAUDIT for IBPB, but the previous v6 of
your patch (https://lore.kernel.org/lkml/nycvar.YFH.7.76.1809121105330.15880@cbobk.fhfr.pm/)
did include it, and therefore Casey thinks that there is a specific
reason why you removed PTRACE_MODE_NOAUDIT, and therefore Casey is
adding special-case logic for PTRACE_MODE_SCHED to Smack when simply
using PTRACE_MODE_NOAUDIT would also work.

I think that Casey should change ptrace_may_access_sched() to use
"mode | PTRACE_MODE_SCHED | PTRACE_MODE_NOAUDIT".
