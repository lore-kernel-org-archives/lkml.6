Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25088C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ACA26BF3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sf7cmp+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ACA26BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965819AbeFZOG7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:06:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42597 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965260AbeFZOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:06:58 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so8491350oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teZOA1RN95vYeiZEwputYpyJISmOqXt1qymNUyGBd7M=;
        b=Sf7cmp+5w3PJISMLkP1k+69npthtwUASlJCM+yCvSXXMAf425GUdQ5D9LqhaD4T7iM
         mBiAqQ71drnDteC5sYlVC2ZW/Z7YGc/75XoymoF8cYQMjsEnOa8QmfEIVGvEzVkTUtd+
         7dkqi2xbzV8zJmAXaV7aXi93NmM5iGbeMnNliLKJ+sisejplKtRx/uCrYRPbBvZNo/8L
         Y/71hrUtDvkn79Gbp5p6ra3lC7Ddm2ygvxBGKgeQzBsCy6hXquo36d3UuJzkXMGA4jKp
         VHPwIqMcdpBLIDrFj+0YwqpwqBz72fhStcl+RCPPXcF1XGGS8Pr2bVgJTbsbaU0eMNuP
         +5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teZOA1RN95vYeiZEwputYpyJISmOqXt1qymNUyGBd7M=;
        b=X4tBdA0sBKB+MMmOG51OUREKXb1EMobk88IUI7f7TrsbFV6iA6AT8vG6RE0h94YEwb
         DA8misKxEK8DzdJ8HZvCfSo9vloh31bArQR0AyyJD9tfucQOxmRdyfPWqSYFPGydK5oX
         xHio0UtwfCxnBtC7fYUdFyxKweLlbUTtOBbLjnUyeSB4JyCQW3EFvlJ0/BHOQ1AtGuKR
         /sTQjnV/y8ML7TjaCKO97trpYM8iH00Uh4LClUvs+6TfAK9Rli7RN0tSzCSnIAA3CHXn
         73XLpuyLMLUi7VGBe/2hdOjOsQXXXxsJOR5fYU55S03RSJL+OsyTnH8LZhffX5mAX/xN
         ZKCg==
X-Gm-Message-State: APt69E3QodJpU5Nl/1Ymq+fnv721EWXIVMcxCJesTTeTghqe72lu//+Q
        9mqojIF8D0t1fzM3arTCurqLxiWXzX7SEJmJjFmDVw==
X-Google-Smtp-Source: AAOMgpcN9l6a/KEwJrZD3vb1IqubqW70PXfO1NhY+RLvJua9lF+MzKuE7G1k/BuLMuBn0YOXWrKYN87F+3Ho4aVH8L8=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr980566oib.91.1530022017344;
 Tue, 26 Jun 2018 07:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163419.216578-1-jannh@google.com> <20180626130757.GA10042@gmail.com>
In-Reply-To: <20180626130757.GA10042@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 26 Jun 2018 16:06:45 +0200
Message-ID: <CAG48ez2WwQVWtfh7sQCqn1E52V7V4_LxZaU+kV_r-YGOzNAsXg@mail.gmail.com>
Subject: Re: [PATCH] userns: move user access out of the mutex
To:     christian.brauner@canonical.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        security@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 3:08 PM Christian Brauner
<christian.brauner@canonical.com> wrote:
>
> On Mon, Jun 25, 2018 at 06:34:19PM +0200, Jann Horn wrote:
> > The old code would hold the userns_state_mutex indefinitely if
> > memdup_user_nul stalled due to e.g. a userfault region. Prevent that by
> > moving the memdup_user_nul in front of the mutex_lock().
> >
> > Note: This changes the error precedence of invalid buf/count/*ppos vs
> > map already written / capabilities missing.
> >
> > Fixes: 22d917d80e84 ("userns: Rework the user_namespace adding uid/gid...")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  kernel/user_namespace.c | 24 ++++++++++--------------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index c3d7583fcd21..e5222b5fb4fe 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -859,7 +859,16 @@ static ssize_t map_write(struct file *file, const char __user *buf,
> >       unsigned idx;
> >       struct uid_gid_extent extent;
> >       char *kbuf = NULL, *pos, *next_line;
> > -     ssize_t ret = -EINVAL;
> > +     ssize_t ret;
> > +
> > +     /* Only allow < page size writes at the beginning of the file */
> > +     if ((*ppos != 0) || (count >= PAGE_SIZE))
> > +             return -EINVAL;
> > +
> > +     /* Slurp in the user data */
> > +     kbuf = memdup_user_nul(buf, count);
> > +     if (IS_ERR(kbuf))
> > +             return PTR_ERR(kbuf);
>
> I'm not opposed to this but what is annoying is the changed error
> reporting you pointed out. It seems conceptually way cleaner if missing
> permissions are reported before more specific internal errors.
>
> The question I have is how bad it would be if memdup_user_nul() stalled
> and if you see any issues security wise. Given that the mutex is only
> taken on operations that are mostly performed when creating or setting
> up a new user namespace
>
> map_write()
> create_user_ns()
> proc_setgroups_write()
> userns_may_setgroups()
>
> and not when actually interacting with it it seems the worst that
> happens is that creation of new user namespaces is not possible anymore.
> That shouldn't have any effect on the host though which I would see as a
> real issue. But I might be missing context. :)

userns_may_setgroups() is involved in sys_setgroups() via
may_setgroups(), so if one thread is blocking the userns_state_mutex,
nobody can log in anymore.

> >       /*
> >        * The userns_state_mutex serializes all writes to any given map.
> > @@ -895,19 +904,6 @@ static ssize_t map_write(struct file *file, const char __user *buf,
> >       if (cap_valid(cap_setid) && !file_ns_capable(file, ns, CAP_SYS_ADMIN))
> >               goto out;
> >
> > -     /* Only allow < page size writes at the beginning of the file */
> > -     ret = -EINVAL;
> > -     if ((*ppos != 0) || (count >= PAGE_SIZE))
> > -             goto out;
> > -
> > -     /* Slurp in the user data */
> > -     kbuf = memdup_user_nul(buf, count);
> > -     if (IS_ERR(kbuf)) {
> > -             ret = PTR_ERR(kbuf);
> > -             kbuf = NULL;
> > -             goto out;
> > -     }
> > -
> >       /* Parse the user data */
> >       ret = -EINVAL;
> >       pos = kbuf;
> > --
> > 2.18.0.rc2.346.g013aa6912e-goog
> >
