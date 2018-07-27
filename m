Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81BCC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54F205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gq8vH1L6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbeG0ThG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:37:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43372 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG0ThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:37:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so3667225pgr.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6U4Waqa/3ME/5HP/Y9f6Ju2Z/mr5jUc1nqYMbCXurU=;
        b=Gq8vH1L6Lq5C2StvDQgbMn9c3IWi+OGnUiOutpQzcIUN0UWLQglAgBfblj8iRUHp+j
         2G/jvDueT/DF3p2ctD2SomoSyRFtwr/oV/Wf0qynDup3TsA9+ViDPfrup/Mp36l+db3D
         7KWCL9p6IrZyEuwNa8BxG+jkq/tOrK95JE1KtZ9zq3+AXrr1QfjQDdz/vmxp4EOZysRx
         EqrdSPP9TRGsz78CQ6AJEkUm7pVzg5qajH2oVuZdWsQyjhKLtXpe3nB+nS2V8AgofGAV
         VCB8dab3p1rPqsdN//Yfo921WyjV5+unHY5Rg+VloOOyVoKMhxevNAG8jlpmRxjKqMQB
         c77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6U4Waqa/3ME/5HP/Y9f6Ju2Z/mr5jUc1nqYMbCXurU=;
        b=Ubgw6z/dHGq/L9bqXys6EeQLwZp4aEGF/9MnGNrGeLth7tuUJWAVYJ26IzpGAD8e7m
         kWWFaeqa1iHTgqr7fexxm3NjyVdOCBaF5LiaP0NMgvZha6art+T+c0csE+SUIiwsTr9U
         bPojqDZTRDhQ/5tVbRVsjmFJ2tdJPwuac1NkkkAl2qh2U8oreXVtRFhbcyl09S4qqpK7
         TOG3ejuvh0PWg2QwDZdCAOREYkQe8z7y7kNkzPkIBbHCrTj8xte2VQoBIvLKUP6h/0z5
         5mhVdqIGjlAUimycgZCHu1EFB0zh+ZFQsW/VQ62OIJJcjzjvtAjKRG1yFo1LU1PQXShd
         v7Eg==
X-Gm-Message-State: AOUpUlHuxoTy0hPa9KgG+rXytkqJdy54BCyEj8M+M42EEdGTG/3Wc8KS
        lwkDRWJ6RzHVjkV4fbfFvIz1pAHwm+Ed1xoAmLuduw==
X-Google-Smtp-Source: AAOMgpd+VlgyGLdrKHW9eReYL8INEfUqEfHQSXLgJOSdwjTS44WF30wiy3kdhgBym2hOo54KilVFdPxsRt8+ihqTsws=
X-Received: by 2002:a63:d916:: with SMTP id r22-v6mr6904989pgg.381.1532715242897;
 Fri, 27 Jul 2018 11:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180725202238.165314-1-salyzyn@android.com> <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com> <20180726153153.GA8327@kroah.com>
 <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
 <20180726181558.25a5c3b8@gandalf.local.home> <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
 <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com> <20180727094730.3a448629@gandalf.local.home>
In-Reply-To: <20180727094730.3a448629@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Jul 2018 11:13:51 -0700
Message-ID: <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     rostedt@goodmis.org
Cc:     Jann Horn <jannh@google.com>, Golden_Miller83@protonmail.ch,
        greg@kroah.com, Kees Cook <keescook@google.com>,
        salyzyn@android.com, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, kernel-team@android.com, stable@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 6:47 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 27 Jul 2018 15:40:32 +0200
> Jann Horn <jannh@google.com> wrote:
>
> > > > But the code doesn't go to dmesg. It's only available
> > > > via /sys/kernel/debug/tracing/printk_formats which is only available
> > > > via root. Nobody else has access to that directory.

Oh, sorry, you're right. We're not printing an address to dmesg, but
to a sysfs node.  If you must have CAP_SYS_ADMIN to read this dir,
then printk's %pK wont save you, because then you can modify
kptr_restrict with sysctl.

> > > I think the point was that when we take capabilities into account the root
> > > privileges aren't unequivocal anymore. The 'root' owned process with only
> > > 'CAP_SYSLOG' shouldn't have access to /sys/kernel/debug/tracing/printk_formats
> >
> > Then they shouldn't have access to debugfs at all, right?
>
> That's what I'm thinking.

I found the internal bug report (reported Jan '17, you'll have to
forgive me if my memory of the issue is hazy, or if the fix used at
the time wasn't perfect), which was reported against the Nexus 6.
From the report, it was possible to `cat
/sys/kernel/debug/tracing/printk_formats` without being root, which I
can't do on my workstations much more modern kernel (Nexus 6 was
3.10).  So I guess the question is what governs access to files below
/sys/kernel/debug, and why was it missing from those kernels?  I
assume some check was added, but either not backported to 3.10 stable
(or more likely not pulled in to Nexus 6's kernel through stable;
Android is now in a much better place for that kind of issue).

--
Thanks,
~Nick Desaulniers
