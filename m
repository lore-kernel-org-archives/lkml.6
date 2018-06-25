Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DCCC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A5B20834
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzHoZ5oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A5B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934175AbeFYXxZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:53:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34310 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFYXxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:53:24 -0400
Received: by mail-io0-f194.google.com with SMTP id e15-v6so14234907iog.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obyk5eqxSjSi5z7kCXf9Fly64BV+iW5EIXpAt+qcgQo=;
        b=RzHoZ5oL7Oo1pznqLFVH4UJWYX37u8FAp8Vmh9HP7B0AsXVgsOmb9swluA/oKBrnuN
         uFHUQe1rbiNG05b0MvghscD+gXLcB/bsi7s6UQJk+lRGKgOWnaecpdwAZfm3K8Tjsen0
         RdgdplQj1rD/UCLZTjJAo9PwAb/mEsj7Q/j3PKgdD8YwL89qm2BtlxynMHow6qTkUUcI
         z/mlk8GKvgxez2Hu4Zi/dh/HYa3UR0+wyyeCOdHjJ1iU86XmfxA9QefCwrpexs1WXu6a
         45+LR3hT1mhGYqnFICmZ0B1PHcSJMo0BDK11OIxiQvWT9ixWRsz5dtTIkG1EXC9RcHS6
         27pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obyk5eqxSjSi5z7kCXf9Fly64BV+iW5EIXpAt+qcgQo=;
        b=LLg+av7moaR8smFXXsxNyNmfbXej5v1M+kunS1Ansi2o7RAOlLJOYtF/qxmlzOhXFL
         ZpAdxC/zogR4FG43qf23b68FTsHQ5PSyoh3DqpgCcwTQ1AGCIX0eaov9mImb9Gp+IQBt
         CiSGoH3asPxj/hEnLPU3Wg5AvYK3GmEXKlv+mAa0SWLCiRJD+7EybR7wr7XZ890y0Bvq
         vfACdjefC2asG8k3CPerckwbWpNLWof8aoIs6J2nrTi4J+8Cj0GS0oBmiaj7YNx4+TBv
         NPhrWjFshsyBdNPBkzTJfTgC3srRGEWF9JH7cO7C6BFUkDB6LyQTJ5g7lbSARp1WUe1l
         pFIw==
X-Gm-Message-State: APt69E3Ilr3m6I+s6J3Z8qnLLwemd194qduxBJv95DTm5BJZvHhDLV1D
        UcOAifKkYmV9nc1uAKjaqko9QFxREMUjNuknX7TYgQ==
X-Google-Smtp-Source: AAOMgpd/nUQN3flg7OC7q2ihp7pt8ntDxKy6V55i1L76lmzqtC2amXWBXV6jeDVK6ckki/IVJqmIsqwQo3lciZTlLOg=
X-Received: by 2002:a6b:da0e:: with SMTP id x14-v6mr11892314iob.19.1529970803067;
 Mon, 25 Jun 2018 16:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180625224014.134829-1-thgarnie@google.com> <20180625224014.134829-24-thgarnie@google.com>
 <c2c67217-e120-468b-b59a-05813a64c448@infradead.org>
In-Reply-To: <c2c67217-e120-468b-b59a-05813a64c448@infradead.org>
From:   Thomas Garnier <thgarnie@google.com>
Date:   Mon, 25 Jun 2018 16:53:11 -0700
Message-ID: <CAJcbSZGGtmMtYYM6DqM8byZDeucUE4G_uvK97BHd-JwLWZe_jw@mail.gmail.com>
Subject: Re: [PATCH v5 23/27] x86/modules: Adapt module loading for PIE support
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 4:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 06/25/18 15:39, Thomas Garnier wrote:
> > Adapt module loading to support PIE relocations. Generate dynamic GOT if
> > a symbol requires it but no entry exists in the kernel GOT.
>
> Hi,
>
> This patch description (and a few others with the same sentence) is a little
> confusing to me:
>
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range 0xffffffff80000000.
>
> Is there a word missing after "range"?  May "below"?
> As is, it seems to imply "range by 0xffffffff80000000."

Yes, below. I will fix this on all patch descriptions on next iteration. Thanks!

>
>
> thanks.
>
> >
> > Signed-off-by: Thomas Garnier <thgarnie@google.com>
> > ---
> >  arch/x86/Makefile               |   4 +
> >  arch/x86/include/asm/module.h   |  11 ++
> >  arch/x86/include/asm/sections.h |   4 +
> >  arch/x86/kernel/module.c        | 181 +++++++++++++++++++++++++++++++-
> >  arch/x86/kernel/module.lds      |   3 +
> >  5 files changed, 198 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/x86/kernel/module.lds
>
>
> --
> ~Randy



-- 
Thomas
