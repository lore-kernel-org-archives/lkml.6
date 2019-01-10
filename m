Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848D2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B40214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRAU0lpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfAJKV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:21:27 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40173 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfAJKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:21:26 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so15481868ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 02:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sliQGW+HOCYznrqpTEmY953yqbv2bcvHKChr/XEDK4=;
        b=FRAU0lptMGhpvshOyMLkAK27TgmZgtxa1e9z4agMTgLylMlc+SK8hT8tkqA1ZPw+/6
         XgEDZqtWb9BNjyozJTpnbVcZW2O9n0F0UMYywCbIs1ehhzLyR3eGV5dCgAnhRSwQOmxf
         WPI9u2VIs1ra2fSFyi9NLDRRYz8vcAGUNkMSBBWy9D5GdhVEuvl0AxtRCjvM26ZvZNDu
         9U5GN8oYFhcwvhIicN01FDBvQHqnfmhCRXafWfOuIpYKXmnvZPOX7LY6asfXclKKGaYZ
         eZeVj0FihAktYXGQzPChebXeGXp+f7KuDATjojR3cOplcaI32kjAAiSsDuKzKI+ARPMz
         bLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sliQGW+HOCYznrqpTEmY953yqbv2bcvHKChr/XEDK4=;
        b=Mi0GOTsEy77HxVbKSbla8mwQfMXyROccmTkKJ0N+LqrYZKyONdeMc9HQCFWOnxa9zw
         PgU6vMoRUK1ZtKoMffVpmbwaPSe0Zyc93MpQcMs+qx++U4iNUuOakhtlNvVA0tGPKg1U
         Gfn2VZ+BrDUHykKhpsmLDIH+SCnzyG++o03nQ4HXaehKKYTfdUoyaLzX5yMMEl6G9Hy7
         DzsuwC9KpVJPpx9rx9O/POG5iai1Lq7hC6x3r6T3WKT43h1wnIuBUnDJ5tuuT6ik5iU2
         Nj5VLaR6R8y7rHxJMxb/RJ/O70M5X4FUsOpU/8zvD4+GnU803AcqAIsGyeHCTf+AIUTo
         vYOQ==
X-Gm-Message-State: AJcUukfnx2KiWjN+LlhW2GYjVwLG/4/GJ6PPpYdslaKoqvnG4tOfVnfW
        3n+cpzKExCO1IZU086k0mXwv8HCO45owSnNd6RA04Q==
X-Google-Smtp-Source: ALg8bN7ZUIVvz/HaTVWhXkJjtC+r8eu3kioTS44j9UIPmqhIoVWZ9kTat7ZpdHH/tTrBn313j7NWXzhvxV/QLKOfWPk=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr6380973jaj.82.1547115685209;
 Thu, 10 Jan 2019 02:21:25 -0800 (PST)
MIME-Version: 1.0
References: <1547093005-26085-1-git-send-email-longman@redhat.com>
In-Reply-To: <1547093005-26085-1-git-send-email-longman@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Jan 2019 11:21:13 +0100
Message-ID: <CACT4Y+YJYSo5GtSvMSqh4y_w7jWC1S-RYu+exuR3DU9NyrpJqA@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Add debug_locks check in __lock_downgrade()
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 5:04 AM Waiman Long <longman@redhat.com> wrote:
>
> Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
> warning right after a previous lockdep warning. It is likely that the
> previous warning turned off lock debugging causing the lockdep to have
> inconsistency states leading to the lock downgrade warning.
>
> Fix that by add a check for debug_locks at the beginning of
> __lock_downgrade().
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

Please also add:

Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com

for tracking purposes. But Tetsuo deserves lots of credit for debugging it.

> ---
>  kernel/locking/lockdep.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 9593233..e805fe3 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3535,6 +3535,9 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
>         unsigned int depth;
>         int i;
>
> +       if (unlikely(!debug_locks))
> +               return 0;
> +

Are we sure this resolves the problem rather than makes the
inconsistency window smaller?
I don't understand all surrounding code, but looking just at this
function it looks like it may just pepper over the problem. Say, we
pass this check when lockdep was still turned on. Then this thread is
preempted for some time (e.g. a virtual CPU), then another thread
started reporting a warning, turned lockdep off, some information
wasn't collected, and this this task resumes and reports a false
warning.
Or we are holding the mutex here, and the fact that we are holding it
ensures that no other task will take it and no information will be
lost?
Quite a tricky moment, perhaps deserves a comment.




>         depth = curr->lockdep_depth;
>         /*
>          * This function is about (re)setting the class of a held lock,
> --
> 1.8.3.1
>
