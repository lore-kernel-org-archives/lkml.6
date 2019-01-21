Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB52C37134
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8164A20844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="finSJ1MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfAUUYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:24:25 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46087 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfAUUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:24:24 -0500
Received: by mail-ua1-f66.google.com with SMTP id v24so7306245uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qipEnN/z0dbSkPyeoMeYCi9POoQUdns81Zz8WAtYNEk=;
        b=finSJ1MZyXpyTrR9FJFmvOzPS0SECNtBnajZptI1gbIsqJ7Ir+CZqy85IR/yArG01G
         Q9R3YIdWwEH0iIrG+3Br8t8jg2V874hRFpHrVAXN5fF5ST6GaBW9Uv9i/TpGpxIMkMcq
         qJl4j4bPbvlRg/D/kyfne8uGJVNxvt2Nk41w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qipEnN/z0dbSkPyeoMeYCi9POoQUdns81Zz8WAtYNEk=;
        b=Y9WATddUq7JU7+yF2nNMDzUx+BbF4fRw5ZqibswAncevQrPrN018hsitOIcCUjFL/A
         g/VGmz/tcfMBE62DRC8dqc0mhVnuSRslsk25u6GmpxQGO/uTAipJ2TL55vZYOEUwaYwN
         ODtVRCuF1IfTnCMlposZuDU4AwgMSLvBuWm+CFRg9u4JrkCgLrBpWbu8zfo0JQ+VE1Ku
         2sBmR5dT94OhhW0PHwmyEoBIwQOlxqiqhn3VQWhmcO7iey8t+TbMEPo6iVVr2k7W5H/x
         PFBt3/ldrqASlmvzAuiPtstrGIU6cOa6QenH+o8935TQUsXLUy4uvbR+Dfniy20JBwdc
         TjsA==
X-Gm-Message-State: AJcUuke12fXku/pI2Lm9fABiO8Ww6fOjKSpfvMsPXJKGaNKRlxMVjWFM
        fteSz42LStpVWUc2WynEYSbMo/6xJpQ=
X-Google-Smtp-Source: ALg8bN4eGxQrHSFiARsDeK2/bgsDL5Dtk9sMS9ubX41fHcV4p5IdCo1Nb3a95BwtWHHemh1ox4b87Q==
X-Received: by 2002:ab0:694f:: with SMTP id c15mr11023314uas.43.1548102262395;
        Mon, 21 Jan 2019 12:24:22 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id w65sm27342482vsc.16.2019.01.21.12.24.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 12:24:21 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id x1so13347915vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:24:21 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr12926582vsl.188.1548102260847;
 Mon, 21 Jan 2019 12:24:20 -0800 (PST)
MIME-Version: 1.0
References: <001a113f711ae2110c055f45acb8@google.com> <20171212220647.GJ185376@gmail.com>
 <CAGXu5jLcuE-h9V04fTtoSfz9mZdVeH1zfJOpRncK2NZkv2gsnQ@mail.gmail.com>
 <CACT4Y+aeSz05wDyStT75OFFi_aTyxbfzz7Z6jJ6FJsLNN3Pdtg@mail.gmail.com> <d1e2488f-a969-30d4-5023-6fa85a4e3833@I-love.SAKURA.ne.jp>
In-Reply-To: <d1e2488f-a969-30d4-5023-6fa85a4e3833@I-love.SAKURA.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Jan 2019 09:24:07 +1300
X-Gmail-Original-Message-ID: <CAGXu5jL0JhcDt4u32c-60hYY_k-8u=42NHyz9bt3wNuTkmjOfQ@mail.gmail.com>
Message-ID: <CAGXu5jL0JhcDt4u32c-60hYY_k-8u=42NHyz9bt3wNuTkmjOfQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Allow opening only regular files during execve().
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:15 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On Tue, Dec 12, 2017 at 2:06 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > I'm not sure what the fix will be.  Maybe the proc handlers should take a
> > different lock instead of cred_guard_mutex.  Or perhaps execve should check that
> > the file is a regular file before it attempts to open it.
>
> We can easily distinguish open() from execve() and open() from others. ;-)
>
> From a8c559566f743eeec31c3cf5bab7a90b1ff7f78b Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 21 Jan 2019 13:55:11 +0900
> Subject: [PATCH] fs: Allow opening only regular files during execve().
>
> syzbot is hitting lockdep warning [1] due to trying to open a fifo during
> an execve() operation. But we don't need to open non regular files during
> an execve() operation, for all files which we will need are the executable
> file itself, the interpreter program, and libraries like ld-linux.so.2
> required by the executable file or the interpreter program.
>
> Since the manpage for execve(2) says that execve() returns EACCES when
> the file or a script interpreter is not a regular file, and we set
> current->in_execve flag during an execve() operation, let's bail out
> when current thread tried to open a non regular file during an execve()
> operation.
>
> [1] https://syzkaller.appspot.com/bug?id=b5095bfec44ec84213bac54742a82483aad578ce
>
> Reported-by: syzbot <syzbot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

I like it!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/open.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/open.c b/fs/open.c
> index 0285ce7dbd51..b2e7b04ade46 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -733,6 +733,12 @@ static int do_dentry_open(struct file *f,
>                 return 0;
>         }
>
> +       /* The file or a script interpreter has to be a regular file. */
> +       if (unlikely(current->in_execve && !S_ISREG(inode->i_mode))) {
> +               error = -EACCES;
> +               goto cleanup_file;
> +       }
> +
>         if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
>                 error = get_write_access(inode);
>                 if (unlikely(error))
> --
> 2.17.1



-- 
Kees Cook
