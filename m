Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C32C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF7B2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 17:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQzCHt2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbeLPRAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 12:00:46 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34011 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeLPRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 12:00:46 -0500
Received: by mail-yb1-f193.google.com with SMTP id k136so4248458ybk.1;
        Sun, 16 Dec 2018 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoGIQ0KbTtmtQte2LVtVxFEytgYXaao+I+RNMuO1R/A=;
        b=XQzCHt2HOt+NO8229QQ9xDPu30EJn5iN0CX7GU1Wu9RjPB+TfMgzZcyuSR9igU6biI
         vDE9znICLSah46eJJvn8PsClx0slSSe0JmfesIwYTZ75CK5NGE1bWLDlc9SUPH4AmNnG
         bSvkVE6XrsPFA6N87M/suYkk7agWnmikYvJo986BwgZhwKlqdfS8VlkGFRcq6HwejVHs
         9hspklqyESD/hO1cr80xZPaHco/rYYJibruld81kwsJE2Y39U06EN6dKelpn68s/WnMv
         GXr0+Sh0uuavmvZyvhtKvkg5GwZMlxqyYN5TyY3EMA08W+vtRm5outXq01dDFYdUpgF6
         FM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoGIQ0KbTtmtQte2LVtVxFEytgYXaao+I+RNMuO1R/A=;
        b=DD8DfuYpB/B3oOHkXehXejd4flQcSfv4uesQKQNu6RpXP3FbBKCRDdccqGk3gGFMGs
         NP0s1WD36IghIBzRaruDnI8/bv6BQT6Wo0kqTC2kO5Ols96ysrTk1ci8rTAFf0mS2x1U
         yI1MqXy6gcf2kNtBj7OPAZv64q8ByqZjy5U3Yvwd+4cjxkZhU7nkc/uwdxGxPdm8Eovc
         UipqhLtJReehz3SBkS62gkkVtdpqcBH31oxSoKcmG6ohBe1S1rRSnJXhLxlHCpRDeQ9n
         tlEhm8TRXnujwPhaHJXV6SclzD3zSAuaiO2Wc9hFun3QWkcKMHJiXE5QedI8kDVVTl/h
         7ljQ==
X-Gm-Message-State: AA+aEWZBS8kLf/tS4yVj5GhjZbguhdwqM/Qdhf3GBPOki98u9DvKTqWZ
        XVt1+VLRwpSTBGDI3pqoVYbJeAW+YpRm82z5gZ4=
X-Google-Smtp-Source: AFSGD/XwNu6eAHasYqV+A/Sp2BgDpGVSEYk/wqEBG3XDRb5uDsFJx9QYIhtTXjUudmN07BgUi85w7zE3P3zCI1WuWkQ=
X-Received: by 2002:a25:912:: with SMTP id 18mr10627810ybj.462.1544979644930;
 Sun, 16 Dec 2018 09:00:44 -0800 (PST)
MIME-Version: 1.0
References: <000000000000064bcf057a59e3b9@google.com> <00000000000058055a057d14a1f4@google.com>
In-Reply-To: <00000000000058055a057d14a1f4@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 16 Dec 2018 19:00:33 +0200
Message-ID: <CAOQ4uxgcxGXcCiC02UJrvwkCjiXERJxuNvoG_mfLga7Am3c5GA@mail.gmail.com>
Subject: Re: WARNING in ovl_instantiate
To:     syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 9:34 PM syzbot
<syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=143f9a15400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6e543400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
>
> overlayfs: filesystem on './file0' not supported as upperdir
> overlayfs: filesystem on './file0' not supported as upperdir
> overlayfs: filesystem on './file0' not supported as upperdir
> overlayfs: filesystem on './file0' not supported as upperdir
> overlayfs: filesystem on './file0' not supported as upperdir
> WARNING: CPU: 1 PID: 28918 at fs/overlayfs/dir.c:263
> ovl_instantiate+0x369/0x400 fs/overlayfs/dir.c:263

Looks like some corner case race when using same dir as upper and lower.
Doesn't look like a critical issue, I just don't know how to explain
getting to this
state. Couldn't reproduce on my target machine.

It would have been interesting for me to see the strace of the repro threads
when that WARN happens. I wonder if anyone else has already asked for it and
how hard would it be to make that information available with the bug report.

Thanks,
Amir.
