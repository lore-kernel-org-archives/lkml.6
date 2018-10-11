Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0ACC677D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9363C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCmGy1wB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9363C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJKVHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:07:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53349 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJKVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:07:44 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so13468930itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P/S/NVmeGNzdOMcQibsQreCH5zyPGvKyD5ZGmoB3wFg=;
        b=vCmGy1wBZbbO0EvCkn6qXrLx53YWJV4Q0GcRk7fZps5WBtV5Rf9LUpE8xzss6BowqO
         CJRO/H3IaEXboStVtssOaPrQIZ9hwygtesron6Sgo5aBurHTr3XQpYRCuCTZVaYR/d4E
         qVhtKh9xrxkaFeKSAlNSGcqnpLgVRoGcA/ZimS/sD1l/cg5oej6FR9VMD+jNG4BBQixG
         SPQ2NAn2eNMTZtPoRo8+FEOj7i0hQCA9Mms9i3zqBCVeg5ZgwDKDug5lxz+OmeF04BC0
         1r9nHUDEcJ3DTWQY7e0qAx314uEpjSUz2HV1bAhLwVB/ma05NLPVK+8mnQetzJ5zISCk
         sE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P/S/NVmeGNzdOMcQibsQreCH5zyPGvKyD5ZGmoB3wFg=;
        b=HBfkfLFL1c3/s+D3spUUDvxZ/h7ATTlCT2yVFa5XLhCbDlD2eAswKjHbzNa1wAdkoK
         SO0N+Fm7xUM5exID8E8yDLq5OKjP04RYUuAGRe5j1tO4e9TjigjhjsqTr86LkfJCNTfE
         pWnzCPYAnJ5JTzrJiQYi8emKRDYIMTew7vrNSXUkmEZBCKJMEmbZ6qsYnUpfz7Zpr8mJ
         3B7iu04JAJLGxbv8V5pPiLn2WA+xTRjpFP2JjCk/mnJ0f5jPSx+XJf1CmeGuXUkNmwdA
         cYF7e4f6c23AQyGLIJz98+ihl734Wp5YR52f6qZBOn6mKj3DTWqWxW1ZffXW8oBJ6LOi
         nVVg==
X-Gm-Message-State: ABuFfojWczcrbuNV7sCY4ssXoI74z9CDDDKldmr0cCqWDFB9LMXM02tN
        tfeOqMeHWGJ8d62Cq1qqKYgVG+6IiLNg+GR2WhkZVw==
X-Google-Smtp-Source: ACcGV63RDCvgHYjgLJxLd0J91ztwiL9dPGd5zHzI22qGzyHM7WhHcaPJThx635VWoN0UlmTtl1h/OBjKZWerWzT3T10=
X-Received: by 2002:a24:24c9:: with SMTP id f192-v6mr1214250ita.144.1539265229029;
 Thu, 11 Oct 2018 06:40:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 06:40:08
 -0700 (PDT)
In-Reply-To: <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
References: <000000000000ca61cd0571178677@google.com> <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica> <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica> <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica> <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
 <20181011131045.GA32030@nautica> <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 15:40:08 +0200
Message-ID: <CACT4Y+bM4DxysCzhWvhURgBVpnLR4uu+oxhLpdZ3x92cKwtAzA@mail.gmail.com>
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

On Thu, Oct 11, 2018 at 3:27 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Oct 11, 2018 at 3:10 PM, Dominique Martinet
> <asmadeus@codewreck.org> wrote:
>> Dmitry Vyukov wrote on Thu, Oct 11, 2018:
>>> > That's still the tricky part, I'm afraid... Making a separate server
>>> > would have been easy because I could have reused some of my junk for the
>>> > actual connection handling (some rdma helper library I wrote ages
>>> > ago[1]), but if you're going to just embed C code you'll probably want
>>> > something lower level? I've never seen syzkaller use any library call
>>> > but I'm not even sure I would know how to create a qp without
>>> > libibverbs, would standard stuff be OK ?
>>>
>>> Raw syscalls preferably.
>>> What does 'rxe_cfg start ens3' do on syscall level? Some netlink?
>>
>> modprobe rdma_rxe (and a bunch of other rdma modules before that) then
>> writes the interface name in /sys/module/rdma_rxe/parameters/add
>> apparently; then checks it worked.
>> this part could be done in C directly without too much trouble, but as
>> long as the proper kernel configuration/modules are available
>
> Now we are talking!
> We generally assume that all modules are simply compiled into kernel.
> At least that's we have on syzbot. If somebody can't compile them in,
> we can suggest to add modprobe into init.
> So this boils down to just writing to /sys/module/rdma_rxe/parameters/add.

This fails for me:

root@syzkaller:~# echo -n syz1 > /sys/module/rdma_rxe/parameters/add
[20992.905406] rdma_rxe: interface syz1 not found
bash: echo: write error: Invalid argument



>>> Any libraries and utilities are hell pain in linux world. Will it work
>>> in Android userspace? gVisor? Who will explain all syzkaller users
>>> where they get this for their who-knows-what distro, which is 10 years
>>> old because of corp policies, and debug how their version of the
>>> library has a slightly incompatible version?
>>> For example, after figuring out that rxe_cfg actually comes from
>>> rdma-core (which is a separate delight on linux), my debian
>>> destribution failed to install it because of some conflicts around
>>> /etc/modprobe.d/mlx4.conf, and my ubuntu distro does not know about
>>> such package. And we've just started :)
>>
>> The rdma ecosystem is a pain, I'll easily agree with that...
>>
>>> Syscalls tend to be simpler and more reliable. If it gives ENOSUPP,
>>> ok, that's it. If it works, great, we can use it.
>>
>> I'll have to look into it a bit more; libibverbs abstracts a lot of
>> stuff into per-nic userspace drivers (the files I cited in a previous
>> mail) and basically with the mellanox cards I'm familiar with the whole
>> user session looks like this:
>>  * common libibverbs/rdmacm code opens /dev/infiniband/rdma_cm and
>> /dev/infiniband/uverbs0 (plus a bunch of files to figure out abi
>> version, what user driver to load etc)
>>  * it and the userspace driver issue "commands" over these two files' fd
>> to setup the connection ; some commands are standard but some are
>> specific to the interface and defined in the driver.
>
> But we will use some kind of virtual/stub driver, right? We don't have
> real hardware. So all these commands should be fixed and known for the
> virtual/stub driver.
>
>> There are many facets to a connection in RDMA: a protection domain used
>> to register memory with the nic, a queue pair that is the actual tx/rx
>> connection, optionally a completion channel that will be another fd to
>> listen on for events that tell you something happened and finally some
>> memory regions to directly communicate with the nic from userspace
>> depending on the specific driver.
>>  * then there's the actual usage, more commands through the uverbs0 char
>> device to register the memory you'll use, and once that's done it's
>> entierly up to the driver - for example the mellanox lib can do
>> everything in userspace playing with the memory regions it registered,
>> but I'd wager the rxe driver does more calls through the uverbs0 fd...
>>
>> Honestly I'm not keen on reimplementing all of this; the interface
>> itself pretty much depends on your version of the kernel (there is a
>> common ABI defined, but as far as specific nics are concerned if your
>> kernel module doesn't match the user library version you can get some
>> nasty surprises), and it's far from the black or white of a good ol'
>> ENOSUPP error.
>>
>>
>> I'll look if I can figure out if there is a common subset of verbs
>> commands that are standard and sufficient to setup a listening
>> connection and exchange data that should be supported for all devices
>> and would let us reimplement just that, but while I hear your point
>> about android and ten years in the future I think it's more likely than
>> ten years in the future the verb abi will have changed but libibverbs
>> will just have the new version implemented and hide the change :P
>
> But again we don't need to support all of the available hardware.
> For example, we are testing net stack from external side using tun.
> tun is a very simple, virtual abstraction of a network card. It allows
> us to test all of generic net stack starting from L2 without messing
> with any real drivers and their differences entirely. I had impression
> that we are talking about something similar here too. Or not?
>
> Also I am a bit missing context about rdma<->9p interface. Do we need
> to setup all these ring buffers to satisfy the parts that 9p needs? Is
> it that 9p actually reads data directly from these ring buffers? Or
> there is some higher-level rdma interface that 9p uses?
