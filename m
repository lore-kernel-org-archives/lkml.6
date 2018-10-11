Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F7EC46466
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E0C2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mj3rlYZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E0C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeJKUA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:00:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42803 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJKUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:00:28 -0400
Received: by mail-io1-f67.google.com with SMTP id n18-v6so6420445ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C0PghJz1FTsvjZ8/fdWGRotBFQoV9N/HuJZ6lEzJWhE=;
        b=Mj3rlYZvFeK18sicUH4/4NFHJSdjFXxobegMrUpjA0yX9LlarwdmDMgnlYsntPm59T
         UqFtxZiT5kZniqZ5R+HJgjCdUfrquLsuZeFhyfBGnXAgBF+iea2JdiBL9Ni070dstE71
         DHzEHiZICq+xG8iyO4tOKhlohxRefmg4nYqvUzzik+Czhl46xOLP3wIVSB5Vw5COpMwk
         F6oS/VL21UBfwnAUYEiD8veRTnwAiaHRzGFYW1MjSPz5+jlv5keyHegDXXk+F+lYzXHs
         qN5qgX+3gkDV9gm+GBaTaOXO3J0TR6E6/iFWA3SUioxrBQ3MUA2kMV4qdldLtznWeScc
         gETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C0PghJz1FTsvjZ8/fdWGRotBFQoV9N/HuJZ6lEzJWhE=;
        b=GnhMtrjK8LBCUXS4c++0XHfZGQdAmcpbYcKeF/DLswcPGYHu7vQWd2yqnQ4kNwPGDS
         WCMiNNhMwvXiqZeJsPdYfBr1ospm6nXJvERiVqU081gJmEKDMzfACRpyRVfK3EUflc/5
         8VqRm1zAEhPNG7OEp96l8+GPGuaYkTnniomcFLfKunnx/3HuO1v5cwCzP+w0XfiURxdP
         niKVwfpHLc+35X/ywPtm+KofHv0XX8Ym79JGe1CpoVFIpUxYWrBChLreZ7nUquMXiWHA
         mWcBRU6auWl28BdSbY3X4PNnlTbUnFdrM6SCnkOfF9bQL7XOHBaAZDlDvel7WtNJ2Nzn
         K5MQ==
X-Gm-Message-State: ABuFfog2Ds8G8Gi6wwk/QtatqZcloO1vd/4F5PRpNSAKOkG5KS9kNwjK
        Tfa/LG9vkOK2CzXg5+5yFv4SRTDhA1Nyhf8lY8fcHQ==
X-Google-Smtp-Source: ACcGV619vVPOMDnb6GfQHkSWPPwauGCLEx42bC/RpVYPtMa+mxBEXH6UCnqLxhiZwyWuD/mzh4DZDggFvzntkNWqnD8=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr831610iog.271.1539261206864;
 Thu, 11 Oct 2018 05:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 05:33:05
 -0700 (PDT)
In-Reply-To: <20181010155814.GC20918@nautica>
References: <000000000000ca61cd0571178677@google.com> <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica> <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica> <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 14:33:05 +0200
Message-ID: <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
Subject: Re: BUG: corrupted list in p9_read_work
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>,
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

On Wed, Oct 10, 2018 at 5:58 PM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Dmitry Vyukov wrote on Wed, Oct 10, 2018:
>> > The problem is that you can't just give the client a file like trans fd;
>> > you'd need to open an ""rdma socket"" (simplifying wording a bit), and
>> > afaik there is no standard tool for it ; or rather, the problem is that
>> > RDMA is packet based so even if there were you can't just write stuff
>> > in a fd and hope it'll work, so you need a server.
>> >
>> > If you're interested, 9p is trivial enough that I could provide you with
>> > a trivial server that works like your file (just need to reimplement
>> > something that parses header to packetize it properly; so you could
>> > write to its stdin for example) ; that'd require some setup in the VM
>> > (configure rxe and install that tool), but it would definitely be
>> > possible.
>> > What do you think ?
>>
>> I would like to hear more details.
>> Opening a socket is not a problem. Why do we need a tool for this?
>
> Sorry, that's my head thinking unixy and piping things :)
>
>> I don't understand the problem with "packet-based" and what does it
>> mean to have a separate server? Any why?
>
> Packet-based means you can't just read/write in a fd and expect the
> other side to know where to cut the packets to send it to the client,
> but if we do it internally there's no problem. We know where to cut.

Ah, OK. This should not be a problem because the descriptions:
https://github.com/google/syzkaller/blob/master/sys/linux/9p.txt#L70
know what a packet is. So we always give write a single packet.


>> We definitely don't want to involve a separate third-party server,
>> that's very problematic for multiple reasons. But we can have a chunk
>> of custom C code inside of syzkaller.
>> What exactly setup we need?
>
> The setup itself isn't that bad, it's actually pretty much trivial - on
> a fedora VM I just had to run 'rxe_cfg start ens3' (virtio interface
> name) and then the infiniband tools are happy e.g. ibv_devinfo should
> list an interface if you have the userspace library that should have
> come with rxe_cfg.
> (specifically, my VM uses /etc/libibverbs.d/rxe.driver to point to the
> lib, and /usr/lib64/libibverbs/librxe-rdmav16.so the lib itself)
>
> Once tools like ibv_devinfo list the interface, it means syzkaller can
> use it, and very probably means the kernel can as well; that's it.
>
>
>> I guess it will make things simpler if you provide some kind of "hello
>> world" C program that mounts 9p/rdma. I don't need exact messages
>> (they will be same as with pipe transport, right?) nor actual server
>> implementation, but just the place where to inject these packets.
>
> That's still the tricky part, I'm afraid... Making a separate server
> would have been easy because I could have reused some of my junk for the
> actual connection handling (some rdma helper library I wrote ages
> ago[1]), but if you're going to just embed C code you'll probably want
> something lower level? I've never seen syzkaller use any library call
> but I'm not even sure I would know how to create a qp without
> libibverbs, would standard stuff be OK ?

Raw syscalls preferably.
What does 'rxe_cfg start ens3' do on syscall level? Some netlink?

Any libraries and utilities are hell pain in linux world. Will it work
in Android userspace? gVisor? Who will explain all syzkaller users
where they get this for their who-knows-what distro, which is 10 years
old because of corp policies, and debug how their version of the
library has a slightly incompatible version?
For example, after figuring out that rxe_cfg actually comes from
rdma-core (which is a separate delight on linux), my debian
destribution failed to install it because of some conflicts around
/etc/modprobe.d/mlx4.conf, and my ubuntu distro does not know about
such package. And we've just started :)

Syscalls tend to be simpler and more reliable. If it gives ENOSUPP,
ok, that's it. If it works, great, we can use it.
