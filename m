Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8638C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B3120684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lravK+qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B3120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404382AbeKWBR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:17:28 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34022 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbeKWBR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:17:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so7632198qtp.1;
        Thu, 22 Nov 2018 06:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0M+LttlhlEKW7lTEt0z0x64h8C5T97YZoUafZU92Z10=;
        b=lravK+qnAmnID7D3sXmY/uzm0oZ0EhmY0SQ9ZGxf8RKVrpKOtxTr1lQ1KE79lyV5ZM
         58cF9mlZ48x53mI3sy2K9jC4vUfjY0zTgfYwHSGsnX2wiPyfYtFrKtbwlzlRpn0+ScNY
         ObDYKKpWF2t7hHqoAeC5KEaKtsXM2UsYou8kv6GiSQReF91rVGW8QerWMkgnL/eWcndS
         MNydfG9t86fYLHfp9M70Y9cGnDQyo1PfLXAL6xsMC8jpleQb2AgmNSYQfbc2zRnm6CYm
         Wl12wW+ma0KAgKDTUu0vGhxoCBWdgolyfnriBS8PvVBmR/IUMYATJJLt1iAtJenFv3B/
         Vq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0M+LttlhlEKW7lTEt0z0x64h8C5T97YZoUafZU92Z10=;
        b=T6aLkw/k4Fezk7dc1kB2DobhuctBEbVtXzmnX3W0Wn/CSo7TGzPwsRRjsYgU3xFBY2
         CFEDUsn5wG6VZAW5sYhQYmzj56VbBf2/GCD8NfFeGFBW0+g+hDwp2h963DMJ4izWmeyO
         xixZfJei8EB+McLZykK+4lMH7FiV48Xz7DisGwVxTGfc1Bye2Os5RrWg/As7LRXMxhXn
         gJUuz8OEPmjvIhdXCMKJcvnkGtRk2xGRVa+S2SENLkg+VRfowmep3s8eFhmggQe07ilV
         3UikNXXR/bJj0IU8juvljb3UHjdEZX79GCKmuefCaIPKTwKDbBv983SmOMxpRNSwdu+j
         VEYQ==
X-Gm-Message-State: AGRZ1gJ2DSx5vUST8wnNcF7It5oraHBUQMyig9L7tZhgUgg1Q93I2dLQ
        c5Nd+wQgqi+XVduaXgVpf30=
X-Google-Smtp-Source: AFSGD/XLXdcjTL09YtVVDNxevwmb2UaeMhBwc7CjLo+HSysSLU8h2WY31TEkuooVcZ/JZchln396OA==
X-Received: by 2002:ac8:88:: with SMTP id c8mr10545277qtg.218.1542897467973;
        Thu, 22 Nov 2018 06:37:47 -0800 (PST)
Received: from localhost.localdomain ([168.194.160.152])
        by smtp.gmail.com with ESMTPSA id q184sm21634688qkb.23.2018.11.22.06.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 06:37:46 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 59C0A180E13; Thu, 22 Nov 2018 12:37:43 -0200 (-02)
Date:   Thu, 22 Nov 2018 12:37:43 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     syzbot+9276d76e83e3bcde6c99@syzkaller.appspotmail.com,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs@googlegroups.com,
        Vlad Yasevich <vyasevich@gmail.com>
Subject: Re: KASAN: use-after-free Read in __lock_sock
Message-ID: <20181122143743.GE31918@localhost.localdomain>
References: <000000000000b98a67057ad7158a@google.com>
 <CADvbK_f3CpK=qJFngBGmO3VXFLsJm9=qqZVtxYOeBS8rwE=9Ew@mail.gmail.com>
 <20181122131344.GD31918@localhost.localdomain>
 <CADvbK_f0n64K==prdcM0KzU0S3pbo1oMW3HhE8zMngCUZp3-iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_f0n64K==prdcM0KzU0S3pbo1oMW3HhE8zMngCUZp3-iQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:44:16PM +0900, Xin Long wrote:
> On Thu, Nov 22, 2018 at 10:13 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Mon, Nov 19, 2018 at 05:57:33PM +0900, Xin Long wrote:
> > > On Sat, Nov 17, 2018 at 4:18 PM syzbot
> > > <syzbot+9276d76e83e3bcde6c99@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=156cd533400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=9276d76e83e3bcde6c99
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+9276d76e83e3bcde6c99@syzkaller.appspotmail.com
> > > >
> > > > netlink: 5 bytes leftover after parsing attributes in process
> > > > `syz-executor5'.
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in __lock_acquire+0x36d9/0x4c20
> > > > kernel/locking/lockdep.c:3218
> > > > Read of size 8 at addr ffff8881d26d60e0 by task syz-executor1/13725
> > > >
> > > > CPU: 0 PID: 13725 Comm: syz-executor1 Not tainted 4.20.0-rc2+ #333
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > > Call Trace:
> > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > >   dump_stack+0x244/0x39d lib/dump_stack.c:113
> > > >   print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
> > > >   kasan_report_error mm/kasan/report.c:354 [inline]
> > > >   kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
> > > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> > > >   __lock_acquire+0x36d9/0x4c20 kernel/locking/lockdep.c:3218
> > > >   lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
> > > >   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
> > > >   _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
> > > >   spin_lock_bh include/linux/spinlock.h:334 [inline]
> > > >   __lock_sock+0x203/0x350 net/core/sock.c:2253
> > > >   lock_sock_nested+0xfe/0x120 net/core/sock.c:2774
> > > >   lock_sock include/net/sock.h:1492 [inline]
> > > >   sctp_sock_dump+0x122/0xb20 net/sctp/diag.c:324
> > >
> > > static int sctp_sock_dump(struct sctp_transport *tsp, void *p)
> > > {
> > >         struct sctp_endpoint *ep = tsp->asoc->ep;
> > >         struct sctp_comm_param *commp = p;
> > >         struct sock *sk = ep->base.sk; <--- [1]
> > > ...
> > >         int err = 0;
> > >
> > >         lock_sock(sk);  <--- [2]
> > >
> > > Between [1] and [2], an asoc peeloff may happen, still thinking
> > > how to avoid this.
> >
> > This race cannot happen more than once for an asoc, so something
> > like this may be doable:
> >
> >         struct sctp_comm_param *commp = p;
> >         struct sctp_endpoint *ep;
> >         struct sock *sk;
> > ...
> >         int err = 0;
> >
> > again:
> >         ep = tsp->asoc->ep;
> >         sk = ep->base.sk; <---[3]
> >         lock_sock(sk);  <--- [2]
> if peel-off happens between [3] and [2], and sk is freed
> somewhere, it will panic on [2] when trying to get the
> sk->lock, no?

Not sure what protects it, but this construct is also used in BH processing at
sctp_rcv():
...
        bh_lock_sock(sk); [4]

        if (sk != rcvr->sk) {
                /* Our cached sk is different from the rcvr->sk.  This is
                 * because migrate()/accept() may have moved the association
                 * to a new socket and released all the sockets.  So now we
                 * are holding a lock on the old socket while the user may
                 * be doing something with the new socket.  Switch our veiw
                 * of the current sk.
                 */
                bh_unlock_sock(sk);
                sk = rcvr->sk;
                bh_lock_sock(sk);
        }
...

If it is not safe, then we have an issue there too.
And by [4] that copy on sk is pretty old already.

> 
> >         if (sk != tsp->asoc->ep->base.sk) {
> >                 /* Asoc was peeloff'd */
> >                 unlock_sock(sk);
> >                 goto again;
> >         }
> >
> > Similarly to what we did on cea0cc80a677 ("sctp: use the right sk
> > after waking up from wait_buf sleep").
