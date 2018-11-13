Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9D7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24232245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds9s9zjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24232245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeKMS3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:29:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34898 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730800AbeKMS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:29:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id z16-v6so12255595wrv.2;
        Tue, 13 Nov 2018 00:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIlh+aWiv5LllTjpX7l82ZE2zR1Qo4tuK++dNvEuhZE=;
        b=Ds9s9zjPfbfboxSfnc98VW9iT+oPKh76TkgXYYKpCZMJexbLky6EYNOX0m36EjkfuW
         Dc0OR2QfLO1vaY2PHKNHLhqUT3LuyUdkX1UXLatAFfyMeIh2H+hztDBomyO/WbKHw6RG
         jPufRgGAYlWrAPobi3CnFvaSjZluzRuQdQpI7OGuNPCzbkDEkDFo/mHiNRtKNuDnneBY
         A5DRZ27sAzLpR2sQJivPxelTiHZMzX/MKk/+8jODOl0XXvf0F/NiqSBWtuV27pN2skWn
         KiTYSq0mdyfw4SNiHyWTAx+C54WKgGb4WxMrQjbxsXra26OsQPLOL2HHcF4pbOz/MvNt
         FPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIlh+aWiv5LllTjpX7l82ZE2zR1Qo4tuK++dNvEuhZE=;
        b=Q80YaZsH/20ZRqWSY+dx5RZxJJ3I3mi0oWZvZn2uLY8KtnerdUz+gUM1/TUYBzn1g5
         om5sdvoo0sR6cLQqfehy8wuWGNwAmKbpsdgU741M0EbgF1H9rmKLN5Oxtu61sChva3qx
         SIQaJF7rvZlP2tyFgcRVxudhgzhnXheA3SCF+TxKdrYDhHc9kLgGdICK1WUVl42gs8o/
         X+NccP6nYl9wbfRqiP3QOMyiXoQbaAl+BbOllE9XPTy8GTWk7452xf2r6Z+E4mdJjFdv
         n0FL5PgLbJO9DwUpDlNOXgW0ztSz5OJ7sTc2KzCiX1+KPU9jOiFuDQmtUFfAA01y9Wut
         9wvQ==
X-Gm-Message-State: AGRZ1gJuSjE1B9QccyNsORHhTTXYlnOM3YzHPdUcqR3o+nCuBniE5XLa
        RaWIuxEL9d9VqCWUQWpDFvECR4LPKE+yJTou1Eo=
X-Google-Smtp-Source: AJdET5eJM+PhFTvukCYX8l7uRvZQgY0K6pMOGKYIy6qfPFA3FR/AJMZR3tEUJny/H9GUIzYNgm9+iaaxkQLQ1qnUTgA=
X-Received: by 2002:adf:ab50:: with SMTP id r16-v6mr3906985wrc.62.1542097930041;
 Tue, 13 Nov 2018 00:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20181113055252.79406-1-sashal@kernel.org>
In-Reply-To: <20181113055252.79406-1-sashal@kernel.org>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Tue, 13 Nov 2018 08:31:58 +0000
Message-ID: <CAK+_RLnZiy13paU3tRggDpanLv=h+ZCcyXtOz_2UzWfy4tsu2w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 3.18 1/9] bfs: add sanity check at bfs_fill_super()
To:     sashal@kernel.org
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 at 05:52, Sasha Levin <sashal@kernel.org> wrote:
> syzbot is reporting too large memory allocation at bfs_fill_super() [1].
> Since file system image is corrupted such that bfs_sb->s_start == 0,
> bfs_fill_super() is trying to allocate 8MB of continuous memory. Fix
> this by adding a sanity check on bfs_sb->s_start, __GFP_NOWARN and
> printf().
>
> [1] https://syzkaller.appspot.com/bug?id=16a87c236b951351374a84c8a32f40edbc034e96

Hi Sasha,

Thank you, but no, I am rejecting this patch as I have already
submitted a much more robust and accurate (stronger check) patch to
Andrew Morton a couple of days ago against 4.20-rc1.
Andrew, if you would like me to make the same patch against 4.19.1 as
well, please let me know.

Kind regards,
Tigran

>
> Link: http://lkml.kernel.org/r/1525862104-3407-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tigran Aivazian <aivazian.tigran@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/bfs/inode.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> index 90bc079d9982..0ee38b284ad7 100644
> --- a/fs/bfs/inode.c
> +++ b/fs/bfs/inode.c
> @@ -349,7 +349,8 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
>
>         s->s_magic = BFS_MAGIC;
>
> -       if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end)) {
> +       if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end) ||
> +           le32_to_cpu(bfs_sb->s_start) < BFS_BSIZE) {
>                 printf("Superblock is corrupted\n");
>                 goto out1;
>         }
> @@ -358,9 +359,11 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
>                                         sizeof(struct bfs_inode)
>                                         + BFS_ROOT_INO - 1;
>         imap_len = (info->si_lasti / 8) + 1;
> -       info->si_imap = kzalloc(imap_len, GFP_KERNEL);
> -       if (!info->si_imap)
> +       info->si_imap = kzalloc(imap_len, GFP_KERNEL | __GFP_NOWARN);
> +       if (!info->si_imap) {
> +               printf("Cannot allocate %u bytes\n", imap_len);
>                 goto out1;
> +       }
>         for (i = 0; i < BFS_ROOT_INO; i++)
>                 set_bit(i, info->si_imap);
>
> --
> 2.17.1
>
