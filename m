Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95F6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9108224EAA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GzY4oOwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9108224EAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753722AbeGBWbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:31:44 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38658 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbeGBWbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:31:42 -0400
Received: by mail-io0-f194.google.com with SMTP id v26-v6so3845683iog.5;
        Mon, 02 Jul 2018 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxuOOo5zUkTbayrosmqKUE7pcu6gkpIE5u8eRz8+XhQ=;
        b=GzY4oOwLF6TEWsVIvd4TSS8AGdnvLJWHOwon9lFbGjdQe3+9oq8hLnXDERoOeXuKDr
         ReqXTY0IgYjd+0egzXpAwd4jZwQ67z6z7CbOlZScfZ0cdYs5KQ3Fz3DclXglQLwq/X9d
         gwlMs3G02Oza7diW01XKrEJsm2Wa0hfBJFfAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxuOOo5zUkTbayrosmqKUE7pcu6gkpIE5u8eRz8+XhQ=;
        b=qKIoncQPQ89txDuGuYcZKrhuAX8jZ2cbQiP2jvEOASvKBr2Z/7DlLPO/6gsrSMwUWv
         7DY/Stt4XcV7PFN8JLtFNh+8uoOlEXKDJqGUQtGWU8OqrbL7YXtQBk5V1k0ohN4dYBxF
         AFwCBTaXKqLu+3OFBz+J1GTmr0yz95qwCone+URoi813Oae/P/40wSYtw4Uw+wGciHJd
         BL7PAZKdTi4XRyvpbVoANR1I0xxMzzZNIzoSjmhAnlw5hNZjaHldq0/cu9nm+SYhEa2M
         ERM1xfmoqvhTqqZH386AINf41HRlLg42V2gnQHyqJnfpZV7CfONCQkbojLi2rCF5p09e
         6aeg==
X-Gm-Message-State: APt69E0561L7XHn+xsldpCgRISe5x71Aeetf1fmAv188zH4w8Kt/nzrI
        pHPESH4FrtMYYd4oMwtfPTV4zBu/Bu5m1aLtWM4=
X-Google-Smtp-Source: AAOMgpecvBql5JT+ZWp+9YYT8K3HbSwzL6EqHPu0MAkPn5LsPAQnFRWj30xHKS4WqVveYcWLDek0TAZj6+dHinQgM0U=
X-Received: by 2002:a6b:980e:: with SMTP id a14-v6mr18281856ioe.238.1530570701497;
 Mon, 02 Jul 2018 15:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org> <20180702222105.GA2438@bombadil.infradead.org>
In-Reply-To: <20180702222105.GA2438@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 15:31:30 -0700
Message-ID: <CA+55aFxcNUGJoe17YsCAgQE-42UDFKLuXg=Wox7SRzR2=xx3GA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jul 02, 2018 at 02:18:11PM -0700, Andrew Morton wrote:
> >
> > Dumb question: do we know that negative dentries are actually
> > worthwhile?  Has anyone checked in the past couple of decades?  Perhaps
> > our lookups are so whizzy nowadays that we don't need them?
>
> I can't believe that's true.

Yeah, I'm with Matthew.

Negative dentries are absolutely *critical*. We have a shit-ton of
stuff that walks various PATH-like things, trying to open a file in
one directory after another.

They also happen to be really fundamental to how the dentry cache
itself works, with operations like "rename()" fundamentally depending
on negative dentries.

Sure, that "fundamental to rename()" could still be something that
isn't actually ever *cached*, but the thing about many filesystems is
that it's actually much more expensive to look up a file that doesn't
exist than it is to look up one that does.

That can be true even with things like hashed lookups, although it's
more obviously true with legacy filesystems.

Calling down to the filesystem every time you wonder "do I have a
/usr/local/bin/cat" binary would be absolutely horrid.

Also, honestly, I think the oom-killing thing says more about the
issues we've had with the memory freeing code than about negative
dentries. But the one problem with negative dentries is that it's
fairly easy to create a shit-ton of them, so while we absolutely don't
want to get rid of the concept, I do agree that having a limiter is a
fine fine idea.

                Linus
