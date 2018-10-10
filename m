Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89312087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTmabuYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89312087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJKBgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:36:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35980 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeJKBgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:36:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so6774734qth.3;
        Wed, 10 Oct 2018 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dLVshSdciuneEtH9iUXf7KeMbwhOUd0vgPurEtL8bPc=;
        b=OTmabuYbgJc702LapkpM9KutpYprmnrIlUpEmnU3dXYVKhbWKb91p8B7Z+yp/Tyx5A
         5Xp6AO9wvI1KkjR0XKGyR9zk+OXS3bAuxmghHG/tMRe+qDvUnH0oGXmXJrUsKsO7564B
         vaO/yft9myj8eLNmBt+uEG27SCKi6jqFWJ80I0Z6LAofgvd0sZ9CnOBt4WN3U4JA4QQ5
         NDn4sMk612UbolTTwpfEvMoZ66By2GCHdBoNV0CBsIXcMeL4cZCzj+AfneIPmGQ6XIJV
         Uc/FOIIqDUgwJBxWI/4SxCRd6sLk5NpNDCwUwNUoQAARwUOQBuH0rpDIi+DZp3sVmg6n
         b5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dLVshSdciuneEtH9iUXf7KeMbwhOUd0vgPurEtL8bPc=;
        b=rz2MEP617h7rFCIhdbWW00+WOI+wuTYVdeqF4ZqD5uCgvIgaL6Htgc3U4m7ExDy5Zu
         8PUtQy3622XMNi+4R802oMuWktu0JSJIrQbkB1DlcHzazyZYzLKcAPSXEYv1H4P3Ns7r
         hmiwY4gcpIMk1G4vyJSKZagmBUYjU+PvrP9dbdmBgEiAKS2ccymMAlzCNb00AGXu9irH
         bHZsEeqID6B+pM+BK1JQ9Cc1dD5tM/8yFdj+Zog3c0s8KSXFIMcexhsd0uQsUwBgIUxb
         MxUZEz5QLWSQVob6AnWLi73tcuRr4j2o3998DOBnEmbo9SVMV1wJ3bblXeMnaJ1Vrj+J
         yHRQ==
X-Gm-Message-State: ABuFfoixwSiUOIcx4hJEezwLZRBoPudZw6gAmPxLQB3XYLXwk+xo3enQ
        2OrKKU7IvjB4s+DQIKo1jCU=
X-Google-Smtp-Source: ACcGV61aQ9W3Zt+c6mmXq8yzVp7G60M/A6oXq2f4hWmHKTbx79ycsJeQw0QvedH+soMeYp4PF0DKuA==
X-Received: by 2002:a0c:9c42:: with SMTP id w2-v6mr28331896qve.194.1539195209425;
        Wed, 10 Oct 2018 11:13:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f022:f7f5:3ccf:a328:f8f8:94f8])
        by smtp.gmail.com with ESMTPSA id l195-v6sm11713501qke.33.2018.10.10.11.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:13:28 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id A7CE2181183; Wed, 10 Oct 2018 15:13:25 -0300 (-03)
Date:   Wed, 10 Oct 2018 15:13:25 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_id2assoc
Message-ID: <20181010181325.GD6761@localhost.localdomain>
References: <0000000000007e767d05776336da@google.com>
 <20181005145855.GB6761@localhost.localdomain>
 <CACT4Y+YVRWSF+VyoBB1vwDevt0gwZYz69bSAivmZDG6r4J-kaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YVRWSF+VyoBB1vwDevt0gwZYz69bSAivmZDG6r4J-kaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:28:12PM +0200, Dmitry Vyukov wrote:
> On Fri, Oct 5, 2018 at 4:58 PM, Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> > On Thu, Oct 04, 2018 at 01:48:03AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    4e6d47206c32 tls: Add support for inplace records encryption
> >> git tree:       net-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13834b81400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=e569aa5632ebd436
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c7dd55d7aec49d48e49a
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com
> >>
> >> netlink: 'syz-executor1': attribute type 1 has an invalid length.
> >> ==================================================================
> >> BUG: KASAN: use-after-free in sctp_id2assoc+0x3a7/0x3e0
> >> net/sctp/socket.c:276
> >> Read of size 8 at addr ffff880195b3eb20 by task syz-executor2/15454
> >>
> >> CPU: 1 PID: 15454 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #242
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> Call Trace:
> >>  __dump_stack lib/dump_stack.c:77 [inline]
> >>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
> >>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
> >>  kasan_report_error mm/kasan/report.c:354 [inline]
> >>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
> >>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> >>  sctp_id2assoc+0x3a7/0x3e0 net/sctp/socket.c:276
> >
> > I'm not seeing yet how this could happen.
> > All sockopts here are serialized by sock_lock.
> > do_peeloff here would create another socket, but the issue was
> > triggered before that.
> > The same function that freed this memory, also removes the entry from
> > idr mapping, so this entry shouldn't be there anymore.
> >
> > I have only two theories so far:
> > - an issue with IDR/RCU.
> > - something else happened that just the call stacks are not revealing.
> 
> The "asoc->base.sk != sk" check after idr_find suggests that we don't
> actually know what sock it belongs to. And if we don't know then

Right. The check is more because the IDR is global and not per socket
(and we don't want sockets accessing asocs from other sockets), and not
that the asoc may move to another socket in between, but it also
protects from such cases, yes.

> locking this sock can't help keeping another sock association alive.
> Am I missing something obvious here? Should we take assoc ref while we

Not sure. Maybe I am.  Thanks for looking into this, btw.

> are still holding sctp_assocs_id_lock?

Shouldn't be needed.

Solely by the call stacks:
- we tried to establish a new asoc from a sctp_connect() call,
  blocking one.
- it slept waiting for the connect
- (something closed the asoc in between the sleeps, because it freed
  the asoc right when waking up on sctp_wait_for_connect())
- it freed the asoc after sleeping on it on sctp_wait_for_connect [A]
- another thread tried to peeloff that asoc [B]

For [B] to access the asoc in question, it had to take the same sock
lock [A] had taken, and then the idr should not return an asoc in
sctp_i2asoc(). Note that we can't peeloff an asoc twice, thus why
the certainty here.

If [B] actually kicked in before the sleep resumed, that should have
been fine because it took the same sock lock [A] would have to
re-take. In this case an asoc would have been returned by
sctp_id2asoc(), the asoc would have been moved to a new socket, but
all while holding the original socket sock lock.

