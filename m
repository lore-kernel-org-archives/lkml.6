Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7370FF05E1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7300B20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLMYJhiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7300B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeG2Mox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 08:44:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34657 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeG2Mox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 08:44:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so16476054ois.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/HQddYTVpr0K9VCH1eqbLenFuy3TyzHMt4utvUM0e8=;
        b=ZLMYJhiUboKah7aijBXLJzLsSGgUZwQDtRHvFQQUoANcSvhEhLjVVsaXrysjGehXf8
         xsULmb7RQwbYm6/CtDWvBnRVZtmQlK1HH7pOXfTqpZI5iXXD3jkIw24LKQwN8zj9Rj0q
         PAecjIykjS6U3JrVbULJ6C8gZlKBmNYjP6sgSGrMSMebijjieO+VJbyH1g4RWGVrJEl0
         gTANKz8OzHbXpG0eaw5v0CfvfrJMpPZKJ13ndSefXHdmHJaVT8ewgooa2re796h8z1Fl
         0458lnM3phna+VRRLDfg2LRkv2RIYUZZPFtLvzKEE9/PrPoYKf5C7UIw0dxgGJ+dW8xU
         anrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/HQddYTVpr0K9VCH1eqbLenFuy3TyzHMt4utvUM0e8=;
        b=BR6+QBPQ5XTuXlwzHSiTSBJ5Co/jBWwdT6SLGOit0X6ySy5+XcOBPPWd48GoZQzD4t
         wCFpOK71Hms1v7eFH3nrJZRxStflyTUuJhXnyFdqo8eyITCMfnezxZoeddesUBUmGYzv
         g3VijrTwNpjXv2pIPUFr81jVeBNQYE9Ps5K7R5hBl5wVVpIYJ+koEYgcsuK2FPZgQToH
         jHYYv0Ga1IvQFbD+JMG1sizfqBmVHfls0Wpv0sW0TJWSteXm31VSW8LyuUdAk6DcDeI3
         Gp1Q6axu5mgZeAqEJwrg+jsl08JchYwgKN367MGf44WxVP5cpi5UPqqhy6ciMo6E4LBT
         ZXag==
X-Gm-Message-State: AOUpUlHnC1SxbykRgrmXkk8IErkHF+2l5auQpnQH3PAb78rHGEY0ybVD
        h8xkcCGiOdnrguV77T8YyZpAalewCKErRm/2JEoTCA==
X-Google-Smtp-Source: AAOMgpekOJTSG7ZVKRrMw9U2OOJQqtRRgCLmcpu9AMvoPNCSveV/SGYxVaCExgdihdljnAnZ/1OupZMPGZvo6ME3bwo=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr12854526oig.221.1532862887446;
 Sun, 29 Jul 2018 04:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk>
 <CAG48ez2f+J+UeFN0u1Hpfq3tFXJbi7ckts8sua3eY4jDwnh6-Q@mail.gmail.com> <19865.1532854200@warthog.procyon.org.uk>
In-Reply-To: <19865.1532854200@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 29 Jul 2018 13:14:20 +0200
Message-ID: <CAG48ez3HY6UuOgo1gM9L=WwyOqifKSs6sFu7f2qqBZQg6hy96g@mail.gmail.com>
Subject: Re: [PATCH 29/38] vfs: syscall: Add fsconfig() for configuring and
 managing a context [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:50 AM David Howells <dhowells@redhat.com> wrote:
>
> Jann Horn <jannh@google.com> wrote:
>
> > [...]
> > > +       case fsconfig_set_binary:
> > > +               param.type = fs_value_is_blob;
> > > +               param.size = aux;
> > > +               param.blob = memdup_user_nul(_value, aux);
> > > +               if (IS_ERR(param.blob)) {
> > > +                       ret = PTR_ERR(param.blob);
> > > +                       goto out_key;
> > > +               }
> > > +               break;
> >
> > This means that a namespace admin (iow, an unprivileged user) can
> > allocate 1MB of unswappable kmalloc memory per userspace task, right?
> > Using userfaultfd or FUSE, you can then stall the task as long as you
> > want while it has that allocation. Is that problematic, or is that
> > normal?
>
> That's not exactly the case.  A userspace task can make a temporary
> allocation, but unless the filesystem grabs it, it's released again on exit
> from the system call.

That's what I said. Each userspace task can make a 1MB allocation by
calling this syscall, and this temporary allocation stays allocated
until the end of the syscall. But the runtime of the syscall is
unbounded - even just the memdup_user_nul() can stall forever if the
copy_from_user() call inside it faults on e.g. a userfault region or a
memory-mapped file from a FUSE filesystem.

> Note that I should probably use vmalloc() rather than kmalloc(), but that
> doesn't really affect your point.  I could also pass the user pointer through
> to the filesystem instead - I wanted to avoid that for this interface, but it
> make sense in this instance.
