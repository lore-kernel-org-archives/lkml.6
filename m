Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5588C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73D920855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2fMLgaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeL3LJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:09:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55399 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeL3LJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 06:09:05 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so33351545ith.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 03:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IopB3OJEHMkbL4+zfUW9FfwFFcYlgYfqDYEkENCo6mU=;
        b=H2fMLgaw5QAf10jNRHr+TXGERAXyjZ902iLiCUVjA12BKkNC1QNSYG5ONuxk7x2G6n
         Zdj8Tf4WCo4GvswGuK2HdMgRaCjmfTSkKuJyTFS16Zt2eC2oZdl7rrL91Gn4RANOzk2y
         AAy5/4V9W7bJQ+f0vTQavEzSmSFeR1zXuJYjmN5nnlJdyPlqj1s+84c64BMKhRlZBBAj
         rKybKt3lrs5KXVlbhKbljslVRXQPzDgKdCcxY15Tm8kq4vqTqDP+fDV0zvHS1fDxQGnl
         HrfcimXtY/JYQZ/LuSLHEiOWlM6fTZHTxBd/nWtVxUr4NiX3XGlndVpNm2yh3bGm+IRN
         bhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IopB3OJEHMkbL4+zfUW9FfwFFcYlgYfqDYEkENCo6mU=;
        b=RgorAhdNMelyt2tgGoY1ezcyJCP9s2NdZiBcr2oz2dZwJWdr3SO57eApRaSHE1xue3
         SmsO08852zIYA2+Hd3dGqBxmcpCJQm6WvXn662X9uOrbXQsWZy2ob2zyNVQ5FNUFXmoS
         QyQALzvv6JjoLMl2Jqsp8WFT5mj/uBokBrOLhcAzzdR5gTebLR36hDHf0rhcZZ383OuK
         7mgkMFrDQ+jYHno9aCch0z1H6YHnNppfWMcAeScXjquvPgvm7AIpQJyHM2oJz0ubHPpb
         X4NHNBY1hCbwGNjMOs9YsKE7s3t9wHMGXGNMbw+EZG7Y9OmfGtXRKUcaN+TJ6pLPd9Qr
         rHVg==
X-Gm-Message-State: AJcUukc3XpdkHztV/Jx7DMbERulQL9zuBGqPP6nzKjYoXn4AQxlDwUmh
        +cb46LCNxd8m3Q5K0OKqJXZauICvkzhzB7yjpBBnuA==
X-Google-Smtp-Source: AFSGD/XBJcBtYCB059Cu2uKzCaISRJsiEfVNVVCqaBdjJw55WPBgLJDKcoga8wiBKyOB4jDszqhQMrzGANPp8RFVb0E=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr19107462itl.144.1546168144058;
 Sun, 30 Dec 2018 03:09:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d89413057e3aeec2@google.com> <3100603.HWLWhOUWpG@sven-edge>
In-Reply-To: <3100603.HWLWhOUWpG@sven-edge>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 30 Dec 2018 12:08:53 +0100
Message-ID: <CACT4Y+Yb+OvJ8c4Vot9pcTEF1OhTHeu=XK5Jb=EXEBv6xmNwnQ@mail.gmail.com>
Subject: Re: WARNING in batadv_is_on_batman_iface
To:     Sven Eckelmann <sven@narfation.org>
Cc:     syzbot <syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 12:00 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Sunday, 30 December 2018 11.41.03 CET syzbot wrote:
> [...]
> > HEAD commit:    d8924c0d76aa Merge tag 'devprop-4.21-rc1' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=122a373f400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c764de0fcfadca9a8595
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd1d67400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com
>
> What is the bug here? The kernel module showed a warning because the parent
> device cannot be found in the same netns using __dev_get_by_index.
>
> The test system was just configured to panic on warnings. So are we now
> expected to show warnings or what is the expected behavior?
>
> This behavior was added with commit b7eddd0b3950 ("batman-adv: prevent using
> any virtual device created on batman-adv as hard-interface") - 3d48811b27f5 in
> the out-of-tree module.

Hi Sven,

The problem is that kernel code uses WARNING when it should not.
For WARN guidelines please see this:
https://elixir.bootlin.com/linux/v4.20/source/include/asm-generic/bug.h#L81
and this (search for WARN_ON_ONCE):
https://lwn.net/Articles/769365/


> Kind regards,
>         Sven
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7eddd0b3950ea9dc863f1cbfa30d172dbf772f4
