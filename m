Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0F12087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dG8LTAel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0F12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJJV0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:26:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34140 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJJV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:26:37 -0400
Received: by mail-io1-f68.google.com with SMTP id w2-v6so3961290ioc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rF64gcV34KiV1fr9uWm8ceuSgT14tQtyXq3dBZps1S8=;
        b=dG8LTAelReepN6wHh7+62cfglNsXcT/fmA4YnZvLAEviaj+FlDB+d2Y/V0SFkCbExr
         h7P2Mqw8fHRk61lqc3S57A3LeTXX+JDbPVWVFvAATf1hcnts4GYGsjUhN5lsv/N3zRXS
         Dbbgi7+ZitHssyOc64LbTObPC1PxUOivPCJ1S/0JfuOzWmY7pWFgDknfC6cZNyNqIG/E
         RWeKI8dN1BMiWsTZUKNHC+xV55GvjS798b7hL0ZTy8iLLFg9qcWzE5QMoUkSHFFfZsSY
         reKtG04UuXcXFFx91vDbvIW2KbwHhOuCi36JNH0jjqrSMALk+kSAYOJ5fELAypqrVCvE
         DkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rF64gcV34KiV1fr9uWm8ceuSgT14tQtyXq3dBZps1S8=;
        b=cYbiWsSCPLuZblvyqw1biT3Nk7MufBZ3FuqEsDh/1yGMLS7SeuYL91Fc13FaI8oxz/
         wi0wjzufqFjpRFx3M2Ixw40zEDK0terCgkl+wVRmv52l8r4Vs+5WnKXaTBILDkTuXKPd
         zOxeN1uvIfnDPpym9lwMuz4uA/RExP8uIjxOXJItVP+xn/SuWy2vpq8J9qOn6ze99aSR
         6BP0rkSaCgRYdLyPU4f7+H6/4eSUqAT4PrU5mkNQhsQxtu5FuSDXr/GIjy0A2Ammv3wP
         HSID0LvvNAH98qdtT9CqbbVmM4XOx+KE+MFfIzJMPtZed0R+UpHCD145StwsMspJUFb+
         acvQ==
X-Gm-Message-State: ABuFfohw0g3qfX3/+XYdPRbLNUNYXeI85BhxF8y3oaOHbkf8GWTfiR1g
        nqS42iRVwqMgB81V5A1Zvi/9d+YAdQ8iZWkXnb3Z2g==
X-Google-Smtp-Source: ACcGV63up1jvgDpbETi2B0pYHAyz8kG74Cw/zHXxTyLKaWjfpDStcsScRgDMzs9mjlIb+L90mYu7kqQSjc7rLj3S5FA=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr20481117iog.271.1539180256951;
 Wed, 10 Oct 2018 07:04:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:03:56
 -0700 (PDT)
In-Reply-To: <20181009020949.GA29622@nautica>
References: <000000000000ca61cd0571178677@google.com> <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 16:03:56 +0200
Message-ID: <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
Subject: Re: BUG: corrupted list in p9_read_work
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Leon Romanovsky <leon@kernel.org>
Cc:     syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 4:09 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> syzbot wrote on Mon, Oct 08, 2018:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    0854ba5ff5c9 Merge git://git.kernel.org/pub/scm/linux/kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1514ec06400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2222c34dc40b515f30dc
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b91685400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com
>>
>> list_del corruption, ffff88019ae36ee8->next is LIST_POISON1
>> (dead000000000100)
>> ------------[ cut here ]------------
>> [...]
>>  list_del include/linux/list.h:125 [inline]
>>  p9_read_work+0xab6/0x10e0 net/9p/trans_fd.c:379
>
> Hmm this looks very much like the report from
> syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
> which should have been fixed by Tomas in 9f476d7c540cb
> ("net/9p/trans_fd.c: fix race by holding the lock")...
>
> It looks like another double list_del, looking at the code again there
> actually are other ways this could happen around connection errors.
> For example,
>  - p9_read_work receives something and lookup works... meanwhile
>  - p9_write_work fails to write and calls p9_conn_cancel, which deletes
> from the req_list without waiting for other works to finish (could also
> happen in p9_poll_mux)
>  - p9_read_work finishes processing the read and deletes from list again
>
> For this one the simplest fix would probably be to just not
> list_del/call p9_client_cb at all if m->r?req->status isn't
> REQ_STATUS_ERROR in p9_read_work after the "got new packet" debug print,
> and frankly I think that's saner so I'll send a patch shortly doing
> that, but I have zero confidence there aren't similar bugs around, the
> tcp code is so messy... Most of the syzbot reports recently have been
> around trans_fd which I don't think is used much in real life, and this
> is not really motivating (i.e. I think it would probably need a more
> extensive rewrite but nobody cares) :/
>
>
> Dmitry, on that note, do you think syzbot could possibly test other
> transports somehow? rdma or virtio cannot be faked as easily as passing
> a fd around, but I'd be very interested in seeing these flayed a bit.

Hi Dominique,

How can they be faked?
If we could create a private rdma/virtio stub instance per test
process, then we could I think easily use that instance for 9p. But is
it possible?
Testing on real hardware is mostly outside of our priorities at the
moment. I mean syzkaller itself can be run on anything, and one could
extend descriptions to use a known rdma interface and run on a real
hardware. But we can't afford this at the moment.
As far as I understand RDMA maintainers run syzkaller on real
hardware, but I don't know if they are up to including 9p into
testing. +Leon
