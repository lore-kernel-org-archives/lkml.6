Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DD7C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288462244D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K03KDV41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288462244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeGGDua (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:50:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38037 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932769AbeGGDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:50:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so27023553oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 20:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZFPDMKMC8Eb1D2j6cSBeRYiMdxx9JLVUOuuPUpfaXI=;
        b=K03KDV41v0XLvp7iD6bJ6nInv/rN8lErCSaUJE3Bz8qSFQr282a0nZF+NS98zg5GKA
         bY0cNkdqx7Kw7wy19ph8y4Ptqp+aZvQx+drkY1GieJlg4nVNSzES5ZfnW4iB4UJalD9d
         SroOdMRMvlmqH6JLq+fpcNB4bi5bq5+DxeogEvXKDB9GNE4xMQq2S3TTlnokx4IyrJKI
         61N1Y0m/3MH8uy4MZ6WRv1WY1dpnk86+oGTORyRROG077UCcJ2CLTLsNiSwjQHEFa1pa
         xrd3i7VHgy8mLZKND0PF34+EffL75ZZxZCjUnmdW7PMebTi5xChS4cbse6+3QZxT8xte
         /jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZFPDMKMC8Eb1D2j6cSBeRYiMdxx9JLVUOuuPUpfaXI=;
        b=Fic4NEimWXkBUhMjBEoD7spcCoSNVNqORpU1dZYq9TlOA8+FP7jvzrBe7aPB5e+eVo
         qqOHQq68KYjVQ8y8RwpHpRe3SUtblFO0MLShTnRvpN4D0r3OZZfAeYcQtTaLZQlkHWYb
         r4B5rNAhD4ZATAE1p82/KLzrtMZt5gR+eraS2hetErK0FTZGPkxVbSnAPdF0x3Wib/C2
         G98K5UTp0/8g56HoAK5nd3F9jC0gSOUA5Gs5afsllJBGti5CcaY+qs0QyYOhjMeDWb5s
         btGtveu9ooRLQqWhxfpjiJR5uBrJdtGvz3Kh6s3M+iRexmgQC+dJGbHEDXSQ/uE9OmR4
         eRIQ==
X-Gm-Message-State: APt69E07WK4OsUKUAd2FB5Xp9IyuCTF9EnvNdqAfOItT0UJ9xWC5zlrs
        B6G7sHO0BPDkQzKMlOXXnwnSsrldfO0bFdrY3nzcIg==
X-Google-Smtp-Source: AAOMgpeyuqsxnhJG6KySFifhDweCbuiNWuP1jEn14qdWlSmzGkOBlgLmlwOCT1yfbaQ6Z3nLmYxXRKp84DD1urG3K7Q=
X-Received: by 2002:aca:d015:: with SMTP id h21-v6mr14971245oig.142.1530935427165;
 Fri, 06 Jul 2018 20:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <87vacsrt0r.fsf@notabene.neil.brown.name> <87fu3dihtf.fsf@notabene.neil.brown.name>
 <874lintqa6.fsf@notabene.neil.brown.name> <87y3fcegnn.fsf@notabene.neil.brown.name>
 <CAG48ez2yTZMye0W3_5R04bV-Qyaz-=zSiVonw_zvRQNH6dcfeg@mail.gmail.com>
 <878t6nybj7.fsf@notabene.neil.brown.name> <87601ryb8a.fsf@notabene.neil.brown.name>
In-Reply-To: <87601ryb8a.fsf@notabene.neil.brown.name>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 7 Jul 2018 05:50:00 +0200
Message-ID: <CAG48ez1XSV9a-SBob6_p3RNC2vU3FnMnsm9Cd6deChh6QexpzQ@mail.gmail.com>
Subject: Re: [PATCH mm] VFS: seq_file: ensure ->from is valid.
To:     neilb@suse.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 5:29 AM NeilBrown <neilb@suse.com> wrote:
> Previous patch ("VFS: simplify seq_file iteration code and interface")
> removed code to set ->from to zero when ->count is zero, as ->from is
> dead at that time.  However it didn't ensure ->from was set properly
> whenever ->count becomes non-zero.
> This can only happen when ->show() is called.  Of the three places it
> is called one already has ->from set to zero.  The other two are
> fixed by setting from to zero after fully flushing the buffer (at which
> point ->count will also be zero).
>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: NeilBrown <neilb@suse.com>

Tested-by: Jann Horn <jannh@google.com>

> ---
>  fs/seq_file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index fd82585ab50f..1dea7a8a5255 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -220,6 +220,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>                         goto Done;
>         }
>         /* we need at least one record in buffer */
> +       m->from = 0;
>         p = m->op->start(m, &m->index);
>         while (1) {
>                 err = PTR_ERR(p);

This looks correct to me. I have also tested that with this patch
applied, my crasher doesn't work anymore.
