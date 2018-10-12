Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB41C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3507D2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwIDdQxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3507D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeJLWPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:15:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38280 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeJLWPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:15:09 -0400
Received: by mail-io1-f65.google.com with SMTP id n5-v6so9382766ioh.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WjgFyqyRa78f+1i5JkGQPsMS31A9+K6HH+fpTDCIC6Q=;
        b=kwIDdQxg8AVBSU326jP4keInmQpRhsxE8JZGrjH20BRUGG8apUXqnFIU9RZkSmuXxf
         AfqusWMsc6ZB0+lUrbQGbVilhuzzoNlvwuslYamrznTRLT6QTUe+lK5o76+A7qZ2uFUK
         jKY8T0W1Dvp/rKCUPdbmoPocXGVVWJIP2swrwfnnL3EtF/nd5OXhflAFQ1CPRKiusEKT
         APOXJ3RS87qgzgp5vB8AYnb5wOiW99JxkHMSACgnxA4kMRoYxodHVnQP4xV9D+/Ay50Z
         ZHeeHjHEKitQs7R+cv5hxKv+6AEcRfE7KRGhrKD10IMTYIL7cAnQYXK1zXNV9fRDWYnv
         MLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WjgFyqyRa78f+1i5JkGQPsMS31A9+K6HH+fpTDCIC6Q=;
        b=C9gowsRJSmlGyPZNGsttUy9eZG6KI0brg4HRuXEHFl5jmm8S89hawHMNvFtF/7WPfd
         3SYEwLVmI3MVwb3L7Tpy3yjZ98iavmFvzIHYeP6F0dMBb9+ZJSpb7X/GXJEPm5uJWNOg
         /TtHay2emwpPd7PIGkoXcARjxATtwQotQLjBXOAe6mlVLM2Rf5q25FemhtELEah2AC/R
         /ryQ2kctU7j5CtNTIn7PN3erHQ3YSerLsvCIreiwlovF2jGBTEkxA4yX9rDSEbdG7Mje
         Hiu2D0Guy7JqMiuMP2c12t4D1xifuNQYjCRWe4tHvL06aawT/LD/RWf27IqoCqalRE6m
         w5bQ==
X-Gm-Message-State: ABuFfohjAJdQAYfcm76Xi62GhpexFawSAlhGpF7RtlxUQZTlcJAi450E
        b7wo/2wW7zX75dTb9LmXs7FZAPSCShxrfcEkfESr2+oV
X-Google-Smtp-Source: ACcGV61xx7uePlh/dx0A2n40URfF7jAbUTh8j/1Svcq8JHF4EH8VerEW11j+w7emn9+mpmj7Y/6liYJshjJZp/p9Rgc=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr4082445iog.271.1539355342427;
 Fri, 12 Oct 2018 07:42:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 07:42:01
 -0700 (PDT)
In-Reply-To: <20181011142808.GC32030@nautica>
References: <000000000000fddb150577c15af6@google.com> <20181009020949.GA29622@nautica>
 <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica> <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica> <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
 <20181011131045.GA32030@nautica> <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
 <CACT4Y+bM4DxysCzhWvhURgBVpnLR4uu+oxhLpdZ3x92cKwtAzA@mail.gmail.com> <20181011142808.GC32030@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Oct 2018 16:42:01 +0200
Message-ID: <CACT4Y+amrywC10vUSN7DQi0O_cx1Y6WysyktPUNMP_u8RMJoHA@mail.gmail.com>
Subject: Re: 9p/RDMA for syzkaller (Was: BUG: corrupted list in p9_read_work)
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

On Thu, Oct 11, 2018 at 4:28 PM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Dmitry Vyukov wrote on Thu, Oct 11, 2018:
>> > Now we are talking!
>> > We generally assume that all modules are simply compiled into kernel.
>> > At least that's we have on syzbot. If somebody can't compile them in,
>> > we can suggest to add modprobe into init.
>> > So this boils down to just writing to /sys/module/rdma_rxe/parameters/add.
>>
>> This fails for me:
>>
>> root@syzkaller:~# echo -n syz1 > /sys/module/rdma_rxe/parameters/add
>> [20992.905406] rdma_rxe: interface syz1 not found
>> bash: echo: write error: Invalid argument
>
> Works here, I just did:
>
> [root@f2 ~]# modprobe rdma_rxe
> [root@f2 ~]# echo -n ens3 > /sys/module/rdma_rxe/parameters/add
>
> dmesg says:
> [   35.595534] rdma_rxe: set rxe0 active
> [   35.595541] rdma_rxe: added rxe0 to ens3
>
>
> Actually for a dummy interface if I try the echo directly the echo
> works, and a verb device is created, and I just confirmed I can use
> it... so not sure why rxe_cfg said EINVAL earlier...
>
> [root@f2 ~]# ip link add dummy0 type dummy
> [root@f2 ~]# ip link set dummy0 up
> [root@f2 ~]# ip addr add 10.1.1.1/24 dev dummy0
> [root@f2 ~]# modprobe rdma_rxe
> [root@f2 ~]# echo -n dummy0 > /sys/module/rdma_rxe/parameters/add
>
>
> (then using my test client:
> [root@f2 src]# ./rcat -s
> INFO:  trans_rdma.c (879), msk_cma_event_handler: CONNECT_REQUEST
> INFO:  trans_rdma.c (862), msk_cma_event_handler: ESTABLISHED
> INFO:  trans_rdma.c (917), msk_cma_event_handler: DISCONNECT EVENT...
>
> [root@f2 src]# ./rcat -c 10.1.1.1
> INFO:  trans_rdma.c (862), msk_cma_event_handler: ESTABLISHED
> ^C
> )
>
>
> I assume your syz1 interface is a tap device as you were saying earlier?
> Got anything in dmesg?

Umm... nope, just a random string.
Don't assume any prior knowledge on my side :)
